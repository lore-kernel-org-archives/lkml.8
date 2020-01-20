Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FE8C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 667DE20674
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 10:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="haEXmCvz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgATKtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 05:49:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36050 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726417AbgATKtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 05:49:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579517360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0q05aO2t3PBog9ubsEIDXd1tWolYY1LjvAiX9CcNfMA=;
        b=haEXmCvz+nzNpW/vUXTNm+c3Bsnm5/nwYKUFqOfLytq2CW7Ck8MjZMEQfddykiC7uVCxv7
        Dzgc3Rq82SQ4aBOlpg3BW+y4EbtyflJhUB+bf5fabxsNVZpZL/AJjpn1w3Di5Kj8V9R8ee
        6xfFgxg0RtrcXEqkALQSQxWFdiCLaIQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-DZf4N8ZEOouSDhZ83kUaPw-1; Mon, 20 Jan 2020 05:49:16 -0500
X-MC-Unique: DZf4N8ZEOouSDhZ83kUaPw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45EB4DB60;
        Mon, 20 Jan 2020 10:49:15 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.36.118.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C0BF610013A7;
        Mon, 20 Jan 2020 10:49:10 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Saravana Kannan <saravanak@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@kernel.org>
Subject: [PATCH v1] driver core: check for dead devices before onlining/offlining
Date:   Mon, 20 Jan 2020 11:49:09 +0100
Message-Id: <20200120104909.13991-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can have rare cases where the removal of a device races with
somebody trying to online it (esp. via sysfs). We can simply check
if the device is already removed or getting removed under the dev->lock.

E.g., right now, if memory block devices are removed (remove_memory()),
we do a:

remove_memory() -> lock_device_hotplug() -> mem_hotplug_begin() ->
lock_device() -> dev->dead =3D true

Somebody coming via sysfs (/sys/devices/system/memory/memoryX/online)
triggers a:

lock_device_hotplug_sysfs() -> device_online() -> lock_device() ...

So if we made it just before the lock_device_hotplug_sysfs() but get
delayed until remove_memory() released all locks, we will continue
taking locks and trying to online the device - which is then a zombie
device.

Note that at least the memory onlining path seems to be protected by
checking if all memory sections are still present (something we can then
get rid of). We do have other sysfs attributes
(e.g., /sys/devices/system/memory/memoryX/valid_zones) that don't do any
such locking yet and might race with memory removal in a similar way. For
these users, we can then do a

device_lock(dev);
if (!device_is_dead(dev)) {
	/* magic /*
}
device_unlock(dev);

Introduce and use device_is_dead() right away.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

Am I missing any obvious mechanism in the device core that handles
something like this already? (especially also for other sysfs attributes?=
)

---
 drivers/base/core.c    | 13 +++++++++++--
 drivers/base/dd.c      |  6 +++---
 include/linux/device.h |  1 +
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 42a672456432..01cd06eeb513 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2952,7 +2952,9 @@ int device_offline(struct device *dev)
 		return ret;
=20
 	device_lock(dev);
-	if (device_supports_offline(dev)) {
+	if (device_is_dead(dev))
+		ret =3D -ENXIO;
+	else if (device_supports_offline(dev)) {
 		if (dev->offline) {
 			ret =3D 1;
 		} else {
@@ -2983,7 +2985,9 @@ int device_online(struct device *dev)
 	int ret =3D 0;
=20
 	device_lock(dev);
-	if (device_supports_offline(dev)) {
+	if (device_is_dead(dev))
+		ret =3D -ENXIO;
+	else if (device_supports_offline(dev)) {
 		if (dev->offline) {
 			ret =3D dev->bus->online(dev);
 			if (!ret) {
@@ -2999,6 +3003,11 @@ int device_online(struct device *dev)
 	return ret;
 }
=20
+bool device_is_dead(struct device *dev)
+{
+	return dev->p->dead;
+}
+
 struct root_device {
 	struct device dev;
 	struct module *owner;
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index b25bcab2a26b..b1d7361720af 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -848,7 +848,7 @@ static void __device_attach_async_helper(void *_dev, =
async_cookie_t cookie)
 	 * and deferred probe processing happens all at once with
 	 * multiple threads.
 	 */
-	if (dev->p->dead || dev->driver)
+	if (device_is_dead(dev) || dev->driver)
 		goto out_unlock;
=20
 	if (dev->parent)
@@ -994,7 +994,7 @@ int device_driver_attach(struct device_driver *drv, s=
truct device *dev)
 	 * If device has been removed or someone has already successfully
 	 * bound a driver before us just skip the driver probe call.
 	 */
-	if (!dev->p->dead && !dev->driver)
+	if (!device_is_dead(dev) && !dev->driver)
 		ret =3D driver_probe_device(drv, dev);
=20
 	__device_driver_unlock(dev, dev->parent);
@@ -1016,7 +1016,7 @@ static void __driver_attach_async_helper(void *_dev=
, async_cookie_t cookie)
 	 * If device has been removed or someone has already successfully
 	 * bound a driver before us just skip the driver probe call.
 	 */
-	if (!dev->p->dead && !dev->driver)
+	if (!device_is_dead(dev) && !dev->driver)
 		ret =3D driver_probe_device(drv, dev);
=20
 	__device_driver_unlock(dev, dev->parent);
diff --git a/include/linux/device.h b/include/linux/device.h
index ce6db68c3f29..acea6a14daa1 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -832,6 +832,7 @@ extern void unlock_device_hotplug(void);
 extern int lock_device_hotplug_sysfs(void);
 extern int device_offline(struct device *dev);
 extern int device_online(struct device *dev);
+extern bool device_is_dead(struct device *dev);
 extern void set_primary_fwnode(struct device *dev, struct fwnode_handle =
*fwnode);
 extern void set_secondary_fwnode(struct device *dev, struct fwnode_handl=
e *fwnode);
 void device_set_of_node_from_dev(struct device *dev, const struct device=
 *dev2);
--=20
2.24.1


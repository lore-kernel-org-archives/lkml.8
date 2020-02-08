Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D55DAC35242
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 18:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAED20661
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 18:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgBHScg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 13:32:36 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34616 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727941AbgBHS3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 13:29:48 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1j0UrO-0003jV-Mb; Sat, 08 Feb 2020 18:29:42 +0000
Received: from ben by deadeye with local (Exim 4.93)
        (envelope-from <ben@decadent.org.uk>)
        id 1j0UrM-000CVx-4D; Sat, 08 Feb 2020 18:29:40 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Konstantin Khlebnikov" <koct9i@gmail.com>
Date:   Sat, 08 Feb 2020 18:21:06 +0000
Message-ID: <lsq.1581185941.610088829@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 127/148] ACPI / osl: speedup grace period in
 acpi_os_map_cleanup
In-Reply-To: <lsq.1581185939.857586636@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.82-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Konstantin Khlebnikov <koct9i@gmail.com>

commit 74b51ee152b6d99e61ba329799a039453fb9438f upstream.

ACPI maintains cache of ioremap regions to speed up operations and
access to them from irq context where ioremap() calls aren't allowed.
This code abuses synchronize_rcu() on unmap path for synchronization
with fast-path in acpi_os_read/write_memory which uses this cache.

Since v3.10 CPUs are allowed to enter idle state even if they have RCU
callbacks queued, see commit c0f4dfd4f90f1667d234d21f15153ea09a2eaa66
("rcu: Make RCU_FAST_NO_HZ take advantage of numbered callbacks").
That change caused problems with nvidia proprietary driver which calls
acpi_os_map/unmap_generic_address several times during initialization.
Each unmap calls synchronize_rcu and adds significant delay. Totally
initialization is slowed for a couple of seconds and that is enough to
trigger timeout in hardware, gpu decides to "fell off the bus". Widely
spread workaround is reducing "rcu_idle_gp_delay" from 4 to 1 jiffy.

This patch replaces synchronize_rcu() with synchronize_rcu_expedited()
which is much faster.

Link: https://devtalk.nvidia.com/default/topic/567297/linux/linux-3-10-driver-crash/
Signed-off-by: Konstantin Khlebnikov <koct9i@gmail.com>
Reported-and-tested-by: Alexander Monakov <amonakov@gmail.com>
Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/acpi/osl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -425,7 +425,7 @@ static void acpi_os_drop_map_ref(struct
 static void acpi_os_map_cleanup(struct acpi_ioremap *map)
 {
 	if (!map->refcount) {
-		synchronize_rcu();
+		synchronize_rcu_expedited();
 		acpi_unmap(map->phys, map->virt);
 		kfree(map);
 	}


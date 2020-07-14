Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B62C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E1DD217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 08:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wk1qKCoU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgGNIPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 04:15:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26787 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725793AbgGNIPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 04:15:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594714536;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=f8+KnFgAxKm6sgEPySfwahianaqUhM5wZ//swhq+ahg=;
        b=Wk1qKCoUxy87U9AV8C5M8fFjPlUvXv9mRqT5gt7yK4mJvN5qKfX4nlOAMQMhY0ESsmoIvu
        zjPB8GRYrmT8IjtFkMENqSMkfe1iRfIS+qt57lcITaNpOYXzV28KXiZgYMzaGY88DqbGvp
        Vk87pER74xD/P+9hlABHOc0tPv6Z0M4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-mhrCMM7eMZ2cOLwZQQt1HQ-1; Tue, 14 Jul 2020 04:15:32 -0400
X-MC-Unique: mhrCMM7eMZ2cOLwZQQt1HQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 545B91800D42;
        Tue, 14 Jul 2020 08:15:30 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-109.ams2.redhat.com [10.36.114.109])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B7C5760CD0;
        Tue, 14 Jul 2020 08:15:28 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5.8 regression fix] platform/x86: thinkpad_acpi: Revert: Use strndup_user() in dispatch_proc_write()
Date:   Tue, 14 Jul 2020 10:15:10 +0200
Message-Id: <20200714081510.6070-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 35d13c7a0512 ("platform/x86: thinkpad_acpi: Use strndup_user()
in dispatch_proc_write()") cleaned up dispatch_proc_write() by replacing
the code to copy the passed in data from userspae with strndup_user().

But strndup_user() expects a 0 terminated input buffer and the buffer
passed to dispatch_proc_write() is NOT 0 terminated.

So this change leads to strndup_user() copying some extra random bytes
from userspace till it hits a 0 byte.

This commit reverts the change to use strndup_user() fixing the
buffer being passed to the ibm_struct.write() call back containing extra
junk at the end.

Fixes: 35d13c7a0512 ("platform/x86: thinkpad_acpi: Use strndup_user() in dispatch_proc_write()")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 92aad746d1f8..8ae2be5871f5 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -886,11 +886,19 @@ static ssize_t dispatch_proc_write(struct file *file,
 
 	if (!ibm || !ibm->write)
 		return -EINVAL;
+	if (count > PAGE_SIZE - 1)
+		return -EINVAL;
+
+	kernbuf = kmalloc(count + 1, GFP_KERNEL);
+	if (!kernbuf)
+		return -ENOMEM;
 
-	kernbuf = strndup_user(userbuf, PAGE_SIZE);
-	if (IS_ERR(kernbuf))
-		return PTR_ERR(kernbuf);
+	if (copy_from_user(kernbuf, userbuf, count)) {
+		kfree(kernbuf);
+		return -EFAULT;
+	}
 
+	kernbuf[count] = 0;
 	ret = ibm->write(kernbuf);
 	if (ret == 0)
 		ret = count;
-- 
2.26.2


Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C030C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 02:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 208A52468D
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 02:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZsG70DDg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgCBCDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 21:03:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52143 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726673AbgCBCDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 21:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583114633;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=f1TfCk6bfq19Mjge8sjJEjXyYMp3pKACoxP43Q8soZY=;
        b=ZsG70DDgvpn8yDp8vyeIy8uirtOswSVQccKzqy9BSSlNAI9gX3Oah1zCR5hOzugFGeOr5b
        p9ZzfNOndjz7nj1vVcFh2uX8CvFslxgx7HSaiNdobWaMD/nbr1fZxCHH6r8QNO/H9zJg3j
        ms4lwVJq5nwy28HeWiA2R7Z9t9+v6f8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-uPrHOxDBNFmHLY-ih7OGxg-1; Sun, 01 Mar 2020 21:03:50 -0500
X-MC-Unique: uPrHOxDBNFmHLY-ih7OGxg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D87BE800D4E;
        Mon,  2 Mar 2020 02:03:48 +0000 (UTC)
Received: from localhost.localdomain.com (vpn2-54-69.bne.redhat.com [10.64.54.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1FE9790F5B;
        Mon,  2 Mar 2020 02:03:44 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        mark.rutland@arm.com, shan.gavin@gmail.com
Subject: [PATCH] arm64/kernel: Simplify __cpu_up() by bailing out early
Date:   Mon,  2 Mar 2020 13:03:40 +1100
Message-Id: <20200302020340.119588-1-gshan@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function __cpu_up() is invoked to bring up the target CPU through
the backend, PSCI for example. The nested if statements won't be needed
if we bail out early on the following two conditions where the status
won't be checked. The code looks simplified in that case.

   * Error returned from the backend (e.g. PSCI)
   * The target CPU has been marked as onlined

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/kernel/smp.c | 79 +++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 42 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index d4ed9a19d8fe..2a9d8f39dc58 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -115,60 +115,55 @@ int __cpu_up(unsigned int cpu, struct task_struct *=
idle)
 	update_cpu_boot_status(CPU_MMU_OFF);
 	__flush_dcache_area(&secondary_data, sizeof(secondary_data));
=20
-	/*
-	 * Now bring the CPU into our world.
-	 */
+	/* Now bring the CPU into our world */
 	ret =3D boot_secondary(cpu, idle);
-	if (ret =3D=3D 0) {
-		/*
-		 * CPU was successfully started, wait for it to come online or
-		 * time out.
-		 */
-		wait_for_completion_timeout(&cpu_running,
-					    msecs_to_jiffies(5000));
-
-		if (!cpu_online(cpu)) {
-			pr_crit("CPU%u: failed to come online\n", cpu);
-			ret =3D -EIO;
-		}
-	} else {
+	if (ret) {
 		pr_err("CPU%u: failed to boot: %d\n", cpu, ret);
 		return ret;
 	}
=20
+	/*
+	 * CPU was successfully started, wait for it to come online or
+	 * time out.
+	 */
+	wait_for_completion_timeout(&cpu_running,
+				    msecs_to_jiffies(5000));
+	if (cpu_online(cpu))
+		return 0;
+
+	pr_crit("CPU%u: failed to come online\n", cpu);
 	secondary_data.task =3D NULL;
 	secondary_data.stack =3D NULL;
 	__flush_dcache_area(&secondary_data, sizeof(secondary_data));
 	status =3D READ_ONCE(secondary_data.status);
-	if (ret && status) {
-
-		if (status =3D=3D CPU_MMU_OFF)
-			status =3D READ_ONCE(__early_cpu_boot_status);
+	if (status =3D=3D CPU_MMU_OFF)
+		status =3D READ_ONCE(__early_cpu_boot_status);
=20
-		switch (status & CPU_BOOT_STATUS_MASK) {
-		default:
-			pr_err("CPU%u: failed in unknown state : 0x%lx\n",
-					cpu, status);
-			cpus_stuck_in_kernel++;
-			break;
-		case CPU_KILL_ME:
-			if (!op_cpu_kill(cpu)) {
-				pr_crit("CPU%u: died during early boot\n", cpu);
-				break;
-			}
-			pr_crit("CPU%u: may not have shut down cleanly\n", cpu);
-			/* Fall through */
-		case CPU_STUCK_IN_KERNEL:
-			pr_crit("CPU%u: is stuck in kernel\n", cpu);
-			if (status & CPU_STUCK_REASON_52_BIT_VA)
-				pr_crit("CPU%u: does not support 52-bit VAs\n", cpu);
-			if (status & CPU_STUCK_REASON_NO_GRAN)
-				pr_crit("CPU%u: does not support %luK granule \n", cpu, PAGE_SIZE / =
SZ_1K);
-			cpus_stuck_in_kernel++;
+	switch (status & CPU_BOOT_STATUS_MASK) {
+	default:
+		pr_err("CPU%u: failed in unknown state : 0x%lx\n",
+		       cpu, status);
+		cpus_stuck_in_kernel++;
+		break;
+	case CPU_KILL_ME:
+		if (!op_cpu_kill(cpu)) {
+			pr_crit("CPU%u: died during early boot\n", cpu);
 			break;
-		case CPU_PANIC_KERNEL:
-			panic("CPU%u detected unsupported configuration\n", cpu);
 		}
+		pr_crit("CPU%u: may not have shut down cleanly\n", cpu);
+		/* Fall through */
+	case CPU_STUCK_IN_KERNEL:
+		pr_crit("CPU%u: is stuck in kernel\n", cpu);
+		if (status & CPU_STUCK_REASON_52_BIT_VA)
+			pr_crit("CPU%u: does not support 52-bit VAs\n", cpu);
+		if (status & CPU_STUCK_REASON_NO_GRAN) {
+			pr_crit("CPU%u: does not support %luK granule\n",
+				cpu, PAGE_SIZE / SZ_1K);
+		}
+		cpus_stuck_in_kernel++;
+		break;
+	case CPU_PANIC_KERNEL:
+		panic("CPU%u detected unsupported configuration\n", cpu);
 	}
=20
 	return ret;
--=20
2.23.0


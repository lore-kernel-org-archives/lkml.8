Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E482C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62A0C2063A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 12:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590667869;
	bh=6zwGUGo6IJLz1UzgMnCPHNAuZNi38tSvN2PQ+FnbxdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=grVhAHG9KNhpFVKiKyNFIkrLys4K6zttA2VUXqRLrP7ZwDGAIs3C7/HTQ5bRz3661
	 5w9wMgaJ5HysYltUUOo2DeTd8SI0Rc8i9DcA5xmQdeIz/kF9BU4EOveugCxsIQRz3Z
	 zTqIvyzAaCdCkEolXZktR9uWXVal6YxAFDcVTlSg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389722AbgE1MLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 08:11:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388638AbgE1L4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:56:10 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B30E214F1;
        Thu, 28 May 2020 11:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590666969;
        bh=6zwGUGo6IJLz1UzgMnCPHNAuZNi38tSvN2PQ+FnbxdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y2frSrjJxoVOwOsazURwQF49ibb5rKmNZthPIEXge8WaIMxnXcp4L0uwO3MZF8SJJ
         O/1YsMjAF1eanemfg96Hr3SXT2ZdY1YkLNk+GQbBefjYw4zCILEOCjGv+mBeou9K+K
         cR7z/d1SNhGn+1wMAVDcxDWQ9gm9HR710zs9hpJE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dexuan Cui <decui@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.6 07/47] x86/hyperv: Properly suspend/resume reenlightenment notifications
Date:   Thu, 28 May 2020 07:55:20 -0400
Message-Id: <20200528115600.1405808-7-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528115600.1405808-1-sashal@kernel.org>
References: <20200528115600.1405808-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>

[ Upstream commit 38dce4195f0daefb566279fd9fd51e1fbd62ae1b ]

Errors during hibernation with reenlightenment notifications enabled were
reported:

 [   51.730435] PM: hibernation entry
 [   51.737435] PM: Syncing filesystems ...
 ...
 [   54.102216] Disabling non-boot CPUs ...
 [   54.106633] smpboot: CPU 1 is now offline
 [   54.110006] unchecked MSR access error: WRMSR to 0x40000106 (tried to
     write 0x47c72780000100ee) at rIP: 0xffffffff90062f24
     native_write_msr+0x4/0x20)
 [   54.110006] Call Trace:
 [   54.110006]  hv_cpu_die+0xd9/0xf0
 ...

Normally, hv_cpu_die() just reassigns reenlightenment notifications to some
other CPU when the CPU receiving them goes offline. Upon hibernation, there
is no other CPU which is still online so cpumask_any_but(cpu_online_mask)
returns >= nr_cpu_ids and using it as hv_vp_index index is incorrect.
Disable the feature when cpumask_any_but() fails.

Also, as we now disable reenlightenment notifications upon hibernation we
need to restore them on resume. Check if hv_reenlightenment_cb was
previously set and restore from hv_resume().

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
Link: https://lore.kernel.org/r/20200512160153.134467-1-vkuznets@redhat.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/hyperv/hv_init.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index fd51bac11b46..acf76b466db6 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -226,10 +226,18 @@ static int hv_cpu_die(unsigned int cpu)
 
 	rdmsrl(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *((u64 *)&re_ctrl));
 	if (re_ctrl.target_vp == hv_vp_index[cpu]) {
-		/* Reassign to some other online CPU */
+		/*
+		 * Reassign reenlightenment notifications to some other online
+		 * CPU or just disable the feature if there are no online CPUs
+		 * left (happens on hibernation).
+		 */
 		new_cpu = cpumask_any_but(cpu_online_mask, cpu);
 
-		re_ctrl.target_vp = hv_vp_index[new_cpu];
+		if (new_cpu < nr_cpu_ids)
+			re_ctrl.target_vp = hv_vp_index[new_cpu];
+		else
+			re_ctrl.enabled = 0;
+
 		wrmsrl(HV_X64_MSR_REENLIGHTENMENT_CONTROL, *((u64 *)&re_ctrl));
 	}
 
@@ -293,6 +301,13 @@ static void hv_resume(void)
 
 	hv_hypercall_pg = hv_hypercall_pg_saved;
 	hv_hypercall_pg_saved = NULL;
+
+	/*
+	 * Reenlightenment notifications are disabled by hv_cpu_die(0),
+	 * reenable them here if hv_reenlightenment_cb was previously set.
+	 */
+	if (hv_reenlightenment_cb)
+		set_hv_tscchange_cb(hv_reenlightenment_cb);
 }
 
 /* Note: when the ops are called, only CPU0 is online and IRQs are disabled. */
-- 
2.25.1


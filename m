Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647B3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 02:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40D43208A9
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 02:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="VmIDRVFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbgGaClK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 22:41:10 -0400
Received: from sonic309-22.consmr.mail.gq1.yahoo.com ([98.137.65.148]:41509
        "EHLO sonic309-22.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730820AbgGaClK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 22:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1596163269; bh=DD91Y+8hLQEWUJa1HsJ2lWsRkBMbpRbQsE0hFQtmbLc=; h=From:To:Cc:Subject:Date:References:From:Subject; b=VmIDRVFyBlAXv4h/wj0to2Y5NvQsQCC1NkpWNImyjBSxIScGyqit8kStor21AWhNMhZXiU0mmtnb7Z4DVpykNmFyVT0jRunbUjJeavCZa5Dzy+y/nuyzJzzKivNWIVCbUq4Nr/xO6Wd22pIWU1BcsWXfl1qE1Mp/suemCVfbYHKIPKb8EPHPG+7Meb87P01AJsb+KE/iqwPoDQmv0zJhALDqbW8cRxppSc41cBFWv2eVMmOs8lDwi3cfKCnGvsaCuLpXtLathSCjmtQpqXOhYkLmqBl5FPRKjAV5UcqZsva8CYukjDIeSaOERpMOIzVt3ee6KQ9Fz5yQ2Tpv/95lhw==
X-YMail-OSG: 0MYneP0VM1kbyZvS9MjCj3h4zIa7Ff1gyM4zgfqAjRrzKcm0.t4ltJ4tOu4QHAD
 v5c6w7ykcLqfjrjCGnuS49oBw6O0oY3wfCyj8RGh2hAdyfOe1eH9BweR7e0uGAksjS2FTPEvzgWX
 zgvtGEW45kl2ZvqQjf3v_bDa20mxNXLeUCYo5EwwRuWfau9XrrxVRakZUTHbyFLTph1MdZGdMCK6
 IxTtmOBvghl0.WgIJFexVpzuaWCpEL_oPc3.aRIHx7MGMOWtfAcEx19zaNG9fFKObciFSYpli4dz
 CQZzgfz3ROrfj8vldt14hG29AMq7YPOWWj7msB9KkuJ1fBi687Z9Un3rzIQ4CL1Piyibvn9iTHt.
 R1jqlgZcOWqHBFBCDxmrlp6N.rjbSH1BWhNM2FlbkbLpoApbkcBXOrwed6AELeuoYEIkF.DvprXG
 l_qTxcR6WnkLM2FquOr.UhyJtVNAjAoNiwvM53dSDzqmKEuXxC4FR1BKnExquf5J5z1J1xf9zLsp
 Ii_uFrZ8F3aQ4ht4wYelC2rNX8y8DSreiOFbXkhpB6tekh.6sjHpy7XQ0Q2HyLt3jca.Hg7BbyS1
 KOGUZewQ3w_v_GntTirMu3a75LSDy.cu_aQhBYyQ85WbqB3FuJyySj4n_q2rKfxHst2IEDCcLfQe
 nmeNNGErZNJ32K1MFeEePF8zgxvbmaXYKWgYmPrC.U4TfAJkvZd2pDbQabA9OVAplK6xqAGB4UvL
 JyBGCVVGUsLtS399tUD_buICu7955NHTU5iAfeDNA4p5ejmC.WaG2.0Upb6x1MILqmaYmLDd.VwX
 Hxac0mtGfdwYFswohqxMzMCMuLBdoIqkxj0o5rrhXuPeA1JnhTsW8zlzBdwih3E7M8oDCrZWSv12
 oY7uS7qPvhUo_1d7Z4GVb1mAPA3QBdvXAzKMIlDIT.DHwFB93xed8Lg1g.NpRmuyA1jYnLYR.gxP
 UNUGtfA9SNacVR0Be.H_IS6bTTqC5T3a7WtpqkuCPLQwio0CBINnB_WUmySv1.rWEkFHkHShS6Ng
 on4nlefh2b06tPoWuPVi6T8KzUCA9G0pYNuvh0KSzuFlHdlBPzpGr.cqnhp.HiL3PI4AksYKQBKq
 Opb.2c8FgrjxHM45oK3MLHb17LGEjaGUuVDLg8XXCWAzuKx3JyakLXwlTpSCEMWBwpbKyQEQVpTR
 j9Z4.iFaRBtlWj6bjl0tGlvoWsfEj8hEDsUZzdT9PKw6nivX46VCY4s2EA2fd_theyLBpPo3Rsn3
 yONYNBWRujEa8CwRisiA_EpYfZT5vpb2B1naxPbHNCNjIwRqHze2TJ6Iqe.MFc_fbEfbrOUHqtN.
 0gYG81w0ddmvrlUxEB4_RROAiHd_JoxE15QvDR.Owhzwx1pVsERPm9BjtuqKq5g9zdVgr
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 Jul 2020 02:41:09 +0000
Received: by smtp432.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID b10174ed125d8e8034f121a89cf92327;
          Fri, 31 Jul 2020 02:41:04 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@redhat.com>,
        Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
Subject: [PATCH] erofs: remove WQ_CPU_INTENSIVE flag from unbound wq's
Date:   Fri, 31 Jul 2020 10:40:49 +0800
Message-Id: <20200731024049.16495-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20200731024049.16495-1-hsiangkao.ref@aol.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <hsiangkao@redhat.com>

The documentation [1] says that WQ_CPU_INTENSIVE is "meaningless" for
unbound wq. I remove this flag from places where unbound queue is
allocated. This is supposed to improve code readability.

[1] https://www.kernel.org/doc/html/latest/core-api/workqueue.html#flags
Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
[Gao Xiang: since the original treewide patch [2] hasn't been merged
            yet, handling the EROFS part only for the next cycle. ]
[2] https://lore.kernel.org/r/20200213141823.2174236-1-mplaneta@os.inf.tu-dresden.de
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/zdata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 80bf09c4de09..9ac2723c11bf 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -43,13 +43,13 @@ void z_erofs_exit_zip_subsystem(void)
 static inline int z_erofs_init_workqueue(void)
 {
 	const unsigned int onlinecpus = num_possible_cpus();
-	const unsigned int flags = WQ_UNBOUND | WQ_HIGHPRI | WQ_CPU_INTENSIVE;
 
 	/*
 	 * no need to spawn too many threads, limiting threads could minimum
 	 * scheduling overhead, perhaps per-CPU threads should be better?
 	 */
-	z_erofs_workqueue = alloc_workqueue("erofs_unzipd", flags,
+	z_erofs_workqueue = alloc_workqueue("erofs_unzipd",
+					    WQ_UNBOUND | WQ_HIGHPRI,
 					    onlinecpus + onlinecpus / 4);
 	return z_erofs_workqueue ? 0 : -ENOMEM;
 }
-- 
2.24.0


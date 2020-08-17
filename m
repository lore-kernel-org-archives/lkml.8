Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE79EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FED720578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690222;
	bh=Y5Peo0FyvYcqmpLjG3BPytrck9wreRRxTDg3f8cOFTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CS/6lHEeIypsUfJsZ0vVOV2ToR5858IIQRQOu+T5YkcYHw+yG7jWS46VZb8r6P9Jt
	 O7uzTxR0hbUe/eih2yTt3BbXGBBtev7lIGFbvCuIpDCeXAOW8HyWJ9pSEDykuNR5xM
	 /GxsxorOoGxL5L6c7fRcbA4e9KoQQ00KIfcJZVWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403904AbgHQSuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:40880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387945AbgHQPxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:53:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 481AB2063A;
        Mon, 17 Aug 2020 15:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679628;
        bh=Y5Peo0FyvYcqmpLjG3BPytrck9wreRRxTDg3f8cOFTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xEaJQPieo2y9NqQGamkb5Zs3MR9Y+LmWjBr3DPy3mEXHogZRyaIE3p4haQV5vUa24
         n6W7J4LJH4ya/qjhulX3bjuEBjP1PoVrUsy0B3Xu+QtucH+hwbu++ZqPflDibdKMSs
         p775qeNCxr0hzXP1NHtCGxqYjTqyaxLbXl34GqGg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerry Crunchtime <jerry.c.t@web.de>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 279/393] libbpf: Fix register in PT_REGS MIPS macros
Date:   Mon, 17 Aug 2020 17:15:29 +0200
Message-Id: <20200817143833.153013152@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerry Crunchtime <jerry.c.t@web.de>

[ Upstream commit 1acf8f90ea7ee59006d0474275922145ac291331 ]

The o32, n32 and n64 calling conventions require the return
value to be stored in $v0 which maps to $2 register, i.e.,
the register 2.

Fixes: c1932cd ("bpf: Add MIPS support to samples/bpf.")
Signed-off-by: Jerry Crunchtime <jerry.c.t@web.de>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Link: https://lore.kernel.org/bpf/43707d31-0210-e8f0-9226-1af140907641@web.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/bpf_tracing.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 48a9c7c69ef1f..e6ec7cb4aa4aa 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -215,7 +215,7 @@ struct pt_regs;
 #define PT_REGS_PARM5(x) ((x)->regs[8])
 #define PT_REGS_RET(x) ((x)->regs[31])
 #define PT_REGS_FP(x) ((x)->regs[30]) /* Works only with CONFIG_FRAME_POINTER */
-#define PT_REGS_RC(x) ((x)->regs[1])
+#define PT_REGS_RC(x) ((x)->regs[2])
 #define PT_REGS_SP(x) ((x)->regs[29])
 #define PT_REGS_IP(x) ((x)->cp0_epc)
 
@@ -226,7 +226,7 @@ struct pt_regs;
 #define PT_REGS_PARM5_CORE(x) BPF_CORE_READ((x), regs[8])
 #define PT_REGS_RET_CORE(x) BPF_CORE_READ((x), regs[31])
 #define PT_REGS_FP_CORE(x) BPF_CORE_READ((x), regs[30])
-#define PT_REGS_RC_CORE(x) BPF_CORE_READ((x), regs[1])
+#define PT_REGS_RC_CORE(x) BPF_CORE_READ((x), regs[2])
 #define PT_REGS_SP_CORE(x) BPF_CORE_READ((x), regs[29])
 #define PT_REGS_IP_CORE(x) BPF_CORE_READ((x), cp0_epc)
 
-- 
2.25.1




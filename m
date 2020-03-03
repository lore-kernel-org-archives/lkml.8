Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63221C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C3D20838
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VYjDCqBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgCCOKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:10:20 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44854 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729582AbgCCOKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:10:07 -0500
Received: by mail-wr1-f65.google.com with SMTP id n7so4450350wrt.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 06:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mGFNfxmSybPpi8Hxmqj4rozq0S6s0SBGDpgeol/ec0I=;
        b=VYjDCqBAbxSTav8zxv1sG9jECNZkU1Dym5p9TwusiD/iRF1iUnhNinGL/PoZGdrGDI
         5gk4yUPNEvlwA4ckubT6gKxT2wz8MggXD1BrU6DOvKb9DhzuPCuoMVMwoPKeF6IRAAfN
         uj5G/oQUMKrjpGuVWEOyfaZVYxUIyg8QN62lI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mGFNfxmSybPpi8Hxmqj4rozq0S6s0SBGDpgeol/ec0I=;
        b=H8aXfZhmlOSkGBMsmCCRFxEKfZ5Kh9i2w3zpZ1vGa1L7M3HAZr1FdjPBbnMrzH7Osw
         B81H+bfv8pN5JjaEULUSq/2aKtt+gSVb73cYW6vol/TGYEv51+xP74gQ1g9SCuhKGzTF
         wmYABmwgsg3i+T5pS6QmK4mJ1E//fTYzGVIfOjAZ4awQTendMRtWH3oX/jeand3Ib7yS
         rpVhktVjKL9MUWodCNafcMPDnXC1UOcMdHA+5ekFmvc36St1tGI7Q5KJ+j2QMPFA0jad
         woZtwboYf0d8gQU/SuPqqLYejt3rXkNfCmFMcU49m1UCZVfnSeDXEMvjNcsjGKECFdzI
         s67g==
X-Gm-Message-State: ANhLgQ3OuzJPwvPWzoNJgY+F/Cw2a+DfsyifGMsVGM6es3I+R+ZLoUSJ
        lbfjEdXyUkUWS1ER9pVa8EmtaNNcfJw=
X-Google-Smtp-Source: ADFU+vtVfcuYABDMhFlSg1yG4SAV6zEXwauaAh/uYewZFENHVXS1M4zs+X78HrkaPQkWLwCeG/1wYQ==
X-Received: by 2002:adf:94a3:: with SMTP id 32mr6123482wrr.276.1583244604871;
        Tue, 03 Mar 2020 06:10:04 -0800 (PST)
Received: from kpsingh-kernel.localdomain ([2a00:79e1:abc:308:2811:c80d:9375:bf8a])
        by smtp.gmail.com with ESMTPSA id h20sm11746823wrc.47.2020.03.03.06.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 06:10:04 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
To:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: [PATCH bpf-next 5/7] tools/libbpf: Add support for BPF_MODIFY_RETURN
Date:   Tue,  3 Mar 2020 15:09:48 +0100
Message-Id: <20200303140950.6355-6-kpsingh@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303140950.6355-1-kpsingh@chromium.org>
References: <20200303140950.6355-1-kpsingh@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: KP Singh <kpsingh@google.com>

Signed-off-by: KP Singh <kpsingh@google.com>
---
 tools/lib/bpf/libbpf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index f8c4042e5855..223be01dc466 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6288,6 +6288,10 @@ static const struct bpf_sec_def section_defs[] = {
 		.expected_attach_type = BPF_TRACE_FENTRY,
 		.is_attach_btf = true,
 		.attach_fn = attach_trace),
+	SEC_DEF("fmod_ret/", TRACING,
+		.expected_attach_type = BPF_MODIFY_RETURN,
+		.is_attach_btf = true,
+		.attach_fn = attach_trace),
 	SEC_DEF("fexit/", TRACING,
 		.expected_attach_type = BPF_TRACE_FEXIT,
 		.is_attach_btf = true,
-- 
2.20.1


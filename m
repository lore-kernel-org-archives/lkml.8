Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1367C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A0F2051A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="vL188Lnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgCILNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:13:40 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36648 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbgCILNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:13:31 -0400
Received: by mail-wr1-f67.google.com with SMTP id s5so6624279wrg.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vzahiIr6twtVt6VsSfZyuBvY9ZwGAcuWVXdLGiISKKI=;
        b=vL188LnzEsS+MsKXijsoJluXMPgIutt8/sArmz7u8w2jTAIn9HLd5FDsnv9iuhYX+p
         avQyieMf2HVcYZunpIGMh/orN7X6vV5YORoDbtlRuDfBwP8c+ODaShEJbzTHssWOsUG3
         iK44quOq9mHpXIO71HTFbLiU+TQBM1XuzFBjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vzahiIr6twtVt6VsSfZyuBvY9ZwGAcuWVXdLGiISKKI=;
        b=P4DG0WiVvwTQ/xzg9TQpuYAmROJmjXi9gwRDSflwBJnk7Y0KXFqJO70ihWgfQSH4Ff
         jl6/S7D+Cpj08502bNuHZFiveE0J4IkudT++QTmUKln8ubAOhNXZNlLaeqUXOWL689w0
         9S6DsdOzsje3o2KOFS4AIBT+B7JBZv8fGaENG+f6SXcolDzcT3I8lRM8UJxAbwDesxtj
         sSdFwtDxf85NKYWdQ6ON+p2sRRvPvqXQ4lu6ukOji0XqqPtCdA536QiyXPj8ZSc6uWkR
         ppYSZhI9xlqA+NBnp5gUR0J1qHaVgiMLvZLPPZ/WshR2oH5Y3d8/ULCK/Bf1hzdR0EDX
         pfNw==
X-Gm-Message-State: ANhLgQ1Tv37ALmpPs+UZDHvchbtIPm+n2dRMJtxbSjXAE6Gy5U0H5dTw
        kenBwKa//ISFTIwspR/DRsGT8g==
X-Google-Smtp-Source: ADFU+vsNhSDq+4c6qa3NLLHn3/xIV3phZyRLu07jB2TtZmct8F2GzqbRAyf6VGtqPNUqtLII7mdYEA==
X-Received: by 2002:adf:f0c6:: with SMTP id x6mr19533874wro.273.1583752409755;
        Mon, 09 Mar 2020 04:13:29 -0700 (PDT)
Received: from localhost.localdomain ([2a06:98c0:1000:8250:3dcc:c1d:7f05:4873])
        by smtp.gmail.com with ESMTPSA id a5sm25732846wmb.37.2020.03.09.04.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 04:13:29 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next v4 12/12] bpf, doc: update maintainers for L7 BPF
Date:   Mon,  9 Mar 2020 11:12:43 +0000
Message-Id: <20200309111243.6982-13-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309111243.6982-1-lmb@cloudflare.com>
References: <20200309111243.6982-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Jakub and myself as maintainers for sockmap related code.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 14554bde1c06..adc7fa8e5880 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9363,6 +9363,8 @@ F:	include/net/l3mdev.h
 L7 BPF FRAMEWORK
 M:	John Fastabend <john.fastabend@gmail.com>
 M:	Daniel Borkmann <daniel@iogearbox.net>
+M:	Jakub Sitnicki <jakub@cloudflare.com>
+M:	Lorenz Bauer <lmb@cloudflare.com>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Maintained
-- 
2.20.1


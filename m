Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FAEC3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B3082084E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BH513kc2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgB1Ly5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:54:57 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40512 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgB1Lyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 06:54:52 -0500
Received: by mail-wr1-f67.google.com with SMTP id r17so2624652wrj.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 03:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MdviBniUP1LTLTlxYrXf4cKTRz1/Aw4mUeuM3QyEeaY=;
        b=BH513kc2bjVfCoogIWJkQPhCfXVFyBq8iNap7ABg1XuYuZiyMESn3PhHMBuT0E6/w9
         b+G35KExpAyEQUFRnkW6OJ5TYjksyTo6+bgXsTQf6ptBiajUxYl/7N0QUbmAkQL7MZ8p
         dzjCpHFWz2sh7x8RdSnAHoWZilYlwT+HbQ+TM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MdviBniUP1LTLTlxYrXf4cKTRz1/Aw4mUeuM3QyEeaY=;
        b=hBOcYX2t0PF7HVElSJOAPd+Q3dTh607/B3I4dCN1NtWiFcVw94NgxIzKTGocWi8B65
         Ob/Jij0uRGKTgzRSqH/gDoVi6THuKTuPiTwPmGuti7aHrlNv5RBOPNZWbx1F/3kGAE4x
         LiigpIRSkOpa78L+B2hmdKn7Fd5s9U3OuZOoc/109pUB14+jOQuA7eX7u4vNvbvEnTd6
         7WB3jnGwSIr8s+tcWbpnLUjVWYMIFur4wQSmA4En7RTcazyhVYwA4sKemScTIcSsPoaP
         Uv1ZkPlzZbQq7xx6wEVfUc1mZrTKklb0FUpsFklV9i9lIdn1oHD5wWeCwJsz1HCUdEE6
         6tnA==
X-Gm-Message-State: APjAAAV5op/Gpakd3HeB1hmQtCUJhY/bSbyg8LbkN0F5oHjgKvxgoISg
        mqzc2dmxKEw2j7ySe34jFZ+dHg==
X-Google-Smtp-Source: APXvYqy6+1s+Iw2KKU638/K+YsQPGmQypYVGl3aWhpmEya+4vA4ML8sUFdda4aZNYwKKNv66XDMHZw==
X-Received: by 2002:adf:fecf:: with SMTP id q15mr4747203wrs.360.1582890889015;
        Fri, 28 Feb 2020 03:54:49 -0800 (PST)
Received: from antares.lan (b.2.d.a.1.b.1.b.2.c.5.e.0.3.d.4.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:4d30:e5c2:b1b1:ad2b])
        by smtp.gmail.com with ESMTPSA id q125sm2044284wme.19.2020.02.28.03.54.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 03:54:48 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     john.fastabend@gmail.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     kernel-team@cloudflare.com, Lorenz Bauer <lmb@cloudflare.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 9/9] bpf, doc: update maintainers for L7 BPF
Date:   Fri, 28 Feb 2020 11:53:44 +0000
Message-Id: <20200228115344.17742-10-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228115344.17742-1-lmb@cloudflare.com>
References: <20200228115344.17742-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Jakub and myself as maintainers for sockmap related code.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 495ba52038ad..8517965adde8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9351,6 +9351,8 @@ F:	include/net/l3mdev.h
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


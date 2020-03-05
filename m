Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EE2C3F2DE
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1252C2146E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.washington.edu header.i=@cs.washington.edu header.b="dAYgGP3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgCEFC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 00:02:26 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36142 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgCEFCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 00:02:24 -0500
Received: by mail-pg1-f195.google.com with SMTP id d9so2143278pgu.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 21:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sV8q7HarohWqKtnLYGNVE5KFLA+QloKZuMOzSIKtRfg=;
        b=dAYgGP3CO8Go0Zt3CaMIpp3oxWWrwBLg5KnHPPIq1+VU1MpOpmu2zAFLvsOtpeZ180
         NKGu6+L7b2be7/a8CLckxLaKZP1QmM/5QftVRYVbj5sqDFXW03auDeJMHhm2V1Cj1dlX
         nD37M0rf1FK33a5vwQcWtV+vReeBbTFCqxzas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sV8q7HarohWqKtnLYGNVE5KFLA+QloKZuMOzSIKtRfg=;
        b=ngF9Imuqml4zu9zCtQGy26zy6R5XWOGcju9Ms38c8LO3vPNXRdRLINeXMMM5xbn7r0
         qZ+ZgRD/yFtWt6EvrxokWTzQoGJPaL71N2XMmj5+SaBiwk8fJkZ9yDP2aB9maMZ+5j0X
         H7ILt3cyEKzK75g9ezyRihqApeOqaX96DKG/kIV574LTLPecslSiFr1li9g+Oiz5JgyY
         Zc6JtzgcJSQUTQjEWAGZlBFduJ/aFdwlcgD0w9GCnGXVUnsuf/nenTCCV57FKwkiCb15
         fWtJUS1uz9e7xw4cSaLLvOxG+ilDA9JLXq/u0qddeOkiZblQEVX9JxAwlAjInmZi0Epw
         Sayg==
X-Gm-Message-State: ANhLgQ3R+JMVTHu3hzceyb+Hi0+aQGGbx5tBgU0xMegI8YDoNrsfFl/W
        z0sW3GKBfNQsXc1ppuYTegyoHw==
X-Google-Smtp-Source: ADFU+vuDUOkuw26JMyYv3YyKm1JJ4tL0PWpDR+kh5XrqfpKiEVBUYAUr39/AOzWyra/fJYd3DntQNg==
X-Received: by 2002:a63:1e4f:: with SMTP id p15mr5929375pgm.28.1583384543147;
        Wed, 04 Mar 2020 21:02:23 -0800 (PST)
Received: from ryzen.cs.washington.edu ([2607:4000:200:11:e9fe:faad:3d84:58ea])
        by smtp.gmail.com with ESMTPSA id y7sm17820466pfq.15.2020.03.04.21.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 21:02:22 -0800 (PST)
From:   Luke Nelson <lukenels@cs.washington.edu>
X-Google-Original-From: Luke Nelson <luke.r.nels@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Luke Nelson <luke.r.nels@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@gmail.com>,
        Xi Wang <xi.wang@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH bpf-next v5 4/4] MAINTAINERS: add entry for RV32G BPF JIT
Date:   Wed,  4 Mar 2020 21:02:07 -0800
Message-Id: <20200305050207.4159-5-luke.r.nels@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305050207.4159-1-luke.r.nels@gmail.com>
References: <20200305050207.4159-1-luke.r.nels@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new entry for the 32-bit RISC-V JIT to MAINTAINERS and change
mailing list from netdev to bpf following the guidelines from
commit e42da4c62abb ("docs/bpf: Update bpf development Q/A file").

Cc: Björn Töpel <bjorn.topel@gmail.com>
Signed-off-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>
---
 MAINTAINERS | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f27f40d22bb..ffad63a02d7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3213,11 +3213,20 @@ L:	bpf@vger.kernel.org
 S:	Maintained
 F:	arch/powerpc/net/
 
-BPF JIT for RISC-V (RV64G)
+BPF JIT for RISC-V (32-bit)
+M:	Luke Nelson <luke.r.nels@gmail.com>
+M:	Xi Wang <xi.wang@gmail.com>
+L:	bpf@vger.kernel.org
+S:	Maintained
+F:	arch/riscv/net/
+X:	arch/riscv/net/bpf_jit_comp64.c
+
+BPF JIT for RISC-V (64-bit)
 M:	Björn Töpel <bjorn.topel@gmail.com>
-L:	netdev@vger.kernel.org
+L:	bpf@vger.kernel.org
 S:	Maintained
 F:	arch/riscv/net/
+X:	arch/riscv/net/bpf_jit_comp32.c
 
 BPF JIT for S390
 M:	Ilya Leoshkevich <iii@linux.ibm.com>
-- 
2.20.1


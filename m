Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FB8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 04:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1884520792
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 04:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhVQyH8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgHDEYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 00:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHDEYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 00:24:24 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E62C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 21:24:24 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id p1so22158558pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 21:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v96ubfgeahRH8xGlTKbAfEYW4ILSGysT4Aem4Y+4DRg=;
        b=EhVQyH8cSJ8WjufSoJQDqGVwOxId9jA9kgPDpqVmz6Eop5PLtoNqsaJ8d/ka9ob+1n
         wCzQhOS2Q7eh89CBVwe5xcy6yeZ7Db4h/Q/TtQGA2NHFgQqBIlJWT6To4J0L8fPDJKYs
         ONsK/6GnZQn4pdtbGmkGETU8J+ArYZBw1fBCkSX4ibQZWi6pZ055lyBfKQwRBWgxyDuF
         jYcIwQxPO5tzFIhthRRLguJXOqCmzsyEeKeEgv0goGLm9QnOYwIxfRYYXjsFSEnnjAX0
         1uhUfWIVbM8Q4qZ1nMDtt+mlxNTgR/B2bOcnqSWaYZX9glLdq7Z/qSknoO4YXsqRlNGp
         xcAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v96ubfgeahRH8xGlTKbAfEYW4ILSGysT4Aem4Y+4DRg=;
        b=HcZm+CNwlwl0+3MSoMwKN55vKa4NBVTWpa17hC8ho/DIa93kd7iwycXaDPyhcp155g
         YENv6Ix3grrAXqq7687ZoKobLsb5BlzfHZDlL4jD+E4VNNxUMbxV06TgYEgrG98rUasN
         KJcy7dOjDBJSyc1vgnvT+jKBman2D8HeqxM8762sfbzbu/ui5Z8gRkPuD1rl902h9IwQ
         JN4LI5Fh2Yq7o4OX3IupXz0/MYDGU8upV517vuim2wl0FFcTtNqAx/bn5l1WPG0GM+LD
         14GXU3w5ApmBhqOivW+iu9DFeksYSUqv9itwhyj/jAUzcTPEm+xuPEl2+lPKe4dEMtZb
         rPnQ==
X-Gm-Message-State: AOAM532RyZQDgmmUhP/JCab0wetDuz+CCsznPAWjvr0FkA3D3c6FvfIv
        pZka8jJuLMkyICH0m/e9j6jvgkgS
X-Google-Smtp-Source: ABdhPJzjN+8C7iOcRT/urmN6FvL54B86INpPPzxRPdkwYACqnHdKiIRG9rYX82aC0KE5TaEVT3WwFA==
X-Received: by 2002:a17:902:9b96:: with SMTP id y22mr9924530plp.86.1596515063199;
        Mon, 03 Aug 2020 21:24:23 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id d29sm20593782pgb.54.2020.08.03.21.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 21:24:22 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        openrisc@lists.librecores.org
Subject: [PATCH 4/6] openrisc: uaccess: Remove unused macro __addr_ok
Date:   Tue,  4 Aug 2020 13:23:52 +0900
Message-Id: <20200804042354.3930694-5-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200804042354.3930694-1-shorne@gmail.com>
References: <20200804042354.3930694-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit b48b2c3e5043 ("openrisc: use generic strnlen_user()
function") the macro __addr_ok is no longer used.  It is safe to remove
so this patch removes it.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/uaccess.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
index 4b59dc9ad300..85a55359b244 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -55,9 +55,6 @@ static inline int __range_ok(unsigned long addr, unsigned long size)
 	return size <= fs && addr <= (fs - size);
 }
 
-/* Ensure that addr is below task's addr_limit */
-#define __addr_ok(addr) ((unsigned long) addr < get_fs())
-
 #define access_ok(addr, size)						\
 ({ 									\
 	__range_ok((unsigned long)(addr), (size));			\
-- 
2.26.2


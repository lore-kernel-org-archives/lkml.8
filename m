Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A69C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 21:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79E172063A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 21:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADuhkSVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgHEVII (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 17:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbgHEVIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 17:08:04 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B36C061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 14:08:04 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p3so25379884pgh.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 14:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EcaRclfd0NpwDQkcLxmVNZSW1Z0kqxgpCzRoAu48M1w=;
        b=ADuhkSVaDTRtiX+a/A4HRrnX5wdPewQRO4PVUtaEa6sLvhaNXyC1A75D6NJO8ujR9R
         A5qauA/huCD7MSpwS4JHRYjIef9Do4aCI1Y9HDctfxPU4dr6EGyeWYbuQ9kWUoilKJ6s
         8khxjHRPj1RHfkem/eleQ8AUDG3vIP4n+o2lQbZxOr2JaSN0ZZcO/+PDRtNn8KEQ3f35
         jLAQOIngNG6pbVYVslCA7Tgt7fW+PWI1EhBqT0JMkG07nJ66bheMAOvFiWW2kYBX/TGy
         Nuu/CtMQ9oMjiMZnyW0wwXl7fB7DCouXMneP8gV5fw76UcEj6w7zG5v5dejTn6wpie9a
         g8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EcaRclfd0NpwDQkcLxmVNZSW1Z0kqxgpCzRoAu48M1w=;
        b=r04qfsxivNscl03vtB9eqVxO74mW7nc+s6KL/nCqj9JH8FWFHT0V4lALRxvL4BdNOp
         J1hdVEbvPK6VA29DRAmhNJRQPR75HUNTGO2tWnN+vCbKzKXIrlSd/gOVnJH25RkYui2K
         DI9XEeBMAueuvR10lSNSCyl9Cl65Xg3nDrt39pGicLv1hAhpaYvVHQhRVv2B2c06Diz7
         dblc399yuGTHQ+Q68dIQcGLX5YlCCgkl5ZFMykZSa1/0WddSxqKU6krJw7kG3QbPGZwp
         ab4wdu1ic8NU8W2DrX9ZlhV49DJo0GaVYlR0YYeoROqhI8FbQZgCk3jlIao5r72jgDve
         d5sA==
X-Gm-Message-State: AOAM532fkRofB0GHRac72kpjIEIqrzsaSknpEX97TJ0cFQm22Kw6BYVu
        r0GV0qXYv9Qx54YgYnY0LrhU9LZh
X-Google-Smtp-Source: ABdhPJyc1IRz+k1a9ZVeVghgxqQ7jnpmtKsUqeaQgqyVbIwZlNtxpP3qjnfIajH51JP52Nj6WDK2zw==
X-Received: by 2002:a65:64c7:: with SMTP id t7mr4426410pgv.89.1596661683856;
        Wed, 05 Aug 2020 14:08:03 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id b13sm4694633pgd.36.2020.08.05.14.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 14:08:03 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        openrisc@lists.librecores.org
Subject: [PATCH v2 6/6] openrisc: uaccess: Add user address space check to access_ok
Date:   Thu,  6 Aug 2020 06:07:25 +0900
Message-Id: <20200805210725.310301-7-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200805210725.310301-1-shorne@gmail.com>
References: <20200805210725.310301-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that __user annotations are fixed for openrisc uaccess api's we can
add checking to the access_ok macro.  This patch adds the __chk_user_ptr
check, on normal builds the added check is a nop.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/include/asm/uaccess.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
index 85a55359b244..53ddc66abb3f 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -57,7 +57,8 @@ static inline int __range_ok(unsigned long addr, unsigned long size)
 
 #define access_ok(addr, size)						\
 ({ 									\
-	__range_ok((unsigned long)(addr), (size));			\
+	__chk_user_ptr(addr);						\
+	__range_ok((__force unsigned long)(addr), (size));		\
 })
 
 /*
-- 
2.26.2


Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350D5C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FE3D206D8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nf0dY76R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgHHXHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgHHXHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:07:20 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637BAC061756
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 16:07:20 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id g19so2932627plq.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 16:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pDz8Q0LmiAvmhRqG8qC/282Sb6uJp9Qz6LidATVCB/U=;
        b=Nf0dY76R58uGzD6j3/28zS3w3KIIQTf+muQl7PjVubwID4qK3JWF/9uoawz9K+B3cV
         6mwPMHZTcKgnC3MqMrija8j3xlZRRlX49fmrdoNZ0+bbr2c/JeoglNRA3febJPBHHWIc
         gziUJ3Z9alJH4y6c2m3wCdXWTd5YuQ3BE5200BmqAzzPzCmQEcUZ/lWGzhvfE18Dy6Zv
         Vzj4kjzScpnL+WBZLDRHOF3SQBQxR/b6wBtCu6WjADq2f85Crt/axQ3fErfA/lvIRX07
         8aBpGst0tzKazlBzIYSFoWyFC4PYw38G6iS9Vo13uOiHbC6aTfTZq2IFlOJITVHxXglj
         AyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pDz8Q0LmiAvmhRqG8qC/282Sb6uJp9Qz6LidATVCB/U=;
        b=uIhgn5daxsN68PYBsFzV67NFc35C2zVfyc8iacjRAC+oXJm4hqGbnkfrs1yiji8Q9I
         H9mTGoruLRLzPNV6V2ZRVzpOIvvchElrBz09U5gWZZ96SBYDu3XQNgBBwiFQDJXVcHPd
         xymEnriC5g6ESyHsZbdfEl9SDMjDQamff1YfgEigpw13LJsn1YCYBYyHIi9Vi0ytPNCK
         14Ey7P/7+sfB31X7PnHEcQTBIr3/WYyUh7752qg/dcC7xWLn/J5jcxOEnlp1BJEeq4TW
         H2/ZgY6M/2Vtr4UQKz4o++KUqDAQ8yex5z6Ab8zW+eW9D1YkY7avZo40ArFKzSINiFoF
         VsoQ==
X-Gm-Message-State: AOAM531pNyWqgFH5Jh5O4yA2P4Ex9OmrrNk2MkiBof+gn3pveb19MPsZ
        5dbNvtkQhMGxiS+gSgjyT5+G1A1e
X-Google-Smtp-Source: ABdhPJw4mZcO6/c/sZmbEOqLUZYbhxa/R/06dhxQLiRlUbbhXF5nO4l2YsheTFXOH0vcPx03Is/n9g==
X-Received: by 2002:a17:90a:2224:: with SMTP id c33mr19383534pje.56.1596928039642;
        Sat, 08 Aug 2020 16:07:19 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id j8sm9324330pfh.90.2020.08.08.16.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 16:07:19 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: [PATCH v3 6/6] openrisc: uaccess: Add user address space check to access_ok
Date:   Sun,  9 Aug 2020 08:06:47 +0900
Message-Id: <20200808230647.833047-7-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200808230647.833047-1-shorne@gmail.com>
References: <20200808230647.833047-1-shorne@gmail.com>
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
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
Changes since v2:
 - Remove __force in cast suggsted by Luc

 arch/openrisc/include/asm/uaccess.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
index 85a55359b244..7c5892f56765 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -57,6 +57,7 @@ static inline int __range_ok(unsigned long addr, unsigned long size)
 
 #define access_ok(addr, size)						\
 ({ 									\
+	__chk_user_ptr(addr);						\
 	__range_ok((unsigned long)(addr), (size));			\
 })
 
-- 
2.26.2


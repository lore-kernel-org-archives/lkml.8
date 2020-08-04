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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5319DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 04:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5528B20792
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 04:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q913rhBu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgHDEYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 00:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgHDEYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 00:24:32 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11230C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 21:24:32 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z188so11649285pfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 21:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EcaRclfd0NpwDQkcLxmVNZSW1Z0kqxgpCzRoAu48M1w=;
        b=Q913rhBuAyO0+o60xPFJW8wXg5ZGqcIWEXeCz7RiId05lFNkXDJ1auQO6qwHL22ddS
         HYG3qOGO/VlnsSMATSISis4CbCxnYJNbpCvOzH1rH6+1FEmnWPrf7ziw+lN+Ltq9Hj06
         Xp78/F6OYdjbecx/AI6LxXrCQAws+A9x91HLi/S9ervmpAoa8EbMmZDYtiFexsmF9/Ke
         lmJPvQcI6bkFGspcHQsOt/fp3LljJIy7s1cJs5dWrg/bqRzoM9EOXJBgci6Q7QZhJVcT
         UD/SdZNbTOG9pRZ07Arw3hyGUH1hiRrbH/LjJeQXA7Uk7ifC38OrgCWSrl8JcwiYDqn9
         mjnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EcaRclfd0NpwDQkcLxmVNZSW1Z0kqxgpCzRoAu48M1w=;
        b=Kw2eb75z7j7tRT5MqGqtC+gkibyMbzMYYOPtZ3LUD6nuYSUz6QVyOXL4/ghHHFerCP
         6m8eBEOq6FzcTGQGSsNaBNMmJQt8h1OSBq3I/ANCP0qRJecxeVKcpB/NOENBNN0geoXX
         S+yRqmpXmEgy92z+/MhyDlEgGcN+IgIBprDgDBpVv0WfehdGPZoJwpJrf8cmcKsOb1An
         zRQggEtsCk5YZFurWDHG3cX+jAfQhh/fjDM/dV2XuHSldwSTiA0iqzTsgZEAB04MJds1
         2n+0Ax9s9DUUA51KOocYv0Yns7atG8KAnmruD0JuJI8IYMKlYjw0GFySvaiQK3yxonns
         2+kQ==
X-Gm-Message-State: AOAM530W5Bon1zLj96SxlgVC+zKsigmCengrcYzD3tKrcE+o2QSwRGIs
        OSDvln3dy5uJQad3DljP15mXpzjW
X-Google-Smtp-Source: ABdhPJwWb3dqAl/1suQswntoOlM/h/C2wqZtYp/uBvMj6jLbSp2K7zuoxskw05OjhWkIknVd+Inkiw==
X-Received: by 2002:a63:4861:: with SMTP id x33mr17010551pgk.448.1596515071039;
        Mon, 03 Aug 2020 21:24:31 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id x9sm21164602pff.145.2020.08.03.21.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 21:24:30 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        openrisc@lists.librecores.org
Subject: [PATCH 6/6] openrisc: uaccess: Add user address space check to access_ok
Date:   Tue,  4 Aug 2020 13:23:54 +0900
Message-Id: <20200804042354.3930694-7-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200804042354.3930694-1-shorne@gmail.com>
References: <20200804042354.3930694-1-shorne@gmail.com>
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


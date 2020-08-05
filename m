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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B743C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 21:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72BB92065C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 21:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ra1N+hKo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgHEVH7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 17:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbgHEVH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 17:07:56 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC75C061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 14:07:56 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kr4so5413474pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 14:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v96ubfgeahRH8xGlTKbAfEYW4ILSGysT4Aem4Y+4DRg=;
        b=ra1N+hKoOtk5+DcbbgGsoMGexOPWfeNtvkB67fEqNZ2Q9sjhXGWHwfqltkBv70FmUH
         edugTkarOj9Qruhl/kueDS5bT0XcpPfmG2+piwt8FrxUHEvjRtWnlb4sgktLOiibURt4
         AFjlIB7HuP45XcTk/Wuecxeh7Q8AiDYKGY8nRBs2QEUwB6ja+Tn/WLMNrFNmCxHvp+oX
         wXA0izQ5Ix8hh1nK8DSuSq84A8e5UocOJKAuF8fyoOob2byMo6h2HDF4egtWTtMv3o46
         Odtu6a1y9ljWXJ1Qfph2Ej0DuIxaAdmiHklBuO9HEm1tQskfC03G3uBRTWP2SJyXCDG2
         DuQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v96ubfgeahRH8xGlTKbAfEYW4ILSGysT4Aem4Y+4DRg=;
        b=rTPmPDDT46vIjdrtjaBiOFaGYGcG5jtJpEDZIr+/HnUH5bYm0KqJlf+Gw3p8QGLiCs
         /r98DgRvfBwfoKpLVK++ndmJuxi5Ei9TwobVcl1ruKWTIXgpjWHAaJK60aznGkxKqKke
         iVO67O90kEnHftHYISBrHFAsC/JDySg6V8nKBKetp0CsLpoMCYHdlEF8gVlroxN25QwY
         gUH0HA9g2tHfBN+hIQQq9Z4mS0ijhzzlYbMKpjlTaNQx0ErHZlHc7OrwRTNU5E7Nviiy
         05plPtEWSi+rFnLm0d12ahSfw/ktLRwvaoUMFC1MsvbvPUB3TJ18FTe/5trnDfa7LNqI
         s74w==
X-Gm-Message-State: AOAM532BEbomEWUxSqw1v3G9MF7hdFi+NpMHcBn9kYTdaifps8YD6xlh
        S9NuJ4d6st8muu8rn4CDlSJuzCFx
X-Google-Smtp-Source: ABdhPJwgAH4NnK9wX6qTc8HLiOKtJkemmE2YjMahKds++HdJ9FjRt9GvV6Ys+LDVFH4h9rcTAgzv3Q==
X-Received: by 2002:a17:902:d303:: with SMTP id b3mr4916272plc.101.1596661676102;
        Wed, 05 Aug 2020 14:07:56 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id e15sm4101134pgr.39.2020.08.05.14.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 14:07:55 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        openrisc@lists.librecores.org
Subject: [PATCH v2 4/6] openrisc: uaccess: Remove unused macro __addr_ok
Date:   Thu,  6 Aug 2020 06:07:23 +0900
Message-Id: <20200805210725.310301-5-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200805210725.310301-1-shorne@gmail.com>
References: <20200805210725.310301-1-shorne@gmail.com>
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


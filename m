Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5252EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F152077D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVSJoPpm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgE2TCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgE2TC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:02:28 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F101C08C5C8
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:02:27 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id x1so3081172ejd.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vj9D4U4So1ra9Zm9hnNGo7stdHYSpNs6NtruFkUFgeo=;
        b=PVSJoPpmVjSmJFILAcMsDnWtnz8yzzzzxyuIuH6IOFqDD/1Yx2gAZuyAoegjLdcJss
         srDdbIWUxBH29A6pHzwXdtZAVkXndvDtQloYk2w+TqGAM2Irhstx8xMOi37Ad7Qh8+Ax
         0rSUA/1K4tlavO2P/idQzvgLPvKekCioSb9wXPyTe5A6WjDUToCvzu4oIuY/2wcajnZX
         B/EK09TXTE3ZwMa5/9lCXVwrxdDlNSNvPsBFaZy8FCc+Fy/+/5RQpzce8G7dbDo7wB4k
         3HFtMEeM1dt85rUCtGqugQg8Od6zBukGPYPgOt4zEUPh6jgktgJq2EhF1eTowmz7EqJy
         3rsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vj9D4U4So1ra9Zm9hnNGo7stdHYSpNs6NtruFkUFgeo=;
        b=q3znicskZr6HLDcD8mbnGT6Pwls3b0sv2IBLYE2LjyNVlp62CbzdaWXDYM1bGQs35j
         krfSqwXPVbuD3u/BEeXlSnlxJKH+0i7qJb/3uuDaYoBrN+AUoumHMkj8zhy0gVK6tdaB
         wHc13j22r2aDfUz/twiFrARIbUTkyUPWxLgoemu7bEZz+QVC4KxVveGD+40X35lzqnvX
         7WE8LCK6m5vD9qclUttejdc5CvOIhuqd2/BjyTL4UeaTt7lo4Phzy8KqcLMuKTbb4bVD
         iZGHWVi4f0vxwZvvQPuWTJ2Y2HASoRsakoWPxPtpWiU1BJsvGbOhoXzrq6lyPqJmEN42
         XIMg==
X-Gm-Message-State: AOAM530TBWVDdVc2a/mVsNsspD8z6GBvOQbsn7e6gJXpMmaP2k24eT5E
        VPtlN1VeiVK9GyR68XfeatL4/HBv
X-Google-Smtp-Source: ABdhPJyQx2RUSz7R1gfHefn9U0kmUE2GFhFldxj0rbBxbVcvlhcRfXqs29T8F/j2u4gKQmfl5E45Vw==
X-Received: by 2002:a17:907:40f1:: with SMTP id no1mr8830682ejb.178.1590778946181;
        Fri, 29 May 2020 12:02:26 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:1951:ff2b:10f0:1763])
        by smtp.gmail.com with ESMTPSA id f4sm8166135ejk.17.2020.05.29.12.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 12:02:25 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v2 1/2] m68k,nommu: add missing __user in uaccess' __ptr() macro
Date:   Fri, 29 May 2020 21:02:17 +0200
Message-Id: <20200529190218.36560-2-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200529190218.36560-1-luc.vanoostenryck@gmail.com>
References: <20200529190218.36560-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The assembly for __get_user() & __put_user() uses a macro, __ptr(),
to cast the pointer to 'unsigned long *' but the pointer is always
a __user one and so this cast creates a lot of warnings when using
Sparse.

So, change to the cast to 'unsigned long __user *'.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/m68k/include/asm/uaccess_no.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/include/asm/uaccess_no.h b/arch/m68k/include/asm/uaccess_no.h
index a24cfe4a0d32..9651766a62af 100644
--- a/arch/m68k/include/asm/uaccess_no.h
+++ b/arch/m68k/include/asm/uaccess_no.h
@@ -60,7 +60,7 @@ extern int __put_user_bad(void);
  * aliasing issues.
  */
 
-#define __ptr(x) ((unsigned long *)(x))
+#define __ptr(x) ((unsigned long __user *)(x))
 
 #define __put_user_asm(err,x,ptr,bwl)				\
 	__asm__ ("move" #bwl " %0,%1"				\
-- 
2.26.2


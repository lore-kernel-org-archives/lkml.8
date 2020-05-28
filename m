Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C5EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 134842072D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtUgp18i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407197AbgE1UZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407151AbgE1UZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:25:22 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047F2C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:25:22 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id h21so1365491ejq.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 13:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XQAtsk/t+fqstgbYgDtIde3vAr7su5QktZBlwp2bjhQ=;
        b=LtUgp18i1/9YOTzZt1/pTx6ctnDjDnQj9O3AP8wClTUO+jbHVJ6UM/hRm3Dy3mFtUj
         kScoehplRay7PttiZKj4934NMGVAYRXvE+oH2ws9OrS4gjIW9+tUfa8b+HNu98fv8DFq
         xpKTme1gN8dtl+uOSTtdWscFVVPL8BfRaEyBfzY35RVj7j+7CKPPEqWZRSjIF8HdShAf
         rAFeoxbQ+rJQqRja6pR9ygLhsOWyIxpjWzJ1rTqFqzJ8X4p7FieN2GDI9WK0t240LMCu
         t1LgWv6yvPkSFTfSn9ckcJmsJ+lMLPNWDUykk7LcguxjCKWmZhefC+36SADGcrv6IU9k
         XXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XQAtsk/t+fqstgbYgDtIde3vAr7su5QktZBlwp2bjhQ=;
        b=iXMeeNIgWwL1gCGiNQpjFsKe2MgnNGSFYJozf2L3G7DECwRDI8Xi71hQevPTibFlGZ
         0SC/q5Wz8ywIE7unVahNZSSLwmTIYmiVH9hJsq2O/XbL+/KHvoHvYNj5L/hxBly84GPW
         o13gBmXEjqen4rRI3acbUeXAabrtudZAN3JjQPTAtIrqqxkzRASHV5ZEoD8NXGrn7Z2V
         dAABwZfnAO1J+bUIRfDxvqWgvTXJU1TZb0SjuiE5biZUd67DGPqvzHJAsDoSqIioi9yH
         MR5cNSNdyknl1zRlwsjXESyZ3RoPVbdq3C1eOWwkmSIJbiR2yxq84NvpayD89dA54KlF
         EwLw==
X-Gm-Message-State: AOAM531jC+KcbC5tJwhhfK14zFIPl5W3ZwRka7DVNMJnMynMsVA+t2Do
        LlsZdQBFbJ8rMJRuvKbX1lA=
X-Google-Smtp-Source: ABdhPJyRnPmNyad+bHae/uPhbcgRV8q1YRY4dd0vf1eU5zp3Q7YYfcUR2L72QDqExSMY7jaeHi6BMA==
X-Received: by 2002:a17:906:2a4d:: with SMTP id k13mr4867500eje.253.1590697520774;
        Thu, 28 May 2020 13:25:20 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:d98f:8461:8d2c:e59b])
        by smtp.gmail.com with ESMTPSA id y13sm5692736ejm.107.2020.05.28.13.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:25:20 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH 2/2] m68k,nommu: fix implicit cast from __user in __{get,put}_user_asm()
Date:   Thu, 28 May 2020 22:25:14 +0200
Message-Id: <20200528202514.27175-3-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528202514.27175-1-luc.vanoostenryck@gmail.com>
References: <20200528202514.27175-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The assembly for __get_user_asm() & __put_user_asm() uses memcpy()
when the size is 8.

However, the pointer is always a __user one while memcpy() expect
a plan one and so this cast creates a lot of warnings when using
Sparse.

So, fix this by adding a cast to 'void __force *' at memcpy()'s
argument.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 arch/m68k/include/asm/uaccess_no.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/include/asm/uaccess_no.h b/arch/m68k/include/asm/uaccess_no.h
index 9651766a62af..f32f08a64eaa 100644
--- a/arch/m68k/include/asm/uaccess_no.h
+++ b/arch/m68k/include/asm/uaccess_no.h
@@ -42,7 +42,7 @@ static inline int _access_ok(unsigned long addr, unsigned long size)
 	__put_user_asm(__pu_err, __pu_val, ptr, l);	\
 	break;						\
     case 8:						\
-	memcpy(ptr, &__pu_val, sizeof (*(ptr))); \
+	memcpy((void __force*)ptr, &__pu_val, sizeof (*(ptr))); \
 	break;						\
     default:						\
 	__pu_err = __put_user_bad();			\
@@ -85,7 +85,7 @@ extern int __put_user_bad(void);
 	    u64 l;						\
 	    __typeof__(*(ptr)) t;				\
 	} __gu_val;						\
-	memcpy(&__gu_val.l, ptr, sizeof(__gu_val.l));		\
+	memcpy(&__gu_val.l, (const void __force*)ptr, sizeof(__gu_val.l));		\
 	(x) = __gu_val.t;					\
 	break;							\
     }								\
-- 
2.26.2


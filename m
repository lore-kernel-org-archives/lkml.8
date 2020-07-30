Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 775F1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C29720809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 09:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fM2X7hGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbgG3Jrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 05:47:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:30665 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729048AbgG3JrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 05:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596102427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Occm5aQ4dBEhhryYjoe4Uk7FK9wU453jYboxAVsStV0=;
        b=fM2X7hGQiixoeagrW8AGchA29SHwL9bSCAkWyp+XTzDdE+ZJrk8mCj0SDVBXfOOK0xjVAZ
        6OIp/PO1V/Vy0An9aV5/yiQlF/djfUTNQ1mvNXvf5Oq66dQVwLV+JzKSfRRXc7CHCmQDhl
        12zGUsmTULU+cSHIdHS3Rf0CJTwwgIc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-88-olvyvlA2Pl638cyqlRjmVg-1; Thu, 30 Jul 2020 05:47:05 -0400
X-MC-Unique: olvyvlA2Pl638cyqlRjmVg-1
Received: by mail-wm1-f70.google.com with SMTP id p23so1299418wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 02:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Occm5aQ4dBEhhryYjoe4Uk7FK9wU453jYboxAVsStV0=;
        b=r06hVHKvLkRtTVwhurXNmwYSUpFMvG9QtLPf4q8NG3Lbj84OCYFJwZrc7JaL1MUBoF
         ymow9+D6kriwd1oZiHTcmemZy4HkG1E6cnWCIGLdAufc6UQ06xc8Fs39Hx91AscMVgrC
         g//+9iNI1qLEr4ohT1iMxG4coANi+4iAdbDEmiBewMJmD4gQboxN+mXWtOOnjc79zDnL
         qi/DTi4ES5NZ3vRq3dYTzep9g9Ui7TPc8fxgNlkmhQ8iJUkYHwZrLTtGvSUUVxcVG/Oz
         wBE5I2xa1ItZwQOid+eRL7LA29bSma4gJEK2kWqha1zty1eaIfHnlxYypED4e9snlaYs
         2XAA==
X-Gm-Message-State: AOAM531Apg4kMlSqO3a6o3s/Nj5cObDGevgcXpwiES3TNuxqGwRGcwz8
        ICP8zQEPfgBESovWPcQ8SJPi+kOJbwhynnxwkuQevvP+GXRz5lLjFNwJPVurJDxKcjLOPSpVPKo
        tVGv9Txi9MPpp5FeSjM/hjbQy
X-Received: by 2002:adf:bc45:: with SMTP id a5mr32842900wrh.215.1596102424080;
        Thu, 30 Jul 2020 02:47:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLq9Op/YIhnGUs1cA8a9+sQUehUXxwGgFo/5E4s19Gt9po3nmaBw57ioUZO1K+YjVmVr9+xQ==
X-Received: by 2002:adf:bc45:: with SMTP id a5mr32842867wrh.215.1596102423860;
        Thu, 30 Jul 2020 02:47:03 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id j6sm9009645wro.25.2020.07.30.02.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 02:47:03 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH v2 7/9] frame: Only include valid definitions depending on source file type
Date:   Thu, 30 Jul 2020 10:46:50 +0100
Message-Id: <20200730094652.28297-8-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200730094652.28297-1-jthierry@redhat.com>
References: <20200730094652.28297-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Header include/linux/frame.h contains both C and assembly definition that
are visible regardless of the file including them.

Place definition under conditional __ASSEMBLY__.

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 include/linux/frame.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/frame.h b/include/linux/frame.h
index 303cda600e56..d946adb5de17 100644
--- a/include/linux/frame.h
+++ b/include/linux/frame.h
@@ -3,6 +3,8 @@
 #define _LINUX_FRAME_H
 
 #ifdef CONFIG_STACK_VALIDATION
+
+#ifndef __ASSEMBLY__
 /*
  * This macro marks the given function's stack frame as "non-standard", which
  * tells objtool to ignore the function when doing stack metadata validation.
@@ -15,6 +17,8 @@
 	static void __used __section(.discard.func_stack_frame_non_standard) \
 		*__func_stack_frame_non_standard_##func = func
 
+#else /* __ASSEMBLY__ */
+
 /*
  * This macro indicates that the following intra-function call is valid.
  * Any non-annotated intra-function call will cause objtool to issue a warning.
@@ -25,6 +29,8 @@
 	.long 999b;						\
 	.popsection;
 
+#endif /* __ASSEMBLY__ */
+
 #else /* !CONFIG_STACK_VALIDATION */
 
 #define STACK_FRAME_NON_STANDARD(func)
-- 
2.21.3


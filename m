Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A602C54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F8020714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IWbgSAf0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbgCYImQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:42:16 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:47726 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726906AbgCYImQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:42:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585125734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8fwXwWjgfvFpCa/LXnsDpuKIOaaCZRr+v9HmG2ULDTA=;
        b=IWbgSAf0A9DlHAt6xPQVcONWCTNYRJcVZ8R2J1v2knznc/AyGV3w/PDKrJmd7W26jvC1YE
        awedYYWTvei0in4uMeQ7KXOVwSZmJsNc+XPw1qMH+6Vdrl2oebBzz8QJLG6fT975XIT9g3
        vRE5vbOB6eqvF0ATqprEbEJoKi3lG2Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-PnqcKxfDN7WNmJpNndfe9A-1; Wed, 25 Mar 2020 04:42:12 -0400
X-MC-Unique: PnqcKxfDN7WNmJpNndfe9A-1
Received: by mail-wr1-f69.google.com with SMTP id f15so811793wrt.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 01:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8fwXwWjgfvFpCa/LXnsDpuKIOaaCZRr+v9HmG2ULDTA=;
        b=GB6p/6sjHdBvSYko9Swt7ZBTkUpFeL+Cd3gj5w7bdNVfwT90baldvTtgLwRHEsapFQ
         2speiiaj4g7L2WGeIm9wDcE+KIVIM1wvSfi72HBewlHxJDz3cMziQ1V+zM21Xm9oK7MJ
         b/MjGEGZiKWJpBn82j4Sfv1baqAxjE4GBL/nbrCce9GRDLm95eb/HuUjq9f9wYDfZcfF
         QHpeADc6Lq8e3/j4kBqUawahwjGsvPMXVzNHIHGf/8iPwBfA7alG3yIQ+FXZterw5RB4
         fJQNTm0M2VApRT3D1tyNvHd84Ob9PkTPh4t3j309/6Ufl63nMEAe/KtYQQr1pttH8DHM
         zvBA==
X-Gm-Message-State: ANhLgQ2AtBno0amM+wpw+7YltQdu1vitMmeaCiz4EOb0h2xmHIpVJhV6
        LY/u0NPxrzdGWi4PzAEesRAoGYzPAF2cSJ5BS6Yh2S05tFpLPNceUza1Mpsr+XmbUndVJltaass
        siFURoUpH4rVQC6WF/b8QkVSl
X-Received: by 2002:adf:9465:: with SMTP id 92mr2203505wrq.122.1585125731613;
        Wed, 25 Mar 2020 01:42:11 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtCB4o+WgoTJ4BiC2oTMAVQV5bLLQTPgkJxOnayugYiLFC2xFic8hHaql40cujwZuyoZCxU3w==
X-Received: by 2002:adf:9465:: with SMTP id 92mr2203485wrq.122.1585125731433;
        Wed, 25 Mar 2020 01:42:11 -0700 (PDT)
Received: from redfedo.redhat.com ([2a01:cb14:58d:8400:ecf6:58e2:9c06:a308])
        by smtp.gmail.com with ESMTPSA id f12sm8055323wmf.24.2020.03.25.01.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 01:42:10 -0700 (PDT)
From:   Julien Thierry <jthierry@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     jpoimboe@redhat.com, peterz@infradead.org, raphael.gault@arm.com,
        Julien Thierry <jthierry@redhat.com>
Subject: [PATCH 01/10] objtool: Move header sync-check ealier in build
Date:   Wed, 25 Mar 2020 08:41:54 +0000
Message-Id: <20200325084203.17005-2-jthierry@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200325084203.17005-1-jthierry@redhat.com>
References: <20200325084203.17005-1-jthierry@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the check of tools files against kernel equivalent is only
done after every object file has been built. This means one might fix
build issues against outdated headers without seeing a warning about
this.

Check headers before any object is built. Also, make it part of a
FORCE'd recipe so every attempt to build objtool will report the
outdated headers (if any).

Signed-off-by: Julien Thierry <jthierry@redhat.com>
---
 tools/objtool/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/Makefile b/tools/objtool/Makefile
index ee08aeff30a1..519af6ec4eee 100644
--- a/tools/objtool/Makefile
+++ b/tools/objtool/Makefile
@@ -43,10 +43,10 @@ export srctree OUTPUT CFLAGS SRCARCH AWK
 include $(srctree)/tools/build/Makefile.include
 
 $(OBJTOOL_IN): fixdep FORCE
+	@$(CONFIG_SHELL) ./sync-check.sh
 	@$(MAKE) $(build)=objtool
 
 $(OBJTOOL): $(LIBSUBCMD) $(OBJTOOL_IN)
-	@$(CONFIG_SHELL) ./sync-check.sh
 	$(QUIET_LINK)$(CC) $(OBJTOOL_IN) $(LDFLAGS) -o $@
 
 
-- 
2.21.1


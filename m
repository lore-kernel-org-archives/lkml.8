Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AECC352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B01D2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SH6/h013"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbgBLTUi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 14:20:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38109 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgBLTUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 14:20:38 -0500
Received: by mail-wm1-f65.google.com with SMTP id a9so3888361wmj.3;
        Wed, 12 Feb 2020 11:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id;
        bh=v00dpEQZvmr0hbUuesFPGJKNn9R41YLAo1Y9071Pc54=;
        b=SH6/h013Ad5Bs7Xej4CYRfWg8JLGso01iNJ8KXmmY5Ix9nkHTEiDljQKsZoE9Rnp6e
         B754XDJPFcr7Yt4vquushComfxMRU2yIiKE78frGUlUmrj47VkjfX6uWkHnCdquI6yDy
         OMZMSvFXrwn1/nsXpAkTRK6aPevFOD5UNY9yt0r7tJyqNi7WuslHdH+5NxXaxTKTSZcu
         ahbokG5ugUvSOgT8j4JFgQ90GSF4b51GdZj3un5XN4VxZbZynjbUuicgNjB33aV4YY67
         8a+IyGdWwiUV6Rl27FvFp6y0hNsgNY6+RXEz9IqMEHrcakridDEY96uATvoeSAx4PJu3
         aqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id;
        bh=v00dpEQZvmr0hbUuesFPGJKNn9R41YLAo1Y9071Pc54=;
        b=DiURn+T12Aj3IoCOHCJ8B6tgqqoSBMnWwVk35mFaXKY5VDYke2P+lrr06dGvQ1sPfL
         WxNE/q2BulMWHYmQN5mwZKT6BZOadfuvgAono9BNh91PtB2xz8F6jZEOZDWpYhIZVziT
         0wd5KHSjBWTm6nPDTolmfCkZr8Lcbn3aPF8ajJxIylB3W1KQGHSgaFCGlDOeKOPSAoHS
         UxF/SLs785mNYZEJAPubGBFW40saba7lcZr2cSQ/vnzGD/zKvrYIhPXMXzftg5y6XVHx
         nOxxcAK8cbYWb6A1Uocqu0ldFHfhvKwuPycvU/fPL42AxWuz7d41CvC/ofN9PUY95nPK
         pL3A==
X-Gm-Message-State: APjAAAWgdbNBW2sETuiJKDJwLbi5HCDwnRYtqqXCXq3h4PxDsOFUXcCv
        KEpN5Lme82uFzCl74OJzqoWq6vpb
X-Google-Smtp-Source: APXvYqwXgPfc2ngIglp9Y5yRLYiVY1BdM08VVvRzhG57ZEx3CVO9dYoPT6mbmrbD6jU0MQPft867Mw==
X-Received: by 2002:a05:600c:2406:: with SMTP id 6mr619742wmp.30.1581535236059;
        Wed, 12 Feb 2020 11:20:36 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id r6sm1654949wrq.92.2020.02.12.11.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Feb 2020 11:20:35 -0800 (PST)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH] KVM: x86: enable -Werror
Date:   Wed, 12 Feb 2020 20:20:33 +0100
Message-Id: <1581535233-42127-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid more embarrassing mistakes.  At least those that the compiler
can catch.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
index b19ef421084d..4654e97a05cc 100644
--- a/arch/x86/kvm/Makefile
+++ b/arch/x86/kvm/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 ccflags-y += -Iarch/x86/kvm
+ccflags-y += -Werror
 
 KVM := ../../../virt/kvm
 
-- 
1.8.3.1


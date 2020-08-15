Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DF0C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B177205CB
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pINu1a9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbgHOWDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728693AbgHOVvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:12 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C14C0F26D5
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 10:37:09 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id v5so3369956plo.4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Aug 2020 10:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3WYA+MRcZZtykG/q4VFvjrVuF0lixiryzbRvGctnpXg=;
        b=pINu1a9Z8jvV2wlSAwofwgFt8WwNyI1VvRWoacqmJB81nfXEzYc2XbqMqAa9fIG6oL
         Ig19mAbu5yJpvG5+RKlsp7BxnzlqabAtR8lK4rzDMM1pVB2NuDmqajqwD+pEtvnGS+zX
         Phkb1Kp7BMleVC9kLnZk1QseNMQTjUIO6Po4sMJXTw+GucVmPFnIXiGHJ8v0hcsG/AqP
         9wMFkmWd3OygzHe5XmHK+dT4lPIQFQ/g6zGqEzQigfFN2drIUiDQ9vatqX+aNsSLDuf2
         blC0bjW8oGxpQteyJzJbaxOXi/JB/06HpzkuabuW3l9eFNdZXVJt+m3eqRxZNWSSYClg
         igxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3WYA+MRcZZtykG/q4VFvjrVuF0lixiryzbRvGctnpXg=;
        b=HwgOQr0J83OtoNm1Z4hHTqRfBjTJBP2xdlFs4Ng1vqdY3EYgtcymo7+zVuvOLT4FKW
         39X036k/eu5BXIn1Fa2BCE7LajEYlADHoUVv0uNRx7kQzAF7CHd+rcBG7Sxob7G6iE5b
         zTV/k4Fv+A8e+Pp6cZloMNQURo3yPKXmYYQkvJA8U1hXHqJU3Jz7UHugzIm9iHZVdkML
         pTQtSla9JP13/1MOUxGfzD/+jIIu0flIn1/MYUP0wQ19cKBHYETiFIqxTk+jFTQLzhMa
         6DQRCcc2xWu3ElrzlfIx2QcBlXDeBagVmX/ZwDgNyxy1MQJXx8aGUEmeDeExkGZWoKbG
         z1YQ==
X-Gm-Message-State: AOAM533HkXjt2huwJxjR6j9Im/RT8H7Wh4q2J+TeiLKFLveyzmkjWmFA
        lBcKuDLER2oVkgcK9CipdfpS7IwWpvQ6xA==
X-Google-Smtp-Source: ABdhPJwjcFvYRspFwrp4C1xN1VrebHSuOSfdaasmGzy35iSykc5pVc5aQhsFaGoLD5BvFRGA9lajCw==
X-Received: by 2002:a17:902:aa82:: with SMTP id d2mr5833816plr.12.1597513028263;
        Sat, 15 Aug 2020 10:37:08 -0700 (PDT)
Received: from gnu-cfl-2.localdomain (c-69-181-90-243.hsd1.ca.comcast.net. [69.181.90.243])
        by smtp.gmail.com with ESMTPSA id b26sm12961860pff.54.2020.08.15.10.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 10:37:07 -0700 (PDT)
Received: from gnu-cfl-2.localdomain (localhost [IPv6:::1])
        by gnu-cfl-2.localdomain (Postfix) with ESMTP id C5A851A0168;
        Sat, 15 Aug 2020 10:37:06 -0700 (PDT)
From:   "H.J. Lu" <hjl.tools@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86-64: Enable x32 set_thread_area
Date:   Sat, 15 Aug 2020 10:37:06 -0700
Message-Id: <20200815173706.2903393-1-hjl.tools@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

X32 uses the common 64-bit syscall interface for set_thread_area.  Tested
with tools/testing/selftests/x86/sigreturn.c on x32.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
---
 arch/x86/entry/syscalls/syscall_64.tbl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 37b844f839bc..670193a73f6e 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -213,7 +213,7 @@
 202	common	futex			sys_futex
 203	common	sched_setaffinity	sys_sched_setaffinity
 204	common	sched_getaffinity	sys_sched_getaffinity
-205	64	set_thread_area
+205	common	set_thread_area
 206	64	io_setup		sys_io_setup
 207	common	io_destroy		sys_io_destroy
 208	common	io_getevents		sys_io_getevents
-- 
2.26.2


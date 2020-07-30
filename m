Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63496C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AA3620809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BMqbLaym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbgG3ShN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 14:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730244AbgG3ShI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 14:37:08 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37147C061575
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 11:37:08 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id b9so14947239plx.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 11:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=48EaftfzmTZBLmMkFzdUMojMZdIQcbrAnw8qi2t2H4o=;
        b=BMqbLaymOrzJinMUG/wVdMBlECk2GjzePlH+34gGt3CbM/banratdk08A5J901lIVo
         uIoSW1FSZJ2Ecj3crkTgAY28lnxvsLrF5xAaE5QhTucCOmYUbjezhboBRmz2wMG6Udmt
         wzOtsncO0fjgHOv9WS9AMpGPCn1HNE0MQq41w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=48EaftfzmTZBLmMkFzdUMojMZdIQcbrAnw8qi2t2H4o=;
        b=l0P8DyePgaQM1CG7MONrjwXbzJEd4P5VEuIHSE5AFByc2viN23uL0rI/MNza46AX9y
         71cUcDPLPtcibN4EF2EdX4lwk93TqkJm9OaoW9+tWHCyZw9cVkjCXdYWaFoIgwky2xuM
         eykO7ftNR67p2+noLq2ystrw3gVxekJeCUrZg/tdzfQ3DPAkZalFdEkUtJ47ZsOuf+Am
         fyp6j2EeVSLr9/+1OG2ED82/cV5Q+TTmoAEJTPh4MAjxWsXsW6xygVSo7keYtV13q3XZ
         vxg0h6WVElRy2gii3azhuJav9wNB0Ivl0HgOd5E2nAt+WxE9y6kIHg14LN5bvsPzADf9
         kVhA==
X-Gm-Message-State: AOAM532Zjvn7WvKFe1a1vBBmq81455Ku01FzsC4xvDVPIQj20gfd+uCz
        0x1yOAT1qDzwjeDGko6rIiArpA==
X-Google-Smtp-Source: ABdhPJzDKESIkF8QnQ2VFqDc+mBNrDD0slry5sD+djVWxhFRRzlCggy9/6M7ixiBMSS5srYub+xAbA==
X-Received: by 2002:a62:7b4e:: with SMTP id w75mr320065pfc.130.1596134227382;
        Thu, 30 Jul 2020 11:37:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f6sm7515046pfa.23.2020.07.30.11.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 11:37:05 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Kees Cook <keescook@chromium.org>,
        WeiXiong Liao <gmpy.liaowx@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mailmap: Add WeiXiong Liao
Date:   Thu, 30 Jul 2020 11:37:02 -0700
Message-Id: <20200730183702.702552-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200730183702.702552-1-keescook@chromium.org>
References: <20200730183702.702552-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WeiXiong Liao noted to me offlist that his preference for email address
had changed and that he'd like it updated in the mailmap so people
discussing pstore/blk would be able to reach him.

Cc: WeiXiong Liao <gmpy.liaowx@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 4e6c169719df..9a3e9b68c430 100644
--- a/.mailmap
+++ b/.mailmap
@@ -296,6 +296,7 @@ Vivien Didelot <vivien.didelot@gmail.com> <vivien.didelot@savoirfairelinux.com>
 Vlad Dogaru <ddvlad@gmail.com> <vlad.dogaru@intel.com>
 Vladimir Davydov <vdavydov.dev@gmail.com> <vdavydov@parallels.com>
 Vladimir Davydov <vdavydov.dev@gmail.com> <vdavydov@virtuozzo.com>
+WeiXiong Liao <gmpy.liaowx@gmail.com> <liaoweixiong@allwinnertech.com>
 Will Deacon <will@kernel.org> <will.deacon@arm.com>
 Wolfram Sang <wsa@kernel.org> <w.sang@pengutronix.de>
 Wolfram Sang <wsa@kernel.org> <wsa@the-dreams.de>
-- 
2.25.1


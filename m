Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9943EC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 13:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605CD20753
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 13:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EC7ZkQr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgDKN3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 09:29:55 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54833 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgDKN3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 09:29:55 -0400
Received: by mail-wm1-f65.google.com with SMTP id h2so5014699wmb.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 06:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P6ApIxfo2aDlkWeR/TZDdFmzYkcPxBAEKEdEW3JJZJU=;
        b=EC7ZkQr2o26VR2RFibT/yRLLPUWI/1VQ2O5/XozszIZcNWC7Ex/kX+OT2aDOXK/vK5
         U8eUF/M/himuKZb1D4VLJsujhHegxT2EcOyvsKf2gMc8UEdjfF50N+3SK5+cUhDPOX0f
         yNcDpKJy9ZURtoNFf9PtJzxgJ8AK40M+a+wBoRDqYKKrmkhuNqb2hbtfqK6bBGy5VlIx
         GAmOcXyCfkOvjUen6Hrvj1ns08HWy9f7npqXvp7io8tb+neyqG0J4g0LAx9nqgy0yj9k
         uTjVEUsu7bLMDPJyzho8Frjbo9nws4Xryk369mj7EPjBKg5Q+dgFv/XqAR/Pic6jPZAs
         kz6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=P6ApIxfo2aDlkWeR/TZDdFmzYkcPxBAEKEdEW3JJZJU=;
        b=hdJDpo+2ZI/jp1JXpx+BCNZu7/D8APrYHq/F0AFG+wMVTTRjCqRfbxmrxfS+WgGeNh
         aFKzlmBepfu2bu5FVtCJbolfZS3En2I5guSrDluHKYEbaXlgyNQLmmjlWc8uyg54xhjp
         U1fTLbn9CMR281DJ4wJiz7WFc3MeynRc/a+pmBj+kh+/taHrVOANDoBJQEQt2UM4wyT/
         pydUGhNcLkWjJinFpAncQ429EtNv898lCFPUxdgnfqhjqhnUrzTKfclkDt06inR+Ecbd
         sh4A4BY+qnlfZ/GIl7oqveQGZUaG2RC7TZnr5H4KmPmwgnX9JSMR4doyZXYQ5j37ydot
         p6SA==
X-Gm-Message-State: AGi0PuaQvvzvXliLSesLn38qwbBnaNo6o7Fb64pckWGCH4Xk/dbiPTCX
        5bUqV3V2DZuhb6vn8XtgL8M=
X-Google-Smtp-Source: APiQypIppj02Oepqz8cbqeIOj/1jTPqGovq6adD1BykznBGoE3KWOPqJq/xaYRF1W7eU35XXG+hnqQ==
X-Received: by 2002:a1c:9aca:: with SMTP id c193mr9641589wme.38.1586611792248;
        Sat, 11 Apr 2020 06:29:52 -0700 (PDT)
Received: from localhost.localdomain (x59cc9a7b.dyn.telefonica.de. [89.204.154.123])
        by smtp.gmail.com with ESMTPSA id m15sm6530483wmc.35.2020.04.11.06.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2020 06:29:51 -0700 (PDT)
From:   Sedat Dilek <sedat.dilek@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH] mailmap: Add Sedat Dilek (replacement for expired email address)
Date:   Sat, 11 Apr 2020 15:29:43 +0200
Message-Id: <20200411132943.18009-1-sedat.dilek@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I do not longer work for credativ Germany.

Please, use my private email address instead.

This is for the case when people want to CC me on
patches sent from my old business email address.

Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index 893266d1f7b0..db3754a41018 100644
--- a/.mailmap
+++ b/.mailmap
@@ -249,6 +249,7 @@ Sakari Ailus <sakari.ailus@linux.intel.com> <sakari.ailus@iki.fi>
 Sean Nyekjaer <sean@geanix.com> <sean.nyekjaer@prevas.dk>
 Sebastian Reichel <sre@kernel.org> <sre@debian.org>
 Sebastian Reichel <sre@kernel.org> <sebastian.reichel@collabora.co.uk>
+Sedat Dilek <sedat.dilek@gmail.com> <sedat.dilek@credativ.de>
 Shiraz Hashim <shiraz.linux.kernel@gmail.com> <shiraz.hashim@st.com>
 Shuah Khan <shuah@kernel.org> <shuahkhan@gmail.com>
 Shuah Khan <shuah@kernel.org> <shuah.khan@hp.com>
-- 
2.26.0


Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3603C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A792D20678
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMEAZZqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgHaSXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgHaSXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:23:01 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C96AC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:23:01 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g14so7078954iom.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Rn6ycFTT7j3FIqN8R6S3S3PsphEhlFWvPxNHVqNSr4=;
        b=iMEAZZqIY7zpTKl5uiXXhul6/cvOwqEkTTtkShqqIcHEkzr5Rdu9Ax1l9vzXCn4jsr
         /vDWvhe3ejpq8lorb7c6uQ71h9CIWozsWXlvo6ApWKaGPdgP9oBRq4vz45esdwN8OLHs
         CLNQJqi7kwASxSyUDKLzZA8zEfYPEXZll+vbsDFKeziDQJ5JmVOy8xWvQyRne+lTWoKK
         TH0OPTOB0FoTDv8UZwHq5AbQl3uFEavEIhfdFEtPfCrUI5WNXq7uGN3ZrqyzZUsH+ySy
         pu2QaUoqxjMr02Y2SNnJa+Hce3juSsuIH9fouV9Ejkcq/RjwZsGR+40RVMozNGT9W2Lv
         5hIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Rn6ycFTT7j3FIqN8R6S3S3PsphEhlFWvPxNHVqNSr4=;
        b=SR/iE5IiAfz1XFIjEDcee97rK+mSu4ny5j8BN17wSPkckyUBeGskqlllCWGcgpQE7Q
         /i1GO7prxEx0zF6gC8qdjulFXOaxjGYMWRgaqPLiTz+EqJyZeYh3CQqEcTXe/lGNsP1D
         BHoq6Z8X+lXkt7FMAsPB6fx1ETz/R/SNrOV0jjXM5X3j+1IgvGhQdl8xePHQ/pX7WDEW
         ENOajrsSSV4eQA03RVbsfQTJeFfocA+X1nQ4rSNo957WJkdnck7ldbJ7z7BuNie5mvrg
         4HHJoFCZK2Xau5vhRXq4gCmX0PEi+lNDYcT5fIyabuhtf86SOVCNB4udtZYDys3lIecD
         wR/g==
X-Gm-Message-State: AOAM530/ukccoocuF2kdFrCMpq47l6Asc9NJTW8317y467XiEwvLSdvb
        Kx0HPKmiU8jDedmqQtob5GA=
X-Google-Smtp-Source: ABdhPJzUqBj7jvOefaWGSfaesaMbvapH2uhvCVr/AYjt+orGYY8OUESB7SNTwJlvJTlBZH+b4uQ0EA==
X-Received: by 2002:a02:9a0e:: with SMTP id b14mr2451017jal.22.1598898180505;
        Mon, 31 Aug 2020 11:23:00 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8203:5970::dc2e])
        by smtp.googlemail.com with ESMTPSA id p18sm4129017iog.1.2020.08.31.11.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 11:22:59 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v3 0/3] dyndbg: cleanups for 5.9
Date:   Mon, 31 Aug 2020 12:22:07 -0600
Message-Id: <20200831182210.850852-1-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3 items for v5.9-rc
  fixed width format %3u in debug output - cosmetic
  fix export: ddebug_exec_queries -> dynamic_debug_exec_queries
  fix format="foo bar" parsing

Jim Cromie (3):
  dyndbg: give %3u width in pr-format, cosmetic only
  dyndbg: refine export, rename to dynamic_debug_exec_queries()
  dyndbg: fix problem parsing format="foo bar"

 include/linux/dynamic_debug.h | 20 ++++++++---
 lib/dynamic_debug.c           | 67 ++++++++++++++++++++++-------------
 2 files changed, 59 insertions(+), 28 deletions(-)

-- 
2.26.2


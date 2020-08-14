Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4310AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 03:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1963520838
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 03:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tfz-net.20150623.gappssmtp.com header.i=@tfz-net.20150623.gappssmtp.com header.b="bu8dsCQK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgHND5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 23:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbgHND5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 23:57:12 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAE3C061384
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 20:57:12 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id n129so7308843qkd.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 20:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tfz-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5MTuDeV+j3fzgYR5SGPLvxT4ilKSMnNxei9P2lIEnWw=;
        b=bu8dsCQKjF9Ov1Nw/qa5ydaYlZbu9Dh6UcAUBcJTG+6J6AyB2e+pghxSPQTGxvMXmN
         XgviDf2W8ZDKqcRpdH5TvHcp+8GApJWFRHcEQ6S7IJXUnssSYf2dR9SWehMkLbAT1wUQ
         9UZXldPpU5EV/UCSMyOkw2IToGLNbo7hbaUmnAOjUhKVZaQzXhCBaEnP5usyxGLZO5by
         wch6njTGkPo3xSmEXOPemOmVWFz8sOXB99nynjJ1Z29b6FQfh/hqjnx+xEh8eq48VoW9
         kgGwTdhfawQmH/3mx2OmEyZevcwsSLEiEhgZ4uTIh9S1L/l1mN6hbeOj2E4Nb68IKO7q
         LF4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5MTuDeV+j3fzgYR5SGPLvxT4ilKSMnNxei9P2lIEnWw=;
        b=nLKrXxJEV2NLT1merUyjeXCFHKd4k3qP1AehKvhpOczvyC3+NOQGjgZy+fsfi46DSS
         H8UOTESiniGVa8qQLzZqSSeLexZy6oLwfFHXFORBrEtw1QATHkBD9gZgzPY5fKwoaZOj
         5hHE9t2LUC20bLe6RvkGPvvQpe+3KJQJ0XWJ7w3vu6F+VqjZM11+kf6mcTvSNkfDzCey
         5mSsVBbI2baxJPL9at/2bVTgklzk8XAMHH92O9KhRV+te04qt87HK9RojgZ4oUu2KrMZ
         8qTxH+xZrC8Av9ozPLwjOrupaPuS+cBG3xp24S3HhcyQh46ed8nP3qLsbxyoLMEQx66A
         McFg==
X-Gm-Message-State: AOAM532xM4x25drGbn91QBCLLoFMJSVTv7OkSMYHmD017QaRTHTOpHai
        Rc9BG3kLtPTOpouyqeRi+0fMp6ufII3iAmOe
X-Google-Smtp-Source: ABdhPJwgDgLg7M2DAbRGUL+XBzE0jRtctTh0Je1JKmoNwZ7TJym5ipZUwDFbNJ2SYTiezA6zG1uDlA==
X-Received: by 2002:a37:5b41:: with SMTP id p62mr387011qkb.369.1597377431112;
        Thu, 13 Aug 2020 20:57:11 -0700 (PDT)
Received: from foo.attlocal.net (108-232-117-128.lightspeed.sntcca.sbcglobal.net. [108.232.117.128])
        by smtp.gmail.com with ESMTPSA id k11sm7229460qkk.93.2020.08.13.20.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 20:57:10 -0700 (PDT)
From:   Pascal Bouchareine <kalou@tfz.net>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Alexey Dobriyan" <adobriyan@gmail.com>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Jeff Layton" <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        "Pascal Bouchareine" <kalou@tfz.net>
Subject: [PATCH v4 0/2] proc,fcntl: introduce F_SET_DESCRIPTION
Date:   Thu, 13 Aug 2020 20:54:51 -0700
Message-Id: <20200814035453.210716-1-kalou@tfz.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a first attempt at taking Alexey's comments into account

This goes against v5.8

tl;dr in commit 2/2 but motivation is also described a bit in
https://lore.kernel.org/linux-api/CAGbU3_nVvuzMn2wo4_ZKufWcGfmGsopVujzTWw-Bbeky=xS+GA@mail.gmail.com/



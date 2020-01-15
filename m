Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BA6C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAC6924656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="EqtZjz+g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgAOSmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:42:01 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41907 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbgAOSmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:42:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so19696509ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 10:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iyWBDBGdPhZMQqYEB7vExUBhfJttJz4+TuTF/gXP4z8=;
        b=EqtZjz+g7EGskQnkixkXn9XrbxTLYToHq+lcUM1leSzTLzazIwT6Rm17EJTEo2I7dn
         /jMMXg6VTujHKsduqV5l/DgLUBmXuJjmqd4akcNhygAVtHa+vWcYPrTzl/kiuM+PacAz
         Wz703GEgGoSEeSwRpyWsEJIXkN8U1RGXyZzNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iyWBDBGdPhZMQqYEB7vExUBhfJttJz4+TuTF/gXP4z8=;
        b=idz68XJLi4jR6I0A+m2ADvGVS4nznmzL8Vy7bAfVyGFh5QRmfsUM2o3TI0KJrtOSqV
         l8zPn0GqxSbxfc1ydB3bpo4NoyONxFZdnQF2+RUUuSXkTJ+6yuVtYWyGlTjX9OhzbX2T
         SATMFeCnowtY66nHnxs2+/Q3ILRJ0M68oE2tlT/n2EVFnMyQhBSng9qt4YK7TV+qwpZ4
         7CWva+824ClVOkGX9AbS2hf9y7HvUv2mnkNGlciHxKu9rVFNnYM4GPrUZWOLJVw5BaUg
         KhpdxDbJsaVaJ2iorinoXjGTOZSCQNhFNcdnZCF3TQB7Ykl4MAehaEfAQUVlA/3iL44l
         azFA==
X-Gm-Message-State: APjAAAXxgcMcC6A7y9s/6YEs+Unzrq3CAoFD9UqHQsLc5rNjPnwC3+jU
        PQuzsA8sMXtA+7N8dmBjN6mtSA==
X-Google-Smtp-Source: APXvYqyqABOunYj/IZj2k+iyOWWbdohNgjhwotUJCn697R4NTNgOCDdJd8PW7LvAjczU2mx6qAtEfw==
X-Received: by 2002:a2e:8eda:: with SMTP id e26mr2776311ljl.65.1579113717180;
        Wed, 15 Jan 2020 10:41:57 -0800 (PST)
Received: from prevas-ravi.prevas.se ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 21sm9598631ljv.19.2020.01.15.10.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 10:41:56 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 0/5] a few devtmpfs patches
Date:   Wed, 15 Jan 2020 19:41:48 +0100
Message-Id: <20200115184154.3492-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 fixes a mostly theoretical problem, but as this is core code,
the pattern might be copy-pasted, so it might as well be fixed. The
remaining ones reduce memory footprint a bit by initifying a function
and factoring out common code.

Rasmus Villemoes (5):
  devtmpfs: fix theoretical stale pointer deref in devtmpfsd()
  devtmpfs: factor out setup part of devtmpfsd()
  devtmpfs: simplify initialization of mount_dev
  devtmpfs: initify a bit
  devtmpfs: factor out common tail of devtmpfs_{create,delete}_node

 drivers/base/devtmpfs.c | 79 ++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 40 deletions(-)

-- 
2.23.0


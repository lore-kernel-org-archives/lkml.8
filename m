Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA23DC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 23:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 846C9206B6
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 23:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O0IcU9Q2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgEaXPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 19:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgEaXPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 19:15:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD592C061A0E;
        Sun, 31 May 2020 16:15:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x13so9680883wrv.4;
        Sun, 31 May 2020 16:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vIearGxk3ZqXd39XhTqhmtb9TyeaDJW1sODG6p1nwS4=;
        b=O0IcU9Q2IOyOCqVJhLxIldhe+aBNEd8HnT5bHIcVSmcrJp3a3D5jUm+NhzGa6K70uY
         fI8QggY0IHt/xMqv6ZbnVbLNPDd0orewS5ke2i9+fl8gdv/EyZZB0Zg6jYuCx+Zfo+ou
         NA4dkiPZ3ibMWz6txHAuxZAIn6nUl8nQFh1Sz9Z6v/E71W4Jb9lCQGvp9D+4ofJ18BEs
         av922/+wYoBElM8L+1pdy13mw6ysMzVIm33lWsXiCCKsWy0eM6cWC0foLYtbhyDWdcis
         hTPd02D7lGcnd9EjUlifTax9EJNIZa8byobvwWHH8aW520xTdnk/yEXjyk8oKF/JBbL8
         BATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vIearGxk3ZqXd39XhTqhmtb9TyeaDJW1sODG6p1nwS4=;
        b=bnn/z9g0MiJV+9JDp0aUwQ0ULKRH4Bo/MxJ5sK7iQHqZeE0hplbp4VNYn0dVC7lIGe
         rQblJWSwJEhfokocjH9A08kkTGXeopdgpXPpc6nl6ZgybAEyZ+jzSC9Ru9jSmylVoU2D
         zrKjdv0V1X/qjZzjNhjYbjNf8TjUCZF9kBpfWWawo6aCBy6XL/oo9Pbob/Y1vE/6ETRh
         gVcUj5BFm+MvxFtX9yaZ4GkIOwmeKGfxQEqi+zjm4SKCzNpf18Cy6zxFmmpgU3H9bG+G
         AsDJw57p7SaHIux225eyJy5F5scXOW+f4sR3UNb4qtQffPDfj9h9oEwVTedylJdzU28O
         gHOg==
X-Gm-Message-State: AOAM533y1jcb2I3vBBRtI7xOjRr35fhJfTR0Du/20LHn1rSCyFpmyTPA
        RBI356ViKx1sCvYKn43w/69pHzmwcmU=
X-Google-Smtp-Source: ABdhPJyA5gLKCjjEL9PDOrZp8rzWThxY9Io+fG4mRBA1RofhhCbqvEdT7P1k9zLtJYrtp7/ZkPW0fQ==
X-Received: by 2002:a5d:4ec3:: with SMTP id s3mr20516784wrv.103.1590966935448;
        Sun, 31 May 2020 16:15:35 -0700 (PDT)
Received: from localhost.localdomain ([46.114.110.83])
        by smtp.gmail.com with ESMTPSA id i74sm18588878wri.49.2020.05.31.16.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2020 16:15:34 -0700 (PDT)
From:   Sedat Dilek <sedat.dilek@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vitaly Wool <vitaly.wool@konsulko.com>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>
Subject: [PATCH] mm/zswap.c: Fix typo accept_threshold_percent in Documentation/vm/zswap.rst
Date:   Mon,  1 Jun 2020 01:15:25 +0200
Message-Id: <20200531231525.10180-1-sedat.dilek@gmail.com>
X-Mailer: git-send-email 2.27.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, I switched over from swap-file to zramswap.

When reading the Documentation/vm/zswap.rst file I fell over this typo.

The parameter is called accept_threshold_percent not accept_threhsold_percent
in /sys/module/zswap/parameters/ directory.

Fixes: 45190f01dd402 ("mm/zswap.c: add allocation hysteresis if pool limit is hit")
Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
---
 Documentation/vm/zswap.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/vm/zswap.rst b/Documentation/vm/zswap.rst
index f8c6a79d7c70..d8d9fa4a1f0d 100644
--- a/Documentation/vm/zswap.rst
+++ b/Documentation/vm/zswap.rst
@@ -140,10 +140,10 @@ without any real benefit but with a performance drop for the system), a
 special parameter has been introduced to implement a sort of hysteresis to
 refuse taking pages into zswap pool until it has sufficient space if the limit
 has been hit. To set the threshold at which zswap would start accepting pages
-again after it became full, use the sysfs ``accept_threhsold_percent``
+again after it became full, use the sysfs ``accept_threshold_percent``
 attribute, e. g.::
 
-	echo 80 > /sys/module/zswap/parameters/accept_threhsold_percent
+	echo 80 > /sys/module/zswap/parameters/accept_threshold_percent
 
 Setting this parameter to 100 will disable the hysteresis.
 
-- 
2.27.0.rc2


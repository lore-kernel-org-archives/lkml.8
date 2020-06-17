Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014DDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0BDC212CC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHueoL6e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgFQTSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 15:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbgFQTSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 15:18:49 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E012C06174E;
        Wed, 17 Jun 2020 12:18:49 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n2so1369783pld.13;
        Wed, 17 Jun 2020 12:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=W/Xf3bmFylXPA0/Ku6n2kmtAEIVKn/C+zo5fkI8WJZo=;
        b=HHueoL6emGfjIzlbwjbMvftTk32wDHhgohFoOYYybjTrJO+tGLX+7oz7EWCBwKfCl4
         Q8RxPs5TI0HpyIZcb4dWh5xzGKSq6m48vpEUICpbaafegqlHm6xfurM6yGm6xw7JyJri
         m6WqPnGDCfl1p9adKC8OlO1QSJuwFi0ivJW61d4XoqUEkFDD++QSZ3/mkaVcAa05wAcj
         aGm2InRrrlzVg4e3KvUrJrvv+MBzmMN475I5kXlo6Wg9CJo7IczJ6Ldp+rl1DDY5wQBv
         3ASxCtUvSHSxhlV9lHc2m3v8O05m6AqbZbrYsgXoPbx+lbUYrU3gj+BJOCUa+IgD15yJ
         6lDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=W/Xf3bmFylXPA0/Ku6n2kmtAEIVKn/C+zo5fkI8WJZo=;
        b=Og0b24dn3uT8tc0rtohWPMy88RUtNj26Dy2lZr7WGeKXNB5sL0WVM5vhU7YWY9lOpT
         ZElvvTG9wjwIQ1FKSaI6E6yMWztOkTIwaq45aaD125x2NZWQcUH2jnribQDRXW3/cId8
         i1wABq/86Eoi8xSYssIh7H17Y9sxLgSZ8jSMZ00tzABXuyGH7OkkesbVdxfdR0n50+v8
         Wr4tQPezKGoZRq5uAl/xo2Q1jq4eg9yurmzsVC2xl8rOSYG6hURb2wCCGeMfX1F+hMV9
         FAWDQWfxYGn/W2tpKFTK448nSHcHUPjCLa6mG60othast6D4zIPVhElQx1qzaw/53bjL
         OCeQ==
X-Gm-Message-State: AOAM533EPAzmw+J90gQNji4EUcJiUUHvAA91AeDrLc9Xpa23tEhdotby
        lEX4PsyxkghAKIgUKZiHW7g=
X-Google-Smtp-Source: ABdhPJzAu5Yu0qRuGhCUgdqB5mDjjwjEDzVQf65Xnb1CFi6m5/cYKAYbr4TDUoIiElq+MvN5rYhA/g==
X-Received: by 2002:a17:902:9342:: with SMTP id g2mr575203plp.36.1592421528265;
        Wed, 17 Jun 2020 12:18:48 -0700 (PDT)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.182.224.179])
        by smtp.gmail.com with ESMTPSA id z8sm309548pjr.41.2020.06.17.12.18.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jun 2020 12:18:47 -0700 (PDT)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     corbet@lwn.net, akpm@linux-foundation.org, jack@suse.cz,
        kirill.shutemov@linux.intel.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH] docs: mm/gup: Minor documentation update
Date:   Thu, 18 Jun 2020 00:57:03 +0530
Message-Id: <1592422023-7401-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now there are 5 cases. Updated the same.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>
---
 Documentation/core-api/pin_user_pages.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/core-api/pin_user_pages.rst
index 6068266..7ca8c7b 100644
--- a/Documentation/core-api/pin_user_pages.rst
+++ b/Documentation/core-api/pin_user_pages.rst
@@ -33,7 +33,7 @@ all combinations of get*(), pin*(), FOLL_LONGTERM, and more. Also, the
 pin_user_pages*() APIs are clearly distinct from the get_user_pages*() APIs, so
 that's a natural dividing line, and a good point to make separate wrapper calls.
 In other words, use pin_user_pages*() for DMA-pinned pages, and
-get_user_pages*() for other cases. There are four cases described later on in
+get_user_pages*() for other cases. There are five cases described later on in
 this document, to further clarify that concept.
 
 FOLL_PIN and FOLL_GET are mutually exclusive for a given gup call. However,
-- 
1.9.1


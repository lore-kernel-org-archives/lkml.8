Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61D5C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 22:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62186252CD
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 22:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jp/pG79P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730774AbgFUW2G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 18:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730202AbgFUW2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 18:28:06 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9489EC061794;
        Sun, 21 Jun 2020 15:28:04 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a9so17137550ljn.6;
        Sun, 21 Jun 2020 15:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ajumZEuWGqqfpvz5AIi0K5R6F27nfu1zPZ2heqoGEwU=;
        b=Jp/pG79Pnk2/NRLy8xIPgPY3fJK5fxhfma2voYkdeSszDzSDocMuYBJ/A4KFtrkN1X
         Miw++FXOgfk7NKwF0ZhhF7T8GWeiUlOzHlanZ/eruJ0ZIRZTBHrgOvwqhtFmlRzpQG6O
         TiSDrbiPbfQ44M/bqqnVYox+pLZui0AJPMTLfxkIrUKFbYw6mUHP9uDfO8S5youbVe3Q
         qbOxpEfnFC93wLtuYmL85SxLPREK7wEEf5aRwdwY3BfeGKuDW/lTu68hf0s5N7dD+dlW
         ZcoVtn1Xbk+zoXUoaLQaBhdsfgSfwUIe4DYqmt/B+rrI2cLJt5MFAVVuVUt/04H8ZEQV
         SknQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ajumZEuWGqqfpvz5AIi0K5R6F27nfu1zPZ2heqoGEwU=;
        b=QdfKfYsxhqhOe3tvywZBihX0ZXMoqz/KQqWRVOIzr+tY1FD9A9sORhQ/C9HyXDH42w
         rPHy6B/9qBkCmwBvQIZumDFOpivV8YRxhL9Ybt6I3+P29UriwWwAVHY0upioanrJ15YY
         csUF1wgdB7DRTzMP4/jUVC19U79jfyk0d/7Fnw+jUvlgi49gEGUhlaHz62VB/++Bkj0i
         69XM+4FnllCl6zcZ6zyGzZgB2aE6Pl/Nggfd/bfBbmTAWyhMItm+N1+1fwFvm6clEJae
         TV0fLpy+THseZ5F+JjlM2m74MB8u1wGjU/WRQclF6l8PBLJOO9/X0fhWcMdSpjD/GnuV
         zK2Q==
X-Gm-Message-State: AOAM533GAL793HPfkn19Np2JBpdqwOj//n6cRzXjg70sqr1ysl4R8zGB
        rqeU5QUPepBiMNmHY8/a5gE=
X-Google-Smtp-Source: ABdhPJzfiAaD32dKdmMh4jARJjfOqTgw+ry8KlCcvWUtzi4c7FUARN+iWGm9seMlIWMWZ/W1ofixwg==
X-Received: by 2002:a2e:910c:: with SMTP id m12mr7391997ljg.332.1592778483168;
        Sun, 21 Jun 2020 15:28:03 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id 11sm2361295lju.118.2020.06.21.15.28.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 15:28:02 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Improve descriptions of a few simple-panels
Date:   Mon, 22 Jun 2020 01:27:40 +0300
Message-Id: <20200621222742.25695-1-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a follow up to [1], which was already applied to drm-misc and then
Laurent Pinchart spotted some problems. This series addresses those problems.

[1] https://patchwork.ozlabs.org/project/linux-tegra/patch/20200617222703.17080-8-digetx@gmail.com/

Dmitry Osipenko (2):
  drm/panel-simple: Correct EDT ET057090DHU connector type
  drm/panel-simple: Add missing BUS descriptions for some panels

 drivers/gpu/drm/panel/panel-simple.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

-- 
2.26.0


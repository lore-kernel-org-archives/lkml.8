Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CB2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4916206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSoehG0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgFHJk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 05:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729184AbgFHJk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 05:40:58 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78FDC08C5C3;
        Mon,  8 Jun 2020 02:40:57 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r15so15805001wmh.5;
        Mon, 08 Jun 2020 02:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+F6VpU2DhJ38D1OzhvVOMkYO64zmbpsjhAiXZI8h3vs=;
        b=iSoehG0/Vz0/hFRBTy05XlPZguWhE683LXK3Skhpl3x5As15/po8UkSHDk2lk6nX8s
         EmfTIGxZrRzy+4Uca9R+I+lMk+JJxO3pNYIKfGX3M1SHybTaTwQodmZK/e5QQjH3apXb
         bjYRtAiGQhKAH6ksUDm69xag6askBl3VCWymf/c94eoGYsBLlEsrhMmyU5sJ67PqcxTr
         gYo6AGAKfXOjpMVuQAcG8+RqQV7WapOqkbXqQCK1NLL4ysw+n/WlrdzAdYYGMFB2iuLt
         oQKy8A7deCvfHilqoP1TXjVWcSElvG3lhEVBjqOWdLkk/n+7n4+c++GQx9oZ5+w8zVTD
         5VbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+F6VpU2DhJ38D1OzhvVOMkYO64zmbpsjhAiXZI8h3vs=;
        b=gWVQuPDZww8z3u0gnZLuZzEnXY3XwnrBzIko1iIAVxN1KJhYZ7ajOV4bwpTb4tDqfz
         U4b8nAaI0RoH+Z7GzsusZADroSe3uzwo5FmgyOktlcIexW7rdQi/QC96ghngl8VG6LX4
         0or1iWa1GKojAZS0WE+ChSCKFpF6gD+jyY+vTi9rekJkupZE7WBQh/wCwTP//l3ZdFp+
         In4dO5z2P8qr2o0cPHwSH6rFT5HwA9QYmIvZwhX2NQ+63BFexPbgFdC95LfsvHisbIw1
         0b9T0KeXNKol6G8TQ7ThMyrO7RZaEsznZWWwvms4LzxxLbkfQeuQY16UOIxGRgO6z9Ef
         F6ng==
X-Gm-Message-State: AOAM530E9aPSPnf63Gfw4FjBkabde3ijPtjSMVYJG0yIZLXC8nG4IXzD
        2uIAh8GEotqsKDiqgYL9bXI=
X-Google-Smtp-Source: ABdhPJwwSZuP+bLORdgzdVpGe4oKaJlyNkuAUhDK5qX4qEIjzSeAk+d6t6RgsEH1l8fS5REb59KWjg==
X-Received: by 2002:a1c:f401:: with SMTP id z1mr14952827wma.44.1591609256454;
        Mon, 08 Jun 2020 02:40:56 -0700 (PDT)
Received: from skynet.lan (28.red-83-49-61.dynamicip.rima-tde.net. [83.49.61.28])
        by smtp.gmail.com with ESMTPSA id a3sm22096479wrp.91.2020.06.08.02.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 02:40:55 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     tsbogend@alpha.franken.de, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, jonas.gorski@gmail.com,
        linus.walleij@linaro.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH 0/2] mtd: parsers: bcm63xx: simplify CFE detection
Date:   Mon,  8 Jun 2020 11:40:51 +0200
Message-Id: <20200608094053.3381512-1-noltari@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of trying to parse CFE version string, which is customized by some
vendors, let's just check that "CFE1" was passed on argument 3.

Álvaro Fernández Rojas (2):
  MIPS: BCM63xx: add helper function to detect CFE
  mtd: parsers: bcm63xx: simplify CFE detection

 .../include/asm/mach-bcm63xx/bcm63xx_board.h  |  6 ++++
 drivers/mtd/parsers/bcm63xxpart.c             | 28 ++-----------------
 2 files changed, 9 insertions(+), 25 deletions(-)

-- 
2.26.2


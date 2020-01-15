Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5711C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BAF7206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 10:12:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rF8UEv4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbgAOKMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 05:12:47 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38244 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729539AbgAOKMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 05:12:47 -0500
Received: by mail-wr1-f67.google.com with SMTP id y17so15149203wrh.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 02:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=TphKRKgrx6UOwY938/z3zkU7XoFubfFhJvJRyw+ELVA=;
        b=rF8UEv4+aHXN5U+ib7xcboRlT+K7H1VEqquEq+m7pEpwSQMFWwyN7guzslCrJoBYLW
         b10OFL9WAPXXzizMArolKJSTLMvixZKpY52I7fDJeykkuO8Dbgki9oDi/vmP6GCjUZtB
         xAXe20p9DG1M0X6Oo+c9IuhxHXQbgTq8Don5pILBFCXzx4gViqvNJ4XjJIzU39GpcF5N
         QKksBAP5PAhksnj6Lx65spoPDoEBaph9dLDVYRbkwhGUqkkYVjP6+TnMhf/bNHby0aJA
         9cO0GNII3uAE/jeHtsQoUeDtSVto0vEbEXh0MTbtkTHHPbRRCw/A9llmThD+IyBlYfOd
         dfDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TphKRKgrx6UOwY938/z3zkU7XoFubfFhJvJRyw+ELVA=;
        b=R5SEoLQgiAxI0CIzCETThKgnGIZmqxrmKhEBgGBfhbNwwxW0TqNgincQqWZX2dvdFJ
         W9+KdKlH+XPX8US6wY/Df9qkx+jne43aBT1yDkbp9b8aksmBKZBVOOPxEuIw6y6n5wrZ
         0uGtjpKICSjT3qmtp0vOyhmc0/jNATOzjng4EJZFA3wt89ylS6fh1oflKZRkHZ7NQzZo
         xTV4q3hr8Ow9l5vIHcXcCqXOegyoBNwDKs0fi2SOUsGcuv16a73HRwf1KXJQgw/Wdv+I
         XOfamApnmJfBSpQr5zCNs/FGaboebLAlDA/3Ksiw96D7Ev9/1V34JDgA4RIaLwho3YH7
         zZ9g==
X-Gm-Message-State: APjAAAWhlPQUvQLhUWheP1IPnH6hbhJwx3G/SGsF1gzncjFOrMXw2K4S
        Cr+bsn7MOEFUchnf2SKEwz0jBg==
X-Google-Smtp-Source: APXvYqyiJAvF67CsgbnfTuZzZ394kjvs04rbDKyhZy7BpSwsCoiFjVC73kNMLzdKqGiznx/yeOH5YA==
X-Received: by 2002:adf:ed83:: with SMTP id c3mr29669763wro.51.1579083165363;
        Wed, 15 Jan 2020 02:12:45 -0800 (PST)
Received: from glaroque-ThinkPad-T480.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g7sm23828223wrq.21.2020.01.15.02.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 02:12:44 -0800 (PST)
From:   Guillaume La Roque <glaroque@baylibre.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org
Cc:     johan@kernel.org, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, khilman@baylibre.com
Subject: [PATCH v7 0/2] add support of interrupt for host wakeup from devicetree in BCM HCI driver
Date:   Wed, 15 Jan 2020 11:12:41 +0100
Message-Id: <20200115101243.17094-1-glaroque@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add interrupts and interrupt-names properties to set host wakeup IRQ.
actually driver find this IRQ from host-wakeup-gpios propety
but some platforms are not supported gpiod_to_irq function.
so to have possibility to use interrupt mode we need to add interrupts
field in devicetree and support it in driver.

change sinve v6:
- depracate host-wakeup-gpios 

change sinve v5:
- add tags

change sinve v4 [1]:
- add patch to update Documentation
- use of_irq_get_byname to be more clear and move call in bcm_of_probe
- update commit message

change since v3:
- move on of_irq instead of platform_get_irq

change since v2:
- fix commit message

change since v1:
- rebase patch

[1] https://lore.kernel.org/linux-bluetooth/20191213105521.4290-1-glaroque@baylibre.com/

Guillaume La Roque (2):
  dt-bindings: net: bluetooth: add interrupts properties
  bluetooth: hci_bcm: enable IRQ capability from devicetree

 .../devicetree/bindings/net/broadcom-bluetooth.txt         | 7 +++++--
 drivers/bluetooth/hci_bcm.c                                | 3 +++
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.17.1


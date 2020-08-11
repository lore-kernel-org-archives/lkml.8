Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FE2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2905C2078B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnGiFeMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgHKPBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728801AbgHKPB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:01:27 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02268C061787;
        Tue, 11 Aug 2020 08:01:27 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id c80so2878553wme.0;
        Tue, 11 Aug 2020 08:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q8s0DvqKHUDOgwL+41LR/o2tBL7BQpYDVvLQhOyKNmE=;
        b=MnGiFeMtI8YJG+KhcK1nZQBYvSHiryie4h22btJkI+1ErbBDAu9T6Bi0LWr7w6UbCM
         1OrLNjigQjPvkPQKLou7TfZdhGAnSKAzRZGc1ZxmDl+6qBj/PeyUgxcs04z1wuehrYHc
         THc7vR5gtKjl9yIclQcCVbnuXO+l4JvuKfiLBzAHy/4heiX883plaxMkfmDI2ONVDP9t
         o4tUOvwEnOHM96927ZAPvgDrgfCDWrB1O/R42bidsQb1IDRwXFSg+p7AwNi4YnC17ea1
         yZD6+x9EVYYks1Qq5iTYB3hHU2gh315YlbfqdGNIxlUmGxZFibey0bxu0TGIs+Dqqtyj
         xzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q8s0DvqKHUDOgwL+41LR/o2tBL7BQpYDVvLQhOyKNmE=;
        b=YWehnzDihruiVj0bQHs+zv5hHBxbkt1UFYzrFHYznl2OXTD8oCacEAPxUi9lOwFWLR
         BMSPh3jYH9HbqK49veKe5GYdoIGS6b52ZtVjNCOvx4xboK32qzvNpQHrJq0W3LPmMe44
         8OYPWD6mUhFP6qerxhXhlp6okMBfu6cvTL8BW/PUPwzWHmzzmuy9VMGxHTHw40sIZ+1g
         7Tq/Iu92rEFNnO8HmWHPBH6pMoA8iMpf9nlcDz+SvoMRqwMNB6TfSi0XTLya4R98AnDR
         PGI13ZoU1MtpLn/Jk9WMJtVM6fxGG+weuF3lkpP3xNVqsQW65hbMOwB/P/kXn7cxLRwV
         Fy3w==
X-Gm-Message-State: AOAM532fdhBfKZEsqOfAgN13kf2/K/9gk78pvFyW6aT/y0ojWa5yOvCu
        fO5J6PzF905rgOmqRZanp4A=
X-Google-Smtp-Source: ABdhPJwm++OYHVlMJdIp4ElGM7WtMsr9nZSTihomZB0DeFdy60BJb3DpEj9ZnpyPy0GA8QB0sqcIRQ==
X-Received: by 2002:a1c:1bc4:: with SMTP id b187mr4273141wmb.175.1597158083703;
        Tue, 11 Aug 2020 08:01:23 -0700 (PDT)
Received: from skynet.lan (88.red-83-49-60.dynamicip.rima-tde.net. [83.49.60.88])
        by smtp.gmail.com with ESMTPSA id 15sm5350494wmo.33.2020.08.11.08.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 08:01:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     tsbogend@alpha.franken.de, f.fainelli@gmail.com,
        jonas.gorski@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        linux-mips@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v3 0/4] MIPS: BCM63xx: board improvements
Date:   Tue, 11 Aug 2020 17:01:13 +0200
Message-Id: <20200811150117.254620-1-noltari@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Theses patches improve BCM63xx board declarations and source code.

v3: Reword DWV-S0 board commit description to avoid possible confusions.
v2: switch to SPDX license identifier.

Álvaro Fernández Rojas (4):
  MIPS: BCM63xx: remove duplicated new lines
  MIPS: BCM63xx: remove EHCI from BCM6348 boards
  MIPS: BCM63xx: enable EHCI for DWV-S0 board
  MIPS: BCM63xx: refactor board declarations

 arch/mips/bcm63xx/boards/board_bcm963xx.c | 625 +++++++++++-----------
 1 file changed, 306 insertions(+), 319 deletions(-)

-- 
2.28.0


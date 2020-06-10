Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC3AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C2952067B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioj0E5CL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729562AbgFJOJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgFJOJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 10:09:04 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E115C03E96B;
        Wed, 10 Jun 2020 07:09:04 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id x6so2406722wrm.13;
        Wed, 10 Jun 2020 07:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3F1gyxKHBurPb/9ok1v4N24kKX2n+9TWOucrfqchLWY=;
        b=ioj0E5CLNbfjs5oCFAoQKIzYeZBkUzsBNDPcTEesJcSJ6K2WjEvS0sIXyNdZBne2fA
         YVFOwVpX6Kvagq0fqimlc2N6UHRM3yksJYSb7cdJeqS69EwbPc7lWT+HhdtAD/Sl8MoY
         LCK4KOoGz/PNI2oe94EnCJZhuHdMPSJZrfkrCERMqgfai5qijCfK4HEipycaa+0Q1CZb
         jU1hc5X10bIoud+iLtWn8xlol613jWOuAg/hpOKsShywXzBWw8RLjXFtn4XT5b+9hCSC
         G03APnvbzi4imW3NZmsUKI/D10zqfJWQqo+3rNODPeenxyc17qu4TDyRwkaMioqpAhUc
         eK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3F1gyxKHBurPb/9ok1v4N24kKX2n+9TWOucrfqchLWY=;
        b=RrFYsjk9leu5TjRiTyB93r40aixrwBx7dO3hQO/T43qxqfSp9+gcyTvo+N9QHKuZuh
         F8m83/ozqVnHlDuRz8MY2K7SXCaF+MaKd0tFHbb1JXsmSB5GK7gdB5pdIlAVyaDxZ4T8
         o/UBnyhsEgaPekF+KfQAoJOxRxiOC9WcI4PGvSbdj2pMU063HN+4bbpR9RyTvClIPaoc
         nR+hSIKRlZFMiG4f2kFE1c6vYRI6ts9aR7Z2zGtdqGoDamCRj3IKCzIrsrnvuSpOXmzM
         G+cGB4yeRZG6IaIh0x4DJ0kONQF6/lHDry22K74uEB+YIsfmSXOGQYtGdnncU0Ob+atG
         O3HA==
X-Gm-Message-State: AOAM530kiFixfLw1KmRSFT1tj5+FdXPcEZ2JvFOnCM3790Sm3erqGTSh
        WstyicpFmz16gzV7IF6reIY=
X-Google-Smtp-Source: ABdhPJz+sj/GScpXnuaN0U+4nlhrlDJQgiftq51b43NZYNgW3u6u9jGX7pG3KxZLtkZNex4KR2PtwA==
X-Received: by 2002:a5d:4bcb:: with SMTP id l11mr4180112wrt.363.1591798142300;
        Wed, 10 Jun 2020 07:09:02 -0700 (PDT)
Received: from skynet.lan (28.red-83-49-61.dynamicip.rima-tde.net. [83.49.61.28])
        by smtp.gmail.com with ESMTPSA id r5sm8565883wrq.0.2020.06.10.07.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 07:09:01 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        julia.lawall@lip6.fr, f4bug@amsat.org, jonas.gorski@gmail.com,
        lkp@intel.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v2 0/2] clk: bcm63xx-gate: add BCM6318 support
Date:   Wed, 10 Jun 2020 16:08:56 +0200
Message-Id: <20200610140858.207329-1-noltari@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200609113049.4035426-1-noltari@gmail.com>
References: <20200609113049.4035426-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the gated clock controllers found on the BCM6318.

Álvaro Fernández Rojas (2):
  dt-bindings: clock: bcm63xx: add 6318 gated clock bindings
  clk: bcm63xx-gate: add BCM6318 support

 .../bindings/clock/brcm,bcm63xx-clocks.txt    |  2 +
 drivers/clk/bcm/clk-bcm63xx-gate.c            | 44 +++++++++++++++++++
 2 files changed, 46 insertions(+)

-- 
2.26.2


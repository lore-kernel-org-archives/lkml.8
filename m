Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EFBC10F26
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 06:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DACF620736
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 06:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cvOyUgm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgCWGxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 02:53:34 -0400
Received: from mail-wr1-f49.google.com ([209.85.221.49]:40984 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgCWGxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 02:53:34 -0400
Received: by mail-wr1-f49.google.com with SMTP id h9so15488387wrc.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 23:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=wGDd6myf+GdHCozxtrhmVLjHaTI84rSVkvwPMbf2b58=;
        b=cvOyUgm3MfUe3yvKUo5aJ1XPsi8hi07U2PZdZJHUC+l7JhpHg/ZEBxJ+h1nY84FsqI
         Di2wMDfKuZbHvQcV6aOX/CIP+n+BcgERrqB2X3Nu4/8JcPE4c8ZmvmaSEw2C44p66rF8
         O7kcYXct7EuBmdOGVfdzqc7lOAISg7+5BQLs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wGDd6myf+GdHCozxtrhmVLjHaTI84rSVkvwPMbf2b58=;
        b=tpRKSrqnErdHFWtRnjMbY4DWiMVCTmpkqwTPqYjz9d19jOT74L155ahJbCg2zzbAiV
         siOoxt7n84FfEF069XIW0w/wtQtGDIzCAla8ZQxm7J7hHpYGwpXgj9VK9uNvYrK+LRYY
         pdC1HLL5pO3f7lMcxtUjaCeJdoaMreqH+oJdpjpZeJcGarCJwFdv4/XVJM58sR7eabPc
         RrOaVcle+LrX+sPYInS5CyJ8DydxFrmdZjltSD1PL/64c7lPSy++K5MIreFDsbOkbrRZ
         IJHSTelGRg82i7pNwUAk7NVWqbHIdSK7n7xEAiqiog6q+95eSfk8IN1bQmVY3SSKuOmM
         5f9Q==
X-Gm-Message-State: ANhLgQ3rEMtf5zRl00RsMMVYLaHLyF1HNfG6jjulICrFydMpza3TeC9R
        /cF/C5/CBkDHO7MWi5tsJLg2vg==
X-Google-Smtp-Source: ADFU+vvwB0MywmLuH1Zm77A5oLo0Gs8q6wjwWuZhQExQclt1yA8E1xmrBOZA/+OlJRl7ZFtCTqdUtA==
X-Received: by 2002:a5d:6245:: with SMTP id m5mr28064980wrv.154.1584946411935;
        Sun, 22 Mar 2020 23:53:31 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id g128sm21127453wmf.27.2020.03.22.23.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2020 23:53:31 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 0/2] Handle return value and remove unnecessary check
Date:   Mon, 23 Mar 2020 12:23:16 +0530
Message-Id: <20200323065318.16533-1-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series contains following changes,
1. Handle clk_get_rate() return
2. remove unnecessary check of 'duty'

Rayagonda Kokatanur (2):
  pwm: bcm-iproc: handle clk_get_rate() return
  pwm: bcm-iproc: remove unnecessary check of 'duty'

 drivers/pwm/pwm-bcm-iproc.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

-- 
2.17.1


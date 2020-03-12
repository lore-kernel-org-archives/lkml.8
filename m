Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F50C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4699720637
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="YSPFRA/M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgCLWdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:33:14 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34554 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgCLWdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 18:33:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id z15so9656863wrl.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 15:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8cdz1LFOuab0jNRbzTq73NrqK6B+wszwWghkMP0+ST4=;
        b=YSPFRA/Mj5hu1kq6SzfqDihHCyZ3cPjjL2R3uOgcx667Cs8k5bOZQ4keT8vtZBMPs3
         4tC5YK+bcY4lIubGuJ+oZIDqrz8rbNw01mKIEJThYNZMhw6sS2SwXOYk12MLbALHeTwn
         7wkeaigHRRe4wJNdc7SVB/D4erJ2kUxD9SssI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8cdz1LFOuab0jNRbzTq73NrqK6B+wszwWghkMP0+ST4=;
        b=gFBBKl7ipUHfWyr3yWrqepl7TFl4jfEyFBoA57iIn7cEP6BbvYd9tEYm2v0aYnddWI
         GNf78dqliJs2emQugSH2PUWKJGxHyWh24gowkUctXnVpaXJMwP6asCtg/ynzzZoF8K9i
         GBFbwt9+FA6JtamW6Uvc6fgVvNMYmP/sAzLlcmJPUfOd2cAlhPhL/hQP9nN08PrGsFdT
         9Fqc7C+jglVrpf7t2A3urICrP1lef9uEBptylcs5l2Tppv/u6mwx2IRSihg9BHAJ+Fql
         lotfaaLQB7k7cYuQviwO5DtysBLUXp2urNvlxqH+Ghtfy/ixalSvXuziBdz/dhm7vGDh
         WDOA==
X-Gm-Message-State: ANhLgQ3r1g9haRctU0TnZ7mrHiNcDI4iAUIZ/QqWSy5TuejQI8Gq4nZz
        rL7FD31j2nbiU8xxZ1n5WO8bNg==
X-Google-Smtp-Source: ADFU+vuNtV0lnm2+jA+dT1T640PomcvSoaj/op5jgEAEK0wuosbYcrQa5xp8y5tBq843mAikSXiPyw==
X-Received: by 2002:adf:f0c8:: with SMTP id x8mr14128631wro.58.1584052391455;
        Thu, 12 Mar 2020 15:33:11 -0700 (PDT)
Received: from kevin-Precision-Tower-5810.dhcp.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id o10sm2964144wrs.65.2020.03.12.15.33.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Mar 2020 15:33:10 -0700 (PDT)
From:   Kevin Li <kevin-ke.li@broadcom.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Ray Jui <rjui@broadcom.com>, Jaroslav Kysela <perex@perex.cz>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Stephen Boyd <swboyd@chromium.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Kevin Li <kevin-ke.li@broadcom.com>
Subject: [PATCH v2 0/2] ASoC: brcm: add dsl and pon chip audio driver
Date:   Thu, 12 Mar 2020 15:32:42 -0700
Message-Id: <20200312223242.2843-3-kevin-ke.li@broadcom.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200312223242.2843-1-kevin-ke.li@broadcom.com>
References: <20200312223242.2843-1-kevin-ke.li@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in v2:
 * Make the comment a C++ one for license header
 * Remove all empty functions
 * Change all variable to use kernel coding style
 * Comment chip TX RX block independently generate I2S bus signals

Kevin Li (2):
  ASoC: brcm:  Add DSL/PON SoC audio driver
  ASoC: brcm:  DSL/PON SoC device tree bindings of audio driver

 .../bindings/sound/brcm,bcm63xx-audio.txt     |  29 ++
 sound/soc/bcm/Kconfig                         |   9 +
 sound/soc/bcm/Makefile                        |   4 +
 sound/soc/bcm/bcm63xx-i2s-whistler.c          | 317 ++++++++++++
 sound/soc/bcm/bcm63xx-i2s.h                   |  90 ++++
 sound/soc/bcm/bcm63xx-pcm-whistler.c          | 485 ++++++++++++++++++
 6 files changed, 934 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/brcm,bcm63xx-audio.txt
 create mode 100644 sound/soc/bcm/bcm63xx-i2s-whistler.c
 create mode 100644 sound/soc/bcm/bcm63xx-i2s.h
 create mode 100644 sound/soc/bcm/bcm63xx-pcm-whistler.c

-- 
2.25.1


Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4039C35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C41A2085B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580894712;
	bh=TumeFDM0fvtGTEAm7W6578sIPHxL+K790G+Ov6vJCqE=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=crkjQs340alSsyKtYI/0eMCvjdzr8pC1ij9RbqxABp9UlEiGbvDRVUsjXfBeBnl4j
	 g82sQfvUlVJY4UJ8iqrJJTB471Pq8TI8lGsSFg1/yV7CvJSw5aH3n6hU/0NP6dSz4P
	 RqX99xvss9NJeB8c7thUBw4W2rjq48rCkynUeO0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgBEJZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 04:25:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45047 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728072AbgBEJZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 04:25:11 -0500
Received: by mail-wr1-f65.google.com with SMTP id m16so1697961wrx.11;
        Wed, 05 Feb 2020 01:25:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1GUaCOJa702fQ2iGRrFBDUSf0RUTl2ZOZotP0GxnSwI=;
        b=ROXqsEj29qPvBQlkPFEeyzqz/mfEcvCNqTE2ENRlJ5EGlO86mlM36AI07UbLRfv8qN
         sEN+gfOKX6AhZZzA+dgZGonL8UEV+XeHjr+iftVjDgRWRXqVmS5aj4mTdqKd5GiAGbsv
         WWpPJsrKRsyL5e5pmHliXxJfeWY9RcUCjfkp5BlEilEljWXLBZ/zSyISBVWxX404V000
         1cZKeMEpBpeN61fyL13fbr1WS1YqjxqQtEumHXNOkKbL2vTddXjp5pRv6uIngcXf1J/u
         4830+kLIHmQTErzn4DxN6BNGo1i1raa/NGOCvfqGSL+miZKXpy1/B42WqeXu6TQvbvd+
         5ZTA==
X-Gm-Message-State: APjAAAX8ElKCeQ8DXs7WQd28B28aqBTHOWunr+srppudWHTCc5z1iG+z
        oWHq27ll/xcv/gEAeaqH4KqzK59d6g==
X-Google-Smtp-Source: APXvYqwoIr+4SCpI/A/eu8U2cd5Kox4SouHrFbf7j9q6XsmrTWoCBq9952gU7b5YrBg/lxDwN0n37Q==
X-Received: by 2002:adf:ea88:: with SMTP id s8mr27313556wrm.293.1580894707502;
        Wed, 05 Feb 2020 01:25:07 -0800 (PST)
Received: from rob-hp-laptop ([212.187.182.162])
        by smtp.gmail.com with ESMTPSA id y131sm7774804wmc.13.2020.02.05.01.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 01:25:07 -0800 (PST)
Received: (nullmailer pid 1471 invoked by uid 1000);
        Wed, 05 Feb 2020 09:25:06 -0000
Date:   Wed, 5 Feb 2020 09:25:06 +0000
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] Devicetree fixes for v5.6
Message-ID: <20200205092506.GA31689@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull a couple of DT fixes for rc1.

Rob

The following changes since commit 33b40134e5cfbbccad7f3040d1919889537a3df7:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2020-02-04 13:32:20 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-fixes-for-5.6

for you to fetch changes up to 04dbd86539fd2f0a65fdd5a0416b7f6606f95e16:

  dt-bindings: Fix paths in schema $id fields (2020-02-05 09:14:57 +0000)

----------------------------------------------------------------
Devicetree fixes for v5.6:

- Fix incorrect $id paths in schemas

- 2 fixes for Intel LGM SoC binding schemas

----------------------------------------------------------------
Dilip Kota (1):
      dt-bindings: PCI: intel: Fix dt_binding_check compilation failure

Rob Herring (2):
      dt-bindings: phy: Fix errors in intel,lgm-emmc-phy example
      dt-bindings: Fix paths in schema $id fields

 Documentation/devicetree/bindings/arm/fsl.yaml                    | 2 +-
 Documentation/devicetree/bindings/arm/qcom.yaml                   | 2 +-
 Documentation/devicetree/bindings/clock/bitmain,bm1880-clk.yaml   | 2 +-
 Documentation/devicetree/bindings/clock/fsl,sai-clock.yaml        | 2 +-
 Documentation/devicetree/bindings/clock/imx8mn-clock.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/imx8mp-clock.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/milbeaut-clock.yaml       | 2 +-
 Documentation/devicetree/bindings/clock/qcom,dispcc.yaml          | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gcc.yaml             | 2 +-
 Documentation/devicetree/bindings/clock/qcom,gpucc.yaml           | 2 +-
 Documentation/devicetree/bindings/clock/qcom,mmcc.yaml            | 2 +-
 Documentation/devicetree/bindings/clock/qcom,rpmhcc.yaml          | 2 +-
 Documentation/devicetree/bindings/clock/qcom,videocc.yaml         | 2 +-
 Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml      | 2 +-
 Documentation/devicetree/bindings/clock/xlnx,versal-clk.yaml      | 2 +-
 Documentation/devicetree/bindings/hwmon/adi,ltc2947.yaml          | 2 +-
 Documentation/devicetree/bindings/iio/adc/adi,ad7124.yaml         | 2 +-
 Documentation/devicetree/bindings/iio/adc/adi,ad7192.yaml         | 2 +-
 Documentation/devicetree/bindings/iio/adc/microchip,mcp3911.yaml  | 2 +-
 Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml | 2 +-
 Documentation/devicetree/bindings/iio/dac/lltc,ltc1660.yaml       | 2 +-
 Documentation/devicetree/bindings/input/gpio-vibrator.yaml        | 2 +-
 Documentation/devicetree/bindings/pci/intel-gw-pcie.yaml          | 4 +---
 Documentation/devicetree/bindings/phy/intel,lgm-emmc-phy.yaml     | 4 +++-
 24 files changed, 26 insertions(+), 26 deletions(-)

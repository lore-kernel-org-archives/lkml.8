Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2339AC83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 049072073E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nlfgv/lw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgD3IZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 04:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgD3IZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 04:25:07 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5DEC035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 01:25:07 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u16so857489wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 01:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=X6kBmgjWNGdoNWM+7HP6Cv8RL/gtxXSH0Zcy+2SUkTg=;
        b=nlfgv/lwGO9u4M/cSd8s6bWYEd60n1HD9hX4RDYFeI6OM5b5/NS+Th7J2Udh6Fer0k
         DgjCL6hq1Oe0dnPWSx2KED3KQCkEicF3F5fi4lbzX9RmkUUJ87uaGgCm0d3AMzH3WoIi
         RJCIpL5QPBeAVE+HBDQEd1DUJFUotoDiX/5diJOFhvDrFX1xaXwYusiT4xUiclcepUHk
         DY8FIUfbfAQReWU0N0sy92dKJXOjkifLiGUuD8U3CbGdljXWWevYVVfdvlMQhO9zlirS
         yZ9TOFMBupFXFOzWg9N3ZCMfzM2AKi3GawTxnx1UEzRPRtAHEZ2lCSj+XFa3L/GlJj1K
         gF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=X6kBmgjWNGdoNWM+7HP6Cv8RL/gtxXSH0Zcy+2SUkTg=;
        b=g97Wdi588rUcslq3QIMest2FaymHeHF/btVKmG54BjY75YwhHjSnWnMGhgIMdgajAQ
         moGYz/ZSsLtLB5CAFIvf2A/u025BLfUx78rlQ80AE14RR7njgeTqq+yImaLxXw2LNchO
         g6D7GikcE1BQBaFCTvJng6W106WITg7AL3MA0GtGvk0G6AK6tCOc1I78FsHe4BmLWi7+
         B0vrMIgDHrbjdRLs7coSXO0jKEN6D+yhDVQyi91PpCaYPlyCuQDf7kKMSYp9sPutfMZ+
         O0kI9C+cDl7mOJUSyqvr/SxinH+FUZUCy51tAtlA4Gg/XEXmjqAJwhUURNlC1M9cEoY5
         fSWQ==
X-Gm-Message-State: AGi0PuYMAsR60NamdrMzIyEDyrduP8mpS4UNyxmJq/jv4aTPIG1GOzoW
        iRiWz8oVcDH3rbyFC4XnGnqo2A==
X-Google-Smtp-Source: APiQypKS6rkdhsHbc2UUSlH3zD912MOA6ZFRvxtjDMHneZ8QIX90PvJVdV6AmPOLALep6jeYDNbP1Q==
X-Received: by 2002:a1c:4e12:: with SMTP id g18mr1649275wmh.11.1588235106039;
        Thu, 30 Apr 2020 01:25:06 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id u7sm12108468wmg.41.2020.04.30.01.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 01:25:05 -0700 (PDT)
Date:   Thu, 30 Apr 2020 09:25:03 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org,
        devicetree@vger.kernel.org, arnd@arndb.de, robh@kernel.org,
        andriy.shevchenko@intel.com, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        yixin.zhu@intel.com
Subject: Re: [PATCH v7 0/3] Add Intel ComboPhy driver
Message-ID: <20200430082503.GA3118@dell>
References: <cover.1588230494.git.eswara.kota@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1588230494.git.eswara.kota@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020, Dilip Kota wrote:

> This patch series adds Intel ComboPhy driver, respective yaml schemas
> 
> Changes on v7:
>   As per System control driver maintainer's inputs remove
>     fwnode_to_regmap() definition and use device_node_get_regmap()
>     
> Changes on v6:
>   Rebase patches on the latest maintainer's branch
>   https://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git/?h=phy-for-5.7
> Dilip Kota (3):
>   dt-bindings: phy: Add PHY_TYPE_XPCS definition
>   dt-bindings: phy: Add YAML schemas for Intel ComboPhy
>   phy: intel: Add driver support for ComboPhy
> 
>  .../devicetree/bindings/phy/intel,combo-phy.yaml   | 101 ++++
>  drivers/phy/intel/Kconfig                          |  14 +
>  drivers/phy/intel/Makefile                         |   1 +
>  drivers/phy/intel/phy-intel-combo.c                | 627 +++++++++++++++++++++
>  include/dt-bindings/phy/phy.h                      |   1 +

Why have you sent this to me?

>  5 files changed, 744 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/intel,combo-phy.yaml
>  create mode 100644 drivers/phy/intel/phy-intel-combo.c
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog

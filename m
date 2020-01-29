Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E58EC35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 16:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1500E206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 16:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="nGONfZBo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgA2QWO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 11:22:14 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:47951 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgA2QWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 11:22:14 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 3E07E23E62;
        Wed, 29 Jan 2020 17:22:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1580314931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sW0QA5hhkf7I3N3KjWQhrGatYUrwYHEsrUcrrXuwzR4=;
        b=nGONfZBo+MF8xCLtL+W9xgTLviPkQ+YDRjN+oRs6Tn1xY19psXusVp50c7JK9RFxA10UBl
        b56t/s+eKqvLn47ys13ldz1LMXHNuCqEX2BkSKYnucZvCVoizVI/xFNRv38YAwoY5o03aV
        PSnFrGTI9QaP8nmrRYNOQYhMF+cj4HY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Jan 2020 17:22:07 +0100
From:   Michael Walle <michael@walle.cc>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Yuantian Tang <andy.tang@nxp.com>
Subject: Re: [PATCH v2 0/5] ls1028a: dts fixes and new board support
In-Reply-To: <20191209234350.18994-1-michael@walle.cc>
References: <20191209234350.18994-1-michael@walle.cc>
Message-ID: <d5a729321220f35bd0ea377a8ec2f852@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.8
X-Spamd-Bar: +
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 3E07E23E62
X-Spamd-Result: default: False [1.40 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[8];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

Am 2019-12-10 00:43, schrieb Michael Walle:
> This series adds basic support for the Kontron SMARC-sAL28 board. It 
> also
> adds missing nodes to the ls1028a base device tree which are used by 
> the
> board.
> 
> changes since v1:
>  - dropped "arm64: dts: ls1028a: add FlexSPI node" in favor of:
> 
> https://lore.kernel.org/lkml/1575457098-18368-2-git-send-email-Ashish.Kumar@nxp.com/
>    Thus, this series now depends on that patch
>  - better commit message for the TMU patch
>  - added fixes tag to the TMU patch
>  - document the LS1028A evaluation boards compatible strings
>  - document the Kontron sl28 boards compatible strings
>  - fix node names of the sl28 device tree(s)
>  - removed device specific compatible string of the spi flash
>  - rebased the patch series
>  - integrate the RGMII configuration of the AR8031 PHY since the 
> binding is
>    now already upstream
> 
> This patchseries depends on:
>  - [Patch v2 1/5] arm64: dts: ls1028a: Add FlexSPI support
> 
> https://lore.kernel.org/lkml/1575457098-18368-2-git-send-email-Ashish.Kumar@nxp.com/
>  - [PATCH v2 1/2] dt-bindings: clock: document the fsl-sai driver
>    
> https://lore.kernel.org/lkml/20191209233305.18619-1-michael@walle.cc/


it seems that all the pieces are now together.

  - "arm64: dts: ls1028a: Add FlexSPI support" is pulled
  - you've already pulled the patches 1 and 2 from this series
  - Rob reviewed patch 3 and 4
  - your review remarks of patch 5 should be included
  - and last but not least, the clock driver used by the device tree 
finally
    made it into clk-next [1]


-michael

[1] 
https://lore.kernel.org/linux-clk/20200128220445.DE778207FD@mail.kernel.org/



> 
> This patchseries superseeds:
>  - [PATCH 0/4] ls1028a: dts fixes and new board support
>    
> https://lore.kernel.org/lkml/20191123201317.25861-1-michael@walle.cc/
>  - [PATCH] arm64: dts: sl28: configure the RGMII PHY
>    
> https://lore.kernel.org/lkml/20191123202624.28093-1-michael@walle.cc/
> 
> Michael Walle (5):
>   arm64: dts: ls1028a: fix typo in TMU calibration data
>   arm64: dts: ls1028a: add missing sai nodes
>   dt-bindings: arm: fsl: add LS1028A based boards
>   dt-bindings: arm: fsl: add Kontron sl28 boards
>   arm64: dts: freescale: add Kontron sl28 support
> 
>  .../devicetree/bindings/arm/fsl.yaml          |  45 +++++
>  arch/arm64/boot/dts/freescale/Makefile        |   4 +
>  .../fsl-ls1028a-kontron-kbox-a-230-ls.dts     |  27 +++
>  .../fsl-ls1028a-kontron-sl28-var3-ads2.dts    | 106 +++++++++++
>  .../fsl-ls1028a-kontron-sl28-var4.dts         |  50 +++++
>  .../freescale/fsl-ls1028a-kontron-sl28.dts    | 174 ++++++++++++++++++
>  .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  44 ++++-
>  7 files changed, 449 insertions(+), 1 deletion(-)
>  create mode 100644
> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-kbox-a-230-ls.dts
>  create mode 100644
> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var3-ads2.dts
>  create mode 100644
> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28-var4.dts
>  create mode 100644 
> arch/arm64/boot/dts/freescale/fsl-ls1028a-kontron-sl28.dts

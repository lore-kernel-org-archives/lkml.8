Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DA7C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE8A9208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583917371;
	bh=23cfMjij0qcBZlWnralLu2AGBY/YdFpxzNPldyRcKbI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nQlJxAF+xHEo1diu+jNnAanWBcW2J0dVl4SYI79+YXdrrzGh3m3VxgDkbIk1PEark
	 xcpUNp1ZCjNcGYKGdiI8alZJMAsxHJ4NHroJbZDb9P3Gu4WLh+xMaYGM0aZ+vRJ5nC
	 XaaA5biwWQ2/VikU6LsPAyprITwvOLhv9XwufzLc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgCKJCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 05:02:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728150AbgCKJCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:02:50 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3597020873;
        Wed, 11 Mar 2020 09:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583917370;
        bh=23cfMjij0qcBZlWnralLu2AGBY/YdFpxzNPldyRcKbI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y6Cz2SHfUoMJnre2zw3Ay9x5+RsW1JBv28aF3xb56rLcWRsEZ1TW/FShfBT1kHqvp
         j25Dw4dJ0cixneKL2fNm+7SEAfnHfDLF3+5o7xF43toyPwbsVRN42EaLj59Hdodbj3
         HVU5L0GtOHcOEzNZACiH67GFg7g1qJ0835vYEzZQ=
Date:   Wed, 11 Mar 2020 17:02:42 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Han Xu <han.xu@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] arm64: dts: enable fspi in imx8mm dts
Message-ID: <20200311090242.GI29269@dragon>
References: <20200306101957.1229406-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306101957.1229406-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 04:19:57AM -0600, Adam Ford wrote:
> Pull in upstream patch from NXP repo to:
> enable fspi in imx8mm DT file
> 
> Signed-off-by: Han Xu <han.xu@nxp.com>
> Signed-off-by: Adam Ford <aford173@gmail.com>

I reworded the commit log a bit and applied patch.

Shawn

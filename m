Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8983BC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 05:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4398D21532
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 05:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599541544;
	bh=h7ulyY1ECSDj4DDRDKfQHLDqzFTyxT+YLVGkU/FGt9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fO5agtKcBmcPv+c5dv3fOB5n7hw3c/kLvveiQ7X8FfV8IlUpWmR3LxbaPHqgfBQLH
	 9TU2qgGr4MeIGK1/qiVzXDe4ljumwO/PiAw7Ca7BVcbpYxZ+vPncpgDfoGBojB3Ic0
	 2UF/D9Xo0Ct7dN7Dv6moU36lNjqFmg6sju7SPZy4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgIHFFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 01:05:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbgIHFFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 01:05:41 -0400
Received: from localhost (unknown [122.182.239.242])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C78C52078B;
        Tue,  8 Sep 2020 05:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599541540;
        bh=h7ulyY1ECSDj4DDRDKfQHLDqzFTyxT+YLVGkU/FGt9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aQu+Rfz1DrAR4iOec0oxzm/Bo5DICB8wxSsSGsiUVq8aoA/W0XMDD4FyeRs+QF52o
         JXmO/tViJ7UQ0OjjkC3ttz1w+lLllt32XOIO5voC0e4QHKpocmPgxoXkg6ntT7Qxh0
         AJvUuo3rZRbvNOk/dXBxBzZ4gm65HVk/BYAmMNRc=
Date:   Tue, 8 Sep 2020 10:35:33 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Swapnil Jakhade <sjakhade@cadence.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mparab@cadence.com,
        yamonkar@cadence.com, tomi.valkeinen@ti.com, jsarha@ti.com,
        nsekhar@ti.com
Subject: Re: [PATCH v2 0/7] PHY: Prepare Cadence Torrent PHY driver to
 support multilink configurations
Message-ID: <20200908050533.GB77521@vkoul-mobl>
References: <1598534932-18693-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598534932-18693-1-git-send-email-sjakhade@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-08-20, 15:28, Swapnil Jakhade wrote:
> Cadence Torrent PHY is a multiprotocol PHY supporting different multilink
> PHY configurations including DisplayPort, PCIe, USB, SGMII, QSGMII etc.
> Existing Torrent PHY driver supports only DisplayPort. This patch series
> prepares Torrent PHY driver so that different multilink configurations can
> be supported. It also updates DT bindings accordingly. This doesn't affect
> ABI as Torrent PHY driver has never been functional, and therefore do not
> exist in any active use case.
> 
> Support for different multilink configurations with register sequences for
> protocols above will be added in a separate patch series.

Series looks good to me.

> This patch series is dependent on PHY attributes patch series [1].

I did not see any obvious depends in the series, if it is not maybe good
to rebase and send without dependency

-- 
~Vinod

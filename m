Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCD0C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 02:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D93D620737
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 02:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588128414;
	bh=i/beAvLFST2zpd8Kzs30/5TtRc3y6I9BsrZ9LT5jD3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gNt6Wm4958l9ac6RjlD3EJCZk5INNkN3oHO0LuJAMAR/6W9ogc9iQKxfMj8rZRlk2
	 wD7Ax7dLgtLgHNubX5QXgVOQTV7p+HhhMqiA3bGi2FL6JjCHBjtVngK3CGyJ2yt9pH
	 BJ0FhpuVj+sv9TEC0BsktWHE9XS3rIwm6EJZrRo4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgD2Cqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 22:46:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:34354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbgD2Cqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 22:46:51 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF90920737;
        Wed, 29 Apr 2020 02:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588128411;
        bh=i/beAvLFST2zpd8Kzs30/5TtRc3y6I9BsrZ9LT5jD3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oE44iFbDA8l5+pIUkhCjvjYqB3CdLOo/xE3SJ8scLw3NEE072VFMwIBKna8Zp83Lb
         C8ShYMGnDpmHXZu1b7J0dLvuNylBH8rUoVEbochDChE5OMu4jmzu8lUaAgsQEr70pd
         Zosytjw13rZFSlK5kcODISxdnWNTzC9zIFD9nl38=
Date:   Wed, 29 Apr 2020 10:46:45 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Matt Porter <mporter@konsulko.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: imx8mm: specify #sound-dai-cells for SAI
 nodes
Message-ID: <20200429024644.GL32592@dragon>
References: <20200415185941.13956-1-mporter@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415185941.13956-1-mporter@konsulko.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 02:59:41PM -0400, Matt Porter wrote:
> Add #sound-dai-cells properties to SAI nodes.
> 
> Signed-off-by: Matt Porter <mporter@konsulko.com>

Applied, thanks.

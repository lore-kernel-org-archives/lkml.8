Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AC1C3B188
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 02:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CB320848
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 02:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581560153;
	bh=BhAo+bHiXSzouzI5WjYsSlJggo3+A6czgmic9kjkb3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PfLE1wYPib518wQf3Pv2hBVpRGm3tWC9KHKZPBu4hND5kMpUvGAf34kycMMKTe7Ov
	 Gmm0GwULs84NMZRN7Kh8X6uKNncicjn3niisV+e5Jzy+TquXWgIrXpHvsymPfHNyJV
	 WtK3J1ecG/F1Ia4/mHTZ1vsXMAxFI9gcj7KMAcGA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbgBMCPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 21:15:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729333AbgBMCPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 21:15:52 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68C13206DB;
        Thu, 13 Feb 2020 02:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581560151;
        bh=BhAo+bHiXSzouzI5WjYsSlJggo3+A6czgmic9kjkb3M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=exaMeRmcsOQVSOOG1R8CFHDzhaO98ueDgBiIaz6eYrD/9aaPnP9Sg8StcONSSxq+5
         BSjoTnDaBc6Et01CWUScAV/BIl9G+yEEAuwKMwQHkEUUnZ+i6u+NUNF73eVUW1eAzy
         WH5b5zNfvpI41THVywCRioDXeRHaYD5xLFM0eJvs=
Date:   Thu, 13 Feb 2020 10:15:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6dl-yapp4: Specify USB overcurrent
 protection polarity
Message-ID: <20200213021545.GI11096@dragon>
References: <1579101448-7247-1-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1579101448-7247-1-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 04:17:28PM +0100, Michal Vokáč wrote:
> After reset the oc protection polarity is set to active high on imx6.
> If the polarity is not specified in device tree it is not changed.
> 
> The imx6dl-yapp4 platform uses an active-low oc signal so explicitly
> configure that in the device tree.
> 
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>

Applied, thanks.

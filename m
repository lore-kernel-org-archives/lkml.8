Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42011C5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1967420771
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584532666;
	bh=uRZr4oAGUYpa/zMNUOyXMVp4EE8BZgWJcULU8/46dck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sH7h24P5IwcynyQBfrjOie/gPd2cCqWAwsaU76YX7PW1PgCh55pkyRZzddx7bQs2+
	 eHqyJ7Iplxnlal1B3L/3N5mxcMVbE9AKDw576s2oK0DJM8Zu80TaoiyMPcRYPZI9rf
	 /M07lPcRBO2p9aJknEuKspFrPS/wc1OZaYzsLLfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgCRL5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:57:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:36208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbgCRL5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:57:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B71E2076D;
        Wed, 18 Mar 2020 11:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584532663;
        bh=uRZr4oAGUYpa/zMNUOyXMVp4EE8BZgWJcULU8/46dck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Pok+J3YfTd5yAUdDjx3qd9+ynvghnEcR2sEOqWnjNbEUAG+d7lJLSmkghOm3bgCMN
         QhRYILNaFz/PfpVSn1+rNIScO18EEraEsA+elQICORe38tU1nXRd5i/AB4X9RXeoNY
         whl4hv5sHdYVUbFkFlUfLHioK2HDm3aqmhpboW7U=
Date:   Wed, 18 Mar 2020 12:57:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     chanwoo@kernel.org, myungjoo.ham@samsung.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] extcon: Remove unneeded extern keyword from
 extcon-provider.h
Message-ID: <20200318115736.GA2508254@kroah.com>
References: <CGME20200217103927epcas1p2f0cf3c28dbc78d991ef8f4895e4717dd@epcas1p2.samsung.com>
 <20200217104728.29330-1-cw00.choi@samsung.com>
 <20200217104516.GA94720@kroah.com>
 <28e13524-7879-e40a-1585-cba1dca4cda7@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28e13524-7879-e40a-1585-cba1dca4cda7@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 08:05:40PM +0900, Chanwoo Choi wrote:
> On 2/17/20 7:45 PM, Greg KH wrote:
> > On Mon, Feb 17, 2020 at 07:47:28PM +0900, Chanwoo Choi wrote:
> >> The commit tb7365587f513 ("extcon: Remove unneeded extern keyword
> >> from extcon.h") removes the unneeded extern keyword from extcon header
> >> file. But, The commit tb7365587f513 has missed that deletes 'extern'
> >> keyword from extcon-provider.h. So that it deletes extern keyword
> >> from extcon-provider.h.
> >>
> >> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> >> ---
> >> Dear Greg,
> >>
> >> When I removed the unneeded extern keyword from extcon hearder file for
> >> v5.6-rc1, although I should remove 'extern' keyword on both extcon.h
> >> and extcon-provider.h, I only removed them from extcon.h. It was my mistake.
> >>
> >> So that I send this patch for v5.6-rc3 release.
> >> Could you review and apply it to char-misc git repository directly?
> > 
> > Sure, but it's not really a bugfix, I'll queue it up for 5.7-rc1, ok?
> 
> Right. It is not bugfix. Just This patch is related to patch[1]
> which was merged to v5.6-rc1.
> [1] commit tb7365587f513 ("extcon: Remove unneeded extern keyword
> from extcon.h")
> 
> If you think that it is not needed to be merged for v5.6-rc3,
> I think that it is better to apply it to extcon-next branch
> for v5.7-rc1.

I'll queue this up for 5.7-rc1, thanks.

greg k-h

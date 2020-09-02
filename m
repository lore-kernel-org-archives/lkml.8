Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8743EC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43C2520758
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599032427;
	bh=UnWMXR/lX2WpiXir+p0pCIk14LzCAktKNMBYLgRQVuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RYVJp1WmZ5bkIH2uEnRGaMgd2wg6Xb4Vd4ayMSXrWk6aKCJEgo/LCzZStmFIkBgAX
	 BymzmbozgRliI1JLQmZiIKF/tbtNOJMvAJcjsk9iE8jGTfDRpdnvlc+O2cNMICigpY
	 sC3D3STcje+nQOMLNSEvyOlguQDWsoSPk14UuqJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgIBHk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:40:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgIBHkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:40:25 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93CA7207EA;
        Wed,  2 Sep 2020 07:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599032425;
        bh=UnWMXR/lX2WpiXir+p0pCIk14LzCAktKNMBYLgRQVuQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K0X7GKcVKUyoYPeAn7Fy2zvCtKtEMkzt0lHXBwTm1EJeEPzhPnAXy8ki7n+Fcyo3H
         hwXBeI32HZtGB1DmzKb0sqknOG4FrJppOj5kdc7VpjySkBEp3WADN4UBVyTIXcwovd
         szrUu2FZ7YTZoVWHer1Nu80AhGrEyYHIiDrzOLMU=
Date:   Wed, 2 Sep 2020 09:40:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.8 000/255] 5.8.6-rc1 review
Message-ID: <20200902074051.GG1610179@kroah.com>
References: <20200901151000.800754757@linuxfoundation.org>
 <5a6083e7-1ec2-4643-83dd-667bc4ea3251@applied-asynchrony.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a6083e7-1ec2-4643-83dd-667bc4ea3251@applied-asynchrony.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 09:42:00PM +0200, Holger Hoffstätte wrote:
> On 2020-09-01 17:07, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.8.6 release.
> 
> This one has a bunch of things I care about, so I gave it a try
> on both my server & desktop (Gentoo, x86_64). Applies & builds cleanly,
> everything working fine: no spontaneous fires or unexpected screams
> from the underworld.

Wonderful, glad the underworld is happy with this release :)

Thanks for testing,

greg k-h

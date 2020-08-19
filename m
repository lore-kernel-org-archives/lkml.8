Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DC0C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 06:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4186020825
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 06:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597817436;
	bh=iFlXz13dwdHiHEwHnDUkh3cKUMUD4Yq7TW4fYCQNBEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U4hfPpz2IF9hcG6rPLQtfEWLp6yZ0DyVYEGxKTp+GrBlCiExEtvWHWubjFY1H5CzP
	 kaWStYmlkciFxyQQl9ZG6ETVs85P2uQmQWSvsPAoM65dFv1SdG/osaCPewHo0528G+
	 Bye5gvBPJSvUtKmtrja6LPIBfu1ehCz2mpqgL4I0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgHSGKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 02:10:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbgHSGKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 02:10:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37DC82063A;
        Wed, 19 Aug 2020 06:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597817434;
        bh=iFlXz13dwdHiHEwHnDUkh3cKUMUD4Yq7TW4fYCQNBEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2vUjizyqpABC+TSVw/Wr1wMTcZjHtteSQuOFWEHhoyQS0hns7m+WmdZoOgGNEneeT
         gVJHZB4o2CDEWEYZqsySglHpoMJE1R62LVOOZQ4+e9vtev7pI+8S+qdd5xSnyhNwFR
         gkicIUsqjeuSFKByyS54ihJxzIov6hcSs0M7kyo4=
Date:   Wed, 19 Aug 2020 08:10:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.8 000/464] 5.8.2-rc1 review
Message-ID: <20200819061057.GB868164@kroah.com>
References: <20200817143833.737102804@linuxfoundation.org>
 <20200818185739.GD235171@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818185739.GD235171@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 11:57:39AM -0700, Guenter Roeck wrote:
> On Mon, Aug 17, 2020 at 05:09:13PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.8.2 release.
> > There are 464 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 19 Aug 2020 14:36:49 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 154 pass: 154 fail: 0
> Qemu test results:
> 	total: 429 pass: 429 fail: 0

Thanks for testing all of these and letting me know.

greg k-h

Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F021FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C330A2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592978112;
	bh=C7u6f+o/DrwWusWOFFTNio0VAYGLsCOVgTu9dC0eAoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1Ye/X5h6fl+dNsTmnCtNe11HBb4pGma47jDSSvjXx/5sJlLz/nv4gxT4s+874yLrn
	 8KkPvLvzTaDShrR5mfEckifNMVHye2MolQARjp6yg3JytocF4XLvUtiUP5V8TbkNqB
	 M4HmMjS8L/OompxraX9D+2J+iWj7AGSv71CBpUpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389015AbgFXFzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 01:55:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388280AbgFXFzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:55:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5640F2085B;
        Wed, 24 Jun 2020 05:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592978109;
        bh=C7u6f+o/DrwWusWOFFTNio0VAYGLsCOVgTu9dC0eAoI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aZgDwP1kB5BuYMPsGylEZmCMeNU4q6GN6UJ01pEHNUiw4OsMfbO6/xD0wyyFwzNmz
         cXNjx8Wv+Amh05LBRkhtYvEU7BekPJKoCzbmSOzFWC06LL6PRahYqvjSiC7B38LxxC
         27mF0GUlDmU7IQU8ZkaanBRYPI4zbfchYHawOLJM=
Date:   Wed, 24 Jun 2020 07:55:08 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.7 000/477] 5.7.6-rc1 review
Message-ID: <20200624055508.GC684295@kroah.com>
References: <20200623195407.572062007@linuxfoundation.org>
 <e2298fad-feda-cbda-102d-caad70a7fdd7@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2298fad-feda-cbda-102d-caad70a7fdd7@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 10:07:08PM -0700, Guenter Roeck wrote:
> On 6/23/20 12:49 PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.7.6 release.
> > There are 477 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 25 Jun 2020 19:52:30 +0000.
> > Anything received after that time might be too late.
> > 
> [ ... ]
> > Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> >     pinctrl: freescale: imx: Use 'devm_of_iomap()' to avoid a resource leak in case of error in 'imx_pinctrl_probe()'
> > 
> This patch has since been reverted in the upstream kernel (commit 13f2d25b951f)
> and needs to be dropped.

Now dropped, thanks.

greg k-h

Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A7BC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 08:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 689CB23A5B
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 08:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592641640;
	bh=b/NRcRX+YjkpxA8owJuhmUOEmbKbGcJjpWFspWaYR3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gHRPRfbK7JxmRMdC8O522B7+id0gzmCXP6hRCgTGK6YogGERmIlOBVdwJteW3UJK/
	 o4A/1AiWANW0Im4Ngab4Ve/Rh2pIZOGXRgtH1EpkiQL9aasOGzpkZxUdAu6Dvvc10k
	 ka5+Xh3odglrnOWr/k98VTM4Lg43iGj5ARMKZurg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgFTI1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 04:27:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:58866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726838AbgFTI1S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 04:27:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33E2E23A55;
        Sat, 20 Jun 2020 08:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592641637;
        bh=b/NRcRX+YjkpxA8owJuhmUOEmbKbGcJjpWFspWaYR3Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TKv6lBHZkT6d4iNbjiZlsZV4A/JdE21h+pddcauh/qynls0MO2L2IOShRgddk1Xr2
         VAknOSspjHICQPJgyQMCZUdEucIjaZ8LBPK4jOVVAN/97DxT/hNpOJYaRwrQxbEMHj
         WaKBKG7nsCTv/ZSCIUI+Bzur7OUPwLDeBmFFHaFA=
Date:   Sat, 20 Jun 2020 10:27:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.4 000/261] 5.4.48-rc1 review
Message-ID: <20200620082713.GA2506465@kroah.com>
References: <20200619141649.878808811@linuxfoundation.org>
 <20200619160118.GA105163@roeck-us.net>
 <20200620080006.GA2302354@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620080006.GA2302354@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 20, 2020 at 10:00:06AM +0200, Greg Kroah-Hartman wrote:
> On Fri, Jun 19, 2020 at 09:01:18AM -0700, Guenter Roeck wrote:
> > On Fri, Jun 19, 2020 at 04:30:11PM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 5.4.48 release.
> > > There are 261 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Sun, 21 Jun 2020 14:15:50 +0000.
> > > Anything received after that time might be too late.
> > > 
> > 
> > Building mips:defconfig ... failed
> > --------------
> > Error log:
> > arch/mips/mm/dma-noncoherent.c: In function 'cpu_needs_post_dma_flush':
> > arch/mips/mm/dma-noncoherent.c:36:7: error: 'CPU_LOONGSON2EF' undeclared
> > 
> > Also affects v4.19.y.queue, and causes almost all mips builds to fail.
> 
> Thanks, I've dropped the offending patch from both trees now.

And pushed out -rc2 for 5.4.y and 4.19.y with that change, and some
other patches dropped.

thanks,

greg k-h

Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C87C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAD6D2071B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 07:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594885600;
	bh=2rRF0+H6dzoiWSGTgh9BDTtMArRDj3M+AvESL+Ll92M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HPrFiwnqU/UCiBs22qMP8Ucdc19BLlT1ODXS0HHCQ5K9wvm38bdV6bm2MjTSi5SJK
	 265dUZVqOhq6rkkBevXhYD30VbrjBp6SGPCCay1JJ6M6bxFUMAiYjdDRCne+0IolFD
	 0zbqqm8/NdjrkHfXKOPP61L4O/IZXx64Z+192AQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgGPHqj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 03:46:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgGPHqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 03:46:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C19CE206F4;
        Thu, 16 Jul 2020 07:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594885598;
        bh=2rRF0+H6dzoiWSGTgh9BDTtMArRDj3M+AvESL+Ll92M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ykopcBfC8YZCQhBDtu5ek2ciYghlU215+FDFUuzg2YHmoat+k86idGLq2jd84r4PL
         M+nWOuyxNyB0H5bJhyI3P9YPhnwhmKATxdHpf6lyTxFWENbayTObGZUbv675fhC2Ww
         X/fx1WnTSpJjB87+FY1X0YI2klLEX/2NPc2ri7Qc=
Date:   Thu, 16 Jul 2020 09:46:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.7 000/166] 5.7.9-rc1 review
Message-ID: <20200716074632.GB975409@kroah.com>
References: <20200714184115.844176932@linuxfoundation.org>
 <424db635-44a1-8bc8-fe5e-4b84e9c14281@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <424db635-44a1-8bc8-fe5e-4b84e9c14281@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 09:43:41AM -0700, Guenter Roeck wrote:
> On 7/14/20 11:42 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.7.9 release.
> > There are 166 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 16 Jul 2020 18:40:38 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 155 pass: 155 fail: 0
> Qemu test results:
> 	total: 431 pass: 431 fail: 0

Thanks for testing all of these and letting me know.

greg k-h

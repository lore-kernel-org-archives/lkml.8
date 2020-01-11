Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1B7C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 17:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04212087F
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 17:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578764855;
	bh=0DgBgLzxR09id1aaAHZTFdk36WW2whOoZrUpy/pDqWA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jKSVuV6fgCDMtX7DMGAm772DMwWXSkQK1bm12Q/VXffVIpCYlrtxJDhYlqHE/my2k
	 tm/Zz1+NMsl1xy71k4GAq6UqeT8wOkX+NwKpVETz1oPPRo0Nj34s1F0tp1Mfoo34il
	 SkW+jIfQvtFhGLiaF6mdbGJ+eRMkuIH8xTErcCVA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730732AbgAKRre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 12:47:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:44474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730683AbgAKRre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 12:47:34 -0500
Received: from localhost (unknown [84.241.193.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AF6120866;
        Sat, 11 Jan 2020 17:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578764853;
        bh=0DgBgLzxR09id1aaAHZTFdk36WW2whOoZrUpy/pDqWA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rhARnQjP3So5k1r2DU1SjuZvoPeakcNdMparUmM5BlzFCYGXOpMkQkKx2pmkBK9M6
         IeQxy+2NBbvHDTkAtP64cGKVx5fvIEYP8gF5dCreb/eSz8ho5+QqwiagKD+VtWqEqu
         ns2sbwLnAbw2ZgVUCOVlwFVBpVGkJPnjTzHP+t/U=
Date:   Sat, 11 Jan 2020 18:47:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.19 00/84] 4.19.95-stable review
Message-ID: <20200111174715.GB394778@kroah.com>
References: <20200111094845.328046411@linuxfoundation.org>
 <23c3a0d1-1655-8cc2-7c96-743a47953795@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23c3a0d1-1655-8cc2-7c96-743a47953795@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2020 at 08:02:40AM -0800, Guenter Roeck wrote:
> On 1/11/20 1:49 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.19.95 release.
> > There are 84 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Mon, 13 Jan 2020 09:46:17 +0000.
> > Anything received after that time might be too late.
> > 
> Build results:
> 	total: 156 pass: 154 fail: 2
> Failed builds:
> 	arm64:defconfig
> 	arm64:allmodconfig
> Qemu test results:
> 	total: 382 pass: 339 fail: 43
> Failed tests:
> 	<all arm64>
> 
> arch/arm64/kvm/hyp/switch.c: In function 'handle_tx2_tvm':
> arch/arm64/kvm/hyp/switch.c:438:2: error: implicit declaration of function '__kvm_skip_instr'; did you mean 'kvm_skip_instr'?

Thanks for this, I'll go push out a -rc2 with the offending patch
removed.

greg k-h

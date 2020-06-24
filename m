Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CE8C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97AE22088E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592978104;
	bh=VYpBZIMY9aO2mR3bi2mhfBiJTHk4WwM3xz3BJMpRSwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lvgP/59F4paHJVig5aBKc/LzeDbaRbAjWWEaFAqgPJv4dW8r2eKCaen+35wxBTuAW
	 gNI5vRYfuxe6WY3crsxh/nZnKDAQeEps5rD8MQyVDbZK/3UO0bCDPP3YRsnBXU/GzB
	 tw1gfLUsdplVckutgQmXNFB6G7oXwJGkRRG+Jn1c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388989AbgFXFzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 01:55:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:58578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388280AbgFXFzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:55:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFFB72073E;
        Wed, 24 Jun 2020 05:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592978101;
        bh=VYpBZIMY9aO2mR3bi2mhfBiJTHk4WwM3xz3BJMpRSwE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JhUxFk9KAACF/HVQCQhv8678RIzOR2E3mMhDvVz83AIev5GUGwOPHqO7a8nW6U4bw
         JOPpm3TGThK4eVI52Gk2HozwKfw326YK0ibkLmx6sRBxatv8IEQfDntxZhRH+CTdem
         SmtTDuMrmhMf58VKvzQ2ZvR1z7WEoDEv7/I/AGZs=
Date:   Wed, 24 Jun 2020 07:55:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.4 000/314] 5.4.49-rc1 review
Message-ID: <20200624055500.GB684295@kroah.com>
References: <20200623195338.770401005@linuxfoundation.org>
 <4794d7ad-9964-c2e6-9757-577057eb2f64@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4794d7ad-9964-c2e6-9757-577057eb2f64@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 10:05:35PM -0700, Guenter Roeck wrote:
> On 6/23/20 12:53 PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.4.49 release.
> > There are 314 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu, 25 Jun 2020 19:52:30 +0000.
> > Anything received after that time might be too late.
> > 
> 
> [ ... ]
> 
> > Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> >     pinctrl: freescale: imx: Use 'devm_of_iomap()' to avoid a resource leak in case of error in 'imx_pinctrl_probe()'
> > 
> This patch has since been reverted in the upstream kernel (commit 13f2d25b951f)
> and needs to be dropped.

Now dropped, thanks.

greg k-h

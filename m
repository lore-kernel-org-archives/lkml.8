Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561ACC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FE6820729
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595422150;
	bh=y3/4VJCTRdIlYtphkAE/Gn/RBkNRjFdO0z0AevSXdDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qv0rqMc65/t1GcVNgMitC0Bw9+R48EMlAO8sIOLNzaz5pXfqJwoHiSOaAuQ9TyWxH
	 NX4Hq1F2fCa2GntrKQYl//JGShB4ucI3PPq7gZatod2esOcWG01Cw4vABOgfIiTA9Q
	 lcdNVn9YZ22lliOrJaxjcN7qaN71wW62t2s7VIt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732355AbgGVMtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 08:49:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726161AbgGVMtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:49:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDE9E206C1;
        Wed, 22 Jul 2020 12:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595422148;
        bh=y3/4VJCTRdIlYtphkAE/Gn/RBkNRjFdO0z0AevSXdDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R95PcF3fQb8RRElBysX344SHutjTptnkFKl5DK4fDoo+4qOVSdceuYQAA/W5HpTPN
         Io/MI+EDIlmspZ+jT13cgU9jOELZz6N0p9ruzumMfbEO+UQjrr+Ewwh4lpuHOSxUJH
         CTMyBJx7isU9/8GjSJPz8+j88gu5g9/aVqKHhdgU=
Date:   Wed, 22 Jul 2020 14:49:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.7 000/243] 5.7.10-rc2 review
Message-ID: <20200722124914.GD3155653@kroah.com>
References: <20200720191523.845282610@linuxfoundation.org>
 <20200721163829.GF239562@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721163829.GF239562@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 09:38:29AM -0700, Guenter Roeck wrote:
> On Mon, Jul 20, 2020 at 09:16:26PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.7.10 release.
> > There are 243 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 22 Jul 2020 19:14:36 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 155 pass: 155 fail: 0
> Qemu test results:
> 	total: 431 pass: 431 fail: 0

Thanks for testing all of these and letting me know.

greg k-h

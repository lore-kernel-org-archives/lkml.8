Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E76C3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C786E20848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581423507;
	bh=Vs9tgYwbNloDtPlYYsWUGJ7oR3Fy1q/E0aww1Ub31D4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ddONnoByOmzYTWS7wtvh9Z7AQutliF+89q+uS6SBN5653YIcQnif+dSFK09KJZ+rV
	 ZMNleFKAiadmSQLmdNGUS8P/OfqbQWXFtZ3JK/SV4HgUNUJq8+OSleC8C7y54JiDzY
	 qSlrP2btNvMFae6f81A3iFB2umtaOdFoTqSq4HHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgBKMS1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:18:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:48296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbgBKMS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:18:27 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65EE72082F;
        Tue, 11 Feb 2020 12:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581423506;
        bh=Vs9tgYwbNloDtPlYYsWUGJ7oR3Fy1q/E0aww1Ub31D4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tjeefSpOmuz19jQy3U1iJ1iex0iaIrhYkEK5O3EIb572/L2aryJkU5djOtgztLAJa
         Jan7q8ZFrhTqh88n08Q35wuK8xF0Z9Ofa9+A2GMk16+Q27MV1BZddXQ3wYAcwsY4Zp
         2+oydmlvXqSPsi6eCAt6DqOYfMpJ1vIktMaFm/30=
Date:   Tue, 11 Feb 2020 04:18:26 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.5 000/367] 5.5.3-stable review
Message-ID: <20200211121826.GD1856500@kroah.com>
References: <20200210122423.695146547@linuxfoundation.org>
 <20200210214218.GC26242@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210214218.GC26242@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 01:42:18PM -0800, Guenter Roeck wrote:
> On Mon, Feb 10, 2020 at 04:28:33AM -0800, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.5.3 release.
> > There are 367 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed, 12 Feb 2020 12:18:57 +0000.
> > Anything received after that time might be too late.
> > 
> 
> For v5.5.2-369-gd9c695759fb3:
> 
> Build results:
> 	total: 157 pass: 157 fail: 0
> Qemu test results:
> 	total: 397 pass: 397 fail: 0

Great, thanks for testing and letting me know.

greg k-h

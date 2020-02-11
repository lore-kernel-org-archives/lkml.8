Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D67AC3F68F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE1E20848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581423491;
	bh=7EMXBuAN8n+5C6BC5i3JI9ULJUmAAjlKHb6hvurOMPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=diBednmPQTDzK2eo0S6eof09Gl8jkxRWRJb1G+ChBcZIAbeJ09+BJ/TD2a1cryFHg
	 44AvJc/XTbBrGQloMNenw/kIRrHUtdFKq57tFmRWVsO2d251IdITtHVglxbLsZJH15
	 1EInOZObRtDcMEkHPwvGXBDxrzhMxijvuhHYTaEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgBKMSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:18:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:48196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727264AbgBKMSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:18:10 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9F45206DB;
        Tue, 11 Feb 2020 12:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581423488;
        bh=7EMXBuAN8n+5C6BC5i3JI9ULJUmAAjlKHb6hvurOMPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wzB9aoK5MR6JydoMwkm4nCcLMd7rYCZ16WPxQNufoLO/HfZ4dJ2MYdfkFlwQPf2nT
         8gfrUUmzdQyGuQALEuLLxOukLhucrBNafQ+E4V59kUxN7aILHClhUOpLteu4i4k/AC
         VIvTCpS9WHWwJxPn7ZFOQVawLGWhHPGzpf5nl690=
Date:   Tue, 11 Feb 2020 04:18:08 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Subject: Re: [PATCH 5.5 000/367] 5.5.3-stable review
Message-ID: <20200211121808.GC1856500@kroah.com>
References: <20200210122423.695146547@linuxfoundation.org>
 <20200210180821.GA1030265@kroah.com>
 <CA+G9fYtcLUcs_LchTTpejwZea0+5kE8OZsRX1Ti54s3Ve2177g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYtcLUcs_LchTTpejwZea0+5kE8OZsRX1Ti54s3Ve2177g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 07:25:14AM +0530, Naresh Kamboju wrote:
> On Mon, 10 Feb 2020 at 23:38, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Feb 10, 2020 at 04:28:33AM -0800, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 5.5.3 release.
> > > There are 367 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Wed, 12 Feb 2020 12:18:57 +0000.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >       https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.5.3-rc1.gz
> >
> > -rc2 is out to fix an arm64 build issue:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.5.3-rc2.gz
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

THanks for testing this and the others and letting me know.

greg k-h

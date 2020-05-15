Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A224C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBD6920787
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 08:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589532760;
	bh=tTlMp/xCsb7doaJIk2+XRoIGf6tofmnrm5qbfUZ7heI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lChZ6avmPqZfHwZl19TITvJ5tiubTgrkd0im/hcS2uUVjXlnu/YP799m1BY98LrVd
	 LDQWT+z9KIvY8MIzb5USeg35w/CsN69uPhcL+gd8hIQgiRcIHGKlQVCjh1IX7fTJkr
	 GFMyyEb8ye6gxQaWwDuNmuD8mC3pzhA4U1Xq4vz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgEOIwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 04:52:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:52454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbgEOIwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 04:52:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDE6F206B6;
        Fri, 15 May 2020 08:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589532758;
        bh=tTlMp/xCsb7doaJIk2+XRoIGf6tofmnrm5qbfUZ7heI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IHNmkzw4n76SGDBX9SY6OQVQo2nfS04f9C1+4gnXVi5vziK52rPgeXA/nkFXVhVn3
         0X1GtvWaJOZSVcn7eYTj/1TPw/fASwr1Ark99hDVisrtqrZjfakb3Fu6B1m0PkWPMz
         cGsgsr48YtzVmZiLmhwORTXxsLcW3bccjsty0MfQ=
Date:   Fri, 15 May 2020 10:52:36 +0200
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
Subject: Re: [PATCH 5.6 000/118] 5.6.13-rc1 review
Message-ID: <20200515085236.GF1474499@kroah.com>
References: <20200513094417.618129545@linuxfoundation.org>
 <CA+G9fYvjbFmT2xjp3cDL9p9q4oT9+7jn4nX-DP6HHe42WBifhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYvjbFmT2xjp3cDL9p9q4oT9+7jn4nX-DP6HHe42WBifhQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 10:56:21PM +0530, Naresh Kamboju wrote:
> On Wed, 13 May 2020 at 15:22, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 5.6.13 release.
> > There are 118 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Fri, 15 May 2020 09:41:20 +0000.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.6.13-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.6.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, x86_64, and i386.

Thanks for testing all of these trees.

greg k-h

Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75A5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B464722B40
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 06:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596523956;
	bh=/YNTEHR/nmNFODRtYqJTFfYIMk+6yAPyea3KRr4m12A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2rGnWzy0g3lAmFkhJPrFjyG4IP0YzN6blr6UJ+92L5o/NRbKirqi/GoZzeeoGY9Yg
	 ljhd8+1ic3EaUPINKW3kaUp2x556ZLh4vBhCjm15z4MdlOUeJX8dMN6SCJ2qiMpNvA
	 f2ghnuaxOKP6HvkEghvWc84IkyBDd6qF5p6wBVdI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgHDGwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 02:52:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:36006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHDGwf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 02:52:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DB172076C;
        Tue,  4 Aug 2020 06:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596523955;
        bh=/YNTEHR/nmNFODRtYqJTFfYIMk+6yAPyea3KRr4m12A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rlbrOySspLyuV9J7wi7e2bLxSNp0ArwgOnKlKaIaxfsckXs0Fj/rSCSoE0rf4vaVc
         +VA0UYN1qbSUb4YfdCgcXe5ZjOdQSPSL+/8ph1A+LGyn4DfdGuynJ0qO/Mt+z3NnIx
         FcbLJTgrAUrta8VzFBf8E/ZvrIWzviVvCZIcVzeI=
Date:   Tue, 4 Aug 2020 08:52:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org, stable <stable@vger.kernel.org>
Subject: Re: [PATCH 5.7 000/120] 5.7.13-rc1 review
Message-ID: <20200804065232.GA699167@kroah.com>
References: <20200803121902.860751811@linuxfoundation.org>
 <20200803155820.GA160756@roeck-us.net>
 <20200803173330.GA1186998@kroah.com>
 <CAMuHMdW1Cz_JJsTmssVz_0wjX_1_EEXGOvGjygPxTkcMsbR6Lw@mail.gmail.com>
 <20200804030107.GA220454@roeck-us.net>
 <CAHk-=wi-WH0vTEVb=yTuWv=3RrGC2T28dHxqc=QXKkRMz3N3-g@mail.gmail.com>
 <20200804055855.GA114969@roeck-us.net>
 <CAHk-=wguY19e6_=c3tGSajC6zxivJ6vH+MsbGDUzSMe5NFkJeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wguY19e6_=c3tGSajC6zxivJ6vH+MsbGDUzSMe5NFkJeA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 11:33:39PM -0700, Linus Torvalds wrote:
> On Mon, Aug 3, 2020 at 10:59 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >
> > Tested-by: Guenter Roeck <linux@roeck-us.net>
> 
> Thanks.
> 
> Greg, I updated my internal commit with Guenter's tested-by and some
> more commentary (I had tried to break out that file entirely, it gets
> ugly).
> 
> So it's now commit c0842fbc1b18 ("random32: move the pseudo-random
> 32-bit definitions to prandom.h") in my tree, and I've pushed it out.

Great, I see it now and will grab it from there, thanks!

greg k-h

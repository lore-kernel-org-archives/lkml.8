Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DCA9C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E45B207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587404098;
	bh=wWPd39Rx54rl9LMyXLHSNXK6eX2yAVdoZDu2g9HTl2E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yQToCBI6kSxqLijyN2AA7Mxl3qqAzA7UxKuOBYCLQCgzi6nu2hKsTEp3iW53wR9DS
	 ycOxgaMKPWzkLPE34EVv+dpcheMLzVmg4fRx3DMkYu1tCbWTy2nQnviMtpr5dlV2QC
	 2IphCl9gt1J5OeTs/40IlhhRVL3dXISoQCIJ/MSY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgDTRe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:34:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:52720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725784AbgDTRe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:34:56 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 920D420782;
        Mon, 20 Apr 2020 17:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587404095;
        bh=wWPd39Rx54rl9LMyXLHSNXK6eX2yAVdoZDu2g9HTl2E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r/pEMiDA6avrETKmf27XlxmTdsajuesl76wdOPCm+kJOZvOqHoHnyYVrTdkkGMI4n
         DltKzbrzicb4YTaRghkvCKyMcY0amFcnM8Gza7c1kKBtXeaSteZPG5oNDcRO0sNzEu
         p62sEzgzz37ygG29gKax/vmgftj8SX9m8C8WcWLk=
Date:   Mon, 20 Apr 2020 19:34:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Dmitry Safonov <dima@arista.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "kernelci.org bot" <bot@kernelci.org>, Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH] tty/sysrq: Export sysrq_mask()
Message-ID: <20200420173451.GA279051@kroah.com>
References: <20200401143904.423450-1-dima@arista.com>
 <20200401144610.GA2433317@kroah.com>
 <b0099c8c-5bab-960a-8d0d-4691e11a462f@arista.com>
 <20200401151222.GA2508664@kroah.com>
 <87pncqu0cv.fsf@mpe.ellerman.id.au>
 <CAPM=9tzujQOXo5Df+UZLTW5pp3JNfchSX-0KVZmOidvFQWxkCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tzujQOXo5Df+UZLTW5pp3JNfchSX-0KVZmOidvFQWxkCw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 04, 2020 at 07:53:10AM +1000, Dave Airlie wrote:
> On Thu, 2 Apr 2020 at 11:46, Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> > > On Wed, Apr 01, 2020 at 03:49:56PM +0100, Dmitry Safonov wrote:
> > >> On 4/1/20 3:46 PM, Greg Kroah-Hartman wrote:
> > >> > On Wed, Apr 01, 2020 at 03:39:04PM +0100, Dmitry Safonov wrote:
> > >> >> Build fix for serial_core being module:
> > >> >>   ERROR: modpost: "sysrq_mask" [drivers/tty/serial/serial_core.ko] undefined!
> > >> >>
> > >> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >> >> Cc: Jiri Slaby <jslaby@suse.com>
> > >> >> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> > >> >> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> > >> >> Signed-off-by: Dmitry Safonov <dima@arista.com>
> > >> >> ---
> > >> >>  drivers/tty/sysrq.c | 1 +
> > >> >>  1 file changed, 1 insertion(+)
> > >> >
> > >> > Is this a new problem?  What commit does this fix?
> > >>
> > >> Right, sorry I've managed to forget adding the tag:
> > >>
> > >> Fixes: eaee41727e6d ("sysctl/sysrq: Remove __sysrq_enabled copy")
> > >>
> > >> Maybe also:
> > >>
> > >> Link:
> > >> https://lore.kernel.org/linux-fsdevel/87tv23tmy1.fsf@mpe.ellerman.id.au/
> > >
> > > Thanks, that works.  WIll queue this up after -rc1 is out.
> >
> > Why wait until after rc1?
> >
> > It's a build break for a bunch of folks and the fix is obviously correct
> > (famous last words).
> 
> definitely seems like something that should be fixed prior to rc1,
> s390 builds in fedora are hitting it.

Ugh, I missed this, I'll go queue this up now, sorry for the delay...

greg k-h

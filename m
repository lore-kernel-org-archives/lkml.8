Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5AEC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8734220658
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581346489;
	bh=UBHVEhjuJ6mZ1x4eg42Y3DOjT70/3Gf+xWMwoSf1ktc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SqYJ1m+wVCPjjYhH5O0EJp8uoqhiBshv+aOpsLrHoOzByh4a7lQ/0oT59fCodv/qo
	 GiLKUQ4Y5b/nG72GX8f9xIiKi6OYkC8rpafQamum+U/OitzKeeJIUJphlmrwikFBek
	 tEQPWAIObwygpmHdN8zuOcsYqg8y8MHZwQkKDBFo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgBJOyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:54:49 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39955 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbgBJOys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:54:48 -0500
Received: by mail-lj1-f196.google.com with SMTP id n18so7479213ljo.7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 06:54:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dllWkZboxxWOQJK/GHcMFsb6rMrw2RkkNPM3tG6F+7U=;
        b=LS4R/QBDpV00wfWL7KQtemTi3CGmfHTLRetl6eoOv4v9vA1h2GEUBRBLrkCESMSnq4
         DYeLrv7mf+btZVxFeuEqMh7VYFAy2OyVmUGeGsEGfcpyAAuA4QZO+WWK10Aho/rC2UwE
         Np5CgsnZ9fPkqxeX3Ew/ekx/AvoYrhG9C9za19tMKRTZEfjKReecn291EFfOIY2ILlnW
         wC5ExMx6g1ASifEKzfqpPhYdbzV0DjhPrz0s3d/m2Qfbic5r7V/MQwY/ri68Ryj3z8w4
         +9ewcfYLFLvgfjG+/yBG3zlOPITaOY97ULO36B9SqBky7/qShvYKQiGSG43PowwFIQcP
         Oxew==
X-Gm-Message-State: APjAAAWet7PIkzGq5s7SC/Km1yXkUjkyS/A2jf0+gK5jogd32CY+fudF
        hBXR5TsDB2YzCxZGNWGAP6A=
X-Google-Smtp-Source: APXvYqxKrpFi2uiLLE3q1pNr62LrlepELG+/vs7ZIS1M3uETx6q2aoru3x/wwPG9NDOPdP7Sp6bQjQ==
X-Received: by 2002:a2e:9d11:: with SMTP id t17mr1194604lji.169.1581346486500;
        Mon, 10 Feb 2020 06:54:46 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id t29sm251725lfg.84.2020.02.10.06.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 06:54:45 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1j1AST-0005sV-4s; Mon, 10 Feb 2020 15:54:45 +0100
Date:   Mon, 10 Feb 2020 15:54:45 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Loic Poulain <loic.poulain@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty_port: Restore tty port default ops on unregistering
Message-ID: <20200210145445.GA22240@localhost>
References: <1580285224-7712-1-git-send-email-loic.poulain@linaro.org>
 <20200204094748.GG26725@localhost>
 <CAMZdPi8R_bj4+HFjCmiRTJ2KgToMMuX0fbopGBOsMPMhJ4xsXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZdPi8R_bj4+HFjCmiRTJ2KgToMMuX0fbopGBOsMPMhJ4xsXQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 07:03:37PM +0100, Loic Poulain wrote:
> On Tue, 4 Feb 2020 at 10:47, Johan Hovold <johan@kernel.org> wrote:
> >
> > On Wed, Jan 29, 2020 at 09:07:04AM +0100, Loic Poulain wrote:
> > > When a port is unregistered from serdev, its serdev specific client_ops
> > > pointer is nullified, which can lead to future null pointer dereference.
> > > Fix that by restoring default client_ops when port is unregistered from
> > > serdev.
> >
> > Hmm, yeah, this seems like something we should fix as 8250 appears to
> > allow reregistering ports, but...
> >
> > > port registering/unregistering can happen several times, at least it
> > > happens when statically registered 8250 ISA port are replaced at boot
> > > time by e.g. device-tree defined 8250 ports.
> >
> > How did the serdev controller get registered in the first place here if
> > you're talking about statically registered 8250 ISA ports (i.e. where is
> > the client defined)?
> >
> > Did you actually ever hit this one?
> 
> Yes, but never in the mainline.

Ok, thanks for confirming.

> Actually a set of changes [1] [2] in the AOSP common kernel mades the tty
> ports bound to serdev by default, except for one(s) with console attached.
> So with some platforms the ISA ttyS0 is firstly registered with serdev and
> then replaced (unregistered/registered) later in the boot by the 8250 port
> enumerated from the fdt and used for console (expecting default tty ops).
> 
> TBH I disagree with the way it has been done in the AOSP, but it highlighted
> this possible null ops path, which can be fixed either by resetting the
> default ops on tty port unregister (this patch), or on register.

Yeah, those AOSP commits doesn't make much sense, especially not the
first one since it doesn't provide any means to define the client.

> [1]
> https://android.googlesource.com/kernel/common/+/c550a54f23026e92633c5145e8b919cf590a5624
> [2]
> https://android.googlesource.com/kernel/common/+/cc3b00864e3b316ff106f948834d7e0cc6244921

I spent some time looking into this today, and this doesn't seem to be
an issue for mainline unless we are reloading 8250 drivers.

Specifically, the statically defined ports that 8250 core would register
when an 8250 driver is being unbound could end up with a NULL client
ops.

This is seems unlikely to be an issue in practice, but I think we should
plug this nonetheless.

I already fixed the related issue of serdev not resetting the client_ops
on failed registration in aee5da783878 ("serdev: fix tty-port client
deregistration"), and I think the unregistration case should be handled
similarly by the serdev ttyport controller driver (rather than by tty
core).

I've prepared a patch with a commit message outlining how this may
affect mainline and included a stable tag. This should fix the issue in
AOSP as well, even that first commit [1] above really should be
reverted.

Johan

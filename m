Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BBD2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F00692078C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 14:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591797708;
	bh=b1KRmFrJQFC3z6HDXblv42MBWZrbFpZqf35Nd9i3Vwk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ijWdabOTTx9p2E9Hw99Ljm/wQKQJT30AX4YZYYOIx9bilZpbvlsFZmJkgHes0OXki
	 ZbnEdYrnTwQvHPudlhSn2nWIRumXW8e2OLqf6gCMSYEiTb7L5lVmnTJVlhJBQ6P1+B
	 ev2XfeulPkqlDulhe9NblI4Wa/kRFFd93hgCZmL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbgFJOBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 10:01:45 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38367 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgFJOBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 10:01:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id u5so1037503pgn.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 07:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rk0ghIljU9mCEy9QgEbT1h8DI09ve656Ar7pgw0dxhA=;
        b=keAZxZ7bjtYjJ/94YrNI6lc0l7jwED5yudDkM3b+F+2oM/qoTyQOVjh3pyHrpd6ENI
         eD4/WDST134g/vgFToUxQmorrJWNPuQtrK/PatYDXXkaCsECoqxu3kLnt1FZCO1MC2W+
         tqcr3CzzuRBbUEiNNqB2vbv0tDVMNfY4S8B8DofZtCH+rmbqQ6U57p9QWEfiOiHrQM7w
         yFB0NYUMWfrgpHI5QaDZ8jO6kM/aiwsx69Qa9AZWHitopkvRmMIr8HiNBYIqeqmJy/an
         ejilEPC48Vdnj+fWx0Txw1klJPtxGqSB/889iOxyxp3JW8aEw1EHCYlB/Vwgjyu+HhwJ
         tuDQ==
X-Gm-Message-State: AOAM531eDhr9OKkVdEaE0oWYospU8YNLspm98Azzdww7rD/WEvAoatPF
        l8N6+E7twGB72uHdbUbCYRdg33jWQ24=
X-Google-Smtp-Source: ABdhPJzlC/UGjhW7h2lRO1BIXvioDT2f+9RysnK1brAAfdDlCCebMhIvBx11VmTIRLFU1mIhMnVn2g==
X-Received: by 2002:a05:6a00:15ca:: with SMTP id o10mr2910124pfu.169.1591797700899;
        Wed, 10 Jun 2020 07:01:40 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id h17sm58841pgv.41.2020.06.10.07.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 07:01:39 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 9129B403AB; Wed, 10 Jun 2020 14:01:38 +0000 (UTC)
Date:   Wed, 10 Jun 2020 14:01:38 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        x86-ml <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] x86/microcode: Do not select FW_LOADER
Message-ID: <20200610140138.GU11244@42.do-not-panic.com>
References: <20200610042911.GA20058@gondor.apana.org.au>
 <20200610081609.GA14118@zn.tnic>
 <20200610131209.GT11244@42.do-not-panic.com>
 <20200610134650.GH14118@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610134650.GH14118@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 03:46:50PM +0200, Borislav Petkov wrote:
> On Wed, Jun 10, 2020 at 01:12:09PM +0000, Luis Chamberlain wrote:
> > On Wed, Jun 10, 2020 at 10:16:09AM +0200, Borislav Petkov wrote:
> > > 
> > > Also, I'm working on removing that homegrown get_builtin_firmware() and
> > > use the one in the fw loader:
> > > 
> > > https://lkml.kernel.org/r/20200408094526.GC24663@zn.tnic
> > 
> > I would like to still encourage this, even with this patch in place,
> > as I think it makes this a proper call, and reflects better how the
> > firmware loader is used exactly.
> > 
> > FWIW, firmware loader will be changed soon to not be modular, and just
> > built-in or disabled.
> 
> I don't mind doing the work but Herbert has a point - there's no need to
> require a bunch of code for a trivial function.
> 
> What I could do in addition is move that trivial function into a
> fw-specific header and have it defined unconditionally so that the
> microcode loader can use it without needing the fw loader.

Would just have to see this part. But sounds like a better place than
today.

> The testcases stuff then goes ontop.

Sure!

  Luis

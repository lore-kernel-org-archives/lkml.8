Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FB8C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80347206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588058988;
	bh=/a/pjlolCtfoc7lJGFazM2Yo7UObdVu05STg+nclafM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Mf1plXz1fnqPIx/AlubUg76dYKhgrz0U9cXBPchiMDRE+mvYbRY2Y4BrqnNbQmdYe
	 Bf7Q78XmDHsi2rA0NkazRALF8cou+5Y51XLVgr/3SFAs1YxBnPImNx/AJC7HnJsdz5
	 crkCUFZmRIMN3W5nhWJihsxo5Wcci5XXR52LLNWk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgD1H3s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:29:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:60506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgD1H3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:29:47 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93D43206B8;
        Tue, 28 Apr 2020 07:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588058987;
        bh=/a/pjlolCtfoc7lJGFazM2Yo7UObdVu05STg+nclafM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Grp4wnjwiTI4HPXJI+Sax7vGGOSZTftnxkusF93w0dhdeFn2CPW0I05fMNbVTeFYh
         SGcMJQxxvRBPjONhz+ZToR0l/0565t96PkTLpaUKimJX9nlE5XwVCru1W8oy4Kx6ZE
         Q5KSVvsaTsrJKoG7KzF/MKiYXT8xPKY1T/3UnVF4=
Date:   Tue, 28 Apr 2020 09:29:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     jeyu@kernel.org, corbet@lwn.net, rdunlap@infradead.org,
        mchehab+samsung@kernel.org, tglx@linutronix.de,
        akpm@linux-foundation.org, pawan.kumar.gupta@linux.intel.com,
        jgross@suse.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3] module: Allow to disable modsign in kernel cmdline
Message-ID: <20200428072944.GA994208@kroah.com>
References: <20200428060008.50417-1-tianjia.zhang@linux.alibaba.com>
 <20200428063522.GA990431@kroah.com>
 <8a0c0ef3-4881-1b9c-6e42-ab379542bc16@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a0c0ef3-4881-1b9c-6e42-ab379542bc16@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 03:07:10PM +0800, Tianjia Zhang wrote:
> 
> 
> On 2020/4/28 14:35, Greg KH wrote:
> > On Tue, Apr 28, 2020 at 02:00:08PM +0800, Tianjia Zhang wrote:
> > > This option allows to disable modsign completely at the beginning,
> > > and turn off by set the kernel cmdline `no_modsig_enforce` when
> > > `CONFIG_MODULE_SIG_FORCE` is enabled.
> > > 
> > > Yet another change allows to always show the current status of
> > > modsign through `/sys/module/module/parameters/sig_enforce`.
> > > 
> > > Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> > > Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> > > ---
> > > 
> > > v3 change:
> > >    Beautify the document description according to the recommendation.
> > > 
> > > v2 change:
> > >    document this new option.
> > > 
> > >   Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
> > >   kernel/module.c                                 | 8 ++++++++
> > >   2 files changed, 14 insertions(+)
> > > 
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index 7bc83f3d9bdf..b30f013fb8c5 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -3190,6 +3190,12 @@
> > >   	noirqdebug	[X86-32] Disables the code which attempts to detect and
> > >   			disable unhandled interrupt sources.
> > > +	no_modsig_enforce
> > > +			[KNL] When CONFIG_MODULE_SIG_FORCE is set, this option
> > > +			allows to disable modsign completely at the beginning.
> > > +			This means that modules without (valid) signatures will
> > > +			be loaded successfully.
> > > +
> > 
> > So now we have module.sig_enforce and this one?  That feels really
> > confusing, why can't you just use the existing option?
> > 
> > And why would you want to allow the bootloader to override a kernel
> > build option like this?  That feels risky.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> If CONFIG_MODULE_SIG_FORCE is set, `module.sig_enforce` is always true and
> read-only. There is indeed a risk in doing this, but it will allow the
> system to boot normally in some emergency situations, such as certificate
> expiration.
> 
> On the other hand, would it be a good solution to make `module.sig_enforce`
> readable and writable?

Readable is fine :)

And you really can't modify the existing option to change how it works,
but my question is, why would you want to override
CONFIG_MODULE_SIG_FORCE at all?  I wouldn't want my bootloader to have
the ability to change the kernel's protection model, that's a huge
security hole you are adding to the kernel that it can not protect
itself from at all.

thanks,

greg k-h

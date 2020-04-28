Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6807C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F67206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588057504;
	bh=pPZOuPOMkuW0rnASrsa54ZV6xYdt/mN+nBOmYv4gGGo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l2/al8841ubLxFzuzjYQSVaxMgMwpo/83Aas4lRuGPA0St/7DURjDatnZo/r2sYeC
	 jCX7WJVSi2sLR6uWdqPhSkz6MJvGc25U0QBl1o69dSklnmNVlIxs3b41yV1PYJwRsk
	 0nBvDp73DGEaouJMr//PjoxYpczv40bWWvZOvIH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgD1HFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:05:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:56692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgD1HFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:05:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99706206A5;
        Tue, 28 Apr 2020 07:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588057500;
        bh=pPZOuPOMkuW0rnASrsa54ZV6xYdt/mN+nBOmYv4gGGo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aTGUnbuUoZboqOXsekTmo/yjhNtcj9R/leh51Hq3VODXBvgowV+T+sNm7T1pvce2u
         vKrsgG/swJhLHvLa5nSgZm4mboPHOnXBelEA7xQhOxu25mw0gH5/7tJ052yn8CPSc+
         pB7qlANBOynBD2P0JxnJ8mdsdaNtmr6Py3oT2xrs=
Date:   Tue, 28 Apr 2020 09:04:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     xujialu <xujialu@vimux.org>
Cc:     corbet@lwn.net, linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        akpm@linux-foundation.org, mchehab+huawei@kernel.org
Subject: Re: [PATCH] scripts: gtags_files_generator.sh
Message-ID: <20200428070457.GA992660@kroah.com>
References: <20200426083619.GA2105859@kroah.com>
 <20200428053509.19564-1-xujialu@vimux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428053509.19564-1-xujialu@vimux.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 01:35:08PM +0800, xujialu wrote:
> > Yes, please, just do proper email responses, like all the other
> > conversations on the mailing lists :)
> 
> Nice of you :)
> 
> > Perhaps you should read the email client documentation in the kernel
> > tree?
> 
> Also watched your interesting video:
>     <HOWTO - apply a Linux kernel patch to the stable tree>
> 
> > I still don't know what is wrong with 'make gtags'.  If it does not work
> > properly for you, why not fix that up instead of creating something
> > totally new that is not even hooked up to the kernel build system?
> 
> As you suggested, i walk through scripts/tags.sh, and suddenly found
> flag COMPILED_SOURCE, so i throw away my lasted stupid script, and tried
> to improve this 'compiled only' feature, seems much better now.
> 
> And about 'make gtags':
> 1. It picks up so many files, do you think 'all sources' is good for us?

When you modify kernel code, yes, you have to fix it up everywhere, you
can not ignore other architectures or drivers that your machine happens
to not use.

An "average" laptop only runs about 2-3 million lines of code or so, a
small percentage of the 25+ million lines that are in the kernel source
tree.

> 2. Seems gtags does not support source files from parrent directories,
> it gives warnning out of tree (global-6.6.3) or just segmentation fault
> (global-5.7.3) when we 'make gtags O=blabla', cause gtags.files is
> generated in dir 'blabla' but source files are out of dir 'blabla'.

Then fix that as a stand-alone patch please, do not mix it in with other
changes.

thanks,

greg k-h

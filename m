Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_24_48,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0CA1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 06:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B08E122D08
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 06:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596781618;
	bh=kqsWg5jAvUzVY91mCkETH95rjV82/9Ukdeimf65cdKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2Vn/+R5Wx1Q7ylNKdboEerHIsHyegvGnb/q7OIE49SBa2poIjM/lykiPOIghrIU9/
	 hE33FQtOtWyKxKq877KRcvp11lJjqDLjRxvu8tbQ8kxmdaHjTXyv68+n9pouhqDo+P
	 NIX4ofpfOpT8NbguZ3AHIq3x+0TL6e4OXMMijtkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgHGG05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 02:26:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:35290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgHGG05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 02:26:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9872E22CAE;
        Fri,  7 Aug 2020 06:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596781616;
        bh=kqsWg5jAvUzVY91mCkETH95rjV82/9Ukdeimf65cdKg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iCQ7xEDU1k/n67IVsR4ok1GRt28TuNr03PEly/24EXb2kXSc0fE6F3scU5TmptHaD
         JlFTbMU09+m8ugorSxIEmgKUBKJTuKQkTdmeX0WlMj/4gBq4ABItz8HSYWRjji8F9m
         rgASC7kbgS1WsGUrITpxi5OJ6dQ1pzon8r0Mg/t4=
Date:   Thu, 6 Aug 2020 07:40:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Niklas <Hgntkwis@vfemail.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Is anyone else getting a bad signature from kernel.org's 5.8
 sources+Greg's sign?
Message-ID: <20200806054056.GA933406@kroah.com>
References: <20200805205924.1f646d45@Phenom-II-x6.niklas.com>
 <5a943a1f-c5ef-937f-f67e-1c59c04d63fb@infradead.org>
 <20200805232038.7a1767cc@Phenom-II-x6.niklas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805232038.7a1767cc@Phenom-II-x6.niklas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 11:20:38PM -0400, David Niklas wrote:
> On Wed, 5 Aug 2020 18:36:08 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> > On 8/5/20 5:59 PM, David Niklas wrote:
> > > Hello,
> > > I downloaded the kernel sources from kernel.org using curl, then
> > > opera, and finally lynx (to rule out an html parsing bug). I did the
> > > same with the sign and I keep getting:
> > > 
> > > %  gpg2 --verify linux-5.8.tar.sign linux-5.8.tar.xz
> > > gpg: Signature made Mon Aug  3 00:19:13 2020 EDT
> > > gpg:                using RSA key
> > > 647F28654894E3BD457199BE38DBBDC86092693E gpg: BAD signature from
> > > "Greg Kroah-Hartman <gregkh@linuxfoundation.org>" [unknown]
> > > 
> > > I did refresh all the keys just in case.
> > > I believe this is important so I'm addressing this to the signer and
> > > only CC'ing the list.
> > > 
> > > If I'm made some simple mistake, feel free to send SIG666 to my
> > > terminal. I did re-read the man page just in case.  
> > 
> > It works successfully for me.
> > 
> > 
> > from https://www.kernel.org/category/signatures.html::
> > 
> > 
> > If you get "BAD signature"
> > 
> > If at any time you see "BAD signature" output from "gpg2 --verify",
> > please first check the following first:
> > 
> >     Make sure that you are verifying the signature against the .tar
> > version of the archive, not the compressed (.tar.xz) version. Make sure
> > the the downloaded file is correct and not truncated or otherwise
> > corrupted.
> > 
> > If you repeatedly get the same "BAD signature" output, please email
> > helpdesk@kernel.org, so we can investigate the problem.
> > 
> > 
> > 
> 
> Many thanks. I've never seen a signature done that way before, but I
> understand why you would do it that way.

That means other projects need to change as well :)

And you are not alone, this comes up every release, no problems.

greg k-h

Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B074DC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88487206F0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595602832;
	bh=RIPb8L5tuFmr36nEbM6kWNkrodrpmItfj74Y1snUV18=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BgKjbwIbIcRBOOMnohmI4HpolgJ94IE93Vb6FyH5iW2u/T7WTTPAwxOs/DnaxTYn5
	 I5jDaUFEhgAPVM4P87+8IJpLdKAwXJVV3U2KLflSYQkGRcfsILtfOlRfrq2eKoX8DE
	 Ef3mTm3+mpFCU95p4cKLHpjHCkeyoLk2pzCOMy9Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgGXPAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 11:00:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbgGXPAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 11:00:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07AAB206D8;
        Fri, 24 Jul 2020 15:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595602830;
        bh=RIPb8L5tuFmr36nEbM6kWNkrodrpmItfj74Y1snUV18=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TowwC36WHR1KZJhXBbG59vF03xaBbNLtrUsYxTL+t2dNrP/DjqdSarxARP/x0ROiX
         d6Z+FsgjaWM1g1VYb0lUXoksoFfRhu9nAoy51IYb9vvSzd0Z8TLN9mPt3kz0U9lU8X
         HZHoaJap5TRwYom0wv+X9lnpGrO9PuDrrnq/8jBA=
Date:   Fri, 24 Jul 2020 17:00:32 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jason Baron <jbaron@akamai.com>
Cc:     Jim Cromie <jim.cromie@gmail.com>, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, linux@rasmusvillemoes.dk
Subject: Re: [PATCH v5 00/18] dynamic_debug fixes, cleanups, features, export
Message-ID: <20200724150032.GB330332@kroah.com>
References: <20200719231058.1586423-1-jim.cromie@gmail.com>
 <4d7244b1-fa4d-f1bd-42e4-7123116e708f@akamai.com>
 <20200724145900.GA330332@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200724145900.GA330332@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 04:59:00PM +0200, Greg KH wrote:
> On Fri, Jul 24, 2020 at 09:48:54AM -0400, Jason Baron wrote:
> > 
> > 
> > On 7/19/20 7:10 PM, Jim Cromie wrote:
> > > this is v5, changes from previous:
> > >  - moved a chunk from patch 13 to 12, per Jason
> > >  - shorten logging prefix to "dyndbg", drop __func__
> > >  - now with more commit-log advocacy
> > >  - shuffle EXPORT_GPL(ddebug_exec_queries) last.
> > >  - v4+ series Acked-by: jbaron@akamai.com
> > 
> > Yes, series looks good to me:
> > Acked-by: <jbaron@akamai.com>
> > 
> > Greg, what do you think about pulling in this series?
> 
> Me?  Am I the one who takes these patches?
> 
> Ok, will do, give me a few hours...

Nevermind, b4 made quick work of that, now queued up, thanks.

greg k-h

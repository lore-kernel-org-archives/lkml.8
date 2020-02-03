Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6B4C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC1212080D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580739196;
	bh=p3urbucqgFJwjTe/aZobdga9eleMICZtIpUsjYKr54A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MfIOyfk5Nvh+44QK5uYmTcDzArfC8o0p26kB2TxeetD96dxqxjusXue1UMbTJYo+d
	 VmnwTB7kfpoSbS7S95feBlvbOp+PMYyubQs/x9c3vz/OFlIAhybFW5SAAC1lp3uvJS
	 kv0GVO2qZGhYsrVwlGcOjJEhYsg5bYFzLCwXSK4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgBCONQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 09:13:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:51724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbgBCONP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 09:13:15 -0500
Received: from localhost (unknown [104.132.45.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECAE6207E0;
        Mon,  3 Feb 2020 14:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580739195;
        bh=p3urbucqgFJwjTe/aZobdga9eleMICZtIpUsjYKr54A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WMY26KSkfEy/Y+NcjKK/pAViv0Ill8Q16mEf1sjdaGWjy5b7ScEojFm2HtV9IBmBa
         BP7je01Nb/bHil4L3CXFn1/bKaQZs+bT1E8kKm9IMnUXjUty1I2tfOyip3JUUXWPqi
         0JeARNTVNtNLEKTJxYMDvVBEvMaGAr09FKffaYdY=
Date:   Mon, 3 Feb 2020 14:13:13 +0000
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Ming Lei <tom.leiming@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gustavo@embeddedor.com, Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: Current Linus tree protection fault in __kmalloc
Message-ID: <20200203141313.GA3219450@kroah.com>
References: <20200203012702.GA8731@bombadil.infradead.org>
 <CACVXFVPyW9+oSPAv7-+=hExzktLkmPG=gYUY5acR5UGeJzTh0Q@mail.gmail.com>
 <20200203132334.GH8731@bombadil.infradead.org>
 <CACVXFVNqP=oEZNiu=nebJ5EKKXfMfq7e=M1Ko1_TVw-FJTUpZw@mail.gmail.com>
 <20200203140819.GI8731@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203140819.GI8731@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 06:08:19AM -0800, Matthew Wilcox wrote:
> On Mon, Feb 03, 2020 at 09:37:11PM +0800, Ming Lei wrote:
> > My git bisect is just done, and it points to the following commit:
> > 
> > commit 987f028b8637cfa7658aa456ae73f8f21a7a7f6f
> > Author: Gustavo A. R. Silva <gustavo@embeddedor.com>
> > Date:   Mon Jan 20 17:53:26 2020 -0600
> > 
> >     char: hpet: Use flexible-array member
> > 
> > I have double checked the commit, and looks it is really the 1st bad one.
> 
> Looks like this patch will fix it then:
> 
> https://lore.kernel.org/lkml/202001300450.00U4ocvS083098@www262.sakura.ne.jp/

Yes, sorry, I will push this to Linus today, hopefully he picks it up
soon, lots of people are hitting this...

greg k-h

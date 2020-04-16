Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7F7C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 10:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A05221973
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 10:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587033061;
	bh=OssfVZy2Gtzt3T7P0reeqZMpIV9JxrCPL2xhmitTd9E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aEIxVjl/KbEgmeIRqL7Xzn2OaHyB8dDeELNJ68K8xXF0SuJJwJX0MrZBo6Hmq4prv
	 Uaroel74SzzlJoZib1qxT0D/rIPdbBFQAaUAWTf8zYspH/1FK9AWDS/9TShIU3Izm/
	 e9qRTo66XZERwPeBLhksqiVxjJ1rjXXpvHQG7CI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505022AbgDPKaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 06:30:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2504976AbgDPK3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 06:29:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 265482192A;
        Thu, 16 Apr 2020 10:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587032950;
        bh=OssfVZy2Gtzt3T7P0reeqZMpIV9JxrCPL2xhmitTd9E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0azUCD7j9RcZZiV9fqaX3mrmQxuFB5X+uVyL8ub/d/3Jq5rCsvrD/6RQAKxkop2lS
         j4FUnBxx+wMRujUOfJqV1bhPGXblv7c1o0DoGeu8Fr243fX6VxwL6R/Ign9lW35kSB
         /FIInuhbq4/sC5RnrupM6QhJ5cvYAf99B4nQjIAE=
Date:   Thu, 16 Apr 2020 12:29:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Carlos Guerrero =?iso-8859-1?Q?=C1lvarez?= 
        <carlosteniswarrior@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: Comedi: Drivers: das08: Fixed some coding style
 issues
Message-ID: <20200416102908.GC820251@kroah.com>
References: <20200413080555.29267-1-carlosteniswarrior@gmail.com>
 <20200413125140.GC3077651@kroah.com>
 <CAB_Ssx7B13Lm-twHuEOzP4EODQ7kqd5jA0mxZS5SnpqxJ65XBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB_Ssx7B13Lm-twHuEOzP4EODQ7kqd5jA0mxZS5SnpqxJ65XBg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Mon, Apr 13, 2020 at 04:55:08PM +0200, Carlos Guerrero Álvarez wrote:
> What do you mean with the From line?

Look at the patch you sent, the "From:" line on your email does not have
your name, only your email address.  Please fix that up when you resend
any future patches.

thanks,

greg k-h

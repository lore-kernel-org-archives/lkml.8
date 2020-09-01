Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C12C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 11:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA753206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 11:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598959912;
	bh=M/gIeLcJ2zVJl2Ut67sxzpfCdDlyqzk0freIT8v084g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uoljEuX0Qth3wcp6O7tDEHq1SvJK1m4Lf4xY35WM+3SaMErvfzJu4LEx6539P3cmP
	 3budOAeNFh8B6OauPJMC6V3Pm8QX1/GVga6EYL25Vk+1HaQrUQ5Y9a1NToADDkKrOl
	 3GmH+iuCay6j17hwGRU4lNI7W6uewkJNwcox2C6M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgIALbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 07:31:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726922AbgIALZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:25:27 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BCC62083B;
        Tue,  1 Sep 2020 11:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598958490;
        bh=M/gIeLcJ2zVJl2Ut67sxzpfCdDlyqzk0freIT8v084g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BZy5W/btSM8j5ieOU3Lkd/o/cf81UNFXZOs7IdZVDmDsLdhyOCvQmv5FbQCwl9H6B
         mgdLcEzTqQ24kpqHfwLVD04S/b+Hju8RFyN455BYX3EfRbnHDw0q9qJJnP4LrNQKjt
         3fnRdPl1V7BGCkeE4TeawBf6ya8ZNspqdZPml+Uo=
Date:   Tue, 1 Sep 2020 13:08:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     antoniprzybylik <antoni.przybylik@wp.pl>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gdm724x: gdm_tty: corrected macro by adding
 brackets
Message-ID: <20200901110838.GA273488@kroah.com>
References: <20200901104311.17270-1-antoni.przybylik@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901104311.17270-1-antoni.przybylik@wp.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 12:43:11PM +0200, antoniprzybylik wrote:
> Such macros are dangerous. Consider following example:
> 	#define GDM_TTY_READY(gdm) (gdm && gdm->tty_dev && gdm->port.count)
> 	GDM_TTY_READY(a + b)
> This macro will be expanded in such a way:
> 	(a + b && a + b->tty_dev && a + b->port.count)
> And it will lead to errors.

This is for a pointer, no one would ever do that :)

But, if you really worry about this, turn it into an inline function,
that way you get the proper typedef safety, which is what something like
this should really be, not a macro.

thanks,

greg k-h

Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C9EC35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6DF0206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581936321;
	bh=e5AY/FD59F7byWOR8uC2uz9sYdDepispIWwjTCj+Uk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iXngJkmAWWidkYXhxXnuXm6o17SyRpCNUu6zoR5Kdd+AJw1n496fiMTm71QRkCm/O
	 Se4iS8uLieF0pPsSyOXIoRzKzSF/NgJ91vRIhluA+GPuyqHhihWPzyyVRU3PFpnej4
	 jDsaJ3zWT6de80zcDYezX/BD7/nEdSEPUStwG6k0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgBQKpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 05:45:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:48284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbgBQKpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 05:45:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F241206F4;
        Mon, 17 Feb 2020 10:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581936318;
        bh=e5AY/FD59F7byWOR8uC2uz9sYdDepispIWwjTCj+Uk8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OmFzGbn5GKnqQ2W+AaU43q/4YKr57jwJZxit/l7VGdMK4yQiIrBeJXqdNdwp98R58
         80G441JG7iEdazl8MPOsgDDoUYl9KsbIKoTR1h79mzJfRXzLNQSEGaQrAPhQ72MJpq
         gj8CyEAio25L9WAhb0T/RO+4fKXsV28OMGyRqbJc=
Date:   Mon, 17 Feb 2020 11:45:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     chanwoo@kernel.org, myungjoo.ham@samsung.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] extcon: Remove unneeded extern keyword from
 extcon-provider.h
Message-ID: <20200217104516.GA94720@kroah.com>
References: <CGME20200217103927epcas1p2f0cf3c28dbc78d991ef8f4895e4717dd@epcas1p2.samsung.com>
 <20200217104728.29330-1-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217104728.29330-1-cw00.choi@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 07:47:28PM +0900, Chanwoo Choi wrote:
> The commit tb7365587f513 ("extcon: Remove unneeded extern keyword
> from extcon.h") removes the unneeded extern keyword from extcon header
> file. But, The commit tb7365587f513 has missed that deletes 'extern'
> keyword from extcon-provider.h. So that it deletes extern keyword
> from extcon-provider.h.
> 
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> Dear Greg,
> 
> When I removed the unneeded extern keyword from extcon hearder file for
> v5.6-rc1, although I should remove 'extern' keyword on both extcon.h
> and extcon-provider.h, I only removed them from extcon.h. It was my mistake.
> 
> So that I send this patch for v5.6-rc3 release.
> Could you review and apply it to char-misc git repository directly?

Sure, but it's not really a bugfix, I'll queue it up for 5.7-rc1, ok?

thanks,

greg k-h

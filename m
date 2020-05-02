Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AAAC3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 06:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30D5824956
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 06:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588399439;
	bh=jH1yteU7OX6qn53YfEKiMOYInLBjYqp7gSStdfUjzoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2MTwEmyiKa/Zw2Y6ljyY6lkMmc3LnTLQzxEg+OfGN5pCx0KTroQU4r5OAmaU3/y3F
	 ySxIFhk3H7t7L8vC3KERcYwRhYvYshrkNaHDpisliSyJ+sRmagESBL6YIV7JFxDjAu
	 vW8njnIrjoxoC/zys2QW5PJ/l+VfKPhp6a3kIAXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgEBGD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 02:03:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726468AbgEBGD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 02:03:58 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 453B02137B;
        Sat,  2 May 2020 06:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588399437;
        bh=jH1yteU7OX6qn53YfEKiMOYInLBjYqp7gSStdfUjzoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hcrXTztDpnSfPoplxgITFTI2dLWI3RngawA5BTKTZf6py51NR9u+9T75Vu/EH2USq
         Uf71SWwnxBIdCJ5/+vzcPNnWAFj6suLBqeADogyDsHjnv9j8GucZfmreQSmh+C7odY
         EXtgTCA+b1/KCAOts6bf2nV1ulHESU7QBHrOCuiE=
Date:   Sat, 2 May 2020 08:03:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-media@vger.kernel.org, Alan Cox <alan@linux.intel.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Ressurect the atomisp staging driver
Message-ID: <20200502060355.GA2524474@kroah.com>
References: <20200501215741.3be05695@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501215741.3be05695@coco.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 09:57:41PM +0200, Mauro Carvalho Chehab wrote:
> This driver is simply too big for it to be sent to the ML via e-mails. Those
> will very likely be rejected due to the e-mail sizes.
> 
> So, instead, I'm sending a "GIT PULL" to myself, at the ML.
> 
> This series basically "resurrect" this driver from the death, giving it a
> second chance to survive.

Hah, good luck!  Without the hardware I think you are going to be
fighting a loosing battle, best of luck...

greg k-h

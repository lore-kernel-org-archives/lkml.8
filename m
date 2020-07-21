Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED0AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B44B22080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595331227;
	bh=Mg6L1cR7Ir4UqEXXKL4h/HOxKKegC7bgckzLjWHf03E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m33fb4VAmmYC8e+9gnsBeJPm7G2XuCTJZU5VAhK9Gbzv2kWSd2LJLPacST0vFRFAm
	 Kz9BIibFf15jjB90huWD5mvg5dKqCYVMdCeSb8uiBvCnsvR+1pzo+5bLjs2q/rjch7
	 k0F7s7Xayyq6u/ivazPpA0GxET886oRCopAk+nec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbgGULdq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:33:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgGULdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:33:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F832206F2;
        Tue, 21 Jul 2020 11:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595331225;
        bh=Mg6L1cR7Ir4UqEXXKL4h/HOxKKegC7bgckzLjWHf03E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MKKZRAuRSOYspVvmRoUmEGX/onlIPbHSCRzt75offJy0YinwoNaV1OYgOYFWjwBdH
         WCzW83kOadlAR/4pgOZyfQDcdzsKQi1Q4TrHiDlucy1DEHBZ5iWAxSfbVsMcWZVryC
         XYgebVnhamm5EbTSZXm+qR10TwLcPdP1Xj5aLlAo=
Date:   Tue, 21 Jul 2020 13:33:53 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Eddie Hung <eddie.hung@mediatek.com>, stable@vger.kernel.org,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>
Subject: Re: [PATCH v2] usb: gadget: configfs: Fix use-after-free issue with
 udc_name
Message-ID: <20200721113353.GA1686460@kroah.com>
References: <1594881666-8843-1-git-send-email-macpaul.lin@mediatek.com>
 <1595040303-23046-1-git-send-email-macpaul.lin@mediatek.com>
 <1595041133.23887.4.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595041133.23887.4.camel@mtkswgap22>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 10:58:53AM +0800, Macpaul Lin wrote:
> On Sat, 2020-07-18 at 10:45 +0800, Macpaul Lin wrote:
> > From: Eddie Hung <eddie.hung@mediatek.com>
> > 
> 
> Well, it's strange, I simply replaced the uploader's name to my
> colleague, git send-email pop up this line automatically.
> 
> Shouldn't I do that kind of change. It did not happened before.
> Do I need to change it back and update patch v3?

Who is the real author of this, Eddie or you?  If Eddie, this is
correct, if you, it is not.

thanks,

greg k-h

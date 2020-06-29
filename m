Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C05EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 205862073E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466257;
	bh=ftGuVRVgqjk9PwokZ1ZSRnJZM48vH8egkh8R/K03F7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2Fq5+ABkTEjRdxS7SkNj99eJl1nDR1t1w5rOXbzaxF+5vMCdkig6NL+3qdqgy6QRh
	 lpzIwhb9dXczniYE4hpzSHogHmUclq8B00JHfBj+MqQ1Q9vdA4JHmDHl/Lx7iGu3kH
	 oKL5Kixwh1q7gOv0yZEXsDTRAjmJ2v6qaZeG20dQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391245AbgF2Vaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:30:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728828AbgF2SlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A853023134;
        Mon, 29 Jun 2020 08:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593418249;
        bh=ftGuVRVgqjk9PwokZ1ZSRnJZM48vH8egkh8R/K03F7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EKuRkQ2BiHMfRIFe8CdjR0qvDn5rm9WrsWhrFDzsY8en1EUHyk0ruTgCkPe/OYRt0
         2+mzFCouHUepwnCP70mA3qtzrpPe1KZ5WvIrkzLiWNdrfzBdQSoVgYlB0z/wyBUTi0
         jrwx4ip6uZf+jqAyXNew5BbRdkospW90++G+Oxn8=
Date:   Mon, 29 Jun 2020 10:10:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH 2/2] usb: mtu3: fix NULL pointer dereference
Message-ID: <20200629081039.GA1221843@kroah.com>
References: <1593410434-19406-1-git-send-email-chunfeng.yun@mediatek.com>
 <1593410434-19406-2-git-send-email-chunfeng.yun@mediatek.com>
 <99fc1f6e-7907-6723-612a-8b68ffa871e5@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99fc1f6e-7907-6723-612a-8b68ffa871e5@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 10:00:22AM +0200, Markus Elfring wrote:
> > Some pointers are dereferenced before successful checks.
> 
> I suggest to reconsider and improve the change description.
> 
> * Would a null pointer dereference be possible only with the variables “mep”
>   and “mreq” in the implementation of the function “mtu3_gadget_dequeue”?
> 
> * How do you think about to adjust any more variable initialisations?
> 
> * Will it become helpful to add the tag “Fixes” to the commit message?
> 
> Regards,
> Markus

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC99EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B857F2186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592468465;
	bh=i7/azv2TIyitmWBxI8oESfdLcS5YpjhAKYG10IPi8qM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0n2UJYxukfkc1R4pUA9e9FT+tamqGAuyPVMwEb9qtO0YjXbLJCQJkAlHxCUU622w+
	 sO3HzeQPgFWS+MWE5kMUH/I7Ky23FMBukxYYcpvtR+JVSxz4rGAhrgVfTWPGK3trDG
	 AwC+KOreMEzNF4540AXBoU2fmaymPOWQ4Ecaophs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgFRIVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 04:21:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:50666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727039AbgFRIVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 04:21:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D58652166E;
        Thu, 18 Jun 2020 08:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592468462;
        bh=i7/azv2TIyitmWBxI8oESfdLcS5YpjhAKYG10IPi8qM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MwaAHevJxbmGhQOPCng+twAill0hon0Zl/MAunJDD+uOpVJiSgR1DakpD/8Rk/gdA
         +zNVGnTdTaJ3krZC+P0UcO7vSvxwDNyuP3nbD1eyiNmbPuKIoEqXKP0lt86Hp8dVVn
         SJIQd+0mvrThE5z2GK0Vra+yPesqHuK57QAOEEsk=
Date:   Thu, 18 Jun 2020 10:20:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Jim Lin <jilin@nvidia.com>,
        Siqi Lin <siqilin@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>
Subject: Re: [PATCH v2] usb: replace hardcode maximum usb string length by
 definition
Message-ID: <20200618082055.GA1049665@kroah.com>
References: <1591939967-29943-1-git-send-email-macpaul.lin@mediatek.com>
 <1592201855-8218-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592201855-8218-1-git-send-email-macpaul.lin@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 02:17:35PM +0800, Macpaul Lin wrote:
> Replace hardcode maximum usb string length (126 bytes) by definition
> "MAX_USB_STRING_LEN".
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
> Changes for v2:
>   - Add definition "MAX_USB_STRING_LEN" in ch9.h instead of in usb.h.
>     Thanks for Alan's suggestion.
> 
>  drivers/usb/gadget/composite.c |    4 ++--
>  drivers/usb/gadget/configfs.c  |    2 +-
>  drivers/usb/gadget/usbstring.c |    4 ++--
>  include/uapi/linux/usb/ch9.h   |    3 +++
>  4 files changed, 8 insertions(+), 5 deletions(-)

This patch fails to apply to my tree (or to 5.8-rc1).  Please rebase it
and resend.

thanks,

greg k-h

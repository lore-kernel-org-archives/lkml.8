Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8D5C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F4221534
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598601209;
	bh=JhNpVsbHlCL1Udn63YeuVXj535D89OBHVFbUoaahHqY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=x8QsV0Ec5CgNZiK7XqbcfGtZmTSYT/te5rZF9gcOwzx0h/SDlRbvELV+l8KULzu35
	 rRZnv59JSxAMUVC0fmybkZvUu0iSwMIJtySXJdOXikFrbBYOIeFblqmAd2/uhzx5e5
	 PAwKZqVIfDMXeAOkwXzYrTm6UGX8b9jyMAaAgeLI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgH1HxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:53:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgH1HxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 03:53:22 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C6F92078A;
        Fri, 28 Aug 2020 07:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598601201;
        bh=JhNpVsbHlCL1Udn63YeuVXj535D89OBHVFbUoaahHqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Htf22TTBK/Pxy8ac6VUWhqB+Gt6XhjgKwY/e110mYWixXOR676XFHXlk9ZGaTk20G
         yMBKVKO/e7vnCTWesykp7ysxN4e9vwj2ZpV8j52yto8TWV4NG8nO+FCFK1iAj5r/SG
         WPQyb84RZUDPXCyBbDoAsLZ+OTxGLsLtjBs7yFYQ=
Date:   Fri, 28 Aug 2020 09:53:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Lee Jones <lee.jones@linaro.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [PATCH v3 01/11] usb: early: convert to
 readl_poll_timeout_atomic()
Message-ID: <20200828075334.GA998738@kroah.com>
References: <1598083553-31896-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598083553-31896-1-git-send-email-chunfeng.yun@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 04:05:43PM +0800, Chunfeng Yun wrote:
> Use readl_poll_timeout_atomic() to simplify code
> 
> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2~v3: no changes
> ---
>  drivers/usb/early/xhci-dbc.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)

No patches in this series applied to my tree :(

Please rebase and resend them against the usb-next branch of my usb.git
tree on git.kernel.org

thanks,

greg k-h

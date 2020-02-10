Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B989C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0DE20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581361103;
	bh=XhsDSqmZAV5GAixCR38jksBySp8eRi3o9QvzAGZo0T0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CyKrOTwOna9L3+HTuqSS9e5prp9qZ2Mi9qJ9OrGudVcbiH+qTNEmw2r7J1k8W+aUe
	 f7kH2P4uhrnRgA/N97G59ivleP3ohWoGDtOqKErcuWQSDjcW2+RXrERYQ2sF8/x0tg
	 2QDwpcfgrjIjiQ2x5iuAuS+2R0MpowxK90HCyTgY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgBJS6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:58:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbgBJS6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:58:23 -0500
Received: from localhost (unknown [104.132.1.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 475222085B;
        Mon, 10 Feb 2020 18:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581361102;
        bh=XhsDSqmZAV5GAixCR38jksBySp8eRi3o9QvzAGZo0T0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fIxlTXuChg1UrtQ3SPibVHWtPQcF/pz1KL2gIKL6c98MEEg8ZkvufcuMOuVVYDIu7
         Y+Ark2JbEzwEmEDSqMSUsX17i4mlOva9YAwF//tnPztNFiCI1Wr3cWXUivWLPRB3/H
         Bi6rOloB/jdx2IepZVYCBFyvlbcpd42Sy5XwxzfE=
Date:   Mon, 10 Feb 2020 10:58:21 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     JC Kuo <jckuo@nvidia.com>
Cc:     thierry.reding@gmail.com, robh@kernel.org, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        felipe.balbi@linux.intel.com
Subject: Re: [PATCH v1] dt-binding: usb: add "super-speed-plus"
Message-ID: <20200210185821.GA1057764@kroah.com>
References: <20200113060046.14448-1-jckuo@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113060046.14448-1-jckuo@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 02:00:46PM +0800, JC Kuo wrote:
> This commit adds "super-speed-plus" to valid argument list of
> "maximum-speed" property.
> 
> Signed-off-by: JC Kuo <jckuo@nvidia.com>
> ---
>  Documentation/devicetree/bindings/usb/generic.txt | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

What ever happened to this?  Did the DT developers see it?

I suggest resending please so it gets into their queue to review.

thanks,

greg k-h

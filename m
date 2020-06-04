Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D131C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CD79206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 20:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591301836;
	bh=3GiddxXcnsJSK2ifatJjmaNUgk6h6y7Z56UEGVh1O1M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YEXfmIYRWOnrgSXXIE+a35RKnCqe75yUxvRHT1f5qCYvGFbND2OKf5w7u7qUon714
	 f+94KYDJpJp1nbz87UIAQJHc4/KtXj+2kXYZACsaAdsl8Q6o1uBuJRBMAAEIBVkzAe
	 BLztHx6WNJzFFUtSOA5eQMNC8GrYSx1oRMGelq2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbgFDURP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 16:17:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:59982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726906AbgFDURO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 16:17:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21D242067B;
        Thu,  4 Jun 2020 20:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591301834;
        bh=3GiddxXcnsJSK2ifatJjmaNUgk6h6y7Z56UEGVh1O1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hbhAowt+aoDCZ+6E8FvGSei/hevOkxDLMqAs6gssavrCffU/MkJt0HUxCGAf0cKAr
         lbwox2hJW/QBpg5mLG0q8CcA9jY5Vymn1VN/nLclhe8v3BP4hRTi58s+mCWyW0bxWn
         w62eEJ2PsLrLx2CW9uE5ALP+7wezwY4zPdN3jA1I=
Date:   Thu, 4 Jun 2020 22:17:12 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David =?utf-8?Q?Bala=C5=BEic?= <xerces9@gmail.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Guillaume Nault <gnault@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 4.19 12/80] pppoe: only process PADT targeted at local
 interfaces
Message-ID: <20200604201712.GB1308830@kroah.com>
References: <20200518173450.097837707@linuxfoundation.org>
 <20200518173452.813559136@linuxfoundation.org>
 <CAPJ9Yc8YOeqeO4mo80iVMf3ay+CkdMvYzJY1BqXMNPcKzL6_zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPJ9Yc8YOeqeO4mo80iVMf3ay+CkdMvYzJY1BqXMNPcKzL6_zg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 08:39:00PM +0200, David Balažic wrote:
> Hi!
> 
> Is there a good reason this did not land in 4.14 branch?
> 
> Openwrt is using that and so it missed this patch.
> 
> Any chance it goes in in next round?

Does it apply and build cleanly?

I don't know why I didn't backport it further, something must have
broke...

greg k-h

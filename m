Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEA0C33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 14:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3F32469C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 14:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579356407;
	bh=VrGnymp6n3Xiztc2LQMXHxuOmTaM8xjGDPxYp0IWfuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PE0YqXWjrFdtx5n5o+Y0wx5lrGkEwtjt7x9gvVE+d2id7WJ1scnvX73DA3rqznO1h
	 04MXHQxB2u8rgPNfQQakQgvS3M7+gR/4xfuos0BMM/69V5hyRflfG/BOU9MQN1VL8u
	 N4tMEPU/os7yZ1qq8UX0ESdVM8x5fYn6kf1ywUOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgAROGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 09:06:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:36468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgAROGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 09:06:46 -0500
Received: from localhost (170.143.71.37.rev.sfr.net [37.71.143.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C375824699;
        Sat, 18 Jan 2020 14:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579356406;
        bh=VrGnymp6n3Xiztc2LQMXHxuOmTaM8xjGDPxYp0IWfuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ro5w3msV1RRAuGYQvyI2e+1zqHAAHgK+X6EP5zVVsS//2UoVOXgavEufTIrKMOvIb
         28J+GWSmWLjG/YUe/ySV5UV7w0r6/uomGxst6wnBJm4Cz0mzR37w3PDjiEaFttcKEw
         0aHhSvlbA1v2M+iFmc/JKH76phXxptiwrZj6ueK8=
Date:   Sat, 18 Jan 2020 15:06:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] coresight: next v5.5-rc6
Message-ID: <20200118140644.GA76711@kroah.com>
References: <20200117185607.24244-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117185607.24244-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 11:56:06AM -0700, Mathieu Poirier wrote:
> Hi Greg,
> 
> Just a single patch to add for the next cycle.
> 
> Thanks,
> Mathieu
> 
> Arnd Bergmann (1):
>   coresight: etm4x: Fix unused function warning
> 
>  drivers/hwtracing/coresight/coresight-etm4x.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

I figured it out, this is already in my tree and scheduled to go to
Linus later today...

greg k-h

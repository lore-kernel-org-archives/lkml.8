Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81897C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 618DD2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594364609;
	bh=dYmX8RjtgwOU2jBuCzoVMgaEAnNs+JRhXV9g96pNMig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CL1P6deG3qIX0dnKiM5FisVYEcvaJGAGWKenAfp2oVNXGrCrwpN/RkvA4r0mzOm8g
	 seXEXyQJIvlY2aGhYx0i9hRCnG6ET9jjUSzjCNI2hy8Y9+FjIsaxqqNamEl5MZQtpb
	 o2LTaly10FIOp85xChd52JdbpZm8fgKfYPwlCdNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgGJHD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 03:03:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgGJHD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 03:03:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 772B2206A5;
        Fri, 10 Jul 2020 07:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594364607;
        bh=dYmX8RjtgwOU2jBuCzoVMgaEAnNs+JRhXV9g96pNMig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tXMGoA2tehFXUGrgwmIUsE7gEF6y2rI6hf/0Uezb6hTzCT7LTuNv/+zACyqzy1Eys
         9apna7cSxzRYDMjl5iJTc3LIuw1UqjPgFSbA/8zav8ePmYiHQt5ptp/fhR5skjhnXm
         L7+/BqOW+9jTs9t49dw15fl7b6sH6nLSGifcJpY4=
Date:   Fri, 10 Jul 2020 09:03:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [RESEND PATCH] media: atomisp: Replace trace_printk by pr_info
Message-ID: <20200710070332.GA1175842@kroah.com>
References: <20200710144520.RESEND.1.Id0f52f486e277b5af30babac8ba6b09589962a68@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710144520.RESEND.1.Id0f52f486e277b5af30babac8ba6b09589962a68@changeid>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 02:45:29PM +0800, Nicolas Boichat wrote:
> trace_printk should not be used in production code, replace it
> call with pr_info.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
> Sent this before as part of a series (whose 4th patch was a
> change that allows to detect such trace_printk), but maybe it's
> easier to get individual maintainer attention by splitting it.

Mauro should take this soon:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

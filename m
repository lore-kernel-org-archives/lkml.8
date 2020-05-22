Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646B8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 05:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3238B20759
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 05:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590125573;
	bh=6pR+6XGvDD997W518VAgh1BZ5r0RWs9xZoUSBvMkuZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WdltY2CjEFH4jfvQGIk3vBABx624DXIMzG++r7amiAYeF7iRFD30/eD1VQpNHn5rK
	 +Cn+8WhRVeAe5K/dUkxPA0e9u7WvGDbfV9/JqST5bkSK8hnvLjn6jD89HU0Jd9WEX5
	 R5rNQwsG0kRMWTR+dSfidCqqYi1PFHjh8SYVzpLE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728169AbgEVFcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 01:32:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:59512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgEVFcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 01:32:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B7842073B;
        Fri, 22 May 2020 05:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590125571;
        bh=6pR+6XGvDD997W518VAgh1BZ5r0RWs9xZoUSBvMkuZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YHnnUGPrz1+U3I6Lolea82Y4C969Op1xLSprKUmCC+Gf7DJKr5kvWVfReIZMh1vRJ
         YUxzgOuduqxKTQ/UMc3N20WNCqvga8eXIXEXQJFCOefe1aNfpOS8xJkmF6vQHYT1nh
         ewafJ/Pod1VFONkWlJ/0frgNJ4W/4wLv+oY7Z/Ck=
Date:   Fri, 22 May 2020 07:32:49 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     dinghao.liu@zju.edu.cn
Cc:     kjlu@umn.edu, Bin Liu <b-liu@ti.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] [v2] usb: musb: Fix runtime PM imbalance on error
Message-ID: <20200522053249.GA616391@kroah.com>
References: <20200522025902.11516-1-dinghao.liu@zju.edu.cn>
 <20200522051222.GA523130@kroah.com>
 <2ca9a5fc.be29f.1723ad51c1d.Coremail.dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ca9a5fc.be29f.1723ad51c1d.Coremail.dinghao.liu@zju.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 01:22:24PM +0800, dinghao.liu@zju.edu.cn wrote:
> Sorry, it's my carelessness. In v1 I added pm_runtime_put_autosuspend()
> after copy_from_user() to fix this problem. Since copy_from_user() is
> moved to the beginning now, we need not to add PM decrement. 

THat's fine, please put that information in a v3 and resend it.

thanks,

greg k-h

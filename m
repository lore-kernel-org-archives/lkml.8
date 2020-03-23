Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB9AC4332E
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F11920719
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584990186;
	bh=yD6k3tOPv3TonJQXAyleomSnTMu0yIQmfZBOylOVK0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vFdHr2PhbAMEvMVH+WItPaps65rmXUWLfl1G21tLk2uBNh/ROPzXlN1PKQ/kdpQRI
	 DoVtvwMH0g8E+ckKPachDCliFuSBAebX5NvKozAT1HsSnMypOvF9zH8QI7Vzk/N+R7
	 ZJ84MATqgLybv/TZCw3aqIhTaM9WPmtOof3rb4+I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727696AbgCWTDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:03:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:54288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbgCWTDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:03:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BF612051A;
        Mon, 23 Mar 2020 19:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584990182;
        bh=yD6k3tOPv3TonJQXAyleomSnTMu0yIQmfZBOylOVK0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MT6ftKgFSoY7zi1rkguZr3WKyFdIfCYFlcTs5ST0vcm9MGXpcmZ1j6AqeOYu6p19R
         0rVpq2fEZf/RlzGuXZVxWSqyZIWhTt89Q2SDLuxptgB8pKowZvjyqItu34M7MrgJo9
         X//zsAwXu1J2/OhlDni/wLZvodhL1VkZbRhBWA80=
Date:   Mon, 23 Mar 2020 20:02:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Freeman Liu <freeman.liu@unisoc.com>,
        Baolin Wang <baolin.wang7@gmail.com>
Subject: Re: [PATCH 1/5] nvmem: sprd: Fix the block lock operation
Message-ID: <20200323190259.GA632476@kroah.com>
References: <20200323150007.7487-1-srinivas.kandagatla@linaro.org>
 <20200323150007.7487-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323150007.7487-2-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 03:00:03PM +0000, Srinivas Kandagatla wrote:
> From: Freeman Liu <freeman.liu@unisoc.com>
> 
> According to the Spreadtrum eFuse specification, we should write 0 to
> the block to trigger the lock operation.
> 
> Fixes: 096030e7f449 ("nvmem: sprd: Add Spreadtrum SoCs eFuse support")
> Signed-off-by: Freeman Liu <freeman.liu@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/nvmem/sprd-efuse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This should go to stable, I'll add the tag...

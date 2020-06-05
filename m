Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3395EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 15:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC1220823
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 15:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591372086;
	bh=O9/yLtTz6iE7aC6a/TCdR+WuOXswCWujrU6CSoAYFNg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=px3myu6YMyBzFfRvqkuqgRTx+g/PM9TTuIQmeBPnsHW+IxQVxLHJJCKaQ5PQbkWVe
	 Uqdq6/Oi5bLY9CEQldkYJTZQncANY2+8xtihAJcqvfwwncqnDkdQ3jPTP4ncsLN8go
	 mI/sgmrU0f8f143wKR/MWSW6lij5DtP73d+UNwMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgFEPsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 11:48:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726914AbgFEPsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 11:48:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 863682074B;
        Fri,  5 Jun 2020 15:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591372084;
        bh=O9/yLtTz6iE7aC6a/TCdR+WuOXswCWujrU6CSoAYFNg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=clJT1c1RiOYG2aIg42f18pscNAm1Uix6ag/Ac3t7FKvHAjoUM2gLbvBNt6un98W65
         hCIF8iXbKBlfPDNGxFZlzCEBcihDGxsbswVOxN7sSIDfk8IDU8TGFucJ7Fae+qKX/2
         eirSqFIqXrTpU8t2o8ETiUXhEbxkT/aiU3sRmqm8=
Date:   Fri, 5 Jun 2020 17:48:01 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 5.6 00/43] 5.6.17-rc1 review
Message-ID: <20200605154801.GA3314871@kroah.com>
References: <20200605140152.493743366@linuxfoundation.org>
 <dee14be9-f6fd-30f7-f399-4e74b104eefc@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dee14be9-f6fd-30f7-f399-4e74b104eefc@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 09:30:36AM -0600, Shuah Khan wrote:
> On 6/5/20 8:14 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.6.17 release.
> > There are 43 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun, 07 Jun 2020 13:54:56 +0000.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.6.17-rc1.gz
> 
> wget https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.6.17-rc1.gz
> --2020-06-05 09:24:32-- https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.6.17-rc1.gz
> Resolving www.kernel.org (www.kernel.org)... 147.75.56.137
> Connecting to www.kernel.org (www.kernel.org)|147.75.56.137|:443...
> connected.
> HTTP request sent, awaiting response... 301 Moved Permanently
> Location: https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.6.17-rc1.gz
> [following]
> --2020-06-05 09:24:32-- https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.6.17-rc1.gz
> Resolving mirrors.edge.kernel.org (mirrors.edge.kernel.org)... 147.75.69.165
> Connecting to mirrors.edge.kernel.org
> (mirrors.edge.kernel.org)|147.75.69.165|:443... connected.
> HTTP request sent, awaiting response... 404 Not Found
> 2020-06-05 09:24:33 ERROR 404: Not Found.
> 
> Looks like patches didn't make it to mirror yet? Seeing the same
> error with the other stable patches.

Hm, odd, let me go push them out again, might have been an error on my
side.  Give them a few minutes to be mirrored...

thanks,

greg k-h

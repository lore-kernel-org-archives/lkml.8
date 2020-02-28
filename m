Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33020C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E81246AE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582891189;
	bh=bgHynsnqLBPu8rlhZMjEUerJKPDtp9SwNd0CcyGneD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i9ZOVepl6yctNBB6IwuoLM44I92DxqlWrFX+WMAut8ymz+xWs4GOV45zUld1fJV5W
	 YPXTJAU7Rxgmd8fM0bU6VYo1yoGyz5OU5X4VtkYz7TwQ5R/Bvn380V87V3uo96cy92
	 UoYytl23L1hAVzraH8v0qvVe+yapawvD6rTvErkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgB1L7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:59:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:41374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgB1L7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 06:59:47 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2B7B24695;
        Fri, 28 Feb 2020 11:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582891185;
        bh=bgHynsnqLBPu8rlhZMjEUerJKPDtp9SwNd0CcyGneD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sbZI4iTBz4TK667SkbfOn9ffDdh8p8SwFD2IAdYjwRnXE2YWo8YFi31fAYRrr+n4y
         Fz61kdmNNX2z6+zelXsqmQpCAZFY+dZ4eeXK4cuOeKSNwxPKSGJJPpncXAHk7pDxAf
         8jrTY+CyHF2XJZEe8SAzzvB1bXBUMZ4bOexqn8/Q=
Date:   Fri, 28 Feb 2020 12:59:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/237] 4.14.172-stable review
Message-ID: <20200228115942.GB3010957@kroah.com>
References: <20200227132255.285644406@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 02:33:34PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.172 release.
> There are 237 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 29 Feb 2020 13:21:24 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.172-rc1.gz

-rc2 is out to hopefully resolve some powerpc build issues:
 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.172-rc2.gz


Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED52C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0EF92084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599216191;
	bh=Xu0I2POKS+CaOprhzvVE8u5rgoy0VjamFgilzIRsWFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v388ZH04w4kyhfgCgdjc6uX3WfjbKQuwiyo169nZ84quc1EnRU8nO7ye3ZfQePxN6
	 hRqRIIaq5u/yPSiIWL8PYFEAzLmzmWJgBehLyelERBv9N7jh6isv9LGOp55z5aznGj
	 MgDi7b08Z45W8Spofv5+9RjKpHnp1XHz5yrW5Nos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730010AbgIDKnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:43:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:56622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726171AbgIDKmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:42:17 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40E072084D;
        Fri,  4 Sep 2020 10:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599216136;
        bh=Xu0I2POKS+CaOprhzvVE8u5rgoy0VjamFgilzIRsWFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iK9F7Cc3oDD6ltaGLz24BF11wzYsN9OUzaGerACJp7iypbLmyaNwmel2i5hzvru0A
         AKqhHM6yrWwevs4BFG9KJnYBNmIa3E1VKztfRaCL3kV3DxEoKr5llH+NrpyigJLjs9
         mrU7C0vLa87BfrCQh9N3VhkCQdizU0xzjQn4mjNU=
Date:   Fri, 4 Sep 2020 12:42:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: PHY fixes for v5.9
Message-ID: <20200904104229.GB2718648@kroah.com>
References: <20200904101750.GA2639@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904101750.GA2639@vkoul-mobl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 03:47:50PM +0530, Vinod Koul wrote:
> Hi Greg,
> 
> Please pull to receive the fixes for PHY subsystem. Cooupld of fixes on
> QCOM driver and one on TI driver
> 
> The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:
> 
>   Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-fixes-5.9

Pulled and pushed out, thanks.

greg k-h

Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CCD2C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1857E21D81
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599766730;
	bh=NG93nN+HmNDOMundStCbsZdACPtwjFTiyShXPaCw+R4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CsEQqBYDrNAW3iJLW+jhenI7L31SNeJB3RiXE/sNninzYsauLwy4RNtdSzo+lIaoh
	 95/9WZKMk6KtkTprg1kWZqRu1UjCN7VTbj+xavTT5dyqs/LmHk/9+y1iVonVl9RanA
	 1usq6gsiiL/R9cT9Y+AuBP/rkVLDJ1qTshhec1nY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgIJTis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:38:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:50552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727028AbgIJTib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 15:38:31 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D402521556;
        Thu, 10 Sep 2020 19:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599766701;
        bh=NG93nN+HmNDOMundStCbsZdACPtwjFTiyShXPaCw+R4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=m6oEoKV1CqxnMH0N1kP3KyM4HasLH15ztnFX8uVPmhajVatp6QvhMxYVetRU8VVCl
         RjGP6MvqeEGQ2k359ryfQwU4+jQz3vxLnT5Ca0bHSm1s0Sz4km1+X4ncu8faOsDcRU
         TPBMZKL8HADa5IIYwmRygZwBFJtFWwNUGb//xry0=
Date:   Thu, 10 Sep 2020 12:38:19 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Wang Hai <wanghai38@huawei.com>
Cc:     <jeffrey.t.kirsher@intel.com>, <davem@davemloft.net>,
        <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 0/3] Fix some kernel-doc warnings for
 e1000/e1000e
Message-ID: <20200910123819.3ce47422@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200910123800.74865996@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20200910150429.31912-1-wanghai38@huawei.com>
        <20200910123800.74865996@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Sep 2020 12:38:00 -0700 Jakub Kicinski wrote:
> On Thu, 10 Sep 2020 23:04:26 +0800 Wang Hai wrote:
> > Wang Hai (3):
> >   e1000e: Fix some kernel-doc warnings in ich8lan.c
> >   e1000e: Fix some kernel-doc warnings in netdev.c
> >   e1000: Fix a bunch of kerneldoc parameter issues in e1000_hw.c  
> 
> You should put some text here but I can confirm this set removes 17
> warnings.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

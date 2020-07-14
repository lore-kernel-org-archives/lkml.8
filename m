Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A4DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF40322453
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594735412;
	bh=ItaWtzeKZou397LLEwwUDYq2U/2uSJnhZHcdNJRYguA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qm0LVQ8WoieUtlCDZHMuThTs7igfpI8lcDYIhmEV8xhvfawYcXcz1/k1NGTNHqDEf
	 yyeLu76usUXIhkfMWpXkL4mc+iQ30Pmzwi/MhWhtpDO1WGGI4eBbAV37UuNEiOHAIj
	 RZO9G8ei+3WGq7k5pFu8g5arxszMrpbgW8jEpRg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgGNODb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:03:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgGNODb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:03:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F20F22267;
        Tue, 14 Jul 2020 14:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594735410;
        bh=ItaWtzeKZou397LLEwwUDYq2U/2uSJnhZHcdNJRYguA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HgNnSq2yhQ6Aj7nARD3HAxMHIxs0RdbweDZXxa0SCRfWWvFrxwWmvbTgvhBeLpJWF
         QvMCbiVQDJDbsYPaDp0CbMomVgba9w7XdhzocIK8o35ZpW0fL7WmFPM9wxoA7bDQQ+
         qR16UAwcyMXDdxOHeUD5u/vG5LR6Uz8XCIfvymG0=
Date:   Tue, 14 Jul 2020 16:03:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gordan Bobic <gordan@redsleeve.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: perf: =?utf-8?Q?util=2Fsyscalltbl=2Ec?=
 =?utf-8?B?OjQzOjM4OiBlcnJvcjog4oCYU1lTQ0FMTFRCTF9BUk02NF9NQVhfSUQ=?=
 =?utf-8?B?4oCZ?= undeclared here (not in a function)
Message-ID: <20200714140328.GC1698833@kroah.com>
References: <CAMx4oe34RcVeaA+sz6vFN-CyNtwdPxj+oTBQjWiM4C7iAqnLGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMx4oe34RcVeaA+sz6vFN-CyNtwdPxj+oTBQjWiM4C7iAqnLGw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 11, 2020 at 01:05:43AM +0100, Gordan Bobic wrote:
> I hit this FTBFS earlier today while trying to build the LT 4.19.132
> kernel from source:
> 
> https://lore.kernel.org/patchwork/patch/960281/
> 
> The "quick hack" patch mentioned at the bottom of the thread gets it
> to compile. Is this the correct solution, or is there a better fix? As
> it stands, tools/perf doesn't seem to compile on 4.19.132.

No idea, try asking the perf developers.

thanks,

greg k-h

Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41079C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23293206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 12:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbgFDM3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 08:29:34 -0400
Received: from foss.arm.com ([217.140.110.172]:43864 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbgFDM3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 08:29:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBBE61FB;
        Thu,  4 Jun 2020 05:29:32 -0700 (PDT)
Received: from bogus (unknown [10.37.12.7])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 972253F6CF;
        Thu,  4 Jun 2020 05:29:31 -0700 (PDT)
Date:   Thu, 4 Jun 2020 13:29:25 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: linux-next: Fixes tag needs some work in the scmi tree
Message-ID: <20200604122925.GA12397@bogus>
References: <20200604221328.2e6b8d98@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604221328.2e6b8d98@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 10:13:28PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   8a8cd9a91081 ("arm: dts: vexpress: Move mcc node back into motherboard node")
> 
> Fixes tag
> 
>   Fixes: d9258898ad49 ("arm64: dts: arm: vexpress: Move fixed devices out of bus node")
> 

Sorry for that, I must have checked it. Will fix it.

-- 
Regards,
Sudeep

Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2EEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52ED52070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgERLNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:13:45 -0400
Received: from foss.arm.com ([217.140.110.172]:38218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726424AbgERLNp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:13:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F8E7106F;
        Mon, 18 May 2020 04:13:45 -0700 (PDT)
Received: from bogus (unknown [10.37.12.25])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 962A63F52E;
        Mon, 18 May 2020 04:13:43 -0700 (PDT)
Date:   Mon, 18 May 2020 12:13:35 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the scmi tree
Message-ID: <20200518111335.GA16262@bogus>
References: <20200518210823.760fee29@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518210823.760fee29@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Mon, May 18, 2020 at 09:08:23PM +1000, Stephen Rothwell wrote:
> Commit
>
>   17a37ff76e95 ("arm64: dts: juno: Use proper DT node name for USB")
>
> is missing a Signed-off-by from its author.
>
> Also, the commit message tags should be separated from the rest of the
> commit message by a blank line.
>

Thanks for the heads up, I will fix and push ASAP.

--
Regards,
Sudeep

Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F8DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5E0320810
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731088AbgFPTkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:40:40 -0400
Received: from ec2-34-208-57-251.us-west-2.compute.amazonaws.com ([34.208.57.251]:43768
        "EHLO ip-172-31-12-36.us-west-2.compute.internal"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731054AbgFPTkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 15:40:40 -0400
X-Greylist: delayed 345 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Jun 2020 15:40:39 EDT
Received: by ip-172-31-12-36.us-west-2.compute.internal (Postfix, from userid 1001)
        id 0E40640777; Tue, 16 Jun 2020 12:34:54 -0700 (PDT)
Date:   Tue, 16 Jun 2020 12:34:54 -0700
From:   Daniel Walker <dwalker@fifo99.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: removal of the cisco tree
Message-ID: <20200616193453.GP16291@fifo99.com>
References: <20200616150009.6b9b1140@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616150009.6b9b1140@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 03:00:09PM +1000, Stephen Rothwell wrote:
> Hi,
> 
> I have removed the cisco tree
> (https://github.com/daniel-walker/cisco-linux.git#for-next)
> from linux-next because it has not been updated in more than a year.
> If you would like it reinstated, please just reply and let me know.

I'll likely request it be added at a later date, but not at this time.

Thanks for notification.

Daniel

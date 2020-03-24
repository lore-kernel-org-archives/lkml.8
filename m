Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EEDC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 08:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F76D20724
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 08:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbgCXIf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 04:35:57 -0400
Received: from foss.arm.com ([217.140.110.172]:58814 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbgCXIfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 04:35:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACA3230E;
        Tue, 24 Mar 2020 01:35:53 -0700 (PDT)
Received: from e123083-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AA9F43F7C3;
        Tue, 24 Mar 2020 01:35:52 -0700 (PDT)
Date:   Tue, 24 Mar 2020 09:35:50 +0100
From:   Morten Rasmussen <morten.rasmussen@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com
Subject: Re: [RFC PATCH 1/3] sched/topology: Split out SD_* flags declaration
 to its own file
Message-ID: <20200324083550.GE6103@e123083-lin>
References: <20200311183320.19186-1-valentin.schneider@arm.com>
 <20200311183320.19186-2-valentin.schneider@arm.com>
 <20200323134234.GD6103@e123083-lin>
 <jhjy2rrknfb.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjy2rrknfb.mognet@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 05:10:00PM +0000, Valentin Schneider wrote:
> 
> Hi Morten,
> 
> Just as a heads-up, I think those changes would better fit 2/3, or be
> in their own patch. 1/3 is just a straight up code move, with no changes
> to the existing comments.

I realized that when I got to 2/3, and yes, most of the comments are not
really related to your proposal it more things we could fix while we are
touching that code anyway.

> On Mon, Mar 23 2020, Morten Rasmussen wrote:
> > On Wed, Mar 11, 2020 at 06:33:18PM +0000, Valentin Schneider wrote:
> >> +/* Domain members share power domain */
> >> +SD_FLAG(SD_SHARE_POWERDOMAIN,   7)
> >
> > This flag is set only by 32-bit arm and has never had any effect. I
> > think it was the beginning of something years ago that hasn't
> > progressed. Perhaps we can remove it now?
> >
> 
> Right, I don't think I've seen anything recent that uses that flag.

AFAIK, it has never been used, only set.

Morten

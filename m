Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF93C54FD0
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412C420772
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 10:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbgCYKgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 06:36:21 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:58286 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727332AbgCYKgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 06:36:21 -0400
Received: from 185.80.35.16 (185.80.35.16) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.341)
 id a27912dfd0cb6c9e; Wed, 25 Mar 2020 11:36:18 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Pratik Rajesh Sampat <psampat@linux.ibm.com>,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, pratik.r.sampat@gmail.com,
        ego@linux.vnet.ibm.com, dja@axtens.net
Subject: Re: [PATCH] cpufreq: powernv: Fix frame-size-overflow in powernv_cpufreq_work_fn
Date:   Wed, 25 Mar 2020 11:36:18 +0100
Message-ID: <7394005.IE404Cl4Vv@kreacher>
In-Reply-To: <87h7yexnu7.fsf@mpe.ellerman.id.au>
References: <20200316135743.57735-1-psampat@linux.ibm.com> <1921198.IfoiWgUDIW@kreacher> <87h7yexnu7.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 24, 2020 7:34:56 AM CET Michael Ellerman wrote:
> "Rafael J. Wysocki" <rjw@rjwysocki.net> writes:
> > On Monday, March 16, 2020 2:57:43 PM CET Pratik Rajesh Sampat wrote:
> >> The patch avoids allocating cpufreq_policy on stack hence fixing frame
> >> size overflow in 'powernv_cpufreq_work_fn'
> >> 
> >> Fixes: 227942809b52 ("cpufreq: powernv: Restore cpu frequency to policy->cur on unthrottling")
> >> Signed-off-by: Pratik Rajesh Sampat <psampat@linux.ibm.com>
> >
> > Any objections or concerns here?
> >
> > If not, I'll queue it up.
> 
> I have it in my testing branch,

Great!

> but if you pick it up I can drop it.

Let it go in through your tree.

Cheers!




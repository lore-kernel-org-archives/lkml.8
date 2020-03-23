Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E394C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1062F20719
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgCWQra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:47:30 -0400
Received: from foss.arm.com ([217.140.110.172]:51886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727556AbgCWQra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:47:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 274921FB;
        Mon, 23 Mar 2020 09:47:30 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91D423F7C3;
        Mon, 23 Mar 2020 09:47:29 -0700 (PDT)
Date:   Mon, 23 Mar 2020 16:47:24 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Two questions about cache coherency on arm platforms
Message-ID: <20200323164723.GA8652@lakrids.cambridge.arm.com>
References: <20200323123524.w67fici6oxzdo665@mail.google.com>
 <20200323131720.GE2597@C02TD0UTHF1T.local>
 <20200323161537.ptjrihqotgmon7tr@mail.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200323161537.ptjrihqotgmon7tr@mail.google.com>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 04:15:40PM +0000, Changbin Du wrote:
> Hi Mark,
> Thanks for your answer. I still don't understand the first question.
> 
> On Mon, Mar 23, 2020 at 01:17:20PM +0000, Mark Rutland wrote:
> > On Mon, Mar 23, 2020 at 08:35:26PM +0800, Changbin Du wrote:
> > > Hi, All,
> > > I am not very familiar with ARM processors. I have two questions about
> > > cache coherency. Could anyone help me?
> > > 
> > > 1. How is cache coherency maintenanced on ARMv8 big.LITTLE system?
> > > As far as I know, big cores and little cores are in seperate clusters on
> > > big.LITTLE system.
> > 
> > This is often true, but not always the case. For example, with DSU big
> > and little cores can be placed within the same cluster.
> 
> Yes, it is ture for DynamIQ that bl cores can be placed within the same cluster.
> But I don't understand how linux support big.LITTLE before DynamIQ.

Multiple clusters can be in the same Inner Shareable domain, and Linux
relies on this being the case for systems it supports. It's possible to
build a system where clusters are in distinct Inner Shareable domains,
but Linux does not support using all cores on such a system.

Even with CCI, CCN, CMN, etc, Linux requires that all cores (which it is
told about) are in the same Inner Shareable domain. That is what is
commonly built.

> I read below description in ARM Cortex-A Series Programmer’s Guide for
> ARMv8-A.
>  | big.LITTLE software models require transparent and efficient transfer of data between big and LITTLE clusters.
>  | Coherency between clusters is provided by a cache-coherent interconnect such as the ARM CoreLink CCI-400 described in Chapter 14.
> 
> So I think  big cores and little cores are in different clusters in this
> case. Then we are not within the same Inner Shareable domain?

Linux requires that those clusters are in the same Inner Shareable
domain, and that's what people (mostly) build today.

Thanks,
Mark.

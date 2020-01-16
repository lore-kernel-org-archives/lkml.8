Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43867C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07C7620661
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217864;
	bh=LNLkwqumuCRsUZzAEzSEPyLEs54KO1X1kXB8A1qAvQw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VwOo6o4045RdE0+tcXPGl6aYRZ2yIC5sYCIVNUvP/k6pbgocNWbhrGBUMKioNPPYS
	 ItMSOnVOLDRIHvjqTf0eoHjp2Ybm7LNVsxvyWTwW4ylKnep1bREccG6wOOpfNAw6px
	 S+zCF4ZWEXhRsd3e0U/1P/71umL7kSUB1NTZ2bws=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391411AbgAPXhn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:37:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:50024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390085AbgAPXhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:37:36 -0500
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC8AE2072B;
        Thu, 16 Jan 2020 23:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217856;
        bh=LNLkwqumuCRsUZzAEzSEPyLEs54KO1X1kXB8A1qAvQw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XiJli2FduQhRgI8pXXx0H4Mh715uj9Rkkyyx6+ApiYXPlAB0n5ofBPOz8OI2HhrBN
         ZQONr0gbIy//k0a+OQVnS0X+Gz8xKuwbw1lhBCN1S0fr8Xf/c2jLKvab/e1zcdVUTT
         Eue2nsmA6xgn/tTSsHwXAQlqm2NaXo/VvouCw96Q=
Date:   Thu, 16 Jan 2020 15:37:35 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmscan: remove prefetch_prev_lru_page
Message-Id: <20200116153735.3090629f3b40bd850c66bd18@linux-foundation.org>
In-Reply-To: <B6E75D9E-E9A2-4078-A89A-267310467B0A@lca.pw>
References: <739f4470-8dfe-bb2f-8100-2134f48868b6@linux.alibaba.com>
        <B6E75D9E-E9A2-4078-A89A-267310467B0A@lca.pw>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2020 07:26:23 -0500 Qian Cai <cai@lca.pw> wrote:

> 
> 
> > On Jan 14, 2020, at 9:33 PM, Alex Shi <alex.shi@linux.alibaba.com> wrote:
> > 
> > ﻿
> > 
> >> 在 2020/1/14 下午9:46, Qian Cai 写道:
> >> 
> >> 
> >>>> On Jan 14, 2020, at 7:55 AM, Alex Shi <alex.shi@linux.alibaba.com> wrote:
> >>> 
> >>> This macro are never used in git history. So better to remove.
> >> 
> >> When removing unused thingy, it is important to figure out which commit introduced it in the first place and Cc the relevant people in that commit.
> >> 
> > 
> > Thanks fore reminder, Qian!
> > 
> > This macro was introduced in 1da177e4c3f4 Linux-2.6.12-rc2, no author or commiter could be found.
> 
> Looks a bit deeper for this, and I am not sure if it is necessary to remove it especially this does not cause any complication warning noise, because the macro looks like a part of API design to have a pair of both read and write version, even though only the write version is used at the moment.
> 
> In theory,  there could be users for the read version in the future, and then it needs to be added back.

Sure.  A problem with leaving it in place is that this leads people to
assume it is tested, which it presumably is not.

I don't think there's any particular downside either way, really.  But
it's presently cruft so I'm inclined to remove it.  If someone has a
need then they can add it back (presumbly reimplement it, actually) and
test it then.


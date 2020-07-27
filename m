Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C777C433EC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 081802075D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 20:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgG0UtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 16:49:04 -0400
Received: from smtprelay0241.hostedemail.com ([216.40.44.241]:48152 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727111AbgG0UtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 16:49:04 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 4FC8B12CA;
        Mon, 27 Jul 2020 20:49:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: team71_150227526f64
X-Filterd-Recvd-Size: 1934
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Jul 2020 20:49:01 +0000 (UTC)
Message-ID: <7f07e16c47c7dcb35685cddbb3a740e4698258fc.camel@perches.com>
Subject: Re: checkpatch: support deprecated terms checking
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.com>
Cc:     =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        SeongJae Park <sj38.park@gmail.com>,
        linux-kernel@vger.kernel.org, apw@canonical.com,
        colin.king@canonical.com, jslaby@suse.cz, pavel@ucw.cz,
        SeongJae Park <sjpark@amazon.de>
Date:   Mon, 27 Jul 2020 13:49:00 -0700
In-Reply-To: <20200727134411.73461df2fe73f8f96d93f75e@linux-foundation.org>
References: <20200726203328.GA8321@qmqm.qmqm.pl>
         <20200727065441.27164-1-sjpark@amazon.com>
         <20200727134411.73461df2fe73f8f96d93f75e@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-07-27 at 13:44 -0700, Andrew Morton wrote:
> On Mon, 27 Jul 2020 08:54:41 +0200 SeongJae Park <sjpark@amazon.com> wrote:
> 
> > > > > Unfortunately, the inexperienced _do_ in fact run
> > > > > checkpatch on files and submit inappropriate patches.
> 
> I don't think I really agree with the "new code only" guideline (where
> did this come from, anyway?).  10 years from now any remaining pre-2020
> terms will look exceedingly archaic and will get converted at some
> point.
> 
> Wouldn't be longterm realistic to just bite the bullet now and add these
> conversions to the various todo lists?

I don't think so.

There's no exclusion list for existing uses
written to external specification.

It's just emitting effectively noisy warnings
on things that should not be changed.



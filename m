Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E46C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 16:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 968D4206E3
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 16:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgGYQg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 12:36:56 -0400
Received: from smtprelay0240.hostedemail.com ([216.40.44.240]:58544 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726567AbgGYQg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 12:36:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 13F411817BAA6;
        Sat, 25 Jul 2020 16:36:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cats52_36037bd26f51
X-Filterd-Recvd-Size: 1668
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sat, 25 Jul 2020 16:36:53 +0000 (UTC)
Message-ID: <58fa2a308db8a27df72f94a880df3224bffab86d.camel@perches.com>
Subject: Re: checkpatch: support deprecated terms checking
From:   Joe Perches <joe@perches.com>
To:     =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        apw@canonical.com, colin.king@canonical.com, sj38.park@gmail.com,
        jslaby@suse.cz, pavel@ucw.cz
Date:   Sat, 25 Jul 2020 09:36:51 -0700
In-Reply-To: <20200725130248.GC18633@qmqm.qmqm.pl>
References: <20200725130248.GC18633@qmqm.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-07-25 at 15:02 +0200, Michał Mirosław wrote:
> Hello,
> 
> I see that this patch went into next and is already inciting people to
> do wrong things [1]. Can you please fix it to require '--subjective'
> switch or otherwise mark it clearly as suggestion-only?
> 
> The coding-style as in Linus' master says about *NEW* uses of the words
> listed (those introductions I expect to be actually rare) and not about
> existing use in the code or industry. Making a noise about all uses
> found surely will generate a lot more irrelevant patches.
> 
> [1] https://www.spinics.net/lists/linux-tegra/msg51849.html

I was never a big fan of this change.

Andrew, can you revert this please?



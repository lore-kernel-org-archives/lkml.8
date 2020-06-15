Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7875EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 525D52067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 07:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgFOHBI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 03:01:08 -0400
Received: from smtprelay0159.hostedemail.com ([216.40.44.159]:58888 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728251AbgFOHBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 03:01:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 51DF9181D3025;
        Mon, 15 Jun 2020 07:00:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: sand89_221708e26df4
X-Filterd-Recvd-Size: 1330
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Mon, 15 Jun 2020 07:00:57 +0000 (UTC)
Message-ID: <404b3a391bd73acfc29f65d14b1586905ee5103c.camel@perches.com>
Subject: Re: Re: [PATCH v4 0/2] Recommend denylist/allowlist instead of
 blacklist/whitelist
From:   Joe Perches <joe@perches.com>
To:     SeongJae Park <sjpark@amazon.com>, Pavel Machek <pavel@ucw.cz>
Cc:     Jiri Slaby <jslaby@suse.cz>, Michael Ellerman <mpe@ellerman.id.au>,
        akpm@linux-foundation.org, apw@canonical.com,
        SeongJae Park <sjpark@amazon.de>, colin.king@canonical.com,
        sj38.park@gmail.com, linux-kernel@vger.kernel.org
Date:   Mon, 15 Jun 2020 00:00:56 -0700
In-Reply-To: <20200615064631.18910-1-sjpark@amazon.com>
References: <20200615064631.18910-1-sjpark@amazon.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-06-15 at 08:46 +0200, SeongJae Park wrote:
> So, I agree this patch is imperfect for many cases, but better than nothing.

Not necessarily.

Having people strain for unusual equivalents
to generally well known terms is not good.

blacklist/whitelist is well understood.

Would you do the same for red/black?



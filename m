Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40CCDC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2431820760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 07:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgFJHGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 03:06:21 -0400
Received: from smtprelay0093.hostedemail.com ([216.40.44.93]:58456 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726095AbgFJHGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:06:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id C2977180A7FF8;
        Wed, 10 Jun 2020 07:06:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: art91_5d16ec026dc9
X-Filterd-Recvd-Size: 1435
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jun 2020 07:06:18 +0000 (UTC)
Message-ID: <21c42f96b7f2b105e863a9f4ddf87f4e95a86393.camel@perches.com>
Subject: Re: [PATCH v3 0/2] Recommend blocklist/allowlist instead of
 blacklist/whitelist
From:   Joe Perches <joe@perches.com>
To:     SeongJae Park <sjpark@amazon.com>, akpm@linux-foundation.org,
        apw@canonical.com
Cc:     colin.king@canonical.com, sj38.park@gmail.com,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Date:   Wed, 10 Jun 2020 00:06:17 -0700
In-Reply-To: <20200610065223.29894-1-sjpark@amazon.com>
References: <20200610065223.29894-1-sjpark@amazon.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-10 at 08:52 +0200, SeongJae Park wrote:
> This patchset 1) adds support of deprecated terms in the 'checkpatch.pl'
> and 2) set the 'blacklist' and 'whitelist' as deprecated with
> replacement suggestion of 'blocklist' and 'allowlist', because the
> suggestions are incontrovertible, doesn't make people hurt, and more
> self-explanatory.

I don't care for the politics of the patch myself.

From a technical perspective, it may be better to
have a single routine for both spelling and whatever
this is called.



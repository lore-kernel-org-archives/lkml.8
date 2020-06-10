Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB91AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 01:35:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3910206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 01:35:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgFJBft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 21:35:49 -0400
Received: from smtprelay0137.hostedemail.com ([216.40.44.137]:48530 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725885AbgFJBft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 21:35:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 5F1EB2E184;
        Wed, 10 Jun 2020 01:35:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: park07_140ccfa26dc7
X-Filterd-Recvd-Size: 1923
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jun 2020 01:35:47 +0000 (UTC)
Message-ID: <d086a1a412de3079cefbfb15f38c4dc9aae0045d.camel@perches.com>
Subject: Re: [PATCH v2] scripts/spelling: Recommend blocklist/allowlist
 instead of blacklist/whitelist
From:   Joe Perches <joe@perches.com>
To:     SeongJae Park <sjpark@amazon.com>, akpm@linux-foundation.org
Cc:     colin.king@canonical.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Date:   Tue, 09 Jun 2020 18:35:46 -0700
In-Reply-To: <20200609122549.26304-1-sjpark@amazon.com>
References: <20200609122549.26304-1-sjpark@amazon.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-09 at 14:25 +0200, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
>
> This commit recommends the patches to replace 'blacklist' and
> 'whitelist' with the 'blocklist' and 'allowlist', because the new
> suggestions are incontrovertible, doesn't make people hurt, and more
> self-explanatory.

nack.  Spelling is for typos not for politics.

> Signed-off-by: SeongJae Park <sjpark@amazon.de>
> ---
>  scripts/spelling.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/scripts/spelling.txt b/scripts/spelling.txt
> index d9cd24cf0d40..ea785568d8b8 100644
> --- a/scripts/spelling.txt
> +++ b/scripts/spelling.txt
> @@ -230,6 +230,7 @@ beter||better
>  betweeen||between
>  bianries||binaries
>  bitmast||bitmask
> +blacklist||blocklist
>  boardcast||broadcast
>  borad||board
>  boundry||boundary
> @@ -1495,6 +1496,7 @@ whcih||which
>  whenver||whenever
>  wheter||whether
>  whe||when
> +whitelist||allowlist
>  wierd||weird
>  wiil||will
>  wirte||write


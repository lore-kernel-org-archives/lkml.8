Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15634C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D638F20784
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585730305;
	bh=Bvhmmc0BPGknPaf0rghM2JRllR9P2T5itF8OtzXxVa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0c6l0mhEcNf1lD4RAfzhS6VXZ169RTeKTzir9Lz5ie+N5s7Zfjleo7Yp/34ctduH9
	 qFpIHbu0ENNqonxIF3BBG8S99XY2TSbWIOdJevImzR0iHmonhZzf1AndGB6619yO9O
	 Q0PVK8qPfCwjo/YVIp4pUBIlhyQ0RTpH4OV1Mptc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731830AbgDAIiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:38:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:48210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgDAIiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:38:24 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75CF82073B;
        Wed,  1 Apr 2020 08:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585730303;
        bh=Bvhmmc0BPGknPaf0rghM2JRllR9P2T5itF8OtzXxVa4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J2s9ykdXJR83vU5mD6OAAenGxi5Bw2B/QKskuClc1jza0jHl4blJXrDruApIoiNgN
         IVIMXXI/VarPS8bmC4RFYcQJu2Rrc+i/0nIrN6/uGlt54YRZuGI5y5XylmsEd0mchJ
         tqvVb/cwwDMpD1Q1wXn+9j0WTJFPOWJGSOUsbJ7o=
Date:   Wed, 1 Apr 2020 09:38:19 +0100
From:   Will Deacon <will@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, cai@lca.pw, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] kcsan: Change data_race() to no longer require
 marking racing accesses
Message-ID: <20200401083818.GA16446@willie-the-truck>
References: <20200331193233.15180-1-elver@google.com>
 <20200331193233.15180-2-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331193233.15180-2-elver@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 09:32:33PM +0200, Marco Elver wrote:
> Thus far, accesses marked with data_race() would still require the
> racing access to be marked in some way (be it with READ_ONCE(),
> WRITE_ONCE(), or data_race() itself), as otherwise KCSAN would still
> report a data race.  This requirement, however, seems to be unintuitive,
> and some valid use-cases demand *not* marking other accesses, as it
> might hide more serious bugs (e.g. diagnostic reads).
> 
> Therefore, this commit changes data_race() to no longer require marking
> racing accesses (although it's still recommended if possible).
> 
> The alternative would have been introducing another variant of
> data_race(), however, since usage of data_race() already needs to be
> carefully reasoned about, distinguishing between these cases likely adds
> more complexity in the wrong place.

Just a thought, but perhaps worth extending scripts/checkpatch.pl to
check for use of data_race() without a comment? We already have that for
memory barriers, so should be easy enough to extend with any luck.

> Link: https://lkml.kernel.org/r/20200331131002.GA30975@willie-the-truck
> Signed-off-by: Marco Elver <elver@google.com>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Qian Cai <cai@lca.pw>
> ---
>  include/linux/compiler.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index f504edebd5d7..1729bd17e9b7 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -326,9 +326,9 @@ unsigned long read_word_at_a_time(const void *addr)
>  #define data_race(expr)                                                        \
>  	({                                                                     \
>  		typeof(({ expr; })) __val;                                     \
> -		kcsan_nestable_atomic_begin();                                 \
> +		kcsan_disable_current();                                       \
>  		__val = ({ expr; });                                           \
> -		kcsan_nestable_atomic_end();                                   \
> +		kcsan_enable_current();                                        \
>  		__val;                                                         \
>  	})
>  #else

Acked-by: Will Deacon <will@kernel.org>

Will

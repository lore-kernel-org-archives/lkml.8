Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0751C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B349920684
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fuCzCCfj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgGQTlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbgGQTlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:41:03 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534BDC0619D2;
        Fri, 17 Jul 2020 12:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Zhw2F/rxfmshgNhQq6sLU09AgyCLqXRUZL8QbpWADbQ=; b=fuCzCCfjaLPlfe+E0FEEKJnWLw
        89oWSRG6JNV6DkE++BILL3IEeuhQVUlk9ecNhsEKCY0Rh9VNU4fZOW28sNvwiDcnZbNPyGiHMI7iq
        6aoBJaDkVgAvHl/80bjsBj12XMh5bGW0Tqc0CrQ3w993yNYBwNaMslrlTf2/lF1MyKchPgEUxhCOK
        W1ult6bJv5JhPc+U4JEk8uhE2kojSmu8qQiimLvKi+nqbmg5fwP5hfH2NANG+A+RPaPCAX4JXyDLq
        ehc1VPx2y0dS5qDDep/zKh13bOYnclpxSBKGrNIRNi4AKvXrxFLxaoDqR/uGxmoEEF1o1yWIhgr2G
        1wL+mmUQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwWE9-0002jL-AP; Fri, 17 Jul 2020 19:41:01 +0000
Subject: Re: [PATCH 10/25] Documentation: rculist.h: fix sphinx warning
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>, corbet@lwn.net,
        mchehab@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
 <20200717185624.2009393-10-dwlsalmeida@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <72f228c9-ca0c-5337-6c78-49ea1a8ea152@infradead.org>
Date:   Fri, 17 Jul 2020 12:40:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200717185624.2009393-10-dwlsalmeida@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/20 11:56 AM, Daniel W. S. Almeida wrote:
> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 
> Fix the following warning:
> 
> warning: bad line: [@right ][node2 ... ]
> 
> This was missing a '*' at the start.
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>

Mauro and I both fixed this one.  His patch was merged.

> ---
>  include/linux/rculist.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/rculist.h b/include/linux/rculist.h
> index df587d181844b..7eed65b5f7130 100644
> --- a/include/linux/rculist.h
> +++ b/include/linux/rculist.h
> @@ -512,7 +512,7 @@ static inline void hlist_replace_rcu(struct hlist_node *old,
>   * @right: The hlist head on the right
>   *
>   * The lists start out as [@left  ][node1 ... ] and
> -                          [@right ][node2 ... ]
> + *                        [@right ][node2 ... ]
>   * The lists end up as    [@left  ][node2 ... ]
>   *                        [@right ][node1 ... ]
>   */
> 


-- 
~Randy


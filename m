Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2151C47257
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 13:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0EDD21835
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 13:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iVv54Rhs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgEBNlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 09:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbgEBNlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 09:41:42 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA811C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  2 May 2020 06:41:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x18so15230606wrq.2
        for <linux-kernel@vger.kernel.org>; Sat, 02 May 2020 06:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sF7Mbr7u0j8a1zCroJsnWHqSQU0Nk3Dl8GARa1TmLgU=;
        b=iVv54RhsTAX8YW8uEm7HffxQIFP8R6uKH+WiakJjPVmvh3Ok+LvRMWsLCpS41MagNA
         O2j/b1oDTRG1GTPqWbec5MvgYkUf1kSQK1Rl/fqRndj7GUrbcfXsj4Vui3SxdeaOPomi
         IBFuIxMmdOBl6zQLwRtG9VZZK4tYrA3VxiviEFrveqGARfpcbrjq440Yw0D/PSJkJm1X
         a2l1pyAVxPg8DBNEWq0leBhLg5KncJMKnnvidn07SJMMWDnpWiCgPkMlNFfNlUGmnCxJ
         bahtESTyTnXH6fP3VSCE2mscrp0mJmiBHgtXjYOg5Xb9G31YfcEOSjFYZSMESMT3bfK2
         D6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=sF7Mbr7u0j8a1zCroJsnWHqSQU0Nk3Dl8GARa1TmLgU=;
        b=FhepfyG+d23tdxkZ06aP7S1sjfQoTBkNYJj9dM9Bfi8oT26Ak6efMfyHtCDDk424sL
         FnEku6zB+gdFyHSuXpWaFDJU4/efGReHXGmazoMFzFnWeW8YEuZthawddVhxh3qfKf55
         CaHvvZf5AlHnLXJCg2mzjzzEDuQZqiubtjg7AJK05Zed82TinJDfKxWCLvnydZdcj5X1
         R/tsDARNLUCCdXJ/pnAb24EJhT6zHEagviz9W9xooehJr6bE7qo/5liqXX6YPNTD/aS+
         h7CHMyNWFSnO0MtMj6T3lwFXETe87MQfIPEqL8gah4+WSRqg0neG1YTTJY454U/zIaaU
         HYPw==
X-Gm-Message-State: AGi0PuYitmTB1KP9oTPSpB4dfKE/wIgBRjJmilVrgMxZ5uBcfQytaYyH
        Ty9kD+yG0KojmNIw2Xo2hxs=
X-Google-Smtp-Source: APiQypIjbZjGH51Gca7iovZ7Scb7BUaWy4caXx9f7B0nZ38xqnChWouJpslsRZxDJjyzHoqfcvEqEQ==
X-Received: by 2002:adf:b344:: with SMTP id k4mr9039440wrd.76.1588426899434;
        Sat, 02 May 2020 06:41:39 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id v16sm4315372wml.30.2020.05.02.06.41.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 02 May 2020 06:41:38 -0700 (PDT)
Date:   Sat, 2 May 2020 13:41:38 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, ying.huang@intel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] mm/swapfile.c: count won't be bigger than
 SWAP_MAP_MAX
Message-ID: <20200502134138.ycm26jnxc55rimgj@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200501015259.32237-1-richard.weiyang@gmail.com>
 <20200501015259.32237-3-richard.weiyang@gmail.com>
 <20200501154853.bca4cfb7b2558bd43a4942f3@linux-foundation.org>
 <20200502132911.u6y6hkh56ik4ojne@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200502132911.u6y6hkh56ik4ojne@master>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 02, 2020 at 01:29:11PM +0000, Wei Yang wrote:
>On Fri, May 01, 2020 at 03:48:53PM -0700, Andrew Morton wrote:
>>On Fri,  1 May 2020 01:52:59 +0000 Wei Yang <richard.weiyang@gmail.com> wrote:
>>
>>> When the condition is true, there are two possibilities:
>>
>>I'm struggling with this one.
>>
>>>    1. count == SWAP_MAP_BAD
>>>    2. count == (SWAP_MAP_MAX & COUNT_CONTINUED) == SWAP_MAP_SHMEM
>>
>>I'm not sure what 2. is trying to say.  For a start, (SWAP_MAP_MAX &
>>COUNT_CONTINUED) is zero.  I guess it meant "|"?
>
>Oops, you are right. It should be (SWAP_MAP_MAX | COUNT_CONTINUED).
>
>Sorry for the confusion.
>

Hmm... I made a mistake again, the two cases should be

  * SWAP_MAP_BAD
  * (SWAP_MAP_BAD | COUNT_CONTINUED) == SWAP_MAP_SHMEM

What a shame.

>>
>>Also, the return value documentation says we return EINVAL for migration
>>entries.  Where's that happening, or is the comment out of date?
>>
>
>Not paid attention to this.
>
>Take look into the code, I don't find a relationship between the swap count
>and migration. Seems we just make a migration entry but not duplicate it.  
>If my understanding is correct.
>
>>> The first case would be filtered by the first if in __swap_duplicate().
>>> 
>>> And the second case means this swap entry is for shmem. Since we never
>>> do another duplication for shmem swap entry. This won't happen neither.
>>
>
>-- 
>Wei Yang
>Help you, Help me

-- 
Wei Yang
Help you, Help me

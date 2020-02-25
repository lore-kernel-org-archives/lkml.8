Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3067C4BA00
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 22:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A980224653
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 22:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FpPAphSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgBYWaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 17:30:16 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46861 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgBYWaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 17:30:16 -0500
Received: by mail-ot1-f65.google.com with SMTP id g64so1043460otb.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 14:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BrEPbLqTlFfWhG7c3GGQgt9yFg0pALuIdjeT0xABLMg=;
        b=FpPAphSHXLYsaE+3UvRxPBgDOnB7MzMk7Kmlh3zw4TOfEWCHWfGUJgRgDJ8VBkWILC
         fkPyQAdZf3U7B8Vug+ANb3jafZttPSBVWEuvQ+oaghABbjg7S+yasje27XW2Gu0fCaNu
         89eHuQHxDrywCsMb3ncajsBSzC6mY0iFSYJBxqyDaIfWBePiwJr81FaFpJ9Zou6QkEyc
         Jjip7c/AKq914jb039x4fbGuobk8OlrDk3vD7f5J1zxZ3/H7tBDa0NLjdmJ08s2jnUhV
         wYGXLf+gK0mSec/DY3pPLGZVF60swBgnM79xrVAANmXb/r5JP1+NLcbk1UcVDSUMQnB6
         Jmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BrEPbLqTlFfWhG7c3GGQgt9yFg0pALuIdjeT0xABLMg=;
        b=rgBr7ZnTMaL+C8u9FmxqYcwjZIgx9YgXsLNg4RiMMJ+0P0Vm0SEBINzvZDRpMVdYNW
         L2g9ILXe4ZznJ2joq+I9asO8H0NZrMm2Sbe1lE/qQRkm/SlECj8SaJ6qxAP68oe8FIFt
         AGwbz8Q/wJE/3XK0iGpRwEELzDrmgaUdVGpc+WrT094+FDW2BQmA6AvcqGnTWrl6czN+
         yUM248iZKsyrW66WsRo3vK5H4HYwiu7HMG+IvKutkx7fiYM77wWzFKy2BQfvTzvky7uR
         5//PVvy0bT2f4TWKmrOPLM3d/I+orMCgIGQjmUPoAHPvmtjhcWtXv1ts6TUedvLPlFT3
         dr6w==
X-Gm-Message-State: APjAAAUhdUJaA15OL8gctHICbzCuXy2rBN0EmR4FF1QMhLbK9zWYePt/
        aM+QfJZAo1klnXdODTz9rm2yZOwkDh2W5GmduOC1mj+h
X-Google-Smtp-Source: APXvYqxPfciH6Z5eK4o0F5Fulc1nBBSG9d5q8Wk5//UKojl8rjqHpyXrdfeCEpLJu+rhzG9/1VevJv49Kiuqtk+U318=
X-Received: by 2002:a9d:6ac2:: with SMTP id m2mr630339otq.191.1582669814963;
 Tue, 25 Feb 2020 14:30:14 -0800 (PST)
MIME-Version: 1.0
References: <dcd1cb4c-89dc-856b-ea1b-8d4930fec3eb@intel.com>
 <20200219194006.GA3075@sultan-book.localdomain> <20200219200527.GF11847@dhcp22.suse.cz>
 <20200219204220.GA3488@sultan-book.localdomain> <20200219214513.GL3420@suse.de>
 <20200219224231.GA5190@sultan-book.localdomain> <20200220101945.GN3420@suse.de>
 <20200221042232.GA2197@sultan-book.localdomain> <20200221080737.GK20509@dhcp22.suse.cz>
 <20200221210824.GA3605@sultan-book.localdomain> <20200225090945.GJ22443@dhcp22.suse.cz>
In-Reply-To: <20200225090945.GJ22443@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 25 Feb 2020 14:30:03 -0800
Message-ID: <CALvZod6MW62-+nEw-d0jKxFK9mspOY_tt2JRTDYOrOVyM9_QHw@mail.gmail.com>
Subject: Re: [PATCH] mm: Stop kswapd early when nothing's waiting for it to
 free pages
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Sultan Alsawaf <sultan@kerneltoast.com>,
        Mel Gorman <mgorman@suse.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 1:10 AM Michal Hocko <mhocko@kernel.org> wrote:
>
[snip]
>
> The proper fix should, however, check the amount of reclaimable pages
> and back off if they cannot meet the target IMO. We cannot rely on the
> general reclaimability here because that could really be thrashing.
>

"check the amount of reclaimable pages" vs "cannot rely on the general
reclaimability"? Can you clarify?

BTW we are seeing a similar situation in our production environment.
We have swappiness=0, no swap from kswapd (because we don't swapout on
pressure, only on cold age) and too few file pages, the kswapd goes
crazy on shrink_slab and spends 100% cpu on it.

Shakeel

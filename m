Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E229EC2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 23:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08AD20787
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 23:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c3dpr6pE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbgDFXch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 19:32:37 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38521 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgDFXch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 19:32:37 -0400
Received: by mail-pl1-f195.google.com with SMTP id w3so504874plz.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 16:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=g27+o/Jo5SyyiT7DC1V9kCq9rdea7CBqZkjMzdC8dyE=;
        b=c3dpr6pE0x2QY/58bp4pyxLwz2eLVzDoUfGk+MzEco6cWUi3PDu85qrsuYlmPmwW6P
         eRqYQl7yL7YawtxZ7Ee722sSoTA6KEeGg1aWPkedXezJS+O0pjFmpk7Hs5mpYTgHIeUh
         Ygo1RfvFk4EiPkwQWmyNbtrUtKrVQS9hd+Rcp0KGIzbapCg66qt0V4Ny/C795ouhzE/g
         ExcoJXf6rGz0/VZ6DbKn/McJVpZqWEepM4aZkqQuRdy8gI+P7xpNNxNDGspNT97PEnU8
         9HUwDAtWCMgmt2gpGrhFlR8A6jJEMcTBl2msqOdYihmpUzqmrXXZ3U2Dzmokyl3XYlYu
         Bwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=g27+o/Jo5SyyiT7DC1V9kCq9rdea7CBqZkjMzdC8dyE=;
        b=I7I8CIM7yLovWLXIWQ3HEnoyaj5PnCsH5p/BdPo8FsR6C8NMvsfCViGp0bFhbcZ35w
         nbOWpkiRdEMiws6QOJxn5ZBEMjNk7BrL0svCf36xlJA74Gd4IYPOvMJDrgdK2MLzIv6H
         SlSqbT1rvB3oFZfbvbu87kpxAtdiIRDt2eksPc5Kntb9GhpMqHl8BaB7XzCTupnRy56g
         F8fxi2Wpq477XyjD/jY+u/6BOI2X+ONxjJDJh4/fyWLSimjuH7urFkyrgh+OPQz6orNU
         Of4qoEYFYIFnM0smLjl4nWJuc2f4tyi6+4euLfUNJX5g6bjiPGUA0fL8IozqAtf7MDFe
         UwUQ==
X-Gm-Message-State: AGi0PubxSZ86fC/1AIejrxzx4su204OrK5ITg+hfMaZJn8I6vU/JctfV
        zRtUe2o6tQ5JNyvoagABf8L4qA==
X-Google-Smtp-Source: APiQypLYDOtw8UUB9MxXci9ylWClLJm3wAfmYK37V8ENY+jHbLhYBUnRripLZQrLkpppPK14T+s0WQ==
X-Received: by 2002:a17:90a:198b:: with SMTP id 11mr1945983pji.23.1586215956046;
        Mon, 06 Apr 2020 16:32:36 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id f69sm12237683pfa.124.2020.04.06.16.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 16:32:35 -0700 (PDT)
Date:   Mon, 6 Apr 2020 16:32:34 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     John Hubbard <jhubbard@nvidia.com>
cc:     Michal Hocko <mhocko@kernel.org>, NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm: clarify __GFP_MEMALLOC usage
In-Reply-To: <4f861f07-4b47-8ddc-f783-10201ea302d3@nvidia.com>
Message-ID: <alpine.DEB.2.21.2004061626540.45667@chino.kir.corp.google.com>
References: <20200403083543.11552-1-mhocko@kernel.org> <20200403083543.11552-2-mhocko@kernel.org> <alpine.DEB.2.21.2004031238571.230548@chino.kir.corp.google.com> <87blo8xnz2.fsf@notabene.neil.brown.name> <20200406070137.GC19426@dhcp22.suse.cz>
 <4f861f07-4b47-8ddc-f783-10201ea302d3@nvidia.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Apr 2020, John Hubbard wrote:

> Hi Michal and all,
> 
> How about using approximately this wording instead? I found Neil's wording to
> be
> especially helpful so I mixed it in. (Also fixed a couple of slight 80-col
> overruns.)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index be2754841369..c247a911d8c7 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -111,6 +111,15 @@ struct vm_area_struct;
>   * very shortly e.g. process exiting or swapping. Users either should
>   * be the MM or co-ordinating closely with the VM (e.g. swap over NFS).
>   *
> + * To be extra clear: users of __GFP_MEMALLOC must be working to free other
> + * memory, and that other memory needs to be freed "soon"; specifically,
> before
> + * the reserve is exhausted. This generally implies a throttling mechanism
> that
> + * balances the amount of __GFP_MEMALLOC memory used against the amount that
> the
> + * caller is about to free.
> + *
> + * Usage of a pre-allocated pool (e.g. mempool) should be always considered
> + * before using this flag.
> + *
>   * %__GFP_NOMEMALLOC is used to explicitly forbid access to emergency
> reserves.
>   * This takes precedence over the %__GFP_MEMALLOC flag if both are set.
>   */

I agree this looks better, but if a developer is reading this and is 
unfamiliar with the implementation of memory reserves or __GFP_MEMALLOC, 
how do they take any action that memory allocated with this bit is freed 
before the reserve is exhausted?

It seems like it's simply saying "don't allocate a lot of this before you 
free it."  That may be very well how it goes, but any discussion of 
depletion of the reserve seems to imply we'd want to quantify it and I 
agree that's not what we want the user to do.

So maybe simply state that reserves can be extremely limited and thus it's 
best to assume there is very little reserve left?

Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C1AC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E5120758
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M3r0aoC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731516AbgCKXx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 19:53:29 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:40421 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731399AbgCKXx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 19:53:29 -0400
Received: by mail-ot1-f53.google.com with SMTP id h17so4119274otn.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 16:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BISaxEO3tLmHtOALupu+vtL3eE8hw9R6Yq+1E8T9jfo=;
        b=M3r0aoC8VOwSKTLuSsCRfJBVH1YnEi930Q0zsoqxBU0YXNRNmHe63uoustvkh7YyFF
         E6CTrkh6gn/dbQfxpVEWqE3X+ZOv+cxeJg/sLWcU43h9CahbGYcje3EaHoZYBBBbxiDs
         lI0xioErrP/uWf69i4EkxpX19QrunfW/e2gI0P2aclQKfwRYO1B6QuWy+axRKHb9jKiz
         5F+ybwjTNafCUTNTdPf4Zxyj2WgKQ+l7ypXg/gKsQWbbKyeHeZSjpkejOHpVW9fpYPo6
         jyY/z0Q8uK+G6hWaYP/zToI4BkNhNau1znGna0o9240neDIIHW+ROUZ+UGCP10q/CkNp
         R01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BISaxEO3tLmHtOALupu+vtL3eE8hw9R6Yq+1E8T9jfo=;
        b=WxI9EPc3WjOvA3jmlEuhrWw4a6evXsvO55d0HAR47NH+jOwivGYvMOY/KV5TPouA3S
         QcipJLXRryiYTrDF8QFSnO9gCI8oLUg6NNkqmGetOSCEke0tDc9+xR8d3xsJKjl+Vowr
         63yaSk0n8RSy0YRyOmxOotdZByTHEdlZ1Tf8uKv44WQUUgG54FvxPPplZDrAIAd+f9Vk
         UUMvrAHKdhfYNmLot9Z5/YHAeHKMGPzQnMozhyNQ7ZNW+9q5M4BDsPebI3MBHn0pos5S
         b3Dfdp/8c1VtiM4PMkK49anhOosPjlBsXpcyiHwL58L48cOFfTvr6Cx/VIXQogHMpLvE
         9ICg==
X-Gm-Message-State: ANhLgQ3bj7UTLZ/DbCZyzNvIkdKBLkvFmxvzC6PakEeOVzTtKDqqbXXz
        bAyWd2LumwFiGA/PeJ36rHTflBh3AWnrODoJsnMFwQ==
X-Google-Smtp-Source: ADFU+vulUlsn/pxKKkjb+94QHZE4kxGdiyGXHu3bIAK6/f38uTBukltpBzlSI6r23VtERCbGZIXEBsrQRXA32wJQXJ8=
X-Received: by 2002:a9d:6c99:: with SMTP id c25mr4022491otr.124.1583970808405;
 Wed, 11 Mar 2020 16:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
 <20200310184814.GA8447@dhcp22.suse.cz> <CAG48ez2pNSKL9ZTH-PQ93+Kc6ObH6Pa1vVg3OS85WT0TB8m3=A@mail.gmail.com>
 <20200310210906.GD8447@dhcp22.suse.cz> <cf95db88-968d-fee5-1c15-10d024c09d8a@intel.com>
 <20200311084513.GD23944@dhcp22.suse.cz>
In-Reply-To: <20200311084513.GD23944@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 11 Mar 2020 16:53:17 -0700
Message-ID: <CALvZod6b73_ay_kxph143Aj+XBq04Np0z2bK4Rfn8qppihrmTw@mail.gmail.com>
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Minchan Kim <minchan@kernel.org>, Jann Horn <jannh@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 1:45 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Tue 10-03-20 15:48:31, Dave Hansen wrote:
> > Maybe instead of just punting on MADV_PAGEOUT for map_count>1 we should
> > only let it affect the *local* process.  We could still put the page in
> > the swap cache, we just wouldn't go do the rmap walk.
>
> Is it really worth medling with the reclaim code and special case
> MADV_PAGEOUT there? I mean it is quite reasonable to have an initial
> implementation that doesn't really touch shared pages because that can
> lead to all sorts of hard to debug and unexpected problems. So I would
> much rather go with a simple patch to check map count first and see
> whether somebody actually cares about those shared pages and go from
> there.
>
> Minchan, do you want to take my diff and turn it into the proper patch
> or should I do it.
>

What about the remote_madvise(MADV_PAGEOUT)? Will your patch disable
the pageout from that code path as well for pages with mapcount > 1?

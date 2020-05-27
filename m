Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC8AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 02:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECC542075F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 02:06:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKtenuWI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgE0CG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 22:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgE0CG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 22:06:58 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F90C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 19:06:57 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f18so6195355qkh.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 19:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZUi+y+kpl/dFHCzojn4fvs0wctouGkeBE98eyOM61ec=;
        b=UKtenuWIwIc+kT7nWPl8E+OCr/W5y/OJXy3ZyIEh4fat/20lp73fqB2CcAgAZBW7P3
         CyFpEDC/PvWhTwkZA1af47/VqgWPVbKnMRBoxK4WJ4z6aJOfR+JgGqCJysDRTWv45tSQ
         YLb3DLACzu3ybIoQzi8F4RUt7Ae2FvYb6eVJzSTBRyuEl9HUlG1cfvkGO7rnFnbiIWls
         ABbDPbOgWMBi83CUW1SEMVefbF6KboDgMLC3gUEk2EzAncRzSnzmcIT+8GtQs1WBSt4j
         0RhCT0uENMtdMXnklttY1bbyDxqcwfzphGP4yqy5zgrFZa7BaXrjCs9Fi562zcy74tAh
         47yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZUi+y+kpl/dFHCzojn4fvs0wctouGkeBE98eyOM61ec=;
        b=sAEvFrztJBVcsmEnFZCnpWhCNpJn4R9cM0EugGoG5tM06jHcxknPQeR5j0qCA4JrNY
         Uf67w4Wi2VpQ1zCV1hLQlReHWpeZT6zGJCGL1dZKyXXH/MkW8fFc7w9UHjK0CrGJseG2
         ulfPShoU3lW877nEVZz+1iodgD/3SpngxyFR5WB4jk4vB23lqLlDeV+RFayXqT7KoIcy
         33Mz1QnZGnghJ6Dy0oPRqBLVyQnIUQBqhvubsvUXLjlpFgrAedmFuVUTxrrXR4a9CEIz
         xXV80m1H1BusJJHXE+OIOAZTvVsVus9rpQYvim85KoaDi4UHt3UuvNqK1aa2TS/wSSc5
         xWag==
X-Gm-Message-State: AOAM531zLM3fR5IfifS9xwoRcq0mbHkJIoq44lXoEB8TjnC1m13YwrI6
        ZkBoJscs478fb3XyFxyimIHW96ZqCfBzwm2g9/6gtO8WAAI=
X-Google-Smtp-Source: ABdhPJwvx49dn7hYu3sdn1SdPWCkEH8F5BhYt2KXTPPwomO4l89A4X+/DXZRzA26IADc4/M7Lz/2bWvPhonqMWskVn8=
X-Received: by 2002:a05:620a:164c:: with SMTP id c12mr1719461qko.343.1590545216375;
 Tue, 26 May 2020 19:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200520232525.798933-1-hannes@cmpxchg.org> <20200520232525.798933-6-hannes@cmpxchg.org>
In-Reply-To: <20200520232525.798933-6-hannes@cmpxchg.org>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Wed, 27 May 2020 11:06:47 +0900
Message-ID: <CAAmzW4MMLw=4BHRtt=g8BHpQLTaSmhG03Ct6WMjmDxVnOkNQYA@mail.gmail.com>
Subject: Re: [PATCH 05/14] mm: workingset: let cache workingset challenge anon
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 5=EC=9B=94 21=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 8:26, J=
ohannes Weiner <hannes@cmpxchg.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> We activate cache refaults with reuse distances in pages smaller than
> the size of the total cache. This allows new pages with competitive
> access frequencies to establish themselves, as well as challenge and
> potentially displace pages on the active list that have gone cold.
>
> However, that assumes that active cache can only replace other active
> cache in a competition for the hottest memory. This is not a great
> default assumption. The page cache might be thrashing while there are
> enough completely cold and unused anonymous pages sitting around that
> we'd only have to write to swap once to stop all IO from the cache.
>
> Activate cache refaults when their reuse distance in pages is smaller
> than the total userspace workingset, including anonymous pages.

Hmm... I'm not sure the correctness of this change.

IIUC, this patch leads to more activations in the file list and more activa=
tions
here will challenge the anon list since rotation ratio for the file
list will be increased.

However, this change breaks active/inactive concept of the file list.
active/inactive
separation is implemented by in-list refault distance. anon list size has
no direct connection with refault distance of the file list so using
anon list size
to detect workingset for file page breaks the concept.

My suspicion is started by this counter example.

Environment:
anon: 500 MB (so hot) / 500 MB (so hot)
file: 50 MB (hot) / 50 MB (cold)

Think about the situation that there is periodical access to other file (10=
0 MB)
with low frequency (refault distance is 500 MB)

Without your change, this periodical access doesn't make thrashing for cach=
ed
active file page since refault distance of periodical access is larger
than the size of
the active file list. However, with your change, it causes thrashing
on the file list.

In fact, I'm not sure that I'm thinking correctly. It's very
complicated for me. :)
Please let me know if there is a missing piece.

Thanks.

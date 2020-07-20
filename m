Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822A9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C69C207EA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 04:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Orx+a9RB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgGTEsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 00:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgGTEsI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 00:48:08 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FD7C0619D4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 21:48:08 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id n24so11164658otr.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 21:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=6Nps254wO3Vku/AMs/COcTPJnAHzxFnu9/tet83Jczo=;
        b=Orx+a9RBBcSgVIEOHFVB374CoAHh0H+dcciHwze7bjd/evrRLoNHoEeHX6AUUXAWPE
         rlEZJuyYrLtfrbxBEr1f6tOk1hUCeuxitWVtbHQSm1gD5eBMeQnnQmiecOui/n+Wy+CH
         lVR+yKJxXOVRAwcOkkKdPQDX9l0WSRYT55r6M1O9qVGNeakNm5eWCBq/poyfEr+Mh+xO
         fvXDBer896r9lWpDPRKLzlOfw7HMuYx8YhXqqDQ9X/jiqcowwnnertv+u6tOMyTf4L6x
         VhxLTL6Tuzj5Wcb/bIoRfQ7SJeG3OQOLcWf9uL2ccqf9yxAULz7Zp0JITwEJl9p0MruI
         UiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=6Nps254wO3Vku/AMs/COcTPJnAHzxFnu9/tet83Jczo=;
        b=i8aBqb6nRavNnqcYOyQtLNfBkTn2r3HCxebxOIU8e20KKUcocVBED1TVD4TA1EDp4A
         MpFkmIXshxqfwDYl0QVCYvcy5+VGSxrhnegITBmbOT7SjeXBRuaWBQulpW7DO4JES0TE
         ehzIvuMt/oP45bmQsBczigfgksMJXLsp2YrXhu6vf5EZHhWdu7+jjiUF9iGRvbvJYuH4
         dKTOcFgkrkdwoc9R07730RoKYuKZ1IU3uXOxu8+FschosMPumzo75WadGXRMHSSYyVZm
         agaLbNwjRE8oDFLy8n/K3CWchYVuX8pogtlko0OxRhAOn1LfP34apxBc2fq+YkJXxxW2
         EQ+Q==
X-Gm-Message-State: AOAM5302AFbECBNsehfehdoLoOII6sx0zXuHi7dMo/3QWwiCOgW+bd0V
        mnZZBkAlfzjcb6zVkaH3KbW9dA==
X-Google-Smtp-Source: ABdhPJyxUSbYws6hgiXi/FXNrgA6DQiqHyVhJ/vCcW5ZcJVVBJfAngGkSI4Kx13zzYcqaz/Mipp0kQ==
X-Received: by 2002:a9d:480d:: with SMTP id c13mr18932515otf.224.1595220487215;
        Sun, 19 Jul 2020 21:48:07 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w17sm3914020oia.16.2020.07.19.21.48.04
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sun, 19 Jul 2020 21:48:06 -0700 (PDT)
Date:   Sun, 19 Jul 2020 21:47:49 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     Hugh Dickins <hughd@google.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kbuild test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v16 00/22] per memcg lru_lock
In-Reply-To: <5f2401d3-dd4f-cbc6-8cb4-4e92fc64998c@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2007192144150.1478@eggly.anvils>
References: <1594429136-20002-1-git-send-email-alex.shi@linux.alibaba.com> <CAKgT0UcKVyTXQ=tGv_uMV+fSvoH_-cuG9zA_zhE+S8Ou11gt=w@mail.gmail.com> <57c619e7-da7e-198e-3de8-530bf19b9450@linux.alibaba.com> <alpine.LSU.2.11.2007190801490.3521@eggly.anvils>
 <5f2401d3-dd4f-cbc6-8cb4-4e92fc64998c@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1916823428-1595220486=:1478"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1916823428-1595220486=:1478
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 20 Jul 2020, Alex Shi wrote:
> =E5=9C=A8 2020/7/19 =E4=B8=8B=E5=8D=8811:23, Hugh Dickins =E5=86=99=E9=81=
=93:
> > I noticed that 5.8-rc5, with lrulock v16 applied, took significantly
> > longer to run loads than without it applied, when there should have bee=
n
> > only slight differences in system time. Comparing /proc/vmstat, somethi=
ng
> > that stood out was "pgrotated 0" for the patched kernels, which led her=
e:
> >=20
> > If pagevec_lru_move_fn() is now to TestClearPageLRU (I have still not
> > decided whether that's good or not, but assume here that it is good),
> > then functions called though it must be changed not to expect PageLRU!
> >=20
> > Signed-off-by: Hugh Dickins <hughd@google.com>
>=20
> Good catch!
>=20
> Thanks a lot, Hugh!=20
> except 6 changes should apply, looks we add one more in swap.c file to st=
op
> !PageRLU further actions!

Agreed, that's a minor optimization that wasn't done before,
that can be added (but it's not a fix like the rest of them).

>=20
> Many Thanks!
> Alex
>=20
> @@ -649,7 +647,7 @@ void deactivate_file_page(struct page *page)
>          * In a workload with many unevictable page such as mprotect,
>          * unevictable page deactivation for accelerating reclaim is poin=
tless.
>          */
> -       if (PageUnevictable(page))
> +       if (PageUnevictable(page) || !PageLRU(page))
>                 return;
>=20
>         if (likely(get_page_unless_zero(page))) {
--0-1916823428-1595220486=:1478--

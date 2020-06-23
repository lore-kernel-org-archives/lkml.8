Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EB5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 22:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C95420724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 22:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Nu1h5FTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388257AbgFWWSX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 18:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387609AbgFWWSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 18:18:22 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116D4C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 15:18:22 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id y10so375698eje.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 15:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qKzAj5vVSTGG+lmqntyPCD1KCCZpZOcUyhdIG2BFn0o=;
        b=Nu1h5FTQR7nfTEVl8HRFO0G4X+KLhCz9KWSJ9qfZeKqvxEUEoRza7yKuL3RCqQe2UT
         LHUIcfwsi/SI+zUbxIcrbMsmSAfDTtq8HK02DuQhf2pNvIpdAfH6hxW8X11yASfhziR/
         3DEHq8y/VXwOfU65qP/pMKIovd8hiWr4BPKtK2tCF8pbGq8pQ9DepmoZ2hHqNnQxkWnF
         KLo14lwQg/Up+ScK0b5CQsZ83Zp+qg+setx4L/lPNFFwsL+2ldxVNvmNlL1yhfMgPe9x
         j9+9q4uBSMVAgjnKjUBkvL1MzQE7s4Rac1crinxmF6450keElPqwlRWs75Ypy/pQc/Ut
         Cisg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qKzAj5vVSTGG+lmqntyPCD1KCCZpZOcUyhdIG2BFn0o=;
        b=AXYVFGS/xsso9H1RZt7c6nObOB+53i6BKSqPvBGW7PwMVU/On6I1s98oK92GdOG0uZ
         13Eu5g9XJ/LoX6SGJvvtk8fenAKIxneue7IovMDGm5THvAeVe96wfM5MQS4HpJcZQ2lj
         +iPJVN3dHR7C6KhWAezg8IItmLqdyqqaki5QJp7YkmN1BbzffuNxrMO90k3TkY7zkwpA
         PzWzOhPzAmGM0XDAqEMplJaqG/zNhrraq9dQR1oBowDPOjT8AiknEBbtEqrSsTeTZC18
         8cuLl4FDlsiZkr3oz5JXgq17Z9ql/WZrP7YQG7owhfH/b5+Tctqg9JRHIKcuZSz3HL0S
         7ThA==
X-Gm-Message-State: AOAM532yQp3PWnPJO2LVyIkVHDGim5Z4CkA2uRwxnduF6L2JCEztG+pp
        fjL07w6AGffvIzg4FEV+B+8oAPkJoMTrg3mwlOSrgg==
X-Google-Smtp-Source: ABdhPJwp8p0x5w/MAR9g9ZdE/7poFPIkrBvB0bYc9yWtOursXvzRpQkVd+QjErbQ+HmOoQ5AujQOUwP4vvzBqq6ZFiw=
X-Received: by 2002:a17:906:6d56:: with SMTP id a22mr16811990ejt.440.1592950700787;
 Tue, 23 Jun 2020 15:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200619125923.22602-1-david@redhat.com> <20200619125923.22602-4-david@redhat.com>
 <CAPcyv4hvwHDa=1suuuEFX5mmpOm12kv-Axbd8G7bp9iaA+FWAA@mail.gmail.com> <7a5f9ea1-7405-7058-af60-eea0bc165e79@redhat.com>
In-Reply-To: <7a5f9ea1-7405-7058-af60-eea0bc165e79@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Jun 2020 15:18:09 -0700
Message-ID: <CAPcyv4jOgyc03hbOGMbQcSDTrpLjHbV+bKtbaqVqxWqBt-ezoQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mm/shuffle: remove dynamic reconfiguration
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 12:33 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 20.06.20 03:49, Dan Williams wrote:
> > On Fri, Jun 19, 2020 at 5:59 AM David Hildenbrand <david@redhat.com> wrote:
> >>
> >> Commit e900a918b098 ("mm: shuffle initial free memory to improve
> >> memory-side-cache utilization") promised "autodetection of a
> >> memory-side-cache (to be added in a follow-on patch)" over a year ago.
> >>
> >> The original series included patches [1], however, they were dropped
> >> during review [2] to be followed-up later.
> >>
> >> Due to lack of platforms that publish an HMAT, autodetection is currently
> >> not implemented. However, manual activation is actively used [3]. Let's
> >> simplify for now and re-add when really (ever?) needed.
> >>
> >> [1] https://lkml.kernel.org/r/154510700291.1941238.817190985966612531.stgit@dwillia2-desk3.amr.corp.intel.com
> >> [2] https://lkml.kernel.org/r/154690326478.676627.103843791978176914.stgit@dwillia2-desk3.amr.corp.intel.com
> >> [3] https://lkml.kernel.org/r/CAPcyv4irwGUU2x+c6b4L=KbB1dnasNKaaZd6oSpYjL9kfsnROQ@mail.gmail.com
> >>
> >> Cc: Andrew Morton <akpm@linux-foundation.org>
> >> Cc: Johannes Weiner <hannes@cmpxchg.org>
> >> Cc: Michal Hocko <mhocko@suse.com>
> >> Cc: Minchan Kim <minchan@kernel.org>
> >> Cc: Huang Ying <ying.huang@intel.com>
> >> Cc: Wei Yang <richard.weiyang@gmail.com>
> >> Cc: Mel Gorman <mgorman@techsingularity.net>
> >> Cc: Dan Williams <dan.j.williams@intel.com>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  mm/shuffle.c | 28 ++--------------------------
> >>  mm/shuffle.h | 17 -----------------
> >>  2 files changed, 2 insertions(+), 43 deletions(-)
> >>
> >> diff --git a/mm/shuffle.c b/mm/shuffle.c
> >> index dd13ab851b3ee..9b5cd4b004b0f 100644
> >> --- a/mm/shuffle.c
> >> +++ b/mm/shuffle.c
> >> @@ -10,33 +10,11 @@
> >>  #include "shuffle.h"
> >>
> >>  DEFINE_STATIC_KEY_FALSE(page_alloc_shuffle_key);
> >> -static unsigned long shuffle_state __ro_after_init;
> >> -
> >> -/*
> >> - * Depending on the architecture, module parameter parsing may run
> >> - * before, or after the cache detection. SHUFFLE_FORCE_DISABLE prevents,
> >> - * or reverts the enabling of the shuffle implementation. SHUFFLE_ENABLE
> >> - * attempts to turn on the implementation, but aborts if it finds
> >> - * SHUFFLE_FORCE_DISABLE already set.
> >> - */
> >> -__meminit void page_alloc_shuffle(enum mm_shuffle_ctl ctl)
> >> -{
> >> -       if (ctl == SHUFFLE_FORCE_DISABLE)
> >> -               set_bit(SHUFFLE_FORCE_DISABLE, &shuffle_state);
> >> -
> >> -       if (test_bit(SHUFFLE_FORCE_DISABLE, &shuffle_state)) {
> >> -               if (test_and_clear_bit(SHUFFLE_ENABLE, &shuffle_state))
> >> -                       static_branch_disable(&page_alloc_shuffle_key);
> >> -       } else if (ctl == SHUFFLE_ENABLE
> >> -                       && !test_and_set_bit(SHUFFLE_ENABLE, &shuffle_state))
> >> -               static_branch_enable(&page_alloc_shuffle_key);
> >> -}
> >>
> >>  static bool shuffle_param;
> >>  static int shuffle_show(char *buffer, const struct kernel_param *kp)
> >>  {
> >> -       return sprintf(buffer, "%c\n", test_bit(SHUFFLE_ENABLE, &shuffle_state)
> >> -                       ? 'Y' : 'N');
> >> +       return sprintf(buffer, "%c\n", shuffle_param ? 'Y' : 'N');
> >>  }
> >>
> >>  static __meminit int shuffle_store(const char *val,
> >> @@ -47,9 +25,7 @@ static __meminit int shuffle_store(const char *val,
> >>         if (rc < 0)
> >>                 return rc;
> >>         if (shuffle_param)
> >> -               page_alloc_shuffle(SHUFFLE_ENABLE);
> >> -       else
> >> -               page_alloc_shuffle(SHUFFLE_FORCE_DISABLE);
> >> +               static_branch_enable(&page_alloc_shuffle_key);
> >>         return 0;
> >>  }
> >
> > Let's do proper input validation here and require 1 / 'true' to enable
> > shuffling and not also allow 0 to be an 'enable' value.
>
> I don't think that's currently done?
>
> param_set_bool(val, kp) will only default val==NULL to 'true'. Passing 0
> will properly be handled by strtobool(). Or am I missing something?
>

No, I misread the patch and thought the conditional was being removed.

All good now.

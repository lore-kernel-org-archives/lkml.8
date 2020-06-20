Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 995F0C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 01:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A40520706
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 01:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="xavAsDmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbgFTBuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 21:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731502AbgFTBuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 21:50:12 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D66CC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 18:50:12 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l27so12255139ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 18:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=twWNVQ4JBSVnYybiZHHXD67URFG/e2UgNtu29WZERs8=;
        b=xavAsDmM7sRSxbBu/yKvIp3Lp4R0Bsu+h9uDpuZEVL98qayjabgZXEjzGGr/HojQZs
         UpxuRJ25mdfXkWVW6a2baEND3MUOUBPxaH3sydXtGsM7qP4lzVqNXomvOdwM8OGszrBG
         p+zTpGbtstHfuz512UqswzqJSBXIOkULJMPFaej9rlMhbdg6fUCOwIhFgRQcAFPaNv15
         8YG9mxyDcPd5kxifNcvoxwnElwqomShFvrKS5Y1M6x74uWcVgkcl/U0A06iCROo2N4ED
         RXuGRs5Zx9UJwuAgAjN13HyaeITMQxpbc101A4Bko0UzCYaUi7N+dp4M08ovX9y1Btw6
         qTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=twWNVQ4JBSVnYybiZHHXD67URFG/e2UgNtu29WZERs8=;
        b=s7du8+ij8UINPAQ9F73ini5/JJwH1Cwh8eI/T6jP4POIw7QozlleMLsXZAm7+j1JRK
         EJgFKjZIlfgiv17I8c78PU2Dic6gCdgjZNqonVSXJiuLjkJVOFLW9hN8jCSQCeEUDpSg
         nSStp5irvgJnm8P/LHFPQG4GhMdBTPFCmSgEgWJbnRlOr8HxUv+rsGGJSsLKYd5uO9b7
         /P1JurtDFDEPcsxvqL/FlRfH/SUn7RG9P+oUwskFozpSF4wly2Sny0SdZAt3zgDQg7gT
         +KQ6JM+6ujqc/jxvhtOyKjHm9JCGz4uRwi/rJ6d9HBWokd9xZNmQr7oLHhOE7XlWaA4V
         zuZQ==
X-Gm-Message-State: AOAM530sHKFgMXAuOjggdVt3no+nqU0ZAxfbGfO0GpEQEvoNhNSk/y+q
        FXX9ByOBdcL7aZTZ0rqLExp9WTIO5IuTQ56EcVdjew==
X-Google-Smtp-Source: ABdhPJyvN9t1Im80WqG/55D6zkuo0TpscIp3tYPFylkOLRRBVms1HpP94gyuRN6s/4qqFgU9cZEWZc0bmgB4AW3BXzw=
X-Received: by 2002:a17:906:bcfc:: with SMTP id op28mr5937381ejb.237.1592617810660;
 Fri, 19 Jun 2020 18:50:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200619125923.22602-1-david@redhat.com> <20200619125923.22602-4-david@redhat.com>
In-Reply-To: <20200619125923.22602-4-david@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 19 Jun 2020 18:49:59 -0700
Message-ID: <CAPcyv4hvwHDa=1suuuEFX5mmpOm12kv-Axbd8G7bp9iaA+FWAA@mail.gmail.com>
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

On Fri, Jun 19, 2020 at 5:59 AM David Hildenbrand <david@redhat.com> wrote:
>
> Commit e900a918b098 ("mm: shuffle initial free memory to improve
> memory-side-cache utilization") promised "autodetection of a
> memory-side-cache (to be added in a follow-on patch)" over a year ago.
>
> The original series included patches [1], however, they were dropped
> during review [2] to be followed-up later.
>
> Due to lack of platforms that publish an HMAT, autodetection is currently
> not implemented. However, manual activation is actively used [3]. Let's
> simplify for now and re-add when really (ever?) needed.
>
> [1] https://lkml.kernel.org/r/154510700291.1941238.817190985966612531.stgit@dwillia2-desk3.amr.corp.intel.com
> [2] https://lkml.kernel.org/r/154690326478.676627.103843791978176914.stgit@dwillia2-desk3.amr.corp.intel.com
> [3] https://lkml.kernel.org/r/CAPcyv4irwGUU2x+c6b4L=KbB1dnasNKaaZd6oSpYjL9kfsnROQ@mail.gmail.com
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Wei Yang <richard.weiyang@gmail.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/shuffle.c | 28 ++--------------------------
>  mm/shuffle.h | 17 -----------------
>  2 files changed, 2 insertions(+), 43 deletions(-)
>
> diff --git a/mm/shuffle.c b/mm/shuffle.c
> index dd13ab851b3ee..9b5cd4b004b0f 100644
> --- a/mm/shuffle.c
> +++ b/mm/shuffle.c
> @@ -10,33 +10,11 @@
>  #include "shuffle.h"
>
>  DEFINE_STATIC_KEY_FALSE(page_alloc_shuffle_key);
> -static unsigned long shuffle_state __ro_after_init;
> -
> -/*
> - * Depending on the architecture, module parameter parsing may run
> - * before, or after the cache detection. SHUFFLE_FORCE_DISABLE prevents,
> - * or reverts the enabling of the shuffle implementation. SHUFFLE_ENABLE
> - * attempts to turn on the implementation, but aborts if it finds
> - * SHUFFLE_FORCE_DISABLE already set.
> - */
> -__meminit void page_alloc_shuffle(enum mm_shuffle_ctl ctl)
> -{
> -       if (ctl == SHUFFLE_FORCE_DISABLE)
> -               set_bit(SHUFFLE_FORCE_DISABLE, &shuffle_state);
> -
> -       if (test_bit(SHUFFLE_FORCE_DISABLE, &shuffle_state)) {
> -               if (test_and_clear_bit(SHUFFLE_ENABLE, &shuffle_state))
> -                       static_branch_disable(&page_alloc_shuffle_key);
> -       } else if (ctl == SHUFFLE_ENABLE
> -                       && !test_and_set_bit(SHUFFLE_ENABLE, &shuffle_state))
> -               static_branch_enable(&page_alloc_shuffle_key);
> -}
>
>  static bool shuffle_param;
>  static int shuffle_show(char *buffer, const struct kernel_param *kp)
>  {
> -       return sprintf(buffer, "%c\n", test_bit(SHUFFLE_ENABLE, &shuffle_state)
> -                       ? 'Y' : 'N');
> +       return sprintf(buffer, "%c\n", shuffle_param ? 'Y' : 'N');
>  }
>
>  static __meminit int shuffle_store(const char *val,
> @@ -47,9 +25,7 @@ static __meminit int shuffle_store(const char *val,
>         if (rc < 0)
>                 return rc;
>         if (shuffle_param)
> -               page_alloc_shuffle(SHUFFLE_ENABLE);
> -       else
> -               page_alloc_shuffle(SHUFFLE_FORCE_DISABLE);
> +               static_branch_enable(&page_alloc_shuffle_key);
>         return 0;
>  }

Let's do proper input validation here and require 1 / 'true' to enable
shuffling and not also allow 0 to be an 'enable' value.

Other than that looks like the right move to me until end users or
distros start asking for the kernel to do this by default, I'm not
aware of any of those requests to date. People seem fine to set the
boot option.

After the above fixups you can add:

Acked-by: Dan Williams <dan.j.williams@intel.com>

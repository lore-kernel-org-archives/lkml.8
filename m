Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A97E5C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 03:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F26E206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 03:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdXdVxMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgCRDm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 23:42:26 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40673 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgCRDmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 23:42:25 -0400
Received: by mail-qk1-f196.google.com with SMTP id j2so23662421qkl.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 20:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8H/ZgaxOVCaLlv2GrR9cTt1R1atml+Y0nsu1LssXxwQ=;
        b=cdXdVxMpdS2avuxbJfe5fumPGhUiiHxepZsYIgnQmJ+ST2hWiySC7uwzwvcbw/bKx9
         RXEM5VIVIAru40XWZQpzspOEwIp3MUzCppzTpU7jPznQhoURhTsw6B52AaQIfjkI5KTJ
         bhF+vwHC/N55J6hj6fCgNv8nAXCT67g/lLRJPFgQW5h7zLVFE6Ko4mA2h7d9/isR3q7n
         VZVERe+xiAmXd6MKdvXm3oE1YST0CPxbHmwyVUeZTOfiDklbhe2MNzEFg3F+dhVWedwu
         Db5qp/YgOZW5sHwJBQeHU45TLOu9gr5TFmaacd4bK0h1u6L9Uhe9+zan+sNhGrgGnOHF
         y2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8H/ZgaxOVCaLlv2GrR9cTt1R1atml+Y0nsu1LssXxwQ=;
        b=bSsSUZ879LRJbEhgO3wRkJh1rY2fBvlJczvLkrWtjiSsMKnJ+8UyzVamWojG0K0INi
         VIA2L79CQD3fNvujIlx1YPZJvZnjdjiiigsenBbjTKSopbE5cO4b8wPgtOnwwQD6GkPh
         6F95UACkTLCplGyDpx8txcaI3uZJ4tgiBRNdahUW3X52eckOaCcv+kN5QLpQki+E5i4k
         mX9q0slUM8V8znGsbxnjaqK5BMDWHbLiD/V+kYhUP1Vs9f6Kb1MLs3l1/6/2gjOCFUy6
         UyPFiNovsZhQIdHevdiIRQkaYtP0SORQzIZaQgLR8sJGex/YlM4PjFQCxej0iwIJm5s4
         BMgw==
X-Gm-Message-State: ANhLgQ0YER+vj94pv5YKgCq8782xo7ZdIdr6LqJe7EebxHbDenMpoICL
        J1HEWTPsRU6fLv2kNdq/taCiQfT66ZO345g5ML8=
X-Google-Smtp-Source: ADFU+vu97TB9JeGN3HvNfR3wj+MzyNnoz/TUsk3S8bY5GJTQm7/MZx0oHWZIiRxVjiy5CXi3P/kqHyb5A08K4Sm82/A=
X-Received: by 2002:a37:546:: with SMTP id 67mr2041350qkf.272.1584502944545;
 Tue, 17 Mar 2020 20:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <1584502378-12609-1-git-send-email-iamjoonsoo.kim@lge.com> <1584502378-12609-3-git-send-email-iamjoonsoo.kim@lge.com>
In-Reply-To: <1584502378-12609-3-git-send-email-iamjoonsoo.kim@lge.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Wed, 18 Mar 2020 12:42:13 +0900
Message-ID: <CAAmzW4Nmo1EYkmHH5HHM=oTKjYqtqA_3TUr27yOJD4umh0suiA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm/page_alloc: integrate classzone_idx and high_zoneidx
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Ye Xiaolong <xiaolong.ye@intel.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 3=EC=9B=94 18=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 12:33, =
<js1304@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> classzone_idx is just different name for high_zoneidx now.
> So, integrate them and add some comment to struct alloc_context
> in order to reduce future confusion about the meaning of this variable.
>
> In addition to integration, this patch also renames high_zoneidx
> to highest_zoneidx since it represents more precise meaning.
>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  include/linux/compaction.h        |   9 ++--
>  include/linux/mmzone.h            |  12 ++---
>  include/trace/events/compaction.h |  22 ++++----
>  include/trace/events/vmscan.h     |  14 +++--
>  mm/compaction.c                   |  64 +++++++++++------------
>  mm/internal.h                     |  10 ++--
>  mm/memory_hotplug.c               |   6 +--
>  mm/oom_kill.c                     |   4 +-
>  mm/page_alloc.c                   |  60 +++++++++++-----------
>  mm/slab.c                         |   4 +-
>  mm/slub.c                         |   4 +-
>  mm/vmscan.c                       | 105 ++++++++++++++++++++------------=
------
>  12 files changed, 165 insertions(+), 149 deletions(-)

Oops... I miss the important part that documents highest_zoneidx.
Please see below.

Thanks.
------------------>8------------------
diff --git a/mm/internal.h b/mm/internal.h
index 7921150..4bbd10fc 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -115,6 +115,17 @@ struct alloc_context {
        nodemask_t *nodemask;
        struct zoneref *preferred_zoneref;
        int migratetype;
+
+       /*
+        * highest_zoneidx represents highest usable zone index of
+        * the allocation request. Due to the nature of the zone,
+        * memory on lower zone than the highest_zoneidx will be
+        * protected by lowmem_reserve[highest_zoneidx].
+        *
+        * highest_zoneidx is also used by reclaim/compaction to limit
+        * the target zone since higher zone than this index cannot be
+        * usable for this allocation request.
+        */
        enum zone_type highest_zoneidx;
        bool spread_dirty_pages;
 };

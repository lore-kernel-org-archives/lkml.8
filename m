Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91449C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 661D120672
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593463400;
	bh=/2yiMERYJACCwUiseh27nto2Fj2JrThoTtAhCKBKnUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L9yYvNkiCR7B9XI0+Civv5BWLCKXFtWFY/wiWVk62U+CulTeQZHdTUVTU21fYyA04
	 Gp63vIWK58BieOin5alhtMz96y2dz87PlX0j9z/pFz1yCxB+Fvdsk4/MFrOeCwCU+l
	 jrqCf07hl28Rxs37cICuClnz24RwiT6NYsu46Wv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgF2UnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731634AbgF2TOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:03 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8F6C014AF7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 00:55:13 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id h28so12019959edz.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 00:55:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Go+MGAqswQJ5Or7swZG3YdRuz2dFng+SdQlnF5u8UcY=;
        b=TrqZ78o6Lo7TxTA2f1Zw4bEtjp8PnlDTD8K4yPHe3LbvzdYRpokNRybEi1GB30yqvq
         InxvSRGZRUiJLvfCSj8Db1AoQQlW/apw9JprEJ1aGVWPTfpETjKGE7A8RlLyCyRBizGx
         8gwVumpmiAf1SlnW9MdUWid6Z4bjno3iMLckR3ZjKTap5+ISTAm7ilbnLz469BvWQnbX
         rGNPfDyQAlRc1iftjquNIBfLqsER8jBsBb3xcwJlp4AJD2zB0/Y4NZP/Ztv4CJCPwffq
         iv2hKTPOOJJez0ALBrjWzNA4bmOgQlbrvy6kRB8ksr86u3rxCXpeBFld9OuZdaYeUSFS
         IOgw==
X-Gm-Message-State: AOAM532vTScIu7yoJSCnkz4WLiuljXrFwXw8vWBUXkbDsuxGjJChk7/X
        RPNxqchXPX6kcKYxojyGwmU=
X-Google-Smtp-Source: ABdhPJynPWVX63OFc/KJXdxkxNjTlQ3FASZvpIdqRrmIoYOiBcrDUVoghxouzfD/w2WirFe+O5AHNQ==
X-Received: by 2002:a50:b086:: with SMTP id j6mr13392527edd.6.1593417312217;
        Mon, 29 Jun 2020 00:55:12 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id g22sm2606486eds.67.2020.06.29.00.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 00:55:11 -0700 (PDT)
Date:   Mon, 29 Jun 2020 09:55:10 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v3 4/8] mm/hugetlb: make hugetlb migration callback CMA
 aware
Message-ID: <20200629075510.GA32461@dhcp22.suse.cz>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-5-git-send-email-iamjoonsoo.kim@lge.com>
 <20200625115422.GE1320@dhcp22.suse.cz>
 <CAAmzW4MHuRhNqVXMntLAc_x4kJgkgQ-pD5GfFxRxJRchrEFr9g@mail.gmail.com>
 <20200626072324.GT1320@dhcp22.suse.cz>
 <CAAmzW4NLVwvqtoUb+JJ+WV=7_n800vA+YYC0LyrDS6iQ7wxcdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAmzW4NLVwvqtoUb+JJ+WV=7_n800vA+YYC0LyrDS6iQ7wxcdg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29-06-20 15:27:25, Joonsoo Kim wrote:
[...]
> Solution that Introduces a new
> argument doesn't cause this problem while avoiding CMA regions.

My primary argument is that there is no real reason to treat hugetlb
dequeing somehow differently. So if we simply exclude __GFP_MOVABLE for
_any_ other allocation then this certainly has some drawbacks on the
usable memory for the migration target and it can lead to allocation
failures (especially on movable_node setups where the amount of movable
memory might be really high) and therefore longterm gup failures. And
yes those failures might be premature. But my point is that the behavior
would be _consistent_. So a user wouldn't see random failures for some
types of pages while a success for others.

Let's have a look at this patch. It is simply working that around the
restriction for a very limited types of pages - only hugetlb pages
which have reserves in non-cma movable pools. I would claim that many
setups will simply not have many (if any) spare hugetlb pages in the
pool except for temporary time periods when a workload is (re)starting
because this would be effectively a wasted memory.

The patch is adding a special case flag to claim what the code already
does by memalloc_nocma_{save,restore} API so the information is already
there. Sorry I didn't bring this up earlier but I have completely forgot
about its existence. With that one in place I do agree that dequeing
needs a fixup but that should be something like the following instead.

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 57ece74e3aae..c1595b1d36f3 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1092,10 +1092,14 @@ static struct page *dequeue_huge_page_nodemask(struct hstate *h, gfp_t gfp_mask,
 /* Movability of hugepages depends on migration support. */
 static inline gfp_t htlb_alloc_mask(struct hstate *h)
 {
+	gfp_t gfp;
+
 	if (hugepage_movable_supported(h))
-		return GFP_HIGHUSER_MOVABLE;
+		gfp = GFP_HIGHUSER_MOVABLE;
 	else
-		return GFP_HIGHUSER;
+		gfp = GFP_HIGHUSER;
+
+	return current_gfp_context(gfp);
 }
 
 static struct page *dequeue_huge_page_vma(struct hstate *h,

If we even fix this general issue for other allocations and allow a
better CMA exclusion then it would be implemented consistently for
everybody.

Does this make more sense to you are we still not on the same page wrt
to the actual problem?
-- 
Michal Hocko
SUSE Labs

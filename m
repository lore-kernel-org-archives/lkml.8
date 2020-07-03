Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9556C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 00:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84352073E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 00:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnD/q/x5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgGCAzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 20:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgGCAzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 20:55:44 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44D9C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 17:55:44 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id z63so27439841qkb.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 17:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=R14iB3HyxYLduKlG30SljyVyNrxsxoGgt0DcZz0ltyM=;
        b=bnD/q/x53LVZJ/xSMYP8vb81Ov2apN4dLC7hNDSSSxVJtpH+fiIgZ254xxZhU6MWyj
         BaaZCw4cL4EDwAFLaEatFAEfGutlmkD1fQpmnZXlngPugTXLX39nuj2B4uwJJPWeHFdU
         8DiXLHrbfFEI66uNAU3lZfizvphLteL7SE2l4sXzOXmhe0oYiC90CiohXQXQbUgAJHv9
         jmVy7ut2qxw7UEASFUsu99p8E1z0WScKTA8+7GDzAieM4I7F56DZHIesn45b2bA6eTtQ
         ZShndqIXZapd+sOthbBLqYJLiAlkgZSz41Z2n5y6SoVZpcyGLtnHHVlgccCT79Zrk32U
         j55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=R14iB3HyxYLduKlG30SljyVyNrxsxoGgt0DcZz0ltyM=;
        b=Da1QjZuaCJpUqUJgiJS51iiUa1pLfJ54piprezqOD5hX5YE3PSJOhMYc3hWCfokWyf
         V2B6bXl2aqSwceAagaWK51jzM0izvpqFCVWQ28tYSpsTYnWAJAe1C5WAPe+3sPZUetoH
         25Ewi2ogPgQiMumeJ++ETLx0sSPrN5To1Ik9U1lp6F26TVsw4Cf6bhYgt1TCJY09vB0p
         2ZiLWsyYq0wT0vlmFEYTDwt9/dWUzyIewiCf7LRSMjHknoYF8iiZPfM82sm5Bsk3dZUC
         KV/rr8B8KmqyQPFnVaD7U9tmYhKNJ6Vy28H1jTQ0Xqnb1ahKmIei/MV2lnBtfQ/ewSYy
         rIcQ==
X-Gm-Message-State: AOAM532ElTz3Fz0w/s0vgWvYTn2MATBBNdIQ7Hro+gHyBHkOm8ACC6P0
        P1NzmBWTp0Vb3yCvArwH2ZRmSZj74B1osFx2cujqhdro
X-Google-Smtp-Source: ABdhPJxtn+eHCXYI2Y4J2s7umPGdlIBIgPLDIFVwggpDIFafCiKmGmXePo69C9JIjtMdVffJ7rlZ5R7gibtaFqAUnic=
X-Received: by 2002:a05:620a:a1b:: with SMTP id i27mr33128417qka.429.1593737743909;
 Thu, 02 Jul 2020 17:55:43 -0700 (PDT)
MIME-Version: 1.0
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-4-git-send-email-iamjoonsoo.kim@lge.com> <20200625112625.GD1320@dhcp22.suse.cz>
 <CAAmzW4N646-xYWosMwwnOgjAB+Z_eoZO4rs58ab+gYbHXmydJA@mail.gmail.com> <c3d97171-b36a-338b-5e5c-360bb52ffe0c@suse.cz>
In-Reply-To: <c3d97171-b36a-338b-5e5c-360bb52ffe0c@suse.cz>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Fri, 3 Jul 2020 09:55:33 +0900
Message-ID: <CAAmzW4OsP7tQ31X1qzezQXDcu7y-ox=QrbHm=KwxWmjQQW_Wsw@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] mm/hugetlb: unify migration callbacks
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 7=EC=9B=94 3=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 1:13, Vl=
astimil Babka <vbabka@suse.cz>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 6/26/20 6:02 AM, Joonsoo Kim wrote:
> > 2020=EB=85=84 6=EC=9B=94 25=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 8:2=
6, Michal Hocko <mhocko@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> >>
> >> On Tue 23-06-20 15:13:43, Joonsoo Kim wrote:
> >> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >> >
> >> > There is no difference between two migration callback functions,
> >> > alloc_huge_page_node() and alloc_huge_page_nodemask(), except
> >> > __GFP_THISNODE handling. This patch adds an argument, gfp_mask, on
> >> > alloc_huge_page_nodemask() and replace the callsite for
> >> > alloc_huge_page_node() with the call to
> >> > alloc_huge_page_nodemask(..., __GFP_THISNODE).
> >> >
> >> > It's safe to remove a node id check in alloc_huge_page_node() since
> >> > there is no caller passing NUMA_NO_NODE as a node id.
> >>
> >> Yes this is indeed safe. alloc_huge_page_node used to be called from
> >> other internal hugetlb allocation layer and that allowed NUMA_NO_NODE =
as
> >> well. Now it is called only from the mempolicy migration callback and
> >> that always specifies a node and want to stick with that node.
> >>
> >> But I have to say I really dislike the gfp semantic because it is
> >> different from any other allocation function I can think of. It
> >> specifies what to be added rather than what should be used.
> >>
> >> Removing the function is ok but please use the full gfp mask instead
> >> or if that is impractical for some reason (wich shouldn't be the case
> >> as htlb_alloc_mask should be trivial to make static inline) make it
> >> explicit that this is not a gfp_mask but a gfp modifier and explicitly
> >> state which modifiers are allowed.
> >
> > Okay. I will try to solve your concern. Concrete solution is not yet pr=
epared
> > but perhaps I will use full gfp_mask by using htlb_alloc_mask() in call=
er sites.
>
> Yeah, that should be feasible. alloc_huge_page_vma() already does
> htlb_alloc_mask(h). In alloc_new_node_page() and new_page_nodemask() it w=
ould be
> consistent with the other cases handled there (THP and base).

Okay. Will check it.

Thanks.

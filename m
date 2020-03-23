Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F6FC10F26
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 04:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA9F20719
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 04:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJBVGaEy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgCWESV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 00:18:21 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37423 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgCWESV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 00:18:21 -0400
Received: by mail-qt1-f196.google.com with SMTP id d12so8190054qtj.4
        for <linux-kernel@vger.kernel.org>; Sun, 22 Mar 2020 21:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XZ6ALnKcU8GcDCoOPSuVyF4QFHvhGeqgzFOKGeSC0Vg=;
        b=fJBVGaEy7KOWlF0tE1BYrzuhumGYB0dEhtuV8n7bDfbT27n4jyVdtkD+znxPp089pS
         lTFUyQv9lcSf9pFHucv52F5tnwfiodEjAjiCeFlHbrgkNeCn48OgJIr0gm3+wDhzQVIh
         BIlgCnzf9vW1RpPvr7puUFJFGXpfTN7HWeFvTfEroVXDq0JaiM8pZ7PS1Dw1/zXSEYjV
         lOn2YPmshDRKqt3BIZrVfLmMkDJU0tqiTJgE35rT6MD71B2VLzigd4We7TSuq3jxrKIB
         a6DRE20Ssyd9nez5022vOmcFy4MwmAbbONZNQWViCV6TBX9rG9q8RNNUeRS8zIfqgQyu
         rxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XZ6ALnKcU8GcDCoOPSuVyF4QFHvhGeqgzFOKGeSC0Vg=;
        b=JxQRFNZZmSbVlLteS4ezPodo2+03Q3zB2ltGODuRxgKKyYQM4wL+OmKtZnTWA+IrUq
         uWOVoQsvO4u7nIeEum8oluZtMMiPIeI93QNJYuh4t1Y98Vn6kuaYEcHRpPj0QOjb9LqH
         OTSnVNk/XLE8c/ZZ3HXX7lXr65GAluYAcO++eBhjgiLiC8cVAprRyQoxDIa/6ylfEll8
         5epIWEWoowH7FCS8BaaxfKGzOrV/FEijQdwO4Pq9QabdId0nDc8jor1aJAWzURnPI+1h
         LcWjFiM11BS89hpFmNNrzT/VqaO6xDLB1CdiWKE4ZU5ia5IuA3gilDlrhcHdiZbVBfnG
         qh0g==
X-Gm-Message-State: ANhLgQ3nDZDAkWfcbyw4s1d8NK/CB3l/QLAiohWbpOAuMa7+s5up5a9Z
        k1/BUzb2UnmXxkSsBw/rUeUS5xxjZdYcR7+m12w=
X-Google-Smtp-Source: ADFU+vtHqEKk2glIG9BQrGBFX4mSf9fs7yV9yFaJvVEQg8IAer5BX6uDG+e8M4RocqLDedeoeAJQ22aciHzwFeqURK4=
X-Received: by 2002:aed:3981:: with SMTP id m1mr1734059qte.35.1584937100110;
 Sun, 22 Mar 2020 21:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <1584693135-4396-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584693135-4396-2-git-send-email-iamjoonsoo.kim@lge.com> <20200320103000.GB3039@MiWiFi-R3L-srv>
 <CAAmzW4PVguD0jEEAt0ZUPqMykswuq2an21jRpP2ZuwRL6PYwCw@mail.gmail.com> <20200323035843.GH2987@MiWiFi-R3L-srv>
In-Reply-To: <20200323035843.GH2987@MiWiFi-R3L-srv>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Mon, 23 Mar 2020 13:18:09 +0900
Message-ID: <CAAmzW4Oejc8MFs91v=SWyy-GSLFskcFAGs1-J_4bYKv2Tt=F0g@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm/page_alloc: use ac->high_zoneidx for classzone_idx
To:     Baoquan He <bhe@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Ye Xiaolong <xiaolong.ye@intel.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 3=EC=9B=94 23=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 12:59, =
Baoquan He <bhe@redhat.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On 03/23/20 at 12:50pm, Joonsoo Kim wrote:
> > Hello, Baoquan.
> >
> > 2020=EB=85=84 3=EC=9B=94 20=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 7:3=
0, Baoquan He <bhe@redhat.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
> > >
> > >
> > > On 03/20/20 at 05:32pm, js1304@gmail.com wrote:
> > > > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> > > >
> > > > Currently, we use the zone index of preferred_zone which represents
> > > > the best matching zone for allocation, as classzone_idx. It has
> > > > a problem on NUMA systems when the lowmem reserve protection exists
> > > > for some zones on a node that do not exist on other nodes.
> > > >
> > > > In NUMA system, it can be possible that each node has different pop=
ulated
> > > > zones. For example, node 0 could have DMA/DMA32/NORMAL/MOVABLE zone=
 and
> > > > node 1 could have only NORMAL zone. In this setup, allocation reque=
st
> > > > initiated on node 0 and the one on node 1 would have different
> > > > classzone_idx, 3 and 2, respectively, since their preferred_zones a=
re
> > > > different. If the allocation is local, there is no problem. However=
,
> > > > if it is handled by the remote node due to memory shortage, the pro=
blem
> > > > would happen.
> > >
> > > Hi Joonsoo,
> > >
> > > Not sure if adding one sentence into above paragraph would be make it
> > > easier to understand. Assume you are only talking about the high_zone=
idx
> > > is MOVABLE_ZONE with calculation of gfp_zone(gfp_mask), since any oth=
er
> > > case doesn't have this problem. Please correct me if I am wrong.
> >
> > You're right. This example is for the allocation request with
> > gfp_zone(gfp_mask),
> > MOVABLE_ZONE.
> >
> > > In NUMA system, it can be possible that each node has different popul=
ated
> > > zones. For example, node 0 could have DMA/DMA32/NORMAL/MOVABLE zone a=
nd
> > > node 1 could have only NORMAL zone. In this setup, if we get high_zon=
eidx
> > > as 3 (namely MOVABLE zone), with gfp_zone(gfp_mask), allocation reque=
st
> > > initiated on node 0 and the one on node 1 would have different
> > > classzone_idx, 3 and 2, respectively, since their preferred_zones are
> > > different. If the allocation is local, there is no problem. However,
> > > if it is handled by the remote node due to memory shortage, the probl=
em
> > > would happen.
> >
> > I'm okay with your change but I try again to be better. Please check th=
e
> > following rewritten commit message and please let me know if it is bett=
er
> > than before.
>
> Yeah, this new one looks very detailed, I believe anyone interested can
> get what's going on. Thanks for doing this.

Thanks for checking it.
I will submit v4 with including this re-written commit message.

Thanks.

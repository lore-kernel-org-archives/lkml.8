Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6447DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 01:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 420B620748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 01:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O9a+aLg6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgEUBSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 21:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgEUBSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 21:18:55 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49AEC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 18:18:54 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f13so5769686qkh.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 18:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+3OSvgXp7d7mMIPIrDIx/ulZwnpTuAbryXHJMArWUuQ=;
        b=O9a+aLg6MZdkXFs1LsULVLnKRF5oQ7OJXY5Sr0xaIN+SB9yOAbz5p04DDYltlb+9Xc
         DM3CgKMQVBluzSQ8dfonEJ8dHgYP422uFe+uJrcIZQXVHkIFg9D4VuS1gy75u4FSRqaG
         X+TzGieXKYui5LqRkAPf5s4FQyvX1PqNQIoqhP4Pm6cbZP+6N8laTS8E86BYr05tmU07
         gu/PITan9RsnwIYMrUUEeeN19HdB9mzr1PqwXJNsdYuBaxsMr1mHJ4gvsi0/XSMH1qFv
         jwyKDbTLKSvzmkqxguIgJJOAlQ5I4qazA/Pv5y9ZGwKL9mEhnB5X8m2irbMYSZn21Cpr
         xf0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+3OSvgXp7d7mMIPIrDIx/ulZwnpTuAbryXHJMArWUuQ=;
        b=A3RxbQ+m4Fu2rnnoEADoIpkxTh7m/mY9P6Q6KpciCd/NiyUbDTiXtUvDcxpo8T9+Lj
         HPbvt7MOa6dbyGjaHzSuMBA+iHw0nSwxtQBCocCgg+YuJoRTA2gM0IH+JgY6SdoS3GLm
         KzoDZqclCMosb3YbbwA09exnBuNU1YP6XoLYSTySD6Fs/pGpGPFJ5gYloaT0HWUfqsvk
         PcUqbhHlOSFFSOgQ0Q+sfNPUO00CmNse4ta+MFAeoueK6I8sBWIFkI5Ta4rt7DWhqAcS
         Z/MdjPvUExzrSy9+1+CrDdegCs/ZuZpcinPqmh/A/QzVcuTVvK92h5IWmwxpo55ew6Vd
         3R3Q==
X-Gm-Message-State: AOAM53163C5+MhtB9fxRaDa2rGrDyaHL8vPhN0BNkmuY7ncuyS9zuDm/
        ksJ2yMw6xEmJU3NEzmW23AoEm0BolAnnvDWF7fA=
X-Google-Smtp-Source: ABdhPJxLkEGz9zfJhSCYb7AbUJ1yc+ysNJnfCiDfARS6DDS7rkatp9xk4ZX7CVbYQ8bOB7pUuRykc/JiZUuDYPyUs7U=
X-Received: by 2002:a37:6cc2:: with SMTP id h185mr5096040qkc.272.1590023933988;
 Wed, 20 May 2020 18:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <1589764857-6800-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1589764857-6800-2-git-send-email-iamjoonsoo.kim@lge.com> <20200521003716.GA317575@carbon.dhcp.thefacebook.com>
In-Reply-To: <20200521003716.GA317575@carbon.dhcp.thefacebook.com>
From:   Joonsoo Kim <js1304@gmail.com>
Date:   Thu, 21 May 2020 10:18:40 +0900
Message-ID: <CAAmzW4ND=AfXavSbraeWH2Pr-AQ=fTAiJFTBt66MrshMNEWuhA@mail.gmail.com>
Subject: Re: [PATCH 01/11] mm/page_isolation: prefer the node of the source page
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2020=EB=85=84 5=EC=9B=94 21=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 9:37, R=
oman Gushchin <guro@fb.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Mon, May 18, 2020 at 10:20:47AM +0900, js1304@gmail.com wrote:
> > From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> >
> > For locality, it's better to migrate the page to the same node
> > rather than the node of the current caller's cpu.
> >
> > Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> Acked-by: Roman Gushchin <guro@fb.com>

Thanks for review!

> > ---
> >  mm/page_isolation.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> > index 2c11a38..7df89bd 100644
> > --- a/mm/page_isolation.c
> > +++ b/mm/page_isolation.c
> > @@ -300,5 +300,7 @@ int test_pages_isolated(unsigned long start_pfn, un=
signed long end_pfn,
> >
> >  struct page *alloc_migrate_target(struct page *page, unsigned long pri=
vate)
> >  {
> > -     return new_page_nodemask(page, numa_node_id(), &node_states[N_MEM=
ORY]);
> > +     int nid =3D page_to_nid(page);
> > +
> > +     return new_page_nodemask(page, nid, &node_states[N_MEMORY]);
>
> Why not new_page_nodemask(page, page_to_nid(page), &node_states[N_MEMORY]=
) ?
> Still fits into 80 characters.

It's just my preference not directly using function call in argument
as much as possible.
If you don't like it, I will change it as you suggested. However,
since alloc_migrate_target()
will be removed in following patch, there will be no difference in the end.

Thanks.

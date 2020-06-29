Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BEAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59D4020656
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="TYDM21jl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbgF2WNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgF2WNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 18:13:38 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBED4C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 15:13:37 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id b15so14352698edy.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 15:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=K4P8LKVTe5uXiv5CF12dyUP3GsCS0f55L5RS9bYmy6s=;
        b=TYDM21jlaEWrczTgpptgS/N7rK1Bd/hFjHiVqFg8CH/odj/0JHq/SWjjosVXKTar0z
         JhK0lqHlowbBubO5YdLsUIeYZqoAIAx41jaVKt4jSZpb9qpKbMBklKkP+qPBJVhuzJ/8
         tvmvypxaw478c7pUQG3gCWp0B00HOvTU6J95+KtSNLm6Q/LEHfvPMfe+VpX9RiSXZYAb
         +BpANty5cTk/d/KSm1hi4dJ4MQ/01iP79D9O3qM3TdiboMmxEhtFQkndMeJiyPaI6TGC
         w1OmACGfeq4MdZD1B3EC1+N0XkJeGk3RNigxpW5ThA5OGMicYBnEvh9GttgQI6kck035
         ZZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=K4P8LKVTe5uXiv5CF12dyUP3GsCS0f55L5RS9bYmy6s=;
        b=ITTMg6dc7UTdj0wj0eV6ym5PxpMoQ6v4CQFchXcxurO+CYtl7GOxESF17NUg2trc7K
         j20PEH5m625KAuw+NdNCBOmARqjZRuGrjH2KtKZ1pXJwfiDOjfx14iSqblYvFmxJ3rFq
         4xa8HfjYxmSHDYbUoFuRsZpH8YPMNipzXFsY4H3xvoThafO48M9sHPEInxxtCqswnEm6
         PWdwlC8wMILk9RpJqsdTXOjRfMfUp6967XilJPRQU3MpzVe55dCCfPtpqflH+hnPwa6Q
         yg6kwhYZhSvZLuErqDzw0Yb3sFoWVOwCuXUgJTAC+yeOXiCeRBs/V3HjNlB+q+TqG8Dl
         VN/g==
X-Gm-Message-State: AOAM533H6yIOA28IZyEy4X02jqO1D32nD4JM8CiKrMVENYJG3sqzSp2I
        Ef/idcXdhXvCJeHD6V5161vTED1dOhdTx5ewrVniAg==
X-Google-Smtp-Source: ABdhPJxE92Vl3dMU6YdSUcgNvBLlsmv8x89spCVSrKlAXXuf4yBVYS/6NJ5lEkK2x5KqYdKSrSEwowTp1Kf9Tzq/l6Q=
X-Received: by 2002:aa7:c24d:: with SMTP id y13mr20776220edo.123.1593468816606;
 Mon, 29 Jun 2020 15:13:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAPcyv4gMQsBSQ-kXM6H_zz96ZTJ5F0XnDfq6_mZTn4t9JwmEpA@mail.gmail.com>
 <4D73CD59-BFD5-401A-A001-41F7BF5641BA@redhat.com> <CAPcyv4hnsUoavnzX8q5VReiLXrOsOYW0Ef5GDKxQtS+6pQLy4A@mail.gmail.com>
 <20200629083411.GA38188@L-31X9LVDL-1304.local>
In-Reply-To: <20200629083411.GA38188@L-31X9LVDL-1304.local>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 29 Jun 2020 15:13:25 -0700
Message-ID: <CAPcyv4gK2PL5YNLkeQjSCLrNZ62P1U_HjuBSNpkEvuHMcyeGOQ@mail.gmail.com>
Subject: Re: [PATCH] mm/spase: never partially remove memmap for early section
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>, Baoquan He <bhe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 1:34 AM Wei Yang
<richard.weiyang@linux.alibaba.com> wrote:
>
> On Thu, Jun 25, 2020 at 12:46:43PM -0700, Dan Williams wrote:
> >On Wed, Jun 24, 2020 at 10:53 PM David Hildenbrand <david@redhat.com> wr=
ote:
> >>
> >>
> >>
> >> > Am 25.06.2020 um 01:47 schrieb Dan Williams <dan.j.williams@intel.co=
m>:
> >> >
> >> > =EF=BB=BFOn Wed, Jun 24, 2020 at 3:44 PM Wei Yang
> >> > <richard.weiyang@linux.alibaba.com> wrote:
> >> > [..]
> >> >>> So, you are right that there is a mismatch here, but I think the
> >> >>> comprehensive fix is to allow early sections to be partially
> >> >>> depopulated/repopulated rather than have section_activate() and
> >> >>> section_deacticate() special case early sections. The special casi=
ng
> >> >>> is problematic in retrospect as section_deactivate() can't be
> >> >>> maintained without understand special rules in section_activate().
> >> >>
> >> >> Hmm... This means we need to adjust pfn_valid() too, which always r=
eturn true
> >> >> for early sections.
> >> >
> >> > Right, rather than carry workarounds in 3 locations, and the bug tha=
t
> >> > has resulted from then getting out of sync, just teach early section
> >> > mapping to allow for the subsection populate/depopulate.
> >> >
> >>
> >> I prefer the easy fix first - IOW what we Here here. Especially, pfn_t=
o_online_page() will need changes as well.
> >
> >Agree, yes, let's do the simple fix first for 5.8 and the special-case
> >elimination work later.
>
> Dan,
>
> A quick test shows this is not a simple task.

Thanks for taking a look...

> First, early sections don't set subsection bitmap, which is necessary for=
 the
> hot-add/remove.
>
> To properly set subsection bitmap, we need to know how many subsections i=
n
> early section. While current code doesn't has a alignment requirement for
> last early section. We mark the whole last early section as present.

I was thinking that the subsection map does not need to be accurate on
initial setup, it only needs to be accurate after the first removal.
However, that would result in new special casing that somewhat defeats
the purpose. The hardest part is potentially breaking up a PMD mapping
of the page array into a series of PTE mappings without disturbing
in-flight pfn_to_page() users.

> I don't find a way to enable this.

While I don't like that this bug crept into the mismatched special
casing of early sections, I'm now coming around to the same opinion.
I.e. that making the memmap for early sections permanent is a simpler
mechanism to maintain.

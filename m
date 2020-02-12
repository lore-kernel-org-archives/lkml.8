Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308E0C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06660217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 19:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581535538;
	bh=xjAs5P+3VFbhq1+HKipj0rlkvXEzY5u1PSc9zD/yAMA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QydeFvmy3CTFG5P54I4e5ckV+JbUv5yF6JX4MbkWe13Vk9jqd+7HC2Ugg9tZ69Q4N
	 b+p29pegn/5n8x3uUkpSZPeIfLlim7698tbLbtIIJLnpV49+Km/lePDh0QXZdaS/Qj
	 gSPl2Zmj0dlC63/4PrFStguY7QVvfB6NmiCxzTw8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgBLTZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 14:25:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:48818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728775AbgBLTZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 14:25:37 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED8F2217F4;
        Wed, 12 Feb 2020 19:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581535536;
        bh=xjAs5P+3VFbhq1+HKipj0rlkvXEzY5u1PSc9zD/yAMA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KxM9mFd/fproB88bxg02lKfgUh3Du7/kDwLfqln8PlYhzIDJrDG8vgHppaX4Da0a4
         NmE8uLTTY1pvtZIaSERemdT/5VbSCee1YWHPOtdkXkc7FC3LUZxhHBoGm6O+kmUpiB
         iHzpFAHJ/mb1PYz/BlDWpE90vQWXIV4rlGLJe7m8=
Received: by mail-qk1-f174.google.com with SMTP id c20so3243932qkm.1;
        Wed, 12 Feb 2020 11:25:35 -0800 (PST)
X-Gm-Message-State: APjAAAWmV+BGA3+7r9vWU4K9S7DCYvO7azuxHEbZrp+r46nuYXM07aYa
        Bg2lcHuuqw449sYzVf1Pw34gthjZ874kHjfzGg==
X-Google-Smtp-Source: APXvYqx+hrqJx34Va9jFgMZ0ER33LnOJQ3LLuYJWmPUC8WeTT6lW5ybMpNNgfTVwwSNdhSdkEyZf6qPgLGSrhl3hXdo=
X-Received: by 2002:ae9:f205:: with SMTP id m5mr12569288qkg.152.1581535535057;
 Wed, 12 Feb 2020 11:25:35 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200204125854eucas1p19ace564a5f45b9231e0fba8af07009cd@eucas1p1.samsung.com>
 <20200204125844.19955-1-m.szyprowski@samsung.com> <20200205054508.GG60221@umbus.fritz.box>
 <bc380fd8-71bb-897e-f060-b51386dec9be@samsung.com> <20200210234406.GH22584@umbus.fritz.box>
 <CAL_JsqJLLWnx-K9T5wv_i+FnPwbWpfak4RD_9P1Xz_2-XkYncA@mail.gmail.com> <1cc6258c-5bf3-3d48-2d6d-1a7176af1459@samsung.com>
In-Reply-To: <1cc6258c-5bf3-3d48-2d6d-1a7176af1459@samsung.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 12 Feb 2020 13:25:23 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+26ypxQ78f=Az_0qPY8Qk4kcO0978cvOikV1YCfeYKcA@mail.gmail.com>
Message-ID: <CAL_Jsq+26ypxQ78f=Az_0qPY8Qk4kcO0978cvOikV1YCfeYKcA@mail.gmail.com>
Subject: Re: [PATCH] libfdt: place new nodes & properties after the parent's ones
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     David Gibson <david@gibson.dropbear.id.au>,
        Devicetree Compiler <devicetree-compiler@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 12:57 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Rob,
>
> On 11.02.2020 21:29, Rob Herring wrote:
> > On Mon, Feb 10, 2020 at 5:44 PM David Gibson
> > <david@gibson.dropbear.id.au> wrote:
> >> On Mon, Feb 10, 2020 at 12:40:19PM +0100, Marek Szyprowski wrote:
> >>> Hi David,
> >>>
> >>> On 05.02.2020 06:45, David Gibson wrote:
> >>>> On Tue, Feb 04, 2020 at 01:58:44PM +0100, Marek Szyprowski wrote:
> >>>>> While applying dt-overlays using libfdt code, the order of the applied
> >>>>> properties and sub-nodes is reversed. This should not be a problem in
> >>>>> ideal world (mainline), but this matters for some vendor specific/custom
> >>>>> dtb files. This can be easily fixed by the little change to libfdt code:
> >>>>> any new properties and sub-nodes should be added after the parent's node
> >>>>> properties and subnodes.
> >>>>>
> >>>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >>>> I'm not convinced this is a good idea.
> >>>>
> >>>> First, anything that relies on the order of properties or subnodes in
> >>>> a dtb is deeply, fundamentally broken.  That can't even really be a
> >>>> problem with a dtb file itself, only with the code processing it.
> >>> I agree about the properties, but generally the order of nodes usually
> >>> implies the order of creation of some devices or objects.
> >> Huh?  From the device tree client's point of view the devices just
> >> exist - the order of creation should not be visible to it.
> > I'm not sure if downstream is different, but upstream this stems from
> > Linux initcalls being processed in link order within a given level.
> > It's much better than it used to be, but short of randomizing the
> > ordering, I'm not sure we'll ever find and fix all these hidden
> > dependencies.
>
> Downstream is probably much worse, because I've seen a lots of custom
> code iterating over the nodes and doing its initialization.
>
> >>> This sometimes
> >>> has some side-effects.
> >> If those side effects matter, your code is broken.  If you need to
> >> apply an order to nodes, you should be looking at 'reg' or other
> >> properties.
> > The general preference is to sort by 'reg'. And we try to catch and
> > reject any node re-ordering patches.
>
> If one applies an dt-overlay with current libfdt, the order of the all
> nodes from that overlay is reversed.

Sure, but my caring about the ordering ends at the source level.

Rob

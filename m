Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284CAC35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 20:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03EDA20842
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 20:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581452977;
	bh=050Spu/rOU3M2mOId8IXyEhwRlEOjhxlUycw+DTlrAU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=L6rPmvvlMafjN+DgXwvzkYaL9Ri4VaS8GnwfPFAiRJMkXDLpFxSc8zjUYPC/ZOj2E
	 YmH5qtSl+8sdyE77gCRcbjgsZo70btt5qV+sbOIaKojfgtVbQ/RDEDXOEGom1jdhmB
	 Hbi5ZiNjt7S0QpVpIyoGubeu+tXA4kvAIUgciQJA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731817AbgBKU3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 15:29:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:60066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728019AbgBKU3f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 15:29:35 -0500
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0566F20842;
        Tue, 11 Feb 2020 20:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581452975;
        bh=050Spu/rOU3M2mOId8IXyEhwRlEOjhxlUycw+DTlrAU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LefOiRP31zOt17a/0mZeErAs3SLjX6rxUajiE6zk+ZHw5rNpW0kPYozl2m3vp2OvQ
         HTUuTEX4/6m9nO8mHTctSbXZ+j7kHj5fdynX4FmZfVJsBmiKpM6eIPUkSXdnnXoY6H
         o3er5cfpYWlylCbvpwchBWOog+/g/IfGeFIzw2Ro=
Received: by mail-qv1-f43.google.com with SMTP id y8so5666231qvk.6;
        Tue, 11 Feb 2020 12:29:34 -0800 (PST)
X-Gm-Message-State: APjAAAUVTN7tt6WYFKAoFCsLCDPUfg0JDMmLUk1WUpsIDpGEAXXOuCqo
        GCdbPISWrAAOBcDbTabTbUUsDOWjaRiUXDHVkQ==
X-Google-Smtp-Source: APXvYqzMzy8SAQGTADa4Ad/96d4YLO1HXcb+kYrifg+OyLqqb/8mxacdP4IS2fUuUglqP9jTUMsTBcYW3SYhp8BSfEE=
X-Received: by 2002:ad4:4511:: with SMTP id k17mr4321626qvu.135.1581452974077;
 Tue, 11 Feb 2020 12:29:34 -0800 (PST)
MIME-Version: 1.0
References: <CGME20200204125854eucas1p19ace564a5f45b9231e0fba8af07009cd@eucas1p1.samsung.com>
 <20200204125844.19955-1-m.szyprowski@samsung.com> <20200205054508.GG60221@umbus.fritz.box>
 <bc380fd8-71bb-897e-f060-b51386dec9be@samsung.com> <20200210234406.GH22584@umbus.fritz.box>
In-Reply-To: <20200210234406.GH22584@umbus.fritz.box>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 11 Feb 2020 14:29:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJLLWnx-K9T5wv_i+FnPwbWpfak4RD_9P1Xz_2-XkYncA@mail.gmail.com>
Message-ID: <CAL_JsqJLLWnx-K9T5wv_i+FnPwbWpfak4RD_9P1Xz_2-XkYncA@mail.gmail.com>
Subject: Re: [PATCH] libfdt: place new nodes & properties after the parent's ones
To:     David Gibson <david@gibson.dropbear.id.au>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Devicetree Compiler <devicetree-compiler@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 5:44 PM David Gibson
<david@gibson.dropbear.id.au> wrote:
>
> On Mon, Feb 10, 2020 at 12:40:19PM +0100, Marek Szyprowski wrote:
> > Hi David,
> >
> > On 05.02.2020 06:45, David Gibson wrote:
> > > On Tue, Feb 04, 2020 at 01:58:44PM +0100, Marek Szyprowski wrote:
> > >> While applying dt-overlays using libfdt code, the order of the applied
> > >> properties and sub-nodes is reversed. This should not be a problem in
> > >> ideal world (mainline), but this matters for some vendor specific/custom
> > >> dtb files. This can be easily fixed by the little change to libfdt code:
> > >> any new properties and sub-nodes should be added after the parent's node
> > >> properties and subnodes.
> > >>
> > >> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > I'm not convinced this is a good idea.
> > >
> > > First, anything that relies on the order of properties or subnodes in
> > > a dtb is deeply, fundamentally broken.  That can't even really be a
> > > problem with a dtb file itself, only with the code processing it.
> >
> > I agree about the properties, but generally the order of nodes usually
> > implies the order of creation of some devices or objects.
>
> Huh?  From the device tree client's point of view the devices just
> exist - the order of creation should not be visible to it.

I'm not sure if downstream is different, but upstream this stems from
Linux initcalls being processed in link order within a given level.
It's much better than it used to be, but short of randomizing the
ordering, I'm not sure we'll ever find and fix all these hidden
dependencies.

> > This sometimes
> > has some side-effects.
>
> If those side effects matter, your code is broken.  If you need to
> apply an order to nodes, you should be looking at 'reg' or other
> properties.

The general preference is to sort by 'reg'. And we try to catch and
reject any node re-ordering patches.

Rob

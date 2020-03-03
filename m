Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A196C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215BF2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583252440;
	bh=Zro81PjZvB79s/jq+XpT7vaGwIFOydrEpcLyBTIre54=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mBP42n53Yd2EBgvBHhJDpLqh1O8YZ+nGc6zB/T/kUVKx/+rAFIH4PBCUQTujAQsAO
	 ZFmwn8VrTQEJ1Ftfbu12dJskjbRvz+Wa0rpjAP/iNGetHHsqMQGlXZdeMqN46wTnWg
	 u/aXbAtpG0T9wjQqEdX7wl36cFHLh7SOIGc/y2kA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbgCCQUj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:20:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:41258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729382AbgCCQUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:20:38 -0500
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 950FF2083E;
        Tue,  3 Mar 2020 16:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583252437;
        bh=Zro81PjZvB79s/jq+XpT7vaGwIFOydrEpcLyBTIre54=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sZ3DrP5arT5Uda74vumLAa2MSbiNfVIz2luVx9rFYxLtcTC+Oo7EmkFLEhd6nGgtt
         As4a7DIpa9oZD61Zh6Lupbal35pfS6oGqT702EMqmCMvq6nNUoTNDo0IooWVwvyBVr
         TTmvdioo2VKymQ3tSv+czlZGw+dYuvwe1sLSIV20=
Received: by mail-qk1-f171.google.com with SMTP id p62so3978147qkb.0;
        Tue, 03 Mar 2020 08:20:37 -0800 (PST)
X-Gm-Message-State: ANhLgQ30HbpvgZ6+2NJAJr37vQ32zfIyyMHCWTMWRtxKBGg3Zqv4K/C5
        ghrd5CixpyySh60F5F08gxlu0PshloXEEFHJkg==
X-Google-Smtp-Source: ADFU+vuMjEgENnYXMgZ0DZmjYOU7SV2y7ndmmk013/U+mJxM6sg3qyyrWb9wOcVBJrSmdtBfV9DfCHaWZOqInJyC6r0=
X-Received: by 2002:a05:620a:1015:: with SMTP id z21mr4780777qkj.393.1583252436658;
 Tue, 03 Mar 2020 08:20:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1583135507.git.mchehab+huawei@kernel.org>
 <20200302123554.08ac0c34@lwn.net> <20200303080947.5f381004@onda.lan>
In-Reply-To: <20200303080947.5f381004@onda.lan>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 3 Mar 2020 10:20:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKsZNFDSsZJ+wzgD1Eaf0fBwZ7BeUv=32jAuE29TeRfnA@mail.gmail.com>
Message-ID: <CAL_JsqKsZNFDSsZJ+wzgD1Eaf0fBwZ7BeUv=32jAuE29TeRfnA@mail.gmail.com>
Subject: Re: [PATCH v2 00/12] Convert some DT documentation files to ReST
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 1:09 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Mon, 2 Mar 2020 12:35:54 -0700
> Jonathan Corbet <corbet@lwn.net> escreveu:
>
> > On Mon,  2 Mar 2020 08:59:25 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >
> > > While most of the devicetree stuff has its own format (with is now being
> > > converted to YAML format), some documents there are actually
> > > describing the DT concepts and how to contribute to it.
> > >
> > > IMHO, those documents would fit perfectly as part of the documentation
> > > body, as part of the firmare documents set.
> > >
> > > This patch series manually converts some DT documents that, on my
> > > opinion, would belong to it.
> >
> > Did you consider putting this stuff into the firmware-guide while you were
> > at it?  It's not a perfect fit, I guess, but it doesn't seem too awkward
> > either.
>
> I placed it just below the firmware-guide at the main index file.
>
> I have split thoughts about moving the files to there, though. From
> one side, it may fit better from the PoV of organizing the documentation.
>
> From other side, newcomers working with DT may expect looking at the
> text files inside Documentation/devicetree/.
>
> Maybe I could add an extra patch at the end of this series with the
> move, adding a "RFC" on his title. This way, we can better discuss it,
> and either merge the last one or not depending on the comments.

Keep in mind that we generate a standalone DT only tree[1] with the
documentation, dts files and headers. So things should be structured
such that all the DT documentation could be built by itself without
dependencies on the 'kernel documentation'. I'm not asking for that to
be done in this series, but just don't do anything to make that
harder. I don't *think* have, but just want to make sure that's clear.

> > It also seems like it would be good to CC the devicetree folks, or at
> > least the devicetree mailing list?

I was wondering what happened to the cover letter on v2...

> Yeah, that would make sense. I'm using get-maintainers script to
> prepare the c/c list, as it is simply too much work to find the
> right maintainers by hand, for every single patch.
>
> I just noticed today that there's just *one entry* at MAINTAINERS
> file for Documentation/devicetree, and that points to you:
>
>         DOCUMENTATION
>         M:      Jonathan Corbet <corbet@lwn.net>
>         L:      linux-doc@vger.kernel.org
>         S:      Maintained
>         F:      Documentation/
>         F:      scripts/documentation-file-ref-check
>         F:      scripts/kernel-doc
>         F:      scripts/sphinx-pre-install
>         X:      Documentation/ABI/
>         X:      Documentation/firmware-guide/acpi/
>         X:      Documentation/devicetree/

You mean doesn't point to Jon as 'X' is exclude. You missed this entry:

OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
M:      Rob Herring <robh+dt@kernel.org>
M:      Mark Rutland <mark.rutland@arm.com>
L:      devicetree@vger.kernel.org
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
Q:      http://patchwork.ozlabs.org/project/devicetree-bindings/list/
S:      Maintained
F:      Documentation/devicetree/
F:      arch/*/boot/dts/
F:      include/dt-bindings/


Rob

[1] https://git.kernel.org/pub/scm/linux/kernel/git/devicetree/devicetree-rebasing.git/

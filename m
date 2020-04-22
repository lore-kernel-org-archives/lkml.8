Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC52C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 18:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67C4B2098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 18:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587581771;
	bh=v69b7vmZ0eLZh99wm9q28w3sHZaF7q7WgriZl7iMEOw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Ku1yqyed/IfbRDxnz5ed0M2bw0nQm0zTS18xqeWV9iAOzTeh7tdD7Y0W+y/TJYBDa
	 3UQv8LpaHo0Dp6REDyQMIk2EMe17juze68mlMCOLkOzDMOkasCdEfifYORzrZ1181s
	 E4y5LlLq4WrzalAiG0ws44HgAnFgKmWWwrA7CDlQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgDVS4L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 14:56:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:36924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgDVS4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 14:56:10 -0400
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A0D32098B;
        Wed, 22 Apr 2020 18:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587581769;
        bh=v69b7vmZ0eLZh99wm9q28w3sHZaF7q7WgriZl7iMEOw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R7PsJtfr815M6Brz+ry8bWH9Y1hGlVLp9bQvXw9Vchv8T2gb1ss7CDapjfIOR7vhk
         jsZFTaDaDC+SbdXaEkfZRRwJ7odrdQGUr7bskWeBTFE56+6M8V8JCopvDHTkpFC3vQ
         ZYn18s+4O9H3LhJonXfGV/ITThQv+iMBc1bEPsC4=
Received: by mail-qv1-f41.google.com with SMTP id bu9so1445890qvb.13;
        Wed, 22 Apr 2020 11:56:09 -0700 (PDT)
X-Gm-Message-State: AGi0Pua7kuLioJSadLef7eyK0A+OSQ8ZlKyHvw9R9v5bErp0CP71XJDX
        35+k8q/luN/PM5OUYLRCiHMebMqLOCSwdJn0DQ==
X-Google-Smtp-Source: APiQypIJaASJPwct+KoZCwFauHfNW3dT2aDQFGODpZYHuCnvrMX4GZazEr8aeaUodJU7mtFBPGEgyjTJSWIJIH0SwlI=
X-Received: by 2002:a05:6214:1848:: with SMTP id d8mr379136qvy.136.1587581768236;
 Wed, 22 Apr 2020 11:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200421212004.6146-1-robh@kernel.org> <CAK7LNASrBW0mL+g=ocQAz1Ggt-c_WX5NyGeRdJGubwSfnhcHaA@mail.gmail.com>
In-Reply-To: <CAK7LNASrBW0mL+g=ocQAz1Ggt-c_WX5NyGeRdJGubwSfnhcHaA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 22 Apr 2020 13:55:56 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+-vnqr_LLW0g4UuMw2BEJBAS-kBqFeuV3YBcY+8XBFPQ@mail.gmail.com>
Message-ID: <CAL_Jsq+-vnqr_LLW0g4UuMw2BEJBAS-kBqFeuV3YBcY+8XBFPQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: Fix command line length limit calling dt-mk-schema
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 12:59 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Hi Rob,
>
>
> On Wed, Apr 22, 2020 at 6:20 AM Rob Herring <robh@kernel.org> wrote:
> >
> > As the number of schemas has increased, we're starting to hit the error
> > "execvp: /bin/sh: Argument list too long". This is due to passing all the
> > schema files on the command line to dt-mk-schema. It currently is only
> > with out of tree builds and is intermittent depending on the file path
> > lengths.
> >
> > Commit 2ba06cd8565b ("kbuild: Always validate DT binding examples") made
> > hitting this proplem more likely since the example validation now always
> > gets the full list of schemas.
> >
> > Fix this by putting the schema file list into a temp file and using xargs.
> >
> > Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/.gitignore | 2 +-
> >  Documentation/devicetree/bindings/Makefile   | 3 ++-
> >  2 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/.gitignore b/Documentation/devicetree/bindings/.gitignore
> > index 5c6d8ea1a09c..0a6aef915fa4 100644
> > --- a/Documentation/devicetree/bindings/.gitignore
> > +++ b/Documentation/devicetree/bindings/.gitignore
> > @@ -1,3 +1,3 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> >  *.example.dts
> > -processed-schema*.yaml
> > +processed-schema*.yaml*
> > diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> > index 1df680d07461..1c1cad860b7c 100644
> > --- a/Documentation/devicetree/bindings/Makefile
> > +++ b/Documentation/devicetree/bindings/Makefile
> > @@ -14,7 +14,8 @@ $(obj)/%.example.dts: $(src)/%.yaml FORCE
> >  DT_TMP_SCHEMA := $(obj)/processed-schema-examples.yaml
> >
> >  quiet_cmd_mk_schema = SCHEMA  $@
> > -      cmd_mk_schema = $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@ $(real-prereqs)
> > +      cmd_mk_schema = $(file >$@.tmp, $(real-prereqs)) \
> > +                      cat $@.tmp | xargs $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@
> >
>
>
> The built-in function $(file ...) is supported on GNU Make 4.0 or later.
> The current minimal version is GNU Make 3.81.
>
> If you want to use this function, you must update
> Documentation/process/changes.rst first.
>
> I am pretty sure some conservative distros
> still stick to GNU Make 3.8*
> but I am open to raising the minimal version
> if it is useful.

I'd like to avoid that. I've come up with another solution.

> But, does this code work in the first place?
>
> When a very long command is given, xargs
> splits it into smaller chunks, and invokes
> the command multiple times, right?
>
>
> So, it boils down to this question:
>
> Are the following two commands work equivalently?
>
>
> "dt-mk-schema -o processed-schema-examples.yaml foo.yaml &&
> dt-mk-schema -o processed-schema-examples.yaml bar.yaml &&
> dt-mk-schema -o processed-schema-examples.yaml baz.yaml"
>
> "dt-mk-schema -o processed-schema-examples.yaml foo.yaml bar.yaml baz.yaml"
>
>
> I think the answer is no.
>
> I confirmed the produced processed-schema-examples.yaml is broken.

Indeed. We need to output to stdout and append the file instead.
Sending a v2 out now.

[...]

> Can dt-mk-schema read the list of schema files
> by other means?

Not currently. Happy to add it, but I'd rather not require everyone
update right away.

Rob

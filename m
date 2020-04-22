Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1FC6C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 05:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B08D5206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 05:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587535178;
	bh=8IaSgDSLU8xYm900xksxRZ3rRz+47+uWCuP57TaHiSk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dl5pa8BR4YssT5KZ0agjG3lfsXldVIpWRNAz0OwUV4HZbqCvueLXxAajYv1PnkOXn
	 HkHqVbmO+kHKwKdyp2dlKlGitPQBwWbQ2b2j45m758mFx3gSHwLImJrQEpxFRvi6qF
	 dQKdwI3IGZEfOP77PJrvGlPxWqgYcE9e3+DefL88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726415AbgDVF7h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 01:59:37 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:45784 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgDVF7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 01:59:36 -0400
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 03M5x5WX002217;
        Wed, 22 Apr 2020 14:59:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 03M5x5WX002217
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587535146;
        bh=seiSfwWiNI4V0jqT1v3MtfXuAE1wvYt6UInOKdV98Wk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PG/TXKE7hKFrVuqz/bSJuLMe3Vge/PVEObk1aIfOzVm/PXK1EVk8jzvXFOk23CecV
         m9+VpUyPQXSP34q189gqyAMKfzgfz0O/3Pyg+NpCHc+UwVgLE5BYsFTCJDdUh7Fhq8
         PwDWO7SX8FM8sHgvH4BLcVINGQHcoln6nmHExKegguLvbi4Bq759CV6WwC08uVUot6
         gSy8wDf/nc6LeuUoyIS1itzC++4D2ZhFDJoB5Z0/hlsHSQXq3Waz7WM9K1JsjLdO6t
         Ry9sm9qTQibIaRA5/+CUBM30w3Y68Ke9JF67lTGRYKSjNa2CjMV96pfTp1adrJFKc1
         rn0cD6RgDqwXw==
X-Nifty-SrcIP: [209.85.221.177]
Received: by mail-vk1-f177.google.com with SMTP id n128so331631vke.5;
        Tue, 21 Apr 2020 22:59:06 -0700 (PDT)
X-Gm-Message-State: AGi0PubXWXXbbf61jaJKNvrLj+4bPZP72DzYiVgK2qkClK0ABEWXDK4Y
        RAcwFbVqdyVpN6ivqXBx06EhrwOJopDuaE+0C0o=
X-Google-Smtp-Source: APiQypKsajKPEYSBekdZFNRdiIg8ikbQ6vWDyOltmnrv7IL0jGCos2arjfUh8JCuA92EvHnRCIdAbLzpMnl9xOu1ruU=
X-Received: by 2002:a1f:5c03:: with SMTP id q3mr18921288vkb.66.1587535145254;
 Tue, 21 Apr 2020 22:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200421212004.6146-1-robh@kernel.org>
In-Reply-To: <20200421212004.6146-1-robh@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 22 Apr 2020 14:58:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNASrBW0mL+g=ocQAz1Ggt-c_WX5NyGeRdJGubwSfnhcHaA@mail.gmail.com>
Message-ID: <CAK7LNASrBW0mL+g=ocQAz1Ggt-c_WX5NyGeRdJGubwSfnhcHaA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: Fix command line length limit calling dt-mk-schema
To:     Rob Herring <robh@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,


On Wed, Apr 22, 2020 at 6:20 AM Rob Herring <robh@kernel.org> wrote:
>
> As the number of schemas has increased, we're starting to hit the error
> "execvp: /bin/sh: Argument list too long". This is due to passing all the
> schema files on the command line to dt-mk-schema. It currently is only
> with out of tree builds and is intermittent depending on the file path
> lengths.
>
> Commit 2ba06cd8565b ("kbuild: Always validate DT binding examples") made
> hitting this proplem more likely since the example validation now always
> gets the full list of schemas.
>
> Fix this by putting the schema file list into a temp file and using xargs.
>
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/.gitignore | 2 +-
>  Documentation/devicetree/bindings/Makefile   | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/.gitignore b/Documentation/devicetree/bindings/.gitignore
> index 5c6d8ea1a09c..0a6aef915fa4 100644
> --- a/Documentation/devicetree/bindings/.gitignore
> +++ b/Documentation/devicetree/bindings/.gitignore
> @@ -1,3 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  *.example.dts
> -processed-schema*.yaml
> +processed-schema*.yaml*
> diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> index 1df680d07461..1c1cad860b7c 100644
> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -14,7 +14,8 @@ $(obj)/%.example.dts: $(src)/%.yaml FORCE
>  DT_TMP_SCHEMA := $(obj)/processed-schema-examples.yaml
>
>  quiet_cmd_mk_schema = SCHEMA  $@
> -      cmd_mk_schema = $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@ $(real-prereqs)
> +      cmd_mk_schema = $(file >$@.tmp, $(real-prereqs)) \
> +                      cat $@.tmp | xargs $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@
>


The built-in function $(file ...) is supported on GNU Make 4.0 or later.
The current minimal version is GNU Make 3.81.

If you want to use this function, you must update
Documentation/process/changes.rst first.

I am pretty sure some conservative distros
still stick to GNU Make 3.8*
but I am open to raising the minimal version
if it is useful.



But, does this code work in the first place?

When a very long command is given, xargs
splits it into smaller chunks, and invokes
the command multiple times, right?


So, it boils down to this question:

Are the following two commands work equivalently?


"dt-mk-schema -o processed-schema-examples.yaml foo.yaml &&
dt-mk-schema -o processed-schema-examples.yaml bar.yaml &&
dt-mk-schema -o processed-schema-examples.yaml baz.yaml"

"dt-mk-schema -o processed-schema-examples.yaml foo.yaml bar.yaml baz.yaml"


I think the answer is no.

I confirmed the produced processed-schema-examples.yaml is broken.

In a normal case, it is more than 50000 lines,
but if xargs split the command, it is much smaller.



masahiro@oscar:~/ref/linux$ make -j24  O=foo/bar dt_binding_check
masahiro@oscar:~/ref/linux$ wc
foo/bar/Documentation/devicetree/bindings/processed-schema-examples.yaml
  51461  115967 1516186
foo/bar/Documentation/devicetree/bindings/processed-schema-examples.yaml




masahiro@oscar:~/ref/this/is/a/long/long/long/long/long/long/long/long/long/long/long/long/long/long/long/long/long/long/long/long/long/long/long/long/src/path/to/linux$
make -j24 O=foo/bar dt_binding_check
masahiro@oscar:~/ref/this/is/a/long/long/long/long/long/long/long/long/long/long/long/long/long/long/long/long/long/long/long/long/long/long/long/long/src/path/to/linux$
wc  foo/bar/Documentation/devicetree/bindings/processed-schema-examples.yaml
  9625  21510 291993
foo/bar/Documentation/devicetree/bindings/processed-schema-examples.yaml



Can dt-mk-schema read the list of schema files
by other means?


>  DT_DOCS = $(addprefix $(src)/, \
>         $(shell \
> --
> 2.20.1
>


-- 
Best Regards
Masahiro Yamada

Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E0DC55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83DD82098B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 15:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587654553;
	bh=3XM5u8fRGtkUVzS6W19Lz1rJZWxKjOjDDFjU2BkBQj0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Rj+est5q0GtXJ3yAmYEzwsGs/YxsuMRR2Dt0t1S6HqKPrlDBo1uebvgTpQ2ddVPr8
	 IBeGjK35uQ1CSI9a+wVFuGNgnwaRxuIepUjCFtm/Rtx05s8Az74PdpxlAQVHTg7MuB
	 grhytRcBqugNrk+Sk3Z3ZBhmhZ9XgKuRIXkN/bRs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbgDWPJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 11:09:12 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:31201 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbgDWPJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:09:12 -0400
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 03NF8iBQ018040;
        Fri, 24 Apr 2020 00:08:44 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 03NF8iBQ018040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587654525;
        bh=+DlzjDpib8laCDy2JUu2OfEgSqg9h54FYVo2uotXvMI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NPgDDsojOl7j2yH2Q1/NnhLkkhuYhMPihzu/fKk48UqeMXvvSzvv2Q0i7VuOt7FAr
         xIpzIl0mx460wO8PERYk4EBNabwPoHROCPFQ4e4IpPvXaI3NReLEjmmtUSlwJIHeFY
         k5vZPCnofo9sH+bQtg17V708AMbqGzmYgHxd6sjfOVjpm3K/2YeOc1+r/1HUa7wwKV
         zyFOf6KU6zUm8swBeBqlzNfcWN+XveMSR3wEPywLINM4i4Phu5f2r8GjA3D+O9lTqh
         iQw2cvdwJwiBr1tgBUdgInJmXFeKVlrj3AmknvTDYpf2wWTccLfgpY17nMc482n06w
         UfltsRIs98vVg==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id i5so6009872uaq.1;
        Thu, 23 Apr 2020 08:08:44 -0700 (PDT)
X-Gm-Message-State: AGi0PuaSp0NSRz0FcuMmo20IJQvaGMU3UBbYkXd7Tshsbuep4HpJt9C0
        ob/UImLKoV8uJrYHkQ22ZzFHs6QRgul7uWBO+HI=
X-Google-Smtp-Source: APiQypIRMJX5auFftzRo3peuQH5roT/wqAq0thBDMbVxeUrJ/YnIr+N1ra1Ide1tPXEE5bafv8C+vQy2G+0+9j/C5lA=
X-Received: by 2002:a9f:28c5:: with SMTP id d63mr3463972uad.25.1587654523415;
 Thu, 23 Apr 2020 08:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200422185708.6363-1-robh@kernel.org>
In-Reply-To: <20200422185708.6363-1-robh@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 24 Apr 2020 00:08:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS_HtT6sZtKEVDGZjbG=hyZKf4Oy1sZ3JNfmewdDgCgYA@mail.gmail.com>
Message-ID: <CAK7LNAS_HtT6sZtKEVDGZjbG=hyZKf4Oy1sZ3JNfmewdDgCgYA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: Fix command line length limit calling dt-mk-schema
To:     Rob Herring <robh@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 3:57 AM Rob Herring <robh@kernel.org> wrote:
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
> Fix this by passing the schema file list in a pipe and using xargs. We end
> up doing the find twice, but the time is insignificant compared to the
> dt-mk-schema time.
>
> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>


Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>


> ---
>  Documentation/devicetree/bindings/Makefile | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> index 87c76bdabfe6..7782d9985082 100644
> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -14,16 +14,18 @@ $(obj)/%.example.dts: $(src)/%.yaml FORCE
>  # Use full schemas when checking %.example.dts
>  DT_TMP_SCHEMA := $(obj)/processed-schema-examples.yaml
>
> +find_cmd = find $(srctree)/$(src) \( -name '*.yaml' ! \
> +               -name 'processed-schema*' ! \
> +               -name '*.example.dt.yaml' \)
> +
>  quiet_cmd_mk_schema = SCHEMA  $@
> -      cmd_mk_schema = $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) -o $@ $(real-prereqs)
> +      cmd_mk_schema = rm -f $@ ; \
> +                      $(if $(DT_MK_SCHEMA_FLAGS), \
> +                           echo $(real-prereqs), \
> +                           $(find_cmd)) | \
> +                      xargs $(DT_MK_SCHEMA) $(DT_MK_SCHEMA_FLAGS) >> $@
>
> -DT_DOCS = $(addprefix $(src)/, \
> -       $(shell \
> -       cd $(srctree)/$(src) && \
> -       find * \( -name '*.yaml' ! \
> -               -name 'processed-schema*' ! \
> -               -name '*.example.dt.yaml' \) \
> -       ))
> +DT_DOCS = $(shell $(find_cmd) | sed -e 's|^$(srctree)/||')
>
>  DT_SCHEMA_FILES ?= $(DT_DOCS)
>
> --
> 2.20.1
>


-- 
Best Regards
Masahiro Yamada

Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF96C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53E51221F7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587146208;
	bh=vpJdUVfmmmrAtQ2EILlcH8G1p0rl6WnTcV9XxcGGlYI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=cE4UKr6FTen9ylS5erFNiqpiMwoPlzp6WGUx8URzQJYTnPGqFje6YSl8ocEg9n95T
	 qJcxpLAOxzgU8wPrEhWNqPiuhqHzJR8vA69RxZ977I2oRrHZE9Z2leJEZNGmX9IyDR
	 Z3dMCytAXFbWvVOncM5N1ljBlnAE0/uMn8CUO52U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbgDQR4r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:56:47 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:55834 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730033AbgDQR4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:56:47 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 03HHuV3a032110;
        Sat, 18 Apr 2020 02:56:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 03HHuV3a032110
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587146192;
        bh=+KVxFT2LECPIeuXt67hDt9x6uevhkyZbcYH2BBPJUh4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cYll3rWsp+Nxsn4tT3M2l1L84VMr6j9UcIKiUNHWS1JL57a5Anx7ckVzrm4b61qMc
         jbips5mzdrMLfJ9u69YJjGVbR6YftqVlYLwG2iL0oI3qr0MJXfYVQ3d3j5bCvpmsoc
         mBIQaCz4FwWVoxKV5EmOsYmdA4fnmINxGxoPc/p5eraqaXbwKoROIcUsx3LqbrLfu9
         nS8xIqydOZY3WLLcmQxLWjSI4X4x9Fln8FOgfNKh1GwfyyJ0Ns9zf6c0Gyiz/1lIhl
         4fdIYHkmMu9/Vd+ISXXFdJmBB2i/Q2h/UfCqQc2q7A2dV1cSqQn/g8VPDlvB81QxI1
         dCKg8hi1TghTA==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id j65so1696979vsd.12;
        Fri, 17 Apr 2020 10:56:31 -0700 (PDT)
X-Gm-Message-State: AGi0Pua9hVI5CSxSHy0sCVV9aEAt6vq7rC3a8nSLm2s8XmdWYTXDsM5x
        /Yt3Mhyii6KG9nlZPXcFGqMDHCbeD55ZVvygNM4=
X-Google-Smtp-Source: APiQypJGrOEpGgHOXO0cViNwYa4oBNBktwA4lv4BaEsvEyCLixLYiyAh1zomCFfSRqQQkTm1Tgx2/Khy+SMKUJa7Me4=
X-Received: by 2002:a67:e94d:: with SMTP id p13mr997304vso.215.1587146190636;
 Fri, 17 Apr 2020 10:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200417154246.2714-1-robh@kernel.org>
In-Reply-To: <20200417154246.2714-1-robh@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 18 Apr 2020 02:55:54 +0900
X-Gmail-Original-Message-ID: <CAK7LNASVSit9NL3YYRT0vyJwRE8A0J5njDO5LXTWecGo0S2dXg@mail.gmail.com>
Message-ID: <CAK7LNASVSit9NL3YYRT0vyJwRE8A0J5njDO5LXTWecGo0S2dXg@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: Add a minimum version check for dtschema
To:     Rob Herring <robh@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 12:42 AM Rob Herring <robh@kernel.org> wrote:
>
> The dtschema package must be somewhat up to date as the tools and
> meta-schema checks are still evolving. Implement a version check,
> so this can be enforced. This will help ensure new schema submissions
> get checked against the latest meta-schemas.
>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - Use a build rule for the version check instead
>
>  Documentation/devicetree/bindings/Makefile | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> index 1df680d07461..daf0dda45a78 100644
> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -3,11 +3,19 @@ DT_DOC_CHECKER ?= dt-doc-validate
>  DT_EXTRACT_EX ?= dt-extract-example
>  DT_MK_SCHEMA ?= dt-mk-schema
>
> +DT_SCHEMA_MIN_VERSION = 2020.04

Just a nit:

You can use 2020.4 if you want to be consistent
with the output from 'dt-doc-validate  --version'

This is not a big deal, though.
It is up to you.


$ dt-doc-validate  --version
2020.4



> +
> +PHONY += check_dtschema_version
> +check_dtschema_version:
> +       @printf "%s\n" $(DT_SCHEMA_MIN_VERSION) \
> +         $$($(DT_DOC_CHECKER) --version 2>/dev/null || echo 0) | sort -VC || \
> +         (echo "ERROR: dtschema minimum version is v$(DT_SCHEMA_MIN_VERSION)"; exit 1) 1>&2
> +


The  ( ... ) run the given command in a sub-shell.
{ ... } does not spawn a sub-shell, so it is a bit more
efficient if you do not have a good reason
to run it in a sub-shell.

I prefer 'false' instead of 'exit 1' because we do not
need to specify the exit code explicitly.
'false' is used in the top Makefile to stop the build.

I want to place the '1>&2' close to the error message,
and you can omit the redundant '1'.


How about this?


check_dtschema_version:
        @{ echo $(DT_SCHEMA_MIN_VERSION); \
        $(DT_DOC_CHECKER) --version 2>/dev/null || echo 0; } | sort -VC || \
        { echo "ERROR: dtschema minimum version is
v$(DT_SCHEMA_MIN_VERSION)" >&2; false; }




-- 
Best Regards
Masahiro Yamada

Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85DEC352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 02:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 784F4221F4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 02:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587092382;
	bh=9f76vsTI4MqslLl1oBh1nibBOhkfOyb39u3yAMi/djM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=q/f0Oujo/JBTy614qbykr2oWSWGwipxL4xBlu+JyZBpP8JsQJe88go8R4x9D3Cb46
	 uiLOyS88qCvVXN9kjmVIbctLAxWkWlo618QIiH/+e7S/wTjGYYnCQqGJp4Ew8RWDN7
	 HWCnGdrm0uG68ibw3EcKFD03pYXnRhi4/U5UXS6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729435AbgDQC7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 22:59:42 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:65340 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgDQC7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 22:59:41 -0400
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 03H2xGCM001052;
        Fri, 17 Apr 2020 11:59:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 03H2xGCM001052
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587092357;
        bh=KyvqBR7+SebaG4aWnNxI8TwLlMiPkUuznzOpaWP3ElE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iArepsPlYW6fwEQDzK41qhpzZIxtCI9Gomvwee4gdDF01fvlc5uVNJmAKYDRPzFMl
         eRDuem1jRW3/Pkm16HE0VcVYIOeFvwCdW6cbJsbsRMv27gGnaoOztxx8+HQwZxAeHP
         d4ud8UJf9DigB9yGa6lE/K+lG9E9N4z5ekPYcO6+fx4i4F4RxVc0Hk3PZCBfxjpjDZ
         jfiEZ5lDZ67/UAirjsyNN6jmirjLkfSN183Gb9WCODuOXsvSdiKIeqFVYyqbLJQdnG
         MknLKZ8LennVjEz1lPO8V3zEC32fAn3NOk4HHlZhYmDN0r6ZVsZg7XeM6hCqVbvTkx
         GZsVX6Xzmy6JA==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id y185so311007vsy.8;
        Thu, 16 Apr 2020 19:59:17 -0700 (PDT)
X-Gm-Message-State: AGi0PuY3KsAiJdL8LXAH/UHYSJy4ewNBIPc8fdseN8rgXDGoF1ieNJEQ
        wLoXXVoCTQqXRchc/L1HPywREa+5ZkI59+6jIJI=
X-Google-Smtp-Source: APiQypJx7KibXr8fY5Cx+oLiKjzxwOTwbjRJ+oH0Mzy7gunEPVz2/1RMo3P20evTOYZ12luvyM9jUPP0LVIg29GAon0=
X-Received: by 2002:a05:6102:2007:: with SMTP id p7mr590853vsr.181.1587092355909;
 Thu, 16 Apr 2020 19:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200416185420.20192-1-robh@kernel.org>
In-Reply-To: <20200416185420.20192-1-robh@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 17 Apr 2020 11:58:40 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQUcHCz-hChi5SKj+Ler-FaUscbkF1KSV+wTq0sC1QeHg@mail.gmail.com>
Message-ID: <CAK7LNAQUcHCz-hChi5SKj+Ler-FaUscbkF1KSV+wTq0sC1QeHg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Add a minimum version check for dtschema
To:     Rob Herring <robh@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 3:54 AM Rob Herring <robh@kernel.org> wrote:
>
> The dtschema package must be somewhat up to date as the tools and
> meta-schema checks are still evolving. Implement a version check,
> so this can be enforced. This will help ensure new schema submissions
> get checked against the latest meta-schemas.
>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---


You cannot check this in the parse stage.


Without the latest dt-schema tools,
you cannot do even 'make clean'. This is odd.

$ make clean
Documentation/devicetree/bindings/Makefile:13: *** dtschema minimum
version is v2020.04.  Stop.
make[1]: *** [scripts/Makefile.clean:66:
Documentation/devicetree/bindings] Error 2
make: *** [Makefile:1729: _clean_Documentation] Error 2




How about adding a phony target to check the version?





PHONY += check_dtschema_version
check_dtschema_version:
        ( Do something to check tool version)

quiet_cmd_chk_binding = CHKDT   $(patsubst $(srctree)/%,%,$<)
      cmd_chk_binding = $(DT_DOC_CHECKER) -u $(srctree)/$(src) $< ; \
                        $(DT_EXTRACT_EX) $< > $@

$(obj)/%.example.dts: $(src)/%.yaml check_dtschema_version FORCE
$(call if_changed,chk_binding)




>  Documentation/devicetree/bindings/Makefile | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/Makefile b/Documentation/devicetree/bindings/Makefile
> index 1df680d07461..9f2e64e29d79 100644
> --- a/Documentation/devicetree/bindings/Makefile
> +++ b/Documentation/devicetree/bindings/Makefile
> @@ -3,6 +3,16 @@ DT_DOC_CHECKER ?= dt-doc-validate
>  DT_EXTRACT_EX ?= dt-extract-example
>  DT_MK_SCHEMA ?= dt-mk-schema
>
> +DT_SCHEMA_MIN_VERSION = 2020.04
> +ifeq (1,$(shell \
> +       printf "%s\n" \
> +               $(DT_SCHEMA_MIN_VERSION) \
> +               $$($(DT_DOC_CHECKER) --version 2>/dev/null || echo 0) | sort -VC; \
> +               echo $$? \
> +       ))
> +$(error dtschema minimum version is v$(DT_SCHEMA_MIN_VERSION))
> +endif
> +
>  quiet_cmd_chk_binding = CHKDT   $(patsubst $(srctree)/%,%,$<)
>        cmd_chk_binding = $(DT_DOC_CHECKER) -u $(srctree)/$(src) $< ; \
>                          $(DT_EXTRACT_EX) $< > $@
> --
> 2.20.1
>


--
Best Regards
Masahiro Yamada

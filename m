Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78E1C35672
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 05:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6637B2467D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 05:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582348850;
	bh=DXbuJPNsogTXj3Xlgpu474tYpxCmg96iOck0OK1De+Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ljvSetzWsCECXAvzHZ95nRVPxc2wEnQiO3cl7jPO/2VVvHqk3iVPfbqCfcpmmLuT7
	 MYx0dXxbu7owNzM4+fGfNMw86rl/6nY3Z23Gp+8cxmeuxKPPKFnA9LyjR8duws/cUl
	 eRIbhYuOzL9Qvpux2c4dDVT/dm1UR+pqDqkay/OY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgBVFUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 00:20:49 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:36666 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgBVFUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 00:20:49 -0500
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 01M5KafQ024227;
        Sat, 22 Feb 2020 14:20:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 01M5KafQ024227
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582348837;
        bh=YKumM6nl7wDW7iBXi9YToiaP0C6K2ymg4jrBCpX08fE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0EoB32tRjcYyXjBskhEVHxvbQUuHzD9oUgSFQWaex7AW1gPRVL7YIs9NaI3sljXKg
         HTbmHsXsbiEgQjV9U3wxlN7Xu7EJTIIadkVRd1wyFJYvzVjnFkN8EwBRRRwef6hpPp
         lait7OkvHVGxupON+CusjwCHCKaF3A9ZIF5aKqICTafZVpI5Zm0u/fU8dorEO+R9SF
         fUPMntDoe0dCRGnn6Oz0VPvirFFrWeyd0ctnfmFAWcvWNBapCQTakHBDSM+pHn00wu
         mqTgPAEoeY72Q87eKu6J/3iWCobU+oGd4dSK9+Tlj80yYcsQdWk++/4KjmS6f04Bsz
         RkjpK0E2M2iOw==
X-Nifty-SrcIP: [209.85.221.171]
Received: by mail-vk1-f171.google.com with SMTP id g7so1176931vkl.12;
        Fri, 21 Feb 2020 21:20:37 -0800 (PST)
X-Gm-Message-State: APjAAAVbbPAiJJxuH38omZ5ezcmEagjuV6/aod1nOM8VsVODJtfhKs4k
        f/C8TOjcOpI0ysruXPiqssJ7T00OT+FC+8l4jpo=
X-Google-Smtp-Source: APXvYqxjngNGYOqQSFORfjCOAcW75hxKKdFrDL8gdS/YktQZrg2mNGMXCeQL1YMeVqq9jyAzI3zQoyABnxgxvjdJyvM=
X-Received: by 2002:a1f:bfc2:: with SMTP id p185mr19206254vkf.73.1582348835888;
 Fri, 21 Feb 2020 21:20:35 -0800 (PST)
MIME-Version: 1.0
References: <20200221021002.18795-1-yamada.masahiro@socionext.com> <20200221152546.GA1327@bogus>
In-Reply-To: <20200221152546.GA1327@bogus>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 22 Feb 2020 14:20:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQnJPOB7-e8GCjmXb4HpNdYqz0TsDvQ8_SJpcN9vsgeqA@mail.gmail.com>
Message-ID: <CAK7LNAQnJPOB7-e8GCjmXb4HpNdYqz0TsDvQ8_SJpcN9vsgeqA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: arm: Convert UniPhier board/SoC bindings
 to json-schema
To:     Rob Herring <robh@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Sat, Feb 22, 2020 at 12:25 AM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, 21 Feb 2020 11:10:00 +0900, Masahiro Yamada wrote:
> > Convert the Socionext UniPhier board/SoC binding to DT schema format.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  .../bindings/arm/socionext/uniphier.txt       | 47 -------------
> >  .../bindings/arm/socionext/uniphier.yaml      | 70 +++++++++++++++++++
> >  MAINTAINERS                                   |  2 +-
> >  3 files changed, 71 insertions(+), 48 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/socionext/uniphier.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/socionext/uniphier.yaml
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> Documentation/devicetree/bindings/display/simple-framebuffer.example.dts:21.16-37.11: Warning (chosen_node_is_root): /example-0/chosen: chosen node must be at root node
> Error: Documentation/devicetree/bindings/arm/socionext/uniphier.example.dts:18.9-10 syntax error
> FATAL ERROR: Unable to parse input tree
> scripts/Makefile.lib:300: recipe for target 'Documentation/devicetree/bindings/arm/socionext/uniphier.example.dt.yaml' failed
> make[1]: *** [Documentation/devicetree/bindings/arm/socionext/uniphier.example.dt.yaml] Error 1
> Makefile:1263: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
>
> See https://patchwork.ozlabs.org/patch/1241745
> Please check and re-submit.


I checked 'make dtbs_check',
but did not test 'make dt_binding_check'.

I remember that
'make dtbs_check' no longer check example.dts after
93512dad334deb444619505f1fbb761156f7471b



Anyway, the example is fold into the plugin node,
so I cannot avoid the schema error about $nodename.

/home/masahiro/workspace/linux-unph/Documentation/devicetree/bindings/arm/socionext/uniphier.example.dt.yaml:
example-0: $nodename:0: '/' was expected


I will remove this example.


--
Best Regards
Masahiro Yamada

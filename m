Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A35C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E408B20739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594917216;
	bh=8nYgVzn7R1JYwFxpemva8sGu7z58gW0yeup8lbFxVSU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZapWIWG9Jk/t0n6PJeFuwMfW9W1SG/4hO3Ay5jhDLyyjRCLDGpYydJINw19C9N75c
	 9Egqq6uAKpAURtC3MAt4GV0tcqjz4P8XWo3q2ZMn+IVCDsumDcNciw19YY98I7jmZo
	 w7XFy/eH7iyhv1i62Vaq42Zx70kjb+lhkMne6Y4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgGPQdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:33:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729048AbgGPQdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:33:35 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8DA7207E8;
        Thu, 16 Jul 2020 16:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594917214;
        bh=8nYgVzn7R1JYwFxpemva8sGu7z58gW0yeup8lbFxVSU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TkffGb9OVFGRbdFNvOa/f8E93aYPUaA/ILPzd0kFE1jO6kBxsGF8oveEy4iCqDzsS
         mne8At+4ZyFu9inRzBPFFK7wf8yW7ZHBR1FbIRnoKfpSGTkufY31BXGS4Vo5yKNjfv
         EfATpALj/PHP2N1e1hYH/mKSRwgYzoFzweJlpvws=
Received: by mail-ot1-f42.google.com with SMTP id 72so4698634otc.3;
        Thu, 16 Jul 2020 09:33:34 -0700 (PDT)
X-Gm-Message-State: AOAM532s8+bylLl52PD5DGHt6FbK4BLmNPoly9azsPsXZTvzgp1KFCpk
        0+V4wQ9YQo1sPFRh2Ialydvvja8s5yI4X+o0LQ==
X-Google-Smtp-Source: ABdhPJyPc0Kjv1vCFbvbIaKIccPgsAjfPdZ7RG9XG+Zqu0zWrm9pSYRPBnGy8Xj9QgkCxtd7tuOVqmTgASNFMWbm180=
X-Received: by 2002:a9d:2646:: with SMTP id a64mr4965237otb.107.1594917214014;
 Thu, 16 Jul 2020 09:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200715090342.28339-1-yifeng.zhao@rock-chips.com>
 <20200715090342.28339-2-yifeng.zhao@rock-chips.com> <20200715175356.GA502928@bogus>
 <2020071610022540759717@rock-chips.com>
In-Reply-To: <2020071610022540759717@rock-chips.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 16 Jul 2020 10:33:22 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+5pgsLNS5t=d2yzYukjXurr2B3pUdb_gejqwA7Tv-7mQ@mail.gmail.com>
Message-ID: <CAL_Jsq+5pgsLNS5t=d2yzYukjXurr2B3pUdb_gejqwA7Tv-7mQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFJlOiBbUEFUQ0ggdjcgMS84XSBkdC1iaW5kaW5nczogbXRkOiBEZXNjcmliZSBSbw==?=
        =?UTF-8?B?Y2tjaGlwIFJLM3h4eCBOQU5EIGZsYXNoIGNvbnRyb2xsZXLjgJDor7fms6jmhI/vvIzpgq7ku7bnlLFy?=
        =?UTF-8?B?b2JoZXJyaW5nMkBnbWFpbC5jb23ku6Plj5HjgJE=?=
To:     =?UTF-8?B?6LW15Luq5bOw?= <yifeng.zhao@rock-chips.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        vigneshr <vigneshr@ti.com>,
        =?UTF-8?Q?HeikoSt=C3=BCbner?= <heiko@sntech.de>,
        richard <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-rockchip <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 8:04 PM =E8=B5=B5=E4=BB=AA=E5=B3=B0 <yifeng.zhao@ro=
ck-chips.com> wrote:
>
> Hi Rob,
>
> >On Wed, 15 Jul 2020 17:03:39 +0800, Yifeng Zhao wrote:
> >> Documentation support for Rockchip RK3xxx NAND flash controllers
> >>
> >> Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> >> ---
> >>
> >> Changes in v7:
> >> - Fix some wrong define
> >>
> >> Changes in v6:
> >> - Fix some wrong define
> >> - Modified the definition of compatible
> >>
> >> Changes in v5:
> >> - Fix some wrong define.
> >> - Add boot-medium define.
> >> - Remove some compatible define.
> >>
> >> Changes in v4:
> >> - The compatible define with rkxx_nfc.
> >> - Add assigned-clocks.
> >> - Fix some wrong defineChanges in.
> >>
> >> Changes in v3:
> >> - Change the title for the dt-bindings.
> >>
> >> Changes in v2: None
> >>
> >>  .../mtd/rockchip,nand-controller.yaml         | 162 +++++++++++++++++=
+
> >>  1 file changed, 162 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/mtd/rockchip,nan=
d-controller.yaml
> >>
> >
> >
> >My bot found errors running 'make dt_binding_check' on your patch:
> >
> >/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mtd=
/rockchip,nand-controller.example.dt.yaml: example-0: nand-controller@ff4b0=
000:reg:0: [0, 4283105280, 0, 16384] is too long
> >
> >
> >See https://patchwork.ozlabs.org/patch/1329325
> >
> >If you already ran 'make dt_binding_check' and didn't see the above
> >error(s), then make sure dt-schema is up to date:
> >
> >pip3 install git+https://github.com/devicetree-org/dt-schema.git@master =
--upgrade
> >
> >Please check and re-submit.
>
> make ARCH=3Darm64 dt_binding_check DT_SCHEMA_FILES=3DDocumentation/device=
tree/bindings/mtd/rockchip,nand-controller.yaml
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/dtc/dtc.o
>   HOSTCC  scripts/dtc/flattree.o
>   HOSTCC  scripts/dtc/fstree.o
>   HOSTCC  scripts/dtc/data.o
>   HOSTCC  scripts/dtc/livetree.o
>   HOSTCC  scripts/dtc/treesource.o
>   HOSTCC  scripts/dtc/srcpos.o
>   HOSTCC  scripts/dtc/checks.o
>   HOSTCC  scripts/dtc/util.o
>   LEX     scripts/dtc/dtc-lexer.lex.c
>   YACC    scripts/dtc/dtc-parser.tab.[ch]
>   HOSTCC  scripts/dtc/dtc-lexer.lex.o
>   HOSTCC  scripts/dtc/dtc-parser.tab.o
>   HOSTCC  scripts/dtc/yamltree.o
>   HOSTLD  scripts/dtc/dtc
>   CHKDT   Documentation/devicetree/bindings/mtd/rockchip,nand-controller.=
yaml
>   SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.yam=
l
>   DTC     Documentation/devicetree/bindings/mtd/rockchip,nand-controller.=
example.dt.yaml
>   CHECK   Documentation/devicetree/bindings/mtd/rockchip,nand-controller.=
example.dt.yaml
> /home/yifeng/work/linux/Documentation/devicetree/bindings/mtd/rockchip,na=
nd-controller.example.dt.yaml: example-0: nand-controller@ff4b0000:reg:0: [=
0, 4283105280, 0, 16384] is too long
>
> I already ran the "make dt_binding_check" before submit this patch and fo=
und this issue.
> The dts examples is for RK3308, ARCH=3Darm64, and the reg define is corre=
ct.
> I thought there was something wrong with the check=EF=BC=8C or something =
configuration I missed.
> Please give me some suggestions.
>
>
> diff --git a/Documentation/devicetree/bindings/mtd/rockchip,nand-controll=
er.yaml b/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.ya=
ml
> index 493705a55638..b9d7a8c79402 100644
> --- a/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
> +++ b/Documentation/devicetree/bindings/mtd/rockchip,nand-controller.yaml
> @@ -132,7 +132,7 @@ examples:
>      nfc: nand-controller@ff4b0000 {
>        compatible =3D "rockchip,rk3308-nfc",
>                     "rockchip,rv1108-nfc";
> -      reg =3D <0x0 0xff4b0000 0x0 0x4000>;
> +      reg =3D <0xff4b0000 0x4000>;

This is the right fix. Or you can define a parent node with cell sizes of 2=
.

The example is just an example and doesn't have to match exactly what
you do in the dts files.

>        interrupts =3D <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
>        clocks =3D <&cru HCLK_NANDC>, <&cru SCLK_NANDC>;
>        clock-names =3D "ahb", "nfc";

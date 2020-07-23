Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646FFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 422692086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgGWKLP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 06:11:15 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:51939 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgGWKLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:11:14 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MhCq4-1kU3Fl1Ht4-00eO2b; Thu, 23 Jul 2020 12:11:11 +0200
Received: by mail-qk1-f177.google.com with SMTP id 2so679556qkf.10;
        Thu, 23 Jul 2020 03:11:11 -0700 (PDT)
X-Gm-Message-State: AOAM532kyoMDnZ1Ms2H/OnY+vQT6odNHvrXVNraM4kcJDrpSBKNQCxER
        Fw63q/vOgq17zw7YKvnEzyVoxp0VCh8t98fGEmc=
X-Google-Smtp-Source: ABdhPJyRBZh+Jnh8z1ps+hnBPrP8rDjvPm7uyIy6hqZTMrzSNVY+O9ozgvN2kAt4bsn8pb7YiQI/Bo1v4oLc+w7G1AU=
X-Received: by 2002:a37:9004:: with SMTP id s4mr4252271qkd.286.1595499070036;
 Thu, 23 Jul 2020 03:11:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200324104918.29578-1-hhhawa@amazon.com> <158946977180.3480.12435085393834819053@kwain>
In-Reply-To: <158946977180.3480.12435085393834819053@kwain>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 23 Jul 2020 12:10:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3ndL0U=Q1HAxd3oTPfO6WwQZM3yQvr-TQEnA3ZzhQNYQ@mail.gmail.com>
Message-ID: <CAK8P3a3ndL0U=Q1HAxd3oTPfO6WwQZM3yQvr-TQEnA3ZzhQNYQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Amazon's Annapurna Labs Alpine v3 device-tree
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     hhhawa@amazon.com, Rob Herring <robh+dt@kernel.org>,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        arm-soc <arm@kernel.org>, DTML <devicetree@vger.kernel.org>,
        benh@amazon.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        hanochu@amazon.com, David Woodhouse <dwmw@amazon.co.uk>,
        jonnyc@amazon.com, ronenk@amazon.com,
        Talel Shenhar <talel@amazon.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:jmjQgQgR1kfpNwBKzXOjGaIt7P5xvz6Uq0aaEtr6Bf0DQwMhboH
 gXvM0j2x2oNNS/2AqBL9uYf+rCm5jTNSMgZ0HP/44QEYWM2VnAm6Fvfx5l6efZG7lw38mpk
 VLyhuXbvtJrY5AREcqJ6a8S3klnUqqW9nOAjogIg7mtsjijXlBzxovIvo7BhHhTmxmNa5sG
 YdiMlfm4MZThljCdWRdQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s1PXoWdnRAk=:1CwqWG6FjcV4SYaJHsv8DX
 mWq6MT1kJsQOC0o+Pn1DURac20De7ds0woW817skooUFIAcN1O8MFgGhbJyzpnyBAg2Y4/bY3
 +hXP7QqSkzw+pGIgSjkC2/R3k4RyfOOrp2CeaM9ttY2YFUJUncgn/p9MBUiIdzqbuKzQYh6U6
 dfLPY1phW5GOKrTfA3cZa8yjfnmUFCeMZThDp1ZoCliN9q5AJbc/LLnP69ytRzK1lW4fmUNjn
 hdFtKdAZguz5jiVBB1L0ekeRhXPUenSTGYDuqBdDwe8nTkSOw16PtMloeRl9pIFRnreO4yBgx
 3j2iAuN81P7WAXqG9bHeESeBm0RPZHA7jOkVigMlm3pmy+otRvlIUZpn8onRBJ5095eHinzVW
 63bWS20pdLmStDngxKnsSaOdLeM3EW4x/AA9nves2PqlVx+Z6HhpxPG0/oTGd/NRSDUSODcGg
 O7mITucxlPUdRCWFUx65u95JFCHbb1NJNNYk9VJzTOomK0MXbh9yzzSqjaTkd3fKR7Y00or42
 S3R+pWk3X8203g0Wc3p2KF94cLGoGgsYG/keF/MX7w+x9/PAOPgf5bDD3r6P/fwT40AJmLhe7
 +y1tkzDiy8uVAtJODG5VDGQvxnIij0dSxbTZo4WTmcPYyNBPuO7EF/k+ObwyQ328s6lkScMCM
 jkNrsJ/xang/9aESMPk7SZrCGnqD/00e+37z/ojP6UEneTbNf++aWPVU3c0WIpzUCL77e9e/r
 DwtaOYNFswgbmGAmPblV/fPbmiMNRuX3QyoiaoqBq5tOSxOQMb9MDrh54F7uiK7bPTnvRBRvM
 HB2/hP5E8CwsUiD0uyQCBOjeegIG59Q6lg8vn011Ch5SARMGLxkvnXvmR7qDb5ulpdrtpi1Oc
 rkv5bBUL0Uax3j4ZIMsK1EB1qE0TbsImGWWct6bNUbNNAjEklAVwL/ElQsRRF65S64XrR0nSt
 cn4tyXBbrvA+mY8/mBosOhWsigjQqsNaf5UGmcCyugTbf4EmfXCPC
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 5:22 PM Antoine Tenart
<antoine.tenart@bootlin.com> wrote:
>
> [Adding arm-soc]
>
> Hi Hanna,
>
> Sorry for the delay, the series was buried in my mails...
>
> Acked-by: Antoine Tenart <antoine.tenart@bootlin.com>
>
> Arnd, Olof, could you take this series directly as this will be the only
> Alpine patches for this release (and for a long time)?

Hi Hanna and Antoine,

I just came across this old series and noticed we had never merged it.

I don't know if the patches all still apply. Could you check and perhaps
resend to soc@kernel.org if they are still good to go into the coming
merge window?

> Quoting Hanna Hawa (2020-03-24 11:49:12)
> > This series organize the Amazon's Annapurna Labs Alpine device tree
> > bindings, device tree folder and adds new device tree for Alpine v3.
> >
> > Changes since v4:
> > -----------------
> > - Re-order nodes in increasing order.
> > - Add disable to UART nodes.
> > - Add missing UART nodes (1,2,3)
> > - Add comments for GIC/UART
> > - Add io-fabric bus, and move uart nodes into it.
> > - Fix MSIx range according Alpine function spec
> >
> > Changes since v3:
> > -----------------
> > - rebased and retested for tag Linux 5.6-rc2
> >
> > Changes since v2:
> > -----------------
> > - Move up a level for DT node without mmio regs.
> > - Drop device_type from serial@fd883000 node.
> > - Minor change name of PCIe node to: pcie@fbd00000
> >
> > Changes since v1:
> > -----------------
> > - Rename al,alpine DT binding to amazon,alpine
> > - Rename al folder to be amazon
> > - Update maintainers of amazon,alpine DT
> > - Add missing alpine-v2 DT binding
> > - Fix yaml schemas for alpine-v3-evp.dts:
> >         - #size-cells:0:0: 0 is not one of [1, 2]
> >         - arch-timer: interrupts: [[1, 13, 8, 1, 14, 8, 1, 11, 8, 1, 10,
> >         8]] is too short
> > - Change compatible string of alpine-v3-evp to amazon,al
> >
> > Hanna Hawa (5):
> >   dt-bindings: arm: amazon: rename al,alpine DT binding to amazon,al
> >   arm64: dts: amazon: rename al folder to be amazon
> >   dt-bindings: arm: amazon: update maintainers of amazon,al DT bindings
> >   dt-bindings: arm: amazon: add missing alpine-v2 DT binding
> >   dt-bindings: arm: amazon: add Amazon Annapurna Labs Alpine V3
> >
> > Ronen Krupnik (1):
> >   arm64: dts: amazon: add Amazon's Annapurna Labs Alpine v3 support
> >
> >  .../devicetree/bindings/arm/al,alpine.yaml    |  21 -
> >  .../devicetree/bindings/arm/amazon,al.yaml    |  33 ++
> >  MAINTAINERS                                   |   2 +-
> >  arch/arm64/boot/dts/Makefile                  |   2 +-
> >  arch/arm64/boot/dts/{al => amazon}/Makefile   |   1 +
> >  .../boot/dts/{al => amazon}/alpine-v2-evp.dts |   0
> >  .../boot/dts/{al => amazon}/alpine-v2.dtsi    |   0
> >  arch/arm64/boot/dts/amazon/alpine-v3-evp.dts  |  24 ++
> >  arch/arm64/boot/dts/amazon/alpine-v3.dtsi     | 408 ++++++++++++++++++
> >  9 files changed, 468 insertions(+), 23 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/al,alpine.yaml
> >  create mode 100644 Documentation/devicetree/bindings/arm/amazon,al.yaml
> >  rename arch/arm64/boot/dts/{al => amazon}/Makefile (64%)
> >  rename arch/arm64/boot/dts/{al => amazon}/alpine-v2-evp.dts (100%)
> >  rename arch/arm64/boot/dts/{al => amazon}/alpine-v2.dtsi (100%)
> >  create mode 100644 arch/arm64/boot/dts/amazon/alpine-v3-evp.dts
> >  create mode 100644 arch/arm64/boot/dts/amazon/alpine-v3.dtsi
> >
> > --
> > 2.17.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> --
> Antoine Ténart, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

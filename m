Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F20F6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D261D20708
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589987426;
	bh=dQU57BxmhphksLlQDSxz/CPGf9TeYRM+MwKSBYrsMLs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=L1X4p6kac+i9jbHuEHm8TacZ+9+DW90s7OjsyVOw2yOsuj2TxuqEHsvZFAaXiNU5k
	 XMha2uqQJYrK8dGI9YM8gU3P6++EMsM1rgqN38sJQYW9sXW1rUzu4h1mxd/86ITSWJ
	 5r/yIkVBVO0kKTTCGZu1YfcNd0e1Gul6ogB7kKD0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgETPK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 11:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:49036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgETPK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:10:26 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2148F20708;
        Wed, 20 May 2020 15:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589987425;
        bh=dQU57BxmhphksLlQDSxz/CPGf9TeYRM+MwKSBYrsMLs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HKQA244c/cJ3tTBDELpqOka6VQ+WSSjxnHqvneKVEyq8JjQtnwxObuVeaXrTe/xB0
         PcDErbl2brLj467vWnmfoU3NkfiJ2uLYGDMB70HDJNGrcvgfn/VwsfvrzppyspPHNs
         JrJGQHfOi9mh4aO8y7H8Hxhlwri17InF4m2PBI3g=
Received: by mail-oi1-f172.google.com with SMTP id y85so3177757oie.11;
        Wed, 20 May 2020 08:10:25 -0700 (PDT)
X-Gm-Message-State: AOAM530we9ErfyaRUk/PJg4s4Qhsn5KzVrkRSvUjV8xvtJf/lmhXYkZe
        MSc0TPxixMYRJi3wPFYpESy5wfCwFb/Lh5WSMA==
X-Google-Smtp-Source: ABdhPJyf6boU8Fyzg95Dr358/HVnQy+kouGJS4kXQJH0q3p9/ibpZTSeA/K0z0s5wVbQAmATPdKRzm0Ul/4Eig3x3j8=
X-Received: by 2002:a05:6808:24f:: with SMTP id m15mr3593664oie.152.1589987424398;
 Wed, 20 May 2020 08:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200512073115.14177-1-qiangqing.zhang@nxp.com>
 <20200512073115.14177-2-qiangqing.zhang@nxp.com> <20200519185125.GB453195@bogus>
 <DB8PR04MB6795A3C57F2B02632D591183E6B60@DB8PR04MB6795.eurprd04.prod.outlook.com>
In-Reply-To: <DB8PR04MB6795A3C57F2B02632D591183E6B60@DB8PR04MB6795.eurprd04.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 20 May 2020 09:10:12 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJU7JjFXSU8m5hyMyXd7L8F33_wHc+tETWXj9NBt9NV8g@mail.gmail.com>
Message-ID: <CAL_JsqJU7JjFXSU8m5hyMyXd7L8F33_wHc+tETWXj9NBt9NV8g@mail.gmail.com>
Subject: Re: [PATCH V1 RESEND 1/3] perf/imx_ddr: Add system PMU identifier for userspace
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     "john.garry@huawei.com" <john.garry@huawei.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 8:56 PM Joakim Zhang <qiangqing.zhang@nxp.com> wrot=
e:
>
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: 2020=E5=B9=B45=E6=9C=8820=E6=97=A5 2:51
> > To: Joakim Zhang <qiangqing.zhang@nxp.com>
> > Cc: john.garry@huawei.com; will@kernel.org; mark.rutland@arm.com;
> > shawnguo@kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> > linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH V1 RESEND 1/3] perf/imx_ddr: Add system PMU identif=
ier
> > for userspace
> >
> > On Tue, May 12, 2020 at 03:31:13PM +0800, Joakim Zhang wrote:
> > > The DDR Perf for i.MX8 is a system PMU whose axi id would different
> > > from SoC to SoC. Need expose system PMU identifier for userspace whic=
h
> > > refer to /sys/bus/event_source/devices/<PMU DEVICE>/identifier.
> >
> > Why not just expose the AXI ID if that's what's different?
>
> Hi Rob,
>
> Each master has their own AXI ID, such as USB, GPU, VPU etc, it is variou=
s from different SoCs. We want to add system PMU support in perf tool, so w=
e want to expose something from perf driver to identify each SoC.
> When we know which SoC it is, we can get each master AXI ID. If this patc=
h can be accepted, /sys/bus/event_source/devices/<PMU DEVICE>/identifier co=
uld be a common interface for all system PMUs.
>
> I will change to add a property to identify SoC, to see if it is better. =
Thanks.

Isn't that what you have already with this patch? My point is you can
already read /proc/device-tree/compatible, read the PMU compatible, or
have an SoC device which exposes SoC info.

Rob

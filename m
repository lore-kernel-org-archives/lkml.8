Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE6AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966BC21835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PcgrxDxX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgAVQtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:49:25 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44588 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgAVQtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:49:25 -0500
Received: by mail-lf1-f67.google.com with SMTP id v201so102928lfa.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 08:49:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aE9tvRHsNGw+QePOFcIWewZ+atRLpc2aXzwNWF24kPY=;
        b=PcgrxDxXDYKvoiByUVx2zZR+94AGBX9I70hgBN2coxBacYj/mNkQlhgRcjd0KpJl5K
         N1WdO4jEBHzTBZ6KZW3/sCzM4lqlzQp2yy7f3FDe+WfnJz3cSUwWZ/bmWUX7Pp50QNT5
         bJCSfTBun4GodFlYaNKron5tfiSuZ3RE/ojD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aE9tvRHsNGw+QePOFcIWewZ+atRLpc2aXzwNWF24kPY=;
        b=bWSe1N7smLYzVnRilQqAtIuMgrvW28CVMs1R/QdbA2RWokUaM3JgWl5t77QNmx3nSk
         c/PQr3acDEb3ZaZwB85HjlcLHHCdUGL5jTQNlTWiYxhjeSzlLvUrBA//KiOjAk424PmV
         S6cnuizQR152Qd1PksMG3SR3s/OoD5jKp5c9DlNfFCAdoqO4URkq6Xxajh8FqNu9DbFI
         9PsMR/czd7qyB45Z7GWp50oKNNGw07UBkLwJjaNMyGJ7nO79s4dSXRTNuowZwITcfA9u
         xOkILgVPRBGhwFENhxUGmVy+K2zNPwbsw2XNfSnwUNeXvPxpZ3H7xyyHJpIXqe7EIDJE
         KG5g==
X-Gm-Message-State: APjAAAUTwxLGZvAEhAHBZ7qCiSFxcWxcfpC5ddBn1joBCQEw3pDlYah7
        bdRNNsxFF3s9pZg0kNuAGJIxXfcqP/k=
X-Google-Smtp-Source: APXvYqxm1AgYiGJ9tS5djipA+huVAtn1FnfZKnv3fe6tm98ccQ8zDk8vzmnHfiu+A3FTqPbk290gxA==
X-Received: by 2002:a19:e011:: with SMTP id x17mr2369509lfg.59.1579711762189;
        Wed, 22 Jan 2020 08:49:22 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id q13sm24447887ljj.63.2020.01.22.08.49.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 08:49:21 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id n18so2646578ljo.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 08:49:20 -0800 (PST)
X-Received: by 2002:a2e:b054:: with SMTP id d20mr19683516ljl.190.1579711760442;
 Wed, 22 Jan 2020 08:49:20 -0800 (PST)
MIME-Version: 1.0
References: <20200109211215.18930-1-sibis@codeaurora.org> <20200109211215.18930-3-sibis@codeaurora.org>
 <CAE=gft7ZUTiGrvsaqfrVv-bH3w75as7G1UJRn3aJs3ECqodpQg@mail.gmail.com>
 <dad8936ba4444c3377d777cbbb879dc3@codeaurora.org> <03f83755-bdcc-dc39-0eae-08414751be57@linaro.org>
In-Reply-To: <03f83755-bdcc-dc39-0eae-08414751be57@linaro.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 22 Jan 2020 08:48:43 -0800
X-Gmail-Original-Message-ID: <CAE=gft6NMD7+Bt0ab8tnb8r2DjPkb2si7+0-R+f=SYk2YMCX0A@mail.gmail.com>
Message-ID: <CAE=gft6NMD7+Bt0ab8tnb8r2DjPkb2si7+0-R+f=SYk2YMCX0A@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] interconnect: qcom: Add OSM L3 interconnect
 provider support
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Dai <daidavid1@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 12:20 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> On 1/22/20 08:45, Sibi Sankar wrote:
> > Hey Evan,
> >
> > Thanks for the review!
> >
> > On 2020-01-22 03:03, Evan Green wrote:
> >> On Thu, Jan 9, 2020 at 1:12 PM Sibi Sankar <sibis@codeaurora.org> wrote:
> >>>
> >>> On some Qualcomm SoCs, Operating State Manager (OSM) controls the
> >>> resources of scaling L3 caches. Add a driver to handle bandwidth
> >>> requests to OSM L3 from CPU on SDM845 SoCs.
> >>>
> >>> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> >>> ---
> >>>  drivers/interconnect/qcom/Kconfig  |   7 +
> >>>  drivers/interconnect/qcom/Makefile |   2 +
> >>>  drivers/interconnect/qcom/osm-l3.c | 267 +++++++++++++++++++++++++++++
> >>>  3 files changed, 276 insertions(+)
> >>>  create mode 100644 drivers/interconnect/qcom/osm-l3.c
> >>>
> >>> diff --git a/drivers/interconnect/qcom/Kconfig
> >>> b/drivers/interconnect/qcom/Kconfig
> >>> index a9bbbdf7400f9..b94d28e7bf700 100644
> >>> --- a/drivers/interconnect/qcom/Kconfig
> >>> +++ b/drivers/interconnect/qcom/Kconfig
> >>> @@ -14,6 +14,13 @@ config INTERCONNECT_QCOM_MSM8974
> >>>          This is a driver for the Qualcomm Network-on-Chip on msm8974-based
> >>>          platforms.
> >>>
> >>> +config INTERCONNECT_QCOM_OSM_L3
> >>> +       tristate "Qualcomm OSM L3 interconnect driver"
> >>> +       depends on INTERCONNECT_QCOM || COMPILE_TEST
> >>> +       help
> >>> +         Say y here to support the Operating State Manager (OSM) interconnect
> >>> +         driver which controls the scaling of L3 caches on Qualcomm SoCs.
> >>> +
> >>>  config INTERCONNECT_QCOM_QCS404
> >>>         tristate "Qualcomm QCS404 interconnect driver"
> >>>         depends on INTERCONNECT_QCOM
> >>> diff --git a/drivers/interconnect/qcom/Makefile
> >>> b/drivers/interconnect/qcom/Makefile
> >>> index 55ec3c5c89dbd..89fecbd1257c7 100644
> >>> --- a/drivers/interconnect/qcom/Makefile
> >>> +++ b/drivers/interconnect/qcom/Makefile
> >>> @@ -1,5 +1,6 @@
> >>>  # SPDX-License-Identifier: GPL-2.0
> >>>
> >>> +icc-osm-l3-objs                                := osm-l3.o
> >>>  qnoc-msm8974-objs                      := msm8974.o
> >>>  qnoc-qcs404-objs                       := qcs404.o
> >>>  qnoc-sc7180-objs                       := sc7180.o
> >>> @@ -12,6 +13,7 @@ icc-smd-rpm-objs                      := smd-rpm.o
> >>>  obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) += icc-bcm-voter.o
> >>>  obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) += qnoc-msm8916.o
> >>>  obj-$(CONFIG_INTERCONNECT_QCOM_MSM8974) += qnoc-msm8974.o
> >>> +obj-$(CONFIG_INTERCONNECT_QCOM_OSM_L3) += icc-osm-l3.o
> >>>  obj-$(CONFIG_INTERCONNECT_QCOM_QCS404) += qnoc-qcs404.o
> >>>  obj-$(CONFIG_INTERCONNECT_QCOM_RPMH) += icc-rpmh.o
> >>>  obj-$(CONFIG_INTERCONNECT_QCOM_SC7180) += qnoc-sc7180.o
> >>> diff --git a/drivers/interconnect/qcom/osm-l3.c
> >>> b/drivers/interconnect/qcom/osm-l3.c
> >>> new file mode 100644
> >>> index 0000000000000..7fde53c70081e
> >>> --- /dev/null
> >>> +++ b/drivers/interconnect/qcom/osm-l3.c
> >>> @@ -0,0 +1,267 @@
> >>> +// SPDX-License-Identifier: GPL-2.0
> >>> +/*
> >>> + * Copyright (c) 2019, The Linux Foundation. All rights reserved.
> >>> + *
> >>> + */
> >>> +
> >>> +#include <dt-bindings/interconnect/qcom,osm-l3.h>
> >>> +#include <linux/bitfield.h>
> >>> +#include <linux/clk.h>
> >>> +#include <linux/interconnect-provider.h>
> >>> +#include <linux/io.h>
> >>> +#include <linux/kernel.h>
> >>> +#include <linux/module.h>
> >>> +#include <linux/of_device.h>
> >>> +#include <linux/of_platform.h>
> >>> +#include <linux/platform_device.h>
> >>> +
> >>> +#define LUT_MAX_ENTRIES                        40U
> >>> +#define LUT_SRC                                GENMASK(31, 30)
> >>> +#define LUT_L_VAL                      GENMASK(7, 0)
> >>> +#define LUT_ROW_SIZE                   32
> >>> +#define CLK_HW_DIV                     2
> >>> +
> >>> +/* Register offsets */
> >>> +#define REG_ENABLE                     0x0
> >>> +#define REG_FREQ_LUT                   0x110
> >>> +#define REG_PERF_STATE                 0x920
> >>> +
> >>> +#define OSM_L3_MAX_LINKS               1
> >>> +#define SDM845_MAX_RSC_NODES           130
> >>
> >> I'm nervous this define is going to fall out of date with
> >> qcom,sdm845.h. I'm worried someone will end up adding a few more nodes
> >> that were always there but previously hidden from Linux. Can we put
> >> this define in include/dt-bindings/interconnect/qcom,sdm845.h, so at
> >> least when that happens they'll come face to face with this define?
> >> The same comment goes for the SC7180 define in patch 4.
> >
> > Yeah both solution require manual
> > intervention how about we just go
> > with what I proposed below.
> >
> >>
> >> On second thought, this trick only works once. Are we sure there
> >> aren't going to be other drivers that might want to tag on
> >> interconnect nodes as well? How about instead we just add the enum
> >> values below in qcom,sdm845.h as defines?
> >
> > Georgi/Evan,
> > Since qcom,sdm845.h is specific to
> > bindings shouldn't I just create a
> > .h file with all the enums so that
> > it can used across all icc providers
> > on SDM845?
>
> This sounds good to me, unless Evan has any objections.

So is this a new .h file with all the node numbers from qcom,sdm845.h
and your new couple of nodes here? That would be fine with me.

Or is it a .h file with only your two new node numbers? My worry there
is when there are two or three other drivers like this one, it will be
difficult to follow the total order of nodes as "base provider', "L3
driver", "new driver 1", "new driver 2".... any thoughts on how we
might address that?
-Evan

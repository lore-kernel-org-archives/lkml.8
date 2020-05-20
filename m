Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C9CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A18B5206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589988241;
	bh=7wy/mzhmsxhrZOkUPW+Q83t2ryAQte3LPn1zb7E6KSs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bJjity80rgdhxc9Hi3Xk66Ks1sXjftfvYT7RdrSmcEsUq5WnyvKAMIxz35t0kMCSN
	 trthoZzeaFGDbH4oSp9h/NSTKulOn2g4oq/WyBvOwwRhsO3V3kBN9vjG9AmsiVfF+p
	 boIY5CaJ9DM+116ZpAkYxn2IeS+lHrqcmrr6AvdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgETPYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 11:24:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbgETPXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:23:54 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 313A62072C;
        Wed, 20 May 2020 15:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589988234;
        bh=7wy/mzhmsxhrZOkUPW+Q83t2ryAQte3LPn1zb7E6KSs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZHYnAgMI7PZ4+geTufcIKRIYu1aGFliDnWFIqieVb7ktqvP33yfjeA6ZijQJ+2Z2t
         fMYOVGmazaAg0f5uRc4b6ptsRCtXBXHoRNBGLnojOriBvwAnqMNoG4655kl1OX3B3A
         uHOzBgWaHpnHR4ARCvfPSbMcyPRjP4VRfJMz71T0=
Received: by mail-ot1-f53.google.com with SMTP id v17so2803927ote.0;
        Wed, 20 May 2020 08:23:54 -0700 (PDT)
X-Gm-Message-State: AOAM530MAjO6maIktxYWScd7XCMNoYmU8mDsuuJSWxJ7/iDpNlYwRIzp
        JFrAIuq/m+ZyZW2wv7pRVKkwXnTc1894c56PJQ==
X-Google-Smtp-Source: ABdhPJxCSCVhZ52I7f5Mgyr0p3dZzcPmtENYVoGA47tZ3xVBr8Qbn/tvizgFDJa4B/xU3JfWxOsateh74q2peWJNOEA=
X-Received: by 2002:a05:6830:18d9:: with SMTP id v25mr3328433ote.107.1589988233456;
 Wed, 20 May 2020 08:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200512073115.14177-1-qiangqing.zhang@nxp.com>
 <20200512073115.14177-2-qiangqing.zhang@nxp.com> <20200519185125.GB453195@bogus>
 <20200520073304.GA23534@willie-the-truck>
In-Reply-To: <20200520073304.GA23534@willie-the-truck>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 20 May 2020 09:23:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJfQ0PFy5mmwSG4aM91ghq5xiAEPR2YZOymws+BfGa+uA@mail.gmail.com>
Message-ID: <CAL_JsqJfQ0PFy5mmwSG4aM91ghq5xiAEPR2YZOymws+BfGa+uA@mail.gmail.com>
Subject: Re: [PATCH V1 RESEND 1/3] perf/imx_ddr: Add system PMU identifier for userspace
To:     Will Deacon <will@kernel.org>
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        John Garry <john.garry@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 1:33 AM Will Deacon <will@kernel.org> wrote:
>
> On Tue, May 19, 2020 at 12:51:25PM -0600, Rob Herring wrote:
> > On Tue, May 12, 2020 at 03:31:13PM +0800, Joakim Zhang wrote:
> > > +static ssize_t ddr_perf_identifier_show(struct device *dev,
> > > +                                   struct device_attribute *attr,
> > > +                                   char *page)
> > > +{
> > > +   struct ddr_pmu *pmu = dev_get_drvdata(dev);
> > > +
> > > +   return sprintf(page, "%s\n", pmu->devtype_data->identifier);
> >
> > Why do we need yet another way to identify the SoC from userspace?
>
> I also really dislike this. What's the preferred way to identify the SoC
> from userspace?

/proc/cpuinfo? ;)

For an non-firmware specific case, I'd say soc_device should be. I'd
guess ACPI systems don't use it and for them it's dmidecode typically.
The other problem I have with soc_device is it is optional.

> It's needed so that the perf userspace tool can describe
> perf events that are supported for the PMU, as this isn't probe-able
> directly from the hardware. We have the same issue with the SMMUv3 PMCG [1],
> and so we need to solve the problem for both DT and ACPI.
>
> Will
>
> [1] https://lore.kernel.org/r/1587120634-19666-1-git-send-email-john.garry@huawei.com

At a minimum, it seems like 'identifier' should be moved into the perf
core if that's an attr we want to keep.

Rob

Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B7AC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D952922CA1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597911822;
	bh=fwGVCmgPxQ4tMxOoVebfaKdoWjHkC+p6W4oBmOn2pCQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=e3n8Id6G4i7JPdWgXC108TNDJyj4cf26pZxmBQuEZ0BsW0rwKlGBu9xpZwaHJPgWg
	 whrcIh8ZoDawWypiHMKH9EcuDhGY7XmEM8D3kuQYS7DKCZMqbR2iHSEntqEuQ2zCqJ
	 GOSJFH8ocs65i6vh2dNgV66/tQ9I1Wkt2/lgzQkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgHTIXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:23:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbgHTIXi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:23:38 -0400
Received: from coco.lan (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8686E22BED;
        Thu, 20 Aug 2020 08:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597911818;
        bh=fwGVCmgPxQ4tMxOoVebfaKdoWjHkC+p6W4oBmOn2pCQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=k0Qrqpn40gEcXyvKnJpr0UKl58JLXD6w6wg75Lq2H21jh3VFgBAOCOS+kekx5tu9V
         jsUl78z48aIZGiHBdWd1mOYDpQBTELDITS0xBdrtmERRoFb9QzRIeW0N/YpsPE8jit
         7HQ7sD1Dxlw1XtG5XGuAiZ1QVR+DwoViOpFp6a28=
Date:   Thu, 20 Aug 2020 10:23:32 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Manivannan Sadhasivam <mani@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Xiubin Zhang <zhangxiubin1@huawei.com>,
        Liwei Cai <cailiwei@hisilicon.com>,
        Chen Feng <puck.chen@hisilicon.com>,
        driverdevel <devel@driverdev.osuosl.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 25/49] staging: hikey9xx/gpu: do some code cleanups
Message-ID: <20200820102332.7223d38d@coco.lan>
In-Reply-To: <CALAqxLV-LaMPKD-ddRM1EehFh+JZfh1eUsKobXgVG9R+q0EF2w@mail.gmail.com>
References: <cover.1597833138.git.mchehab+huawei@kernel.org>
        <9fa944021373ec5b82c2c1e118c15d9effe7f964.1597833138.git.mchehab+huawei@kernel.org>
        <CALAqxLV-LaMPKD-ddRM1EehFh+JZfh1eUsKobXgVG9R+q0EF2w@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(added c/c Rob Herring)

Em Wed, 19 Aug 2020 18:53:06 -0700
John Stultz <john.stultz@linaro.org> escreveu:

> On Wed, Aug 19, 2020 at 4:46 AM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> > @@ -376,7 +355,7 @@ static int kirin_drm_platform_resume(struct platform_device *pdev)
> >  }
> >
> >  static const struct of_device_id kirin_drm_dt_ids[] = {
> > -       { .compatible = "hisilicon,hi3660-dpe",
> > +       { .compatible = "hisilicon,kirin960-dpe",  
> 
> 
> One issue, elsewhere in your patch stack you still refer to the
> hisilicon,hi3660-dpe compatible string. This should probably be
> consistent one way or the other.

Agreed with regards to consistency.

It sounds to me that calling those as Kirin 9xx (and the previous one
as Kirin 620) is better than using the part number.

Here, googling for "Kirin 970" gave about 6.9 million hits, while "Hi3670"
gave only 75,5K hits.

Kirin 620 has similar results: 6.85 million hits, against 61,9 hits
for "Hi3620".

With "Kirin 960", the numbers are a lot higher: had 21,4 million hits,
against 423K hits for "Hi3660".

So, my preference is to use "Kirin 620, 960 and 970" for future changes.

-

Currently, there are already some inconsistency, as some places
use the part number where others use "Kirin xxx" designation,
when referring to Kirin 620, 960 and 970.

I would love to make this consistent among the Kernel. However,
I'm not sure if changing "compatible" would be acceptable
by DT maintainers.

If something like that would be OK, I can prepare a separate
patchset to be applied at the Kernel.

Thanks,
Mauro

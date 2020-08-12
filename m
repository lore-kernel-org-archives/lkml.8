Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B853C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 18:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D16DF20866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 18:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597258792;
	bh=/wdga4UNSKTHfzzgL8b+sTrJQhQuvj60dfRwTV4au+I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=pLZM0xAQwrdm9O/FRbU9HC0g7zJABac0U6npU26RVv3MRirRGOWyI+PuQVo3WIvNz
	 6aRBHVMEDnWov08MK7SGnc1CXTYvkrQBkq5BhXjgGkVNwtkuvRX2x9mDyji/q4b7t7
	 tc3t8U1czrXMNqGPDQvwrHOTyD6aMWbeI/Ok9jv4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbgHLS7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 14:59:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60370 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgHLS7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 14:59:51 -0400
Received: from onda.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70AC720774;
        Wed, 12 Aug 2020 18:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597258790;
        bh=/wdga4UNSKTHfzzgL8b+sTrJQhQuvj60dfRwTV4au+I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=w9VyCjMfLpHM6SJRTjzkW/Z5MxU+3eg1va9oDApDyOEJGq2zjgIuS1d4Rrq2pmVrB
         Z+L6UcwoueIx/DEG0iCChjOgfiIVYPRx++/zS2gcCSx8ZXxHD6bfG89Lmh/VqPRN1a
         tSosj6QHQDN/qPEVmRu+jJf/Eq5IIY6OYOEMSXnA=
Date:   Wed, 12 Aug 2020 15:59:47 -0300
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, Mayulong <mayulong1@huawei.com>,
        linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        mauro.chehab@huawei.com
Subject: Re: [PATCH 01/44] staging: spmi: add Hikey 970 SPMI controller
 driver
Message-ID: <20200812155947.61479b84@onda.lan>
In-Reply-To: <20200812162814.GB2650123@kroah.com>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
        <4305f945d257cf590646100cad752a0a6542a152.1597247164.git.mchehab+huawei@kernel.org>
        <20200812162814.GB2650123@kroah.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 12 Aug 2020 18:28:14 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Wed, Aug 12, 2020 at 05:56:11PM +0200, Mauro Carvalho Chehab wrote:
> > From: Mayulong <mayulong1@huawei.com>
> > 
> > Add the SPMI controller code required to use the Kirin 970
> > SPMI bus.
> > 
> > [mchehab+huawei@kernel.org: added just the SPMI controller on this patch]
> > 
> > The complete patch is at:
> > 
> > 	https://github.com/96boards-hikey/linux/commit/08464419fba2
> > 
> > Signed-off-by: Mayulong <mayulong1@huawei.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  .../staging/hikey9xx/hisi-spmi-controller.c   | 390 ++++++++++++++++++
> >  1 file changed, 390 insertions(+)
> >  create mode 100644 drivers/staging/hikey9xx/hisi-spmi-controller.c
> > 
> > diff --git a/drivers/staging/hikey9xx/hisi-spmi-controller.c b/drivers/staging/hikey9xx/hisi-spmi-controller.c
> > new file mode 100644
> > index 000000000000..987526c8b49f
> > --- /dev/null
> > +++ b/drivers/staging/hikey9xx/hisi-spmi-controller.c
> > @@ -0,0 +1,390 @@
> > +
> > +#include <linux/delay.h>  
> 
> <snip>
> 
> No SPDX line at all?
> 
> :(

This is added later on at this series. The first patch came from a 4.9
tree, where such tags weren't used yet.

The next patches on this series will add SPDX to all files.

Regards,
Mauro


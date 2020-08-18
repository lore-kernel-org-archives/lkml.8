Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D90C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8601720786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597760910;
	bh=TyjAOtFLUcdkHJqVznsWOj1rsY2m5SGYugIkegCaavY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rByCrSfUl2Xnvs0vmEJJnhHHFnhVdF7ibrPWq7S1sg1pmDhXuxPTiJ4ucG5kc7DDd
	 ajr/mwfuIR9TyEK2I/g/8rlo1D7V6pzb+71iJRw1U7DeDATPMqYsk5Ku0ZQPDFna4r
	 yR+NqabRPm9sNClNDMExSKBD31suDO2NEnqT57Co=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgHRO23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:28:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726660AbgHRO21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:28:27 -0400
Received: from coco.lan (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A1CD207D3;
        Tue, 18 Aug 2020 14:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597760906;
        bh=TyjAOtFLUcdkHJqVznsWOj1rsY2m5SGYugIkegCaavY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bxizRbar0YqT2TrzigWWLFiyjHd8OrzPxdbiHrSL99ATPBIiho1ScQAO7glgsBm1d
         CbqL8TXLmE9kPn/MY2ElMs8rz7fnLBvYK+P6j8yH2z/fv3Q506iLRcxsBsCOKM8oYr
         TVBv9HaIJ85o0Un2VIykpVXUobCuAXfcoKVL/ss4=
Date:   Tue, 18 Aug 2020 16:28:20 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linuxarm@huawei.com, Wei Xu <xuwei5@hisilicon.com>,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, mauro.chehab@huawei.com,
        Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 00/44] SPMI patches needed by Hikey 970
Message-ID: <20200818162820.3c78c33c@coco.lan>
In-Reply-To: <20200818141750.GA608639@kroah.com>
References: <cover.1597647359.git.mchehab+huawei@kernel.org>
        <20200818141750.GA608639@kroah.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 18 Aug 2020 16:17:50 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> escreveu:

> On Mon, Aug 17, 2020 at 09:10:19AM +0200, Mauro Carvalho Chehab wrote:
> > Hi Greg,
> > 
> > This patch series is part of a work I'm doing in order to be able to support
> > a HiKey 970 board that I recently got on my hands.  
> 
> With this applied, I get the following build error:
> ERROR: modpost: "__spmi_driver_register" [drivers/staging/hikey9xx/hi6421-spmi-pmic.ko] undefined!
> ERROR: modpost: "spmi_ext_register_writel" [drivers/staging/hikey9xx/hi6421-spmi-pmic.ko] undefined!
> ERROR: modpost: "spmi_ext_register_readl" [drivers/staging/hikey9xx/hi6421-spmi-pmic.ko] undefined!
> ERROR: modpost: "spmi_controller_add" [drivers/staging/hikey9xx/hisi-spmi-controller.ko] undefined!
> ERROR: modpost: "spmi_controller_alloc" [drivers/staging/hikey9xx/hisi-spmi-controller.ko] undefined!
> ERROR: modpost: "spmi_controller_remove" [drivers/staging/hikey9xx/hisi-spmi-controller.ko] undefined!
> 
> 
> I'll take this in my testing tree for now, can you send a follow-on
> patch to fix this?

Surely. That's because it got moved from drivers/spmi/Kconfig.
The Kconfig var was inside a:

if SPMI
...
endif

This driver should "depends on SPMI". I'll send you a patch in a few.

Thanks,
Mauro

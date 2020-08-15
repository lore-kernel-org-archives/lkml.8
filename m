Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737B4C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ACAD2065C
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597529458;
	bh=8xrqG9ujM70SVswirhjHSCM1NcB46h4TexvLpDudO2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=n9/4LSqm0nYybotUQ+WGdLi8oMvCXnChbc9leysTjbsRoejomhFZJSFoadpQ5Yp1p
	 sRAgDa71zldtgPfpb16dwQKYdDY7PKfFhmG/30HXIB4ohZCsNtRk4oo8b5doW9xJI0
	 tuVAqPps5VaKJmK4o3/NWkw4mOrKKVcSdO6ucIZc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgHOWKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:10:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:41774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729600AbgHOWKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:10:37 -0400
Received: from coco.lan (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE6E123107;
        Sat, 15 Aug 2020 09:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597485342;
        bh=8xrqG9ujM70SVswirhjHSCM1NcB46h4TexvLpDudO2g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=yAnn6BiR5U23ij/arHHrK8eelhARFK7/EUOlF3awlMLsxkoQEG9tZYQUnutq9i7MH
         D18q6AwLGssk9detsPija+F+N9yue+RsxWHArtljHus9HQJvE2NliGwp1XGPCRSpMw
         n2rx5a4v/01pNOLc3N1Isl2OON8WkrUFAo3yyNtY=
Date:   Sat, 15 Aug 2020 11:55:36 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     mauro.chehab@huawei.com, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linuxarm@huawei.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 43/44] dt: document HiSilicon SPMI controller and
 mfd/regulator properties
Message-ID: <20200815115536.6519a7f5@coco.lan>
In-Reply-To: <20200814201708.GA2665752@bogus>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
        <da65a508d01aa2092999d0ce7e9c061ccfd24036.1597247164.git.mchehab+huawei@kernel.org>
        <20200814201708.GA2665752@bogus>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Em Fri, 14 Aug 2020 14:17:08 -0600
Rob Herring <robh@kernel.org> escreveu:

> On Wed, 12 Aug 2020 17:56:53 +0200, Mauro Carvalho Chehab wrote:
> > Add documentation for the properties needed by the HiSilicon
> > 6421v600 driver, and by the SPMI controller used to access
> > the chipset.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  .../mfd/hisilicon,hi6421-spmi-pmic.yaml       | 182 ++++++++++++++++++
> >  .../spmi/hisilicon,hisi-spmi-controller.yaml  |  54 ++++++
> >  2 files changed, 236 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
> >  create mode 100644 Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
> >   
> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.example.dt.yaml: example-0: spmi@fff24000:reg:0: [0, 4294066176, 0, 4096] is too long

I was unable to find any way to solve this one. What's the proper
way to set the length of the root reg on some example?

Thanks,
Mauro

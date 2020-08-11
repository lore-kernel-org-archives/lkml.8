Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF7BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A26D021744
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597163718;
	bh=zrROuNHVIPl2WwOYy+4z35skJ3HoFnLK9ZW+bJ7/5x0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=quALXkL3Vw6eCYxr4MoF3ksEGXM9bWe7LXMdMhxV0IA4hrFZAnjy9YFY9oG2XLx+2
	 JOSta6K2CtmaFcEZoCMR1XcxiWzgbt42SK9x4p/hSkTmLnw/JGa77SwTjdC/zR4mKr
	 dsBRmBJBx8LXhX5nM1kWjQ2NFaffH0D3wgZdXoX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbgHKQfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:35:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728925AbgHKQfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:35:15 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C631420781;
        Tue, 11 Aug 2020 16:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597163714;
        bh=zrROuNHVIPl2WwOYy+4z35skJ3HoFnLK9ZW+bJ7/5x0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2p7n3NZ4tJbHK1piz2KsMNonkfyeGdCrmOUc1O3Dr8IBWh6YKlc+b61prSsSMUxFp
         0sNe9y3U0Vx/akq9xMm8zhoLxWQLNOVoTILjXYZNoco5uUvurxN8g4JkkEOKs6IO9U
         LB4aUAc9GF6MHmp8wDt0Xs3YBIQod1xJK0k3kHSA=
Date:   Tue, 11 Aug 2020 18:35:09 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mayulong <mayulong1@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 02/33] spmi, regulator, mfd: add drivers for hikey970
 SPMI PMIC
Message-ID: <20200811183509.32339628@coco.lan>
In-Reply-To: <20200811161539.GK6967@sirena.org.uk>
References: <cover.1597160086.git.mchehab+huawei@kernel.org>
        <36a548c10ea8c75d13c3e796c4cee65132819ef1.1597160086.git.mchehab+huawei@kernel.org>
        <20200811155810.GH6967@sirena.org.uk>
        <20200811180837.2285c8b5@coco.lan>
        <20200811161539.GK6967@sirena.org.uk>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 11 Aug 2020 17:15:39 +0100
Mark Brown <broonie@kernel.org> escreveu:

> On Tue, Aug 11, 2020 at 06:08:37PM +0200, Mauro Carvalho Chehab wrote:
> > Mark Brown <broonie@kernel.org> escreveu:  
> 
> > > This is a single patch for three subsystems, please split it into per
> > > subsystem patches.  
> 
> > Ok, I'll split on a next version.   
> 
> > Yet, it would be good to have all tree drivers applied via the same tree,
> > as those drivers are needed altogether in order for this PMIC to work:  
> 
> This is completely normal for MFD drivers, it's still much easier to
> review things if individual subsystem maintainers can easily get to the
> code for their subsystem, any Reviewed-bys or whatever can be sensibly
> applies to relevant code and ideally people can apply patches as they're
> ready if there's no build time dependencies or Kconfig symbols which
> prevent build without the dependencies being merged.

Ok. I'll split it into three series. 

Before posting the next version, it would be nice to have some feedback
specially at the DT documentation patch:

	https://lore.kernel.org/lkml/176043f329dfa9889f014feec04e7e1553077873.1597160086.git.mchehab+huawei@kernel.org/T/#u

as any changes there will need to be reflected on the other patches
from this series.

Btw, despite being 3 drivers, I added only two DT docs, as the
regulator description is done together with the PMIC one.

Thanks,
Mauro

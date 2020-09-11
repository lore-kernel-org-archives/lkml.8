Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 316CDC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E80F5206CA
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599840521;
	bh=iLPXQfche2cl2UNFwVe5Cn0pwE5wjPTc1yMcibij3Cc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BL1ElaaBI8z4He+7pSnTHJJGZEUyzRlOEdNzmc9e4Bu1OQeJLcxlelD288D00lPiy
	 84kz0lJsD9DT2Rqio+mq202nHhE8e8vcFHYkBnsersK89sLY9efmv5lvaQpmxt0k7w
	 NRNjR2yKbmQjfak4THDFZsyxQA6LQL6Ua7yzbQU4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgIKQIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:08:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:49908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726308AbgIKQII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:08:08 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67F69206CA;
        Fri, 11 Sep 2020 16:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599840488;
        bh=iLPXQfche2cl2UNFwVe5Cn0pwE5wjPTc1yMcibij3Cc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LzluMK/42p47BOEhqCg9J+En60njQGbHwN2+0wRwyoosXXO2/pLvAVJsq5zMFx1qz
         uVCU9qpfDRiLxjKRXW38CC0EKI1OyvSsyZJDC+z8P1OI+d9DW/uqyNEGwC2oXnpu1u
         AzDXcFsZscFOuTMQXVm2IWUukA/pz77wIuMh5Q60=
Date:   Fri, 11 Sep 2020 17:08:04 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Salter <msalter@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/perf: xgene_pmu: Fix uninitialized resource
 struct
Message-ID: <20200911160802.GB20802@willie-the-truck>
References: <20200902182729.27415-1-msalter@redhat.com>
 <20200907135026.GC12551@willie-the-truck>
 <489a7918b244e83736feff79c59a4b74d4e5cad0.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <489a7918b244e83736feff79c59a4b74d4e5cad0.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 02:37:22PM -0400, Mark Salter wrote:
> On Mon, 2020-09-07 at 14:50 +0100, Will Deacon wrote:
> > On Wed, Sep 02, 2020 at 02:27:29PM -0400, Mark Salter wrote:
> > > diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
> > > index edac28cd25dd..fdbbd0804b92 100644
> > > --- a/drivers/perf/xgene_pmu.c
> > > +++ b/drivers/perf/xgene_pmu.c
> > > @@ -1483,6 +1483,7 @@ xgene_pmu_dev_ctx *acpi_get_pmu_hw_inf(struct xgene_pmu *xgene_pmu,
> > >  		return NULL;
> > >  
> > >  	INIT_LIST_HEAD(&resource_list);
> > > +	memset(&res, 0, sizeof(res));
> > >  	rc = acpi_dev_get_resources(adev, &resource_list,
> > >  				    acpi_pmu_dev_add_resource, &res);
> > >  	acpi_dev_free_resource_list(&resource_list);
> > 
> > Hmm, to be honest, I'm not sure we should be calling devm_ioremap_resource()
> > at all here. The resource is clearly bogus, even with this change: the name
> > and the resource hierarchy pointers will all be NULL. I think it would be
> > better to follow the TX2 PMU driver (drivers/perf/thunderx2_pmu.c) which
> > appears to assign the resource directly in tx2_uncore_pmu_init_dev().
> > 
> > Is there a reason we can't do that?
> > 
> > Will
> > 
> 
> There's no difference between xgene and tx2 wrt resouce name/hierarchy.
> They both call devm_ioresource_remap() which ends up setting the name
> and hierarchy. The difference is that xgene calls acpi_dev_resource_memory()
> directly from the acpi_dev_get_resources() callback. TX2 doesn't use such a
> callback and in that case, acpi_dev_resource_memory() gets called with a
> zeroed struct.
> 
> That said, changing xgene to avoid the callback like TX2 does would fix the
> problem as well. If you'd rather go that route, I can send a patch for it.

Yes please

Will

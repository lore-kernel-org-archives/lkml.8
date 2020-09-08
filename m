Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7C8C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC4A2080C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QNOSICBK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731362AbgIHShe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:37:34 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39126 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728572AbgIHSh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 14:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599590247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4hFz93R/epUx5ygJCxi7aKlkiNQm5+bqKazJAau4MUY=;
        b=QNOSICBKCCkjT3z/L/0rfRzs4Nm+zR79po9yr+CpxkXMRft+y3zO4/fhyFR7dsUjbshS0Y
        4FQ6wV8eOZTlSrDoA/LhI7QEbOlZI3RbeNvTxJI8gLczau3DYCmKmXFPKH3PYSB4o90rGB
        6VFM1nO63Jn2DGqQJuETyJX3ClAw7GE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-510-KwvEnB2CMD-KkDvmAjm5DQ-1; Tue, 08 Sep 2020 14:37:25 -0400
X-MC-Unique: KwvEnB2CMD-KkDvmAjm5DQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 66DC9801AB2;
        Tue,  8 Sep 2020 18:37:23 +0000 (UTC)
Received: from ovpn-112-26.rdu2.redhat.com (ovpn-112-26.rdu2.redhat.com [10.10.112.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C50EB282F0;
        Tue,  8 Sep 2020 18:37:22 +0000 (UTC)
Message-ID: <489a7918b244e83736feff79c59a4b74d4e5cad0.camel@redhat.com>
Subject: Re: [PATCH] drivers/perf: xgene_pmu: Fix uninitialized resource
 struct
From:   Mark Salter <msalter@redhat.com>
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 08 Sep 2020 14:37:22 -0400
In-Reply-To: <20200907135026.GC12551@willie-the-truck>
References: <20200902182729.27415-1-msalter@redhat.com>
         <20200907135026.GC12551@willie-the-truck>
Organization: Red Hat, Inc
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.module_f32+9025+599b805f) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-09-07 at 14:50 +0100, Will Deacon wrote:
> On Wed, Sep 02, 2020 at 02:27:29PM -0400, Mark Salter wrote:
> > diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
> > index edac28cd25dd..fdbbd0804b92 100644
> > --- a/drivers/perf/xgene_pmu.c
> > +++ b/drivers/perf/xgene_pmu.c
> > @@ -1483,6 +1483,7 @@ xgene_pmu_dev_ctx *acpi_get_pmu_hw_inf(struct xgene_pmu *xgene_pmu,
> >  		return NULL;
> >  
> >  	INIT_LIST_HEAD(&resource_list);
> > +	memset(&res, 0, sizeof(res));
> >  	rc = acpi_dev_get_resources(adev, &resource_list,
> >  				    acpi_pmu_dev_add_resource, &res);
> >  	acpi_dev_free_resource_list(&resource_list);
> 
> Hmm, to be honest, I'm not sure we should be calling devm_ioremap_resource()
> at all here. The resource is clearly bogus, even with this change: the name
> and the resource hierarchy pointers will all be NULL. I think it would be
> better to follow the TX2 PMU driver (drivers/perf/thunderx2_pmu.c) which
> appears to assign the resource directly in tx2_uncore_pmu_init_dev().
> 
> Is there a reason we can't do that?
> 
> Will
> 

There's no difference between xgene and tx2 wrt resouce name/hierarchy.
They both call devm_ioresource_remap() which ends up setting the name
and hierarchy. The difference is that xgene calls acpi_dev_resource_memory()
directly from the acpi_dev_get_resources() callback. TX2 doesn't use such a
callback and in that case, acpi_dev_resource_memory() gets called with a
zeroed struct.

That said, changing xgene to avoid the callback like TX2 does would fix the
problem as well. If you'd rather go that route, I can send a patch for it.

Mark



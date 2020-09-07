Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF38C2BB84
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19432206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599499157;
	bh=J7KhyjwPkOJGOay8k3dotO+k4kIPfPIOXH16l9SfKnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=J72lwcu8oY5XB1n3jxisJoA+Ea0incFatlbsXHWj4mPtA7p4rUtC7SqgwsXC84Z0W
	 TGGkBt+5JcykSq8ABPNiEL0r5jY7+vNr7PH+Asz25YEjPAK8w3GM0bfeBVNiY7LCb+
	 a6zxI/5nBpXrf7j9zlgYYe/zgn69ZxtuVkIzFgos=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbgIGRTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:19:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729703AbgIGOA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:00:56 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB4412064B;
        Mon,  7 Sep 2020 13:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599486630;
        bh=J7KhyjwPkOJGOay8k3dotO+k4kIPfPIOXH16l9SfKnk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nqPSx7Yg7Dl3jwKJBWll4TFZ9RfVikUBT1Sx9PemWPtM1NMfcWAh+PXCs2dng91S4
         EgW1V+1KMTn274zvq7rhmRpyKPTiC/sEHR0/0Hu4m3mKYq/BGFAMUTC7k8YzLL4/Ac
         5ERBrYKHDKOXeeQbsoQCn7Z0c0st8Adb/JzalYBY=
Date:   Mon, 7 Sep 2020 14:50:26 +0100
From:   Will Deacon <will@kernel.org>
To:     Mark Salter <msalter@redhat.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/perf: xgene_pmu: Fix uninitialized resource
 struct
Message-ID: <20200907135026.GC12551@willie-the-truck>
References: <20200902182729.27415-1-msalter@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902182729.27415-1-msalter@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 02:27:29PM -0400, Mark Salter wrote:
> diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
> index edac28cd25dd..fdbbd0804b92 100644
> --- a/drivers/perf/xgene_pmu.c
> +++ b/drivers/perf/xgene_pmu.c
> @@ -1483,6 +1483,7 @@ xgene_pmu_dev_ctx *acpi_get_pmu_hw_inf(struct xgene_pmu *xgene_pmu,
>  		return NULL;
>  
>  	INIT_LIST_HEAD(&resource_list);
> +	memset(&res, 0, sizeof(res));
>  	rc = acpi_dev_get_resources(adev, &resource_list,
>  				    acpi_pmu_dev_add_resource, &res);
>  	acpi_dev_free_resource_list(&resource_list);

Hmm, to be honest, I'm not sure we should be calling devm_ioremap_resource()
at all here. The resource is clearly bogus, even with this change: the name
and the resource hierarchy pointers will all be NULL. I think it would be
better to follow the TX2 PMU driver (drivers/perf/thunderx2_pmu.c) which
appears to assign the resource directly in tx2_uncore_pmu_init_dev().

Is there a reason we can't do that?

Will

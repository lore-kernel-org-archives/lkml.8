Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4164DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D688207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 07:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589959993;
	bh=wubkXTV9YfNSZFkVpKAM6nS+N7G81auN5xKELhErTmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gfw3+rDlpH+JJNrZJFdQzB2mKdrAbI+Eobwj1yZCIm7JgI7OfKXSI+k16oK4WpRA5
	 sTUvKKGvtLEf5WZXLPRmkYECjmEJ778zHBCNftYYgOjPVd6mA2qm2A11L+HMTNHwdl
	 tXIFa+KOaRt3+CiKNvXkn2ZPzTuYVfu7cSzs+fK4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgETHdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 03:33:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:58988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbgETHdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 03:33:10 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26ABF205CB;
        Wed, 20 May 2020 07:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589959989;
        bh=wubkXTV9YfNSZFkVpKAM6nS+N7G81auN5xKELhErTmY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yc/605SUMUJFs9TJLBPK2N5ck7U+Xa/E8+UxOiI7rgE3jsziwIwsk2ilHury9s9E2
         pTi8zsr9ZsOdemB7gI4Lu3oSp6U9/zDqz0PuAkVPzm4Smr6sumxAV0qmwbH5wb3vON
         SxPzkYN+kKYXfWbahrcv+B36uCRmn6Sj+4UJgtoU=
Date:   Wed, 20 May 2020 08:33:04 +0100
From:   Will Deacon <will@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>, john.garry@huawei.com,
        mark.rutland@arm.com, shawnguo@kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 RESEND 1/3] perf/imx_ddr: Add system PMU identifier
 for userspace
Message-ID: <20200520073304.GA23534@willie-the-truck>
References: <20200512073115.14177-1-qiangqing.zhang@nxp.com>
 <20200512073115.14177-2-qiangqing.zhang@nxp.com>
 <20200519185125.GB453195@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519185125.GB453195@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 12:51:25PM -0600, Rob Herring wrote:
> On Tue, May 12, 2020 at 03:31:13PM +0800, Joakim Zhang wrote:
> > +static ssize_t ddr_perf_identifier_show(struct device *dev,
> > +					struct device_attribute *attr,
> > +					char *page)
> > +{
> > +	struct ddr_pmu *pmu = dev_get_drvdata(dev);
> > +
> > +	return sprintf(page, "%s\n", pmu->devtype_data->identifier);
> 
> Why do we need yet another way to identify the SoC from userspace?

I also really dislike this. What's the preferred way to identify the SoC
from userspace? It's needed so that the perf userspace tool can describe
perf events that are supported for the PMU, as this isn't probe-able
directly from the hardware. We have the same issue with the SMMUv3 PMCG [1],
and so we need to solve the problem for both DT and ACPI.

Will

[1] https://lore.kernel.org/r/1587120634-19666-1-git-send-email-john.garry@huawei.com

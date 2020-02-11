Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D30C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 410A120870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581441346;
	bh=g+2gIaMisgtrnsO0SyHLEWmhyLlRYwzciA6Edap8+RU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JvnTq416uSEN3VS2uL/t1jrtTjC817N4+UMB+2RvV7LvJ38cXDPaFH2u7FTFASCjF
	 NgcqCYvmFvcMuGWRvdLIPPCwxJ5fcrWGvVstX+RowaS5P1U692LPXbX5+4jLtcFV4G
	 Vd1mbMjwuG5QHr4BQvgQhPr44VEQweMB/KaL8Zus=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgBKRPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:15:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:43172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728078AbgBKRPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:15:45 -0500
Received: from localhost (unknown [104.133.9.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA55620848;
        Tue, 11 Feb 2020 17:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581441344;
        bh=g+2gIaMisgtrnsO0SyHLEWmhyLlRYwzciA6Edap8+RU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y0aGiIyAaVVO0J9iefxmrJ0xHxm1khL6jjbw1n047KHv65w6GxCjelqC6vigPIFJC
         py3GV0oyVen3P4WFtKjp3e/tmDj6tiJfD4h2Nf/S7ArYhFO7MDQdi5byte8iBYwcv/
         WJKobnq/kr0IQcP0JJO6m18He7o1pIZbbuV55s5c=
Date:   Tue, 11 Feb 2020 09:15:44 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     roman.sudarikov@linux.intel.com
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, eranian@google.com,
        bgregg@netflix.com, ak@linux.intel.com, kan.liang@linux.intel.com,
        alexander.antonov@intel.com
Subject: Re: [PATCH v5 3/3] perf =?iso-8859-1?Q?x86?=
 =?iso-8859-1?Q?=3A_Exposing_an_Uncore_unit_to_PMON_for_Intel_Xeon?=
 =?iso-8859-1?Q?=AE?= server platform
Message-ID: <20200211171544.GA1933705@kroah.com>
References: <20200211161549.19828-1-roman.sudarikov@linux.intel.com>
 <20200211161549.19828-4-roman.sudarikov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200211161549.19828-4-roman.sudarikov@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 07:15:49PM +0300, roman.sudarikov@linux.intel.com wrote:
> +static ssize_t skx_iio_mapping_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	struct pmu *pmu = dev_get_drvdata(dev);
> +	struct intel_uncore_pmu *uncore_pmu =
> +		container_of(pmu, struct intel_uncore_pmu, pmu);
> +
> +	struct dev_ext_attribute *ea =
> +		container_of(attr, struct dev_ext_attribute, attr);
> +	long die = (long)ea->var;
> +
> +	return sprintf(buf, "0000:%02x\n", skx_iio_stack(uncore_pmu, die));

If "0000:" is always the "prefix" of the output of this file, why have
it at all as you always know it is there?

What is ever going to cause that to change?

thanks,

greg k-h

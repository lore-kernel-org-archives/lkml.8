Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3BC3C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D6420870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581441519;
	bh=d+G1kH6PuPcpK/vgEAYZT5zRCug6wULTh1C5dFAkCLU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r5qwtN1hdyekXufU6KX+iHTvr6IqQQEBjDOGZJqymXN3sCCn49MT8IDPhp6tEqiJ6
	 9TvCueSqWgHrRs5TGKwCci9Q8SFpXREXy+ixmOzQSr+yN2IXmkv/S2tkvWe8vs6WlR
	 jF56ZC2qQ3nLl3q2pQjOL5+Wj3MVVo2ELf/X89x0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgBKRSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:18:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:44564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727954AbgBKRSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:18:38 -0500
Received: from localhost (unknown [104.133.9.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CAD6C20578;
        Tue, 11 Feb 2020 17:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581441516;
        bh=d+G1kH6PuPcpK/vgEAYZT5zRCug6wULTh1C5dFAkCLU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U0OuxxUFxc6JzUL0wcYRVH93AQWkx9gbK37pIl2pFQeyTPnK47wBJ1LzbK0AAKn5b
         av6brJaC00sXlP2/WYqD0I4N3sWA5Zlgj0rpnCUh0jI4aTCwJ34neI+vq/5O7RmewF
         EMBps2STPX+59ugI43bQZpPevaWONvznwzscfjW0=
Date:   Tue, 11 Feb 2020 09:18:36 -0800
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
Message-ID: <20200211171836.GB1933705@kroah.com>
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
> +static struct attribute *uncore_empry_attr;

What is this for?

> +static struct attribute_group skx_iio_mapping_group = {
> +	.attrs		= &uncore_empry_attr,

Again, what for?

You just overwrite this value so why have it at all?


> +	.is_visible	= skx_iio_mapping_visible,
> +};
> +
> +const static struct attribute_group *skx_iio_attr_update[] = {
> +	&skx_iio_mapping_group,
> +	NULL,
> +};
> +
> +static int skx_iio_set_mapping(struct intel_uncore_type *type)
> +{
> +	char buf[64];
> +	int ret = 0;
> +	long die;
> +	struct attribute **attrs;
> +	struct dev_ext_attribute *eas;
> +
> +	ret = skx_iio_get_topology(type);
> +	if (ret)
> +		return ret;
> +
> +	// One more for NULL.
> +	attrs = kzalloc((uncore_max_dies() + 1) * sizeof(*attrs), GFP_KERNEL);
> +	if (!attrs) {
> +		kfree(type->topology);
> +		return -ENOMEM;
> +	}
> +
> +	eas = kzalloc(sizeof(*eas) * uncore_max_dies(), GFP_KERNEL);
> +	if (!eas) {
> +		kfree(attrs);
> +		kfree(type->topology);
> +		return -ENOMEM;
> +	}
> +	for (die = 0; die < uncore_max_dies(); die++) {
> +		sprintf(buf, "node%ld", die);
> +		eas[die].attr.attr.name = kstrdup(buf, GFP_KERNEL);
> +		if (!eas[die].attr.attr.name) {
> +			ret = -ENOMEM;
> +			goto err;
> +		}
> +		eas[die].attr.attr.mode = 0444;
> +		eas[die].attr.show = skx_iio_mapping_show;
> +		eas[die].attr.store = NULL;
> +		eas[die].var = (void *)die;
> +		attrs[die] = &eas[die].attr.attr;

You HAVE to call sysfs_attr_init() on any dynamically created
attributes.  I am guessing you never ran this code with lockdep enabled?

{sigh}

greg k-h

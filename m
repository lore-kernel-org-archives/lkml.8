Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6830EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 366D6207D4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589975832;
	bh=iykMISmEA3B2cWlO05h0kvztgbh5MJtjGLS9pgY5hRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L9FJCGd1r9JPwjnHTOdDenLdWPDN8M2iph7pS5+KH9OgZYY7E6BV5iIfMeuq3xfR1
	 Nz2j27McxjHZnZPBXthoXRKO3QHZYj04DnwHd4mjgzDyxqwS3evw97vp2p8bD54WNQ
	 towhMN6kSxyiHHF/pOHT5Mnoucq2p3yPKaa9Zc0Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgETL5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:57:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgETL5L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:57:11 -0400
Received: from localhost (unknown [122.178.227.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5CE1206BE;
        Wed, 20 May 2020 11:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589975830;
        bh=iykMISmEA3B2cWlO05h0kvztgbh5MJtjGLS9pgY5hRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=alR7aWRzrS+FUgCnAxm/sAtv2qosqZMo77Ks9sqnj8L+o+zNCJoLgsuxpeH7mvBuq
         HMHacczQmUyiUYrF6//cLN8VHogYz2F87uT78h/dpMQc5pfJ0EqymqYF9T0LKUQIEQ
         EJH1lp05zfFm/aJ26v144OcgYqsGwmzqSOENwLtU=
Date:   Wed, 20 May 2020 17:27:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, pierre-louis.bossart@linux.intel.com,
        sanyog.r.kale@intel.com, slawomir.blauciak@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 3/3] soundwire: add Slave sysfs support
Message-ID: <20200520115705.GV374218@vkoul-mobl.Dlink>
References: <20200518203551.2053-1-yung-chuan.liao@linux.intel.com>
 <20200518203551.2053-4-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518203551.2053-4-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-05-20, 04:35, Bard Liao wrote:

> +int sdw_slave_sysfs_init(struct sdw_slave *slave)
> +{
> +	int ret;
> +
> +	ret = devm_device_add_groups(&slave->dev, slave_groups);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_device_add_group(&slave->dev, &sdw_slave_dev_attr_group);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (slave->prop.dp0_prop) {
> +		ret = devm_device_add_group(&slave->dev, &dp0_group);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	if (slave->prop.source_ports || slave->prop.sink_ports) {
> +		ret = sdw_slave_sysfs_dpn_init(slave);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +

We have trailing line here

> +static int add_all_attributes(struct device *dev, int N, int dir)
> +{
> +	struct attribute **dpn_attrs;
> +	struct attribute_group *dpn_group;
> +	int i = 0;
> +	int ret;
> +
> +	/* allocate attributes, last one is NULL */
> +	dpn_attrs = devm_kcalloc(dev, SDW_DPN_ATTRIBUTES + 1,
> +				 sizeof(struct attribute *),
> +				 GFP_KERNEL);
> +	if (!dpn_attrs)
> +		return -ENOMEM;
> +
> +	ret = max_word_attribute_alloc(dev, &dpn_attrs[i++],
> +				       N, dir, "%d\n");
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = min_word_attribute_alloc(dev, &dpn_attrs[i++],
> +				       N, dir, "%d\n");
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = words_attribute_alloc(dev, &dpn_attrs[i++],
> +				    N, dir, "%d\n");
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = type_attribute_alloc(dev, &dpn_attrs[i++],
> +				   N, dir, "%d\n");
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = max_grouping_attribute_alloc(dev, &dpn_attrs[i++],
> +					   N, dir, "%d\n");
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = simple_ch_prep_sm_attribute_alloc(dev, &dpn_attrs[i++],
> +						N, dir, "%d\n");
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ch_prep_timeout_attribute_alloc(dev, &dpn_attrs[i++],
> +					      N, dir, "%d\n");
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = imp_def_interrupts_attribute_alloc(dev, &dpn_attrs[i++],
> +						 N, dir, "0x%x\n");
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = min_ch_attribute_alloc(dev, &dpn_attrs[i++],
> +				     N, dir, "%d\n");
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = max_ch_attribute_alloc(dev, &dpn_attrs[i++],
> +				     N, dir, "%d\n");
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = channels_attribute_alloc(dev, &dpn_attrs[i++],
> +				       N, dir, "%d\n");
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ch_combinations_attribute_alloc(dev, &dpn_attrs[i++],
> +					      N, dir, "%d\n");
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = max_async_buffer_attribute_alloc(dev, &dpn_attrs[i++],
> +					       N, dir, "%d\n");
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = block_pack_mode_attribute_alloc(dev, &dpn_attrs[i++],
> +					      N, dir, "%d\n");
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = port_encoding_attribute_alloc(dev, &dpn_attrs[i++],
> +					    N, dir, "%d\n");
> +	if (ret < 0)
> +		return ret;
> +
> +	/* paranioa check for editing mistakes */

s/paranioa/paranoia

I found only these two nitpicks so I will go ahead and apply these and
fix them up.

-- 
~Vinod

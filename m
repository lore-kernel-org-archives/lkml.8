Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD509C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFFA32076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 16:27:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgHKQ1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 12:27:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:8362 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728872AbgHKQ1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 12:27:30 -0400
IronPort-SDR: 2Gk8+/oNgATSB0kG/OyfniFpNLK67JazcyM364PnQMUPm+v525FCktOzFq9E28LppfUKUPya1z
 9yje0z1dhsyw==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="171808402"
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="171808402"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 09:27:29 -0700
IronPort-SDR: PqOn8S+oN8hEcv874dbMLZ5zXgf9nDKMNmzaxkZ620ZYHXq2r+fwW7PHg2LJvIG5GSAE490Gtr
 9sSMAy/93TsA==
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="495202850"
Received: from lwhitehe-mobl.amr.corp.intel.com (HELO [10.212.97.49]) ([10.212.97.49])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 09:27:24 -0700
Subject: Re: sound/soc/codecs/max98373-sdw.c:325:4: warning: Variable 'i' is
 reassigned a value before the old one has been used.
To:     kernel test robot <lkp@intel.com>,
        Ryan Lee <ryans.lee@maximintegrated.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Naveen Manohar <naveen.m@intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
References: <202008111139.FaGnu4xu%lkp@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5a9a2338-1348-a84b-36f2-280d603298af@linux.intel.com>
Date:   Tue, 11 Aug 2020 10:04:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202008111139.FaGnu4xu%lkp@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> cppcheck warnings: (new ones prefixed by >>)
> 
>>> sound/soc/codecs/max98373-sdw.c:325:4: warning: Variable 'i' is reassigned a value before the old one has been used. [redundantAssignment]
>      i = 0;
>        ^
>     sound/soc/codecs/max98373-sdw.c:313:4: note: Variable 'i' is reassigned a value before the old one has been used.
>       i++;
>        ^

the variable is incremented at the end of the loop, and reset at the 
start of a new loop, not sure how to avoid this warning.

>     sound/soc/codecs/max98373-sdw.c:325:4: note: Variable 'i' is reassigned a value before the old one has been used.
>      i = 0;
>        ^
>     sound/soc/codecs/max98373-sdw.c:344:9: warning: Variable 'i' is reassigned a value before the old one has been used. [redundantAssignment]
>      for (i = 0; i < num_of_ports; i++)
>             ^
>     sound/soc/codecs/max98373-sdw.c:333:4: note: Variable 'i' is reassigned a value before the old one has been used.
>       i++;
>        ^
>     sound/soc/codecs/max98373-sdw.c:344:9: note: Variable 'i' is reassigned a value before the old one has been used.
>      for (i = 0; i < num_of_ports; i++)
>             ^

Same problem, the variable is reset at the start of a new loop, but the 
problem is solved - that code was removed in the latest code (to be 
submitted after the merge window).

> vim +/i +325 sound/soc/codecs/max98373-sdw.c
> 
>     281	
>     282	static int max98373_read_prop(struct sdw_slave *slave)
>     283	{
>     284		struct sdw_slave_prop *prop = &slave->prop;
>     285		int nval, i, num_of_ports;
>     286		u32 bit;
>     287		unsigned long addr;
>     288		struct sdw_dpn_prop *dpn;
>     289	
>     290		/* BITMAP: 00001000  Dataport 3 is active */
>     291		prop->source_ports = BIT(3);
>     292		/* BITMAP: 00000010  Dataport 1 is active */
>     293		prop->sink_ports = BIT(1);
>     294		prop->paging_support = true;
>     295		prop->clk_stop_timeout = 20;
>     296	
>     297		nval = hweight32(prop->source_ports);
>     298		num_of_ports = nval;
>     299		prop->src_dpn_prop = devm_kcalloc(&slave->dev, nval,
>     300						  sizeof(*prop->src_dpn_prop),
>     301						  GFP_KERNEL);
>     302		if (!prop->src_dpn_prop)
>     303			return -ENOMEM;
>     304	
>     305		i = 0;
>     306		dpn = prop->src_dpn_prop;
>     307		addr = prop->source_ports;
>     308		for_each_set_bit(bit, &addr, 32) {
>     309			dpn[i].num = bit;
>     310			dpn[i].type = SDW_DPN_FULL;
>     311			dpn[i].simple_ch_prep_sm = true;
>     312			dpn[i].ch_prep_timeout = 10;
>     313			i++;
>     314		}
>     315	
>     316		/* do this again for sink now */
>     317		nval = hweight32(prop->sink_ports);
>     318		num_of_ports += nval;
>     319		prop->sink_dpn_prop = devm_kcalloc(&slave->dev, nval,
>     320						   sizeof(*prop->sink_dpn_prop),
>     321						   GFP_KERNEL);
>     322		if (!prop->sink_dpn_prop)
>     323			return -ENOMEM;
>     324	
>   > 325		i = 0;
>     326		dpn = prop->sink_dpn_prop;
>     327		addr = prop->sink_ports;
>     328		for_each_set_bit(bit, &addr, 32) {
>     329			dpn[i].num = bit;
>     330			dpn[i].type = SDW_DPN_FULL;
>     331			dpn[i].simple_ch_prep_sm = true;
>     332			dpn[i].ch_prep_timeout = 10;
>     333			i++;
>     334		}
>     335	
>     336		/* Allocate port_ready based on num_of_ports */
>     337		slave->port_ready = devm_kcalloc(&slave->dev, num_of_ports,
>     338						 sizeof(*slave->port_ready),
>     339						 GFP_KERNEL);
>     340		if (!slave->port_ready)
>     341			return -ENOMEM;
>     342	
>     343		/* Initialize completion */
>     344		for (i = 0; i < num_of_ports; i++)
>     345			init_completion(&slave->port_ready[i]);
>     346	
>     347		/* set the timeout values */
>     348		prop->clk_stop_timeout = 20;
>     349	
>     350		return 0;
>     351	}
>     352	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

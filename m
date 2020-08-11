Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883A7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA75206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgHKDjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 23:39:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:41488 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727819AbgHKDjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 23:39:12 -0400
IronPort-SDR: IuvU02qvJ0JGIo/xltQJeAgXShAPHJaEbEoLcLlPOqsj5ISbTokD0Nv+qH8Vk4Rrg0lAne9w79
 no0+U45jg65Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="141518784"
X-IronPort-AV: E=Sophos;i="5.75,459,1589266800"; 
   d="scan'208";a="141518784"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 20:39:12 -0700
IronPort-SDR: P8PizyPiuh4AlrdqU9apzXqzMZqHNk2HlQGkgByKfdMpnOOR1yo7CwCM5+4TBoOQ+3WvBzVocF
 lmXCvAyXHFfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,459,1589266800"; 
   d="scan'208";a="332384573"
Received: from lkp-server01.sh.intel.com (HELO 71729f5ca340) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Aug 2020 20:39:10 -0700
Received: from kbuild by 71729f5ca340 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k5L81-0000Lh-Dt; Tue, 11 Aug 2020 03:39:09 +0000
Date:   Tue, 11 Aug 2020 11:38:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ryan Lee <ryans.lee@maximintegrated.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Naveen Manohar <naveen.m@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: sound/soc/codecs/max98373-sdw.c:325:4: warning: Variable 'i' is
 reassigned a value before the old one has been used.
Message-ID: <202008111139.FaGnu4xu%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   086ba2ec163b638abd2a90ef3e8bab0238d02e56
commit: 56a5b7910e965c6905d112ce94fd9a9f5561f326 ASoC: codecs: max98373: add SoundWire support
date:   5 weeks ago
compiler: mipsel-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> sound/soc/codecs/max98373-sdw.c:325:4: warning: Variable 'i' is reassigned a value before the old one has been used. [redundantAssignment]
    i = 0;
      ^
   sound/soc/codecs/max98373-sdw.c:313:4: note: Variable 'i' is reassigned a value before the old one has been used.
     i++;
      ^
   sound/soc/codecs/max98373-sdw.c:325:4: note: Variable 'i' is reassigned a value before the old one has been used.
    i = 0;
      ^
   sound/soc/codecs/max98373-sdw.c:344:9: warning: Variable 'i' is reassigned a value before the old one has been used. [redundantAssignment]
    for (i = 0; i < num_of_ports; i++)
           ^
   sound/soc/codecs/max98373-sdw.c:333:4: note: Variable 'i' is reassigned a value before the old one has been used.
     i++;
      ^
   sound/soc/codecs/max98373-sdw.c:344:9: note: Variable 'i' is reassigned a value before the old one has been used.
    for (i = 0; i < num_of_ports; i++)
           ^

vim +/i +325 sound/soc/codecs/max98373-sdw.c

   281	
   282	static int max98373_read_prop(struct sdw_slave *slave)
   283	{
   284		struct sdw_slave_prop *prop = &slave->prop;
   285		int nval, i, num_of_ports;
   286		u32 bit;
   287		unsigned long addr;
   288		struct sdw_dpn_prop *dpn;
   289	
   290		/* BITMAP: 00001000  Dataport 3 is active */
   291		prop->source_ports = BIT(3);
   292		/* BITMAP: 00000010  Dataport 1 is active */
   293		prop->sink_ports = BIT(1);
   294		prop->paging_support = true;
   295		prop->clk_stop_timeout = 20;
   296	
   297		nval = hweight32(prop->source_ports);
   298		num_of_ports = nval;
   299		prop->src_dpn_prop = devm_kcalloc(&slave->dev, nval,
   300						  sizeof(*prop->src_dpn_prop),
   301						  GFP_KERNEL);
   302		if (!prop->src_dpn_prop)
   303			return -ENOMEM;
   304	
   305		i = 0;
   306		dpn = prop->src_dpn_prop;
   307		addr = prop->source_ports;
   308		for_each_set_bit(bit, &addr, 32) {
   309			dpn[i].num = bit;
   310			dpn[i].type = SDW_DPN_FULL;
   311			dpn[i].simple_ch_prep_sm = true;
   312			dpn[i].ch_prep_timeout = 10;
   313			i++;
   314		}
   315	
   316		/* do this again for sink now */
   317		nval = hweight32(prop->sink_ports);
   318		num_of_ports += nval;
   319		prop->sink_dpn_prop = devm_kcalloc(&slave->dev, nval,
   320						   sizeof(*prop->sink_dpn_prop),
   321						   GFP_KERNEL);
   322		if (!prop->sink_dpn_prop)
   323			return -ENOMEM;
   324	
 > 325		i = 0;
   326		dpn = prop->sink_dpn_prop;
   327		addr = prop->sink_ports;
   328		for_each_set_bit(bit, &addr, 32) {
   329			dpn[i].num = bit;
   330			dpn[i].type = SDW_DPN_FULL;
   331			dpn[i].simple_ch_prep_sm = true;
   332			dpn[i].ch_prep_timeout = 10;
   333			i++;
   334		}
   335	
   336		/* Allocate port_ready based on num_of_ports */
   337		slave->port_ready = devm_kcalloc(&slave->dev, num_of_ports,
   338						 sizeof(*slave->port_ready),
   339						 GFP_KERNEL);
   340		if (!slave->port_ready)
   341			return -ENOMEM;
   342	
   343		/* Initialize completion */
   344		for (i = 0; i < num_of_ports; i++)
   345			init_completion(&slave->port_ready[i]);
   346	
   347		/* set the timeout values */
   348		prop->clk_stop_timeout = 20;
   349	
   350		return 0;
   351	}
   352	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

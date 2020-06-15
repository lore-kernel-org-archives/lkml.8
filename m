Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80FE5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E9DE2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728466AbgFOGhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:37:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:55706 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728260AbgFOGhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:37:23 -0400
IronPort-SDR: miPQA/FyJi8OZlB4C2vVDPZAOZXe7x4yUHuIYD4xlWrU434u1tMP1KiOITVCxodaQNG8KW0q8p
 nGMWUOa3NszA==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2020 23:34:16 -0700
IronPort-SDR: s3/r0VUsMitPTljxXd7ilf/c9sd+bLx44+TXMfZA7RF2uRimjjkaL0sz94/Xnm7IwyX1Cr8YQX
 kQK4QdXWOlqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; 
   d="gz'50?scan'50,208,50";a="475910792"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jun 2020 23:34:14 -0700
Date:   Mon, 15 Jun 2020 14:33:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/bridge/sil-sii8620.c:2355: undefined reference to
 `extcon_unregister_notifier'
Message-ID: <20200615063343.GP12456@shao2-debian>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="qIPawLzV4dNV95Tt"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qIPawLzV4dNV95Tt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b3a9e3b9622ae10064826dccb4f7a52bd88c7407
commit: def2fbffe62c00c330c7f41584a356001179c59c kconfig: allow symbols implied by y to become m
date:   3 months ago
:::::: branch date: 4 hours ago
:::::: commit date: 3 months ago
config: h8300-randconfig-r024-20200614 (attached as .config)
compiler: h8300-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout def2fbffe62c00c330c7f41584a356001179c59c
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=h8300 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

h8300-linux-ld: section .init.text LMA [0000000000455a00,000000000048c1c7] overlaps section .text LMA [000000000000025c,0000000000820b77]
h8300-linux-ld: section .data VMA [0000000000400000,00000000004559ff] overlaps section .text VMA [000000000000025c,0000000000820b77]
h8300-linux-ld: drivers/gpu/drm/bridge/sil-sii8620.o: in function `sii8620_remove':
>> drivers/gpu/drm/bridge/sil-sii8620.c:2355: undefined reference to `extcon_unregister_notifier'
h8300-linux-ld: drivers/gpu/drm/bridge/sil-sii8620.o: in function `sii8620_extcon_init':
>> drivers/gpu/drm/bridge/sil-sii8620.c:2179: undefined reference to `extcon_find_edev_by_node'
>> h8300-linux-ld: drivers/gpu/drm/bridge/sil-sii8620.c:2191: undefined reference to `extcon_register_notifier'
h8300-linux-ld: drivers/gpu/drm/bridge/sil-sii8620.o: in function `sii8620_extcon_work':
>> drivers/gpu/drm/bridge/sil-sii8620.c:2139: undefined reference to `extcon_get_state'

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=def2fbffe62c00c330c7f41584a356001179c59c
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git remote update linus
git checkout def2fbffe62c00c330c7f41584a356001179c59c
vim +2355 drivers/gpu/drm/bridge/sil-sii8620.c

688838442147d9 Maciej Purski    2018-02-27  2162  
688838442147d9 Maciej Purski    2018-02-27  2163  static int sii8620_extcon_init(struct sii8620 *ctx)
688838442147d9 Maciej Purski    2018-02-27  2164  {
688838442147d9 Maciej Purski    2018-02-27  2165  	struct extcon_dev *edev;
688838442147d9 Maciej Purski    2018-02-27  2166  	struct device_node *musb, *muic;
688838442147d9 Maciej Purski    2018-02-27  2167  	int ret;
688838442147d9 Maciej Purski    2018-02-27  2168  
688838442147d9 Maciej Purski    2018-02-27  2169  	/* get micro-USB connector node */
688838442147d9 Maciej Purski    2018-02-27  2170  	musb = of_graph_get_remote_node(ctx->dev->of_node, 1, -1);
688838442147d9 Maciej Purski    2018-02-27  2171  	/* next get micro-USB Interface Controller node */
688838442147d9 Maciej Purski    2018-02-27  2172  	muic = of_get_next_parent(musb);
688838442147d9 Maciej Purski    2018-02-27  2173  
688838442147d9 Maciej Purski    2018-02-27  2174  	if (!muic) {
688838442147d9 Maciej Purski    2018-02-27  2175  		dev_info(ctx->dev, "no extcon found, switching to 'always on' mode\n");
688838442147d9 Maciej Purski    2018-02-27  2176  		return 0;
688838442147d9 Maciej Purski    2018-02-27  2177  	}
688838442147d9 Maciej Purski    2018-02-27  2178  
688838442147d9 Maciej Purski    2018-02-27 @2179  	edev = extcon_find_edev_by_node(muic);
688838442147d9 Maciej Purski    2018-02-27  2180  	of_node_put(muic);
688838442147d9 Maciej Purski    2018-02-27  2181  	if (IS_ERR(edev)) {
688838442147d9 Maciej Purski    2018-02-27  2182  		if (PTR_ERR(edev) == -EPROBE_DEFER)
688838442147d9 Maciej Purski    2018-02-27  2183  			return -EPROBE_DEFER;
688838442147d9 Maciej Purski    2018-02-27  2184  		dev_err(ctx->dev, "Invalid or missing extcon\n");
688838442147d9 Maciej Purski    2018-02-27  2185  		return PTR_ERR(edev);
688838442147d9 Maciej Purski    2018-02-27  2186  	}
688838442147d9 Maciej Purski    2018-02-27  2187  
688838442147d9 Maciej Purski    2018-02-27  2188  	ctx->extcon = edev;
688838442147d9 Maciej Purski    2018-02-27  2189  	ctx->extcon_nb.notifier_call = sii8620_extcon_notifier;
688838442147d9 Maciej Purski    2018-02-27  2190  	INIT_WORK(&ctx->extcon_wq, sii8620_extcon_work);
688838442147d9 Maciej Purski    2018-02-27 @2191  	ret = extcon_register_notifier(edev, EXTCON_DISP_MHL, &ctx->extcon_nb);
688838442147d9 Maciej Purski    2018-02-27  2192  	if (ret) {
688838442147d9 Maciej Purski    2018-02-27  2193  		dev_err(ctx->dev, "failed to register notifier for MHL\n");
688838442147d9 Maciej Purski    2018-02-27  2194  		return ret;
688838442147d9 Maciej Purski    2018-02-27  2195  	}
688838442147d9 Maciej Purski    2018-02-27  2196  
688838442147d9 Maciej Purski    2018-02-27  2197  	return 0;
688838442147d9 Maciej Purski    2018-02-27  2198  }
688838442147d9 Maciej Purski    2018-02-27  2199  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2200  static inline struct sii8620 *bridge_to_sii8620(struct drm_bridge *bridge)
ce6e153f414a73 Andrzej Hajda    2016-10-10  2201  {
ce6e153f414a73 Andrzej Hajda    2016-10-10  2202  	return container_of(bridge, struct sii8620, bridge);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2203  }
ce6e153f414a73 Andrzej Hajda    2016-10-10  2204  
e25f1f7c94e16d Maciej Purski    2017-08-24  2205  static int sii8620_attach(struct drm_bridge *bridge)
e25f1f7c94e16d Maciej Purski    2017-08-24  2206  {
e25f1f7c94e16d Maciej Purski    2017-08-24  2207  	struct sii8620 *ctx = bridge_to_sii8620(bridge);
e25f1f7c94e16d Maciej Purski    2017-08-24  2208  
e25f1f7c94e16d Maciej Purski    2017-08-24  2209  	sii8620_init_rcp_input_dev(ctx);
e25f1f7c94e16d Maciej Purski    2017-08-24  2210  
e25f1f7c94e16d Maciej Purski    2017-08-24  2211  	return sii8620_clear_error(ctx);
e25f1f7c94e16d Maciej Purski    2017-08-24  2212  }
e25f1f7c94e16d Maciej Purski    2017-08-24  2213  
e25f1f7c94e16d Maciej Purski    2017-08-24  2214  static void sii8620_detach(struct drm_bridge *bridge)
e25f1f7c94e16d Maciej Purski    2017-08-24  2215  {
e25f1f7c94e16d Maciej Purski    2017-08-24  2216  	struct sii8620 *ctx = bridge_to_sii8620(bridge);
e25f1f7c94e16d Maciej Purski    2017-08-24  2217  
710abfe8ead247 Ronald Tschalär  2019-04-19  2218  	if (!IS_ENABLED(CONFIG_RC_CORE))
710abfe8ead247 Ronald Tschalär  2019-04-19  2219  		return;
710abfe8ead247 Ronald Tschalär  2019-04-19  2220  
e25f1f7c94e16d Maciej Purski    2017-08-24  2221  	rc_unregister_device(ctx->rc_dev);
e25f1f7c94e16d Maciej Purski    2017-08-24  2222  }
e25f1f7c94e16d Maciej Purski    2017-08-24  2223  
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2224  static int sii8620_is_packing_required(struct sii8620 *ctx,
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2225  				       const struct drm_display_mode *mode)
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2226  {
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2227  	int max_pclk, max_pclk_pp_mode;
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2228  
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2229  	if (sii8620_is_mhl3(ctx)) {
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2230  		max_pclk = MHL3_MAX_PCLK;
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2231  		max_pclk_pp_mode = MHL3_MAX_PCLK_PP_MODE;
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2232  	} else {
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2233  		max_pclk = MHL1_MAX_PCLK;
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2234  		max_pclk_pp_mode = MHL1_MAX_PCLK_PP_MODE;
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2235  	}
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2236  
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2237  	if (mode->clock < max_pclk)
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2238  		return 0;
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2239  	else if (mode->clock < max_pclk_pp_mode)
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2240  		return 1;
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2241  	else
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2242  		return -1;
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2243  }
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2244  
e7c2e4d368e2ef Marek Szyprowski 2017-11-09  2245  static enum drm_mode_status sii8620_mode_valid(struct drm_bridge *bridge,
e7c2e4d368e2ef Marek Szyprowski 2017-11-09  2246  					 const struct drm_display_mode *mode)
e7c2e4d368e2ef Marek Szyprowski 2017-11-09  2247  {
e7c2e4d368e2ef Marek Szyprowski 2017-11-09  2248  	struct sii8620 *ctx = bridge_to_sii8620(bridge);
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2249  	int pack_required = sii8620_is_packing_required(ctx, mode);
e7c2e4d368e2ef Marek Szyprowski 2017-11-09  2250  	bool can_pack = ctx->devcap[MHL_DCAP_VID_LINK_MODE] &
e7c2e4d368e2ef Marek Szyprowski 2017-11-09  2251  			MHL_DCAP_VID_LINK_PPIXEL;
e7c2e4d368e2ef Marek Szyprowski 2017-11-09  2252  
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2253  	switch (pack_required) {
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2254  	case 0:
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2255  		return MODE_OK;
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2256  	case 1:
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2257  		return (can_pack) ? MODE_OK : MODE_CLOCK_HIGH;
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2258  	default:
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2259  		return MODE_CLOCK_HIGH;
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2260  	}
e7c2e4d368e2ef Marek Szyprowski 2017-11-09  2261  }
e7c2e4d368e2ef Marek Szyprowski 2017-11-09  2262  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2263  static bool sii8620_mode_fixup(struct drm_bridge *bridge,
ce6e153f414a73 Andrzej Hajda    2016-10-10  2264  			       const struct drm_display_mode *mode,
ce6e153f414a73 Andrzej Hajda    2016-10-10  2265  			       struct drm_display_mode *adjusted_mode)
ce6e153f414a73 Andrzej Hajda    2016-10-10  2266  {
ce6e153f414a73 Andrzej Hajda    2016-10-10  2267  	struct sii8620 *ctx = bridge_to_sii8620(bridge);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2268  
bf1722cab55a32 Andrzej Hajda    2017-02-01  2269  	mutex_lock(&ctx->lock);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2270  
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2271  	ctx->use_packed_pixel = sii8620_is_packing_required(ctx, adjusted_mode);
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2272  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2273  	mutex_unlock(&ctx->lock);
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2274  
ecba7cfa3afbe4 Maciej Purski    2018-02-02  2275  	return true;
ce6e153f414a73 Andrzej Hajda    2016-10-10  2276  }
ce6e153f414a73 Andrzej Hajda    2016-10-10  2277  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2278  static const struct drm_bridge_funcs sii8620_bridge_funcs = {
e25f1f7c94e16d Maciej Purski    2017-08-24  2279  	.attach = sii8620_attach,
e25f1f7c94e16d Maciej Purski    2017-08-24  2280  	.detach = sii8620_detach,
ce6e153f414a73 Andrzej Hajda    2016-10-10  2281  	.mode_fixup = sii8620_mode_fixup,
e7c2e4d368e2ef Marek Szyprowski 2017-11-09  2282  	.mode_valid = sii8620_mode_valid,
ce6e153f414a73 Andrzej Hajda    2016-10-10  2283  };
ce6e153f414a73 Andrzej Hajda    2016-10-10  2284  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2285  static int sii8620_probe(struct i2c_client *client,
ce6e153f414a73 Andrzej Hajda    2016-10-10  2286  			 const struct i2c_device_id *id)
ce6e153f414a73 Andrzej Hajda    2016-10-10  2287  {
ce6e153f414a73 Andrzej Hajda    2016-10-10  2288  	struct device *dev = &client->dev;
ce6e153f414a73 Andrzej Hajda    2016-10-10  2289  	struct sii8620 *ctx;
ce6e153f414a73 Andrzej Hajda    2016-10-10  2290  	int ret;
ce6e153f414a73 Andrzej Hajda    2016-10-10  2291  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2292  	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2293  	if (!ctx)
ce6e153f414a73 Andrzej Hajda    2016-10-10  2294  		return -ENOMEM;
ce6e153f414a73 Andrzej Hajda    2016-10-10  2295  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2296  	ctx->dev = dev;
ce6e153f414a73 Andrzej Hajda    2016-10-10  2297  	mutex_init(&ctx->lock);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2298  	INIT_LIST_HEAD(&ctx->mt_queue);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2299  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2300  	ctx->clk_xtal = devm_clk_get(dev, "xtal");
ce6e153f414a73 Andrzej Hajda    2016-10-10  2301  	if (IS_ERR(ctx->clk_xtal)) {
ce6e153f414a73 Andrzej Hajda    2016-10-10  2302  		dev_err(dev, "failed to get xtal clock from DT\n");
ce6e153f414a73 Andrzej Hajda    2016-10-10  2303  		return PTR_ERR(ctx->clk_xtal);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2304  	}
ce6e153f414a73 Andrzej Hajda    2016-10-10  2305  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2306  	if (!client->irq) {
ce6e153f414a73 Andrzej Hajda    2016-10-10  2307  		dev_err(dev, "no irq provided\n");
ce6e153f414a73 Andrzej Hajda    2016-10-10  2308  		return -EINVAL;
ce6e153f414a73 Andrzej Hajda    2016-10-10  2309  	}
ce6e153f414a73 Andrzej Hajda    2016-10-10  2310  	irq_set_status_flags(client->irq, IRQ_NOAUTOEN);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2311  	ret = devm_request_threaded_irq(dev, client->irq, NULL,
ce6e153f414a73 Andrzej Hajda    2016-10-10  2312  					sii8620_irq_thread,
ce6e153f414a73 Andrzej Hajda    2016-10-10  2313  					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
ce6e153f414a73 Andrzej Hajda    2016-10-10  2314  					"sii8620", ctx);
e0ba12ea5e1329 Andrzej Hajda    2017-02-22  2315  	if (ret < 0) {
e0ba12ea5e1329 Andrzej Hajda    2017-02-22  2316  		dev_err(dev, "failed to install IRQ handler\n");
e0ba12ea5e1329 Andrzej Hajda    2017-02-22  2317  		return ret;
e0ba12ea5e1329 Andrzej Hajda    2017-02-22  2318  	}
ce6e153f414a73 Andrzej Hajda    2016-10-10  2319  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2320  	ctx->gpio_reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2321  	if (IS_ERR(ctx->gpio_reset)) {
ce6e153f414a73 Andrzej Hajda    2016-10-10  2322  		dev_err(dev, "failed to get reset gpio from DT\n");
ce6e153f414a73 Andrzej Hajda    2016-10-10  2323  		return PTR_ERR(ctx->gpio_reset);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2324  	}
ce6e153f414a73 Andrzej Hajda    2016-10-10  2325  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2326  	ctx->supplies[0].supply = "cvcc10";
ce6e153f414a73 Andrzej Hajda    2016-10-10  2327  	ctx->supplies[1].supply = "iovcc18";
ce6e153f414a73 Andrzej Hajda    2016-10-10  2328  	ret = devm_regulator_bulk_get(dev, 2, ctx->supplies);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2329  	if (ret)
ce6e153f414a73 Andrzej Hajda    2016-10-10  2330  		return ret;
ce6e153f414a73 Andrzej Hajda    2016-10-10  2331  
688838442147d9 Maciej Purski    2018-02-27  2332  	ret = sii8620_extcon_init(ctx);
688838442147d9 Maciej Purski    2018-02-27  2333  	if (ret < 0) {
688838442147d9 Maciej Purski    2018-02-27  2334  		dev_err(ctx->dev, "failed to initialize EXTCON\n");
688838442147d9 Maciej Purski    2018-02-27  2335  		return ret;
688838442147d9 Maciej Purski    2018-02-27  2336  	}
688838442147d9 Maciej Purski    2018-02-27  2337  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2338  	i2c_set_clientdata(client, ctx);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2339  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2340  	ctx->bridge.funcs = &sii8620_bridge_funcs;
ce6e153f414a73 Andrzej Hajda    2016-10-10  2341  	ctx->bridge.of_node = dev->of_node;
ce6e153f414a73 Andrzej Hajda    2016-10-10  2342  	drm_bridge_add(&ctx->bridge);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2343  
688838442147d9 Maciej Purski    2018-02-27  2344  	if (!ctx->extcon)
ce6e153f414a73 Andrzej Hajda    2016-10-10  2345  		sii8620_cable_in(ctx);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2346  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2347  	return 0;
ce6e153f414a73 Andrzej Hajda    2016-10-10  2348  }
ce6e153f414a73 Andrzej Hajda    2016-10-10  2349  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2350  static int sii8620_remove(struct i2c_client *client)
ce6e153f414a73 Andrzej Hajda    2016-10-10  2351  {
ce6e153f414a73 Andrzej Hajda    2016-10-10  2352  	struct sii8620 *ctx = i2c_get_clientdata(client);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2353  
688838442147d9 Maciej Purski    2018-02-27  2354  	if (ctx->extcon) {
688838442147d9 Maciej Purski    2018-02-27 @2355  		extcon_unregister_notifier(ctx->extcon, EXTCON_DISP_MHL,
688838442147d9 Maciej Purski    2018-02-27  2356  					   &ctx->extcon_nb);
688838442147d9 Maciej Purski    2018-02-27  2357  		flush_work(&ctx->extcon_wq);
688838442147d9 Maciej Purski    2018-02-27  2358  		if (ctx->cable_state > 0)
688838442147d9 Maciej Purski    2018-02-27  2359  			sii8620_cable_out(ctx);
688838442147d9 Maciej Purski    2018-02-27  2360  	} else {
688838442147d9 Maciej Purski    2018-02-27  2361  		sii8620_cable_out(ctx);
688838442147d9 Maciej Purski    2018-02-27  2362  	}
e25f1f7c94e16d Maciej Purski    2017-08-24  2363  	drm_bridge_remove(&ctx->bridge);
ce6e153f414a73 Andrzej Hajda    2016-10-10  2364  
ce6e153f414a73 Andrzej Hajda    2016-10-10  2365  	return 0;
ce6e153f414a73 Andrzej Hajda    2016-10-10  2366  }
ce6e153f414a73 Andrzej Hajda    2016-10-10  2367  

:::::: The code at line 2355 was first introduced by commit
:::::: 688838442147d9dd94c2ef7c2c31a35cf150c5fa drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL

:::::: TO: Maciej Purski <m.purski@samsung.com>
:::::: CC: Chanwoo Choi <cw00.choi@samsung.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--qIPawLzV4dNV95Tt
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
nwEA

--qIPawLzV4dNV95Tt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

--qIPawLzV4dNV95Tt--

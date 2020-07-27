Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5A1C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 04:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76E9A206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 04:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgG0EZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 00:25:21 -0400
Received: from mga04.intel.com ([192.55.52.120]:29583 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbgG0EZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 00:25:21 -0400
IronPort-SDR: 0thcq0fn7ladLHvsuqYG2iztutwc/WVjbT5daVPSkofBKCgvPRwT/BKzb43pj39k0p4dRTaEK7
 8rDDiz9ad+Ag==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="148426378"
X-IronPort-AV: E=Sophos;i="5.75,401,1589266800"; 
   d="gz'50?scan'50,208,50";a="148426378"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2020 21:06:16 -0700
IronPort-SDR: u2CmiqxoPgiiOVTlxhzuxnJ/Bsf2gCuxuqh2nnKGh7ykBCuXfROR7cjl2Vuf9kQs1wcCB3yvUn
 vNYn5eUtDLBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,401,1589266800"; 
   d="gz'50?scan'50,208,50";a="321664161"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jul 2020 21:06:14 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jzuOz-0001n1-H3; Mon, 27 Jul 2020 04:06:13 +0000
Date:   Mon, 27 Jul 2020 12:05:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/gpu/drm/bridge/sil-sii8620.c:2355: undefined reference to
 `extcon_unregister_notifier'
Message-ID: <202007271219.isooCFOr%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Masahiro,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   92ed301919932f777713b9172e525674157e983d
commit: def2fbffe62c00c330c7f41584a356001179c59c kconfig: allow symbols implied by y to become m
date:   5 months ago
config: i386-randconfig-r014-20200727 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-14) 9.3.0
reproduce (this is a W=1 build):
        git checkout def2fbffe62c00c330c7f41584a356001179c59c
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/gpu/drm/bridge/sil-sii8620.o: in function `sii8620_remove':
>> drivers/gpu/drm/bridge/sil-sii8620.c:2355: undefined reference to `extcon_unregister_notifier'
   ld: drivers/gpu/drm/bridge/sil-sii8620.o: in function `sii8620_extcon_init':
>> drivers/gpu/drm/bridge/sil-sii8620.c:2179: undefined reference to `extcon_find_edev_by_node'
>> ld: drivers/gpu/drm/bridge/sil-sii8620.c:2191: undefined reference to `extcon_register_notifier'
   ld: drivers/gpu/drm/bridge/sil-sii8620.o: in function `sii8620_extcon_work':
>> drivers/gpu/drm/bridge/sil-sii8620.c:2139: undefined reference to `extcon_get_state'

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

--IS0zKkzwUGydFO0o
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICK5KHl8AAy5jb25maWcAjFzbc9w2r3/vX7GTvrQP7edb3PSc8QNFUSt2JVEhpbXXLxrX
2aSeOnaOL1+b//4ApC6kBG7S6bReAryDwA8gqB9/+HHFXl8eP9+83N3e3N9/XX3aP+yfbl72
H1Yf7+73/7tK1apSzUqksvkVmIu7h9d//3N3+u589fbX81+Pfnm6PVtt9k8P+/sVf3z4ePfp
FWrfPT788OMP8O+PUPj5CzT09D+rT7e3v/y++ind/3l387D6/ddTqH189rP7C3i5qjK57jjv
pOnWnF98HYrgR7cV2khVXfx+dHp0NPIWrFqPpCOvCc6qrpDVZmoECnNmOmbKbq0aRRJkBXXE
gnTJdNWVbJeIrq1kJRvJCnkt0olR6vfdpdJed0kri7SRpegalhSiM0o3E7XJtWAp9Jcp+A+w
GKxqF2xtN+B+9bx/ef0yLQt224lq2zG9hpmVsrk4PcH17UeqylpCN40wzeruefXw+IItDLUL
xVkxrNObN1Rxx1p/Vez4O8OKxuPP2VZ0G6ErUXTra1lP7D4lAcoJTSquS0ZTrq5jNVSMcDYR
wjGNq+IPyF+VOQMO6xD96vpwbXWYfEbsSCoy1hZNlyvTVKwUF29+enh82P/8ZqpvdmYra062
XSsjr7ryfStaQbTOtTKmK0Wp9K5jTcN47q9La0QhE7Jh1sJJJ1q0S880zx0HjA1EpxiEFuR/
9fz65/PX55f950lo16ISWnJ7PGqtEu9o+SSTq0uaIrJM8EZi11kGR9Bslny1qFJZ2TNIN1LK
tWYNSj5J5rkvyFiSqpLJiirrcik0rsIu0hVrNOwLrAycrEZpmksLI/TWDqkrVSrCnjKluUh7
FQETm6imZtqIfqLjjvktpyJp15kJd3b/8GH1+HG2R5MKVXxjVAt9gp5reJ4qr0e74T5Lyhp2
gIxaylOfHmULKhMqi65gpun4jheEMFh9uZ1ka0a27YmtqBpzkNglWrGUQ0eH2UrYUJb+0ZJ8
pTJdW+OQByFv7j7vn54pOW8k33SqEiDIXlP5NcimliqV3N+vSiFFpoUgD6AlUwdQrnOUHLtI
2tgW+51dDMzTE1qIsm6g1YrSEwN5q4q2apje+QPtiQeqcQW1huXhdfuf5ub579ULDGd1A0N7
frl5eV7d3N4+vj683D18mi0YVOgYt204MR97RlG2sjCRybVKTIp6hQtQdsDakExoXE3DGkMr
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
4BnBbovlAQA=

--IS0zKkzwUGydFO0o--

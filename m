Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC23C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81E19206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389536AbgDNOSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:18:48 -0400
Received: from mga09.intel.com ([134.134.136.24]:2867 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389449AbgDNOSm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:18:42 -0400
IronPort-SDR: n43S6aWBfOIE+rassvK5ChimVM5f/sKoFm/U5zFWXK4ExS4a4hx7GQ8lmrbqydVkkSX/Slg1xB
 LxL/XMBsT7QA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 07:18:41 -0700
IronPort-SDR: 8WT6N8GvHPslDndi0ySiMxgySi7g+kqKVAHKVdF4HU1IZhPuzfzp4N1R6P0bjWy4k/uyJl34Qx
 bB8G2jheDpbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; 
   d="scan'208";a="288229034"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 14 Apr 2020 07:18:39 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jOMOc-0000XZ-F6; Tue, 14 Apr 2020 22:18:38 +0800
Date:   Tue, 14 Apr 2020 22:17:42 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Maxime Ripard <mripard@kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: drivers/gpu/drm/bridge/display-connector.c:34:48: warning: Clarify
 calculation precedence for '&' and '?'. [clarifyCalculation]
Message-ID: <202004142240.uydqaASd%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8f3d9f354286745c751374f5f1fcafee6b3f3136
commit: 0c275c30176b2e7871c6ac5fb0ed548f81e0fa27 drm/bridge: Add bridge driver for display connectors
date:   7 weeks ago

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> drivers/gpu/drm/ttm/ttm_bo.c:409:9: warning: Identical condition and return expression 'r', return value is always 0 [identicalConditionAfterEarlyExit]
    return r;
           ^
   drivers/gpu/drm/ttm/ttm_bo.c:396:6: note: If condition 'r' is true, the function will return/exit
    if (r)
        ^
   drivers/gpu/drm/ttm/ttm_bo.c:409:9: note: Returning identical expression 'r'
    return r;
           ^
   drivers/gpu/drm/ttm/ttm_bo.c:100:9: warning: The scope of the variable 'ret' can be reduced. [variableScope]
    int i, ret, mem_type;
           ^
   drivers/gpu/drm/ttm/ttm_bo.c:572:6: warning: The scope of the variable 'ret' can be reduced. [variableScope]
    int ret;
        ^
   drivers/gpu/drm/ttm/ttm_bo.c:913:6: warning: The scope of the variable 'ret' can be reduced. [variableScope]
    int ret;
        ^
   drivers/gpu/drm/ttm/ttm_bo.c:1241:7: warning: The scope of the variable 'locked' can be reduced. [variableScope]
    bool locked;
         ^
   drivers/gpu/drm/ttm/ttm_bo.c:1623:31: warning: The scope of the variable 'man' can be reduced. [variableScope]
    struct ttm_mem_type_manager *man;
                                 ^
   drivers/gpu/drm/ttm/ttm_bo.c:1822:28: warning: Local variable 'ctx' shadows outer argument [shadowArgument]
     struct ttm_operation_ctx ctx = { false, false };
                              ^
   drivers/gpu/drm/ttm/ttm_bo.c:1775:74: note: Shadowed declaration
   int ttm_bo_swapout(struct ttm_bo_global *glob, struct ttm_operation_ctx *ctx)
                                                                            ^
   drivers/gpu/drm/ttm/ttm_bo.c:1822:28: note: Shadow variable
     struct ttm_operation_ctx ctx = { false, false };
                              ^
--
>> drivers/gpu/drm/drm_bridge.c:1006:7: warning: Local variable 'ret' shadows outer variable [shadowVariable]
     int ret;
         ^
   drivers/gpu/drm/drm_bridge.c:994:6: note: Shadowed declaration
    int ret;
        ^
   drivers/gpu/drm/drm_bridge.c:1006:7: note: Shadow variable
     int ret;
         ^
--
>> drivers/gpu/drm/bridge/display-connector.c:34:48: warning: Clarify calculation precedence for '&' and '?'. [clarifyCalculation]
    return flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR ? 0 : -EINVAL;
                                                  ^
--
>> drivers/gpu/drm/tidss/tidss_scale_coefs.c:159:15: warning: struct member 'Anonymous0::name' is never used. [unusedStructMember]
     const char *name;
                 ^
--
   drivers/gpu/drm/tidss/tidss_dispc.c:1929:6: warning: The scope of the variable 'ret' can be reduced. [variableScope]
    int ret;
        ^
>> drivers/gpu/drm/tidss/tidss_dispc.c:2312:11: warning: Shifting signed 32-bit value by 31 bits is implementation-defined behaviour [shiftTooManyBitsSigned]
      v |= 1 << 31;
             ^

vim +34 drivers/gpu/drm/bridge/display-connector.c

    30	
    31	static int display_connector_attach(struct drm_bridge *bridge,
    32					    enum drm_bridge_attach_flags flags)
    33	{
  > 34		return flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR ? 0 : -EINVAL;
    35	}
    36	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

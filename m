Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99189C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 01:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 653AF207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 01:49:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbgGaBtX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 21:49:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:50155 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbgGaBtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 21:49:22 -0400
IronPort-SDR: fyFmrMR0subfLqxqLCiz9LjMQ6a/g8m63tWi/1TRX8kKuUSzZM55ramUvpfWEv8Lpzm0OaRr/I
 ZVsmo8Zl5vag==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="139279544"
X-IronPort-AV: E=Sophos;i="5.75,416,1589266800"; 
   d="scan'208";a="139279544"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 18:49:18 -0700
IronPort-SDR: I6+Dm8/goDd6DttjG0HdbgKShGZmGenR14LqZjbNDESfKCzluClDcY2VPzWB8Wp7tkM5jFWm+9
 G+hHU+KF0Wtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,416,1589266800"; 
   d="scan'208";a="330929191"
Received: from lkp-server02.sh.intel.com (HELO d4d86dd808e0) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 30 Jul 2020 18:49:16 -0700
Received: from kbuild by d4d86dd808e0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k1KAd-0000NU-Qj; Fri, 31 Jul 2020 01:49:15 +0000
Date:   Fri, 31 Jul 2020 09:48:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Evan Quan <evan.quan@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:1186:21: warning: Variable
 'adev->in_hibernate' is reassigned a value before the old one has been used.
Message-ID: <202007310904.RMLh8Rsr%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e2c46b5762c616c249201688d3b9846627f78d2c
commit: b2b6290a23986a5c88384887b8a589a3c4ebe292 drm/amdgpu: enable hibernate support on Navi1X
date:   3 months ago
compiler: arc-elf-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

   In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/navi10_ppt.c:
>> drivers/gpu/drm/amd/powerplay/navi10_ppt.c:728:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:719:6: note: first condition
    if (ret)
        ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:728:9: note: second condition
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1006:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1001:6: note: first condition
    if (ret)
        ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1006:9: note: second condition
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1208:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1203:6: note: first condition
    if (ret)
        ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1208:9: note: second condition
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1226:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1220:6: note: first condition
    if (ret)
        ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1226:9: note: second condition
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1695:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1692:6: note: first condition
    if (ret)
        ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1695:9: note: second condition
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1763:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1760:6: note: first condition
    if (ret)
        ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1763:9: note: second condition
    return ret;
           ^
>> drivers/gpu/drm/amd/powerplay/navi10_ppt.c:887:12: warning: %u in format string (no. 3) requires 'unsigned int' but the argument type is 'signed int'. [invalidPrintfArgType_uint]
      size += sprintf(buf + size, "%d: %uMHz @ %umVn", i, curve_settings[0], curve_settings[1] / NAVI10_VOLTAGE_SCALE);
              ^
>> drivers/gpu/drm/amd/powerplay/navi10_ppt.c:918:12: warning: %d in format string (no. 1) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
      size += sprintf(buf + size, "VDDC_CURVE_VOLT[0]: %7dmV %11dmVn",
              ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:918:12: warning: %d in format string (no. 2) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
      size += sprintf(buf + size, "VDDC_CURVE_VOLT[0]: %7dmV %11dmVn",
              ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:926:12: warning: %d in format string (no. 1) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
      size += sprintf(buf + size, "VDDC_CURVE_VOLT[1]: %7dmV %11dmVn",
              ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:926:12: warning: %d in format string (no. 2) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
      size += sprintf(buf + size, "VDDC_CURVE_VOLT[1]: %7dmV %11dmVn",
              ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:934:12: warning: %d in format string (no. 1) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
      size += sprintf(buf + size, "VDDC_CURVE_VOLT[2]: %7dmV %11dmVn",
              ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:934:12: warning: %d in format string (no. 2) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
      size += sprintf(buf + size, "VDDC_CURVE_VOLT[2]: %7dmV %11dmVn",
              ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1277:11: warning: %d in format string (no. 1) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
     size += sprintf(buf + size, "%2d %14s%s:n",
             ^
>> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c:811:6: warning: Variable 'res' is reassigned a value before the old one has been used. 'break;' missing? [redundantAssignInSwitch]
    res = 0;
        ^
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c:768:0: note: Variable 'res' is reassigned a value before the old one has been used. 'break;' missing?
    int res = -ENODEV;
   ^
   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c:811:6: note: Variable 'res' is reassigned a value before the old one has been used. 'break;' missing?
    res = 0;
        ^
>> drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c:1247:33: warning: Variable 'ctx->dc->caps.max_slave_planes' is reassigned a value before the old one has been used. [redundantAssignment]
    ctx->dc->caps.max_slave_planes = 1;
                                   ^
   drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c:1246:33: note: Variable 'ctx->dc->caps.max_slave_planes' is reassigned a value before the old one has been used.
    ctx->dc->caps.max_slave_planes = 1;
                                   ^
   drivers/gpu/drm/amd/display/dc/dce110/dce110_resource.c:1247:33: note: Variable 'ctx->dc->caps.max_slave_planes' is reassigned a value before the old one has been used.
    ctx->dc->caps.max_slave_planes = 1;
                                   ^
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_resource.c:
>> drivers/gpu/drm/amd/display/dc/core/dc_resource.c:2355:10: warning: Variable 'support' is reassigned a value before the old one has been used. 'break;' missing? [redundantAssignInSwitch]
    support = stream->content_support;
            ^
   drivers/gpu/drm/amd/display/dc/core/dc_resource.c:2251:0: note: Variable 'support' is reassigned a value before the old one has been used. 'break;' missing?
    union display_content_support support = {0};
   ^
   drivers/gpu/drm/amd/display/dc/core/dc_resource.c:2355:10: note: Variable 'support' is reassigned a value before the old one has been used. 'break;' missing?
    support = stream->content_support;
            ^
>> drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c:1897:15: warning: Variable 'max_link_cap' is reassigned a value before the old one has been used. [redundantAssignment]
    max_link_cap = get_max_link_cap(link);
                 ^
   drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c:1877:0: note: Variable 'max_link_cap' is reassigned a value before the old one has been used.
    struct dc_link_settings max_link_cap = {0};
   ^
   drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c:1897:15: note: Variable 'max_link_cap' is reassigned a value before the old one has been used.
    max_link_cap = get_max_link_cap(link);
                 ^
>> drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c:1919:24: warning: Variable 'initial_link_settings' is reassigned a value before the old one has been used. [redundantAssignment]
    initial_link_settings = get_common_supported_link_settings(
                          ^
   drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c:1880:0: note: Variable 'initial_link_settings' is reassigned a value before the old one has been used.
    struct dc_link_settings initial_link_settings = {0};
   ^
   drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c:1919:24: note: Variable 'initial_link_settings' is reassigned a value before the old one has been used.
    initial_link_settings = get_common_supported_link_settings(
                          ^
   drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c:2030:15: warning: Variable 'max_link_cap' is reassigned a value before the old one has been used. [redundantAssignment]
    max_link_cap = get_max_link_cap(link);
                 ^
   drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c:2028:0: note: Variable 'max_link_cap' is reassigned a value before the old one has been used.
    struct dc_link_settings max_link_cap = {0};
   ^
   drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c:2030:15: note: Variable 'max_link_cap' is reassigned a value before the old one has been used.
    max_link_cap = get_max_link_cap(link);
                 ^
>> drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c:3491:10: warning: Variable 'status' is reassigned a value before the old one has been used. [redundantAssignment]
     status = core_link_read_dpcd(
            ^
   drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c:3486:10: note: Variable 'status' is reassigned a value before the old one has been used.
     status = core_link_read_dpcd(
            ^
   drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c:3491:10: note: Variable 'status' is reassigned a value before the old one has been used.
     status = core_link_read_dpcd(
            ^
   drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c:3496:10: warning: Variable 'status' is reassigned a value before the old one has been used. [redundantAssignment]
     status = core_link_read_dpcd(
            ^
   drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c:3491:10: note: Variable 'status' is reassigned a value before the old one has been used.
     status = core_link_read_dpcd(
            ^
   drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c:3496:10: note: Variable 'status' is reassigned a value before the old one has been used.
     status = core_link_read_dpcd(
            ^
>> drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:1186:21: warning: Variable 'adev->in_hibernate' is reassigned a value before the old one has been used. [redundantAssignment]
    adev->in_hibernate = false;
                       ^
   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:1184:21: note: Variable 'adev->in_hibernate' is reassigned a value before the old one has been used.
    adev->in_hibernate = true;
                       ^
   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:1186:21: note: Variable 'adev->in_hibernate' is reassigned a value before the old one has been used.
    adev->in_hibernate = false;
                       ^
>> drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:180:2: warning: Address of local auto-variable assigned to a function parameter. [autoVariables]
    *f = &fence->base;
    ^
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:524:17: warning: Boolean result is used in bitwise operation. Clarify expression with parentheses. [clarifyCondition]
    if (!(!!enable ^ !!amdgpu_ras_is_feature_enabled(adev, head)))
                   ^
   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:573:17: warning: Boolean result is used in bitwise operation. Clarify expression with parentheses. [clarifyCondition]
    if (!(!!enable ^ !!amdgpu_ras_is_feature_enabled(adev, head)))
                   ^
>> drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c:4589:9: warning: Identical condition 'r', second condition is always false [identicalConditionAfterEarlyExit]
    return r;
           ^
   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c:4586:6: note: first condition
    if (r)
        ^
   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c:4589:9: note: second condition
    return r;
           ^
>> drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:1113:9: warning: Identical condition 'r', second condition is always false [identicalConditionAfterEarlyExit]
    return r;
           ^
   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:1110:6: note: first condition
    if (r)
        ^
   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:1113:9: note: second condition
    return r;
           ^
>> drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:1313:40: warning: Clarify calculation precedence for '&' and '?'. [clarifyCalculation]
     info->prot_valid = protections & 0x7 ? true : false;
                                          ^
   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:1314:39: warning: Clarify calculation precedence for '&' and '?'. [clarifyCalculation]
     info->prot_read = protections & 0x8 ? true : false;
                                         ^
   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:1315:41: warning: Clarify calculation precedence for '&' and '?'. [clarifyCalculation]
     info->prot_write = protections & 0x10 ? true : false;
                                           ^
   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c:1316:40: warning: Clarify calculation precedence for '&' and '?'. [clarifyCalculation]
     info->prot_exec = protections & 0x20 ? true : false;
                                          ^
>> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1246:9: warning: Identical condition 'r', second condition is always false [identicalConditionAfterEarlyExit]
    return r;
           ^
   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1243:6: note: first condition
    if (r)
        ^
   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1246:9: note: second condition
    return r;
           ^
>> drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1497:40: warning: Clarify calculation precedence for '&' and '?'. [clarifyCalculation]
     info->prot_valid = protections & 0x7 ? true : false;
                                          ^
   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1498:39: warning: Clarify calculation precedence for '&' and '?'. [clarifyCalculation]
     info->prot_read = protections & 0x8 ? true : false;
                                         ^
   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1499:41: warning: Clarify calculation precedence for '&' and '?'. [clarifyCalculation]
     info->prot_write = protections & 0x10 ? true : false;
                                           ^
   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1500:40: warning: Clarify calculation precedence for '&' and '?'. [clarifyCalculation]
     info->prot_exec = protections & 0x20 ? true : false;
                                          ^
>> drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c:137:2: warning: Local variable tmp shadows outer variable [shadowVar]
    WREG32_SOC15_RLC(GC, 0, mmMC_VM_MX_L1_TLB_CNTL, tmp);
    ^
   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c:121:11: note: Shadowed declaration
    uint32_t tmp;
             ^
   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c:137:2: note: Shadow variable
    WREG32_SOC15_RLC(GC, 0, mmMC_VM_MX_L1_TLB_CNTL, tmp);
    ^
   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c:154:2: warning: Local variable tmp shadows outer variable [shadowVar]
    WREG32_SOC15_RLC(GC, 0, mmVM_L2_CNTL, tmp);
    ^
   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c:142:11: note: Shadowed declaration
    uint32_t tmp;
             ^
   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c:154:2: note: Shadow variable
    WREG32_SOC15_RLC(GC, 0, mmVM_L2_CNTL, tmp);
    ^
   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c:159:2: warning: Local variable tmp shadows outer variable [shadowVar]
    WREG32_SOC15_RLC(GC, 0, mmVM_L2_CNTL2, tmp);
    ^
   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c:142:11: note: Shadowed declaration
    uint32_t tmp;
             ^
   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c:159:2: note: Shadow variable
    WREG32_SOC15_RLC(GC, 0, mmVM_L2_CNTL2, tmp);
    ^
   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c:171:2: warning: Local variable tmp shadows outer variable [shadowVar]
    WREG32_SOC15_RLC(GC, 0, mmVM_L2_CNTL3, tmp);
    ^
   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c:142:11: note: Shadowed declaration
    uint32_t tmp;
             ^
   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c:171:2: note: Shadow variable
    WREG32_SOC15_RLC(GC, 0, mmVM_L2_CNTL3, tmp);
    ^
   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c:176:2: warning: Local variable tmp shadows outer variable [shadowVar]
    WREG32_SOC15_RLC(GC, 0, mmVM_L2_CNTL4, tmp);
    ^
   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c:142:11: note: Shadowed declaration
    uint32_t tmp;
             ^
   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c:176:2: note: Shadow variable
    WREG32_SOC15_RLC(GC, 0, mmVM_L2_CNTL4, tmp);
    ^
>> drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c:316:2: warning: Local variable i shadows outer variable [shadowVar]
    WREG32_SOC15_RLC(GC, 0, mmMC_VM_MX_L1_TLB_CNTL, tmp);
    ^
   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c:303:6: note: Shadowed declaration
    u32 i;
        ^
   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c:316:2: note: Shadow variable
    WREG32_SOC15_RLC(GC, 0, mmMC_VM_MX_L1_TLB_CNTL, tmp);
    ^
   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c:316:2: warning: Local variable tmp shadows outer variable [shadowVar]
    WREG32_SOC15_RLC(GC, 0, mmMC_VM_MX_L1_TLB_CNTL, tmp);
    ^
   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c:302:6: note: Shadowed declaration
    u32 tmp;
        ^
   drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c:316:2: note: Shadow variable
    WREG32_SOC15_RLC(GC, 0, mmMC_VM_MX_L1_TLB_CNTL, tmp);
    ^
>> drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:1180:4: warning: Variable 'r' is reassigned a value before the old one has been used. 'break;' missing? [redundantAssignInSwitch]
    r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VMC, VMC_1_0__SRCID__VM_FAULT,
      ^
   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:1112:4: note: Variable 'r' is reassigned a value before the old one has been used. 'break;' missing?
    r = amdgpu_atomfirmware_get_vram_info(adev,
      ^
   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:1180:4: note: Variable 'r' is reassigned a value before the old one has been used. 'break;' missing?
    r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VMC, VMC_1_0__SRCID__VM_FAULT,
      ^
>> drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:1117:7: warning: Variable 'err' is reassigned a value before the old one has been used. [redundantAssignment]
     err = request_firmware(&adev->gfx.mec_fw, fw_name, adev->dev);
         ^
   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:1070:6: note: Variable 'err' is reassigned a value before the old one has been used.
    err = amdgpu_ucode_validate(adev->gfx.rlc_fw);
        ^
   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:1117:7: note: Variable 'err' is reassigned a value before the old one has been used.
     err = request_firmware(&adev->gfx.mec_fw, fw_name, adev->dev);
         ^
>> drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:1896:7: warning: Variable 'ring' is reassigned a value before the old one has been used. [redundantAssignment]
    ring = &adev->gfx.compute_ring[ring_id];
         ^
   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:1894:0: note: Variable 'ring' is reassigned a value before the old one has been used.
    struct amdgpu_ring *ring = &adev->gfx.compute_ring[ring_id];
   ^
   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:1896:7: note: Variable 'ring' is reassigned a value before the old one has been used.
    ring = &adev->gfx.compute_ring[ring_id];
         ^
>> drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c:4400:7: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
         PACKET3_MAP_QUEUES_ME(ring->me == 1 ? 0 : 1)); /* doorbell */
         ^
>> drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c:490:9: warning: Identical condition 'r', second condition is always false [identicalConditionAfterEarlyExit]
    return r;
           ^
   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c:487:6: note: first condition
    if (r)
        ^
   drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c:490:9: note: second condition
    return r;
           ^
>> drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:493:9: warning: Identical condition 'r', second condition is always false [identicalConditionAfterEarlyExit]
    return r;
           ^
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:490:6: note: first condition
    if (r)
        ^
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:493:9: note: second condition
    return r;
           ^
>> drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:446:12: warning: Local variable size shadows outer variable [shadowVar]
     unsigned size = amdgpu_bo_size(adev->vce.vcpu_bo);
              ^
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:429:11: note: Shadowed declaration
    unsigned size;
             ^
   drivers/gpu/drm/amd/amdgpu/vce_v4_0.c:446:12: note: Shadow variable
     unsigned size = amdgpu_bo_size(adev->vce.vcpu_bo);
              ^

vim +1186 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c

  1177	
  1178	static int amdgpu_pmops_freeze(struct device *dev)
  1179	{
  1180		struct drm_device *drm_dev = dev_get_drvdata(dev);
  1181		struct amdgpu_device *adev = drm_dev->dev_private;
  1182		int r;
  1183	
  1184		adev->in_hibernate = true;
  1185		r = amdgpu_device_suspend(drm_dev, true);
> 1186		adev->in_hibernate = false;
  1187		if (r)
  1188			return r;
  1189		return amdgpu_asic_reset(adev);
  1190	}
  1191	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

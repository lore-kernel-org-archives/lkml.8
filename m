Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56D2C43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 22:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A6DC20796
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 22:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgIEWSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 18:18:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:7738 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbgIEWSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 18:18:45 -0400
IronPort-SDR: 9YUz+rZcayffyJg8SLva3Z6iaJeYffBsTtgnAiQ4jBAZunoilHo8OnNwoIO4DPqtpYgJHaUo9E
 Cyi3MITipIkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9735"; a="155383516"
X-IronPort-AV: E=Sophos;i="5.76,395,1592895600"; 
   d="scan'208";a="155383516"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2020 15:18:43 -0700
IronPort-SDR: RkEpJvY1SF8z1oYZcT4/cGKDw475/I5SUUNk2N6VD3JTUjM1B9muqi2oDfvutbmodkqpCPeY1Y
 9yZrFAuIiW6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,395,1592895600"; 
   d="scan'208";a="327285690"
Received: from lkp-server01.sh.intel.com (HELO 4b5d6de90563) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 05 Sep 2020 15:18:42 -0700
Received: from kbuild by 4b5d6de90563 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kEgW9-00004l-HV; Sat, 05 Sep 2020 22:18:41 +0000
Date:   Sun, 6 Sep 2020 06:18:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:1855:42: warning:
 Uninitialized variable: fw_ver
Message-ID: <202009060624.Yoq9KfEs%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9322c47b21b9e05d7f9c037aa2c472e9f0dc7f3b
commit: 57430471e2fa60a412e220fa3014567e792aaa6f drm/amdgpu: Add support for USBC PD FW download
date:   6 months ago
compiler: hppa-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:1855:42: warning: Uninitialized variable: fw_ver [uninitvar]
    return snprintf(buf, PAGE_SIZE, "%xn", fw_ver);
                                            ^
>> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3769:9: warning: Identical condition 'r', second condition is always false [identicalConditionAfterEarlyExit]
    return r;
           ^
   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3766:6: note: first condition
    if (r)
        ^
   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3769:9: note: second condition
    return r;
           ^
>> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3904:7: warning: Identical inner 'if' condition is always true. [identicalInnerCondition]
     if (grbm_soft_reset) {
         ^
   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3894:6: note: outer condition: grbm_soft_reset
    if (grbm_soft_reset) {
        ^
   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3904:7: note: identical inner condition: grbm_soft_reset
     if (grbm_soft_reset) {
         ^
>> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:771:6: warning: Variable 'err' is reassigned a value before the old one has been used. [redundantAssignment]
    err = request_firmware(&adev->gfx.mec_fw, fw_name, adev->dev);
        ^
   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:719:7: note: Variable 'err' is reassigned a value before the old one has been used.
     err = amdgpu_ucode_validate(adev->gfx.rlc_fw);
         ^
   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:771:6: note: Variable 'err' is reassigned a value before the old one has been used.
    err = request_firmware(&adev->gfx.mec_fw, fw_name, adev->dev);
        ^
   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:1271:7: warning: Variable 'ring' is reassigned a value before the old one has been used. [redundantAssignment]
    ring = &adev->gfx.compute_ring[ring_id];
         ^
   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:1269:0: note: Variable 'ring' is reassigned a value before the old one has been used.
    struct amdgpu_ring *ring = &adev->gfx.compute_ring[ring_id];
   ^
   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:1271:7: note: Variable 'ring' is reassigned a value before the old one has been used.
    ring = &adev->gfx.compute_ring[ring_id];
         ^
>> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:2400:2: warning: Local variable i shadows outer variable [shadowVar]
    WREG32_SOC15_RLC(GC, 0, mmCP_ME_CNTL, tmp);
    ^
   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:2390:6: note: Shadowed declaration
    int i;
        ^
   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:2400:2: note: Shadow variable
    WREG32_SOC15_RLC(GC, 0, mmCP_ME_CNTL, tmp);
    ^
>> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:2400:2: warning: Local variable tmp shadows outer variable [shadowVar]
    WREG32_SOC15_RLC(GC, 0, mmCP_ME_CNTL, tmp);
    ^
   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:2391:6: note: Shadowed declaration
    u32 tmp = RREG32_SOC15(GC, 0, mmCP_ME_CNTL);
        ^
   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:2400:2: note: Shadow variable
    WREG32_SOC15_RLC(GC, 0, mmCP_ME_CNTL, tmp);
    ^
>> drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c:3797:6: warning: Unused variable: r [unusedVariable]
    int r;
        ^
>> drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c:687:22: warning: Either the condition 'allowed_vdd_mclk_table!=NULL' is redundant or there is possible null pointer dereference: allowed_vdd_mclk_table. [nullPointerRedundantCheck]
    PP_ASSERT_WITH_CODE(allowed_vdd_mclk_table->count >= 1,
                        ^
   drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c:704:45: note: Assuming that condition 'allowed_vdd_mclk_table!=NULL' is not redundant
    PP_ASSERT_WITH_CODE(allowed_vdd_mclk_table != NULL,
                                               ^
   drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c:687:22: note: Null pointer dereference
    PP_ASSERT_WITH_CODE(allowed_vdd_mclk_table->count >= 1,
                        ^
>> drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c:1745:6: warning: Either the condition 'table_info==NULL' is redundant or there is possible null pointer dereference: table_info. [nullPointerRedundantCheck]
        table_info->vddc_lookup_table, vv_id, &sclk)) {
        ^
   drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c:1748:21: note: Assuming that condition 'table_info==NULL' is not redundant
        if (table_info == NULL)
                       ^
   drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c:1745:6: note: Null pointer dereference
        table_info->vddc_lookup_table, vv_id, &sclk)) {
        ^
>> drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c:3708:25: warning: Variable 'data->force_pcie_gen' is reassigned a value before the old one has been used. 'break;' missing? [redundantAssignInSwitch]
      data->force_pcie_gen = smu7_get_current_pcie_speed(hwmgr);
                           ^
   drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c:3698:25: note: Variable 'data->force_pcie_gen' is reassigned a value before the old one has been used. 'break;' missing?
      data->force_pcie_gen = PP_PCIEGen2;
                           ^
   drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c:3708:25: note: Variable 'data->force_pcie_gen' is reassigned a value before the old one has been used. 'break;' missing?
      data->force_pcie_gen = smu7_get_current_pcie_speed(hwmgr);
                           ^
--
   In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/hwmgr/smu10_hwmgr.c:
>> drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c:917:12: warning: %d in format string (no. 1) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
      size += sprintf(buf + size, "%d: %uMhz %sn",
              ^
   drivers/gpu/drm/amd/powerplay/hwmgr/smu10_hwmgr.c:1266:11: warning: %d in format string (no. 1) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
     size += sprintf(buf + size, "%3d %14s%s: %14d %3d %10d %14dn",
             ^
>> drivers/gpu/drm/amd/powerplay/arcturus_ppt.c:1037:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/arcturus_ppt.c:1032:6: note: first condition
    if (ret)
        ^
   drivers/gpu/drm/amd/powerplay/arcturus_ppt.c:1037:9: note: second condition
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/arcturus_ppt.c:1057:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/arcturus_ppt.c:1051:6: note: first condition
    if (ret)
        ^
   drivers/gpu/drm/amd/powerplay/arcturus_ppt.c:1057:9: note: second condition
    return ret;
           ^
>> drivers/gpu/drm/amd/powerplay/arcturus_ppt.c:1387:11: warning: %d in format string (no. 1) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
     size += sprintf(buf + size, "%2d %14s%sn",
             ^
>> drivers/gpu/drm/amd/powerplay/navi10_ppt.c:723:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:714:6: note: first condition
    if (ret)
        ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:723:9: note: second condition
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1001:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:996:6: note: first condition
    if (ret)
        ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1001:9: note: second condition
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1203:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1198:6: note: first condition
    if (ret)
        ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1203:9: note: second condition
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1221:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1215:6: note: first condition
    if (ret)
        ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1221:9: note: second condition
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1690:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1687:6: note: first condition
    if (ret)
        ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1690:9: note: second condition
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1758:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1755:6: note: first condition
    if (ret)
        ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1758:9: note: second condition
    return ret;
           ^
>> drivers/gpu/drm/amd/powerplay/navi10_ppt.c:882:12: warning: %u in format string (no. 3) requires 'unsigned int' but the argument type is 'signed int'. [invalidPrintfArgType_uint]
      size += sprintf(buf + size, "%d: %uMHz @ %umVn", i, curve_settings[0], curve_settings[1] / NAVI10_VOLTAGE_SCALE);
              ^
>> drivers/gpu/drm/amd/powerplay/navi10_ppt.c:913:12: warning: %d in format string (no. 1) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
      size += sprintf(buf + size, "VDDC_CURVE_VOLT[0]: %7dmV %11dmVn",
              ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:913:12: warning: %d in format string (no. 2) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
      size += sprintf(buf + size, "VDDC_CURVE_VOLT[0]: %7dmV %11dmVn",
              ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:921:12: warning: %d in format string (no. 1) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
      size += sprintf(buf + size, "VDDC_CURVE_VOLT[1]: %7dmV %11dmVn",
              ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:921:12: warning: %d in format string (no. 2) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
      size += sprintf(buf + size, "VDDC_CURVE_VOLT[1]: %7dmV %11dmVn",
              ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:929:12: warning: %d in format string (no. 1) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
      size += sprintf(buf + size, "VDDC_CURVE_VOLT[2]: %7dmV %11dmVn",
              ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:929:12: warning: %d in format string (no. 2) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
      size += sprintf(buf + size, "VDDC_CURVE_VOLT[2]: %7dmV %11dmVn",
              ^
   drivers/gpu/drm/amd/powerplay/navi10_ppt.c:1272:11: warning: %d in format string (no. 1) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
     size += sprintf(buf + size, "%2d %14s%s:n",
             ^
>> drivers/gpu/drm/amd/display/dc/core/dc_link.c:398:10: warning: Variable 'present' is reassigned a value before the old one has been used. [redundantAssignment]
    present = (gpio_result == GPIO_RESULT_OK) && !clock_pin;
            ^
   drivers/gpu/drm/amd/display/dc/core/dc_link.c:358:0: note: Variable 'present' is reassigned a value before the old one has been used.
    bool present =
   ^
   drivers/gpu/drm/amd/display/dc/core/dc_link.c:398:10: note: Variable 'present' is reassigned a value before the old one has been used.
    present = (gpio_result == GPIO_RESULT_OK) && !clock_pin;
            ^
>> drivers/gpu/drm/amd/display/dc/core/dc_link.c:3342:6: warning: Uninitialized variable: link_stream [uninitvar]
    if (link_stream->dpms_off)
        ^
--
   In file included from drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:
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
>> drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c:3465:10: warning: Variable 'status' is reassigned a value before the old one has been used. [redundantAssignment]
     status = core_link_read_dpcd(
            ^
   drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c:3460:10: note: Variable 'status' is reassigned a value before the old one has been used.
     status = core_link_read_dpcd(
            ^
   drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c:3465:10: note: Variable 'status' is reassigned a value before the old one has been used.
     status = core_link_read_dpcd(
            ^
   drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c:3470:10: warning: Variable 'status' is reassigned a value before the old one has been used. [redundantAssignment]
     status = core_link_read_dpcd(
            ^
   drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c:3465:10: note: Variable 'status' is reassigned a value before the old one has been used.
     status = core_link_read_dpcd(
            ^
   drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c:3470:10: note: Variable 'status' is reassigned a value before the old one has been used.
     status = core_link_read_dpcd(
            ^

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=57430471e2fa60a412e220fa3014567e792aaa6f
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout 57430471e2fa60a412e220fa3014567e792aaa6f
vim +1855 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c

  1836	
  1837	static ssize_t psp_usbc_pd_fw_sysfs_read(struct device *dev,
  1838						 struct device_attribute *attr,
  1839						 char *buf)
  1840	{
  1841		struct drm_device *ddev = dev_get_drvdata(dev);
  1842		struct amdgpu_device *adev = ddev->dev_private;
  1843		uint32_t fw_ver;
  1844		int ret;
  1845	
  1846		mutex_lock(&adev->psp.mutex);
  1847		ret = psp_read_usbc_pd_fw(&adev->psp, &fw_ver);
  1848		mutex_unlock(&adev->psp.mutex);
  1849	
  1850		if (ret) {
  1851			DRM_ERROR("Failed to read USBC PD FW, err = %d", ret);
  1852			return ret;
  1853		}
  1854	
> 1855		return snprintf(buf, PAGE_SIZE, "%x\n", fw_ver);
  1856	}
  1857	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

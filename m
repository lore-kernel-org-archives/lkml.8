Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2926DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0932320774
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgHMTQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 15:16:34 -0400
Received: from mga04.intel.com ([192.55.52.120]:12215 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726167AbgHMTQe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 15:16:34 -0400
IronPort-SDR: TTNsQ9Oodb4O8rSyNRrqfqJlvtLdaOw6eRevMY/TzJGpUe2LaeczsEwBXeka/32lT7FNQI8Xeq
 freQ0bFy77XA==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="151724969"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="151724969"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 12:13:31 -0700
IronPort-SDR: 0aNgwSFFiICM0nTQwxhXDLPq8L/Quhmm1/08Lpq7SmDvpQeD5fXThANQnXAuxfPx6ufvoq36zO
 76gyRYLmCc+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; 
   d="scan'208";a="276936889"
Received: from lkp-server01.sh.intel.com (HELO 7f1ebb311643) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 13 Aug 2020 12:13:29 -0700
Received: from kbuild by 7f1ebb311643 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k6IfI-0000lX-I3; Thu, 13 Aug 2020 19:13:28 +0000
Date:   Fri, 14 Aug 2020 03:12:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leo Liu <leo.liu@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        James Zhu <James.Zhu@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c:354:9: warning: Identical
 condition 'ret', second condition is always false
Message-ID: <202008140340.h5fqwsWJ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dc06fe51d26efc100ac74121607c01a454867c91
commit: dfd57dbf44ddc70c90c76f83b2deb46e5dd40ce3 drm/amdgpu: add JPEG3.0 support for Sienna_Cichlid
date:   6 weeks ago
compiler: alpha-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

   In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/smumgr/ci_smumgr.c:
>> drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c:416:9: warning: Variable 'result' is reassigned a value before the old one has been used. [redundantAssignment]
    result = ci_get_dependency_volt_by_clk(hwmgr,
           ^
   drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c:413:9: note: Variable 'result' is reassigned a value before the old one has been used.
    result = ci_calculate_sclk_params(hwmgr, clock, level);
           ^
   drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c:416:9: note: Variable 'result' is reassigned a value before the old one has been used.
    result = ci_get_dependency_volt_by_clk(hwmgr,
           ^
   drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c:2235:9: warning: Variable 'result' is reassigned a value before the old one has been used. [redundantAssignment]
    result = ci_update_and_upload_mc_reg_table(hwmgr);
           ^
   drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c:2225:10: note: Variable 'result' is reassigned a value before the old one has been used.
     result = ci_copy_bytes_to_smc(
            ^
   drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c:2235:9: note: Variable 'result' is reassigned a value before the old one has been used.
    result = ci_update_and_upload_mc_reg_table(hwmgr);
           ^
>> drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c:2125:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c:2116:6: note: first condition
    if (ret)
        ^
   drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c:2125:9: note: second condition
    return ret;
           ^
>> drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c:3216:10: warning: %llx in format string (no. 1) requires 'unsigned long long' but the argument type is 'unsigned long'. [invalidPrintfArgType_uint]
    size += sprintf(buf + size, "Current ppfeatures: 0x%016llxn", features_enabled);
            ^
>> drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c:3296:12: warning: %u in format string (no. 1) requires 'unsigned int' but the argument type is 'signed int'. [invalidPrintfArgType_uint]
      size += sprintf(buf + size, "0: %uMhz * (DPM disabled)n",
              ^
   drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c:3314:12: warning: %u in format string (no. 1) requires 'unsigned int' but the argument type is 'signed int'. [invalidPrintfArgType_uint]
      size += sprintf(buf + size, "0: %uMhz * (DPM disabled)n",
              ^
   drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c:3332:12: warning: %u in format string (no. 1) requires 'unsigned int' but the argument type is 'signed int'. [invalidPrintfArgType_uint]
      size += sprintf(buf + size, "0: %uMhz * (DPM disabled)n",
              ^
   drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c:3362:12: warning: %u in format string (no. 1) requires 'unsigned int' but the argument type is 'signed int'. [invalidPrintfArgType_uint]
      size += sprintf(buf + size, "0: %uMhz * (DPM disabled)n",
              ^
   drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c:3452:12: warning: %u in format string (no. 1) requires 'unsigned int' but the argument type is 'signed int'. [invalidPrintfArgType_uint]
      size += sprintf(buf + size, "SCLK: %7uMhz %10uMhzn",
              ^
   drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c:3452:12: warning: %u in format string (no. 2) requires 'unsigned int' but the argument type is 'signed int'. [invalidPrintfArgType_uint]
      size += sprintf(buf + size, "SCLK: %7uMhz %10uMhzn",
              ^
   drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c:3458:12: warning: %u in format string (no. 1) requires 'unsigned int' but the argument type is 'signed int'. [invalidPrintfArgType_uint]
      size += sprintf(buf + size, "MCLK: %7uMhz %10uMhzn",
              ^
   drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c:3458:12: warning: %u in format string (no. 2) requires 'unsigned int' but the argument type is 'signed int'. [invalidPrintfArgType_uint]
      size += sprintf(buf + size, "MCLK: %7uMhz %10uMhzn",
              ^
   drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c:3469:12: warning: %u in format string (no. 1) requires 'unsigned int' but the argument type is 'signed int'. [invalidPrintfArgType_uint]
      size += sprintf(buf + size, "VDDC_CURVE_SCLK[0]: %7uMhz %10uMhzn",
              ^
   drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c:3469:12: warning: %u in format string (no. 2) requires 'unsigned int' but the argument type is 'signed int'. [invalidPrintfArgType_uint]
      size += sprintf(buf + size, "VDDC_CURVE_SCLK[0]: %7uMhz %10uMhzn",
              ^
   drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c:3475:12: warning: %u in format string (no. 1) requires 'unsigned int' but the argument type is 'signed int'. [invalidPrintfArgType_uint]
      size += sprintf(buf + size, "VDDC_CURVE_SCLK[1]: %7uMhz %10uMhzn",
              ^
   drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c:3475:12: warning: %u in format string (no. 2) requires 'unsigned int' but the argument type is 'signed int'. [invalidPrintfArgType_uint]
      size += sprintf(buf + size, "VDDC_CURVE_SCLK[1]: %7uMhz %10uMhzn",
              ^
   drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c:3481:12: warning: %u in format string (no. 1) requires 'unsigned int' but the argument type is 'signed int'. [invalidPrintfArgType_uint]
      size += sprintf(buf + size, "VDDC_CURVE_SCLK[2]: %7uMhz %10uMhzn",
              ^
   drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c:3481:12: warning: %u in format string (no. 2) requires 'unsigned int' but the argument type is 'signed int'. [invalidPrintfArgType_uint]
      size += sprintf(buf + size, "VDDC_CURVE_SCLK[2]: %7uMhz %10uMhzn",
              ^
>> drivers/gpu/drm/amd/powerplay/hwmgr/vega20_hwmgr.c:3946:11: warning: %d in format string (no. 1) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
     size += sprintf(buf + size, "%2d %14s%s:n",
             ^
>> drivers/gpu/drm/amd/powerplay/smu_v11_0.c:719:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/smu_v11_0.c:716:6: note: first condition
    if (ret)
        ^
   drivers/gpu/drm/amd/powerplay/smu_v11_0.c:719:9: note: second condition
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/smu_v11_0.c:1689:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/smu_v11_0.c:1686:6: note: first condition
    if (ret)
        ^
   drivers/gpu/drm/amd/powerplay/smu_v11_0.c:1689:9: note: second condition
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/smu_v11_0.c:1833:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/smu_v11_0.c:1828:6: note: first condition
    if (ret)
        ^
   drivers/gpu/drm/amd/powerplay/smu_v11_0.c:1833:9: note: second condition
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/smu_v11_0.c:1844:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/smu_v11_0.c:1841:6: note: first condition
    if (ret)
        ^
   drivers/gpu/drm/amd/powerplay/smu_v11_0.c:1844:9: note: second condition
    return ret;
           ^
>> drivers/gpu/drm/amd/powerplay/arcturus_ppt.c:1053:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/arcturus_ppt.c:1048:6: note: first condition
    if (ret)
        ^
   drivers/gpu/drm/amd/powerplay/arcturus_ppt.c:1053:9: note: second condition
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/arcturus_ppt.c:1073:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/arcturus_ppt.c:1067:6: note: first condition
    if (ret)
        ^
   drivers/gpu/drm/amd/powerplay/arcturus_ppt.c:1073:9: note: second condition
    return ret;
           ^
>> drivers/gpu/drm/amd/powerplay/arcturus_ppt.c:1402:11: warning: %d in format string (no. 1) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
     size += sprintf(buf + size, "%2d %14s%sn",
             ^
>> drivers/gpu/drm/amd/powerplay/arcturus_ppt.c:2292:9: warning: %llx in format string (no. 1) requires 'unsigned long long' but the argument type is 'unsigned long'. [invalidPrintfArgType_uint]
    size = sprintf(sn, "%llx", id);
           ^
>> drivers/gpu/drm/amd/powerplay/renoir_ppt.c:411:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/renoir_ppt.c:402:6: note: first condition
    if (ret)
        ^
   drivers/gpu/drm/amd/powerplay/renoir_ppt.c:411:9: note: second condition
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/renoir_ppt.c:726:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/gpu/drm/amd/powerplay/renoir_ppt.c:723:6: note: first condition
    if (ret)
        ^
   drivers/gpu/drm/amd/powerplay/renoir_ppt.c:726:9: note: second condition
    return ret;
           ^
>> drivers/gpu/drm/amd/powerplay/renoir_ppt.c:864:11: warning: %d in format string (no. 1) requires 'int' but the argument type is 'unsigned int'. [invalidPrintfArgType_sint]
     size += sprintf(buf + size, "%2d %14s%sn",
             ^
>> drivers/gpu/drm/amd/display/dc/bios/bios_parser.c:184:12: warning: Variable 'object_id' is reassigned a value before the old one has been used. [redundantAssignment]
    object_id = object_id_from_bios_object_id(id);
              ^
   drivers/gpu/drm/amd/display/dc/bios/bios_parser.c:162:0: note: Variable 'object_id' is reassigned a value before the old one has been used.
    struct graphics_object_id object_id = dal_graphics_object_id_init(
   ^
   drivers/gpu/drm/amd/display/dc/bios/bios_parser.c:184:12: note: Variable 'object_id' is reassigned a value before the old one has been used.
    object_id = object_id_from_bios_object_id(id);
              ^
>> drivers/gpu/drm/amd/display/dc/bios/bios_parser.c:1064:10: warning: Variable 'result' is reassigned a value before the old one has been used. [redundantAssignment]
     result = BP_RESULT_OK;
            ^
   drivers/gpu/drm/amd/display/dc/bios/bios_parser.c:1043:10: note: Variable 'result' is reassigned a value before the old one has been used.
     result = BP_RESULT_NORECORD;
            ^
   drivers/gpu/drm/amd/display/dc/bios/bios_parser.c:1064:10: note: Variable 'result' is reassigned a value before the old one has been used.
     result = BP_RESULT_OK;
            ^
>> drivers/gpu/drm/amd/display/dc/core/dc_link.c:400:10: warning: Variable 'present' is reassigned a value before the old one has been used. [redundantAssignment]
    present = (gpio_result == GPIO_RESULT_OK) && !clock_pin;
            ^
   drivers/gpu/drm/amd/display/dc/core/dc_link.c:359:0: note: Variable 'present' is reassigned a value before the old one has been used.
    bool present =
   ^
   drivers/gpu/drm/amd/display/dc/core/dc_link.c:400:10: note: Variable 'present' is reassigned a value before the old one has been used.
    present = (gpio_result == GPIO_RESULT_OK) && !clock_pin;
            ^
>> drivers/gpu/drm/amd/display/dc/core/dc_link.c:3486:6: warning: Uninitialized variable: link_stream [uninitvar]
    if (link_stream->dpms_off)
        ^
>> drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c:354:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c:351:6: note: first condition
    if (ret)
        ^
   drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c:354:9: note: second condition
    return ret;
           ^

vim +/ret +354 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c

   342	
   343	static int jpeg_v3_0_wait_for_idle(void *handle)
   344	{
   345		struct amdgpu_device *adev = (struct amdgpu_device *)handle;
   346		int ret = 0;
   347	
   348		SOC15_WAIT_ON_RREG(JPEG, 0, mmUVD_JRBC_STATUS,
   349			UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
   350			UVD_JRBC_STATUS__RB_JOB_DONE_MASK, ret);
   351		if (ret)
   352			return ret;
   353	
 > 354		return ret;
   355	}
   356	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

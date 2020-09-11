Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EEAC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 06:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06CFF221ED
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 06:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgIKG2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 02:28:49 -0400
Received: from foss.arm.com ([217.140.110.172]:53810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgIKG2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 02:28:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4F40F106F;
        Thu, 10 Sep 2020 23:28:48 -0700 (PDT)
Received: from [10.57.50.170] (unknown [10.57.50.170])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 24F8B3F68F;
        Thu, 10 Sep 2020 23:28:47 -0700 (PDT)
Subject: Re: [PATCH v5] perf: arm_dsu: Support DSU ACPI devices
To:     tuanphan@amperemail.onmicrosoft.com
Cc:     will@kernel.org, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1599694141-16056-1-git-send-email-tuanphan@os.amperecomputing.com>
 <202009102143.A4pW4A7I%lkp@intel.com>
 <C7729DCE-57C3-4ADD-AFD4-3992798F1FF9@amperemail.onmicrosoft.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <6b04416d-497b-4687-2c79-08d029cf758d@arm.com>
Date:   Fri, 11 Sep 2020 07:33:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <C7729DCE-57C3-4ADD-AFD4-3992798F1FF9@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/2020 08:07 PM, Tuan Phan wrote:
> Hi Will,
> 
>> On Sep 10, 2020, at 6:40 AM, kernel test robot <lkp@intel.com> wrote:
>>
>> Hi Tuan,
>>
>> Thank you for the patch! Perhaps something to improve:
>>
>> [auto build test WARNING on linus/master]
>> [also build test WARNING on v5.9-rc4 next-20200910]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Tuan-Phan/perf-arm_dsu-Support-DSU-ACPI-devices/20200910-105630
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git ab29a807a7ddaa7c84d2f4cb8d29e74e33759072
>> config: arm64-randconfig-r012-20200909 (attached as .config)
>> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 0a5dc7effb191eff740e0e7ae7bd8e1f6bdb3ad9)
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # install arm64 cross compiling tool for clang build
>>         # apt-get install binutils-aarch64-linux-gnu
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm64
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> drivers/perf/arm_dsu_pmu.c:799:36: warning: unused variable 'dsu_pmu_acpi_match' [-Wunused-const-variable]
>>    static const struct acpi_device_id dsu_pmu_acpi_match[] = {
>>                                       ^
>>    1 warning generated.
>>
> 
> Do you need me to fix this warning when CONFIG_ACPI not defined?

Yes, please. The kernel should compile fine in any config. Any compiler
warning is not good (unless the compiler is wrong).

Cheers
Suzuki

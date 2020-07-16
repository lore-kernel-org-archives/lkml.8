Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C23C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AF542071B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgGPAsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 20:48:54 -0400
Received: from mga09.intel.com ([134.134.136.24]:39137 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgGPAsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 20:48:53 -0400
IronPort-SDR: k6rYKA3Zr5yPUTi1H/uH6M6ccQTvSTdeB2esEqLIstswZ0QbB3GFs1P0GrMWAJOF+9kARPNfP4
 pHlBvawlDVJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9683"; a="150683262"
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; 
   d="scan'208";a="150683262"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 17:48:52 -0700
IronPort-SDR: Cd6FiDqz4Iz5Y9Hl5wdbZkTLPfSQzmi5prl7GFa7fzLtH6E0hPpx9b9EnMEboJ4Ee7RxEeAjej
 WeNfA149Bxfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,357,1589266800"; 
   d="scan'208";a="485918696"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jul 2020 17:48:50 -0700
Subject: Re: [kbuild-all] Re: [PATCH v5 06/11] remoteproc: stm32: Properly set
 co-processor state when attaching
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        kernel test robot <lkp@intel.com>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
References: <20200707213112.928383-7-mathieu.poirier@linaro.org>
 <202007150455.m7mLaFaF%lkp@intel.com>
 <CANLsYkwWe_zfpafBKNF10BEqV4w1tHTjrTOPUca36LkTD+Nu=Q@mail.gmail.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <c74cd2d3-6f7b-6781-2edb-eb1944ae8def@intel.com>
Date:   Thu, 16 Jul 2020 08:48:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CANLsYkwWe_zfpafBKNF10BEqV4w1tHTjrTOPUca36LkTD+Nu=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/16/20 6:19 AM, Mathieu Poirier wrote:
> Hi Robot,
>
> On Tue, 14 Jul 2020 at 14:31, kernel test robot <lkp@intel.com> wrote:
>> Hi Mathieu,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on linux/master]
>> [also build test ERROR on linus/master v5.8-rc5 next-20200714]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use  as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Mathieu-Poirier/remoteproc-stm32-Add-support-for-attaching-to-M4/20200708-053515
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 9ebcfadb0610322ac537dd7aa5d9cbc2b2894c68
>> config: arm-randconfig-r011-20200714 (attached as .config)
>> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 02946de3802d3bc65bc9f2eb9b8d4969b5a7add8)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install arm cross compiling tool for clang build
>>          # apt-get install binutils-arm-linux-gnueabi
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>>> drivers/remoteproc/stm32_rproc.c:697:18: error: use of undeclared identifier 'RPROC_DETACHED'
>>                     rproc->state = RPROC_DETACHED;
>>                                    ^
>>     1 error generated.
> This patchset depends on this one [1], something that is clearly
> stated in the cover letter.  Compiling this set on top of [1]
> generates no error.
>
> [1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=318275

Hi Mathieu,

Thanks for the feedback, the bot can't parse the base which links to another patchset,
and we can get the base commit if using 'git format-patch --base' to submit patch.

Best Regards,
Rong Chen

>
>> vim +/RPROC_DETACHED +697 drivers/remoteproc/stm32_rproc.c
>>
>>     661
>>     662
>>     663  static int stm32_rproc_probe(struct platform_device *pdev)
>>     664  {
>>     665          struct device *dev = &pdev->dev;
>>     666          struct stm32_rproc *ddata;
>>     667          struct device_node *np = dev->of_node;
>>     668          struct rproc *rproc;
>>     669          unsigned int state;
>>     670          int ret;
>>     671
>>     672          ret = dma_coerce_mask_and_coherent(dev, DMA_BIT_MASK(32));
>>     673          if (ret)
>>     674                  return ret;
>>     675
>>     676          rproc = rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*ddata));
>>     677          if (!rproc)
>>     678                  return -ENOMEM;
>>     679
>>     680          ddata = rproc->priv;
>>     681
>>     682          rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
>>     683
>>     684          ret = stm32_rproc_parse_dt(pdev, ddata, &rproc->auto_boot);
>>     685          if (ret)
>>     686                  goto free_rproc;
>>     687
>>     688          ret = stm32_rproc_of_memory_translations(pdev, ddata);
>>     689          if (ret)
>>     690                  goto free_rproc;
>>     691
>>     692          ret = stm32_rproc_get_m4_status(ddata, &state);
>>     693          if (ret)
>>     694                  goto free_rproc;
>>     695
>>     696          if (state == M4_STATE_CRUN)
>>   > 697                  rproc->state = RPROC_DETACHED;
>>     698
>>     699          rproc->has_iommu = false;
>>     700          ddata->workqueue = create_workqueue(dev_name(dev));
>>     701          if (!ddata->workqueue) {
>>     702                  dev_err(dev, "cannot create workqueue\n");
>>     703                  ret = -ENOMEM;
>>     704                  goto free_rproc;
>>     705          }
>>     706
>>     707          platform_set_drvdata(pdev, rproc);
>>     708
>>     709          ret = stm32_rproc_request_mbox(rproc);
>>     710          if (ret)
>>     711                  goto free_wkq;
>>     712
>>     713          ret = rproc_add(rproc);
>>     714          if (ret)
>>     715                  goto free_mb;
>>     716
>>     717          return 0;
>>     718
>>     719  free_mb:
>>     720          stm32_rproc_free_mbox(rproc);
>>     721  free_wkq:
>>     722          destroy_workqueue(ddata->workqueue);
>>     723  free_rproc:
>>     724          if (device_may_wakeup(dev)) {
>>     725                  dev_pm_clear_wake_irq(dev);
>>     726                  device_init_wakeup(dev, false);
>>     727          }
>>     728          rproc_free(rproc);
>>     729          return ret;
>>     730  }
>>     731
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org


Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C24C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 04:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3968F2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 04:17:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgE0ERA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 00:17:00 -0400
Received: from mail.loongson.cn ([114.242.206.163]:60880 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726961AbgE0ERA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 00:17:00 -0400
Received: from [10.130.0.52] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9AxJuqu6c1e1385AA--.411S3;
        Wed, 27 May 2020 12:16:47 +0800 (CST)
Subject: Re: [PATCH 2/2] clk: Remove CONFIG_ARCH_HISI check for subdir
 hisilicon
To:     kbuild test robot <lkp@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
References: <1590377516-32117-2-git-send-email-yangtiezhu@loongson.cn>
 <202005270245.sb1paW0C%lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <88bb8736-735e-cc74-8d62-901950c6af4b@loongson.cn>
Date:   Wed, 27 May 2020 12:16:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <202005270245.sb1paW0C%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9AxJuqu6c1e1385AA--.411S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAr13JryxWF1fKrW8Cw48Zwb_yoWrKw1kpa
        1kGFWxAw18JFW8WrZrJFWUuFyF9FW7ta48CFZ7ZryvqFn8G3y8tw40gr97WF4Ygr1kZw40
        g3y8Gw48u3yjyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
        1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
        6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7Mxk0xIA0c2IEe2xFo4CE
        bIxvr21lc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjfUe89NUUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/27/2020 02:55 AM, kbuild test robot wrote:
> Hi Tiezhu,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on clk/clk-next]
> [also build test ERROR on v5.7-rc7 next-20200526]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Tiezhu-Yang/clk-hisilicon-Use-correct-return-value-about-hisi_reset_init/20200525-113342
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
> config: i386-tinyconfig (attached as .config)

Hi,

Thanks for your report.

I find that both CONFIG_ARCH_HISI and CONFIG_COMPILE_TEST are not
set in .config, if one of them is set, the build will be success.

But when used with this patch and this .config, I think it is
better to check CONFIG_COMMON_CLK and CONFIG_CLKDEV_LOOKUP or
just check CONFIG_ARCH_HISI before build the following files
"clk.o clkgate-separated.o clkdivider-hi6220.o clk-hisi-phase.o"
in drivers/clk/hisilicon/Makefile to avoid the build failure.

I will verify it and then send v2.

Thanks,
Tiezhu Yang

> compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
> reproduce (this is a W=1 build):
>          # save the attached .config to linux build tree
>          make W=1 ARCH=i386
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
> ld: drivers/clk/hisilicon/clk.o: in function `hisi_clk_register_fixed_rate':
>>> clk.c:(.text+0x9e): undefined reference to `clk_register_fixed_rate'
>>> ld: clk.c:(.text+0xdf): undefined reference to `clk_unregister_fixed_rate'
> ld: drivers/clk/hisilicon/clk.o: in function `hisi_clk_register_fixed_factor':
>>> clk.c:(.text+0x117): undefined reference to `clk_register_fixed_factor'
>>> ld: clk.c:(.text+0x158): undefined reference to `clk_unregister_fixed_factor'
> ld: drivers/clk/hisilicon/clk.o: in function `hisi_clk_register_mux':
>>> clk.c:(.text+0x1cb): undefined reference to `clk_register_mux_table'
>>> ld: clk.c:(.text+0x1f2): undefined reference to `clk_register_clkdev'
>>> ld: clk.c:(.text+0x21a): undefined reference to `clk_unregister_mux'
> ld: drivers/clk/hisilicon/clk.o: in function `hisi_clk_register_divider':
>>> clk.c:(.text+0x2c9): undefined reference to `clk_register_divider_table'
> ld: clk.c:(.text+0x2e3): undefined reference to `clk_register_clkdev'
>>> ld: clk.c:(.text+0x311): undefined reference to `clk_unregister_divider'
> ld: drivers/clk/hisilicon/clk.o: in function `hisi_clk_register_gate':
>>> clk.c:(.text+0x36c): undefined reference to `clk_register_gate'
> ld: clk.c:(.text+0x393): undefined reference to `clk_register_clkdev'
>>> ld: clk.c:(.text+0x3bb): undefined reference to `clk_unregister_gate'
> ld: drivers/clk/hisilicon/clk.o: in function `hisi_clk_register_gate_sep':
>>> clk.c:(.text+0x425): undefined reference to `clk_register_clkdev'
> ld: drivers/clk/hisilicon/clk.o: in function `hi6220_clk_register_divider':
>>> clk.c:(.init.text+0x5d): undefined reference to `clk_register_clkdev'
> ld: drivers/clk/hisilicon/clkgate-separated.o: in function `hisi_register_clkgate_sep':
>>> clkgate-separated.c:(.text+0xf0): undefined reference to `clk_register'
> ld: drivers/clk/hisilicon/clkdivider-hi6220.o: in function `hi6220_clkdiv_set_rate':
>>> clkdivider-hi6220.c:(.text+0x16): undefined reference to `divider_get_val'
> ld: drivers/clk/hisilicon/clkdivider-hi6220.o: in function `hi6220_clkdiv_recalc_rate':
>>> clkdivider-hi6220.c:(.text+0x8a): undefined reference to `divider_recalc_rate'
> ld: drivers/clk/hisilicon/clkdivider-hi6220.o: in function `hi6220_clkdiv_round_rate':
>>> clkdivider-hi6220.c:(.text+0xa9): undefined reference to `clk_hw_get_parent'
>>> ld: clkdivider-hi6220.c:(.text+0xbd): undefined reference to `divider_round_rate_parent'
> ld: drivers/clk/hisilicon/clkdivider-hi6220.o: in function `hi6220_register_clkdiv':
>>> clkdivider-hi6220.c:(.text+0x1c5): undefined reference to `clk_register'
> ld: drivers/clk/hisilicon/clk-hisi-phase.o: in function `clk_register_hisi_phase':
>>> clk-hisi-phase.c:(.text+0x121): undefined reference to `devm_clk_register'
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


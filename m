Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8254C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 01:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C97C020734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 01:43:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728441AbgFBBnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 21:43:47 -0400
Received: from mail.loongson.cn ([114.242.206.163]:59122 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbgFBBnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 21:43:46 -0400
Received: from [10.130.0.52] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxz2nBrtVeLHQ8AA--.2202S3;
        Tue, 02 Jun 2020 09:43:29 +0800 (CST)
Subject: Re: [PATCH v4 2/2] clk: Allow COMPILE_TEST for subdir hisilicon in
 Makefile
To:     kbuild test robot <lkp@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
References: <1590590362-11570-2-git-send-email-yangtiezhu@loongson.cn>
 <202006010557.pUApller%lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
Message-ID: <3b371f54-3ee3-0248-b9d7-1b766449dffc@loongson.cn>
Date:   Tue, 2 Jun 2020 09:43:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <202006010557.pUApller%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: AQAAf9Dxz2nBrtVeLHQ8AA--.2202S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr13ZF47WFyxGFyfCr4Durg_yoWxAFWUpa
        n5CFy8t3W8JFWUW3y3GayUWw1fuanrtFy8CFZ3X3yUXFn8XrW8t3yqgFyfGF4qgr1kZw48
        u34UGw48u34jyFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
        1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
        7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCYjI0SjxkI62AI1cAE
        67vIY487MxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
        4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
        67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
        x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvj
        DU0xZFpf9x0JUChFxUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2020 05:05 AM, kbuild test robot wrote:
> Hi Tiezhu,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on clk/clk-next]
> [also build test ERROR on v5.7-rc7 next-20200529]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Tiezhu-Yang/clk-hisilicon-Use-correct-return-value-about-hisi_reset_init/20200527-233606
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
> config: openrisc-randconfig-r021-20200531 (attached as .config)
> compiler: or1k-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=openrisc
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>

Hi,

Thanks for your report, please ignore this patch.

>
> All errors (new ones prefixed by >>, old ones prefixed by <<):
>
> or1k-linux-ld: drivers/clk/hisilicon/clk.o: in function `hisi_clk_register_fixed_rate':
>>> clk.c:(.text+0x158): undefined reference to `clk_register_fixed_rate'
> clk.c:(.text+0x158): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `clk_register_fixed_rate'
> or1k-linux-ld: clk.c:(.text+0x220): undefined reference to `clk_unregister_fixed_rate'
> clk.c:(.text+0x220): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `clk_unregister_fixed_rate'
> or1k-linux-ld: drivers/clk/hisilicon/clk.o: in function `hisi_clk_register_fixed_factor':
>>> clk.c:(.text+0x2a0): undefined reference to `clk_register_fixed_factor'
> clk.c:(.text+0x2a0): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `clk_register_fixed_factor'
> or1k-linux-ld: clk.c:(.text+0x370): undefined reference to `clk_unregister_fixed_factor'
> clk.c:(.text+0x370): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `clk_unregister_fixed_factor'
> or1k-linux-ld: drivers/clk/hisilicon/clk.o: in function `hisi_clk_register_mux':
>>> clk.c:(.text+0x434): undefined reference to `clk_register_mux_table'
> clk.c:(.text+0x434): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `clk_register_mux_table'
> or1k-linux-ld: clk.c:(.text+0x464): undefined reference to `clk_register_clkdev'
> clk.c:(.text+0x464): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `clk_register_clkdev'
> or1k-linux-ld: clk.c:(.text+0x528): undefined reference to `clk_unregister_mux'
> clk.c:(.text+0x528): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `clk_unregister_mux'
> or1k-linux-ld: drivers/clk/hisilicon/clk.o: in function `hisi_clk_register_divider':
>>> clk.c:(.text+0x6e8): undefined reference to `clk_register_divider_table'
> clk.c:(.text+0x6e8): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `clk_register_divider_table'
> or1k-linux-ld: clk.c:(.text+0x718): undefined reference to `clk_register_clkdev'
> clk.c:(.text+0x718): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `clk_register_clkdev'
> or1k-linux-ld: clk.c:(.text+0x7d0): undefined reference to `clk_unregister_divider'
> clk.c:(.text+0x7d0): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `clk_unregister_divider'
> or1k-linux-ld: drivers/clk/hisilicon/clk.o: in function `hisi_clk_register_gate':
>>> clk.c:(.text+0x870): undefined reference to `clk_register_gate'
> clk.c:(.text+0x870): additional relocation overflows omitted from the output
> or1k-linux-ld: clk.c:(.text+0x8a0): undefined reference to `clk_register_clkdev'
> or1k-linux-ld: clk.c:(.text+0x960): undefined reference to `clk_unregister_gate'
> or1k-linux-ld: drivers/clk/hisilicon/clk.o: in function `hisi_clk_register_gate_sep':
>>> clk.c:(.text+0xa4c): undefined reference to `clk_register_clkdev'
> or1k-linux-ld: drivers/clk/hisilicon/clk.o: in function `hisi_clk_init':
> clk.c:(.text+0xb5c): undefined reference to `of_clk_src_onecell_get'
> or1k-linux-ld: clk.c:(.text+0xb6c): undefined reference to `of_clk_src_onecell_get'
> or1k-linux-ld: clk.c:(.text+0xb70): undefined reference to `of_clk_add_provider'
> or1k-linux-ld: drivers/clk/hisilicon/clk.o: in function `hi6220_clk_register_divider':
>>> clk.c:(.init.text+0xe0): undefined reference to `clk_register_clkdev'
> or1k-linux-ld: drivers/clk/hisilicon/clkgate-separated.o: in function `hisi_register_clkgate_sep':
>>> clkgate-separated.c:(.text+0x2b4): undefined reference to `clk_register'
> or1k-linux-ld: drivers/clk/hisilicon/clkdivider-hi6220.o: in function `hi6220_clkdiv_set_rate':
>>> clkdivider-hi6220.c:(.text+0x30): undefined reference to `divider_get_val'
> or1k-linux-ld: drivers/clk/hisilicon/clkdivider-hi6220.o: in function `hi6220_clkdiv_round_rate':
>>> clkdivider-hi6220.c:(.text+0x15c): undefined reference to `clk_hw_get_parent'
> or1k-linux-ld: clkdivider-hi6220.c:(.text+0x180): undefined reference to `divider_round_rate_parent'
> or1k-linux-ld: drivers/clk/hisilicon/clkdivider-hi6220.o: in function `hi6220_clkdiv_recalc_rate':
>>> clkdivider-hi6220.c:(.text+0x214): undefined reference to `divider_recalc_rate'
> or1k-linux-ld: drivers/clk/hisilicon/clkdivider-hi6220.o: in function `hi6220_register_clkdiv':
>>> clkdivider-hi6220.c:(.text+0x380): undefined reference to `clk_register'
> or1k-linux-ld: drivers/clk/hisilicon/clk-hisi-phase.o: in function `clk_register_hisi_phase':
>>> clk-hisi-phase.c:(.text+0x2f0): undefined reference to `devm_clk_register'
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


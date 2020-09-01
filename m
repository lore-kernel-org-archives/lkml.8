Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9422C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C9E214F1
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 06:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598941628;
	bh=t7ox/qrbbbkL2ZtqqsEYnR1uZk9hfzbSyMJhMHAqzQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=slCMMh01yRFrJxWf33LO3AXbz+AXVZ744uLztMhr8mg8HsEcBnwS85iXD0Dm1tWpu
	 Cw2O7rg1Uee1GIxPEWE269G7LcL8ZhQkg8HR738InleGPJinZzRP2V6kZ5Ut+Vmr1r
	 fontona6+7qg8t8c4p75+2VqxsUke+PlhdT2LLXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgIAG1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 02:27:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgIAG1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 02:27:06 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1A692071B;
        Tue,  1 Sep 2020 06:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598941625;
        bh=t7ox/qrbbbkL2ZtqqsEYnR1uZk9hfzbSyMJhMHAqzQ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OJqNmTYapOpO2MDGn5WrVTXLtNQIoF4NdyT4gOwfLhJufZdWwqHDTjvmCAxOGvenH
         tyg8oe0E43OHauo5AaCXhZ0DRizwxeH7vuArLk/hT4Umnr5oNUQtCz+m2UNhV6tdQr
         fGtc2ca23M6v8clXdGQzZSUhrwFPHTltbw+vPsw8=
Date:   Tue, 1 Sep 2020 15:27:01 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jonathan Corbet <corbet@lwn.net>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/6] kprobes: tracing/kprobes: Fix to kill kprobes on
 initmem after boot
Message-Id: <20200901152701.bd1899670b00388313b4b7e2@kernel.org>
In-Reply-To: <202009010046.S8OcDNX5%lkp@intel.com>
References: <159887793377.1330989.1807362919167072561.stgit@devnote2>
        <202009010046.S8OcDNX5%lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Sep 2020 00:25:58 +0800
kernel test robot <lkp@intel.com> wrote:

> Hi Masami,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on tip/perf/core]
> [also build test ERROR on trace/for-next lwn/docs-next linus/master v5.9-rc3 next-20200828]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Masami-Hiramatsu/tracing-boot-Add-new-options-for-tracing-specific-period/20200831-204738
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 2cb5383b30d47c446ec7d884cd80f93ffcc31817
> config: arc-defconfig (attached as .config)
> compiler: arc-elf-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arc-elf-ld: init/main.o: in function `kernel_init':
> >> main.c:(.ref.text+0xa6): undefined reference to `kprobe_free_init_mem'
> >> arc-elf-ld: main.c:(.ref.text+0xa6): undefined reference to `kprobe_free_init_mem'

OK, I missed to put the kprobe_free_init_mem() in the code
depends on CONFIG_DEBUG_FS. I'll move this out.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>

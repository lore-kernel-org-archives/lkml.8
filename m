Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 701BAC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4984F20936
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgHaJuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgHaJuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:50:06 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD7BC061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 02:50:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 9663C28EE24
Subject: Re: [PATCH v3 1/1] drm/bridge: ps8640: Rework power state handling
To:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Collabora Kernel ML <kernel@collabora.com>,
        matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        laurent.pinchart@ideasonboard.com, sam@ravnborg.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
References: <20200827085911.944899-2-enric.balletbo@collabora.com>
 <202008280329.nzd5hxfy%lkp@intel.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <bd7dff5b-46a8-e202-1e93-0f292d199267@collabora.com>
Date:   Mon, 31 Aug 2020 11:49:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <202008280329.nzd5hxfy%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/8/20 21:34, kernel test robot wrote:
> Hi Enric,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on drm-tip/drm-tip]
> [cannot apply to linux/master drm-intel/for-linux-next linus/master v5.9-rc2]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Enric-Balletbo-i-Serra/drm-bridge-ps8640-Make-sure-all-needed-is-powered-to-get-the-EDID/20200827-170009
> base:   git://anongit.freedesktop.org/drm/drm-tip drm-tip
> config: riscv-randconfig-r001-20200827 (attached as .config)
> compiler: riscv32-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=riscv 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> << WARNING: modpost: vmlinux.o(__ex_table+0xed0): Section mismatch in reference from the (unknown reference) (unknown) to the variable .debug_str:.LASF1611
>>> WARNING: modpost: vmlinux.o(__ex_table+0xf40): Section mismatch in reference from the (unknown reference) (unknown) to the variable .debug_str:.LASF1482
> FATAL: modpost: The relocation at __ex_table+0xf40 references
> section ".debug_str" which is not executable, IOW
> it is not possible for the kernel to fault
> at that address.  Something is seriously wrong
> and should be fixed.
> 

Hmm, is this really a build problem introduce by the patch ? I'll try to
investigate a bit more but looks to me that there is another problem and a false
positive.

Thanks,
  Enric


> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

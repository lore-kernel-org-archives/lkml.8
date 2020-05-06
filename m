Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475E9C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25D0720736
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 13:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgEFNsk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 09:48:40 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:13177 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgEFNsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 09:48:40 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee75eb2c006200-276df; Wed, 06 May 2020 21:47:50 +0800 (CST)
X-RM-TRANSID: 2ee75eb2c006200-276df
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.0.101] (unknown[112.0.146.193])
        by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee75eb2c004224-cf21d;
        Wed, 06 May 2020 21:47:50 +0800 (CST)
X-RM-TRANSID: 2ee75eb2c004224-cf21d
Subject: Re: [PATCH] ASoC: qcom: Use devm_platform_ioremap_resource_byname()to
 simplify code
To:     kbuild test robot <lkp@intel.com>, broonie@kernel.org,
        bgoswami@codeaurora.org, plai@codeaurora.org, perex@perex.cz,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org
References: <20200504072820.5328-1-tangbin@cmss.chinamobile.com>
 <202005051301.uK51h1pS%lkp@intel.com>
From:   Tang Bin <tangbin@cmss.chinamobile.com>
Message-ID: <4b2fba97-6f04-622c-f69a-ba00de19335d@cmss.chinamobile.com>
Date:   Wed, 6 May 2020 21:48:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <202005051301.uK51h1pS%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/5/5 13:35, kbuild test robot wrote:
> Hi Tang,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on asoc/for-next]
> [also build test ERROR on v5.7-rc4 next-20200504]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Tang-Bin/ASoC-qcom-Use-devm_platform_ioremap_resource_byname-to-simplify-code/20200505-051041
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> config: sh-allmodconfig (attached as .config)
> compiler: sh4-linux-gcc (GCC) 9.3.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=sh
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>     sound/soc/qcom/lpass-cpu.c: In function 'asoc_qcom_lpass_cpu_platform_probe':
>>> sound/soc/qcom/lpass-cpu.c:445:21: error: expected ';' before 'if'

Sorry, please forget this patch, it's my fault.

Thanks




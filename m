Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 843C5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 612D120748
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="D1HDn8jo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgHQOJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:09:04 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:62410 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728855AbgHQOJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:09:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597673342; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=t4hLN9MLXcZJt9GM/Fc8JoQMEeFYiDnOvn2HIImnesY=;
 b=D1HDn8joF7fJ9oPEyTVm9JdkTbIutDwQhHYxQ75+O62GEKuy5bCUe53/q1oLxyey6FPo7L2A
 wnp/y7rBU8DdxstkcCU8QJir8EPdngAwS9k7wXGRwDrzkvI+XFoubgyqBs9kf/5xKXyFxcQl
 0N1rpWLvWA3WCRFKqup5pG2ZJp0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f3a8f7346ed996674108e84 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 17 Aug 2020 14:08:51
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 56138C4339C; Mon, 17 Aug 2020 14:08:51 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B220C433CA;
        Mon, 17 Aug 2020 14:08:50 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 17 Aug 2020 19:38:50 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>
Subject: Re: [PATCH] soc: qcom: llcc: Support chipsets that can write to llcc
 registers
In-Reply-To: <202008172052.mtVMHotl%lkp@intel.com>
References: <20200817081138.6755-1-saiprakash.ranjan@codeaurora.org>
 <202008172052.mtVMHotl%lkp@intel.com>
Message-ID: <ca48bfaf94267bc9883ad6c41de3f796@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-17 18:13, kernel test robot wrote:
> Hi Sai,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on linux/master]
> [also build test WARNING on linus/master v5.9-rc1 next-20200817]
> [cannot apply to agross-msm/qcom/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:
> https://github.com/0day-ci/linux/commits/Sai-Prakash-Ranjan/soc-qcom-llcc-Support-chipsets-that-can-write-to-llcc-registers/20200817-161342
> base:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> bcf876870b95592b52519ed4aafcf9d95999bc9c
> config: mips-randconfig-r006-20200817 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project
> de71b46a519db014ce906a39f8a0e1b235ef1568)
> reproduce (this is a W=1 build):
>         wget
> https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross
> -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install mips cross compiling tool for clang build
>         # apt-get install binutils-mips-linux-gnu
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross 
> ARCH=mips
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>    drivers/soc/qcom/llcc-qcom.c:343:28: warning: unused variable 'np'
> [-Wunused-variable]
>            const struct device_node *np = dev_of_node(&pdev->dev);
>                                      ^
>>> drivers/soc/qcom/llcc-qcom.c:324:34: warning: unused variable 
>>> 'qcom_llcc_configure_of_match' [-Wunused-const-variable]
>    static const struct of_device_id qcom_llcc_configure_of_match[] = {
>                                     ^
>    2 warnings generated.
> 

Ok, W=1 build and CONFIG_OF=n, so I need __maybe_unused for 
qcom_llcc_configure_of_match.
Will add and send v2.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation

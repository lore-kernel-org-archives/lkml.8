Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE218C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF7A62075E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 11:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgHRLb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 07:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgHRLaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 07:30:19 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD70DC061344
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 04:29:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: andrzej.p)
        with ESMTPSA id 4021C299026
Subject: Re: [PATCH v2 2/2] tty/sysrq: Add configurable handler to execute a
 compound action
To:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
References: <20200817132727.14564-3-andrzej.p@collabora.com>
 <202008180432.QeU9MPWz%lkp@intel.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Message-ID: <0c82da66-910d-cd1f-2181-8d184e84f77a@collabora.com>
Date:   Tue, 18 Aug 2020 13:29:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202008180432.QeU9MPWz%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 17.08.2020 o 22:09, kernel test robot pisze:
> Hi Andrzej,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5]
> 
> url:    https://github.com/0day-ci/linux/commits/Andrzej-Pietrasiewicz/Add-configurable-handler-to-execute-a-compound-action/20200817-212944
> base:    9123e3a74ec7b934a4a099e98af6a61c2f80bbf5
> config: powerpc-tqm8xx_defconfig (attached as .config)
> compiler: powerpc-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All error/warnings (new ones prefixed by >>):
> 
>>> drivers/tty/sysrq.c:1158:1: error: expected identifier or '(' before '{' token

Corrected in v3.

Andrzej

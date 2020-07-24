Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4BCC433EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 04:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18BAC207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 04:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKqdBUA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgGXEPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 00:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgGXEPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 00:15:02 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0344DC0619D3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 21:15:02 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k5so4536492pjg.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 21:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/axfoE20/JGPCsNsinStfUiFAOr5YCp2PNYp2vEabD0=;
        b=BKqdBUA8zNMLgZGY1L9iCUO116w6JCjKhSoeTm8/s3qhufeM1ybtByiHEIkRdZ+OQg
         gF7cRJV5M6LAT7WHID2VGKVObo3c3xk9xvBljtt9yd1Gi23+TtCGubrl1BH2dZgJC31n
         Gn9/R94VlefdX0EAUESBXjLu/KWIX4pHPjjlylMZtl00J4IWhEK6U57fv9hI9uSQ69Fs
         C8c+VUSVbvPr2YR8opF4bzfbO/8EFXlf+ELgiF0SR6rRaFFttdpArvAh4nBS7s41B93X
         GlLvSQy3jZ/LtIV6G33XbQ7IKNCORtv9aJgJ6qQMkw/ClubEqqGH+0NeYwhswO9z/2c+
         mWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/axfoE20/JGPCsNsinStfUiFAOr5YCp2PNYp2vEabD0=;
        b=ovjItFsyk5LO5rTnfWbNU7zoIjS7Dlmo5p3NE/mUlzMz9NCJbYnTuT8fVuFJVWLdn4
         vhE87Z6keDX5jQF5Et04UAIocPzMXowhVH1b8Ri93WiAX4/9mgXFypkAH3Beeo5Zcr+a
         i/rF2Z4/XFd2fpitowEwtM4qGgkPLP1nioiByrcNVFOcVw3GKlZK6O/X82CmuYX6BZ1X
         Rf4KhqKSUkV6xFuHRmryn003M0/goPWbcBV6vApbJBFQ+9Qej2oy08f6cOy4aUMQHZOl
         3aivRBnVxPczGlzGFTrVU5bykd1WoBdXnVSS6Ya00+UxZrkzjil0qoFmHN9QkeKCQ4+n
         wvLg==
X-Gm-Message-State: AOAM5326VBkX1dJl1c5L4JdSM0O5Ps449fiiUPj/eVUEZ78jO/main6m
        6ogiynH+IvbNswXhwEIJGDpLbDq/
X-Google-Smtp-Source: ABdhPJyj8Bbtifw/CkEoBYpxxuDdTIkQYHiJRvTvTaaMOOWWB7eztqF7rRR3gqlKZOsEoRKcfzwBxg==
X-Received: by 2002:a17:902:9b8f:: with SMTP id y15mr6829884plp.322.1595564101513;
        Thu, 23 Jul 2020 21:15:01 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o11sm4467888pfp.88.2020.07.23.21.14.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2020 21:15:00 -0700 (PDT)
Subject: Re: drivers/irqchip/irq-bcm7038-l1.c:312:13: error: implicit
 declaration of function 'cpu_logical_map'
To:     kernel test robot <lkp@intel.com>,
        Justin Chen <justinpopo6@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>
References: <202007241234.G6Yf8u6V%lkp@intel.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6d4d8b18-8c55-2ad9-ec57-0e5eb65a8dec@gmail.com>
Date:   Thu, 23 Jul 2020 21:14:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <202007241234.G6Yf8u6V%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/23/2020 9:07 PM, kernel test robot wrote:
> Hi Justin,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d15be546031cf65a0fc34879beca02fd90fe7ac7
> commit: 6468fc18b00685c82408f40e9569c0d3527862b8 irqchip/irq-bcm7038-l1: Add PM support
> date:   9 months ago
> config: mips-randconfig-r033-20200724 (attached as .config)
> compiler: mipsel-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 6468fc18b00685c82408f40e9569c0d3527862b8
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/irqchip/irq-bcm7038-l1.c: In function 'bcm7038_l1_suspend':
>>> drivers/irqchip/irq-bcm7038-l1.c:312:13: error: implicit declaration of function 'cpu_logical_map' [-Werror=implicit-function-declaration]
>      312 |  boot_cpu = cpu_logical_map(0);
>          |             ^~~~~~~~~~~~~~~
>    drivers/irqchip/irq-bcm7038-l1.c: At top level:
>    drivers/irqchip/irq-bcm7038-l1.c:393:12: warning: no previous prototype for 'bcm7038_l1_of_init' [-Wmissing-prototypes]
>      393 | int __init bcm7038_l1_of_init(struct device_node *dn,
>          |            ^~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> vim +/cpu_logical_map +312 drivers/irqchip/irq-bcm7038-l1.c

Ah this needs to be guarded with CONFIG_SMP which this failing .config
did not enable, I will submit a fix for that first thing in the morning.
-- 
Florian

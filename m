Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4121BC35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 16:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ECED21775
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 16:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tZ+ZrfQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgBHQG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 11:06:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40010 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbgBHQG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 11:06:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=wGHruymOSLzDhYVr7mNGwmtnwr69b/K/PGGV693l2Q4=; b=tZ+ZrfQdZjexJbtGaW5PsKulJ/
        AQ/Mh7Kq3Rf+gvZh/yMmrctfDKZGPAxKebwLsczlzYIlJBOcxoKIriiOGkaAhU+IrazpKi7PysWSn
        ZhSwxyAo1RGMOZLYUsF8biStN9AqybcH8wzUpfxayiwdDvMk7ksm8B7Svy38HbeftQ6P+Guxw6ZeW
        vkvmKQuqczli23OWoYY0CWPwRqhrwJHIpV7cotSu1dkMT7LXDwsWDjbCDBgtK9fVGM6EvHROHjc5/
        7jsMZlPgfwdZTKR5OD+VHwVJHQzHJOa5BR9PTPXHoiiDSyjW59ZkzkubvdoxoW2nnqX0INhNGBHyd
        FlyHvM2Q==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j0ScU-0004aq-8F; Sat, 08 Feb 2020 16:06:10 +0000
Subject: Re: da9062_wdt.c:undefined reference to `i2c_smbus_write_byte_data'
To:     kbuild test robot <lkp@intel.com>,
        Marco Felsch <m.felsch@pengutronix.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Stefan Lengfeld <contact@stefanchrist.eu>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
References: <202002082121.pOScaga1%lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <14439325-fa91-9090-6dab-d63ce540aae7@infradead.org>
Date:   Sat, 8 Feb 2020 08:06:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <202002082121.pOScaga1%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/20 5:14 AM, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f757165705e92db62f85a1ad287e9251d1f2cd82
> commit: 057b52b4b3d58f4ee5944171da50f77b00a1bb0d watchdog: da9062: make restart handler atomic safe
> date:   12 days ago
> config: i386-randconfig-b001-20200208 (attached as .config)
> compiler: gcc-7 (Debian 7.5.0-3) 7.5.0
> reproduce:
>         git checkout 057b52b4b3d58f4ee5944171da50f77b00a1bb0d
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    ld: drivers/watchdog/da9062_wdt.o: in function `da9062_wdt_restart':
>>> da9062_wdt.c:(.text+0x1c): undefined reference to `i2c_smbus_write_byte_data'
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


Also reported here:
https://lore.kernel.org/lkml/ac797eb0-9b0a-d2d3-3a40-3fbd0a8b5ee0@infradead.org/

on 2020-JAN-31.

-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>

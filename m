Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C74DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 05:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C3552087D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 05:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i0Vnj588"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgIAFrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 01:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgIAFrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 01:47:46 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF58C0612A3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 22:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=z0w4+hNfdldNlYEJjiZeG1sutgNqlA1BYQPXsEIo0Jo=; b=i0Vnj588KWHlGnV0+RT994CjOG
        r/nD5PmJoKEJyKHXSYH0lRtT0Cylwc9SvFdUkldryRiUXY3YdZwMxDc5UXRu1T7HQV+GY77aVyej3
        GJpH7DVvX/wfwDwanif+gPGkjVSnhGUaU9X9S5FlN9V8AKeRMMcCOugf5rtoJO5WmYOWuwCuobv/L
        +aJlZq/a8gLUs2WnutFnRwMUr/TRWYsbThgGGuVoOJSoxmhkRyI7rQhxgqJCeHwmbeCuFLUQpoV2D
        jklZZdYeQjFg8DV0ImY9Sf9P91HKX1LuT0R+iDAD9tzSG0G5YddvboFf8E9NMhixz7P9PwVndD1GT
        LEBrDRVg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCz8u-0001Hp-Nx; Tue, 01 Sep 2020 05:47:41 +0000
Subject: Re: ERROR: "min_low_pfn" undefined!
To:     kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
References: <202009011306.LeUnyxbp%lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <dccbf654-3684-c491-4659-0d6d4044d43a@infradead.org>
Date:   Mon, 31 Aug 2020 22:47:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <202009011306.LeUnyxbp%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/20 10:41 PM, kernel test robot wrote:
> Hi Arnd,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b51594df17d0ce80b9f9f35394a1f42d7ac94472
> commit: 710ec38b0f633ab3e2581f07a73442d809e28ab0 mm: add dummy can_do_mlock() helper
> date:   11 months ago
> config: microblaze-randconfig-r031-20200831 (attached as .config)
> compiler: microblaze-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 710ec38b0f633ab3e2581f07a73442d809e28ab0
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=microblaze 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>>> ERROR: "min_low_pfn" [drivers/rpmsg/virtio_rpmsg_bus.ko] undefined!
>    ERROR: "min_low_pfn" [drivers/block/aoe/aoe.ko] undefined!


Please test
https://lore.kernel.org/lkml/20200829000110.2408-1-rdunlap@infradead.org/


-- 
~Randy


Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFC5C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EBDB2071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NilOZBre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbgIAR7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729720AbgIAR7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:59:31 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD9EC061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 10:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=YXCMk1DqoHnqX2zfbvTUsn6RI4RK/Zt6tOzCi66KY2c=; b=NilOZBreCDAw1824+1VZwgvMN6
        btUoliLVNBLnjdURDffrohVVyPwgo4q0GLJ8m3MN0vyBp1VItfSqX49sQyK/UTPfDdrocF8BaqeDM
        k6ZilJXpBLoTNQaplUfwPtVgqBui+fxPgi/2879Umkic3EHfVvmnkKxjG0DdZQl4Oin/mB7Jw3Ucd
        LKpKlizgMRpiMTTTvgp4A3zTZu38DrYKpe1hn9NswA5OwApC3SFhej6g8nmHAzA8uYamV54RZpsfk
        aJjnOzmEfr3QPRgXju6SIgpft4JlQNvvOV7jiiLa/3F7lW7mBYO5n3ZNCEjgVURBogBVJUNFXQuSv
        RAIIT1gA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDAZ4-0003cI-OJ; Tue, 01 Sep 2020 17:59:27 +0000
Subject: Re: ERROR: "min_low_pfn" undefined!
To:     kernel test robot <lkp@intel.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mike Snitzer <snitzer@redhat.com>
References: <202009012005.FyTjySG4%lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0ab89fbf-eb8c-2122-c939-5a7d0db55379@infradead.org>
Date:   Tue, 1 Sep 2020 10:59:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <202009012005.FyTjySG4%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/20 5:05 AM, kernel test robot wrote:
> Hi Ard,
> 
> First bad commit (maybe != root cause):
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b51594df17d0ce80b9f9f35394a1f42d7ac94472
> commit: be1eb7f78aa8fbe34779c56c266ccd0364604e71 crypto: essiv - create wrapper template for ESSIV generation
> date:   12 months ago
> config: microblaze-randconfig-r003-20200831 (attached as .config)
> compiler: microblaze-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout be1eb7f78aa8fbe34779c56c266ccd0364604e71
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=microblaze 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    ERROR: "min_low_pfn" [net/mac80211/mac80211.ko] undefined!
>    ERROR: "min_low_pfn" [drivers/mtd/nand/raw/nand.ko] undefined!
>    ERROR: "min_low_pfn" [drivers/ntb/ntb_transport.ko] undefined!
>>> ERROR: "min_low_pfn" [crypto/essiv.ko] undefined!
>    ERROR: "min_low_pfn" [crypto/tcrypt.ko] undefined!
>    ERROR: "min_low_pfn" [crypto/gcm.ko] undefined!
>    ERROR: "min_low_pfn" [crypto/asymmetric_keys/asym_tpm.ko] undefined!
> 
> ---

Please test this patch:

https://lore.kernel.org/lkml/20200829000110.2408-1-rdunlap@infradead.org/

thanks.
-- 
~Randy


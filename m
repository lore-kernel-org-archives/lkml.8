Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959B3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 03:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AF4820675
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 03:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgHLDXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 23:23:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:41409 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgHLDXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 23:23:14 -0400
IronPort-SDR: Fwh8n7fy43aWXi/Gpi9Kr3MSYVXWqllrxJmJ0AZhHnq8IMsrimDU9Mq+Jtww71brxG/l8J59UE
 yYJ2iglpNXZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="215396806"
X-IronPort-AV: E=Sophos;i="5.76,302,1592895600"; 
   d="scan'208";a="215396806"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 20:23:13 -0700
IronPort-SDR: 8Ntqf9bKTlQ/6rSRI4Sr4fNm6XilpPALipbN+NNWVx33eAuERpOf0eGomaIU37KgSSYC7RpQQA
 9ICutRePGsvA==
X-IronPort-AV: E=Sophos;i="5.76,302,1592895600"; 
   d="scan'208";a="469658117"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 20:23:11 -0700
Subject: Re: [kbuild-all] Re: arch/sparc/include/asm/cmpxchg_64.h:161:55:
 sparse: sparse: cast truncates bits from constant value (ffffffffe0f510cc
 becomes cc)
To:     Gao Xiang <hsiangkao@redhat.com>, kernel test robot <lkp@intel.com>
Cc:     Gao Xiang <hsiangkao@aol.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <202008120933.YrVhHyoA%lkp@intel.com>
 <20200812030956.GA17005@xiangao.remote.csb>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <b8dfa8cd-f3f9-d10c-fbd0-eac8067ee39c@intel.com>
Date:   Wed, 12 Aug 2020 11:22:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200812030956.GA17005@xiangao.remote.csb>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/12/20 11:09 AM, Gao Xiang wrote:
> Hi,
>
> On Wed, Aug 12, 2020 at 09:49:38AM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   fb893de323e2d39f7a1f6df425703a2edbdf56ea
>> commit: 47e4937a4a7ca4184fd282791dfee76c6799966a erofs: move erofs out of staging
>> date:   12 months ago
>> config: sparc64-randconfig-s032-20200812 (attached as .config)
>> compiler: sparc64-linux-gcc (GCC) 9.3.0
>> reproduce:
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # apt-get install sparse
>>          # sparse version: v0.6.2-168-g9554805c-dirty
>>          git checkout 47e4937a4a7ca4184fd282791dfee76c6799966a
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sparc64
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> sparse warnings: (new ones prefixed by >>)
>>
>>     fs/erofs/utils.c: note: in included file (through arch/sparc/include/asm/cmpxchg.h, arch/sparc/include/asm/atomic_64.h, arch/sparc/include/asm/atomic.h, ...):
>>>> arch/sparc/include/asm/cmpxchg_64.h:161:55: sparse: sparse: cast truncates bits from constant value (ffffffffe0f510cc becomes cc)
>> --
>>     fs/erofs/zdata.c: note: in included file (through arch/sparc/include/asm/cmpxchg.h, arch/sparc/include/asm/atomic_64.h, arch/sparc/include/asm/atomic.h, ...):
>>>> arch/sparc/include/asm/cmpxchg_64.h:161:55: sparse: sparse: cast truncates bits from constant value (ffffffffe0f510cc becomes cc)
>>     arch/sparc/include/asm/cmpxchg_64.h:161:50: sparse: sparse: cast truncates bits from constant value (5f0ecafe becomes fe)
>>     arch/sparc/include/asm/cmpxchg_64.h:161:50: sparse: sparse: cast truncates bits from constant value (5f0ecafe becomes fe)
>>     arch/sparc/include/asm/cmpxchg_64.h:161:55: sparse: sparse: cast truncates bits from constant value (5f0edead becomes ad)
>>
>> vim +161 arch/sparc/include/asm/cmpxchg_64.h
>>
>> d550bbd40c0e10 David Howells 2012-03-28  155
>> d550bbd40c0e10 David Howells 2012-03-28  156  static inline unsigned long
>> d550bbd40c0e10 David Howells 2012-03-28  157  __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
>> d550bbd40c0e10 David Howells 2012-03-28  158  {
>> d550bbd40c0e10 David Howells 2012-03-28  159  	switch (size) {
>> a12ee2349312d7 Babu Moger    2017-05-24  160  		case 1:
>> a12ee2349312d7 Babu Moger    2017-05-24 @161  			return __cmpxchg_u8(ptr, old, new);
>> d550bbd40c0e10 David Howells 2012-03-28  162  		case 4:
>> d550bbd40c0e10 David Howells 2012-03-28  163  			return __cmpxchg_u32(ptr, old, new);
>> d550bbd40c0e10 David Howells 2012-03-28  164  		case 8:
>> d550bbd40c0e10 David Howells 2012-03-28  165  			return __cmpxchg_u64(ptr, old, new);
>> d550bbd40c0e10 David Howells 2012-03-28  166  	}
>> d550bbd40c0e10 David Howells 2012-03-28  167  	__cmpxchg_called_with_bad_pointer();
>> d550bbd40c0e10 David Howells 2012-03-28  168  	return old;
>> d550bbd40c0e10 David Howells 2012-03-28  169  }
>> d550bbd40c0e10 David Howells 2012-03-28  170
> Again, I have no idea how to deal with that in my current
> gatekeeping code.
>
> I got these reports, but I cannot help to resolve that.
> Even I don't know if that's another sparse issue (since I
> only got such reports on sparc and alpha arch, but no x86
> or arm64.)
>
> https://lore.kernel.org/r/202007251532.y5A10ZoO%25lkp@intel.com
> https://lore.kernel.org/r/202007272132.1AgbBO3U%25lkp@intel.com
> https://lore.kernel.org/r/202008100408.Wc6WGrac%25lkp@intel.com
> https://lore.kernel.org/r/202008120933.YrVhHyoA%25lkp@intel.com
>
> If no one can help that, could you please silence such reports.
> It really makes me confusing.


Hi Gao Xiang,

Sorry for the inconvenience, we'll silence the reports on this commit.

Best Regards,
Rong Chen

>
> Thanks,
> Gao Xiang
>
>> :::::: The code at line 161 was first introduced by commit
>> :::::: a12ee2349312d7112b9b7c6ac2e70c5ec2ca334e arch/sparc: Introduce cmpxchg_u8 SPARC
>>
>> :::::: TO: Babu Moger <babu.moger@oracle.com>
>> :::::: CC: David S. Miller <davem@davemloft.net>
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org


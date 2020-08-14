Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EDFC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 04:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 160FF20708
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 04:21:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AUUNBvBz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgHNEVx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 00:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgHNEVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 00:21:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BFCC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 21:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=6u8Q+umVnRxiYYDPDA9arw80XfyHuNVnhyeRkqd+wgE=; b=AUUNBvBzzD8i5v1Rf6ugorkyGQ
        La0hjzSqKhbHaeuOnuQYRkFNjyVWFlhtEREwbee9n4C2O5Et1GEqDLJW7D53xW3zN2n7qevbMOfEv
        7DdkQ7O9H4JhC+pH0Qc0iCGL5bmxwODxDK8ivPO2emYNEADJpAtP5l6AJkN16ywm9W+EuHR562J/W
        fN4Ax0d6JwEqIP5QfahMyc6fwS4gBs2KDRBFuthmaCI8DzDqe6VXPSqqeRpBU9LV2r0BUfs//ypS3
        BrAE1ijwVw0tyoqcml7DZRB64A+1v/PDuK7AOrfXlwtZzviDjbTg0be+QWPNlFUy4d7saJop41Wv6
        vbxg9IiQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6RDx-0007c4-Nm; Fri, 14 Aug 2020 04:21:50 +0000
Subject: Re: net/tipc/udp_media.c:743: undefined reference to `ipv6_dev_find'
To:     Xin Long <lucien.xin@gmail.com>, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>
References: <202008120718.VxKCVIJX%lkp@intel.com>
 <CADvbK_fycBSAL5Xz1XjGNmEfQ6499n+4Wr01GTn-vNi0Fuj2FQ@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <eeb31691-bc42-3363-f24d-b8fa66f5deb2@infradead.org>
Date:   Thu, 13 Aug 2020 21:21:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CADvbK_fycBSAL5Xz1XjGNmEfQ6499n+4Wr01GTn-vNi0Fuj2FQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/13/20 2:35 AM, Xin Long wrote:
> On Wed, Aug 12, 2020 at 7:21 AM kernel test robot <lkp@intel.com> wrote:
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   c636eef2ee3696f261a35f34989842701a107895
>> commit: 5a6f6f579178dbeb33002d93b4f646c31348fac9 tipc: set ub->ifindex for local ipv6 address
>> date:   6 days ago
>> config: ia64-randconfig-r005-20200811 (attached as .config)
>> compiler: ia64-linux-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         git checkout 5a6f6f579178dbeb33002d93b4f646c31348fac9
>>         # save the attached .config to linux build tree
>>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=ia64
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>    ia64-linux-ld: net/tipc/udp_media.o: in function `tipc_udp_enable':
>>>> net/tipc/udp_media.c:743: undefined reference to `ipv6_dev_find'
> To use some APIs exported from ipv6 code.
> We need add this:
> 
> --- a/net/tipc/Kconfig
> +++ b/net/tipc/Kconfig
> @@ -6,6 +6,7 @@
>  menuconfig TIPC
>         tristate "The TIPC Protocol"
>         depends on INET
> +       depends on IPV6 || IPV6=n
> 

Thanks. Works for me.

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Please make a proper patch and send it to the maintainers.
-- 
~Randy

Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08435C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 13:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4EBC20739
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 13:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgFMNKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 09:10:14 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42472 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgFMNKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 09:10:13 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jk5uv-0003T2-8W; Sat, 13 Jun 2020 23:09:50 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 13 Jun 2020 23:09:49 +1000
Date:   Sat, 13 Jun 2020 23:09:49 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     kernel test robot <lkp@intel.com>, linux-sparse@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild-all@lists.01.org
Subject: Re: [PATCH] printk: Make linux/printk.h self-contained
Message-ID: <20200613130949.GA22005@gondor.apana.org.au>
References: <20200611125144.GA2506@gondor.apana.org.au>
 <20200613122834.GA23739@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613122834.GA23739@xsang-OptiPlex-9020>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 08:28:34PM +0800, kernel test robot wrote:
> 
> Hi Herbert,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v5.7 next-20200611]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Herbert-Xu/printk-Make-linux-printk-h-self-contained/20200611-205340
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git b29482fde649c72441d5478a4ea2c52c56d97a5e
> :::::: branch date: 13 hours ago
> :::::: commit date: 13 hours ago
> config: powerpc-randconfig-s031-20200611 (attached as .config)
> compiler: powerpc64le-linux-gcc (GCC) 9.3.0
> reproduce:
>         # apt-get install sparse
>         # sparse version: v0.6.1-250-g42323db3-dirty
>         # save the attached .config to linux build tree
>         make W=1 C=1 ARCH=powerpc CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
> >> include/linux/ratelimit_types.h:16:25: sparse: sparse: expected ; at end of declaration
>    include/linux/ratelimit_types.h:16:25: sparse: sparse: Expected } at end of struct-union-enum-specifier
>    include/linux/ratelimit_types.h:16:25: sparse: sparse: got lock
>    include/linux/ratelimit_types.h:24:1: sparse: sparse: Expected ; at the end of type declaration
>    include/linux/ratelimit_types.h:24:1: sparse: sparse: got }

This looks like a bug in sparse as the same code compiles just
fine.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4B3C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 02:58:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA2FE206B5
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 02:58:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JEWFb2iE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="O3CXe5iW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgH3C6I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 22:58:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53421 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbgH3C6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 22:58:07 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 642D4E4160;
        Sat, 29 Aug 2020 22:58:05 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=veTpVxcWP5WtZFT8De+7rlcxJ10=; b=JEWFb2
        iEjOZjn5F2jR1wdyVZRfcvCAS8Dky2psvB8ao/5iHPG79Jie3YhhivmXVTbCKUEo
        9gHDQiRW9n9pByh4DpwVPwY3CvoiJmxa8nXxDbTeG1le+cJy//wwZaUei0U1bfeX
        lbAyhueE4ez7m4y0YxXCAbbswwPxypTHU6aZE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5D12BE415F;
        Sat, 29 Aug 2020 22:58:05 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=EuBCUU8DsUHeXqRf2L0y2Ivmd5f0yk2vTZ+rNahJQt8=; b=O3CXe5iW/f0HksiyQ+AAIKso5eWQ+hpmTtvJqMSf190mbhA9uTpJPOy4IgkHje6hG9dDKrjh+jDo5ntn7mFkoqgcuCf0ZdGTy0mwa+fyYfEoyVs9ceKBPBQQbFtvmffGHdnxA5vI4EU6HCNP0kZ+QfKb4MyKAIPK7hUJOP8Xzes=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 55633E415D;
        Sat, 29 Aug 2020 22:58:02 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id A08A72DA0A72;
        Sat, 29 Aug 2020 22:58:00 -0400 (EDT)
Date:   Sat, 29 Aug 2020 22:58:00 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     kernel test robot <lkp@intel.com>
cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: {standard input}:1174: Error: inappropriate arguments for opcode
 'mpydu'
In-Reply-To: <202008300726.ynqzYKmk%lkp@intel.com>
Message-ID: <nycvar.YSQ.7.78.906.2008292257360.1479@knanqh.ubzr>
References: <202008300726.ynqzYKmk%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 9E6EEE02-EA6C-11EA-BE4F-F0EA2EB3C613-78420484!pb-smtp20.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks like a buggy compiler to me.


On Sun, 30 Aug 2020, kernel test robot wrote:

> Hi Nicolas,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   e77aee1326f7691763aa968eee2f57db37840b9d
> commit: 602828c1aade576ac5f3fbd59b4eb014c5fc2414 __div64_const32(): improve the generic C version
> date:   12 months ago
> config: arc-allmodconfig (attached as .config)
> compiler: arceb-elf-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 602828c1aade576ac5f3fbd59b4eb014c5fc2414
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    {standard input}: Assembler messages:
> >> {standard input}:1174: Error: inappropriate arguments for opcode 'mpydu'
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

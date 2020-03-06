Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0D6C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90AC20717
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583504857;
	bh=3grT2gueeZjVzW3RFKCo3PiCktA7IBrRkmtlsVj4AqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PvuVyCKWbsnT3d+RQxqgBWhoku2VGrHUCrD8HVMi8xxwPE5NZAwwfUjvh2i18W/LL
	 lQh7wY8X5DDqMNEB4iezOQ+peHQ1arfKaZoZJ4h4WZWo34knxZOvVd/UouUL545M1R
	 Ztqs9/hxcPqOBZZ6f+8GlQRHguMZiYe0geUYrpd0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgCFO1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:27:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:45426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbgCFO1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:27:36 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D10120717;
        Fri,  6 Mar 2020 14:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583504856;
        bh=3grT2gueeZjVzW3RFKCo3PiCktA7IBrRkmtlsVj4AqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=exw25vLgHi62KLBmn/WFZKNXY2lbyONY/qvDb1H5QxSr2axZAF3NCQ3QdlEwQc+MK
         UF2PhxIJP241uK3o+fGsqIxy9dCjxrXH/kF97QUaIfS+Ev8mIXFpsL9xg/sW+fbtY4
         y0Tqab4RZJMTJSFSRym9f3REgympRGIuJR8r7viE=
Date:   Fri, 6 Mar 2020 15:27:33 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: arch/x86/mm/fault.o: warning: objtool: do_page_fault()+0x4fb:
 unreachable instruction
Message-ID: <20200306142732.GA8590@lenoir>
References: <202003061843.YVzsDc3A%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003061843.YVzsDc3A%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 06:48:47PM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   9f65ed5fe41ce08ed1cb1f6a950f9ec694c142ad
> commit: ee6352b2c47a24234398e06381edd93a8e965976 x86/context-tracking: Remove exception_enter/exit() from do_page_fault()
> date:   8 weeks ago
> config: x86_64-randconfig-a002-20200306 (attached as .config)
> compiler: gcc-4.9 (Debian 4.9.2-10+deb8u1) 4.9.2
> reproduce:
>         git checkout ee6352b2c47a24234398e06381edd93a8e965976
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> arch/x86/mm/fault.o: warning: objtool: do_page_fault()+0x4fb: unreachable instruction

I tried several versions of gcc and I can't reproduce the warning. Also looking
at the code I fail to find an actual unreachable path. Do you still have the vmlinux around?

Thanks.


Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66BFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1282207CD
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 13:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598277289;
	bh=QgmigMQcPNPtnVLV/dmghOequglNtwdp+wCttMBUnD8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iNGW1aTqg+kbEdBDnh8FkWF2c4kS8QKvD0FXRZimqoLX51beOYgcDjejfZI/uZjNo
	 XGBFRF/Ql5XDO4lLvwAbXfKuBLo4DJKSsSmsG6IP7xsHQ9rNRWf5la0wkEyh8x/T4x
	 DV0khl5jMYElp/H1+TwNkuzZgSGrdTFsz8pnEowo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgHXNys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 09:54:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgHXNyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 09:54:43 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF197206B5;
        Mon, 24 Aug 2020 13:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598277282;
        bh=QgmigMQcPNPtnVLV/dmghOequglNtwdp+wCttMBUnD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yMjD0q0J0KAvP4sS6fR8lm9rUO+TwMiXW/Q7f1iZkqrqCWqyP+7uf+gJlrJ60jLkf
         GSjmtk0/6OburSq8JLSdLvnK1IRnYLtzVN+7rCm8eQbBpD8gn7gfqOMUejKF5hm9zB
         9IyJ3tJeoU6ONY9SFScZuNp0pqwDwaRKjMLgshLY=
Date:   Mon, 24 Aug 2020 19:24:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     kernel test robot <lkp@intel.com>,
        Sugar Zhang <sugar.zhang@rock-chips.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: Re: drivers/dma/pl330.c:2981:9: warning: Identical condition 'ret',
 second condition is always false
Message-ID: <20200824135438.GA2639@vkoul-mobl>
References: <202008081010.0bKKNfQp%lkp@intel.com>
 <CGME20200808125949eucas1p2d02178719f81ee811aae13097d382670@eucas1p2.samsung.com>
 <20200808125940.GR12965@vkoul-mobl>
 <9e7612e8-41a5-460d-5492-12c5ef81b914@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e7612e8-41a5-460d-5492-12c5ef81b914@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-08-20, 15:50, Marek Szyprowski wrote:
> Hi Vinod,
> 
> On 08.08.2020 14:59, Vinod Koul wrote:
> > On 08-08-20, 10:53, kernel test robot wrote:
> >> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> >> head:   30185b69a2d533c4ba6ca926b8390ce7de495e29
> >> commit: a39cddc9e3775100100a4272feed64faac831be9 dmaengine: pl330: Drop boilerplate code for suspend/resume
> >> date:   8 months ago
> >> compiler: aarch64-linux-gcc (GCC) 9.3.0
> >>
> >> If you fix the issue, kindly add following tag as appropriate
> >> Reported-by: kernel test robot <lkp@intel.com>
> >>
> >>
> >> cppcheck warnings: (new ones prefixed by >>)
> >>
> >>>> drivers/dma/pl330.c:2981:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
> >>      return ret;
> >>             ^
> >>     drivers/dma/pl330.c:2976:6: note: first condition
> >>      if (ret)
> >>          ^
> >>     drivers/dma/pl330.c:2981:9: note: second condition
> >>      return ret;
> > This one could be fixed by making this as return 0, but is harmless
> 
> Right, with CONFIG_PM disabled, pm_runtime_force_resume() is noop, what 
> causes the above warning.
> 
> >>             ^
> >>>> drivers/dma/pl330.c:2798:23: warning: Variable 'desc->rqcfg.brst_len' is reassigned a value before the old one has been used. [redundantAssignment]
> >>      desc->rqcfg.brst_len = get_burst_len(desc, len);
> >>                           ^
> >>     drivers/dma/pl330.c:2796:24: note: Variable 'desc->rqcfg.brst_len' is reassigned a value before the old one has been used.
> >>       desc->rqcfg.brst_len = 1;
> >>                            ^
> >>     drivers/dma/pl330.c:2798:23: note: Variable 'desc->rqcfg.brst_len' is reassigned a value before the old one has been used.
> >>      desc->rqcfg.brst_len = get_burst_len(desc, len);
> > This one actually seems like a bug. Reading the code I think
> > get_burst_len() should be called first before checking if burst size is
> > smaller and setting to 1 in that case
> >
> > Sugar Zhang, Marek Szyprowski can you folks check this?
> 
> Indeed. It look that the commit 137bd11090d89b added 
> desc->rqcfg.brst_len = 1 assignment before the desc->rqcfg.brst_len is 
> set. Maybe this was a result of the broken rebase or so. No idea. It 
> makes sense to switch the order and call desc->rqcfg.brst_len = 
> get_burst_len(desc, len) first. I can send a patch if you want.

That would be great Marek

Thanks
-- 
~Vinod

Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F139BC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:32:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C46E124684
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583839926;
	bh=d9N6Gce4VbPrb9WCFzhtQKiZPVyau9sCRNVtOM++vOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iF+XWGd/W6t8EeNvXu/pMQgv6Le4kYzeJsHT+ScK5m4HH6lw+ilIdA90ITLmRKsNG
	 hmEGncZ3/ckhc80gbZBYPdpmH06usl1mksavva64wq6P+TMUVb7OheH1hRfgg6UCtn
	 FR5OFyF53vBP3fbj0B+c4yL4hq9UikY0TYn0pZ+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgCJLcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:32:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgCJLcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:32:05 -0400
Received: from linux-8ccs.fritz.box (p5B2812F9.dip0.t-ipconnect.de [91.40.18.249])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D04ED24681;
        Tue, 10 Mar 2020 11:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583839924;
        bh=d9N6Gce4VbPrb9WCFzhtQKiZPVyau9sCRNVtOM++vOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zej+Xx83tfvYCe5hxjS66GJFZ5o3pt4nB4URqcZ8Ns67wwXx4eyfmY+aTB3xDh1s6
         bzZWtVxznpTtYWLQoF+yB8DgyzkIkG2jVn+nYpAyvkS9jq1Vo5Rv2U5PlWbH5Un/Va
         LhP0gIvPSGz01oppJrl1uR64sTFkSxXEUk4zjoCU=
Date:   Tue, 10 Mar 2020 12:32:00 +0100
From:   Jessica Yu <jeyu@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Matthias Maennich <maennich@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkp@01.org
Subject: Re: [PATCH v3 1/2] modpost: rework and consolidate logging interface
Message-ID: <20200310113158.GA4865@linux-8ccs.fritz.box>
References: <20200306160206.5609-1-jeyu@kernel.org>
 <CAK7LNARZ4VgaCa_TiDBG-99amBGTTXTQMs9LsK3nO4k+y-5KDQ@mail.gmail.com>
 <20200309095914.GA18870@linux-8ccs.fritz.box>
 <CAK7LNARf9CzZ8dcK5O5vxUoncpDdpzSZctd0YuKeWyfDG_cdwA@mail.gmail.com>
 <20200309103935.GB18870@linux-8ccs.fritz.box>
 <CAK7LNARpJ-FAvCUEH9rrNCiqx5LwRHmWospvRnT-ERQoEGjK-Q@mail.gmail.com>
 <20200309105812.GC18870@linux-8ccs.fritz.box>
 <CAK7LNAQqMGSkX4Coe+f49SbXT_jkG_Mm4XZ3EJei0_K7SEaLhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAK7LNAQqMGSkX4Coe+f49SbXT_jkG_Mm4XZ3EJei0_K7SEaLhg@mail.gmail.com>
X-OS:   Linux linux-8ccs 5.5.0-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Masahiro Yamada [09/03/20 20:03 +0900]:
>On Mon, Mar 9, 2020 at 7:58 PM Jessica Yu <jeyu@kernel.org> wrote:
>>
>> +++ Masahiro Yamada [09/03/20 19:49 +0900]:
>> >On Mon, Mar 9, 2020 at 7:39 PM Jessica Yu <jeyu@kernel.org> wrote:
>> >>
>> >> Ah, sorry, I mean the kbuild 0-day bot errors. I am just realizing
>> >> the 0-day bot emails are not CC'd to lkml. Here is the error I got
>> >> from the bot:
>> >>
>> >> ---
>> >>
>> >> I love your patch! Yet something to improve:
>> >>
>> >> [auto build test ERROR on linus/master]
>> >> [also build test ERROR on v5.6-rc4 next-20200306]
>> >> [if your patch is applied to the wrong git tree, please drop us a note to help
>> >> improve the system. BTW, we also suggest to use '--base' option to specify the
>> >> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>> >>
>> >> url:    https://github.com/0day-ci/linux/commits/Jessica-Yu/modpost-rework-and-consolidate-logging-interface/20200307-052346
>> >> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 30fe0d07fd7b27d41d9b31a224052cc4e910947a
>> >> config: sh-randconfig-a001-20200306 (attached as .config)
>> >> compiler: sh4-linux-gcc (GCC) 7.5.0
>> >> reproduce:
>> >>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>> >>         chmod +x ~/bin/make.cross
>> >>         # save the attached .config to linux build tree
>> >>         GCC_VERSION=7.5.0 make.cross ARCH=sh
>> >>
>> >> If you fix the issue, kindly add following tag
>> >> Reported-by: kbuild test robot <lkp@intel.com>
>> >>
>> >> All errors (new ones prefixed by >>):
>> >>
>> >> >> ERROR: modpost: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!
>> >
>> >
>> >Indeed, this one is odd.
>> >I have no idea...
>>
>> I've pushed the patches to a branch to let the kbuild bot run through its
>> build tests again, and if I have extra time today I will try to
>> reproduce this and let you know the results.
>>
>> Thanks,
>>
>> Jessica
>
>
>Ah, Now I see.
>
>
>Because you added "modpost:" prefix.
>
>
>
>The previous error message:
>
>ERROR: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!
>
>
>The new error message:
>
>ERROR: modpost: "adc_single" [arch/sh/boards/mach-hp6xx/hp6xx_apm.ko] undefined!
>
>
>
>So, the bot assumed it was a new error.

Nice catch! Hm, I suppose we need to let the LKP folks know about the
change in error message. CC'd LKP mailing list.

Jessica

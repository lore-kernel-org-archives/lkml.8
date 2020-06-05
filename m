Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E060C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26CAD207D0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:02:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgFEKCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:02:05 -0400
Received: from foss.arm.com ([217.140.110.172]:53080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbgFEKCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:02:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0B8612B;
        Fri,  5 Jun 2020 03:02:04 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 444693F52E;
        Fri,  5 Jun 2020 03:02:03 -0700 (PDT)
References: <20200603184500.GC1551@shell.armlinux.org.uk> <CAKfTPtBdN30ChMgFqqT1bzeU6HExXEQFrQjxbCK-hRT4HEiQkQ@mail.gmail.com> <20200603195853.GD1551@shell.armlinux.org.uk> <jhjftbbj3qi.mognet@arm.com> <a34fcb9a-ba4b-0c9e-328f-1244c2720ed2@linaro.org> <jhjeeqvi3m1.mognet@arm.com> <20200604092901.GE1551@shell.armlinux.org.uk> <jhjbllzhzg9.mognet@arm.com> <CALD-y_zQms4YQup2MgAfNhWSu=ewkhossHma2TKqfTcOFaG=uA@mail.gmail.com> <jhja71ij0xr.mognet@arm.com> <20200605081518.GG1551@shell.armlinux.org.uk>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Thara Gopinath <thara.gopinath@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: v5.7: new core kernel option missing help text
In-reply-to: <20200605081518.GG1551@shell.armlinux.org.uk>
Date:   Fri, 05 Jun 2020 11:02:00 +0100
Message-ID: <jhj7dwlj0fb.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/06/20 09:15, Russell King - ARM Linux admin wrote:
> On Thu, Jun 04, 2020 at 04:38:40PM +0100, Valentin Schneider wrote:
>> diff --git a/init/Kconfig b/init/Kconfig
>> index 74a5ac65644f..ba846f6e805b 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -439,8 +439,11 @@ config HAVE_SCHED_AVG_IRQ
>>         depends on SMP
>>
>>  config SCHED_THERMAL_PRESSURE
>> -	bool "Enable periodic averaging of thermal pressure"
>> +	def_bool n
>
> You don't need to specify this default, as the default default is "n".
> "bool" will do.
>
> You should never need to use "def_bool n" or "default n" for anything
> this simple. There are more complex cases where there may be multiple
> conditional "default" lines where it may be necessary, but the majority
> of cases where people use these are completely unnecessary.

Right, thanks!

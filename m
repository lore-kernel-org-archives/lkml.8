Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CFEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 22:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C672120774
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 22:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgHMW1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 18:27:15 -0400
Received: from foss.arm.com ([217.140.110.172]:57480 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgHMW1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 18:27:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0E5E1063;
        Thu, 13 Aug 2020 15:27:14 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BD903F22E;
        Thu, 13 Aug 2020 15:27:13 -0700 (PDT)
References: <20200812125300.11889-1-valentin.schneider@arm.com> <20200812125300.11889-3-valentin.schneider@arm.com> <20200813191614.GB2337490@gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        peterz@infradead.org, vincent.guittot@linaro.org,
        morten.rasmussen@arm.com, Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v5 02/17] ARM: Revert back to default scheduler topology.
In-reply-to: <20200813191614.GB2337490@gmail.com>
Date:   Thu, 13 Aug 2020 23:27:05 +0100
Message-ID: <jhjzh6ydvwm.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/08/20 20:16, Ingo Molnar wrote:
> * Valentin Schneider <valentin.schneider@arm.com> wrote:
>
>> The ARM-specific GMC level is meant to be built using the thread sibling
>> mask, but no devicetree in arch/arm/boot/dts uses the 'thread' cpu-map
>> binding. With SD_SHARE_POWERDOMAIN gone, this topology level can be
>> removed, at which point ARM no longer benefits from having a custom defined
>> topology table.
>>
>> Delete the GMC topology level by making ARM use the default scheduler
>> topology table. This essentially reverts commit
>>
>>   fb2aa85564f4 ("sched, ARM: Create a dedicated scheduler topology table")
>>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
>
> Minor changelog nit, it's helpful to add this final sentence:
>
>     No change in functionality is expected.
>
> ( If indeed no change in functionality is expected. ;-)
>

Right, that's indeed the case here given the GMC domain would always be
degenerated anyway.

> Thanks,
>
>       Ingo

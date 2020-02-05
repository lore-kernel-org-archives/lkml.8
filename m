Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA57C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFE8A20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="t9Jn6TzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgBEPeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:34:14 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:34740 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726933AbgBEPeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:34:13 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580916853; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=xQtXYIwOwSlgLqFKh7hxcgpzuZUdvMgwDcTJdnzHrhQ=; b=t9Jn6TzCYhYgRHZ90zjZ3cCTtzNudk8U5LHZplrRMkzbvY52ahyNxKRfqlnYoppo9blS60jW
 x9EeAqi2WYS5YOz/+ZdOL25PGWWkQQC90zHUcsu6bR9v7VKPXPrvce92sCUTnkgC6Ou3KjbI
 JLZY2t4+OLokQ9VdouuE7jzhRMg=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3ae073.7f592c4bbb58-smtp-out-n02;
 Wed, 05 Feb 2020 15:34:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CEF65C4479C; Wed,  5 Feb 2020 15:34:11 +0000 (UTC)
Received: from localhost (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ilina)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F29AAC433CB;
        Wed,  5 Feb 2020 15:34:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F29AAC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ilina@codeaurora.org
Date:   Wed, 5 Feb 2020 08:34:10 -0700
From:   Lina Iyer <ilina@codeaurora.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Maulik Shah <mkshah@codeaurora.org>
Subject: Re: [PATCH] genirq: Clarify that irq wake state is orthogonal to
 enable/disable
Message-ID: <20200205153410.GA3898@codeaurora.org>
References: <20200205060953.49167-1-swboyd@chromium.org>
 <87zhdxrzhh.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87zhdxrzhh.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05 2020 at 05:27 -0700, Thomas Gleixner wrote:
>Stephen Boyd <swboyd@chromium.org> writes:
>> There's some confusion around if an irq that's disabled with
>> disable_irq() can still wake the system from sleep states such as
>> "suspend to RAM". Let's clarify this in the kernel documentation for
>> irq_set_irq_wake() so that it's clear that an irq can be disabled and
>> still wake the system if it has been marked for wakeup.
>>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Douglas Anderson <dianders@chromium.org>
>> Cc: Lina Iyer <ilina@codeaurora.org>
>> Cc: Maulik Shah <mkshah@codeaurora.org>
>> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
>> ---
>>  kernel/irq/manage.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
>> index 818b2802d3e7..fa8db98c8699 100644
>> --- a/kernel/irq/manage.c
>> +++ b/kernel/irq/manage.c
>> @@ -731,6 +731,11 @@ static int set_irq_wake_real(unsigned int irq, unsigned int on)
>>   *
>>   *	Wakeup mode lets this IRQ wake the system from sleep
>>   *	states like "suspend to RAM".
>> + *
>> + *	Note: irq enable/disable state is completely orthogonal
>> + *	to the enable/disable state of irq wake. An irq can be
>> + *	disabled with disable_irq() and still wake the system as
>> + *	long as the irq has wake enabled.
>
>It clearly should say that this is really depending on the hardware
>implementation of the particual interrupt chip whether disabled + wake
>mode is supported.
>
Could an irqchip flag be used to warn users that we may not wakeup from
suspend/resume if the interrupt if the hardware does not support wakeup
when disabled ?

--Lina

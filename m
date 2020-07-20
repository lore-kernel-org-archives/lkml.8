Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F16C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:41:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 940712176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 07:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595230895;
	bh=Hgih/CgCT3e24D4BXc0rTqOhOL/EL2WpV/Z7aQ7NpNo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gznpWWNw/T0MOyAZzZObGIWnHAtu7tWim7xKAsBe6pYJbJPeWu6hIGiZ8oC5vRv5h
	 e/rzByY9SEkon/h9E5+qZ4saSfMLM5kCZavBo/t9KZrjnAKCz8QRlc3ZgTRTkugj4r
	 ICGqpYdFsDopkOG+mZoz4KLOMj+tM8r/P2qDKtOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgGTHle (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 03:41:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbgGTHld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 03:41:33 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10B1420773;
        Mon, 20 Jul 2020 07:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595230893;
        bh=Hgih/CgCT3e24D4BXc0rTqOhOL/EL2WpV/Z7aQ7NpNo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=1SGbqMfuj4fGfXr9apHUlnb6KelALGVLfq+i0kNUCueubOnkAeh0WT1DPFKrXDflP
         Mopdfryi8t0PQtWKHqkeR/G2apyhM4CSsJVkWarlrgchv0ONjCKYXoYSPS2SLN1lfg
         uPT0DBQt3SQeaMestOwG2l/3cM+X+ZIhda3LwLT4=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jxQQV-00DEk7-3j; Mon, 20 Jul 2020 08:41:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 20 Jul 2020 08:41:30 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, wanghaibin.wang@huawei.com
Subject: Re: [PATCH] irqchip/gic-v4.1: Ensure accessing the correct RD when
 writing INVALLR
In-Reply-To: <4d79c6f0-cb38-70fc-93e7-0172417ecbfd@huawei.com>
References: <20200709134959.1039-1-yuzenghui@huawei.com>
 <87h7u6xuur.wl-maz@kernel.org>
 <4d79c6f0-cb38-70fc-93e7-0172417ecbfd@huawei.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <18d2a3da66cd94d98dac178281f77e22@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 2020-07-20 03:27, Zenghui Yu wrote:
> Hi Marc,
> 
> On 2020/7/17 19:07, Marc Zyngier wrote:
>> On Thu, 09 Jul 2020 14:49:59 +0100,
>> Zenghui Yu <yuzenghui@huawei.com> wrote:
>>> 
>>> The GICv4.1 spec tells us that it's CONSTRAINED UNPREDICTABLE to 
>>> issue a
>>> register-based invalidation operation for a vPEID not mapped to that 
>>> RD,
>>> or another RD within the same CommonLPIAff group.
>>> 
>>> To follow this rule, commit f3a059219bc7 ("irqchip/gic-v4.1: Ensure 
>>> mutual
>>> exclusion between vPE affinity change and RD access") tried to 
>>> address the
>>> race between the RD accesses and the vPE affinity change, but somehow
>>> forgot to take GICR_INVALLR into account. Let's take the vpe_lock 
>>> before
>>> evaluating vpe->col_idx to fix it.
>>> 
>>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>> 
>> Shouldn't this deserve a Fixes: tag?
> 
> Yes, I think a
> 
> Fixes: f3a059219bc7 ("irqchip/gic-v4.1: Ensure mutual exclusion
> between vPE affinity change and RD access")
> 
> should be enough. Should I resend a version with the tag added?

Yes, please, together with a Cc: stable@vger.kernel.org, as the
original patch is in 5.7 and I intend to take it via the 5.9
branch.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

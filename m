Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBA4C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 19:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E540246B4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 19:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582919648;
	bh=yFa9GTusWGP9MI5rVwDvWIvMEuL11F9VB9eTfxoriBM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ewqdMin8FO6o2N9a1/6mMI4/5tsnkjlnw+Baz31sZjh41ykvVaq60lNIxETAnlQau
	 NcQ4teVK4rsvPnqjQ8MmCULHXP3Gbdy2HU7pkMqewGs2c+HMnKJlhys4vMwZz1I8k1
	 /6fYJdEapm6gxHfAn/U6ERUpkLMAKhTLtbKyRDaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgB1TyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 14:54:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:59750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726838AbgB1TyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 14:54:06 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57062246A3;
        Fri, 28 Feb 2020 19:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582919646;
        bh=yFa9GTusWGP9MI5rVwDvWIvMEuL11F9VB9eTfxoriBM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=B7Z/yodHUB8jE1bVpRXAyJta0eKioEPjfCw0GF3NCMjGhDN1gn5BpcyeV84YQmLg2
         PswXKPBgjSBEMksGGcEuSgtvpKJQgXX5ALZt+ywZjnvujiZTKUxDG8tYkw3UkRQYXx
         kzjfo8K+yVPrQsMIwDCyCNsChFGVJ1In0k2PcIrg=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j7li0-008qC3-Io; Fri, 28 Feb 2020 19:54:04 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Feb 2020 19:54:04 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Joe Jin <joe.jin@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq/debugfs: add new config option for trigger
 interrupt from userspace
In-Reply-To: <a4b3b41b-b0b9-03cd-c394-05d8f0bfc5f4@oracle.com>
References: <44a7007d-9624-8ac7-e0ab-fab8bdd39848@oracle.com>
 <006a08b8bfb991853ede8c9d1e29d6a7@kernel.org>
 <a4b3b41b-b0b9-03cd-c394-05d8f0bfc5f4@oracle.com>
Message-ID: <bd3f06814b4319ddaaee2bf142aaf465@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: joe.jin@oracle.com, tglx@linutronix.de, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-28 19:13, Joe Jin wrote:
> Hi Marc,
> 
> Thanks for your reply.
> 
> On 2/28/20 8:37 AM, Marc Zyngier wrote:
>> On 2020-02-28 05:42, Joe Jin wrote:
>>> commit 536e2e34bd00 ("genirq/debugfs: Triggering of interrupts from
>>> userspace") is allowed developer inject interrupts via irq debugfs, 
>>> which
>>> is very useful during development phase, but on a production system, 
>>> this
>>> is very dangerous, add new config option, developers can enable it as
>>> needed instead of enabling it by default when irq debugfs is enabled.
>> 
>> I don't really mind the patch (although it could be more elegant), but 
>> in
>> general I object to most debugfs options being set on a production 
>> kernel.
>> There is way too much information in most debugfs backends to be 
>> comfortable
>> with it, and you can find things like page table dumps, for example...
> 
> We should not enable any debug option on production system, actual 
> customer
> want to resize their BM or VM, cpu offline may lead system not works 
> properly,
> and if we knew more details of IRQ info it will be very help to 
> identify
> if it caused by IRQ/vectors, this is the motivation of we want to 
> enable it
> on production kernel.

If something doesn't work properly, then you are still debugging, 
AFAICT.

         M.
-- 
Jazz is not dead. It just smells funny...

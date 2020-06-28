Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0151C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 12:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE90120772
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 12:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593345975;
	bh=YYpHynDUNbdyuzPWVqciXZ3BfY5jlxoPDbM5nSOJXgc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=c+VF1L/5ntVTkVkFs3FwGM6lQ7R4YWNFn5A0wJv+Gioiych4kGHBnsBg29LZsJDjf
	 iPpPfBggPFZNRbWvlaeQUtgftDafqaH9OtVcVO8bIU1TwSygZhFOxQi/FuKiPncmkM
	 mu2Aw3qcfgfO07jXHa8Z8s9Z6n96emzTBCEB0FIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbgF1MGN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 08:06:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726243AbgF1MGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 08:06:13 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5411320720;
        Sun, 28 Jun 2020 12:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593345972;
        bh=YYpHynDUNbdyuzPWVqciXZ3BfY5jlxoPDbM5nSOJXgc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MJ4h4ObkgzM2MfOImYkM2zDBkG8CxbBBgA0xPCZ5EAjJQRCRZjnP4bx475Eiw8Gdq
         VejtKMpVRWGt6XOPG3o2o+p3n1LN48HQtEII9cYGSEAMXkMff/RNODtvN9UMmZfeLs
         I2jN4YxVvaGY4pm1Ey6dJNsRjEU2fesXuLz2Nbp0=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jpW4Y-00760i-K6; Sun, 28 Jun 2020 13:06:10 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Sun, 28 Jun 2020 13:06:10 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH v3 00/14 RESEND] irqchip: Fix potential resource leaks
In-Reply-To: <CAHiYmc6wmgHYm688pTFEAoyzD+nE68SPeJgCOcZLb2yRRgwGRg@mail.gmail.com>
References: <1592984711-3130-1-git-send-email-yangtiezhu@loongson.cn>
 <e419a2acea6c1977eaef5d049d607749@kernel.org>
 <CAHiYmc6wmgHYm688pTFEAoyzD+nE68SPeJgCOcZLb2yRRgwGRg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <80132dff49a64d238f775aa0bafe29e1@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: aleksandar.qemu.devel@gmail.com, yangtiezhu@loongson.cn, tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, lixuefeng@loongson.cn
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-28 12:25, Aleksandar Markovic wrote:
> сре, 24. јун 2020. у 10:40 Marc Zyngier <maz@kernel.org> је написао/ла:
>> 
>> On 2020-06-24 08:44, Tiezhu Yang wrote:
>> > [git send-email failed due to too many commands,
>> >  so only cc the major related email and resend it,
>> >  sorry for that]
>> 
>> This is becoming majorly annoying.
> 
> I don't think this is the right vocabulary to welcome newcomers,
> however "terrible" thinks they did.
> 
> Rather, patience, calmness and clear and detailed explanations would
> work much better - and certainly be much more helpful and useful to
> the community in the long run.

Pray tell how you would have handled this. I expressed *my* personal
frustration at a SNR hovering below the 25% mark. I have only indicated
that the current course of action was becoming a problem.

And instead of taking the moral high ground, maybe you could actually
share your wisdom with Teizhu and help him becoming a better 
contributor?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAEABC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 10:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF827206E9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 10:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584267222;
	bh=gwrJ6sYrbxhdQYlWtybDyVw2aNJ2RBxviyhLDiHE2Q8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=R3aooWxJFWad2oH5RE9MfcHmABTvfKOjQA4snEwwG+8bda3bnm0PRdtHSP/Fj1hUV
	 3RM5IAp3F3D+nACSpc1ft7s3hX0tcIu69ytLmLLNhNX1boW72SSdalGjQALBgHq5L3
	 DhnFBww0sDivauYhv/kxSMZlR6lG6/GS4WdBA1CM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgCOKNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 06:13:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47630 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgCOKNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 06:13:41 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D865220575;
        Sun, 15 Mar 2020 10:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584267221;
        bh=gwrJ6sYrbxhdQYlWtybDyVw2aNJ2RBxviyhLDiHE2Q8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r533RQNGnq5xSHcTxObw+9A8llarsP+7Q97TxaaPxjxkkPkxrFWt81iWLDpQpXfT5
         ufTayVCgMf/T2545wPrz3CSlPXKLRk9DrRelhD5PcBqcwpfognUg8VJkmLdZL6J6F3
         BuUwMgcOjVoWo7o0EXcdCPkZXRAjGd6ue29Z4YSI=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jDQH4-00Cqr9-Qt; Sun, 15 Mar 2020 10:13:38 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 15 Mar 2020 10:13:38 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Salter <msalter@redhat.com>,
        Robert Richter <rrichter@marvell.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] irqchip fixes for 5.6, take #2
In-Reply-To: <20200315084846.h222n5pf4jvpojec@wunner.de>
References: <20200314103000.2413-1-maz@kernel.org>
 <20200315084846.h222n5pf4jvpojec@wunner.de>
Message-ID: <76dcc2d8532f8e3a87bf03469b9c2c19@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: lukas@wunner.de, tglx@linutronix.de, catalin.marinas@arm.com, msalter@redhat.com, rrichter@marvell.com, tharvey@gateworks.com, jason@lakedaemon.net, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas,

On 2020-03-15 08:48, Lukas Wunner wrote:
> On Sat, Mar 14, 2020 at 10:30:00AM +0000, Marc Zyngier wrote:
>> This is hopefully the last irqchip update for 5.6. This time, a single
>> patch working around a hardware issue on the Cavium ThunderX and its
>> derivatives.
> 
> Hm, I was hoping to see the BCM2835 irqchip fix in this pull:
> 
> https://lore.kernel.org/lkml/f97868ba4e9b86ddad71f44ec9d8b3b7d8daa1ea.1582618537.git.lukas@wunner.de/
> 
> That patch fixes a pretty grave issue so I'd be really grateful
> if anyone could pick it up (or provide feedback why it can't be
> picked up just yet).

Whilst I don't dispute that this patch addresses a serious issue,
it is in no way an urgent fix -- the issue is already 7.5 year old,
so a couple of week delay isn't going to change the world. Also,
the system does work without this fix, so I'm quite confident
leaving it for 5.7.

But thanks for this email anyway, as it reminded me that although
I had picked that patch for 5.7, I didn't apply it just yet. This
is now fixed, and the patch should be picked up by -next shortly.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248B2C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 09:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB86120739
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 09:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584784476;
	bh=NS/N+R4zjFt1wYwXqNO17JBU2FQXg+65IRm1UhhpibY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oTdGNrt92sCUPxSf+H4FMjGXfnRabkZ3BFVURvrJeaMk3pJVmpZyr+QLtSO9YoSQ3
	 OJPc3EAGZnrXnetJXM40ttCZ2X/3Wr65mYLcFsQzD5OSX1fZU26of882yec+kddKtV
	 mq5LhyGQz+5kX3eOKczeN/hspNk2vVbsDBCmbHBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgCUJye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 05:54:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726345AbgCUJye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 05:54:34 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6A1420732;
        Sat, 21 Mar 2020 09:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584784473;
        bh=NS/N+R4zjFt1wYwXqNO17JBU2FQXg+65IRm1UhhpibY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mK+3t8pNxQDaG1R96o1v1rHlvKzydm3GJ6p68lz/bj/H5yU9RACQQY6fQszq0vLAr
         Rzlafw7j6vsvVYZiOkpYa7rzIjeTaKMH6b6Tx0Xx5BVg8tCPdogg+Bbe6UrXPj9yl3
         0HNellmJWUfWBcmCmz1wWP7/+0J6GJ9Cdt+8Q9R8=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jFapr-00ETBh-Mp; Sat, 21 Mar 2020 09:54:31 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 21 Mar 2020 09:54:31 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Heyi Guo <guoheyi@huawei.com>
Cc:     linux-kernel@vger.kernel.org, wanghaibin.wang@huawei.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH] irq/gic-its: gicv4: set VPENDING table as inner-shareable
In-Reply-To: <3de7a72f-1a15-c908-57e6-35eff00b1ca6@huawei.com>
References: <20191130073849.38378-1-guoheyi@huawei.com>
 <20191201180434.1dba3116@why>
 <3de7a72f-1a15-c908-57e6-35eff00b1ca6@huawei.com>
Message-ID: <40704a28b562167b58992c036bff4f81@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: guoheyi@huawei.com, linux-kernel@vger.kernel.org, wanghaibin.wang@huawei.com, tglx@linutronix.de, jason@lakedaemon.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heyi,

On 2020-02-24 02:22, Heyi Guo wrote:
> Hi Marc,
> 
> On 2019/12/2 2:04, Marc Zyngier wrote:
>> On Sat, 30 Nov 2019 15:38:49 +0800
>> Heyi Guo <guoheyi@huawei.com> wrote:
>> 
>>> There is no special reason to set virtual LPI pending table as
>>> non-shareable. If we choose to hard code the shareability without
>>> probing, inner-shareable will be a better choice, for all the other
>>> ITS/GICR tables prefer to be inner-shareable.
>> One of the issues is that we have strictly no idea what the caches are
>> Inner Shareable with (I've been asking for such clarification for 
>> years
>> without getting anywhere). You can have as many disconnected inner
>> shareable domains as you want!
>> 
>> I suspect that in the grand scheme of things, the redistributors
>> ought to be in the same inner shareable domain, and that with a bit of
>> luck, the CPUs are there as well. Still, that's a massive guess.
>> 
>>> What's more, on Hisilicon hip08 it will trigger some kind of bus
>>> warning when mixing use of different shareabilities.
>> Do you have more information about what the bus is complaining about?
>> Is that because the CPUs have these pages mapped as inner shareable?
>> 
>> I'll give it a go on D05 (HIP07) to find out what changes there.
> 
> How's your go on D05? Did you see any issues?

Sorry it took so long. I've given it a go on my D05, and didn't notice
anything bad (or rather, nothing worse than usual, since GICv4 on this
machine is pretty... funky).

I've now take this into the 5.7 queue.

Thanks,

          M.
-- 
Jazz is not dead. It just smells funny...

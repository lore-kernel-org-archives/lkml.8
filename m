Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE321C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904B620773
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584541001;
	bh=tCwrNUH0wEi91/ICyI3DEO7ju+O7G22DnHL/K0ZmyCA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UM61Efg7Wm9JfuKWFpNkcCNM7liULKrixHwl1Js3jhc4qDfccc/8hXk9pNZs+PhPR
	 Ep2aas91NqvoBqXVYJ7AozWz9Kc6ZJ2iVUBjlk3vwfbZgtgvU2vMbyYV3e0xu6/z6g
	 a+6TrJ85Wn7Jfv9B/J3Iv3KDmiLwNld6p4nq0lT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgCROQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:16:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:45638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbgCROQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 10:16:40 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21AD020772;
        Wed, 18 Mar 2020 14:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584540999;
        bh=tCwrNUH0wEi91/ICyI3DEO7ju+O7G22DnHL/K0ZmyCA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PSNMOXkjPBQikNc6cmKJIkreczP/pS8nYA42jW3RgdJDdAoWitLFPU7TuYPXplgic
         ttMV53POQqk7UEF0SvV74O10zCBGJ9QxOqiRh12fvL44axys2TjSPAdfIvCjvfE7hD
         5elv0MajXB5LgwubYmN5btiq7zLxlKy2n7V+TAdc=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jEZUr-00DevC-Gn; Wed, 18 Mar 2020 14:16:37 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 18 Mar 2020 14:16:37 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        chenxiang <chenxiang66@hisilicon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>, luojiaxing@huawei.com
Subject: Re: [PATCH v3 2/2] irqchip/gic-v3-its: Balance initial LPI affinity
 across CPUs
In-Reply-To: <8b141d09-ac11-34ec-0922-c21c22f94f36@huawei.com>
References: <20200316115433.9017-1-maz@kernel.org>
 <20200316115433.9017-3-maz@kernel.org>
 <2c367508-f81b-342e-eb05-8bbd1b056279@huawei.com>
 <9ce0b23455a06d92161c5302ac28152e@kernel.org>
 <8b141d09-ac11-34ec-0922-c21c22f94f36@huawei.com>
Message-ID: <7b97c24ceced7560b5acb03edaf2cd70@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: john.garry@huawei.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, chenxiang66@hisilicon.com, wangzhou1@hisilicon.com, ming.lei@redhat.com, jason@lakedaemon.net, tglx@linutronix.de, luojiaxing@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-17 18:43, John Garry wrote:
>>> 
>>>> +        int this_count = its_read_lpi_count(d, tmp);
>>> 
>>> Not sure if it's intentional, but now there seems to be a subtle
>>> difference to what Thomas described for non-managed interrupts - for
>>> non-managed interrupts, x86 selects the CPU based on the total
>>> interrupt load per CPU (or, more specifically, lowest vector
>>> allocation count), and not just the non-managed load. Or maybe I
>>> misread it.
>> 
>> So far, I'm trying to keep the two allocation paths separate, as the
>> two systems I have access to have very different behaviours: D05 has
>> no managed interrupts to speak of, and my top-secret work machine
>> has almost no unmanaged interrupts, so the two sets are almost
>> completely disjoint.
> 
> Sure, but I'd say that it would be a more common scenario to have a
> mixture of both.
> 
>> 
>> Also, it all depends on the interrupt allocation order, and whether
>> something will rebalance the non-managed interrupts at a later time.
>> At least, these two patches make it easy to alter the placement policy
>> (the behaviour you describe above is a 2 line change).
>> 
>>> Anyway, we can test this now for NVMe with its managed interrupts.
>> 
>> Looking forward to hearing from you!
>> 
> 
> On my D06CS board (128 core), there seems to be something wrong, as
> the q0 affinity mask looks incorrect:
> 
> PCI name is 81:00.0: nvme0n1
> 
> 
>         irq 322, cpu list 69, effective list 69
> 
> 
>         irq 325, cpu list 32-38, effective list 32
> 
> 
>         irq 326, cpu list 39-45, effective list 40
> 
> 
>         irq 327, cpu list 46-51, effective list 47
> 
> 
>         irq 328, cpu list 52-57, effective list 53
> 
> 
>         irq 329, cpu list 58-63, effective list 59


Sorry, can you explain in more detail what you find wrong in this log?
Is it that interrupt 322 has a single CPU affinity instead of a list?

> And something stranger for my colleague Luo Jiaxing, specifically the
> effective affinity:
> 
> PCI name is 85:00.0: nvme2n1
> irq 196, cpu list 0-31, effective list 82

Right, this one we have seen in your other email. Being a non-managed
interrupt, it lands on the closest socket.

> irq 377, cpu list 32-38, effective list 32
> irq 378, cpu list 39-45, effective list 39
> irq 379, cpu list 46-51, effective list 46
> 
> But then v5.6-rc5 vanilla also looks to have this issue when I tested
> on my board:
> 
> john@ubuntu:~$ more /proc/irq/322/smp_affinity_list
> 
> 
> 69
> 
> My D06ES (96 core) board looks sensible for the affinity in this
> regard (I did not try vanilla v5.6-rc5, but only with your patches on
> top). I'll need to debug this.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DD8C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFFF21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583932718;
	bh=G4uTYK2xRhHMdOjbTICLxaFDjb8wtIesdVb4/zO0XI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FfRlMyiSe/lrvwveaXtMlT+1uoUXy6V4avfpmmscWaZPHrS526lmc99h1Kdv0l5dq
	 FL1qPNVtqLL5oMHU+Rw88Zb0Hml5+v5gUbinbdg3klVgMeNf3UaRyKc9/ifvN02lWS
	 E/9J/sOq2FgDTE/8T8bFy0KTQ5/h3CtZPpqeNF/Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbgCKNSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 09:18:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729232AbgCKNSg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 09:18:36 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30F6721D56;
        Wed, 11 Mar 2020 13:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583932716;
        bh=G4uTYK2xRhHMdOjbTICLxaFDjb8wtIesdVb4/zO0XI8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VKKNuK8dxXBa204Ij7VVdQzQmls+EBquSanejRNiG+ZiKfUhtgpN1q97o7/frr77E
         q4JgWrpE+hFhZdmHQKTgxbHA5skjc98gmZCAGUrgESWdCUYwykl5nqc+64x5qpq/5f
         OXP5tSl0pSa/Vj3rAxghB8amnqHTOPWrHOVMX28M=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jC1Fq-00Buul-IR; Wed, 11 Mar 2020 13:18:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 11 Mar 2020 13:18:34 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Jason Cooper <jason@lakedaemon.net>,
        Ming Lei <ming.lei@redhat.com>,
        "chenxiang (M)" <chenxiang66@hisilicon.com>
Subject: Re: [PATCH] irqchip/gic-v3-its: Balance initial LPI affinity across
 CPUs
In-Reply-To: <e65af3fd-e7c8-bd9b-75ff-f2d990338221@huawei.com>
References: <20200119190554.1002-1-maz@kernel.org>
 <5d04d904-d7ea-04ea-ac3b-8cdc90074a92@huawei.com>
 <afb60c5f9a176470449a83126db326a9@kernel.org>
 <83eb55b0-2f2d-3335-85cf-6d7ed379b3c7@huawei.com>
 <7dc37b35d8ec6c78e75969d8c6c2d2e9@kernel.org>
 <87h80q2aoc.fsf@nanos.tec.linutronix.de>
 <e65af3fd-e7c8-bd9b-75ff-f2d990338221@huawei.com>
Message-ID: <1d7a7c445538c8352fc2391a06184b59@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: john.garry@huawei.com, tglx@linutronix.de, linux-kernel@vger.kernel.org, jason@lakedaemon.net, ming.lei@redhat.com, chenxiang66@hisilicon.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-10 11:33, John Garry wrote:

[...]

> Hi Marc,
> 
> I was wondering if there is anything we can do to progress this patch?
> 
> Apart from being a good change in itself, I need to do some SMMU
> testing for nextgen product development and I would like to include
> this patch, most preferably from mainline.

Let me revive it and see how to apply a similar logic as what Thomas
was describing. Shouldn't take too long...

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

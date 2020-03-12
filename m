Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD19C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAEBF206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584028578;
	bh=oGArRq0tEnTFcgyoMZa37IAaS/3wFGT2DjTjAcSByts=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SR0YhbQ70qX3JWvj0tbc9sc+ofRhZxk7HdQJRCejXowdoVLlYJImZfmM51A0IXL+g
	 vApE2qM8+OR+FKDCDutC4Y6ZxPLEkhSBPAsOgwXrgQiK+e9m9FbAa9DQ4SB1VCsOjE
	 etzGpN0AuSlyvCQm8Ujbn9tyH7wYuhGzEmcT38Co=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgCLP4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:56:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:55644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbgCLP4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 11:56:17 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 939EA2067C;
        Thu, 12 Mar 2020 15:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584028576;
        bh=oGArRq0tEnTFcgyoMZa37IAaS/3wFGT2DjTjAcSByts=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0v5Gtpi6PGscvk86Ol+1eanIx4sNKYpwoYHBt5ybPAFdYm8Rh9U4azp+iEWMGtW8g
         Ppgl3SMsLAAwa9x/Uy9i8VqVqhgj6s785tv2kcnNrEM9EXW9o0sBFv4iCPMlnNAy4I
         nahjkW7VAd1CSjXorfRqqZBvPEXIR3yCQTKR5UUU=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jCQBy-00CGGM-Sp; Thu, 12 Mar 2020 15:56:15 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 12 Mar 2020 15:56:14 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Ming Lei <ming.lei@redhat.com>,
        chenxiang <chenxiang66@hisilicon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH v2] irqchip/gic-v3-its: Balance initial LPI affinity
 across CPUs
In-Reply-To: <d23436b5-a207-91e9-be11-f5d0e44b6e12@huawei.com>
References: <20200312115552.29185-1-maz@kernel.org>
 <d23436b5-a207-91e9-be11-f5d0e44b6e12@huawei.com>
Message-ID: <33bc00d1ba25d5fd53de2413c831d723@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: john.garry@huawei.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net, ming.lei@redhat.com, chenxiang66@hisilicon.com, wangzhou1@hisilicon.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 2020-03-12 15:41, John Garry wrote:
> On 12/03/2020 11:55, Marc Zyngier wrote:
> 
> Hi Marc,
> 
>> When mapping a LPI, the ITS driver picks the first possible
>> affinity, which is in most cases CPU0, assuming that if
>> that's not suitable, someone will come and set the affinity
>> to something more interesting.
>> 
>> It apparently isn't the case, and people complain of poor
>> performance when many interrupts are glued to the same CPU.
>> So let's place the interrupts by finding the "least loaded"
>> CPU (that is, the one that has the fewer LPIs mapped to it).
>> So called 'managed' interrupts are an interesting case where
>> the affinity is actually dictated by the kernel itself, and
>> we should honor this.
>> 
>> Reported-by: John Garry <john.garry@huawei.com>
>> Link: 
>> https://lore.kernel.org/r/1575642904-58295-1-git-send-email-john.garry@huawei.com
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> Cc: John Garry <john.garry@huawei.com>
>> Cc: Ming Lei <ming.lei@redhat.com>
>> ---
>> Reviving this at John's request.
> 
> Thanks very much. I may request a colleague test this due to possible
> precautionary office closure.

Huh. Not great... :-(

> 
>  The major change is that the
>> affinity follows the x86 model, as described by Thomas.
> 
> There seems to be a subtle difference between this implementation and
> what Thomas described for managed interrupts handling on x86. That
> being, managed interrupt loading is counted separately to total
> interrupts per CPU for x86. That seems quite important so that we
> spread managed interrupts evenly.

Hmmm. Yes. That'd require a separate per-CPU counter. Nothing too 
invasive
though. I'll roll that in soon. I still wonder about interaction of 
collocated
managed and non-managed interrupts, but we can cross that bridge later.

>> I expect this to have an impact on platforms like D05, where
>> the SAS driver cannot use managed affinity just yet.
> 
> I need some blk-mq and SCSI changes to go in first to improve the
> interrupt handling there, hopefully we can make progress on that soon.

That'd be good.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

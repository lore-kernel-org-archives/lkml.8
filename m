Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007FBC352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D392E2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587057831;
	bh=Dnm0mMP7sM6v2yRBoZW9YSazaAPo3hTRbZ0BkC844Z0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PGBbyftgO9gWCEoazoxpz4ViNteYK6bCiXWVQeSPdQhTtsZ1jceOA1FPN+1MSx6M/
	 OCyWfqROlbwhzPYlQJj7GVvJ4aS8NjXOo6wOonGU9z+TN1+XQ/4Yebrq46Yl1nrd70
	 T9M4+D8X0EXnXeFze6S1WwphTJ8gYMz6xxctX7As=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392028AbgDPRXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 13:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390655AbgDPRXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 13:23:47 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 621042076D;
        Thu, 16 Apr 2020 17:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587057826;
        bh=Dnm0mMP7sM6v2yRBoZW9YSazaAPo3hTRbZ0BkC844Z0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rkLhDD4qLp8KP0RMHSLSNkm+a9R8itTqzZcRU6uHqEpSdfcDBpKQU4gy+moAUKA6s
         K3q0EbbWzED59GDX/yx+5pTv9236qIu06jiOhGUfN0KnGmhFU4mqZb9204qDbu2jwM
         WXbUH9EgXwILz6UIGPvBkmqXKhZHwZIkkj2z+KQ4=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jP8Eq-003x6L-Pt; Thu, 16 Apr 2020 18:23:44 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 16 Apr 2020 18:23:44 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     kvmarm@lists.cs.columbia.edu, james.morse@arm.com,
        julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com,
        wanghaibin.wang@huawei.com, yezengruan@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: arm64: vgic-its: Fix memory leak on the error
 path of vgic_add_lpi()
In-Reply-To: <610f2195-f85d-4beb-b711-47d63bb393d0@huawei.com>
References: <20200414030349.625-1-yuzenghui@huawei.com>
 <20200414030349.625-3-yuzenghui@huawei.com>
 <610f2195-f85d-4beb-b711-47d63bb393d0@huawei.com>
Message-ID: <2173e13527cc9578838f0364ad29f6cc@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, kvmarm@lists.cs.columbia.edu, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, wanghaibin.wang@huawei.com, yezengruan@huawei.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-16 02:17, Zenghui Yu wrote:
> On 2020/4/14 11:03, Zenghui Yu wrote:
>> If we're going to fail out the vgic_add_lpi(), let's make sure the
>> allocated vgic_irq memory is also freed. Though it seems that both
>> cases are unlikely to fail.
>> 
>> Cc: Zengruan Ye <yezengruan@huawei.com>
>> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
>> ---
>>   virt/kvm/arm/vgic/vgic-its.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>> 
>> diff --git a/virt/kvm/arm/vgic/vgic-its.c 
>> b/virt/kvm/arm/vgic/vgic-its.c
>> index d53d34a33e35..3c3b6a0f2dce 100644
>> --- a/virt/kvm/arm/vgic/vgic-its.c
>> +++ b/virt/kvm/arm/vgic/vgic-its.c
>> @@ -98,12 +98,16 @@ static struct vgic_irq *vgic_add_lpi(struct kvm 
>> *kvm, u32 intid,
>>   	 * the respective config data from memory here upon mapping the 
>> LPI.
>>   	 */
>>   	ret = update_lpi_config(kvm, irq, NULL, false);
>> -	if (ret)
>> +	if (ret) {
>> +		kfree(irq);
>>   		return ERR_PTR(ret);
>> +	}
>>     	ret = vgic_v3_lpi_sync_pending_status(kvm, irq);
>> -	if (ret)
>> +	if (ret) {
>> +		kfree(irq);
>>   		return ERR_PTR(ret);
>> +	}
> 
> Looking at it again, I realized that this error handling is still not
> complete. Maybe we should use a vgic_put_irq() instead so that we can
> also properly delete the vgic_irq from lpi_list.

Yes, this is a more correct fix indeed. There is still a bit of a 
bizarre
behaviour if you have two vgic_add_lpi() racing to create the same 
interrupt,
which is pretty dodgy anyway (it means we have two MAPI at the same 
time...).
You end-up with re-reading the state from memory... Oh well.

> Marc, what do you think? Could you please help to fix it, or I can
> resend it.

I've fixed it as such (with a comment for a good measure):

diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 3c3b6a0f2dce..c012a52b19f5 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -96,16 +96,19 @@ static struct vgic_irq *vgic_add_lpi(struct kvm 
*kvm, u32 intid,
  	 * We "cache" the configuration table entries in our struct 
vgic_irq's.
  	 * However we only have those structs for mapped IRQs, so we read in
  	 * the respective config data from memory here upon mapping the LPI.
+	 *
+	 * Should any of these fail, behave as if we couldn't create the LPI
+	 * by dropping the refcount and returning the error.
  	 */
  	ret = update_lpi_config(kvm, irq, NULL, false);
  	if (ret) {
-		kfree(irq);
+		vgic_put_irq(kvm, irq);
  		return ERR_PTR(ret);
  	}

  	ret = vgic_v3_lpi_sync_pending_status(kvm, irq);
  	if (ret) {
-		kfree(irq);
+		vgic_put_irq(kvm, irq);
  		return ERR_PTR(ret);
  	}


Let me know if you agree with that.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

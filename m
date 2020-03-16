Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1457DC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 11:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2E8B20719
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 11:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584356946;
	bh=7GnxZNUgFtH4VyMWdhOlCXj+A6q4k8+r/Ert4LPiEUg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YjkdPalx+2yq3vdcEi9hXRWBthUZ92AsiDPp/fpAA/FcBIbtTk5cmjZ5Ou5eOyT+K
	 MolotrpZHpCbVF/4Uk4bpTzpPGjKKnYRnGpuU20sqaB66TGhV5btWHo+7okSK0QCsY
	 Na3lu9vK0VMiYGhGmME3niLHAcX5HhlGS0HbwTqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbgCPLJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 07:09:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730693AbgCPLJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 07:09:05 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0371C205ED;
        Mon, 16 Mar 2020 11:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584356945;
        bh=7GnxZNUgFtH4VyMWdhOlCXj+A6q4k8+r/Ert4LPiEUg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fXh7WLR86Zz7FIHD9/0xetiYssyqwbwXtbSusOmYKXIZUVB57528z/q+NGy6FA0zS
         uyFKf/ZYX3TH9TVaLtgy7bkAZvRI9/ESDSsLxCKo6SlK4RTHvEF9LJgvNHauqpITXU
         3IRFo6Uwdgo4ma5B8B81byHZPU6ckH3rloLCWW5Y=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jDncF-00D3fu-D8; Mon, 16 Mar 2020 11:09:03 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Mar 2020 11:09:03 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     KarimAllah Ahmed <karahmed@amazon.de>,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] KVM: arm64: Use the correct timer for accessing CNT
In-Reply-To: <7ed91b9b-e968-770c-28f9-0ca479359657@huawei.com>
References: <1584351546-5018-1-git-send-email-karahmed@amazon.de>
 <7ed91b9b-e968-770c-28f9-0ca479359657@huawei.com>
Message-ID: <a8b72d6c0a28e0554050e98d011f32d9@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, karahmed@amazon.de, linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 2020-03-16 10:49, Zenghui Yu wrote:
> Hi,
> 
> On 2020/3/16 17:39, KarimAllah Ahmed wrote:
>> Use the physical timer object when reading the physical timer counter
>> instead of using the virtual timer object. This is only visible when
>> reading it from user-space as kvm_arm_timer_get_reg() is only executed 
>> on
>> the get register patch from user-space.
> 
> s/patch/path/
> 
> I think the physical counter hasn't yet been accessed by the current
> userspace, wrong?

I don't think userspace can access it, as the ONE_REG API only exposes 
the virtual
timer so far, and userspace is much better off just reading the counter 
directly
(it has access to the virtual counter, and the guarantee that cntvoff is 
0 in this
context).

But as we move towards a situation where we can save/restore the 
physical timer
just like the virtual one, we're going to use this path and hit this 
bug.

> 
>> 
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
>> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: kvmarm@lists.cs.columbia.edu
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> 
> Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
> 
> And this might also deserve:
> 
> Fixes: 84135d3d18da ("KVM: arm/arm64: consolidate arch timer trap 
> handlers")

Indeed. Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

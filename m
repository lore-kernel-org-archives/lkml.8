Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A66C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84DC020890
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592561200;
	bh=DWSDBScNwddwzZeNQuc8t3eZi3YeAqlJ80SvLgG6nS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UTieplMCXJLYCrcXSA6IhT7GrhsUo7Uw22YMtPGMhQQmWMYGjdvRCIxP9e7uEIUsq
	 E0IC3dwilOVFMmltrkMVshduNv8zLDpywQbwUGrLctnk1Ri5CLA0E5wc6bVeyGryHQ
	 FrOx5UeVthvpCe3rPrs4+4v9c8BQrIwDV86SAE1o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732275AbgFSKGj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 06:06:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729195AbgFSKGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 06:06:38 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE8E52073E;
        Fri, 19 Jun 2020 10:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592561197;
        bh=DWSDBScNwddwzZeNQuc8t3eZi3YeAqlJ80SvLgG6nS8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qIufNTZj6yHfnPnBRaf2owSdXt7OVv7IpCYl31/NDFk71OtOv+pZZqp0d8gLcdubc
         TDzWmk0gLtWleYLotZ1fKE9J16A0E/65QArtUQm0riJj+wYsYWhuzvh/TDqu6dmvam
         KkjDqDbCPnaAwVGwUECfJZMmVIuxBpYakWWlymGQ=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jmDuu-004QT8-7C; Fri, 19 Jun 2020 11:06:36 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 19 Jun 2020 11:06:36 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, android-kvm@google.com,
        kernel-team@android.com
Subject: Re: [PATCH v3 02/15] arm64: kvm: Move __smccc_workaround_1_smc to
 .rodata
In-Reply-To: <20200619095120.wenkbs5bl3wbyiyh@google.com>
References: <20200618122537.9625-1-dbrazdil@google.com>
 <20200618122537.9625-3-dbrazdil@google.com>
 <02322fdac903aa1786c334d0ddd7f38a@kernel.org>
 <20200619095120.wenkbs5bl3wbyiyh@google.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <eac273f8f0801969c650a3bd78052e0a@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, will@kernel.org, catalin.marinas@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, android-kvm@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-19 10:51, David Brazdil wrote:
> Hey Marc,
> 
>> > -	.popsection
>> 
>> I'd be tempted to leave the .popsection in place, if only for symmetry 
>>  with
>> the initial .pushsection.
> 
> I removed it because other .S files don't pop either. It must have been 
> added
> here purely for the smccc workaround code. Happy to add it back if you 
> prefer,
> but the pushsection is removed later in the series, so this would 
> disappear
> as well.

Don't bother then.

> 
>> > +	.pushsection	.rodata
>> > +	.global		__smccc_workaround_1_smc
>> > +__smccc_workaround_1_smc:
>> 
>> You probably want to replace this with SYM_DATA_START (and 
>> SYM_DATA_END at
>> the end).
> 
> Done

Thanks!

         M.
-- 
Jazz is not dead. It just smells funny...

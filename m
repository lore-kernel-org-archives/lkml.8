Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE08C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13032206D6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587050821;
	bh=9UZrlX86YbwbreLTFi5YKGq3YhBn1+9uHoeSBBf886o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=auDVwaT/vEXmzwmIzT9/Njl2UjVQ5LHtty4xFSLcoXEB0Jm1dv7SaIvcG2F9wpxjW
	 UwSGEPL3flNexyVdnlWNb6HvT5DR5UDWBVeU83m2i76MD94aJ6uUZZh0y0mzZi5nOZ
	 /lEPTrwyBIgjwpoPUQiuXxAupPj3wUuMS3zw3Mzw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410283AbgDPP1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:27:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391156AbgDPP0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:26:08 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 203D7214D8;
        Thu, 16 Apr 2020 15:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587050767;
        bh=9UZrlX86YbwbreLTFi5YKGq3YhBn1+9uHoeSBBf886o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Wro98QecVB/0yTP1mFZaDqaN8sf50x8/37MZzrvNgiLKrQBlnQ6sup5XaruO0XJ92
         Ov5TZHt+/at8yAP5S0jEpEatpociE0KfOEDnJhmaFF8XEYMeoULpW57GUqGQWwHoJs
         gxSvPKSjW6ewRrdRcYKlexr5vTiEok4qN9+lJFbQ=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jP6Oz-003uSn-HM; Thu, 16 Apr 2020 16:26:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 16 Apr 2020 16:26:05 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, saiprakash.ranjan@codeaurora.org,
        dianders@chromium.org, kernel-team@android.com
Subject: Re: [PATCH 8/8] arm64: cpufeature: Add an overview comment for the
 cpufeature framework
In-Reply-To: <96dd797d-ccfe-c867-0a70-65eccacde3cd@arm.com>
References: <20200414213114.2378-1-will@kernel.org>
 <20200414213114.2378-9-will@kernel.org>
 <96dd797d-ccfe-c867-0a70-65eccacde3cd@arm.com>
Message-ID: <96438d59a2bc05871ef68fca475fabf5@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: suzuki.poulose@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, mark.rutland@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com, saiprakash.ranjan@codeaurora.org, dianders@chromium.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-16 15:59, Suzuki K Poulose wrote:

Hi Suzuki,

[...]

> As you mentioned in the other response we could add information about
> the guest view, something like :
> 
>       - KVM exposes the sanitised value of the feature registers to the
> 	guests and is not affected by the FTR_VISIBLE. However,
> 	depending on the individual feature support in the hypervisor,
> 	some of the fields may be capped/limited.

Although in most cases, what KVM exposes is indeed a strict subset of
the host's features, there is a few corner cases where we expose 
features
that do not necessarily exist on the host. For example ARMv8.5-GTG and
ARMv8.4-TTL get exposed by the NV patches even if they don't exist on 
the
host, as KVM will actually emulate them.

Not a big deal, but I just wanted to outline that it isn't as clear-cut 
as
it may seem...

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...

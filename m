Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3A1C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 07:28:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D429B208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 07:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579159733;
	bh=pRRQpXth0TXpHnnIZoTynOLbI277epXRK/djArfkqqg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RIJUs2EOGxpPweFXK4X7F6FptefITtxfYpuYeK8f/sqNYv6ZcfXmDwC4bDT/+2tFw
	 sMQvib3SXHQ8QhhQbSCAhBARaqWLyzq6FG7l4VhgqikG/lkZR/Xb9B1iVJdFv+Esoq
	 OCnKUyYKUt6Oy/IFfGCRTivx9Jvc8QQgCdk1fPXI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730753AbgAPH2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 02:28:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:58968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730088AbgAPH2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 02:28:52 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CF10206D9;
        Thu, 16 Jan 2020 07:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579159731;
        bh=pRRQpXth0TXpHnnIZoTynOLbI277epXRK/djArfkqqg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hS8dlpQ99rHWL0kTk5ZTYzoWlF+J25ZQgpqOCCSNP9QRRFrh4ST6wgTBWIxY18DIE
         LNp5gkGHlGi2/6LMyenbRn4s8rV1IGTp2AusKhQwbPGYgRWzfoJ9Z8HfxtqWPQToBi
         QmN3YnO0LOt/4zJx8GDSRa1AKsyKkXQy3cdeZPCE=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1irzaD-00058d-LD; Thu, 16 Jan 2020 07:28:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 16 Jan 2020 07:28:49 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Steven Price <steven.price@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v5 0/3] arm64: Workaround for Cortex-A55 erratum 1530923
In-Reply-To: <20200114164543.GD2579@willie-the-truck>
References: <20191216115631.17804-1-steven.price@arm.com>
 <20200114164543.GD2579@willie-the-truck>
Message-ID: <3292551ef07b2c5354d48faedad849ff@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, steven.price@arm.com, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-14 16:45, Will Deacon wrote:
> On Mon, Dec 16, 2019 at 11:56:28AM +0000, Steven Price wrote:
>> Version 5 is a rebasing of version 4 (no changes).
>> 
>> This series enables a workaround for Cortex-A55 erratum 1530923. The
>> erratum potentially allows TLB entries to be allocated as a result of 
>> a
>> speculative AT instruction. This may happen in the middle of a guest
>> world switch while the relevant VMSA configuration is in an 
>> inconsistent
>> state, leading to erroneous content being allocated into TLBs.
>> 
>> There are existing workarounds for similar issues, 1165522 is
>> effectively the same, and 1319367/1319537 is similar but without VHE
>> support.  Rather than add to the selection of errata, the first patch
>> renames 1165522 to WORKAROUND_SPECULATIVE_AT which can be reused (in 
>> the
>> final patch) for 1530923.
>> 
>> The workaround for errata 1319367 and 1319537 although similar cannot
>> use VHE (not available on those CPUs) so cannot share the workaround.
>> However, to keep some sense of symmetry the workaround is renamed to
>> SPECULATIVE_AT_NVHE.
>> 
>> Changes since v4:
>>  * Rebased to v5.5-rc1
> 
> Looks fine to me. Marc, are you ok with me queueing this via arm64 
> (that's
> where the existing workarounds came from), or would you prefer to take 
> them
> via kvm-arm?

Please go ahead and take it (with my ack) via the arm64 tree.

Thanks,

        M.
-- 
Jazz is not dead. It just smells funny...

Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF2DC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5028D20775
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586940966;
	bh=lL08kyfy+9y5wE4bT7FrtRAP9e6Jx76z4bGDZo1tk4s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sTSE5hiCPxso1yrIGu2b7CXAjnOSh3XslGfuYV3vIEWQQTBeGh5JTw59QjfhocHXD
	 71FsZfyEn5CpX/bICi9Jm23YZ5A1+E7ag6hIKIdJGuCn4M6B4JH1ZDCDs2938DRqwx
	 w6Jd6Y5Gvg0e06i+a2pNfCPWQ5C9KWYJ++sqyP18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405252AbgDOI4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:56:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:41700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404988AbgDOI4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:56:00 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 900C520737;
        Wed, 15 Apr 2020 08:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586940959;
        bh=lL08kyfy+9y5wE4bT7FrtRAP9e6Jx76z4bGDZo1tk4s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zPVuO2lg9Bf7O4AyeHVkBbTdBcjJ0l9TTPg+WqJ1AqZYtX9Ksbab4hxQBuS6PhOcz
         nG946f+z2ldlNfsBvYalLoWeuksyMjcQaVfN7Vrfos3ZdMA9haxjGQx7k25dNYi8JR
         3SG+qQmED0JCKXDh2wrsKH9jJipvG+N1lrNGpk3o=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jOdpt-003Rlm-Ss; Wed, 15 Apr 2020 09:55:58 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 15 Apr 2020 09:55:57 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Doug Anderson <dianders@chromium.org>, kernel-team@android.com
Subject: Re: [PATCH 3/8] arm64: cpufeature: Add CPU capability for AArch32 EL1
 support
In-Reply-To: <20200414213114.2378-4-will@kernel.org>
References: <20200414213114.2378-1-will@kernel.org>
 <20200414213114.2378-4-will@kernel.org>
Message-ID: <1b76993491176577567a0960a435dac0@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, suzuki.poulose@arm.com, mark.rutland@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com, saiprakash.ranjan@codeaurora.org, dianders@chromium.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 2020-04-14 22:31, Will Deacon wrote:
> Although we emit a "SANITY CHECK" warning and taint the kernel if we
> detect a CPU mismatch for AArch32 support at EL1, we still online the
> CPU with disastrous consequences for any running 32-bit VMs.
> 
> Introduce a capability for AArch32 support at EL1 so that late onlining
> of incompatible CPUs is forbidden.
> 
> Signed-off-by: Will Deacon <will@kernel.org>

Definitely an improvement over the current situation, as the direct read
of ID_AA64PFR0 was always a bit dodgy. Given that I'm pretty sure these 
new
braindead SoCs are going to run an older version of the kernel, should 
we
Cc stable for this?

Otherwise:

Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...

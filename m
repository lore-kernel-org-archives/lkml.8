Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C696DC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 954C72083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 15:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588864558;
	bh=ux/WK4BgpiCCy4diPu3bKfY8AWDQXyNVDGkRY8G5x9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=s4N/qPpSuwrrvv4Ak2yCOQICap6IjbOkJoafS9A+4d6cFwUk5YWVBvLL4l4GcuaKC
	 h4jjCr6k9ZWqUd/vL8TKCIn+dfFm4A7+T5g1QFGtOLHDVCdj8kGse97TsFkLVwl6SV
	 Py7JnP44kQpXnk/GWf2Kkb1T+9g8kvyed6uOYgl8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgEGPP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 11:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:44054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgEGPP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 11:15:57 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D392B207DD;
        Thu,  7 May 2020 15:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588864557;
        bh=ux/WK4BgpiCCy4diPu3bKfY8AWDQXyNVDGkRY8G5x9M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zudqrwOEUY4DrnXjGQ98u/M9JwOEVc2mYKgd2qyD6usz0b0wVhGN/ItZFzVXLo0R7
         bP62RQIzzwzc3uL2VJdZi2SHW+rxNi7LR0aaVg4gaXWAOjCUwANHAFCk9luv2am+7G
         +BzQ4FAUUMp2mZIeSATcsMXvjbtawZA3Rrhf9u5k=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jWiFf-00AJoN-6T; Thu, 07 May 2020 16:15:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 07 May 2020 16:15:55 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>, kvmarm@lists.cs.columbia.edu,
        Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: Re: [PATCH 05/15] arm64: kvm: Build hyp-entry.S separately for
 VHE/nVHE
In-Reply-To: <87imh72379.wl-maz@kernel.org>
References: <20200430144831.59194-1-dbrazdil@google.com>
 <20200430144831.59194-6-dbrazdil@google.com> <87imh72379.wl-maz@kernel.org>
User-Agent: Roundcube Webmail/1.4.3
Message-ID: <df5bf1943851715130517c43fde8e5a9@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, james.morse@arm.com, linux-arm-kernel@lists.infradead.org, will@kernel.org, kvmarm@lists.cs.columbia.edu, julien.thierry.kdev@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-07 16:07, Marc Zyngier wrote:
> On Thu, 30 Apr 2020 15:48:21 +0100,
> David Brazdil <dbrazdil@google.com> wrote:

[...]

>> hyp-entry.S contains implementation of KVM hyp vectors. This code is 
>> mostly
>> shared between VHE/nVHE, therefore compile it under both VHE and nVHE 
>> build
>> rules, with small differences hidden behind '#ifdef __HYPERVISOR__'. 
>> These are:
>>   * only nVHE should handle host HVCs, VHE will now panic,
> 
> That's not true. VHE does handle HVCs from the guest. If you make VHE
> panic on guest exit, I'll come after you! ;-)

Duh, I can't read. "host HVCs". You can relax. ;-)

         M.
-- 
Jazz is not dead. It just smells funny...

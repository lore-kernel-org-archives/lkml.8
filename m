Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E7DC11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5838208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582208500;
	bh=lceTBKXrhIYb6VxrwOKtVPslg2/v6WjO9hyREWwD78k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=E4RDCHpxScffOjlot8FBwPGwIVwLJ1dGN/9I4Jv/s5rVWe2ndMvmXYtlSs6PmI4Gq
	 XCA4+uLevwYkLZGsPxnvd+q3jT7aBCWgRdQeMAMU2kNqStIp5bERPSzd4U5HtuD4I8
	 ThrSI0P85CxMlY6+MDvO6NafJLgzwr/InQcHUQjw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728211AbgBTOVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:21:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:43460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726959AbgBTOVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:21:39 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7137D207FD;
        Thu, 20 Feb 2020 14:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582208498;
        bh=lceTBKXrhIYb6VxrwOKtVPslg2/v6WjO9hyREWwD78k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZbXXsMBsRyyIBeBmreTW8DQoMBPi3cWz8+SDX7nxLdE+hS/KR2082sCu/jViS+roU
         Ns6+qz/61WTOexKFZoJKNOz7TkGffZo/4+ASyu2gbwfPo5VxOSPTF5+wgewh3DVkOZ
         pO/PtLbsZkbcFnq5TiyT5/oB2JKvMRaUrt4nV6jw=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j4mhs-006kHV-QE; Thu, 20 Feb 2020 14:21:36 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Feb 2020 14:21:36 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     minyard@acm.org
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Corey Minyard <cminyard@mvista.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64:kgdb: Fix kernel single-stepping
In-Reply-To: <20200219152403.3495-1-minyard@acm.org>
References: <20200219152403.3495-1-minyard@acm.org>
Message-ID: <1416dca51b52dff349923184f41d48e8@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: minyard@acm.org, will@kernel.org, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, cminyard@mvista.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-19 15:24, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>

[...]

> After studying the EL0 handling for this, I realized an issue with 
> using
> MDSCR to check if single step is enabled: it can be expensive on a VM.
> So check the task flag first to see if single step is enabled.  Then
> check MDSCR if the task flag is set.

Very tangential remark: I'd really like people *not* to try and optimize
Linux based on the behaviour of a hypervisor. In general, reading a
system register is fast, and the fact that it traps on a given 
hypervisor
at some point may not be true in the future, nor be a valid assumption
across hypervisors.

         M.
-- 
Jazz is not dead. It just smells funny...

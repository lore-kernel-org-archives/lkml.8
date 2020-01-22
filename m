Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01108C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:56:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D439F21835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579719407;
	bh=A1sveuLlqqQKceZWUAfaJuEVgzcWTxZ9DNy4YwMID1M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=UMZtRDTbB/vsWyzjQcVPXJknYrp8nHFajDpJSt8SKxk6Fr4lFY1z0FcXh370V/u0x
	 9oYapRIJH15xsomNQ+ydOyrnet6BQhIwXqE1lIQ5IVMrujY8mdEBdPh8LOa7VMFlPI
	 BZKifXWoXA4d7/E698coZBPbOfRLsqbetWIjkUYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729400AbgAVS4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 13:56:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:57788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729268AbgAVS4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 13:56:40 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F26B121835;
        Wed, 22 Jan 2020 18:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579719400;
        bh=A1sveuLlqqQKceZWUAfaJuEVgzcWTxZ9DNy4YwMID1M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QZ8CdyDm7SZ5aEnXV0NmjiW3eVtkqaHu+EdT4hcHHRfmTQZepyKl8Hrn/qG/z4MdD
         xT/kCCT1tnBwgq5siEH90jGhstBx1yUgCoGOjf+4XEkIbP3lXVvA1jGuk1qQSDq7LQ
         0/t5wVmcbzzRXcOeast0al9DP3vMqfgwn8b9JF00=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1iuLB8-000o1p-9q; Wed, 22 Jan 2020 18:56:38 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 22 Jan 2020 18:56:38 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>, Mike Rapoport <rppt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 0/1] arm/arm64: add support for folded p4d page tables
In-Reply-To: <20200122185017.GA17321@willie-the-truck>
References: <20200113111323.10463-1-rppt@kernel.org>
 <20200122185017.GA17321@willie-the-truck>
Message-ID: <cb6357040bd5d9fa061a8d3bd96fb571@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, rppt@kernel.org, linux-arm-kernel@lists.infradead.org, anshuman.khandual@arm.com, catalin.marinas@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, linux@armlinux.org.uk, suzuki.poulose@arm.com, kvmarm@lists.cs.columbia.edu, linux-mm@kvack.org, linux-kernel@vger.kernel.org, rppt@linux.ibm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-22 18:50, Will Deacon wrote:
> On Mon, Jan 13, 2020 at 01:13:22PM +0200, Mike Rapoport wrote:
>> From: Mike Rapoport <rppt@linux.ibm.com>
>> 
>> This is a part of clean up of the page table manipulation code that 
>> aims to
>> remove asm-generic/5level-fixup.h and asm-generic/pgtable-nop4d-hack.h
>> 
>> There is a single patch for both arm and arm64 because doing the 
>> conversion
>> separately would mean breaking the shared mmu bits in virt/kvm/arm.
> 
> Unfortunately, that's going to be really hard to merge, as the two
> architectures are maintained in different trees and the breadth of this
> patch series is likely to lead to conflicts in both.

But maybe this is the reason we've all been waiting for, for which we
sacrifice 32bit KVM host on the altar of progress, and finally move 
along.

Will and I are the only known users, and that'd be a good incentive to
experience some if this 64bit goodness... ;-)

         M.
-- 
Jazz is not dead. It just smells funny...

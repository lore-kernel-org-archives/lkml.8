Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2589C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F6E024673
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579780755;
	bh=sPgVONfMBssyrYeOuNYXulKqcfSKytB9nRTLqgRxmS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ufBnBKW6N40g9G5fM4fqM6b/wFT9qI1Vneb6+Ie09sUV6eLwUfNPj7GuSBdUbRw32
	 v7aT6Bq2YcdYiSWUS+WMucWX76LyhsRe43gq4AZF6xi7jlATyJAr+xYc6K+jxuc1qq
	 7UhN6rEj7RiBDCheoODS6X4Qjlf2nucFre90aD/g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgAWL7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:59:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:56986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgAWL7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:59:14 -0500
Received: from hump.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACD3320704;
        Thu, 23 Jan 2020 11:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579780754;
        bh=sPgVONfMBssyrYeOuNYXulKqcfSKytB9nRTLqgRxmS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uVF5rERqT0jd+V9y/x+9lELDQyPdGpV1tP/mdrlK+qSKbSW1torLX2dCc/MLqgBEL
         Yn8ARXFSFu9OEqhGmdOsVxFcvKEe8f6UjhQcmBYEF4pxjKECfqUBjqawzluK1cE5pt
         fVrjwg4K5wErH4qLiwrRsizZx4Ecd9NfIs6YthKc=
Date:   Thu, 23 Jan 2020 13:59:04 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH v2 0/1] arm/arm64: add support for folded p4d page tables
Message-ID: <20200123115904.GA10436@hump.haifa.ibm.com>
References: <20200113111323.10463-1-rppt@kernel.org>
 <20200122185017.GA17321@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122185017.GA17321@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 06:50:17PM +0000, Will Deacon wrote:
> On Mon, Jan 13, 2020 at 01:13:22PM +0200, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > This is a part of clean up of the page table manipulation code that aims to
> > remove asm-generic/5level-fixup.h and asm-generic/pgtable-nop4d-hack.h
> > 
> > There is a single patch for both arm and arm64 because doing the conversion
> > separately would mean breaking the shared mmu bits in virt/kvm/arm.
> 
> Unfortunately, that's going to be really hard to merge, as the two
> architectures are maintained in different trees and the breadth of this
> patch series is likely to lead to conflicts in both.

I anyway realized that sending these changes arch-by-arch was not so bright
idea, so my intention is to make "v2" include all the changes required to
drop asm-generic/5level-fixup.h and merge it via the -mm tree.
 
> Will

-- 
Sincerely yours,
Mike.

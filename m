Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA2FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29002465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579719025;
	bh=fQoQAjUDEAVwQrQeHLA+HkE9LCpRN8ToPkGfhrFGRTI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eIG09WAfkHfq8nyUxE8lPyxEGUa9bEnUlpl2aZ1Gu+QaIFnFAeX0zWP6hGpihlJzZ
	 DcbPFIXxOC3kpA6JYVkv6pae8VBH5b+Gh2BQHkHX4W1x7thCvlLl+mY1HXoJFueyXR
	 85Mg17liQI13yXhS1oR65siV6RzlMdIfyMMX1zQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgAVSuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 13:50:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:53522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725884AbgAVSuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 13:50:23 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 426D5217F4;
        Wed, 22 Jan 2020 18:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579719023;
        bh=fQoQAjUDEAVwQrQeHLA+HkE9LCpRN8ToPkGfhrFGRTI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b+Ot0Q5erq2ofBuHbSY4jl60BHqd5jvaTS2Z5b8zY9E2CCjpW/gUY7SmA6zxes5u5
         bi2BHeBPk6IhlFZECSrGz8HnFEfhJ/4Xept9OHvYsE9MiemYO4T6gr5/d3FMtJxid7
         4ziXuAQ8YYQEQWVs78cHw3ipxSjKjkn0OWuYacAs=
Date:   Wed, 22 Jan 2020 18:50:17 +0000
From:   Will Deacon <will@kernel.org>
To:     Mike Rapoport <rppt@kernel.org>
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
Message-ID: <20200122185017.GA17321@willie-the-truck>
References: <20200113111323.10463-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113111323.10463-1-rppt@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 01:13:22PM +0200, Mike Rapoport wrote:
> From: Mike Rapoport <rppt@linux.ibm.com>
> 
> This is a part of clean up of the page table manipulation code that aims to
> remove asm-generic/5level-fixup.h and asm-generic/pgtable-nop4d-hack.h
> 
> There is a single patch for both arm and arm64 because doing the conversion
> separately would mean breaking the shared mmu bits in virt/kvm/arm.

Unfortunately, that's going to be really hard to merge, as the two
architectures are maintained in different trees and the breadth of this
patch series is likely to lead to conflicts in both.

Will

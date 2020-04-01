Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB9DAC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3DAD2078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732488AbgDAM20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 08:28:26 -0400
Received: from foss.arm.com ([217.140.110.172]:50550 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726920AbgDAM20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 08:28:26 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE64930E;
        Wed,  1 Apr 2020 05:28:25 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 056243F68F;
        Wed,  1 Apr 2020 05:28:24 -0700 (PDT)
Date:   Wed, 1 Apr 2020 13:28:22 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Amit Daniel Kachhap <amit.kachhap@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: Kconfig: ptrauth: Add binutils version
 check to fix mismatch
Message-ID: <20200401122805.GD9434@mbp>
References: <1585568499-21585-1-git-send-email-amit.kachhap@arm.com>
 <1585568499-21585-2-git-send-email-amit.kachhap@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585568499-21585-2-git-send-email-amit.kachhap@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 05:11:39PM +0530, Amit Daniel Kachhap wrote:
> Recent addition of ARM64_PTR_AUTH exposed a mismatch issue with binutils.
> 9.1+ versions of gcc inserts a section note .note.gnu.property but this
> can be used properly by binutils version greater than 2.33.1. If older
> binutils are used then the following warnings are generated,
> 
> aarch64-linux-ld: warning: arch/arm64/kernel/vdso/vgettimeofday.o: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0000000
> aarch64-linux-objdump: warning: arch/arm64/lib/csum.o: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0000000
> aarch64-linux-nm: warning: .tmp_vmlinux1: unsupported GNU_PROPERTY_TYPE (5) type: 0xc0000000

I queued both patches for 5.7. Thanks.

-- 
Catalin

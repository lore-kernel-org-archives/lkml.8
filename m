Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A496C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D4502073B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:45:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbgCaJp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:45:26 -0400
Received: from foss.arm.com ([217.140.110.172]:49726 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729997AbgCaJpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:45:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6081430E;
        Tue, 31 Mar 2020 02:45:25 -0700 (PDT)
Received: from C02TD0UTHF1T.local (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDBD43F52E;
        Tue, 31 Mar 2020 02:45:22 -0700 (PDT)
Date:   Tue, 31 Mar 2020 10:45:11 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rafael Aquini <aquini@redhat.com>,
        Mark Salter <msalter@redhat.com>,
        Jon Masters <jcm@jonmasters.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        Michal Hocko <mhocko@kernel.org>, QI Fuli <qi.fuli@fujitsu.com>
Subject: Re: [PATCH 3/3] arm64: tlb: skip tlbi broadcast
Message-ID: <20200331094034.GA1131@C02TD0UTHF1T.local>
References: <20200223192520.20808-1-aarcange@redhat.com>
 <20200223192520.20808-4-aarcange@redhat.com>
 <20200309112242.GB2487@mbp>
 <20200314031609.GB2250@redhat.com>
 <20200316140906.GA6220@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316140906.GA6220@lakrids.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

On Mon, Mar 16, 2020 at 02:09:07PM +0000, Mark Rutland wrote:
> AFAICT, this series relies on:
> 
> * An ISB completing prior page table walks when updating TTBR. I don't
>   believe this is necessarily the case, given how things work for an
>   EL1->EL2 transition where there can be ongoing EL1 walks.

I've had confirmation that a DSB is necessary (after the MSR and ISB) to
complete any ongoing translation table walks for the stale context.

Without a DSB, those walks can observe subsequent stores and encounter
the usual set of CONSTRAINED UNPREDICTABLE behaviours (e.g. walking into
MMIO with side-effects, continuing from amalgamted entries, etc). Those
issues are purely to do with the walk, and apply regardless of whether
the resulting translations are architecturally consumed.

> * Walks never being initiated for `inactive` contexts within the current
>   translation regime. e.g. while ASID x is installed, never starting a
>   walk for ASID y. I can imagine that the architecture may permit a form
>   of this starting with intermediate walk entries in the TLBs.

I'm still chasing this point.

Thanks,
Mark.

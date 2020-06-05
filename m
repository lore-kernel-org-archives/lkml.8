Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9776C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 11:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C36B12070B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 11:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgFELrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 07:47:00 -0400
Received: from foss.arm.com ([217.140.110.172]:54068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgFELrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 07:47:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2D672B;
        Fri,  5 Jun 2020 04:46:59 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FB4D3F305;
        Fri,  5 Jun 2020 04:46:57 -0700 (PDT)
Date:   Fri, 5 Jun 2020 12:46:55 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, hpa@zytor.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 1/7] mm: Add functions to track page directory
 modifications
Message-ID: <20200605114654.GD31371@gaia>
References: <20200515140023.25469-1-joro@8bytes.org>
 <20200515140023.25469-2-joro@8bytes.org>
 <20200605100813.GA31371@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605100813.GA31371@gaia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 11:08:13AM +0100, Catalin Marinas wrote:
> This patch causes a kernel panic on arm64 (and possibly powerpc, I
> haven't tried). arm64 still uses the 5level-fixup.h and pud_alloc()
> checks for the empty p4d with pgd_none() instead of p4d_none().

Ah, should have checked the list first
(https://lore.kernel.org/linux-mm/20200604074446.23944-1-joro@8bytes.org/).

Please ignore my patch then.

-- 
Catalin

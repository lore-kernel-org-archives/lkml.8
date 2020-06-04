Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF51C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFE4F204EF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgFDIfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:35:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:59466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgFDIfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:35:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 09FFAAC46;
        Thu,  4 Jun 2020 08:35:18 +0000 (UTC)
Date:   Thu, 4 Jun 2020 10:35:12 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc: track which page-table levels were modified
Message-ID: <20200604083512.GN6857@suse.de>
References: <20200603232311.GA205619@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603232311.GA205619@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Wed, Jun 03, 2020 at 04:23:11PM -0700, Guenter Roeck wrote:
> This patch causes crashes with all my ppc64 boot tests, in various
> locations depending on the platform. Reverting it together with its
> companion "mm/ioremap: track which page-table levels were modified"
> fixes the problem.
> 
> Various logs are at
> https://kerneltests.org/builders/qemu-ppc64-master/builds/1442/steps/qemubuildcommand/logs/stdio

I posted the fix for this already:

	https://lore.kernel.org/lkml/20200604074446.23944-1-joro@8bytes.org/

Regards,

	Joerg


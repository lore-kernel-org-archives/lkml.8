Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90671C4BA3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6B424695
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 12:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgB0MCL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 07:02:11 -0500
Received: from foss.arm.com ([217.140.110.172]:49292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728882AbgB0MCK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 07:02:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 458B51FB;
        Thu, 27 Feb 2020 04:02:10 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9FD413F73B;
        Thu, 27 Feb 2020 04:02:07 -0800 (PST)
Date:   Thu, 27 Feb 2020 12:02:05 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
        will@kernel.org, mark.rutland@arm.com, ira.weiny@intel.com,
        david@redhat.com, mgorman@techsingularity.net,
        steve.capper@arm.com, Robin.Murphy@arm.com, steven.price@arm.com,
        broonie@kernel.org, cai@lca.pw, ard.biesheuvel@arm.com,
        arunks@codeaurora.org, dan.j.williams@intel.com,
        logang@deltatee.com, valentin.schneider@arm.com,
        suzuki.poulose@arm.com, osalvador@suse.de
Subject: Re: [PATCH V13 0/2] arm64/mm: Enable memory hot remove
Message-ID: <20200227120205.GD3281767@arrakis.emea.arm.com>
References: <1581565532-27916-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581565532-27916-1-git-send-email-anshuman.khandual@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 09:15:30AM +0530, Anshuman Khandual wrote:
> Anshuman Khandual (2):
>   arm64/mm: Hold memory hotplug lock while walking for kernel page table dump
>   arm64/mm: Enable memory hot remove

Queued for 5.7. Thanks.

-- 
Catalin

Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011A3C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 22:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA27C24676
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 22:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579730749;
	bh=6PB72xkKLVmFMKgN6If9TxhA4tlM5oqHhI4xKDg0GNk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kEF6hU//eazQ0fZMcmiVj4KF9/oaFNYuaNDzgPDtiiJGjQZL/DrcSSfJ9SMnWfdSr
	 4zptfnNdIoyFiQkRK5lLQqpEUMcaHmit9o6NLc8mSiapvslaFBGCtHKIalYqLs2SsQ
	 4zlEUK9J6zU4AQX38pG52fI2YrP4ZW2sfCFXpKRE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgAVWFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 17:05:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:52216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726101AbgAVWFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 17:05:48 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B4BC2253D;
        Wed, 22 Jan 2020 22:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579730748;
        bh=6PB72xkKLVmFMKgN6If9TxhA4tlM5oqHhI4xKDg0GNk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rhbI3JisEWrkHimpeHIrEue57yOQLbRfh8rvhyltY2AV+AUFQsCNv1y6NBg6hmmin
         repX3JAMnZVSTs1Kzk1kUtqHne4qEfpPAo25zV2YmHgql5ADot2byalOtjouu4N+Zf
         3SfcAU9BepizgSlugExioTNtKeJtznLfmPDYZ330=
Date:   Wed, 22 Jan 2020 14:05:47 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     mhocko@suse.com, richardw.yang@linux.intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm: move_pages: report the number of non-attempted
 pages
Message-Id: <20200122140547.92940695cc47ccb7b7be7d44@linux-foundation.org>
In-Reply-To: <1579721990-18672-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1579721990-18672-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jan 2020 03:39:50 +0800 Yang Shi <yang.shi@linux.alibaba.com> wrote:

> Since commit a49bd4d71637 ("mm, numa: rework do_pages_move"),
> the semantic of move_pages() was changed to return the number of
> non-migrated pages (failed to migration) and the call would be aborted
> immediately if migrate_pages() returns positive value.  But it didn't
> report the number of pages that we even haven't attempted to migrate.
> So, fix it by including non-attempted pages in the return value.
> 
> Fixes: a49bd4d71637 ("mm, numa: rework do_pages_move")
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Cc: Wei Yang <richardw.yang@linux.intel.com>
> Cc: <stable@vger.kernel.org>    [4.17+]
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
> ---
> The patch is based off Wei Yang's cleanup patchset:
> https://lore.kernel.org/linux-mm/20200122011647.13636-1-richardw.yang@linux.intel.com/T/#t

Can you please redo this so it is applicable to current mainline?  That
will make it more easily backportable and this fix is higher priority
than a set of cleanups.


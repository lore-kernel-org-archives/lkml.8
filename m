Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF331C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5B66207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589890279;
	bh=lDb46p/0XzvV+nIWSNwOG8PA6sEkz0i+9XCjntJ0NAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rCi2KjLo2SyTTkNjRjBZhFc+xhCtA0PympyessDfJ/q+urGBu/2q7yzz597oDgaNF
	 USQySQ4k6wVjnvnGznZuS/o4O0AUj+iLR7e+Ans9nDiAXQp0GOkcsPQxfAvyW9yo+U
	 o4mH5rWiwHHIWlmqTdGNbAL2IY4O/HaLvdkI2Azo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgESMLT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 08:11:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727057AbgESMLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 08:11:18 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A78BD2072C;
        Tue, 19 May 2020 12:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589890278;
        bh=lDb46p/0XzvV+nIWSNwOG8PA6sEkz0i+9XCjntJ0NAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hKGWS3lAAwsrm2uxA/yEA91/u81l9RD6W7nThOe/ZFoqNkfekIVw8oqq0z34EoFO4
         BNZWIp7vKXQywos1ApLMyhSFb4K95fhJRhmO8FFhLDQ0XGfK1n9VO+g0VU378o8cUn
         HFr23bVdmzNjDYEgPtEVHU2kHjWIBnzqy1k1Gc0Y=
Date:   Tue, 19 May 2020 14:11:15 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] /dev/mem: Revoke mappings when a driver claims the
 region
Message-ID: <20200519121115.GC332015@kroah.com>
References: <158987153989.4000084.17143582803685077783.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158987153989.4000084.17143582803685077783.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 12:03:06AM -0700, Dan Williams wrote:
> Close the hole of holding a mapping over kernel driver takeover event of
> a given address range.
> 
> Commit 90a545e98126 ("restrict /dev/mem to idle io memory ranges")
> introduced CONFIG_IO_STRICT_DEVMEM with the goal of protecting the
> kernel against scenarios where a /dev/mem user tramples memory that a
> kernel driver owns. However, this protection only prevents *new* read(),
> write() and mmap() requests. Established mappings prior to the driver
> calling request_mem_region() are left alone.
> 
> Especially with persistent memory, and the core kernel metadata that is
> stored there, there are plentiful scenarios for a /dev/mem user to
> violate the expectations of the driver and cause amplified damage.
> 
> Teach request_mem_region() to find and shoot down active /dev/mem
> mappings that it believes it has successfully claimed for the exclusive
> use of the driver. Effectively a driver call to request_mem_region()
> becomes a hole-punch on the /dev/mem device.
> 
> The typical usage of unmap_mapping_range() is part of
> truncate_pagecache() to punch a hole in a file, but in this case the
> implementation is only doing the "first half" of a hole punch. Namely it
> is just evacuating current established mappings of the "hole", and it
> relies on the fact that /dev/mem establishes mappings in terms of
> absolute physical address offsets. Once existing mmap users are
> invalidated they can attempt to re-establish the mapping, or attempt to
> continue issuing read(2) / write(2) to the invalidated extent, but they
> will then be subject to the CONFIG_IO_STRICT_DEVMEM checking that can
> block those subsequent accesses.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Fixes: 90a545e98126 ("restrict /dev/mem to idle io memory ranges")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Changes since v1 [1]:
> 
> - updated the changelog to describe the usage of unmap_mapping_range().
>   No other logic changes:
> 
> [1]: http://lore.kernel.org/r/158662721802.1893045.12301414116114602646.stgit@dwillia2-desk3.amr.corp.intel.com
> 
> Greg, Andrew,
> 
> I have a regression test for this case now. This was found by an
> intermittent data corruption scenario on pmem from a test tool using
> /dev/mem.

Ick, why are test tools messing around in /dev/mem :)

Anyway, this seems sane to me, want me to take it through my tree?

thanks,

greg k-h

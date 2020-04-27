Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D92C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7DD720775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588015568;
	bh=78FSdmryfDcWh8nNrKD1ELHe02HQDSNEuFChSLKV3Ug=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Z7ERfcNppGFgQzwKpC2Zf5FhRaIOcjtwyoV9UmZ8pENiuLHpR1CyJD4HYiy6HGKIc
	 QZ5hnqYtJI21wy4mb6Mk3/RimO4mLfBKbQUAOWMRe1rMzKTah46MoJAkksOyteUC5o
	 rMXofEL4YFaFAXZe0SO+XCt8F7dD0s64bNIKqtMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgD0T0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:26:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgD0T0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:26:07 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 176BE20775;
        Mon, 27 Apr 2020 19:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588015567;
        bh=78FSdmryfDcWh8nNrKD1ELHe02HQDSNEuFChSLKV3Ug=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sqav9Y/SwqxoyMEJHzu5dvSUIyn0Vx3vDrhV3FcKsRgGmHkKuwcQuSEiZMKHMaHde
         lqyR6D58PWaB7QVenVZajXB6HZIiqDGwICxWLKYkP4txppp3SdKAMA9GB6B+6w0fdG
         u0yE+tV3X0WZ3eoVJSpK6wuJKPtFKYlI5oLfW9RU=
Date:   Mon, 27 Apr 2020 12:26:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/gup.c: Updating the documentation
Message-Id: <20200427122606.dc29c381f6da47831a40d365@linux-foundation.org>
In-Reply-To: <1588013630-4497-1-git-send-email-jrdr.linux@gmail.com>
References: <1588013630-4497-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 00:23:50 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:

> This patch is an attempt to update the documentation.
> 
> * Adding / removing extra * based on type of function
> static / global.

I don't think so, unless this is a new kerneldoc convention?

> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -722,7 +722,7 @@ static struct page *follow_p4d_mask(struct vm_area_struct *vma,
>  	return follow_pud_mask(vma, address, p4d, flags, ctx);
>  }
>  
> -/**
> +/*
>   * follow_page_mask - look up a page descriptor from a user-virtual address
>   * @vma: vm_area_struct mapping @address
>   * @address: virtual address to look up

/** indicates that the comment is in kerneldoc form, not that it has
static scope?


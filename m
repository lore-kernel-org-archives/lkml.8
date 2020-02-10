Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32001C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05DFF2072C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581373148;
	bh=U1U7cImPq803xqZ3DUHhtgG0N2b7tlPuA9beJ7ERTmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=AFwCtK2Po00vk+avUvZYjROwaTwcZVNiD/FKetIEbM860xu0LDi9sTXCWhXfc4lBC
	 eL63/z1Nb3QhxRmdjBJEQYP4BKKMaacXHcc7qzTM4MNWHZvOAh/yk0SupC0ozaXvlK
	 zKoM8oC9z91Oll7K1U03dLFQSgT2zYHJZ3L8fK78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbgBJWTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:19:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:45926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727254AbgBJWTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 17:19:04 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B68E32072C;
        Mon, 10 Feb 2020 22:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581373144;
        bh=U1U7cImPq803xqZ3DUHhtgG0N2b7tlPuA9beJ7ERTmA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f0FluNuw8e02LglLoSvZgFRdIJ2JIp1iMkmmWYbUUJJbvLT3EV5SSlK51fJC1bt+N
         syL7wsKwpGPOPWeOx4QT/TwKUlO51s/s/1OkqRHPEHaJ9qca8zhqpLmi5iGdjTV6l9
         dmAlp1AYNIPu8Ta8uMnFH6GtfKbV/bUrbNWkLsJg=
Date:   Mon, 10 Feb 2020 14:19:03 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v2] mm: Don't overwrite user min_free_kbytes, consider
 THP when adjusting
Message-Id: <20200210141903.413880202fa3e858e27272fd@linux-foundation.org>
In-Reply-To: <20200210190121.10670-1-mike.kravetz@oracle.com>
References: <20200210190121.10670-1-mike.kravetz@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020 11:01:21 -0800 Mike Kravetz <mike.kravetz@oracle.com> wrote:

> The value of min_free_kbytes is calculated in two routines:
> 1) init_per_zone_wmark_min based on available memory
> 2) set_recommended_min_free_kbytes may reserve extra space for
>    THP allocations
> 
> In both of these routines, a user defined min_free_kbytes value will
> be overwritten if the value calculated in the code is larger. No message
> is logged if the user value is overwritten.

Could we provide a detailed description of why this is considered to be
a problem?  This is fairly easily guessable, but is there a real
in-field bad user experience we can point at?

> Change code to never overwrite user defined value.  However, do log a
> message (once per value) showing the value calculated in code.
> 
> At system initialization time, both init_per_zone_wmark_min and
> set_recommended_min_free_kbytes are called to set the initial value
> for min_free_kbytes.  When memory is offlined or onlined, min_free_kbytes
> is recalculated and adjusted based on the amount of memory.  However,
> the adjustment for THP is not considered.  Here is an example from a 2
> node system with 8GB of memory.
> 
>  # cat /proc/sys/vm/min_free_kbytes
>  90112
>  # echo 0 > /sys/devices/system/node/node1/memory56/online
>  # cat /proc/sys/vm/min_free_kbytes
>  11243
>  # echo 1 > /sys/devices/system/node/node1/memory56/online
>  # cat /proc/sys/vm/min_free_kbytes
>  11412
> 
> One would expect that min_free_kbytes would return to it's original
> value after the offline/online operations.
> 
> Create a simple interface for THP/khugepaged based adjustment and
> call this whenever min_free_kbytes is adjusted.
> 
> ...
>
>  include/linux/khugepaged.h |  5 ++++
>  mm/internal.h              |  2 ++
>  mm/khugepaged.c            | 56 ++++++++++++++++++++++++++++++++------
>  mm/page_alloc.c            | 35 ++++++++++++++++--------

min_free_kbytes gets a few mentions in Documentation/.  Should we make
the appropriate updates there to bring this behavior to people's
attention?


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mga14.intel.com ([192.55.52.115]:3477 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729989AbgCKQKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:10:46 -0400
Subject: Re: [Patch v2] mm/swap_slots.c: assign|reset cache slot by value
 directly
To: Wei Yang <richard.weiyang@linux.alibaba.com>,
        akpm@linux-foundation.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20200311055352.50574-1-richard.weiyang@linux.alibaba.com>
From: Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <8c15d421-da51-dbac-336b-c65ee258a427@linux.intel.com>
Date: Wed, 11 Mar 2020 09:10:39 -0700
MIME-Version: 1.0
In-Reply-To: <20200311055352.50574-1-richard.weiyang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/10/20 10:53 PM, Wei Yang wrote:
> Currently we use a tmp pointer, pentry, to transfer and reset swap cache
> slot, which is a little redundant. Swap cache slot stores the entry
> value directly, assign and reset it by value would be straight forward.
> 
> Also this patch merges the else and if, since this is the only case we
> refill and repeat swap cache.
> 
> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
> CC: Tim Chen <tim.c.chen@linux.intel.com>

Acked-by: Tim Chen <tim.c.chen@linux.intel.com>

> 
> ---
> v2: keep the reset step after use, but remove the tmp pointer
> ---


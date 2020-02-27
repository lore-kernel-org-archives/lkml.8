Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14551C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA8352469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbgB0QyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:54:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:60158 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727211AbgB0QyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:54:02 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 79C7FAE06;
        Thu, 27 Feb 2020 16:53:58 +0000 (UTC)
Subject: Re: [PATCH] mm: slub: reinitialize random sequence cache on slab
 object update
To:     vjitta@codeaurora.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, vinmenon@codeaurora.org,
        kernel-team@android.com
References: <1580379523-32272-1-git-send-email-vjitta@codeaurora.org>
 <1580383064-16536-1-git-send-email-vjitta@codeaurora.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <d3acc069-a5c6-f40a-f95c-b546664bc4ee@suse.cz>
Date:   Thu, 27 Feb 2020 17:53:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1580383064-16536-1-git-send-email-vjitta@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/20 12:17 PM, vjitta@codeaurora.org wrote:
> From: Vijayanand Jitta <vjitta@codeaurora.org>
> 
> Random sequence cache is precomputed during slab object creation
> based up on the object size and no of objects per slab. These could
> be changed when flags like SLAB_STORE_USER, SLAB_POISON are updated
> from sysfs. So when shuffle_freelist is called during slab_alloc it
> uses updated object count to access the precomputed random sequence
> cache. This could result in incorrect access of the random sequence
> cache which could further result in slab corruption. Fix this by
> reinitializing the random sequence cache up on slab object update.
> 
> A sample panic trace when write to slab_store_user was attempted.

A more complete oops report would have been better, e.g. if anyone was googling
it, to find this patch.

Also I was checking where else calculate_sizes() is called and found
order_store(). So if somebody changes (especially increases) the order,
shouldn't the reinitialization also be done?

This is even more nasty as it doesn't seem to require that no objects exist.
Also there is no synchronization against concurrent allocations/frees? Gasp.

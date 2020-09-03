Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C5FC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 00:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF72420773
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 00:02:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DJVpw/6/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgICACA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 20:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgICAB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 20:01:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8271BC061244;
        Wed,  2 Sep 2020 17:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=jG/anSY/5LJ9ebMkKbHQcu0NPrstmMT3teYNar15g7Q=; b=DJVpw/6/EjS/5Vi1TOx+P43hi+
        0Mb1VKZRuV+VtEiaMix6/Y+oL6zpiQ+Wq4JKmC3q3d+2ltYN0Xr0HV1JlKRwBZBPx5r1sZuA5NMQO
        /wrIn6znnWnAJybMIoWNQB5tIMA/T7fGnumSHne7ZtRXvnODdkzl/7fscOpgYOlhTbRAsQbcNrDik
        6YXPz5P5IYAzTH1t/prwtfaMsYUU/AwzDpf5rfKWxqw6p+yvO5mb2tBlyLJXRhXnXHeKlblG2fB7F
        iT+rzfid4z19fEqaz21dzyEIatotU3wpswJrm5o12uItiZZQBDnZe86q93bcM4AyVMKXL55bXSax4
        ZwWUywKA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDchN-0008UX-J1; Thu, 03 Sep 2020 00:01:54 +0000
Subject: Re: [PATCH v2] mm/doc: editorial pass on page migration
To:     Ralph Campbell <rcampbell@nvidia.com>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200902225247.15213-1-rcampbell@nvidia.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8def6c20-0efe-99f3-bde3-3e49f1456112@infradead.org>
Date:   Wed, 2 Sep 2020 17:01:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902225247.15213-1-rcampbell@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/20 3:52 PM, Ralph Campbell wrote:
> Add Sphinx reference links to HMM and CPUSETS, and numerous small
> editorial changes to make the page_migration.rst document more readable.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> 
> The patch applies cleanly to the latest linux or linux-mm tree.
> Since this is MM relatated, perhaps Andrew Morton would like to
> take this into the linux-mm tree.
> 
> Changes in v2:
> Applied suggestions from Randy Dunlap:
> Replace outdated ftp:// link to https://github
> Changed "off node" to "off-node" and "non-lru" to "non-LRU"
> 
>  .../admin-guide/cgroup-v1/cpusets.rst         |   2 +
>  Documentation/vm/hmm.rst                      |   2 +-
>  Documentation/vm/page_migration.rst           | 164 +++++++++---------
>  3 files changed, 87 insertions(+), 81 deletions(-)
> 

-- 
~Randy

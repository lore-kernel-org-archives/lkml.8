Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00A2C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 940A721D46
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgIIRkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIIRkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 13:40:13 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA44C061573;
        Wed,  9 Sep 2020 10:40:13 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6F527844;
        Wed,  9 Sep 2020 17:40:12 +0000 (UTC)
Date:   Wed, 9 Sep 2020 11:40:11 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     <linux-doc@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm/doc: editorial pass on page migration
Message-ID: <20200909114011.43b7649b@lwn.net>
In-Reply-To: <20200902225247.15213-1-rcampbell@nvidia.com>
References: <20200902225247.15213-1-rcampbell@nvidia.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Sep 2020 15:52:47 -0700
Ralph Campbell <rcampbell@nvidia.com> wrote:

> Add Sphinx reference links to HMM and CPUSETS, and numerous small
> editorial changes to make the page_migration.rst document more readable.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
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

Applied, thanks.

jon

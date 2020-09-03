Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D22C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 05:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC64520665
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 05:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O2ZLi9Hv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgICFO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 01:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgICFO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 01:14:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D00CC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 22:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=S3vLzSeyfG+KqBqznsClDRQPQ5Xz1QDvXgbvLZRew48=; b=O2ZLi9HvFUVeA5dNf6C4hfMpMM
        V/6hzfgxBoHNXX4paL9yWa+RFWHgqQHYVBK66qu1yr208+8lc/+leQy4/u+buq+VkfnNjUrr1Bk8R
        yRVMAVuXvv1y6hLHJ3pVssHbykEgqd9PI7QOtxizLKysrJlVjgdwq68uGyeb/7eIkvSVJ7yVoOl86
        cPwogFZlofVXdD/JSOUiSh12hNYCDHWTHg9c2NbGsOVL8ceWDshD85l3xjAzsPUiQVLBZBxwN2kiL
        z9pCA/l6PXHNfkWsPAxvXLOMnvBEX6jvierqsEMLe4AqPa/J76L/XvfuPtTbNYQKMgwVetGXGLghj
        xZLDEaPg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDhZK-0005wk-MB; Thu, 03 Sep 2020 05:13:54 +0000
Subject: Re: [RFC PATCH v7 06/23] bitops: Introduce find_next_or_bit
To:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Joel Fernandes <joelaf@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <b802d1711231deb5cd00723a2c63eada71d8b5a3.1598643276.git.jdesfossez@digitalocean.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <3ca5af2e-e541-fc25-047d-3692adb30c42@infradead.org>
Date:   Wed, 2 Sep 2020 22:13:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <b802d1711231deb5cd00723a2c63eada71d8b5a3.1598643276.git.jdesfossez@digitalocean.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/20 12:51 PM, Julien Desfossez wrote:
> +#ifndef find_next_or_bit
> +/**
> + * find_next_or_bit - find the next set bit in any memory regions
> + * @addr1: The first address to base the search on
> + * @addr2: The second address to base the search on
> + * @offset: The bitnumber to start searching at

preferably         bit number

> + * @size: The bitmap size in bits
> + *
> + * Returns the bit number for the next set bit

 * Return: the bit number for the next set bit

for kernel-doc syntax.


> + * If no bits are set, returns @size.
> + */
> +extern unsigned long find_next_or_bit(const unsigned long *addr1,
> +		const unsigned long *addr2, unsigned long size,
> +		unsigned long offset);
> +#endif


thanks.
-- 
~Randy


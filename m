Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67F1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 21:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70C222078C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 21:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tfTCqong"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgE0V2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 17:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbgE0V2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 17:28:38 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3796FC05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 14:28:38 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 69so803833otv.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 14:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=4UI6e2GMibGuRpVHiu85Pbqm0jGHFEIovTR145EhE6Q=;
        b=tfTCqongHzhg9tCYDzvS1J9r8QatdVtaRP2it6wWgZ2HKxYmBBw7l1t24Me6d3P0xy
         KKlbFESlR00hHGEOF0liuNf6sHmEs2d5Zc6Zt9GiGDQhK/MAq0CeRKqECY9RNb+3QvmF
         z9YJAtjlMKKOfUaI+atgGixfJALTEgCpNSkLJhhk8MCogJzOAAq38sgZxtVICV2FN1ej
         wcMD3LTlQC1A7Q4D03NZqMgi2xAFHwB8DzFzXwEZO5OFJgcAWith1AL17KSN7UptiObH
         4hxpvd/6LEutlsmlT4NXGsBhbetxnGiogYFvM4+9uDNjCUg/OGjEpu6Xj3nsk63dmcIo
         wrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=4UI6e2GMibGuRpVHiu85Pbqm0jGHFEIovTR145EhE6Q=;
        b=N8xZpO+rm+Yeqg26r5LZ4ZL7OEPNTLqmnoihuv7Y5fFJYRCYNh1aChfkdVkucju+ip
         o9dhV3rkTxCaYkB6k5/W/x9VY0xlBpjjxkf2JmP5OmuOmsp23apwnm8UWzQVvkN8CyzI
         5JffcXYlvod/SWaIlAr05t5dtYWz271CgxACZRAgcKgFx/s2lMKn4st16EM00oaQbdEa
         L8I2GvjXb9t2jRaX8aOcG29Mq81l8FcTx9wDr2qPQ0hfHYaHN3cqE09fYMe70HvyBTOS
         Wam3zhW32qlsERIot3ZotnKphBQQmVzwS5rlR16R1nqsif6PwLhEI/HBzF2Tva4puqRS
         mIzw==
X-Gm-Message-State: AOAM533/93VUEaWO3eJ4ves8gkUPkMmABDFe9zAWfUUM55shGQipleal
        qtP+OLXHkw1OHL0LYIGU5iuuqQ==
X-Google-Smtp-Source: ABdhPJxN0MPTAEY0w/YWPHqpxtKv+IMzeu2/eouHGW7v3F0SZ7oi/OxA2Zxf1Ot1xutvuHd3m051ow==
X-Received: by 2002:a9d:2253:: with SMTP id o77mr75532ota.236.1590614917287;
        Wed, 27 May 2020 14:28:37 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x25sm1158289ood.47.2020.05.27.14.28.35
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 27 May 2020 14:28:36 -0700 (PDT)
Date:   Wed, 27 May 2020 14:28:10 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Johannes Weiner <hannes@cmpxchg.org>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm,thp: stop leaking unreleased file pages
In-Reply-To: <20200526160140.GC850116@cmpxchg.org>
Message-ID: <alpine.LSU.2.11.2005271402410.6459@eggly.anvils>
References: <alpine.LSU.2.11.2005231837500.1766@eggly.anvils> <20200526160140.GC850116@cmpxchg.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 May 2020, Johannes Weiner wrote:
> On Sat, May 23, 2020 at 06:50:15PM -0700, Hugh Dickins wrote:
> > When collapse_file() calls try_to_release_page(), it has already
> > isolated the page: so if releasing buffers happens to fail (as it
> > sometimes does), remember to putback_lru_page(): otherwise that page is
> > left unreclaimable and unfreeable, and the file extent uncollapsible.
> 
> Oof, I could imagine that was painful to debug (unless you already
> suspected file THP due to a targeted test or similar). Kudos.

Thanks, but I have to refuse both your admiration and sympathy:
mercifully, it was just something I noticed by source inspection
when working there.

I did then put in a debug count to see if it ever got hit in practice,
and checked after big multi-testing runs: it was sometimes hit, but
certainly not often, and I don't know what it was racing with when
it happened - would depend on filesystem anyway (ext4 in our case).

Saying "source inspection" reminds me: there is another funny in there,
but I don't think it matters very much in practice, and might need
rather a lot of testing to justify any particular patch: where
page_cache_sync_readahead() asks for PAGE_SIZE pages!

"end - index" seems a more reasonable number to me: but then we
might find that reading ahead into the next huge extent had actually
been a useful optimization (and those readahead functions impose
their own caps, so PAGE_SIZE shouldn't work out too outrageously).

Hugh

> 
> > Signed-off-by: Hugh Dickins <hughd@google.com>
> > Fixes: 99cb0dbd47a1 ("mm,thp: add read-only THP support for (non-shmem) FS")
> > Cc: stable@vger.kernel.org # v5.4+
> 
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

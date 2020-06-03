Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A49C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 919E3207D3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 22:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q2j+NT0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgFCWUB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 18:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgFCWUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 18:20:00 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B7EC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 15:20:00 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c14so3974075qka.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 15:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=u8bt+zJqcOzYuwXNEkBi3TSw8qIySQwkMwxxZhfbW18=;
        b=q2j+NT0eKKrPZcaZj7zOdpJf6VRJKe1lfRidzOhPqGQQMYv9LP6cbgWlNpGtOAYYYo
         1F8XkS4JBGT45vJQcJQiseFEIZiJsyHIUcmahuuHUvUbA/O3i1sn2RFFPH0LAOu338Lq
         GZL7uPZ8PPfpOlH9nV2nXPeChGR8mwkfvRcICVF30rJQkLPmMZV+7KLUbHHd98jItvaK
         aAEfNVpnz2AjS8AUxcd5vS9qSXZk8xJvlC7cOMaR3PuBj35OXO76ZIH1K/aUrhfv5XEn
         pdTzFxFZs9KXENZRy5YgVfW5jMX61cOnTsCK/Q9xLc7aqEhNi2vQ3DahE9d+fAVSefdf
         tlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=u8bt+zJqcOzYuwXNEkBi3TSw8qIySQwkMwxxZhfbW18=;
        b=hYhoSWhLkudNpkoOdN7opWpY8pkvDOIL6YYO8pi5NqMy5V9WIPyy0EGOCXRs6WT+/G
         xuZKj8s8qJqF4ltGS6Ezamv8jkTNDkVO8ITGsn+wmmsfCVid0lW3HGOd54vbHBJfDurk
         SVCZoFjjgeMdH56HcY87ID6+h7NFE3c1XZPJObsixaCjPlS5CZUsmylLKoZ+BkgC4GOA
         Z7q3e6kWlp6L6pn77NWiL2v4uVo/0fOu3JfuEHFXQI2AvG8BhXi8Wvk/ntcKByFpcEAV
         jOIrNnf+j85Rle0JQ81x18JpP3sEIW4RlcgPZkCVvKgfakRB7Ayc8mDTAS/wN1pUTSQT
         XhbQ==
X-Gm-Message-State: AOAM531+qj9lB21Whx7J/2HldlIuR8WDVcu7Os8f4y8DDqyT0vfHKxXJ
        wpUGVhVqrQa1vC6qVYqYi4z3Mg==
X-Google-Smtp-Source: ABdhPJw05gsQ6aNcDdc1C5CE24VGVGWfuS8FT1e1NBeJHtJHf+z9mkEvKoPt0qQbf38jhzBbMLSP7g==
X-Received: by 2002:a37:9586:: with SMTP id x128mr1874208qkd.312.1591222799472;
        Wed, 03 Jun 2020 15:19:59 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id h50sm3328294qte.25.2020.06.03.15.19.56
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 03 Jun 2020 15:19:58 -0700 (PDT)
Date:   Wed, 3 Jun 2020 15:19:42 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm,thp: stop leaking unreleased file pages
In-Reply-To: <20200603215122.GR19604@bombadil.infradead.org>
Message-ID: <alpine.LSU.2.11.2006031506500.32284@eggly.anvils>
References: <alpine.LSU.2.11.2005231837500.1766@eggly.anvils> <20200526160140.GC850116@cmpxchg.org> <alpine.LSU.2.11.2005271402410.6459@eggly.anvils> <20200603215122.GR19604@bombadil.infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jun 2020, Matthew Wilcox wrote:
> On Wed, May 27, 2020 at 02:28:10PM -0700, Hugh Dickins wrote:
> > Saying "source inspection" reminds me: there is another funny in there,
> > but I don't think it matters very much in practice, and might need
> > rather a lot of testing to justify any particular patch: where
> > page_cache_sync_readahead() asks for PAGE_SIZE pages!
> > 
> > "end - index" seems a more reasonable number to me: but then we
> > might find that reading ahead into the next huge extent had actually
> > been a useful optimization (and those readahead functions impose
> > their own caps, so PAGE_SIZE shouldn't work out too outrageously).
> 
> That readahead was only added in 99cb0dbd47a15d395bf3faa78dc122bc5efe3fc0
> so it probably hasn't really been performance tested yet.

I can well imagine that an entirely new body of code, exercised
in the background by khugepaged, will not be a leading candidate for
performance comparisons - rightly so; but arguing that by the commit
being in the tree for only eight months seems... odd :)

Hugh

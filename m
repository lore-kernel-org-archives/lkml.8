Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B45C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0CC20885
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B1+UCT17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgFZW1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:27:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47093 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725909AbgFZW1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593210441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ezANVk9qOxqEaH3BZXiYSkQMCdN7GNKpY7AcMYxVw+Q=;
        b=B1+UCT17EgegdI1C/zf2TaU5ub9wUfqIaB2qMR4MHlWeArLQ9K6L4NpOlVR0VaA0QPs+M9
        i2PHOI8slg2sWvsAY3Wio62d9zeXLadq2qUDK0hKslQreNhUW2aTJ6JCOYV0ENnq/5Cgme
        QDOr0fjl1JNlTX0Qf42zWOGJ4nUSIZg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-HjAJke4dMEOTvXTzbe1ihA-1; Fri, 26 Jun 2020 18:27:11 -0400
X-MC-Unique: HjAJke4dMEOTvXTzbe1ihA-1
Received: by mail-qv1-f69.google.com with SMTP id v1so7352996qvx.8
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ezANVk9qOxqEaH3BZXiYSkQMCdN7GNKpY7AcMYxVw+Q=;
        b=MukzbyG3H9j7ktG/jWvxVdOlbWseqLfqQopcyx95rCCh1IiPVRkakPp4BI/whByyb0
         2RHGha2aAgPcLyOElvlxZ8sutrOTu6+IPpQ2SiMmYu4phk5yaxC2exdLKMCrdKO+GkPZ
         3+csaDZ0MphKayew1/OZp4UG3RJ+KnpyNkr/Blbzk8ex3qve/1h/xKqhiHDvXnJXheDL
         6hHRuKdLvnOpde7v5PLtQMSXqv63KhCc0vnO95pJrUfABDTlje+c+BS8eQ5Y5TtM20nl
         yRdWZ2Hp01W4eyeg+/PknA82TN2hvJN5bNrliGhjaOImBW8iaf0SuiFscCISvJcNfku6
         nrAQ==
X-Gm-Message-State: AOAM532qV0V40VPmOPWgekwEOYTe0UrxTO4KrInzbfEl/jP/S9Bwz4Jw
        Px1l4U/nyUMPlS44YIIhw0PkxS+VgChTwGzkx+Ix+i4CLdxhPEwZHqztuVjG+TsSf85hPn4hf86
        5kkfCY51abEQ521Qvwnkg17X4
X-Received: by 2002:a37:4b0d:: with SMTP id y13mr5006307qka.446.1593210429999;
        Fri, 26 Jun 2020 15:27:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwmZLtHpJAeBZ399vMiz1mJyuQdHk6v2hbTMEsydCoQct3oDd3SA+V5XqBCvEG6lXJVwmr+Rw==
X-Received: by 2002:a37:4b0d:: with SMTP id y13mr5006291qka.446.1593210429806;
        Fri, 26 Jun 2020 15:27:09 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id x26sm9307758qtp.54.2020.06.26.15.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:27:09 -0700 (PDT)
Date:   Fri, 26 Jun 2020 18:27:07 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 01/26] mm: Do page fault accounting in handle_mm_fault
Message-ID: <20200626222707.GF175520@xz-x1>
References: <20200619160538.8641-1-peterx@redhat.com>
 <20200619160538.8641-2-peterx@redhat.com>
 <20200624204903.097a5a58@thinkpad>
 <20200624203412.GB64004@xz-x1>
 <20200626215424.581d6077@thinkpad>
 <20200626215346.GE175520@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200626215346.GE175520@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 05:53:46PM -0400, Peter Xu wrote:
> Since this patch seems to be the only one that needs a new post so far, I'll
> repost this patch only by replying to itself with v2.1.  Hopefully that can
> avoid some unecessary mail bombs.

Unluckily patch 25 will need a trivial touch-up on the comment...  I'll just
resend the whole series for simplicity.  Thanks,

-- 
Peter Xu


Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA231C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 20:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A5C120829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 20:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MfGKeycr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729567AbgG3ULH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 16:11:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51400 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726939AbgG3ULH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 16:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596139865;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y8i5cbDjIAyIY7v4/z+I6axawyVafnBlcK9vywXk4mI=;
        b=MfGKeycrJ7iEDoTDLgGP42qC1WpW0BuZFnvkj7p+y1xyfn1MIn2+U1rqxSr2RXf6EEDFE7
        eK913sGEe8zq1TpWE3IHvQTnI9WV72ndcGCTOdx1NLbjctbuTnMg0GA8f79fj4g1oIzDUa
        tFJrlanAW5S2k8RT7HdLGJlIf7YEkd0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-401-voFBY83IOvi4rKiSlOxolA-1; Thu, 30 Jul 2020 16:11:03 -0400
X-MC-Unique: voFBY83IOvi4rKiSlOxolA-1
Received: by mail-qk1-f199.google.com with SMTP id v188so19374618qkb.17
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 13:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y8i5cbDjIAyIY7v4/z+I6axawyVafnBlcK9vywXk4mI=;
        b=TbKXjWBlw9emhTe2nNlp4u1fj3Z6xf/4WIFIrwfc4ZO9M3JIzAbY/v726gNI1Qaa7b
         rPZSZfHuD1/aDldihHCc2Ktoddgq3V4oLh4UftF2ZYQpu9gKDT7tkGu2XxYcygSZPf5W
         1FnZqiq1fZvdLYkkyvzZYfmEM/FfalUOJ3SzTbAnRJ4EB/b43LcCprYf9v2rB5u8qaiB
         1ltR9cO9MXG7mKNhrim87Eog+IRwXaoYc+yjsQBz+oTekqFBMaOfs+SQ4PRyBhxQ3QSF
         ChN84EZT2XzhpLE3SNCb768KqQrRfkxByxkONZHcXUKJW4dn4be7KEl/nwzJz2m/Ti0K
         JCUA==
X-Gm-Message-State: AOAM533G/b2ylfs4AEpm8HYZFpJoC+aBklZqfQB5DEz5seJUihcpF+LV
        1Unhk2N9MUTTS/g7sfuPkih720ZLCWP8ajDCyjBrtO8+994ZLnXqGK6IPHbAnJlfkVHVPqvZlLM
        GP+lyVrFuJKI96nplZxP4xbwS
X-Received: by 2002:aed:2946:: with SMTP id s64mr421549qtd.204.1596139862949;
        Thu, 30 Jul 2020 13:11:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFhrM3dAa7RGRDF5Fd7FxwsAgX8ghqq1B1Ny7FyckDeaak3knknG8M+o4sHVPV5hB2GmznSw==
X-Received: by 2002:aed:2946:: with SMTP id s64mr421527qtd.204.1596139862733;
        Thu, 30 Jul 2020 13:11:02 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c8:6f::1f4f])
        by smtp.gmail.com with ESMTPSA id 94sm5629137qtc.88.2020.07.30.13.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 13:11:01 -0700 (PDT)
Date:   Thu, 30 Jul 2020 16:10:56 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH] mm/hugetlb: Fix calculation of
 adjust_range_if_pmd_sharing_possible
Message-ID: <20200730201056.GB3649@xz-x1.hitronhub.home>
References: <20200730195030.60616-1-peterx@redhat.com>
 <20200730195722.GL23808@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200730195722.GL23808@casper.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 08:57:22PM +0100, Matthew Wilcox wrote:
> On Thu, Jul 30, 2020 at 03:50:30PM -0400, Peter Xu wrote:
> > +#define MAX(a,b)  (((a)>(b))?(a):(b))
> > +#define MIN(a,b)  (((a)<(b))?(a):(b))
> 
> What's wrong with max() and min() defined in kernel.h?

Oops.. Posting another one... Thanks.

-- 
Peter Xu


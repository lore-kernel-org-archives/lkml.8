Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AABC54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:16:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3C702068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 15:16:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFruQhbf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbgDUPQj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 11:16:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44078 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726160AbgDUPQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 11:16:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587482194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jOM4weC6TpcAg4wB4lXnSsiBFB5f0u5Eqttp2CDyqno=;
        b=RFruQhbfrWRwwkYZunpxbFQ9Sw7FQYbBbMCwlYQoQAGr9d+PcPRoafvBFHT3QvRSX51uma
        HT++0WgjYgmTOLiDEl9/nk1FfY6XpPI5kuYeQh303qIHfyEKrqmxg1TKN4HXLGERftmCwn
        5j5Tyy7Yv9GqeZl3tTuxzsdrLg+jNxQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-8ZXPrGRtOOucguVmKNWyhA-1; Tue, 21 Apr 2020 11:16:33 -0400
X-MC-Unique: 8ZXPrGRtOOucguVmKNWyhA-1
Received: by mail-qt1-f200.google.com with SMTP id g14so15154783qts.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 08:16:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jOM4weC6TpcAg4wB4lXnSsiBFB5f0u5Eqttp2CDyqno=;
        b=R3/WBRqlMtH7bHeFptfkubYDiAvtIwkQSI/9N0D19eII+lhnJplaWHriwwwczzy8yL
         joYK5dNB+G3aHaY94gOdk/wF3oP53FzPB3DDN20/XCbfKeRXiLDJxbwhVHK4/i4Ec4iV
         MHAyiZkanCxZU9uQotp3e5SnM5C3DN+YcfQyy87fvRFNaOkItcDA7u1IDvDmN6XebjIf
         pyvLBx9i8+DJS3MduERk9vKq6oVsrAAcjUEQVjdvZkqpe3klHNmZ2Nqlka9SMTL9TbT5
         LslymPF+iZhZ3eGxU5WRuZNzkwiRDQ8QtjxleTLCfOgaT5nNF9VNeXvcYsbFKZbp78YK
         I6Dw==
X-Gm-Message-State: AGi0PuZSEEMKZ9P9EJYHMyZs4WENZaOg8IZFOFq7QcOXLXwxRBX1b/t6
        kLzaWrrVISr+XAaZ67ZwWoCR/94gqFT5pvg0Z7gcQ+sSDrhzuaj20vQcZ1js6qbsel3q6/47FMy
        DnOILiUr640ZZK2i++xTExjE7
X-Received: by 2002:a0c:b604:: with SMTP id f4mr2854375qve.40.1587482192610;
        Tue, 21 Apr 2020 08:16:32 -0700 (PDT)
X-Google-Smtp-Source: APiQypLEuWxVwkViiokLApaoye3yy37kg97hMnAjfB8uy6nIohQlrmv+haZhugt1Ouy8ojkwZC9/rQ==
X-Received: by 2002:a0c:b604:: with SMTP id f4mr2854325qve.40.1587482192132;
        Tue, 21 Apr 2020 08:16:32 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id g12sm1947617qtu.69.2020.04.21.08.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 08:16:31 -0700 (PDT)
Date:   Tue, 21 Apr 2020 11:16:29 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm, mempolicy: fix up gup usage in lookup_node
Message-ID: <20200421151629.GG420399@xz-x1>
References: <20200421071026.18394-1-mhocko@kernel.org>
 <20200421132916.GE420399@xz-x1>
 <20200421144603.GI27314@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200421144603.GI27314@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 04:46:03PM +0200, Michal Hocko wrote:
> I thought I have explained that when we have discussed last time and the
> changelog is explaining that as well. Checking for impossible error code
> is simply confusing and provokes for copy&pasting this pattern. I
> wouldn't really bother if I haven't seen this cargo cult pattern in the
> so many times.

It's just my poor habit to avoid churns like this.  Say, if the check is not
there, I definitely shouldn't add that check without explicit reason.  However
if it's there already (and it's not an extremely hot path so no number to show
that it will bring any performance impact), then I won't touch it either
without a good reasoning.  "Somebody could copy & paste the same code" isn't a
reason to me - that's something we can observe when reviewing a patch.

I've broken some code due to some tiny trivial small changes that I thought
won't hurt, and I've also been debugging for hours due to some "should be
trivial" patches from others.  This is how the habit comes...

But it's not a strong opinion either.  I'd be fine if the patch is liked by
others and Andrew would like to queue it.

Thanks,

-- 
Peter Xu


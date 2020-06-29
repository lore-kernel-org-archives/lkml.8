Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211A3C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 057CE204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="heSHuZTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbgF2S5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:57:20 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31875 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726178AbgF2S5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593457030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x2c/2dZNG7adq9LsJdfmo7ftcPEILQF95jZw0pQ9BCQ=;
        b=heSHuZTF0S4jBuO+WRaJongAIcmpcdDj4Zl3murESu8dVvNzqcyhkpl/EaM2TaaJZimXsu
        Zw5N7Mp9mQJLHfy5lBa1poy5hsM7PN+x3WVJbHNwWuqKpRnTuqIPUHC934ON/blxftyHls
        Atr8v40eREjznLe4ix7n+hXKyMGed/8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-q60Rl0cbMX6Q8nC4LTZZpQ-1; Mon, 29 Jun 2020 10:56:24 -0400
X-MC-Unique: q60Rl0cbMX6Q8nC4LTZZpQ-1
Received: by mail-qk1-f199.google.com with SMTP id v16so2250723qka.18
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x2c/2dZNG7adq9LsJdfmo7ftcPEILQF95jZw0pQ9BCQ=;
        b=k8Xv2H4hOgPyNYYq7TY5B89xxOXGNY/qmAIF023lkkYfPAEVZhWSHGBf8mxkD7OM5t
         3VYXeYHuX0k03frM+HV6YoavOMNV5wkM/oSsRTaMRUKi7Syc7vXh/Q/vD/QNpo7dQxvD
         qByqZ/kro4fkPybw2r5fpw9urTuNg78/BWZi7lWEY3PeCXhKfOjOyoaq+KtDhd3hXKqE
         6nsOdF+wNyu/Umg0yjPzCi9JnMps0wfvXhitmUd3uoWzscYf5D29yHGjUeIDPhd/sC0O
         GgKQw0ZimRKUhjNKxChXuONbYQXzEVd+EXv3lUlkCzsUhU1/ZqR9IJOZfA8fThQhtV/7
         YNYw==
X-Gm-Message-State: AOAM533+/n/2COw7eebQ871MbHAHQNRuBc/SkFfWTA1Oc35cM6O5Zth3
        Mn4klsNUYQslGKQzwbJoyzpcI3w9SixXAe9Cn94bd7tS+JGj/UP5FZTaxLHjUwpwWNTD/y3+vIB
        1CQvdIu1BK752PVtNLNo0Sclz
X-Received: by 2002:ac8:4e03:: with SMTP id c3mr16104936qtw.82.1593442583874;
        Mon, 29 Jun 2020 07:56:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbgg3ZlZlh6ZNt2QjuDWhPkkTILFb8Ljtsdr8XVVXuozp8ruhVF65TWV2XDFLeFI6GnqXVuA==
X-Received: by 2002:ac8:4e03:: with SMTP id c3mr16104908qtw.82.1593442583630;
        Mon, 29 Jun 2020 07:56:23 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id g1sm35145qkl.86.2020.06.29.07.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:56:22 -0700 (PDT)
Date:   Mon, 29 Jun 2020 10:56:21 -0400
From:   Peter Xu <peterx@redhat.com>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 01/26] mm: Do page fault accounting in handle_mm_fault
Message-ID: <20200629145621.GC266532@xz-x1>
References: <20200626223130.199227-1-peterx@redhat.com>
 <20200626223130.199227-2-peterx@redhat.com>
 <370e06f7-a93b-21c9-c58e-57ad6ed8f8a8@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <370e06f7-a93b-21c9-c58e-57ad6ed8f8a8@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 06:52:24PM -0700, John Hubbard wrote:
> The above file is renamed, as of a couple weeks ago, via
> commit ad8694bac410 ("iommu/amd: Move AMD IOMMU driver into
> subdirectory").
> 
> Also there are a number of changes to mm/gup.c (not a concern for this
> patch, but it is for the overall series). So I'm hoping you're going to
> post a version that is rebased against 5.8-rc*.

Thanks for the heads up.  It turns out that there're even more conflicts than
the file movements.  I'll rebase to linux-next/akpm and resend.  The versioning
of the series seems to always not working right...  I'll try to fix that too...

-- 
Peter Xu


Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C560EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 00:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5684207CD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 00:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NgRWNg2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731540AbgGVAs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 20:48:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58237 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726468AbgGVAs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 20:48:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595378936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RWGSZm0mD0Hsn964zAHjsyYpgFxMJEkHeUi58lCG8KY=;
        b=NgRWNg2cY954VBDR5yx7sHw7ouqzSp4Q8n5V3t9nrvaNd519pR3n5afL6ER6RmAMJBgmn3
        Ef2BenjuYL9WKA+5vJzWdxjY/7/dgIwEA9lWgpcLybMzfBpnq9s8pyfO1YbvMqmTSv17Z7
        m600azGlfjMHyuZ2uE+T+zEv9YCkg00=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-166Hben3O0er4xj42NmneA-1; Tue, 21 Jul 2020 20:48:55 -0400
X-MC-Unique: 166Hben3O0er4xj42NmneA-1
Received: by mail-qt1-f198.google.com with SMTP id 71so280549qte.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 17:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RWGSZm0mD0Hsn964zAHjsyYpgFxMJEkHeUi58lCG8KY=;
        b=fDPUhSHF0QuJrzSD4MybEPzYrncIZw9ktiMT0GSHaTCGb53XKxZKcdjBc8MZ8mmJtH
         eXkccuF6hV06OF6S3HWtbnXWQ548fZ7ysS5BSH7hAVAv0yLvLy9lQ9cMPwGC2Onw3T2C
         4nydSil3RplqBPAfkj2h9tgSyEEuVF7Nm6nKLfkKm1/bjSlKyRZHBJUMEowzRxQnCSS3
         WpLrirzQBZQIvD7+4GOpYVtPmPogkIsg1g4Q83CW8jLgZ38TsNNedzuvnqhkiYYcuhdk
         T65EFNcYikeIbrIKLS90jZs1lbdlW7e7+jMFFyDkD88UwXvZZicvediIMZodVr5wgX+9
         CI1w==
X-Gm-Message-State: AOAM531BrBRrM2x9DrtqvNGAI16BIsgY/1yoUNVBPmhrZvlPwfWTh6oz
        UVbx8dIwEMcaaI6IzGQFRhDwiK733PzuSWz0OSltXY3+kR4kM/kqGkx2TV8h+rO+sREptfqbGB2
        fQJhdat72z4pYJ5qppgjPFzCH
X-Received: by 2002:a37:4711:: with SMTP id u17mr23575349qka.54.1595378934445;
        Tue, 21 Jul 2020 17:48:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxWo0UiizA03wUsCSxpLxCUuVi6CjaeEv2A/IRRJwpXQsph164b5zXlWqHCZZwzWoCTBmIt5g==
X-Received: by 2002:a37:4711:: with SMTP id u17mr23575333qka.54.1595378934196;
        Tue, 21 Jul 2020 17:48:54 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c8:6f::1f4f])
        by smtp.gmail.com with ESMTPSA id q126sm3509556qke.34.2020.07.21.17.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 17:48:53 -0700 (PDT)
Date:   Tue, 21 Jul 2020 20:48:51 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Jay Zhou <jianjay.zhou@huawei.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, cohuck@redhat.com, maoming.maoming@huawei.com,
        weidong.huang@huawei.com, Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH] vfio dma_map/unmap: optimized for hugetlbfs pages
Message-ID: <20200722004851.GV535743@xz-x1>
References: <20200720082947.1770-1-jianjay.zhou@huawei.com>
 <20200720164603.3a622548@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200720164603.3a622548@x1.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 04:46:03PM -0600, Alex Williamson wrote:
> > +		/*
> > +		 * We got a hugetlbfs page using vaddr_get_pfn alreadly.
> > +		 * In this case,we do not need to alloc pages and we can finish all
> > +		 * work by a single operation to the head page.
> > +		 */
> > +		lock_acct += contiguous_npage;
> > +		head = compound_head(pfn_to_page(*pfn_base));
> > +		atomic_add(contiguous_npage, compound_pincount_ptr(head));
> > +		page_ref_add(head, contiguous_npage);
> > +		mod_node_page_state(page_pgdat(head), NR_FOLL_PIN_ACQUIRED, contiguous_npage);
> > +		pinned += contiguous_npage;
> > +		goto out;
> 
> I'm hoping Peter or Andrea understand this, but I think we still have
> pfn_base pinned separately and I don't see that we've done an unpin
> anywhere, so are we leaking the pin of the first page??

I'm not very familiar with that either, however it seems to me most of above
chunk was already done in the gup core.  For hugetlbfs, imho it should be where
follow_hugetlb_page() calls try_grab_page().  Thanks,

-- 
Peter Xu


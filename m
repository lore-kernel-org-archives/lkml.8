Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068CAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 12:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBFF020812
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 12:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="M8B6svJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390571AbgEYM0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 08:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390505AbgEYM0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 08:26:09 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53917C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 05:26:09 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id i68so13647849qtb.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 05:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v+B1785OZUouPASW2jrMekMBCWgZaLFpUTHdleb2VxA=;
        b=M8B6svJXr54wgpkQnxJoxOPnFoG3xoaPb76kANRmbKzt4nMw3qxD/q1sXASpcEEWgF
         gHuA1+7j+0GHGEQqXQhNV3CKJGJ9y8q3jm3bRbRkWZKx1ilA8ceQcZUG0kUCYhtO2MZ7
         o4kqO2LyZq2faf/NlIVIMBkKLeXoa88R/AW3tpprsWHR3SjzEi7iaSys03D2VbMtewxD
         KWhdY5a9O/4fZ5uesQirQ2lMyaFJfuB2R2HsT37n64J/gUu+48rbi4zf1W71+HPlLCgg
         RS6kJEq84BAk2ESnQHLB8txIWUSWrjJBBQcE2f/WAF2FVslapUIbMMvrwY16wMa3EvYc
         Oywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=v+B1785OZUouPASW2jrMekMBCWgZaLFpUTHdleb2VxA=;
        b=oC7WKjOyRX1sPtMYcz5URt5vsWLUAyK1jnhK7rHw4kcUtO7Qr8dyRDQHzjjMcGrjLu
         Jese0AVGs3tJYJvFNldPUOkRtjtep2jZjNEjSCYSsLBWPRuyxV8ZA7JiY1keyM/8o18E
         S55mUmqMGBMpeHUQJH1A7wkj7ClNTZn4gSG+CB/TQTYLhk94a87gwpwg2V3nI3/OJ+9T
         HpQI+/mIO7RD876R3/Q6Qm9lZFn/1dlMzQS7pqUmZYqGVS6eOC//lWrTALHl9UREfd5Q
         iRfjbqe+KdiPK8VdRcyj+zZNHtpfm9cVk/gjjhhb9PbrPobhHuSbIkluPN3kEpUluX2l
         whYA==
X-Gm-Message-State: AOAM531HqMUbeaUsi4NRiEC55wW7z7ACv6bK/4YGeWPZOaYC2QQlEx4E
        vsfrdpyyA05vF8NJz6mzpBzY9w==
X-Google-Smtp-Source: ABdhPJwk7SIlqGjBIUWz/0hGbccyh9qfHeyY8qv0Rau9jFzIYCDNLUkjNci7H9c03NXVt63ilIK9QA==
X-Received: by 2002:aed:278d:: with SMTP id a13mr2961124qtd.23.1590409568569;
        Mon, 25 May 2020 05:26:08 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id l2sm13637889qkd.57.2020.05.25.05.26.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 May 2020 05:26:08 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jdCBD-0007ON-FH; Mon, 25 May 2020 09:26:07 -0300
Date:   Mon, 25 May 2020 09:26:07 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, cohuck@redhat.com, cai@lca.pw
Subject: Re: [PATCH v3 3/3] vfio-pci: Invalidate mmaps and block MMIO access
 on disabled memory
Message-ID: <20200525122607.GC744@ziepe.ca>
References: <159017449210.18853.15037950701494323009.stgit@gimli.home>
 <159017506369.18853.17306023099999811263.stgit@gimli.home>
 <20200523193417.GI766834@xz-x1>
 <20200523170602.5eb09a66@x1.home>
 <20200523235257.GC939059@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523235257.GC939059@xz-x1>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 07:52:57PM -0400, Peter Xu wrote:

> For what I understand now, IMHO we should still need all those handlings of
> FAULT_FLAG_RETRY_NOWAIT like in the initial version.  E.g., IIUC KVM gup will
> try with FOLL_NOWAIT when async is allowed, before the complete slow path.  I'm
> not sure what would be the side effect of that if fault() blocked it.  E.g.,
> the caller could be in an atomic context.

AFAICT FAULT_FLAG_RETRY_NOWAIT only impacts what happens when
VM_FAULT_RETRY is returned, which this doesn't do?

It is not a generic 'do not sleep'

Do you know different?

Jason

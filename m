Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C18CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 174F521532
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 19:58:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgA8Zy7w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgFQT6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 15:58:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53199 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726496AbgFQT6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 15:58:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592423892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gmJWpSwHVjxD6GXTAJ69IeIkc8fh7DM3r6hkTC0cWeE=;
        b=VgA8Zy7wMoR/1lzsmCN9WMUvteeUwIUoVLkS0gQqhtb3Z6RhHsuuTEKG5rFV9/rihnLKi1
        sTsaFJqwhedVbsjHshw2kyfyBI+ZJVAfrBuvcKQ+ySH0y6U6tYVndohsj8lxMGh+YLnNej
        +zHEQ2w9OFfW6+4Q0RRh+MfVX8L1OwA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-Y1F-9STcO7OuvfQTv4WmjQ-1; Wed, 17 Jun 2020 15:58:10 -0400
X-MC-Unique: Y1F-9STcO7OuvfQTv4WmjQ-1
Received: by mail-qt1-f198.google.com with SMTP id p9so2606606qtn.5
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 12:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gmJWpSwHVjxD6GXTAJ69IeIkc8fh7DM3r6hkTC0cWeE=;
        b=NRMPops+BJvfrdj4v92oX5cMESiTH0UaLaiGOQ5oXtYL8LvmMleoDOKAhbW0OYDa8i
         lbXikE7R1L4k5rEBvCmNcEDz4/XEBRvXXmGLlicEBUgHk2cnYTUEKJf60w/MhP+ooSED
         9bUJplH7HHl2dmTB9+OHfFcMqDD7hGARDjApOA2O7MgA1q9+uB0VZYJnxqkzl41xthJS
         lyUj/W5KVTpuuApqKmZGOUSkZBqfQ6R8brRWCV5PCvqpXVvAv5+h4J2Edzszo39SAkwe
         Ii8U0hdkv45D3jiBH2Oeqm2pXn7HIW7Mz3Y21etYk6dt9l2WQYucCDKCsG/ovbCdMFQ3
         qpuw==
X-Gm-Message-State: AOAM533D2Im9LaIlW9GdtIahq4YUv4w4Z0dfXGANWCCF8kJdmMytKmP+
        IhT+yjFNa2qOeNV0Ndhe3GaRkt1TKdbadhOo6GZDuJADeQ+pVZt8wvgfRz/QIhRciIFETmOrIlK
        Mm5tb/Vg4zoWzK1VxNPox7ouH
X-Received: by 2002:a05:620a:218b:: with SMTP id g11mr302079qka.251.1592423890285;
        Wed, 17 Jun 2020 12:58:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcgg+y34wH1kZsiZl1638g4VhObYVYEjy0Zq1p0HEwGO4go5ztwMhAOlTkmaJl++mH9IdRGQ==
X-Received: by 2002:a05:620a:218b:: with SMTP id g11mr302063qka.251.1592423890039;
        Wed, 17 Jun 2020 12:58:10 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id y19sm837132qki.19.2020.06.17.12.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 12:58:08 -0700 (PDT)
Date:   Wed, 17 Jun 2020 15:58:07 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guo Ren <guoren@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-csky@vger.kernel.org
Subject: Re: [PATCH 07/25] mm/csky: Use mm_fault_accounting()
Message-ID: <20200617195807.GH76766@xz-x1>
References: <20200615221607.7764-1-peterx@redhat.com>
 <20200615221607.7764-8-peterx@redhat.com>
 <CAJF2gTSVSXO=phc1eeb-ZmDMrSDjSSLd3tN6ng_8n-pCSZh5zw@mail.gmail.com>
 <20200617154925.GC76766@xz-x1>
 <CAHk-=wi=58J7d5iyFyYyHrU+pzjWB55cit_LQCkSkavpH-trsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wi=58J7d5iyFyYyHrU+pzjWB55cit_LQCkSkavpH-trsg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 10:53:23AM -0700, Linus Torvalds wrote:
> On Wed, Jun 17, 2020 at 8:49 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > I don't think it's a must, but mmap_sem should not be required at least by
> > observing current code.  E.g., do_user_addr_fault() of x86 does the accounting
> > without mmap_sem even before this series.
> 
> All the accounting should be per-thread and not need any locking.
> 
> Which is why a remote GUP should never account to the remote mm - not
> only isn't there an unambiguous thread to account to (an mm can share
> many threads), but it would require locking not just for the remote
> update, but for all normal page faults.

But currently remote GUP will still do the page fault accounting on the remote
task_struct, am I right?  E.g., when the get_user_pages_remote() is called with
"tsk != current", it seems the faultin_page() will still do maj_flt/min_flt
accounting for that remote task/thread?

Thanks,

-- 
Peter Xu


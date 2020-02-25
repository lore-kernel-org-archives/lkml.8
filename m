Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764E7C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 20:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38C2921744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 20:31:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sjvb63g0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731772AbgBYUbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:31:32 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40768 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731725AbgBYUbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 15:31:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so277757plp.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 12:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=f38t1vB1E09D3O7biTt/uQi42QKpJWaCNeM//jWgarM=;
        b=sjvb63g0ui81MI1fbKV7N4ZZhCK7dzBk+hc23Dx3DUZXkjdV7ixE6DbDIL3m++COvZ
         exMZqZqLJm4kkM77tkSO9TmOUxFgYUNtzeqItuQQ/uN8LBrAByURzxuTL6l+vSiRxQDV
         vWQIXWSSLjiZ95LDxy/SlsPwrIa+6E+3JBgvZRMUMUT0Zcd6LqPy3lX2vcrtS99LMSpL
         C3dmmZ2E/ABD5Ie2tbJGR/CRO1y7VnwD7/+QCfS2kyN+MEbVbX94JnlZUCUpPJ/+vjIo
         r1buECakC2UYaBHVQW3v/s5+Kibf0uEuGG16hgY53a65cKvyadxR4creiDaMj9x/TiOz
         fKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=f38t1vB1E09D3O7biTt/uQi42QKpJWaCNeM//jWgarM=;
        b=tK/8DdIpS84B1/zG57xc+XujOatDxffkCjZTm13gkbLVTDVtTU8hflUrgvQMTEKnXk
         ZhFEKupuihhk3KyHmcsfEqm2JOvGEhCjl0FnxMQzt7+sJjGRZz3S+g0R7b31ToI8GTiS
         SY4u2TGtoDe+SVANvMwX2mjxEXhCv5RJhb4i6Sz6uuMSCeaEMErkvogzf77KFWAgyyz2
         DDl2g121uTrcAoVp2R5hDZy3OyITlmwCPJRSibmxqU2TVxl9GLWcLW/1w3aGyh9mLSZa
         0hgbx+nEEGxzaIAfOmTS3egEhiiHlSVFSgHAS6PN7TMricMVMv3ZsrzTbXLEoBB9Q6m/
         +5Vg==
X-Gm-Message-State: APjAAAV1GB7N8Jo1VPnWUmkAIQJvEjT3sPscp+q3DcvTQMuTZ3m4mT0R
        73Hhxys3Fu8eCicck75eb7pIUg==
X-Google-Smtp-Source: APXvYqyDeg5oZCf2F73phX2nvXcxMbTP9CUH6FGv8O9YLT3d4xw7nlHTf/BPkYJf899KEhhCWK3kng==
X-Received: by 2002:a17:902:8604:: with SMTP id f4mr327049plo.278.1582662690368;
        Tue, 25 Feb 2020 12:31:30 -0800 (PST)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id w81sm18529544pff.95.2020.02.25.12.31.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Feb 2020 12:31:29 -0800 (PST)
Date:   Tue, 25 Feb 2020 12:31:07 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     David Hildenbrand <david@redhat.com>
cc:     Hugh Dickins <hughd@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: shmem: allow split THP when truncating THP
 partially
In-Reply-To: <14abd659-1571-8196-202d-d2fcc227a4b0@redhat.com>
Message-ID: <alpine.LSU.2.11.2002251216480.7087@eggly.anvils>
References: <1575420174-19171-1-git-send-email-yang.shi@linux.alibaba.com> <alpine.LSU.2.11.1912041601270.12930@eggly.anvils> <00f0bb7d-3c25-a65f-ea94-3e2de8e9bcdd@linux.alibaba.com> <alpine.LSU.2.11.2002241831060.3084@eggly.anvils>
 <14abd659-1571-8196-202d-d2fcc227a4b0@redhat.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020, David Hildenbrand wrote:
> > 
> > I notice that this thread has veered off into QEMU ballooning
> > territory: which may indeed be important, but there's nothing at all
> > that I can contribute on that.  I certainly do not want to slow down
> > anything important, but remain convinced that the correct filesystem
> > implementation for punching a hole is to punch a hole.
> 
> I am not completely sure I follow all the shmem details (sorry!). But
> trying to "punch a partial hole punch" into a hugetlbfs page will result
> in the very same behavior as with shmem as of now, no?

I believe so.

> 
> FALLOC_FL_PUNCH_HOLE: "Within the specified range, partial filesystem
> blocks are zeroed, and whole filesystem blocks are removed from the
> file." ... After a successful call, subsequent reads from this range
> will return zeros."
> 
> So, as long as we are talking about partial blocks the documented
> behavior seems to be to only zero the memory.
> 
> Does this patch fix "FALLOC_FL_PUNCH_HOLE does not free blocks if called
> in block granularity on shmem" (which would be a valid fix),

Yes. The block size of tmpfs is (talking x86_64 for simplicity) 4KiB;
but when mounted huge, it transparently takes advantage of 2MiB extents
when it can.  Rather like a disk-based filesystem always presenting a
4KiB block interface, but stored on disk in multisector extents.

Whereas hugetlbfs is a different filesystem, which is and always has
been limited to supporting only certain larger block sizes.

> or does it
> try to implement something that is not documented? (removing partial
> blocks when called in sub-block granularity)

No.

> 
> I assume the latter, in which case I would interpret "punching a hole is
> to punch a hole" as "punching sub-blocks will not free blocks".
> 
> (if somebody could enlighten me which important piece I am missing or
> messing up, that would be great :) )
> 
> -- 
> Thanks,
> 
> David / dhildenb

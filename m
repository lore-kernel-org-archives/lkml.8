Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E1CC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 18:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36165206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 18:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2TBBSft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgDJSO6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 14:14:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55397 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726142AbgDJSO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 14:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586542497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t4jnBv56iJyBMaSdpfyq8JNe1NXVm+rxJaqyJqBMPzM=;
        b=a2TBBSft87afLssJo6QL0uFziQvtcEybhvnhCTcaHMM3HMdZQdlKlfICcIF4JqkLkhwnSm
        rlt38qGLB/9ckwRqK8/UnbvuVisODJc2KFW2tfGwuYb94ykzdf0p3QXIjqiI40YAFHcOwh
        OG9k8QGCO08SPDyUTF1ATTdqLL67puw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-tC8-haXqPqGk-9v0-7Zp-Q-1; Fri, 10 Apr 2020 14:14:55 -0400
X-MC-Unique: tC8-haXqPqGk-9v0-7Zp-Q-1
Received: by mail-qv1-f70.google.com with SMTP id z16so2269713qvo.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 11:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t4jnBv56iJyBMaSdpfyq8JNe1NXVm+rxJaqyJqBMPzM=;
        b=IRPZ9GX7Mq/h9tNIN2fUBXR0SwiLfgkc1mh1sF2JpRICptRfBc+XsfQ6C4HFOwTdTh
         RxA43Tc35PJcwwdlCfFvFOQ+pf8HCoUVW95FnfWsx1jK53XgswJ7TKRL8aOn0wRBrFJj
         N0gXlGzaS/0FMc4wdPhcqNHxH9qJfS5gJodccXbDYGjrdjCzIXlSohkItCPOoaBSOGVD
         xzvGQlH+jqSXAq+wNoZ+qL17x+TJVGFtGOrN5/fd2uNd3eaFv5O5bf7gJXmp09mdjmr0
         COl56uo144nJn3i9BvVbX8ovW2CGZmM4JFnz+3JUrx/qRXV2g9ELTD7EEvSnx728snqF
         7r8w==
X-Gm-Message-State: AGi0PuZNILmD7zXgxJQMSnsSFntNWExP/AsKhc5skLjWsStCEgcMoN4w
        Vcc1wZR1ETr38JnN1TceAQPgRaN3Ba9G9iu/+v0BtinCS17W3yap+6dsqTDxelnd29oyXttLbV/
        V1CFIXyajbhPAm1Pw08KqFW+H
X-Received: by 2002:ac8:4e8e:: with SMTP id 14mr439598qtp.3.1586542495030;
        Fri, 10 Apr 2020 11:14:55 -0700 (PDT)
X-Google-Smtp-Source: APiQypJdgNanx+iC1lJjnr/30Tw/VOyto9B36vj31bco1lYF5s/fzOgTxlfQtzsH9iXspsf0I8lCcQ==
X-Received: by 2002:ac8:4e8e:: with SMTP id 14mr439561qtp.3.1586542494668;
        Fri, 10 Apr 2020 11:14:54 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id r6sm2130349qtp.61.2020.04.10.11.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 11:14:53 -0700 (PDT)
Date:   Fri, 10 Apr 2020 14:14:52 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hillf Danton <hdanton@sina.com>, kernel test robot <lkp@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: f45ec5ff16 ("userfaultfd: wp: support swap and page migration"):
 [  140.777858] BUG: Bad rss-counter state mm:b278fc66 type:MM_ANONPAGES
 val:1
Message-ID: <20200410181452.GC3172@xz-x1>
References: <20200410002518.GG8179@shao2-debian>
 <20200410073209.11164-1-hdanton@sina.com>
 <20200410153234.GB3172@xz-x1>
 <20200410153805.GA21484@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200410153805.GA21484@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 08:38:05AM -0700, Matthew Wilcox wrote:
> On Fri, Apr 10, 2020 at 11:32:34AM -0400, Peter Xu wrote:
> > I'm still trying to digest on what's happened... It would be good too
> > if more information on the test could be given, e.g., what is the
> > behavior of trinity-c2. A reproducer is of course even better.
> 
> Trinity is a syscall fuzzer.  Don't expect what it's doing to make any
> sense, it's just executing syscalls at random.

OK thanks.

Though I just noticed that the original report is actually with some
attachments which I totally missed initially.  There's the config file
showing that we're with:

CONFIG_MIGRATION=y
CONFIG_MEMORY_FAILURE=y
CONFIG_DEVICE_PRIVATE=n

And even a reproducer.  However the reproducer script will fail at
wget, until I fixed it using:

initrd=openwrt-trinity-i386.cgz

to replace:

initrd=openwrt-i386-trinity.cgz

Then I can download the initrd and boot the VM with a decent QEMU.
However I didn't see any test running after the VM booted, and it will
reboot/shutdown after 100 sec without any error triggered (I believe
the rc.local tries to run something under /etc/kernel-tests/ but I'm
not sure it's running the right thing).

If there's any way to reproduce (I believe so because it can even
bisect in the original report, I just don't know how...), I'm thinking
maybe we can try to dump every swp entry change that could have been
touched in change_pte_range(), which is the only place that I thought
could be related to this in the commit, to see whether there's
anything suspecious.

8<----------------------------------------------
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 1d823b050329..1b6daf7d03aa 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -173,6 +173,8 @@ static unsigned long change_pte_range(struct vm_area_struct *vma, pmd_t *pmd,
                                newpte = pte_swp_clear_uffd_wp(newpte);
 
                        if (!pte_same(oldpte, newpte)) {
+                               pr_info("%s: Update swp entry, 0x%lx -> 0x%lx\n",
+                                       __func__, pte_val(oldpte), pte_val(newpte));
                                set_pte_at(vma->vm_mm, addr, pte, newpte);
                                pages++;
                        }

-- 
Peter Xu


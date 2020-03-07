Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3D7C10F27
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 21:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C6820684
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 21:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HMHybRnj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgCGVrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 16:47:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36392 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726098AbgCGVrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 16:47:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583617670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IkOBexO04RVBl2l8ypAUnEz4Z2T/51GfLf5xq5+aDvY=;
        b=HMHybRnjVHTv1Xh5afc/O+VNakdQyzTb3prpBYiMePNQVBMEQWH/Zc0WTS70fapHDVOFlc
        YQh1IqsUbnuyiJYEHbe2OvwUJMXyzgDDmRVi1MEnW/MVu3XfujXke6pU+sAc300jR850SK
        lOPwh1caOLrVY+qHeh1h9HFcUfBxLWs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-YwNvcz96OoGFbYVd1W1FDw-1; Sat, 07 Mar 2020 16:47:47 -0500
X-MC-Unique: YwNvcz96OoGFbYVd1W1FDw-1
Received: by mail-qv1-f70.google.com with SMTP id w1so4061211qvp.23
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 13:47:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IkOBexO04RVBl2l8ypAUnEz4Z2T/51GfLf5xq5+aDvY=;
        b=ufJUFw586klsP9oa/y8/t2CDRDMBeAQaW03pOIEQMGyGa2bhQX/kz8UrknVuIGeXuQ
         /9Kry7JYrzk7n+pYmSi5CxgYDrfQXqAc5eRwa9HFhOHSaCAc5VlwBAYh8pBneWaT0Gnr
         rwM3Q1zqc2MJntidD9K7SCQHqh3mNbRGVJEGl9xVn882Ei6gj6ShF8IhMuHHt5TtuApA
         tWFto9VAHVJdvSAI3PlbjE+I9LgwstHdiHmMWH/ry4ujHZo8JTpHftC+D6ieBMWh13Q0
         FFGPLKyO/FudHAzmn6nqP9EAYUf2onEGQLiM/yBM0fQNi5egdVjerat86Y3HwNVIWm60
         DOgg==
X-Gm-Message-State: ANhLgQ1/OySegRVuDBZeuLpyAY4Vf9fZKi+QX6fbqY3CNmrdk500gOF0
        Aify1xM87yUScFeiS5HEJRxk/IwCevxO8HHV68/JajWzDG8g2IkQavP6pM7peidIIv0Xy0DqwMl
        uY17yXQhTKd908anjpCkpbhyf
X-Received: by 2002:a37:606:: with SMTP id 6mr9063576qkg.194.1583617667258;
        Sat, 07 Mar 2020 13:47:47 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuFg3WiUjDadRTm8H6xACsKd8IRm59QlCeklYibzU4D4eDdDdU2T9UUIl41chl/6P+PgPuIqQ==
X-Received: by 2002:a37:606:: with SMTP id 6mr9063548qkg.194.1583617666811;
        Sat, 07 Mar 2020 13:47:46 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id h21sm110044qtu.58.2020.03.07.13.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2020 13:47:45 -0800 (PST)
Date:   Sat, 7 Mar 2020 16:47:43 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Martin Cracauer <cracauer@cons.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Bobby Powers <bobbypowers@gmail.com>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marty McFadden <mcfadden8@llnl.gov>,
        Mel Gorman <mgorman@suse.de>, Hugh Dickins <hughd@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>
Subject: Re: [PATCH RESEND v6 00/16] mm: Page fault enhancements
Message-ID: <20200307214743.GA4206@xz-x1>
References: <20200220155353.8676-1-peterx@redhat.com>
 <1eb7bdd4-348f-da87-47a1-0b022b70e918@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1eb7bdd4-348f-da87-47a1-0b022b70e918@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 07, 2020 at 09:33:08PM +0100, David Hildenbrand wrote:
> On 20.02.20 16:53, Peter Xu wrote:
> > [Resend v6]
> > 
> > This is v6 of the series.  It is majorly a rebase to 5.6-rc2, nothing
> > else to be expected (plus some tests after the rebase).  Instead of
> > rewrite the cover letter I decided to use what we have for v5.
> > 
> > Adding extra CCs for both Bobby Powers <bobbypowers@gmail.com> and
> > Brian Geffon <bgeffon@google.com>.
> > 
> > Online repo: https://github.com/xzpeter/linux/tree/mm-pf-signal-retry
> > 
> > Any review comment is appreciated.  Thanks,
> 
> If I am not completely missing something (and all my testing today was
> wrong) there is a very simple reason why I *LOVE* this series and it made
> my weekend. It makes userfaultfd with concurrent discarding (e.g.,
> MADV_DONTNEED) of pages actually usable.

Hi, David,

Thanks for doing further test against this branch!

> 
> The issue in current code is that between placing a page and waking
> up a waiter, somebody can zap the new placed page and trigger
> re-fault, triggering a SIGBUS and crashing an application where all
> memory is supposed to be accessible. And there is no real way to protect
> from that, because when the fault handler will be woken up and retry
> is not deterministic (e.g., making madvise(MADV_DONTNEED) and
> UFFDIO_ZEROPAGE mutually exclusive does not help).
> 
> Find a simple reproducer at the end of this mail.
> 
> Before this series:
> [root@localhost ~]# ./a.out 
> Progress!
> Progress!
> Progress!
> Progress!
> Progress!
> Progress!
> Progress!
> Progress!
> Progress!
> Progress!
> Progress!
> Progress!
> [   34.849604] FAULT_FLAG_ALLOW_RETRY missing 70
> [   34.850466] CPU: 1 PID: 651 Comm: a.out Not tainted 5.6.0-rc2+ #92
> [   34.851525] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.4
> [   34.852818] Call Trace:
> [   34.853045]  dump_stack+0x8f/0xd0
> [   34.853338]  handle_userfault.cold+0x1a/0x2e
> [   34.853704]  ? find_held_lock+0x2b/0x80
> [   34.854031]  ? __handle_mm_fault+0x18c5/0x1900
> [   34.854409]  __handle_mm_fault+0x18d4/0x1900
> [   34.854784]  handle_mm_fault+0x169/0x360
> [   34.855120]  do_user_addr_fault+0x20d/0x490
> [   34.855478]  async_page_fault+0x43/0x50
> [   34.855809] RIP: 0033:0x401659
> [   34.856069] Code: ba 1f 00 00 00 be 01 00 00 00 bf 10 21 40 00 e8 ad fa ff ff bf ff ff ff ff e8 93 fa ff ff 48 8b8
> [   34.857629] RSP: 002b:00007ffcfd536ec0 EFLAGS: 00010246
> [   34.858076] RAX: 00007fcba86a4000 RBX: 0000000000000000 RCX: 00007fcba85784ef
> [   34.858675] RDX: 00007fcba86a4007 RSI: 00000000016524e0 RDI: 00007fcba864b320
> [   34.859272] RBP: 00007ffcfd536f20 R08: 000000000000000a R09: 0000000000000070
> [   34.859876] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000401120
> [   34.860472] R13: 00007ffcfd537000 R14: 0000000000000000 R15: 0000000000000000
> 
> After this series:
> Well, "Progress!" all day long.

Yes, IIUC the race can happen like this in your below test:

     main thread          uffd thread             disgard thread
     ===========          ===========             ==============
     access page
       uffd page fault
         wait for page
                          UFFDIO_ZEROCOPY
                            put a page P there
                                                  MADV_DONTNEED on P
                            wakeup main thread
         return from fault
       page still missing
       uffd page fault again
       (without ALLOW_RETRY)
       --> SIGBUS.

And I agree this should be one if the major issues that this series
wants to address.

> 
> 
> Can we please have a way to identify that this "feature" is available?
> I'd appreciate a new read-only UFFD_FEAT_ , so we can detect this from
> user space easily and use concurrent discards without crashing our applications.

I'm not sure how others think about it, but to me this still fells
into the bucket of "solving an existing problem" rather than a
feature.  Also note that this should change the behavior for the page
fault logic in general, rather than an uffd-only change. So I'm also
not sure whether UFFD_FEAT_* suites here even if we want it.

> 
> 
> Questions:
> 1. I assume KVM will do multiple retries as well, and have the same behavior, right?

Yes I believe so, or we'll need to fix it.

> 
> 2. What will happen if I don't place a page on a pagefault, but only do a UFFDIO_WAKE?
>    For now we were able to trigger a signal this way.

If I'm not mistaken the UFFDIO_WAKE will directly trigger the sigbus
even without the help of the MADV_DONTNEED race.

> If the behavior is changed, can
>    we make this configurable via a UFFD_FEAT?

I'll still think that could be an overkill, but I'll leave the
discussion to the experts.

Thanks,

> 
> --- snip ---
> #include <string.h>
> #include <stdbool.h>
> #include <stdint.h>
> #include <sys/types.h>
> #include <stdio.h>
> #include <pthread.h>
> #include <errno.h>
> #include <unistd.h>
> #include <stdlib.h>
> #include <fcntl.h>
> #include <poll.h>
> #include <linux/userfaultfd.h>
> #include <sys/mman.h>
> #include <sys/syscall.h>
> #include <sys/ioctl.h>
> 
> static int page_size;
> 
> static void *fault_handler_thread(void *arg)
> {
>     const long uffd = (long) arg;
>     struct pollfd pollfd = {
>         .fd = uffd,
>         .events = POLLIN,
>     };
>     int ret;
> 
>     while (true) {
>         struct uffdio_zeropage zeropage = {};
>         struct uffd_msg msg;
>         ssize_t nread;
> 
>         if (poll(&pollfd, 1, -1) == -1) {
>             fprintf(stderr, "POLL failed: %s\n", strerror(errno));
>             exit(-1);
>         }
>         if (read(uffd, &msg, sizeof(msg)) != sizeof(msg)) {
>             fprintf(stderr, "READ failed\n");
>             exit(-1);
>         }
>         if (msg.event != UFFD_EVENT_PAGEFAULT) {
>             fprintf(stderr, "Not UFFD_EVENT_PAGEFAULT\n");
>             exit(-1);
>         }
> 
>         zeropage.range.start = msg.arg.pagefault.address;
>         zeropage.range.len = page_size;
>         do {
>             ret = ioctl(uffd, UFFDIO_ZEROPAGE, &zeropage);
>             if (ret && errno != EAGAIN) {
>                 fprintf(stderr, "UFFDIO_ZEROPAGE failed:%s\n", strerror(errno));
>                 exit(-1);
>             }
>         } while (ret);
>     }
> }
> static void *discard_thread(void *arg)
> {
>     while (true) {
>         if (madvise(arg, page_size, MADV_DONTNEED)) {
>             fprintf(stderr, "MADV_DONTNEED failed:%s\n", strerror(errno));
>             exit(-1);
>         }
>         usleep(1000);
>     }
> }
> 
> int main(void)
> {
>     struct uffdio_register reg;
>     struct uffdio_api api = {
>         .api = UFFD_API,
>     };
>     pthread_t fault, discard;
>     long uffd;
>     char *area;
> 
>     page_size = sysconf(_SC_PAGE_SIZE);
> 
>     uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
>     if (uffd == -1) {
>         fprintf(stderr, "Could not create uffd: %s\n", strerror(errno));
>         exit(-1);
>     }
>     if (ioctl(uffd, UFFDIO_API, &api) == -1) {
>         fprintf(stderr, "UFFDIO_API failed: %s\n", strerror(errno));
>         exit(-1);
>     }
> 
>     area = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
>                 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
>     if (area == MAP_FAILED) {
>         fprintf(stderr, "Could not allocate memory");
>         exit(-1);
>     }
> 
>     reg.range.start = (uint64_t) area;
>     reg.range.len = page_size,
>     reg.mode = UFFDIO_REGISTER_MODE_MISSING;
>     if (ioctl(uffd, UFFDIO_REGISTER, &reg) == -1) {
>         fprintf(stderr, "UFFDIO_REGISTER failed: %s\n", strerror(errno));
>         exit(-1);
>     }
> 
>     /* thread to provide zeropages */
>     if (pthread_create(&fault, NULL, fault_handler_thread,
>                        (void *) uffd)) {
>         fprintf(stderr, "Could not create fault handling thread");
>         exit(-1);
>     }
> 
>     /* thread to discard the page */
>     if (pthread_create(&discard, NULL, discard_thread,
>                        (void *) area)) {
>         fprintf(stderr, "Could not create discard thread");
>         exit(-1);
>     }
> 
>     /* keep reading/writing the page */
>     while (true) {
>         area[7] = area[1];
>         usleep(10000);
>         printf("Progress!\n");
>     }
>     return 0;
> }
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Peter Xu


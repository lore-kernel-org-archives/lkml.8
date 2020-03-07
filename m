Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11A5C10F25
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 20:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A51206D7
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 20:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEmTTvme"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgCGUd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 15:33:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20249 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726252AbgCGUd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 15:33:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583613203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=EnxWqFw2XGGLFVrvlFzBZqqKIBoeagTKHI5uncmZMZ0=;
        b=DEmTTvme7dtrG/mZxBbbAllYuZPGgRm6AxEZo/5j7c+/+i2LljsCe6g92gi4bMbbvTaVwI
        AgjzYrC+G6d2traQ1WURCUo/xe8tY22udnnKmkxE5hvuBgX3tGgIvLPeTJHpPSYZC+k4ZC
        da7YGh01KVhcZpwKpAjJEyuR4tv6qN8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-JBQ5hQ-2POWH6jDm5ueSOA-1; Sat, 07 Mar 2020 15:33:20 -0500
X-MC-Unique: JBQ5hQ-2POWH6jDm5ueSOA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DBB3107ACC7;
        Sat,  7 Mar 2020 20:33:17 +0000 (UTC)
Received: from [10.36.116.41] (ovpn-116-41.ams2.redhat.com [10.36.116.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4203A272C4;
        Sat,  7 Mar 2020 20:33:09 +0000 (UTC)
Subject: Re: [PATCH RESEND v6 00/16] mm: Page fault enhancements
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
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
        Pavel Emelyanov <xemul@virtuozzo.com>,
        "dgilbert@redhat.com" <dgilbert@redhat.com>
References: <20200220155353.8676-1-peterx@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <1eb7bdd4-348f-da87-47a1-0b022b70e918@redhat.com>
Date:   Sat, 7 Mar 2020 21:33:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200220155353.8676-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.02.20 16:53, Peter Xu wrote:
> [Resend v6]
>=20
> This is v6 of the series.  It is majorly a rebase to 5.6-rc2, nothing
> else to be expected (plus some tests after the rebase).  Instead of
> rewrite the cover letter I decided to use what we have for v5.
>=20
> Adding extra CCs for both Bobby Powers <bobbypowers@gmail.com> and
> Brian Geffon <bgeffon@google.com>.
>=20
> Online repo: https://github.com/xzpeter/linux/tree/mm-pf-signal-retry
>=20
> Any review comment is appreciated.  Thanks,

If I am not completely missing something (and all my testing today was
wrong) there is a very simple reason why I *LOVE* this series and it made
my weekend. It makes userfaultfd with concurrent discarding (e.g.,
MADV_DONTNEED) of pages actually usable.

The issue in current code is that between placing a page and waking
up a waiter, somebody can zap the new placed page and trigger
re-fault, triggering a SIGBUS and crashing an application where all
memory is supposed to be accessible. And there is no real way to protect
from that, because when the fault handler will be woken up and retry
is not deterministic (e.g., making madvise(MADV_DONTNEED) and
UFFDIO_ZEROPAGE mutually exclusive does not help).

Find a simple reproducer at the end of this mail.

Before this series:
[root@localhost ~]# ./a.out=20
Progress!
Progress!
Progress!
Progress!
Progress!
Progress!
Progress!
Progress!
Progress!
Progress!
Progress!
Progress!
[   34.849604] FAULT_FLAG_ALLOW_RETRY missing 70
[   34.850466] CPU: 1 PID: 651 Comm: a.out Not tainted 5.6.0-rc2+ #92
[   34.851525] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.4
[   34.852818] Call Trace:
[   34.853045]  dump_stack+0x8f/0xd0
[   34.853338]  handle_userfault.cold+0x1a/0x2e
[   34.853704]  ? find_held_lock+0x2b/0x80
[   34.854031]  ? __handle_mm_fault+0x18c5/0x1900
[   34.854409]  __handle_mm_fault+0x18d4/0x1900
[   34.854784]  handle_mm_fault+0x169/0x360
[   34.855120]  do_user_addr_fault+0x20d/0x490
[   34.855478]  async_page_fault+0x43/0x50
[   34.855809] RIP: 0033:0x401659
[   34.856069] Code: ba 1f 00 00 00 be 01 00 00 00 bf 10 21 40 00 e8 ad f=
a ff ff bf ff ff ff ff e8 93 fa ff ff 48 8b8
[   34.857629] RSP: 002b:00007ffcfd536ec0 EFLAGS: 00010246
[   34.858076] RAX: 00007fcba86a4000 RBX: 0000000000000000 RCX: 00007fcba=
85784ef
[   34.858675] RDX: 00007fcba86a4007 RSI: 00000000016524e0 RDI: 00007fcba=
864b320
[   34.859272] RBP: 00007ffcfd536f20 R08: 000000000000000a R09: 000000000=
0000070
[   34.859876] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0401120
[   34.860472] R13: 00007ffcfd537000 R14: 0000000000000000 R15: 000000000=
0000000

After this series:
Well, "Progress!" all day long.


Can we please have a way to identify that this "feature" is available?
I'd appreciate a new read-only UFFD_FEAT_ , so we can detect this from
user space easily and use concurrent discards without crashing our applic=
ations.


Questions:
1. I assume KVM will do multiple retries as well, and have the same behav=
ior, right?

2. What will happen if I don't place a page on a pagefault, but only do a=
 UFFDIO_WAKE?
   For now we were able to trigger a signal this way. If the behavior is =
changed, can
   we make this configurable via a UFFD_FEAT?

--- snip ---
#include <string.h>
#include <stdbool.h>
#include <stdint.h>
#include <sys/types.h>
#include <stdio.h>
#include <pthread.h>
#include <errno.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <poll.h>
#include <linux/userfaultfd.h>
#include <sys/mman.h>
#include <sys/syscall.h>
#include <sys/ioctl.h>

static int page_size;

static void *fault_handler_thread(void *arg)
{
    const long uffd =3D (long) arg;
    struct pollfd pollfd =3D {
        .fd =3D uffd,
        .events =3D POLLIN,
    };
    int ret;

    while (true) {
        struct uffdio_zeropage zeropage =3D {};
        struct uffd_msg msg;
        ssize_t nread;

        if (poll(&pollfd, 1, -1) =3D=3D -1) {
            fprintf(stderr, "POLL failed: %s\n", strerror(errno));
            exit(-1);
        }
        if (read(uffd, &msg, sizeof(msg)) !=3D sizeof(msg)) {
            fprintf(stderr, "READ failed\n");
            exit(-1);
        }
        if (msg.event !=3D UFFD_EVENT_PAGEFAULT) {
            fprintf(stderr, "Not UFFD_EVENT_PAGEFAULT\n");
            exit(-1);
        }

        zeropage.range.start =3D msg.arg.pagefault.address;
        zeropage.range.len =3D page_size;
        do {
            ret =3D ioctl(uffd, UFFDIO_ZEROPAGE, &zeropage);
            if (ret && errno !=3D EAGAIN) {
                fprintf(stderr, "UFFDIO_ZEROPAGE failed:%s\n", strerror(e=
rrno));
                exit(-1);
            }
        } while (ret);
    }
}
static void *discard_thread(void *arg)
{
    while (true) {
        if (madvise(arg, page_size, MADV_DONTNEED)) {
            fprintf(stderr, "MADV_DONTNEED failed:%s\n", strerror(errno))=
;
            exit(-1);
        }
        usleep(1000);
    }
}

int main(void)
{
    struct uffdio_register reg;
    struct uffdio_api api =3D {
        .api =3D UFFD_API,
    };
    pthread_t fault, discard;
    long uffd;
    char *area;

    page_size =3D sysconf(_SC_PAGE_SIZE);

    uffd =3D syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
    if (uffd =3D=3D -1) {
        fprintf(stderr, "Could not create uffd: %s\n", strerror(errno));
        exit(-1);
    }
    if (ioctl(uffd, UFFDIO_API, &api) =3D=3D -1) {
        fprintf(stderr, "UFFDIO_API failed: %s\n", strerror(errno));
        exit(-1);
    }

    area =3D mmap(NULL, page_size, PROT_READ | PROT_WRITE,
                MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    if (area =3D=3D MAP_FAILED) {
        fprintf(stderr, "Could not allocate memory");
        exit(-1);
    }

    reg.range.start =3D (uint64_t) area;
    reg.range.len =3D page_size,
    reg.mode =3D UFFDIO_REGISTER_MODE_MISSING;
    if (ioctl(uffd, UFFDIO_REGISTER, &reg) =3D=3D -1) {
        fprintf(stderr, "UFFDIO_REGISTER failed: %s\n", strerror(errno));
        exit(-1);
    }

    /* thread to provide zeropages */
    if (pthread_create(&fault, NULL, fault_handler_thread,
                       (void *) uffd)) {
        fprintf(stderr, "Could not create fault handling thread");
        exit(-1);
    }

    /* thread to discard the page */
    if (pthread_create(&discard, NULL, discard_thread,
                       (void *) area)) {
        fprintf(stderr, "Could not create discard thread");
        exit(-1);
    }

    /* keep reading/writing the page */
    while (true) {
        area[7] =3D area[1];
        usleep(10000);
        printf("Progress!\n");
    }
    return 0;
}


--=20
Thanks,

David / dhildenb


Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_QP_LONG_LINE,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CB3C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E86624677
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i4ipj4G9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgCBUXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 15:23:04 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40399 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725781AbgCBUXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 15:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583180583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1v3eeaBvxWW08CKlRkVMkWVuW1t+GrIzi7YMfXOkG78=;
        b=i4ipj4G9yYjywHSe6MGTQjmmVXHksaRwEIoMOnTeCqPnglqwke6aOTeLK5WUon7XR5Cfb9
        U+xM/L1igAMM6cDlfWFVf45AG/kz5rOjvhP8G1//diH08VJAZ1QrHUDbsBzdEwt8TSRtua
        o98BS5dMY2jU5gqP3+WExA/j2uC/SUA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-vcy8G9dTMYqLTHaiFLjM5g-1; Mon, 02 Mar 2020 15:23:01 -0500
X-MC-Unique: vcy8G9dTMYqLTHaiFLjM5g-1
Received: by mail-wm1-f71.google.com with SMTP id w12so105248wmc.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 12:23:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=1v3eeaBvxWW08CKlRkVMkWVuW1t+GrIzi7YMfXOkG78=;
        b=ozinrrFoTy41rRcxxZmBb4O1EIgycWzQT6rRIeGIuaNjyT9YSQTNhKGXc3mp+/mn0j
         UICwoFqA3HHZ38vvlHSe/HpOOhGEOybEzk4gYptdqQRKbUcz++h5u9pKLyGxQUr6CqK9
         l+S1cpgFCdgv4OeycazqL+hTW95awIEgwhhif9X56GRZbrCjfOWc+SL+H01rW5Ieku0Q
         nYI6sd/uHlT37z93KSgcFY/FJm9y/wcZWwBNNUylROuCQ1UuPgRAKQCWd/4xKlmWGmwW
         8rOSdWzz6Bq+1DA5UYetC4YXMdC9UzEd8n3EBp0J5RHtVqVN0ua/Kuhouwl9Uo4b3thO
         mbjw==
X-Gm-Message-State: ANhLgQ1AeRAlLg6qeLFCKkJlbha062cssisM+cMBzVjJ9nEXlJleNora
        HtzuQEguYoH0jkMvJHN5zqnQZCZctL1t0kDrb57b8Bwte+QDYlepXKB4ikbiqYRpuFZ7zFl2l84
        qKhGnEFmkS2LgI7LqW5V3aSVm
X-Received: by 2002:a5d:4b09:: with SMTP id v9mr1170171wrq.85.1583180579492;
        Mon, 02 Mar 2020 12:22:59 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuk1tLHYCQN5PVOToQUfe18XsP5CatCYQfDDsLOb5ElxjkF0oSmYiEAR1227TUWRygo8Q0VWQ==
X-Received: by 2002:a5d:4b09:: with SMTP id v9mr1170154wrq.85.1583180579234;
        Mon, 02 Mar 2020 12:22:59 -0800 (PST)
Received: from [192.168.3.122] (p5B0C64B4.dip0.t-ipconnect.de. [91.12.100.180])
        by smtp.gmail.com with ESMTPSA id j205sm204790wma.42.2020.03.02.12.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 12:22:58 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RESEND v6 02/16] mm/gup: Fix __get_user_pages() on fault retry of hugetlb
Date:   Mon, 2 Mar 2020 21:22:57 +0100
Message-Id: <671E8651-F7BB-48AF-AFA8-AB38C7AE7BFE@redhat.com>
References: <20200302200731.GA464129@xz-x1>
Cc:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
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
In-Reply-To: <20200302200731.GA464129@xz-x1>
To:     Peter Xu <peterx@redhat.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 02.03.2020 um 21:07 schrieb Peter Xu <peterx@redhat.com>:
>=20
> =EF=BB=BFOn Mon, Mar 02, 2020 at 08:02:34PM +0100, David Hildenbrand wrote=
:
>>> On 20.02.20 16:53, Peter Xu wrote:
>>> When follow_hugetlb_page() returns with *locked=3D=3D0, it means we've g=
ot
>>> a VM_FAULT_RETRY within the fauling process and we've released the
>>> mmap_sem.  When that happens, we should stop and bail out.
>>>=20
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>> mm/gup.c | 10 ++++++++++
>>> 1 file changed, 10 insertions(+)
>>>=20
>>> diff --git a/mm/gup.c b/mm/gup.c
>>> index 1b4411bd0042..76cb420c0fb7 100644
>>> --- a/mm/gup.c
>>> +++ b/mm/gup.c
>>> @@ -849,6 +849,16 @@ static long __get_user_pages(struct task_struct *ts=
k, struct mm_struct *mm,
>>>                i =3D follow_hugetlb_page(mm, vma, pages, vmas,
>>>                        &start, &nr_pages, i,
>>>                        gup_flags, locked);
>>> +                if (locked && *locked =3D=3D 0) {
>>> +                    /*
>>> +                     * We've got a VM_FAULT_RETRY
>>> +                     * and we've lost mmap_sem.
>>> +                     * We must stop here.
>>> +                     */
>>> +                    BUG_ON(gup_flags & FOLL_NOWAIT);
>>> +                    BUG_ON(ret !=3D 0);
>>=20
>> Can we be sure ret is really set to !=3D 0 at this point? At least,
>> reading the code this is not clear to me.
>=20
> Here I wanted to make sure ret is zero (it's BUG_ON, not assert).

Sorry, I completely misread that BUG_ON for whatever reason, maybe I was sta=
ring for too long into my computer screen :)

>=20
> "ret" is the fallback return value only if error happens when i=3D=3D0.
> Here we want to make sure even if no page is pinned we'll return zero
> gracefully when VM_FAULT_RETRY happened when following the hugetlb
> pages.

Makes sense!

>=20
>>=20
>> Shouldn't we set "ret =3D i" and assert that i is an error (e.g., EBUSY?)=
.
>> Or set -EBUSY explicitly?
>=20
> No.  Here "i" could only be either positive (when we've got some pages
> pinned no matter where), or zero (when follow_hugetlb_page released
> the mmap_sem on the first page that it wants to pin).  So imo "i"
> should never be negative instead.

I briefly scanned the function and spotted some errors being returned, that=E2=
=80=98s why I was wondering.

Thanks!


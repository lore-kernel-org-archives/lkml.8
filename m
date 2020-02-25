Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608A3C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C292176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 18:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nd3cYOeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbgBYSCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 13:02:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48148 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726953AbgBYSCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 13:02:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582653761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
        bh=jXQ5ajSsoTpibZAFkWJhv93iOc+cNRzn0v1VEP6LHTo=;
        b=Nd3cYOeWax3uj4vlZ+YZWEXvLQmLkPKF7+cWUB5kYb8vQDVG0d/OxBDSYeHeHneU2H19XW
        9bAYA4Ty+fy0deqdLWM/BLHFWq8sw726YOehH5Pf7R7gp4DOSDcKDImu3n62+QGM4UbVKo
        Cc+xrEpT66f+8c0kwLpUOxhgAlSTgCU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-458-rBV5DQmhOY2_Ijcx6yi3oA-1; Tue, 25 Feb 2020 13:02:37 -0500
X-MC-Unique: rBV5DQmhOY2_Ijcx6yi3oA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 115E8107ACC4;
        Tue, 25 Feb 2020 18:02:36 +0000 (UTC)
Received: from [10.36.117.12] (ovpn-117-12.ams2.redhat.com [10.36.117.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 632008C07B;
        Tue, 25 Feb 2020 18:02:34 +0000 (UTC)
Subject: Re: [v2 PATCH] mm: shmem: allow split THP when truncating THP
 partially
To:     Hugh Dickins <hughd@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Cc:     kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1575420174-19171-1-git-send-email-yang.shi@linux.alibaba.com>
 <alpine.LSU.2.11.1912041601270.12930@eggly.anvils>
 <00f0bb7d-3c25-a65f-ea94-3e2de8e9bcdd@linux.alibaba.com>
 <alpine.LSU.2.11.2002241831060.3084@eggly.anvils>
From:   David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat GmbH
Message-ID: <14abd659-1571-8196-202d-d2fcc227a4b0@redhat.com>
Date:   Tue, 25 Feb 2020 19:02:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <alpine.LSU.2.11.2002241831060.3084@eggly.anvils>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>
>> Any update on this one?
>=20
> I apologize for my dreadful unresponsiveness.
>=20
> I've spent the last day trying to love yours, and considering how mine
> might be improved; but repeatedly arrived at the conclusion that mine i=
s
> about as nice as we can manage, just needing more comment to dignify it=
.
>=20
> I did willingly call my find_get_entries() stopping at PageTransCompoun=
d
> a hack; but now think we should just document that behavior and accept =
it.
> The contortions of your patch come from the need to release those 14 ex=
tra
> unwanted references: much better not to get them in the first place.
>=20
> Neither of us handle a failed split optimally, we treat every tail as a=
n
> opportunity to retry: which is good to recover from transient failures,
> but probably excessive.  And we both have to restart the pagevec after
> each attempt, but at least I don't get 14 unwanted extras each time.
>=20
> What of other find_get_entries() users and its pagevec_lookup_entries()
> wrapper: does an argument to select this "stop at PageTransCompound"
> behavior need to be added?
>=20
> No.  The pagevec_lookup_entries() calls from mm/truncate.c prefer the
> new behavior - evicting the head from page cache removes all the tails
> along with it, so getting the tails a waste of time there too, just as
> it was in shmem_undo_range().
>=20
> Whereas shmem_unlock_mapping() and shmem_seek_hole_data(), as they
> stand, are not removing pages from cache, but actually wanting to plod
> through the tails.  So those two would be slowed a little, while the
> pagevec collects 1 instead of 15 pages.  However: if we care about thos=
e
> two at all, it's clear that we should speed them up, by noticing the
> PageTransCompound case and accelerating over it, instead of plodding
> through the tails.  Since we haven't bothered with that optimization
> yet, I'm not very worried to slow them down a little until it's done.
>=20
> I must take a look at where we stand with tmpfs 64-bit ino tomorrow,
> then recomment my shmem_punch_compound() patch and post it properly,
> probably day after.  (Reviewing it, I see I have a "page->index +
> HPAGE_PMD_NR <=3D end" test which needs correcting - I tend to live
> in the past, before v4.13 doubled the 32-bit MAX_LFS_FILESIZE.)
>=20
> I notice that this thread has veered off into QEMU ballooning
> territory: which may indeed be important, but there's nothing at all
> that I can contribute on that.  I certainly do not want to slow down
> anything important, but remain convinced that the correct filesystem
> implementation for punching a hole is to punch a hole.

I am not completely sure I follow all the shmem details (sorry!). But
trying to "punch a partial hole punch" into a hugetlbfs page will result
in the very same behavior as with shmem as of now, no?

FALLOC_FL_PUNCH_HOLE: "Within the specified range, partial filesystem
blocks are zeroed, and whole filesystem blocks are removed from the
file." ... After a successful call, subsequent reads from this range
will return zeros."

So, as long as we are talking about partial blocks the documented
behavior seems to be to only zero the memory.

Does this patch fix "FALLOC_FL_PUNCH_HOLE does not free blocks if called
in block granularity on shmem" (which would be a valid fix), or does it
try to implement something that is not documented? (removing partial
blocks when called in sub-block granularity)

I assume the latter, in which case I would interpret "punching a hole is
to punch a hole" as "punching sub-blocks will not free blocks".

(if somebody could enlighten me which important piece I am missing or
messing up, that would be great :) )

--=20
Thanks,

David / dhildenb


Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1EBC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08A202145D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="ZkNFv3uO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730957AbgIHUQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:16:52 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15900 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729993AbgIHPKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:10:01 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f579e780000>; Tue, 08 Sep 2020 08:08:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 08 Sep 2020 08:09:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 08 Sep 2020 08:09:30 -0700
Received: from [10.2.173.224] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 8 Sep
 2020 15:09:27 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Roman Gushchin <guro@fb.com>, <linux-mm@kvack.org>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Date:   Tue, 8 Sep 2020 11:09:25 -0400
X-Mailer: MailMate (1.13.1r5705)
Message-ID: <3CDAD67E-23A1-4D84-BF19-FFE1CF956779@nvidia.com>
In-Reply-To: <20200907072014.GD30144@dhcp22.suse.cz>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200903073254.GP4617@dhcp22.suse.cz>
 <20200903162527.GF60440@carbon.dhcp.thefacebook.com>
 <20200904074207.GC15277@dhcp22.suse.cz>
 <20200904211045.GA567128@carbon.DHCP.thefacebook.com>
 <20200907072014.GD30144@dhcp22.suse.cz>
MIME-Version: 1.0
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: multipart/signed;
        boundary="=_MailMate_7EDFBC1A-C6C8-4AEF-8110-676C99F27B91_=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599577720; bh=jnz+dCZGTh2wGzZqbGtsnPy5hFqZLkUbDaA96gFT3Ps=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:X-Mailer:Message-ID:
         In-Reply-To:References:MIME-Version:X-Originating-IP:
         X-ClientProxiedBy:Content-Type;
        b=ZkNFv3uOrVPsbPahKFLZbOUwHLsE3AqdbHeu6IFT7rCjitH2P3xGmUtwrapYanNkX
         yRipfqYYrsNMMFT52oZetbPHqSQAXD0uGgme+pNWNRgP9sOe0QS7vg84l3uVYAnj2x
         ntHbQmstRnCVe1ZlMbDk10FURBOa9efBKDw3DaNOhPMRxR6dFfOMSv/uoTl3BhIa+I
         znRhBw6KmNE782Nu8+a/cq8cdET2c0erj0OS69iw3PCQEiglhyJ0cut+/7xcuJ3btK
         kRBKi+8tVBku5WjYslW93gJAuT15/YSTdoxQBi//zsY5DgVmCpc7a3oYZG2mm5rFk5
         eywxRP8FYMZ7g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_7EDFBC1A-C6C8-4AEF-8110-676C99F27B91_=
Content-Type: text/plain; charset="UTF-8"; markup=markdown
Content-Transfer-Encoding: quoted-printable

On 7 Sep 2020, at 3:20, Michal Hocko wrote:

> On Fri 04-09-20 14:10:45, Roman Gushchin wrote:
>> On Fri, Sep 04, 2020 at 09:42:07AM +0200, Michal Hocko wrote:
> [...]
>>> An explicit opt-in sounds much more appropriate to me as well. If we =
go
>>> with a specific API then I would not make it 1GB pages specific. Why
>>> cannot we have an explicit interface to "defragment" address space
>>> range into large pages and the kernel would use large pages where
>>> appropriate? Or is the additional copying prohibitively expensive?
>>
>> Can you, please, elaborate a bit more here? It seems like madvise(MADV=
_HUGEPAGE)
>> provides something similar to what you're describing, but there are lo=
t
>> of details here, so I'm probably missing something.
>
> MADV_HUGEPAGE is controlling a preference for THP to be used for a
> particular address range. So it looks similar but the historical
> behavior is to control page faults as well and the behavior depends on
> the global setup.
>
> I've had in mind something much simpler. Effectively an API to invoke
> khugepaged (like) functionality synchronously from the calling context
> on the specific address range. It could be more aggressive than the
> regular khugepaged and create even 1G pages (or as large THPs as page
> tables can handle on the particular arch for that matter).
>
> As this would be an explicit call we do not have to be worried about
> the resulting latency because it would be an explicit call by the
> userspace.  The default khugepaged has a harder position there because
> has no understanding of the target address space and cannot make any
> cost/benefit evaluation so it has to be more conservative.

Something like MADV_HUGEPAGE_SYNC? It would be useful, since users have
better and clearer control of getting huge pages from the kernel and
know when they will pay the cost of getting the huge pages.

I would think the suggestion is more about the huge page control options
currently provided by the kernel do not have predictable performance
outcome, since MADV_HUGEPAGE is a best-effort option and does not tell
users whether the marked virtual address range is backed by huge pages
or not when the madvise returns. MADV_HUGEPAGE_SYNC would provide a
deterministic result to users on whether the huge page(s) are formed
or not.

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_7EDFBC1A-C6C8-4AEF-8110-676C99F27B91_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAl9XnqUPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKS+oQAJojTqyoQvL31XcZ+NFpnvN4yzKKUCnvHJXH
z7mb9aqUbdDJ3sABiHPa8jyjZoyxbSh8khEyUtfuLgqQ3V8/rFNDcXbTgjKgu7dg
PUS9EdMATXRPkfRHe/X+3gXfmbsm1zD3qU84qQLPcenu3RAbWziXlC3+grWBqaVV
ktZ8NGtpLkzkx2Fk3s/ZBSe9HgCE8CJHBZtxGT6XXxMxaHbGNCu9jmtaRNVG1Fcu
QTMWe5eYbkR4g1hPmaPD9W5cjgEeno77VhdGH7RTCiOO18Yh5/4PUybz13qjztbY
1tCOfaZpYI1w9fVtlY8d0oPLytZ/A9YoCEz4NGhM6YmsHDR15Mjf8p7xPmfSK7cM
kRcIGabPHa6UDrzBgCjjnJHm3DIgO+56ZtS4smFbKG0+2nk5g43MSTrN07MrsAi7
d9GBp/qct3LCHWejJyxGKAJ9hPTVILJlIrp8pCajwPRvxXz/Kx0g61/nx571kr9H
VqV4UiF6xZGSYAiAsL66DqerxaIYn/y1wMyS/4GcCr37hb94T+KWh6DyV0oczQsb
NKbo4Kx+4LSpFgs4j7/h6ZEVu83u5uaFLuW832WDgi0KfZf/tGFzyjt1S0IXxzrA
wyP3WsaMRtOWl+66+nE7sEwY7fReeRY5fQnQ8KBtAsm/8v0hXMk5gmKQlLwbAK+n
LKsetGJu
=NLLe
-----END PGP SIGNATURE-----

--=_MailMate_7EDFBC1A-C6C8-4AEF-8110-676C99F27B91_=--

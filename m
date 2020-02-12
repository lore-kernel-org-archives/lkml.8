Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D9BC3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FF42073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SKwd+Yaa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgBLLUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:20:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28183 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727947AbgBLLUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:20:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581506413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ISQpWX8qRdL9ZLUrbjv3TLSIeU6toSMj/m/1mOebzDg=;
        b=SKwd+YaabkzXD1FiGR8WCJmU3mjytecEhUlsoxQGoxBT1fJfh0Z/jfZkzVeCVuAWBvFoPo
        toA1vRgfgAhSGd/zE6cN5qQDTIJbNshQjpXJViM/t7QQygbLxhLIgW7XT13yMf2I9ZzLHN
        TKqgqXlBnl1G98wlZCigjyly41qkntw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-XcEi_Dj7MAiCndTsDJgohg-1; Wed, 12 Feb 2020 06:20:11 -0500
X-MC-Unique: XcEi_Dj7MAiCndTsDJgohg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4313BDB65;
        Wed, 12 Feb 2020 11:20:10 +0000 (UTC)
Received: from localhost (ovpn-12-47.pek2.redhat.com [10.72.12.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D719E1001B07;
        Wed, 12 Feb 2020 11:20:03 +0000 (UTC)
Date:   Wed, 12 Feb 2020 19:20:00 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 3/7] mm/sparse.c: only use subsection map in VMEMMAP case
Message-ID: <20200212112000.GH8965@MiWiFi-R3L-srv>
References: <CAPcyv4hh5PmF8qU+p7Q903PhX+ho9yHMzLFncmh6psW5YOLU_w@mail.gmail.com>
 <B23A05D9-40E2-4862-979D-C6DA69DDDC80@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <B23A05D9-40E2-4862-979D-C6DA69DDDC80@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/20 at 10:39am, David Hildenbrand wrote:
>=20
>=20
> > Am 11.02.2020 um 21:15 schrieb Dan Williams <dan.j.williams@intel.com=
>:
> >=20
> > =EF=BB=BFOn Sun, Feb 9, 2020 at 2:48 AM Baoquan He <bhe@redhat.com> w=
rote:
> >>=20
> >> Currently, subsection map is used when SPARSEMEM is enabled, includi=
ng
> >> VMEMMAP case and !VMEMMAP case. However, subsection hotplug is not
> >> supported at all in SPARSEMEM|!VMEMMAP case, subsection map is unnec=
essary
> >> and misleading. Let's adjust code to only allow subsection map being
> >> used in SPARSEMEM|VMEMMAP case.
> >>=20
> >> Signed-off-by: Baoquan He <bhe@redhat.com>
> >> ---
> >> include/linux/mmzone.h |   2 +
> >> mm/sparse.c            | 231 ++++++++++++++++++++++-----------------=
--
> >> 2 files changed, 124 insertions(+), 109 deletions(-)
> >>=20
> >> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> >> index 462f6873905a..fc0de3a9a51e 100644
> >> --- a/include/linux/mmzone.h
> >> +++ b/include/linux/mmzone.h
> >> @@ -1185,7 +1185,9 @@ static inline unsigned long section_nr_to_pfn(=
unsigned long sec)
> >> #define SUBSECTION_ALIGN_DOWN(pfn) ((pfn) & PAGE_SUBSECTION_MASK)
> >>=20
> >> struct mem_section_usage {
> >> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
> >>        DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
> >> +#endif
> >=20
> > This was done deliberately so that the SPARSEMEM_VMEMMAP=3Dn case ran=
 as
> > a subset of the SPARSEMEM_VMEMMAP=3Dy case.

Thanks for checking this, Dan.

Taking away the subsection part, won't affect the classic sparse being a
subset of VMEMMAP case, I would say.


> >=20
> > The diffstat does not seem to agree that this is any clearer:
> >=20
> >    124 insertions(+), 109 deletions(-)
> >=20
>=20
> I don=E2=80=98t see a reason to work with subsections (+store them) if =
subsections are not supported.
>=20
> I do welcome this cleanup. Diffstats don=E2=80=98t tell the whole story=
.

Thanks for clarifying this, David, I agree.

If applying the patch, it should be easier to observe that the code
is simpler to follow, at least won't be confusing on subsection handling
part.


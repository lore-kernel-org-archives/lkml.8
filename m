Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD77CC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F70520746
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:43:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QOqVmkTl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgEEMn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 08:43:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50243 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728512AbgEEMn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 08:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588682606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QvblSLfFZRo0c25upM8T9PfnHCbkleHxSvyb57+CDAY=;
        b=QOqVmkTlVl9pOFEnJsmwcbOi062aUmQe3mj0IV9gdpktGUgciIsZgd9VIEKHm1nfIU54wd
        1b1PGlk73zVKri+3w0JZLadMMRRLovhyKWOdNYUtN9sb2lUzE8WSZ+b7c+R37xFZVs14qQ
        nsDXgYcyweO86+OWE654Po7xBNKh6Ng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-IrthXCA0OrWchj2813q8Nw-1; Tue, 05 May 2020 08:43:24 -0400
X-MC-Unique: IrthXCA0OrWchj2813q8Nw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 076C3872FEA;
        Tue,  5 May 2020 12:43:22 +0000 (UTC)
Received: from localhost (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 97E372E025;
        Tue,  5 May 2020 12:43:17 +0000 (UTC)
Date:   Tue, 5 May 2020 20:43:14 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: compaction: VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn))
Message-ID: <20200505124314.GA5029@MiWiFi-R3L-srv>
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
 <20200424034353.GD4247@MiWiFi-R3L-srv>
 <A49F2991-4319-4207-9B6E-CC8563102C27@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A49F2991-4319-4207-9B6E-CC8563102C27@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 04/24/20 at 09:45am, Qian Cai wrote:
>=20
>=20
> > On Apr 23, 2020, at 11:43 PM, Baoquan He <bhe@redhat.com> wrote:
> >=20
> > On 04/23/20 at 05:25pm, Qian Cai wrote:
> >> Compaction starts to crash below on linux-next today. The faulty pag=
e belongs to Node 0 DMA32 zone.
> >> I=E2=80=99ll continue to narrow it down, but just want to give a hea=
dup in case someone could beat me to it.
> >>=20
> >> Debug output from free_area_init_core()
> >> [    0.000000] KK start page =3D ffffea0000000040, end page =3D ffff=
ea0000040000, nid =3D 0 DMA
> >> [    0.000000] KK start page =3D ffffea0000040000, end page =3D ffff=
ea0004000000, nid =3D 0 DMA32
> >> [    0.000000] KK start page =3D ffffea0004000000, end page =3D ffff=
ea0012000000, nid =3D 0 NORMAL
> >> [    0.000000] KK start page =3D ffffea0012000000, end page =3D ffff=
ea0021fc0000, nid =3D 4 NORMAL
> >=20
> > Where are these printed? They are the direct mapping address of page?
>=20
> From this debug patch. Yes, direct mapping.

Can you try below patch? I may get why this is caused, not sure if the
place is right.=20

diff --git a/mm/compaction.c b/mm/compaction.c
index 177c11a8f3b9..e26972f26414 100644
--- a/mm/compaction.c
+++ b/mm/compaction.c
@@ -1409,7 +1409,9 @@ fast_isolate_freepages(struct compact_control *cc)
 				cc->free_pfn =3D highest;
 			} else {
 				if (cc->direct_compaction && pfn_valid(min_pfn)) {
-					page =3D pfn_to_page(min_pfn);
+					page =3D pageblock_pfn_to_page(min_pfn,
+						pageblock_end_pfn(min_pfn),
+						cc->zone);
 					cc->free_pfn =3D min_pfn;
 				}
 			}


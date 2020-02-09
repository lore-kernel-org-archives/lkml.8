Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383FBC35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 14:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E7C2080C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 14:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dEXlpokB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgBIOOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 09:14:35 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30359 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727473AbgBIOOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 09:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581257673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=813s76S6mX/ZPXrvvTupXYay1h8zH1+OICdcpr86wfM=;
        b=dEXlpokB9sBvH5OyxgRXM7txUvoO1hIOkx+vwe74oO75shGyRBOliJFfOUerrkkMw1T0ok
        i5SqpjJHmzRJ0we0bl2rctZ9Bb3vvbCgwoAY2wT6Kx3z7HiuRh7LMWYtovB2f/hAoRJHnU
        jJiTn/nI+U7hsngjqIdvLIKIFIAFzbs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-vKJTVaD7NAW5AVErefS_ng-1; Sun, 09 Feb 2020 09:14:32 -0500
X-MC-Unique: vKJTVaD7NAW5AVErefS_ng-1
Received: by mail-wr1-f69.google.com with SMTP id j4so3227166wrs.13
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 06:14:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=813s76S6mX/ZPXrvvTupXYay1h8zH1+OICdcpr86wfM=;
        b=eMHTq6/Qs8RTUpwLjWJpD92s9H+12bmvao7KbyHf3mskzaxE25h8sFqdV7hF5Lc/+R
         cDBoFpLFdLP94f8b9waEM7+jsmM/p1XMtzO+6ZAUSD2FhM+5Iz+bNHE8YZ7qD3tF62oo
         h/D1sLgBHrKMZvpNQLu+LxxrldxpCzQQljHO1nVS2PDaZ8phQpQvn6g35tV3fJjyoSyI
         FtFa4kVJM/xior8r7lO89hZ8sxCg80TrEXyeIl+mjat/1IIQVGpuGGYHTjaRsYONscXK
         E5ADmn8OO8raPralUjhURlJJhtW/0YZkCnzUoRkGrVmibpxWzuSAsv5Aa3/xw20URIq6
         paHQ==
X-Gm-Message-State: APjAAAVykVb1DhDggEwsFKgBzj0UcAPujQG9ASrJRA8+H2sifhHK77UX
        Nsg7Y41TFy4U7GA1PD+AtMkvV0S2fJi0Pd0ZpTt6oYmD67uci0Q2Nyhog4wYZXm72SiZyQnTI8E
        VdxLSogzEuQ01I3EcY73Lyc4J
X-Received: by 2002:a7b:cb49:: with SMTP id v9mr10208418wmj.160.1581257670899;
        Sun, 09 Feb 2020 06:14:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqywWLeCJMBRdhe4PAzltDrfZmYBKWl+x+93v2t0WrtYuOGkM04/aaempW6pNrI0HoPra/JtKA==
X-Received: by 2002:a7b:cb49:: with SMTP id v9mr10208397wmj.160.1581257670604;
        Sun, 09 Feb 2020 06:14:30 -0800 (PST)
Received: from [192.168.178.65] (p4FE0FDD8.dip0.t-ipconnect.de. [79.224.253.216])
        by smtp.gmail.com with ESMTPSA id d22sm11721121wmd.39.2020.02.09.06.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Feb 2020 06:14:30 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/3] mm/sparsemem: get physical address to page struct instead of virtual address to pfn
Date:   Sun, 9 Feb 2020 15:14:28 +0100
Message-Id: <A25CC0EC-73A0-426D-93A0-DD9DDC43800F@redhat.com>
References: <20200209135015.GX8965@MiWiFi-R3L-srv>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
In-Reply-To: <20200209135015.GX8965@MiWiFi-R3L-srv>
To:     Baoquan He <bhe@redhat.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 09.02.2020 um 14:50 schrieb Baoquan He <bhe@redhat.com>:
>=20
> =EF=BB=BFOn 02/07/20 at 11:26am, Wei Yang wrote:
>>> On Thu, Feb 06, 2020 at 06:19:46PM -0800, Dan Williams wrote:
>>> On Thu, Feb 6, 2020 at 3:17 PM Wei Yang <richardw.yang@linux.intel.com> w=
rote:
>>>>=20
>>>> memmap should be the physical address to page struct instead of virtual=

>>>> address to pfn.
>>>>=20
>>>> Since we call this only for SPARSEMEM_VMEMMAP, pfn_to_page() is valid a=
t
>>>> this point.
>>>>=20
>>>> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
>>>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>>>> CC: Dan Williams <dan.j.williams@intel.com>
>>>> ---
>>>> mm/sparse.c | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>=20
>>>> diff --git a/mm/sparse.c b/mm/sparse.c
>>>> index b5da121bdd6e..56816f653588 100644
>>>> --- a/mm/sparse.c
>>>> +++ b/mm/sparse.c
>>>> @@ -888,7 +888,7 @@ int __meminit sparse_add_section(int nid, unsigned l=
ong start_pfn,
>>>>        /* Align memmap to section boundary in the subsection case */
>>>>        if (IS_ENABLED(CONFIG_SPARSEMEM_VMEMMAP) &&
>>>>                section_nr_to_pfn(section_nr) !=3D start_pfn)
>>>> -               memmap =3D pfn_to_kaddr(section_nr_to_pfn(section_nr));=

>>>> +               memmap =3D pfn_to_page(section_nr_to_pfn(section_nr));
>>>=20
>>> Yes, this looks obviously correct. This might be tripping up
>>> makedumpfile. Do you see any practical effects of this bug? The kernel
>>> mostly avoids ->section_mem_map in the vmemmap case and in the
>>> !vmemmap case section_nr_to_pfn(section_nr) should always equal
>>> start_pfn.
>>=20
>> I took another look into the code. Looks there is no practical effect aft=
er
>> this. Because in the vmemmap case, we don't need ->section_mem_map to ret=
rieve
>> the real memmap.
>>=20
>> But leave a inconsistent data in section_mem_map is not a good practice.
>=20
> Yeah, it does has no pratical effect. I tried to create sub-section
> alighed namespace, then trigger crash, makedumpfile isn't impacted.
> Because pmem memory is only added, but not onlined. We don't report it
> to kdump, makedumpfile will ignore it.
>=20
> I think it's worth fixing it to encode a correct memmap address. We
> don't know if in the future this will break anything.

We can have system memory and devmem overlap within a section (which is stil=
l buggy and to be fixed in other regard - e.g., pfn_to_online_page() does no=
t work correctly).

E.g., 64 mb of (boot) system memory in a section. Then you can hot-add devme=
m that spans the remaining 64 mb of that section.

So some of that memory will be kdumped - and should be fixed if broken.

Cheers


>=20
> Thanks
> Baoquan


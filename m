Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D592DC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE379206ED
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:40:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WggSq1/q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgBLJkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:40:04 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20255 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728637AbgBLJkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:40:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581500402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c83LcFNEPkF5bSyJ17QW8npolY+U6XnNUigsdS1CwDA=;
        b=WggSq1/qyagL8Qt+HfpUMjavAivj7ylxkdZRHMotiGpJbJuN/NvCaPDHTmneyEv2C4nlEJ
        BZghh1ARVFsPYw45aprrSXfwEJ04xvPWvT7gmj6FO0VED7SOranSFi4kBU45OWhD95nMn1
        gp6woXMrd8Q2TXelK6u4qr/sL8sliF8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-cFFR_5nTOn-A9eJBKXrdDA-1; Wed, 12 Feb 2020 04:40:00 -0500
X-MC-Unique: cFFR_5nTOn-A9eJBKXrdDA-1
Received: by mail-wm1-f71.google.com with SMTP id f66so701601wmf.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 01:39:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=c83LcFNEPkF5bSyJ17QW8npolY+U6XnNUigsdS1CwDA=;
        b=uCt80abQCLgQ0JTMOunMJfvwXeP1GUI5ip255WeERaNTyG8KVTxjPuY1HnB+jtavC6
         A4eq8AM/oFoWX5DbSAAC89V6ls3ln6p+ccNtRTvp6dWL51A8DLeN4aw6tGO/wzBgNwY+
         QG455qHoh/fn6T3QDqtkmC4ZZWD7hNAIx5IW18MBy4UCMCliCDa9xkhc5azyEOMYDr2w
         jkkQqKHwVdxNMRk4p3GH3qmFFuU4BpjudrQwM6Ci6DMcrHoiAs+xYufZabvqK0LQZ+CT
         WcU8JLard471dHTrkXHbDRH6n+MLhW9ckRI6oMFfgajSIFYGaOUee95mEydibfDe3n4f
         AccA==
X-Gm-Message-State: APjAAAWvrDFBuJKYIKnXnz69wnz96aNTnZnlK3p8ksWwqGGnWc0IY9MB
        zmYjyZlg2SBp8TIx5ziF2OSzIrqbZSgQDVppCwj+xL0L2pjnhl14+GgLo+fhiW+Lzsb7ZA6tgz8
        1udZW18V4ZMOy1KNk2I5j9wIm
X-Received: by 2002:a7b:cc81:: with SMTP id p1mr11434528wma.62.1581500398736;
        Wed, 12 Feb 2020 01:39:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqycGgOsxcsLpBqLe1JUUbLxeEn1YGzSgVehs1upbAUjMLYhLIYvtCmSvFnQyscOJ1cUULDMig==
X-Received: by 2002:a7b:cc81:: with SMTP id p1mr11434495wma.62.1581500398455;
        Wed, 12 Feb 2020 01:39:58 -0800 (PST)
Received: from ?IPv6:2a01:598:b900:81d7:5461:d59c:2c6b:6afa? ([2a01:598:b900:81d7:5461:d59c:2c6b:6afa])
        by smtp.gmail.com with ESMTPSA id h18sm9160176wrv.78.2020.02.12.01.39.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 01:39:57 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 3/7] mm/sparse.c: only use subsection map in VMEMMAP case
Date:   Wed, 12 Feb 2020 10:39:56 +0100
Message-Id: <B23A05D9-40E2-4862-979D-C6DA69DDDC80@redhat.com>
References: <CAPcyv4hh5PmF8qU+p7Q903PhX+ho9yHMzLFncmh6psW5YOLU_w@mail.gmail.com>
Cc:     Baoquan He <bhe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yang <richardw.yang@linux.intel.com>,
        David Hildenbrand <david@redhat.com>
In-Reply-To: <CAPcyv4hh5PmF8qU+p7Q903PhX+ho9yHMzLFncmh6psW5YOLU_w@mail.gmail.com>
To:     Dan Williams <dan.j.williams@intel.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 11.02.2020 um 21:15 schrieb Dan Williams <dan.j.williams@intel.com>:
>=20
> =EF=BB=BFOn Sun, Feb 9, 2020 at 2:48 AM Baoquan He <bhe@redhat.com> wrote:=

>>=20
>> Currently, subsection map is used when SPARSEMEM is enabled, including
>> VMEMMAP case and !VMEMMAP case. However, subsection hotplug is not
>> supported at all in SPARSEMEM|!VMEMMAP case, subsection map is unnecessar=
y
>> and misleading. Let's adjust code to only allow subsection map being
>> used in SPARSEMEM|VMEMMAP case.
>>=20
>> Signed-off-by: Baoquan He <bhe@redhat.com>
>> ---
>> include/linux/mmzone.h |   2 +
>> mm/sparse.c            | 231 ++++++++++++++++++++++-------------------
>> 2 files changed, 124 insertions(+), 109 deletions(-)
>>=20
>> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
>> index 462f6873905a..fc0de3a9a51e 100644
>> --- a/include/linux/mmzone.h
>> +++ b/include/linux/mmzone.h
>> @@ -1185,7 +1185,9 @@ static inline unsigned long section_nr_to_pfn(unsig=
ned long sec)
>> #define SUBSECTION_ALIGN_DOWN(pfn) ((pfn) & PAGE_SUBSECTION_MASK)
>>=20
>> struct mem_section_usage {
>> +#ifdef CONFIG_SPARSEMEM_VMEMMAP
>>        DECLARE_BITMAP(subsection_map, SUBSECTIONS_PER_SECTION);
>> +#endif
>=20
> This was done deliberately so that the SPARSEMEM_VMEMMAP=3Dn case ran as
> a subset of the SPARSEMEM_VMEMMAP=3Dy case.
>=20
> The diffstat does not seem to agree that this is any clearer:
>=20
>    124 insertions(+), 109 deletions(-)
>=20

I don=E2=80=98t see a reason to work with subsections (+store them) if subse=
ctions are not supported.

I do welcome this cleanup. Diffstats don=E2=80=98t tell the whole story.=


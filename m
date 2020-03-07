Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94978C10DCE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 02:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B108206E6
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 02:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="TobaqPZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCGC1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 21:27:45 -0500
Received: from mail-qv1-f42.google.com ([209.85.219.42]:39253 "EHLO
        mail-qv1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgCGC1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 21:27:45 -0500
Received: by mail-qv1-f42.google.com with SMTP id fc12so1909678qvb.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 18:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Xyt6pVhon/2aZQC2wk1neLD+BgEVwWmhUAx8r/Hnvac=;
        b=TobaqPZPfsZXYUfUwAOtAPBnJS2y7ZJynkfiLggAmq2PgFHuYUVbRjgrnewbyCkeY1
         TA7Wgy1TxIg3Duygg8VaRKvrDqVgMpivOQ760FFPQx0q/LhM8IyCNJyFAd8EItYKitd4
         8TOCtWATlHA+X5+1CYtsIbYMWGJfJNDEU3uD1Vqr0/cNwKDBnqSj9I3WL3pG8oUahbNl
         2n9HiR1bRn7Qa5fjG99C2A0Owk6bNjZGg2ZJM9HfyuUqcjNIb/haTkeL+58XXOzQ4jqD
         xf18SIziPTTHkQFJZdhWmK9hpIFN78UW+6BVoWpF0oN1/+tJGWqRDpTZiSepAdEo7N06
         mMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Xyt6pVhon/2aZQC2wk1neLD+BgEVwWmhUAx8r/Hnvac=;
        b=XKkD6vXMP4vsbozPYg/gLMpTKFGDDhShrpLQEnCuqFKd86uNYum1uo6Hc4ZM6MoXXG
         Baa9jLMJNmGT5QFRmdL9XTLw4czOezD2tTF8uUOivyVDfbEqr/gb+aVI33s1xXUMOsBy
         DqdJyi1IkE9iqZAKZV8NQfleiya0+8MfhOsCBqOMcx3jQlQ/Kdzn9SJd80KrVM5tebua
         hR6qs6vSwi5tkMI0pxhNE6pVzNP+hIl4Zw/yTNvH8Fw+SH1xiVFHClxJ81cBZ5ePlvxE
         m4H9xAzhwWTkUW4xKaZq5KctJvq/mY8+mkPZ1sBwWaylIBOesqe8hJNCYYPFIJpEVK7H
         rRIA==
X-Gm-Message-State: ANhLgQ0bXxgAR4J52lGF3QPsqb5eoTqqymUGAKJNPgGUDEsyS+4zb6md
        8aB69AY09yCNZk7zlHyCaRyt+N870J3EGw==
X-Google-Smtp-Source: ADFU+vtYmiDe9rg5kkRiwE1GtNAn+gV8RcmDs6v7eaGBOma+mr5pxA3Zmo1yoCD2DnA6wzlNz+y0EA==
X-Received: by 2002:a0c:e8c5:: with SMTP id m5mr5620996qvo.40.1583548063635;
        Fri, 06 Mar 2020 18:27:43 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id b11sm1077635qtp.82.2020.03.06.18.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Mar 2020 18:27:42 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [failures] mm-vmscan-remove-unnecessary-lruvec-adding.patch
 removed from -mm tree
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <f37b9b6b-730b-09b0-dd6b-5acba53e71e6@linux.alibaba.com>
Date:   Fri, 6 Mar 2020 21:27:41 -0500
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, aarcange@redhat.com,
        daniel.m.jordan@oracle.com, hannes@cmpxchg.org, hughd@google.com,
        khlebnikov@yandex-team.ru, kirill@shutemov.name,
        kravetz@us.ibm.com, mhocko@kernel.org, mm-commits@vger.kernel.org,
        tj@kernel.org, vdavydov.dev@gmail.com, willy@infradead.org,
        yang.shi@linux.alibaba.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <792CE873-A64B-4FA6-A258-A8B6B951E698@lca.pw>
References: <20200306025041.rERhvnYmB%akpm@linux-foundation.org>
 <211632B1-2D6F-4BFA-A5A0-3030339D3D2A@lca.pw>
 <b123f1d8-eab0-4689-9400-ba1f853728b7@linux.alibaba.com>
 <f37b9b6b-730b-09b0-dd6b-5acba53e71e6@linux.alibaba.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 6, 2020, at 6:58 AM, Alex Shi <alex.shi@linux.alibaba.com> =
wrote:
>=20
>=20
>=20
> =E5=9C=A8 2020/3/6 =E4=B8=8B=E5=8D=885:04, Alex Shi =E5=86=99=E9=81=93:
>>=20
>>=20
>> =E5=9C=A8 2020/3/6 =E4=B8=8A=E5=8D=8811:32, Qian Cai =E5=86=99=E9=81=93=
:
>>>=20
>>>> On Mar 5, 2020, at 9:50 PM, akpm@linux-foundation.org wrote:
>>>>=20
>>>>=20
>>>> The patch titled
>>>>    Subject: mm/vmscan: remove unnecessary lruvec adding
>>>> has been removed from the -mm tree.  Its filename was
>>>>    mm-vmscan-remove-unnecessary-lruvec-adding.patch
>>>>=20
>>>> This patch was dropped because it had testing failures
>>> Andrew, do you have more information about this failure? I hit a bug
>>> here under memory pressure and am wondering if this is related
>>> which might save me some time digging=E2=80=A6
>>>=20
>>> [ 4389.727184][ T6600] mem_cgroup_update_lru_size(00000000bb31aaed, =
0, -7): lru_size -1
>>=20
>> This bug seems failed due to a update_lru_size() missing or misplace, =
but
>> what's I changed on this patch seems unlike to cause this bug.
>>=20
>> Anyway, Qian, could you do me a favor to remove this patch and try =
again?
>=20
> Compare to this patch's change, the 'c8cba0cc2a80 mm/thp: narrow lru =
locking' is more
> likely bad. Maybe it's due to lru unlock was moved before =
ClearPageCompound() from
> before remap_page(head); guess this unlock should be move after =
ClearPageCompound or
> move back to origin place.

I can only confirmed that after reverted those 6 patches, I am no long =
be able to reproduce it.

>=20
> But I still can not reproduce this bug. Awkward!
>=20
> Alex
>=20
> ---
> line 2605 mm/huge_memory.c:
>        spin_unlock_irqrestore(&pgdat->lru_lock, flags);
>=20
>        ClearPageCompound(head);
>=20
>        split_page_owner(head, HPAGE_PMD_ORDER);
>=20
>        /* See comment in __split_huge_page_tail() */
>        if (PageAnon(head)) {
>                /* Additional pin to swap cache */
>                if (PageSwapCache(head)) {
>                        page_ref_add(head, 2);
>                        xa_unlock(&swap_cache->i_pages);
>                } else {
>                        page_ref_inc(head);
>                }
>        } else {
>                /* Additional pin to page cache */
>                page_ref_add(head, 2);
>                xa_unlock(&head->mapping->i_pages);
>        }
>=20
>        remap_page(head);


Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB6CC47258
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE0C2078D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 13:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ayAGzn9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgEENUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 09:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgEENUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 09:20:55 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49FFC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 06:20:53 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id k81so2180867qke.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 06:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=213HbyB0dXdOu9tOQL23m9CAXurK/4RRlK83qot5Fpg=;
        b=ayAGzn9JtIdchXWpNhGcaOr+WipHTnL7gaYtegPoAEXA6BmnLLpNRCbkv9bfl4Mbso
         FpkqEVCEjIpQnEGRY+ngyqB/cBTzRBPTzn8Y4bnOw4wUK87dwTwwCvCCFsL8mcbCbzSq
         GvDFBpBQv59w8EPz+1+ljsNJU6cQQtmwjD4eEjg42QenQUtva7Xj+QOJ3K9mT1cReMnz
         alRdg/xRFYGORmjo/btQ+680dLCr5zfv1deSC5d6Q9XHYDRQcbIIFcvJ2UDwNqqb3l2f
         yEqVA8ZacbdFgDtp/cQ1D3d78NECggz48xAxzDsyuBJvj/5ZOUM8rWbXdPOxSdPGZVsF
         oMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=213HbyB0dXdOu9tOQL23m9CAXurK/4RRlK83qot5Fpg=;
        b=KmvcLkVtsN7X6hq0rEy3vlhYSdfqCuKROPYKFqpoTDY0gyACNG+DDSfHqWb3sHt/HP
         LLF65z888Yw9n1Fg9NTt03dVlv4xceaZhOgjMamqjG6sr6DOjYBkb5KI4CQcDq+S50Ke
         p0VX4qA3koEsKcFriTshFVuyL/9YfvF6jnUNiitbIYoX7c81FbTGwNzpCelKTfP4WJGK
         LxSoN3twfcFhZgmtgBbrbwpDR7Z6h8GnZinFRy3x5wYVDBbAaMWWiGwzA6lbZmeNyUjX
         2V7Jzyuy/XvVeR1Fc3Om8sZ6wl3DZNPY8aDM2LX4EJiDHrIPCyRqwOvEbo4a2lgfNcbI
         QBhQ==
X-Gm-Message-State: AGi0PuZu9ir89tSOukpg3r0wrNsFlk7bbKhxWX7pCe4MjikK5GacO7ig
        wXvITGbJ49vZCuNlZVjxg+VfWA==
X-Google-Smtp-Source: APiQypJQlw5GSoqNb/uQjAIcHU4IZvQ/VjhuUPBnf6JURTKbD2+ahzYYUqfyhDSGqnlDhL62S7/i8A==
X-Received: by 2002:a37:2c45:: with SMTP id s66mr3559475qkh.305.1588684852904;
        Tue, 05 May 2020 06:20:52 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 74sm1752928qke.71.2020.05.05.06.20.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 06:20:52 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: compaction: VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn))
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200505124314.GA5029@MiWiFi-R3L-srv>
Date:   Tue, 5 May 2020 09:20:51 -0400
Cc:     Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <46D27820-4B67-45F0-898C-B0547D654626@lca.pw>
References: <8C537EB7-85EE-4DCF-943E-3CC0ED0DF56D@lca.pw>
 <20200424034353.GD4247@MiWiFi-R3L-srv>
 <A49F2991-4319-4207-9B6E-CC8563102C27@lca.pw>
 <20200505124314.GA5029@MiWiFi-R3L-srv>
To:     Baoquan He <bhe@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 5, 2020, at 8:43 AM, Baoquan He <bhe@redhat.com> wrote:
>=20
> Hi,
>=20
> On 04/24/20 at 09:45am, Qian Cai wrote:
>>=20
>>=20
>>> On Apr 23, 2020, at 11:43 PM, Baoquan He <bhe@redhat.com> wrote:
>>>=20
>>> On 04/23/20 at 05:25pm, Qian Cai wrote:
>>>> Compaction starts to crash below on linux-next today. The faulty =
page belongs to Node 0 DMA32 zone.
>>>> I=E2=80=99ll continue to narrow it down, but just want to give a =
headup in case someone could beat me to it.
>>>>=20
>>>> Debug output from free_area_init_core()
>>>> [    0.000000] KK start page =3D ffffea0000000040, end page =3D =
ffffea0000040000, nid =3D 0 DMA
>>>> [    0.000000] KK start page =3D ffffea0000040000, end page =3D =
ffffea0004000000, nid =3D 0 DMA32
>>>> [    0.000000] KK start page =3D ffffea0004000000, end page =3D =
ffffea0012000000, nid =3D 0 NORMAL
>>>> [    0.000000] KK start page =3D ffffea0012000000, end page =3D =
ffffea0021fc0000, nid =3D 4 NORMAL
>>>=20
>>> Where are these printed? They are the direct mapping address of =
page?
>>=20
>> =46rom this debug patch. Yes, direct mapping.
>=20
> Can you try below patch? I may get why this is caused, not sure if the
> place is right.=20
>=20
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 177c11a8f3b9..e26972f26414 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1409,7 +1409,9 @@ fast_isolate_freepages(struct compact_control =
*cc)
> 				cc->free_pfn =3D highest;
> 			} else {
> 				if (cc->direct_compaction && =
pfn_valid(min_pfn)) {
> -					page =3D pfn_to_page(min_pfn);
> +					page =3D =
pageblock_pfn_to_page(min_pfn,
> +						=
pageblock_end_pfn(min_pfn),
> +						cc->zone);
> 					cc->free_pfn =3D min_pfn;
> 				}
> 			}

I have not had luck to reproduce this again yet, but feel free to move =
forward with the patch anyway if you are comfortable to do so, so at =
least people could review it properly.

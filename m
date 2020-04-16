Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3464FC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DC3B20857
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 06:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="fnz5YT8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407484AbgDPGOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 02:14:34 -0400
Received: from mout.web.de ([212.227.17.11]:54495 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407264AbgDPGO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 02:14:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587017649;
        bh=yE3WRQFbzy9TZxF3eQPkIGcnX6B9c+jYyC2kI29aWMk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=fnz5YT8NWV94IsnzLzg8HgmsXko0cm3fapuGIKC2PC7NQZxkqk1P2/fvHpT93GUQu
         IA7VaM5mS1fau5ng+Lorwb4Z4ChVpsGpch4JyA99nCk+KataGoo/u+hiMl2Snu4NFv
         RvD3wp8K4pZ3kxL5vDhedDO+W0IH4Smds1MUpUGI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.109.113]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MVLak-1jlOTn0EYA-00YfQo; Thu, 16
 Apr 2020 08:14:09 +0200
Subject: Re: [PATCH v4] mm/ksm: Fix NULL pointer dereference when KSM zero
 page is enabled
To:     Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Xiongchun Duan <duanxiongchun@bytedance.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
References: <20200416025034.29780-1-songmuchun@bytedance.com>
 <20200415195841.da4361916f662a0136a271a5@linux-foundation.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <516df5d7-b514-11dc-130e-f1a2edce0108@web.de>
Date:   Thu, 16 Apr 2020 08:14:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200415195841.da4361916f662a0136a271a5@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hruyfe80HoKoDtVWzyXWpdMt82R75FeTYIsTEIQFpTkH1L8Nu+o
 lAwuc9XEJ2+0Dk5Fc0Q6CYathRlKeRsy/Kv6OeZGoGMC/QJU/6L+fMQbsw4t9PlqQVgK83p
 TrCyZGQmWFu/pyhIFFYVQDcA6rr15iaMC+oFAhwoJoMqE9F9+gPxf0ZQGK6OVvjtd4jg0qG
 dIZTN20xmgPlKlbwt22mA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QRbQ1/dJKzc=:1GZqrtpF/61F7ORjcJLWGY
 zeen+Xs8iyH9Cj/YMb0eFBL5VgfSLpqAPZdtHMNloybZ/g0RsT1FvA3JxaRl6Cn7H16bQwuen
 inUkmshyYK5dy79PXyUAlv6g0ApZBmNfx+Jan8Lkvp6UkmjWM7V1WOt5LH/AdJpgFt0Hs7G89
 UP9eYygtAJutKXpGQfWMMo/5Hr/h3khGpMXU9c2BaXNAqbeg970q791nO7iKfn0aVTe6l4lHk
 zR8Ups+G5ttVryZZ0txhVh272pbUACPPtxlgNFNintEI47qpZ2js5Dz8/88r8XsvBcEbSSBWi
 SAjqGKOqFJtYCiXy7J20jyhy4EDS8iZlOH7IRze1bOYLsh3HJ3/nhb/6zWuoi7mUaLsUhp63b
 HsboVUc5djT4TBCWXFSSpSXIZHg7X7VLl7XOiXQLOvj2QPREZmK9oiNwAOmJzjlmUMNH0HUok
 qvM1VHNuNPsTZAb4k/oi1K5U3CHTpfu+w03ePHOwVwkFsUIhQPqeNS1f1vizjCwZFd1YPdgqm
 xCeTqAs5NNpkQDN/0swjjePXAPW0XcWZNnJX5RIO+6wSEKOfNpGlC8/4ubMZFw9Bn6qPsG/0P
 YbRdfhlCwUGBEgXowJlG2h1oifU53ldQRONuKBJ2tn2V+wwxVoV33yjkVL52MewxJexok4QKz
 Dcvm1Dt9bIDGh1FhXDTIGff5Q189t5rsJpeMMf3gPWk6eAlwiAZrWwELqzqBTQcuhk0H5Y5QU
 8qYk16r3JuoJOwiEZULjMmhYkW6xVbR2l7GPuZqzNA8auEFuw0AFp5yQ+5aj0d9rb7PyroaWP
 20SnDDlSmGaSLNsCUV+iD1YYq9zmOYI2JpOZeI66QnejfanC7VBCmcZa63SeX0u9h+3um8PMT
 Fo5m7poJsWYctm16DA1XpTNPmxjQpejlyYwIhQ1Z9O1vbFQiGL55xXz5746M3HwI6Q3u+VFBD
 Il77XE6d44Y2x5Ko3OJAR0578tsCSxvEbJiomr4rjsG0Z8S/ipDbvliRCQIr47JhySIqVCXZ5
 7EyjBIS6e3WgcUFXblUHtVfxhcu9UbMSej8LhoiTUgmlI5IW6u00j12JzaZwJgOJ57V+nSXRu
 rLQVV2T1sQuq86e7xDw61STR6HprDd93e/nTKoeSND/Md8NduKcLNaZ3updBV5UEI7R2zSsj7
 SRuJ3Y3iwFrjC1CcI9sVRtjcGmRfPt4wcnRds1g9lCis2llWlNel+zf9G235vCaMbfTPfZPgf
 KnjiESZZ5QhNV7L7Q
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
>> +++ b/mm/ksm.c
>> @@ -2112,8 +2112,15 @@ static void cmp_and_merge_page(struct page *page=
, struct rmap_item *rmap_item)
=E2=80=A6
>> +		if (vma)
>> +			err =3D try_to_merge_one_page(vma, page,
>> +					ZERO_PAGE(rmap_item->address));
>> +		else
>> +			/**
>> +			 * If the vma is out of date, we do not need to
>> +			 * continue.
>> +			 */
>> +			err =3D 0;
>>  		up_read(&mm->mmap_sem);
=E2=80=A6
> It's conventional to put braces around multi-line blocks such as this.

Are there different views to consider around the usage of single statement=
s
together with curly brackets in if branches?

Regards,
Markus

Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EF5C2D0EB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F397020748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONAk249V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbgC2Ul0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:41:26 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:46777 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727370AbgC2Ul0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:41:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585514485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SCa1U8meEBdpyum9BPOZFAw/fPYtJnIhokr9ugURbvc=;
        b=ONAk249VBf+aaurFR7QXDl+K//c6eEsbr5syiESpF4CtIRBrXqTHduriZ/SkTU/XTJ4pT8
        8/xu+NIdHzAWJsgvaCm0CiFMr5NVNHLHH1wdtBuLYWfQat3s0IctgKanE1CP5pDk6uW9uQ
        z0g3PVzUNgFkFi6X6T3pCA1tUMLY4XE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-TVJurLO3N-iShh9gomF7gw-1; Sun, 29 Mar 2020 16:41:21 -0400
X-MC-Unique: TVJurLO3N-iShh9gomF7gw-1
Received: by mail-wr1-f72.google.com with SMTP id d1so9214446wru.15
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 13:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=SCa1U8meEBdpyum9BPOZFAw/fPYtJnIhokr9ugURbvc=;
        b=Nfo2K/JJtciE0XbiAOMzFfQYUHTDxSb8/9141pioGgn1cSWTT16OSeXgweMJrECeyK
         JP9wuayLUW7VXmxGLfRQbKzIChROMq+wZDabwKMSftblmbqPyJe656lRw7ePVU6J86+h
         Uzlg1x5JkOMHGnhD8n+LzuCLIMbvAnhQlz1znL5Ft54gp7bbocfAFtcA3EbzSs7u/a7H
         hhedS/Ke62/eaM21QDUcX4voaPzx4vuqhCG6+v7StAF+Yl1LUdsj2/MaoZkWtJm1OrSz
         sbonM1wSXMh/n/zAB2dTp6cy4cncquNaM9K4ayfEtZjoFFA5+jZFg285uS1JDBG8goQ+
         iEXQ==
X-Gm-Message-State: ANhLgQ118HdrFgJJUvD8MHdxGlVVgGITLs3gfQ4kZB/d95mLRNNzE1SS
        iFnqyGa5xeq+MUlCi9oAmknaGhwMS+ZELKcULFbNdebUPP5dGh7lSo/Yi6UrjkXjWPuUIgNYG8L
        q7P2VPLbzC+1Y1vd5GQ0l6d0m
X-Received: by 2002:a1c:1d8e:: with SMTP id d136mr10158755wmd.26.1585514479938;
        Sun, 29 Mar 2020 13:41:19 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs5E25g6VQ2DopxFsoqjsYSxsbVkfQl1ndZYa22/E6gYoauP3Ds/PIRW+TFftqeWsvRoBQsLA==
X-Received: by 2002:a1c:1d8e:: with SMTP id d136mr10158738wmd.26.1585514479670;
        Sun, 29 Mar 2020 13:41:19 -0700 (PDT)
Received: from [192.168.3.122] (p4FF23127.dip0.t-ipconnect.de. [79.242.49.39])
        by smtp.gmail.com with ESMTPSA id a10sm10645137wrm.87.2020.03.29.13.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 13:41:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/2] mm/memory_hotplug: simplify calculation of number of pages in __remove_pages()
Date:   Sun, 29 Mar 2020 22:41:18 +0200
Message-Id: <F45052AF-D619-4993-AFF4-1E417C3BF424@redhat.com>
References: <CAHk-=wj1K5rsyoPps3H5QW_KOxtDQ8zPJ-bc-BmYjT4jXU_7Og@mail.gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>, Baoquan He <bhe@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>
In-Reply-To: <CAHk-=wj1K5rsyoPps3H5QW_KOxtDQ8zPJ-bc-BmYjT4jXU_7Og@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 29.03.2020 um 22:19 schrieb Linus Torvalds <torvalds@linux-foundation.o=
rg>:
>=20
> =EF=BB=BFOn Sun, Mar 29, 2020 at 1:09 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>=20
>> In contrast, look at the email that Andrew sent me and that I complained a=
bout:
>>=20
>>   https://lore.kernel.org/linux-mm/20200329021719.MBKzW0xSl%25akpm@linux-=
foundation.org/
>=20
> Hmm. I'm trying to figure out how and where Andrew got the original from y=
ou.
>=20
> There's
>=20
>  https://lore.kernel.org/linux-mm/20200124155336.17126-1-david@redhat.com/=
raw
>=20
> but again, that one actually looks fine. It has that
>=20
>   Content-Transfer-Encoding: quoted-printable
>=20
> header line, but it doesn't even have the "=3D\n" pattern in the text at
> all. It does have MIME encoding in the patch, but that's all fine.
>=20
> Then there's a new version:
>=20
>   https://lore.kernel.org/linux-mm/20200128093542.6908-1-david@redhat.com/=
raw
>=20
> and that one *does* have the "Withou=3D\nt" pattern in it. But it still
> has the proper
>=20
>   Content-Transfer-Encoding: quoted-printable
>=20
> in it, so the recipient should decode it just fine (and again, you can
> see that in the non-raw email - it looks just fine).
>=20
> So your emails on lore look fine. I'm not seeing how that got corrupted.

*maybe* Andrew updated only the patch description, copying the raw content. E=
ventually he converts MIME only when importing, so the description got corru=
pted.

... or the mail he received via cc got messed up by my mailing infrastructur=
e.

Cheers=


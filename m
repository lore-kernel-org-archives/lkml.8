Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D2CC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0626720748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JX5yxLW3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728637AbgC2UR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:17:56 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:22353 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728481AbgC2URz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585513074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5YQVKx16TS+5clxSLtkXpe8YoP0huXDFkfGYX4zkxME=;
        b=JX5yxLW3vmMR/kxT8cEtrTDSmVqwfhy781f2LVtzKtwSM8p21+vnvXpg5NUCJDSi+4h0B+
        HG9D/bomo91Gp5iYW6W6aS5asyb6wjSCJV3qXYzSFGwiq+aD5WCrJ7G6ARog2Uzv0bvcMf
        Xdls9p1rRJ5C+1kfw8rlbU+5HzIn3+s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-PcG6bRu1NJORZ_S4r-Yp5w-1; Sun, 29 Mar 2020 16:17:50 -0400
X-MC-Unique: PcG6bRu1NJORZ_S4r-Yp5w-1
Received: by mail-wm1-f70.google.com with SMTP id u6so931072wmm.6
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 13:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=5YQVKx16TS+5clxSLtkXpe8YoP0huXDFkfGYX4zkxME=;
        b=ESXaDetHv6zDPT7AnGnTRl14LuO2uVDwfIEBtOD+Xo5CcK4ZRkukx5repM/WxBYnvQ
         ygBoFEmZ4L8Rs7tkzOZhiUPuyxf4ceH6lewvH4eVacuChJcYIen6LpT8TO0QdwgrfARU
         OztGKy90FjWGmMyLqYo9/2S3oJkkjNwlA/t6sdSNwAA7ls0IHqq9rEfdW/DohXf6etQb
         Yiqx0xqnP1Im4dX3WD41iMX4fvMZ+TF4JI+IV4APjvCKzW/B+F2+9zbdqfXj7VpaW71l
         Ho6JIUA4XDu4W2plPh02s2xyMT/epuKR/53DDUiMccneGvYwgYUC5IAdEfEsRjRifAJH
         twXw==
X-Gm-Message-State: ANhLgQ2PevOfRcUAAZEg/l37ARGRA65AG75l1bPLCbsd990hSBuLcCOM
        uwC/frw7Zu/WrPz0sDRr41DeUciZBSrwuLIHD/QvM3SSKDT1bdls5Vy3KS+PwRxvh0Qhc713I+R
        s335kOACG3SCrLAkzvvEoXKlJ
X-Received: by 2002:a5d:4cc4:: with SMTP id c4mr11020549wrt.346.1585513068823;
        Sun, 29 Mar 2020 13:17:48 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvGOR9hvsxil64/+f2JpUGFAdf8Qlt+ucWEguEIT6KS905fdsOrxkr5UEtxCIOY0arEv/XlQQ==
X-Received: by 2002:a5d:4cc4:: with SMTP id c4mr11020522wrt.346.1585513068448;
        Sun, 29 Mar 2020 13:17:48 -0700 (PDT)
Received: from [192.168.3.122] (p4FF23127.dip0.t-ipconnect.de. [79.242.49.39])
        by smtp.gmail.com with ESMTPSA id j11sm18440236wrt.14.2020.03.29.13.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 13:17:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 1/2] mm/memory_hotplug: simplify calculation of number of pages in __remove_pages()
Date:   Sun, 29 Mar 2020 22:17:46 +0200
Message-Id: <DFA2A279-A6B4-4F0C-A8B9-38E1A7A6B400@redhat.com>
References: <CAHk-=wjEk_smqiRh4-JosHsRxzhedJddGf5EQV0JxqZtHYMdkA@mail.gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>, Baoquan He <bhe@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>
In-Reply-To: <CAHk-=wjEk_smqiRh4-JosHsRxzhedJddGf5EQV0JxqZtHYMdkA@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 29.03.2020 um 22:10 schrieb Linus Torvalds <torvalds@linux-foundation.o=
rg>:
>=20
> =EF=BB=BFOn Sun, Mar 29, 2020 at 12:19 PM David Hildenbrand <david@redhat.=
com> wrote:
>>=20
>> This patch seems to have another of these weird MIME crap in it. (my
>> other patches in -next seem to be fine)
>>=20
>> See
>>=20
>> https://lore.kernel.org/linux-mm/20200228095819.10750-2-david@redhat.com/=
raw
>=20
> That email actually looks fine.
>=20
> Yes, it has that
>=20
>   fro=3D
>   m
>=20
> pattern, but it also has
>=20
>   Content-Transfer-Encoding: quoted-printable
>=20
> so the recipient should be doing the right thing with that pattern.
>=20
> The patch itself also has MIME encoding in it:
>=20
>   - cur_nr_pages =3D3D min(end_pfn - pfn, -(pfn | PAGE_SECTION_MASK));
>   + cur_nr_pages =3D3D min(end_pfn - pfn,
>=20
> so the patch wouldn't even apply unless the recipient did the proper
> MIME decode of the message.
>=20
> That's also why the non-raw message looks fine:
>=20
>  https://lore.kernel.org/linux-mm/20200228095819.10750-2-david@redhat.com/=

>=20
> because the raw message data has the proper encoding information.
>=20
> In contrast, look at the email that Andrew sent me and that I complained a=
bout:
>=20
>   https://lore.kernel.org/linux-mm/20200329021719.MBKzW0xSl%25akpm@linux-f=
oundation.org/
>=20
> and notice how that *non-raw* email has that
>=20
>   Withou=3D
>   t
>=20
> pattern in it. And when you look at the raw one:
>=20
>  https://lore.kernel.org/linux-mm/20200329021719.MBKzW0xSl%25akpm@linux-fo=
undation.org/raw
>=20
> it has no content transfer encoding line in the headers.

Interesting, at least the patch in -next is messed up. I remember Andrew ada=
pted some scripts, maybe this is a leftover.

Cheers!

>=20
>                 Linus
>=20


Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7856BC2D0EB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D40420732
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585512598;
	bh=FZZv1ZxKeKzm1JJCjT97edQrCDpaSL32wX+1mzYa4AY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Cm1biDD3imWNkSslXsOjvXgy6v//5da5zn6u7DL3xCweFJg8gcaBos52ZpFlXvBij
	 OT+DbiVrPQS6q10FYTJR4qW2ZsRJNk5IfAKpXIldHC9zgfz1dym/8X/uT9crU4EFV/
	 Loeu7s19UVs6Ac4tKy0zXp21HNTVu6ptteUhkUA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgC2UJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:09:57 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36042 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727606AbgC2UJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:09:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id g12so15837383ljj.3
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 13:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CDzpIw5Dwqx87pXbxst3BXzLJY05rEwRTdeUPJLp2p8=;
        b=bUHjhkA1Af+QiPaVmhyq86BzGJeSR2DakZAUmFAPw9Xt+RlcyzMxIIRxmot0HmwELi
         ADDlZPZ6dsx90Zz77SzT7Uxh7WfgSkq4bSapA/RwDPg0DHyDpgO62IH/keqF9PXXyowL
         bUibJtuc65zjqn/WGlrSempOI99VirDosSizc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CDzpIw5Dwqx87pXbxst3BXzLJY05rEwRTdeUPJLp2p8=;
        b=A2qkq92wnttqsd5O66G/RjDxXk7UHp813xZ9inaJK89P3G6WufWweWOKb3PkU859QR
         bPi8BIWDccGIcn9ixI5yVoOWkoTfsj4ijmrxP2A8fiG6KRIOB/kB3KRixtSe0i6RlYGn
         Ayc6v/c1nLt4A23I1OQL+onX4J3SSslgwxidwFOvSsiGxTe9BVLUz5msP/opfj92ZCWv
         epQWCiYdxhZhJztQB95Ka8gC1kzl+e1KJjllMPRV68DLTusXqDo8XKhnC8VLYq8YQ2xl
         4Wb53HjTIdShRQnwFJrBgsRTG+OaRO0Q7xSs3ouRG9T2lC7Vz5lSWsnDDJfiNEiylqtA
         4B1g==
X-Gm-Message-State: AGi0PubAbyokRFXH1K3KAFYL8JTlR4JcGoxX1rdjohyrBvKjH81NTd6I
        3FYjkviGH7EyBlqhUFGxfxpX62I0K1w=
X-Google-Smtp-Source: APiQypIBkdgOr1EJoYE6FlLa6DC6GnMv3f9WCbNUT66d+ASan/kkLAm3PBoZQDmSddggPxQqcg3J2A==
X-Received: by 2002:a2e:83cf:: with SMTP id s15mr5019700ljh.36.1585512594086;
        Sun, 29 Mar 2020 13:09:54 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id y64sm6707690lfa.88.2020.03.29.13.09.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 13:09:53 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id j11so12312547lfg.4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 13:09:52 -0700 (PDT)
X-Received: by 2002:a19:7f96:: with SMTP id a144mr6062690lfd.31.1585512592314;
 Sun, 29 Mar 2020 13:09:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200228095819.10750-1-david@redhat.com> <20200228095819.10750-2-david@redhat.com>
 <dca485fe-7024-392b-f51c-cd54550317ff@redhat.com>
In-Reply-To: <dca485fe-7024-392b-f51c-cd54550317ff@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Mar 2020 13:09:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjEk_smqiRh4-JosHsRxzhedJddGf5EQV0JxqZtHYMdkA@mail.gmail.com>
Message-ID: <CAHk-=wjEk_smqiRh4-JosHsRxzhedJddGf5EQV0JxqZtHYMdkA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mm/memory_hotplug: simplify calculation of number
 of pages in __remove_pages()
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>, Baoquan He <bhe@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Wei Yang <richardw.yang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 12:19 PM David Hildenbrand <david@redhat.com> wrote:
>
> This patch seems to have another of these weird MIME crap in it. (my
> other patches in -next seem to be fine)
>
> See
>
> https://lore.kernel.org/linux-mm/20200228095819.10750-2-david@redhat.com/raw

That email actually looks fine.

Yes, it has that

   fro=
   m

pattern, but it also has

   Content-Transfer-Encoding: quoted-printable

so the recipient should be doing the right thing with that pattern.

The patch itself also has MIME encoding in it:

   - cur_nr_pages =3D min(end_pfn - pfn, -(pfn | PAGE_SECTION_MASK));
   + cur_nr_pages =3D min(end_pfn - pfn,

so the patch wouldn't even apply unless the recipient did the proper
MIME decode of the message.

That's also why the non-raw message looks fine:

  https://lore.kernel.org/linux-mm/20200228095819.10750-2-david@redhat.com/

because the raw message data has the proper encoding information.

In contrast, look at the email that Andrew sent me and that I complained about:

   https://lore.kernel.org/linux-mm/20200329021719.MBKzW0xSl%25akpm@linux-foundation.org/

and notice how that *non-raw* email has that

   Withou=
   t

pattern in it. And when you look at the raw one:

  https://lore.kernel.org/linux-mm/20200329021719.MBKzW0xSl%25akpm@linux-foundation.org/raw

it has no content transfer encoding line in the headers.

                 Linus

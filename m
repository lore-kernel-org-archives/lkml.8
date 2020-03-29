Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FE2C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C0A920748
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585513149;
	bh=gzFxmXM9Xs5fdU1VQ7CsU1YQH05YqOZmBU9LVgUyiRY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GOmckbaCMKXhSPdA0LFZHzTyhOwTUomOmEScqF9X1/SkRVQgCDpta2iw9L3r8Y4g4
	 ct6xGacu1VIiFQS0tqUnrUChBdqaucMceitCOMqRL3oVr8m3eJhGPuMahAk6NwBIW5
	 ZNksZDG2eLSnVQDRoBepWpdtg2Mc6Oyy0Y7FpDIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgC2UTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:19:07 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46632 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbgC2UTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:19:07 -0400
Received: by mail-lf1-f66.google.com with SMTP id q5so12301320lfb.13
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 13:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w8lE84NI1cL59u/KthhlQ8Af9PEIK30oQOH90kdvtn8=;
        b=cpg506iB8SOhnj7ZbK4G34NSdESJO+2VG90dBY6R8angEfpZUFvoW/zG4GYaa6Kmnt
         ZPRV8WatmmcRF4nlIlxorVllw6HV5fcFCULUzWwfI1QO3Q84zdWBXrCL2dc7+g662iLu
         IRELBwyagYyzGFysU2njrUepcsCW1xuVrYmg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w8lE84NI1cL59u/KthhlQ8Af9PEIK30oQOH90kdvtn8=;
        b=pr6ZyprP0pqT4gb64V0XoEHhsplN8t2w/5hZ9hHjziBjpAjmrLs/WcrlTopu1rLmzq
         q5RJZAmsvaPmzrHWvZw/7nyp90rfpIjoHMxH9vDJpfB1aRtIAW1XUCfRKRgGQl8AN8Q8
         U4Xh8PVxvCUVbiAWdUHTEmgHVGp0sAKiTbv5XKApr9L9TMKS4FqfI6V/+Wb7zDurssg6
         YQTR6HJ8Oe/XY+H4jLo9Bqklbr1KHHFlP6Go0V/82Wr3xALDo6zjfbuB2xH7W+4UdWV6
         HrAWT/kC13rUNT+o+UWg6wPEA565zokbKCyh32v4NXzJ53Eoe5/sm/quphzBMhnx50nm
         RQZQ==
X-Gm-Message-State: AGi0Pubx4BO5Z6h7/pj+cUzmX4gBoAjhqMsBZypWxSNXVM00yEvRfMOw
        Fui1cwXPpI8dsEx1RmPEznYnFizoWNI=
X-Google-Smtp-Source: APiQypKa1acATMeDTUlhMTIqqJEGnKXNaxUo9+2UltqWgmwnTbNm/JIXGulWvb+HfRZ/Bce7UEcvKQ==
X-Received: by 2002:a19:4c44:: with SMTP id z65mr6163699lfa.203.1585513142779;
        Sun, 29 Mar 2020 13:19:02 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id v22sm5962145ljj.67.2020.03.29.13.19.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 13:19:02 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id s13so1174901lfb.9
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 13:19:01 -0700 (PDT)
X-Received: by 2002:a19:7f96:: with SMTP id a144mr6077406lfd.31.1585513141215;
 Sun, 29 Mar 2020 13:19:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200228095819.10750-1-david@redhat.com> <20200228095819.10750-2-david@redhat.com>
 <dca485fe-7024-392b-f51c-cd54550317ff@redhat.com> <CAHk-=wjEk_smqiRh4-JosHsRxzhedJddGf5EQV0JxqZtHYMdkA@mail.gmail.com>
In-Reply-To: <CAHk-=wjEk_smqiRh4-JosHsRxzhedJddGf5EQV0JxqZtHYMdkA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 29 Mar 2020 13:18:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1K5rsyoPps3H5QW_KOxtDQ8zPJ-bc-BmYjT4jXU_7Og@mail.gmail.com>
Message-ID: <CAHk-=wj1K5rsyoPps3H5QW_KOxtDQ8zPJ-bc-BmYjT4jXU_7Og@mail.gmail.com>
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

On Sun, Mar 29, 2020 at 1:09 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> In contrast, look at the email that Andrew sent me and that I complained about:
>
>    https://lore.kernel.org/linux-mm/20200329021719.MBKzW0xSl%25akpm@linux-foundation.org/

Hmm. I'm trying to figure out how and where Andrew got the original from you.

There's

  https://lore.kernel.org/linux-mm/20200124155336.17126-1-david@redhat.com/raw

but again, that one actually looks fine. It has that

   Content-Transfer-Encoding: quoted-printable

header line, but it doesn't even have the "=\n" pattern in the text at
all. It does have MIME encoding in the patch, but that's all fine.

Then there's a new version:

   https://lore.kernel.org/linux-mm/20200128093542.6908-1-david@redhat.com/raw

and that one *does* have the "Withou=\nt" pattern in it. But it still
has the proper

   Content-Transfer-Encoding: quoted-printable

in it, so the recipient should decode it just fine (and again, you can
see that in the non-raw email - it looks just fine).

So your emails on lore look fine. I'm not seeing how that got corrupted.

               Linus

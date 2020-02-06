Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE567C352A3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E11021D7D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="nf8aNdh3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgBFUb4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:31:56 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36769 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgBFUb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:31:56 -0500
Received: by mail-qt1-f193.google.com with SMTP id t13so152267qto.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 12:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gJbewMsHDVUVh+mQTq3o5gvQ9Bp13UC+F2iCFMLgKQo=;
        b=nf8aNdh3/8vP+W6SEn5KZenp8fTVGziOmZartWyRum8Wqy1f9ey00xYjpPQClOVE3D
         68kcBncv4V9Q7NCw3t96JYeVPzbunNmBb/9HKY9p615QIe/64MnR9PZGyr1JN3I0u4pK
         ed6yePVHQtBooopmWBhtYlKj6PJZQY1poubQ1HciuI1R57AxRi32xTAeTm73WktqQxHA
         9d+0w6w8jDBrCCzbiCi8prOR8l1oZgJqHz0w4KIClxWaLQqa1rEO4MbOjcKhbZf3QbLc
         RMR7jzSbb/TF9cA3UFIDTW0cea5UWVT6Hl9M61KcNe8gut9qC8t7GJnmFVqAfdm1pbFb
         7UGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=gJbewMsHDVUVh+mQTq3o5gvQ9Bp13UC+F2iCFMLgKQo=;
        b=DO5IztjVQG3Kajvf3P9VbY1XS1pbJNDbBxuZS8V0wjsKTIDfkXZEIWsJcElCZmo+xF
         rfCYokpxzt95U3GtSgKX/OMXHkji3B+hJHFJTifPxvK5IfOmihFmeogTLm0MaW5g7+N6
         hWb2Amo0+z+2PiQy33aRelZwXdVNlvk5BXMVEpM3Dd1nMeCsQoS/3n44Boa+Zllry5VX
         6EMFOlgfw47SkCJySnEO8dluyBz+UC/qllLUUT3cnwBOo78eXjX1weVnXjd4NTingE7R
         g1ajGFbye0ZkHTbOOWUjFLtO0jfxzF8UcTy+7QN8IJPP8bAhKkWT1mrRQNYrQ09T59Bz
         gJDg==
X-Gm-Message-State: APjAAAVifOGqGxSqFPFb4FGKpeJqCqOBEcoE4FOGG6UX+bJpGVj23B71
        YKO1N67+P1ljPQru0VbQChgqZ489rphSgw==
X-Google-Smtp-Source: APXvYqyccwwtBVliPd+rxU1o4Pu5PuwWdPD2lPNRCAf1/BcKZbWbmaymmFFGO6MORI/PRZKNMQEqEw==
X-Received: by 2002:ac8:3a02:: with SMTP id w2mr4186584qte.351.1581021115295;
        Thu, 06 Feb 2020 12:31:55 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id b17sm212383qtr.36.2020.02.06.12.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Feb 2020 12:31:54 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH -next] mm/page_io: mark an intentional data race
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200206035654.2647-1-cai@lca.pw>
Date:   Thu, 6 Feb 2020 15:31:54 -0500
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5B9299F8-C495-4675-B8F5-BAEA28D45586@lca.pw>
References: <20200206035654.2647-1-cai@lca.pw>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please disregard this patch. I found more data races in this file, so =
will send a new
patch to have them at once.

> On Feb 5, 2020, at 10:56 PM, Qian Cai <cai@lca.pw> wrote:
>=20
> struct swap_info_struct si.flags could be accessed concurrently as
> noticed by KCSAN,
>=20
> BUG: KCSAN: data-race in scan_swap_map_slots / swap_readpage
>=20
> write to 0xffff9c77b80ac400 of 8 bytes by task 91325 on cpu 16:
>  scan_swap_map_slots+0x6fe/0xb50
>  scan_swap_map_slots at mm/swapfile.c:887
>  get_swap_pages+0x39d/0x5c0
>  get_swap_page+0x377/0x524
>  add_to_swap+0xe4/0x1c0
>  shrink_page_list+0x1740/0x2820
>  shrink_inactive_list+0x316/0x8b0
>  shrink_lruvec+0x8dc/0x1380
>  shrink_node+0x317/0xd80
>  do_try_to_free_pages+0x1f7/0xa10
>  try_to_free_pages+0x26c/0x5e0
>  __alloc_pages_slowpath+0x458/0x1290
>  __alloc_pages_nodemask+0x3bb/0x450
>  alloc_pages_vma+0x8a/0x2c0
>  do_anonymous_page+0x170/0x700
>  __handle_mm_fault+0xc9f/0xd00
>  handle_mm_fault+0xfc/0x2f0
>  do_page_fault+0x263/0x6f9
>  page_fault+0x34/0x40
>=20
> read to 0xffff9c77b80ac400 of 8 bytes by task 5422 on cpu 7:
>  swap_readpage+0x204/0x6a0
>  swap_readpage at mm/page_io.c:380
>  read_swap_cache_async+0xa2/0xb0
>  swapin_readahead+0x6a0/0x890
>  do_swap_page+0x465/0xeb0
>  __handle_mm_fault+0xc7a/0xd00
>  handle_mm_fault+0xfc/0x2f0
>  do_page_fault+0x263/0x6f9
>  page_fault+0x34/0x40
>=20
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 7 PID: 5422 Comm: gmain Tainted: G        W  O L =
5.5.0-next-20200204+ #6
> Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 =
07/10/2019
>=20
> The write is under &si->lock, but the read is done as lockless. Since
> the read only check for a specific bit in the flag, it is harmless =
even
> if load tearing happens. Thus, just mark it as an intentional data =
race
> using the data_race() macro.
>=20
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> mm/page_io.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/mm/page_io.c b/mm/page_io.c
> index 76965be1d40e..e33925b9178c 100644
> --- a/mm/page_io.c
> +++ b/mm/page_io.c
> @@ -377,7 +377,7 @@ int swap_readpage(struct page *page, bool =
synchronous)
> 		goto out;
> 	}
>=20
> -	if (sis->flags & SWP_FS) {
> +	if (data_race(sis->flags & SWP_FS)) {
> 		struct file *swap_file =3D sis->swap_file;
> 		struct address_space *mapping =3D swap_file->f_mapping;
>=20
> --=20
> 2.21.0 (Apple Git-122.2)
>=20


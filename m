Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F260C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E112214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 20:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="mCUQ5rJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgBFUbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:31:41 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46793 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgBFUbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 15:31:40 -0500
Received: by mail-qv1-f67.google.com with SMTP id y2so3481999qvu.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 12:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3hepVKSvwAH2BCEpeqSROxuiNRdF8yu9qLYhzLxF5X0=;
        b=mCUQ5rJxLZCg5QMWr6ZxXRplaT+23zazAIVOwZhHUYjIEMMmMhpgHApJx6nsUwaKFa
         dRf8/7xUI59q+iT3yH+SdQU/MWDG0Lb9rOU2AFhfukiIZ/WEsh4492SxbCZyY7ZGvbRI
         3liEvywzAFrzOnjycn4el3PKJB4EVkdrXuz44gBulPJDiP+9LjZipnuf4J6MxU/QKk+E
         WyBWyf9Kc7n/t5O8D0tLyqfhZn69lVSjnUJtnKBemAMnwmj4WW8pakwC8L58pt/JbxQG
         n0Dl3m7eLoEc4yFrLfOrIj2uRwgtLc68YNoZjWhR/ctviVeRU+dPdM6FI4XMTnX+XGEp
         mJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3hepVKSvwAH2BCEpeqSROxuiNRdF8yu9qLYhzLxF5X0=;
        b=Sfa8rjvU9mii6QkUJYULQGwMBKpK7/DQZTF8UNAtGt6/Mlv8wz4clCTS2PU5wlwZ96
         aB9l1nAsHKk7pnb9mQfwispEIH1R990GoBiSkoqUALVnYHUgpDrcGkshS1xoLEY23kVK
         lWJfBgUDzRN6FrSUBwt9eiZq6ETCJkbu1u2f6Ypma81j+Fpsp2KYF3/OjPAYr4gpQAyk
         BKiLdDWBTcfHk1hK1JHhBIWng49Ln+EAp++vjEAV/vtissfZio4Akipxj9asIpSgAauW
         XDAi7/e/ueJFw/hUT5XRXGi1DMEjy7D7r6QpJcpREo8dfcDhmS9pki3UoC1bJNn93Lmt
         5CPQ==
X-Gm-Message-State: APjAAAWskJ8v/bIYkCTylVViIoNJx6MoR1Y735HMSMuSYgPvSPKbjjDh
        NensWZ+sTmjguII6Y7pTsIyyjg==
X-Google-Smtp-Source: APXvYqyulUGMXFzGjbdwIurFH8T4hxHWqdTO227D2jcvE3rhlfndJ0+4/nnBte/B0kWEXIapt3ccOQ==
X-Received: by 2002:ad4:5349:: with SMTP id v9mr4060471qvs.177.1581021099930;
        Thu, 06 Feb 2020 12:31:39 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id b17sm212383qtr.36.2020.02.06.12.31.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Feb 2020 12:31:39 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [PATCH -next] mm/swap_state: mark an intentional data race
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200206035516.2593-1-cai@lca.pw>
Date:   Thu, 6 Feb 2020 15:31:38 -0500
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1BD7EB07-8E26-4AE4-8FEF-A05154D3F674@lca.pw>
References: <20200206035516.2593-1-cai@lca.pw>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please disregard this patch. I found more data races in this file, so =
will send a new
patch to have them at once.

> On Feb 5, 2020, at 10:55 PM, Qian Cai <cai@lca.pw> wrote:
>=20
> swap_cache_info.find_total could be accessed concurrently as noticed =
by
> KCSAN,
>=20
> BUG: KCSAN: data-race in lookup_swap_cache / lookup_swap_cache
>=20
> write to 0xffffffff85517318 of 8 bytes by task 94138 on cpu 101:
>  lookup_swap_cache+0x12e/0x460
>  lookup_swap_cache at mm/swap_state.c:322
>  do_swap_page+0x112/0xeb0
>  __handle_mm_fault+0xc7a/0xd00
>  handle_mm_fault+0xfc/0x2f0
>  do_page_fault+0x263/0x6f9
>  page_fault+0x34/0x40
>=20
> read to 0xffffffff85517318 of 8 bytes by task 91655 on cpu 100:
>  lookup_swap_cache+0x117/0x460
>  lookup_swap_cache at mm/swap_state.c:322
>  shmem_swapin_page+0xc7/0x9e0
>  shmem_getpage_gfp+0x2ca/0x16c0
>  shmem_fault+0xef/0x3c0
>  __do_fault+0x9e/0x220
>  do_fault+0x4a0/0x920
>  __handle_mm_fault+0xc69/0xd00
>  handle_mm_fault+0xfc/0x2f0
>  do_page_fault+0x263/0x6f9
>  page_fault+0x34/0x40
>=20
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 100 PID: 91655 Comm: systemd-journal Tainted: G        W  O L =
5.5.0-next-20200204+ #6
> Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 =
07/10/2019
>=20
> Both the read and write are done as lockless. Since INC_CACHE_INFO() =
is
> only used for swap_cache_info.find_total and
> swap_cache_info.find_success which both are information counters, even
> if any of them missed a few incremental due to data races, it will be
> harmless, so just mark it as an intentional data race using the
> data_race() macro.
>=20
> While at it, fix a checkpatch.pl warning,
>=20
> WARNING: Single statement macros should not use a do {} while (0) loop
>=20
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
> mm/swap_state.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 8e7ce9a9bc5e..b964c1391362 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -58,8 +58,8 @@ static bool enable_vma_readahead __read_mostly =3D =
true;
> #define GET_SWAP_RA_VAL(vma)					\
> 	(atomic_long_read(&(vma)->swap_readahead_info) ? : 4)
>=20
> -#define INC_CACHE_INFO(x)	do { swap_cache_info.x++; } while (0)
> -#define ADD_CACHE_INFO(x, nr)	do { swap_cache_info.x +=3D =
(nr); } while (0)
> +#define INC_CACHE_INFO(x)	data_race(swap_cache_info.x++)
> +#define ADD_CACHE_INFO(x, nr)	(swap_cache_info.x +=3D (nr))
>=20
> static struct {
> 	unsigned long add_total;
> --=20
> 2.21.0 (Apple Git-122.2)
>=20


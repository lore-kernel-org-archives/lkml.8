Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465F2C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23BDD20735
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s8za3E5G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgCQSl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 14:41:28 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45675 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgCQSl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 14:41:28 -0400
Received: by mail-ot1-f66.google.com with SMTP id e9so15570659otr.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 11:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zqeTFrmm9hzoE8Ei7WXbY06jiJr+QU1mv/oiGm2r+iM=;
        b=s8za3E5GTL9xqEXCX6qpYZH20rsTRqMRJMoDP57Np3i5aoMg7NmPNGi9OQJ31a+O1e
         ziJ0svX/fqjjMPO8l8ofDVWDIYWOcNjCgucPRt53rsPsckFoQTGGnCLVw9jbj5KLoEs1
         cQ35HZ3FpGvao4ZPHHf1vAyc/ZMifpSBYFYsdMQO7yCRtI2aP2Ix7yiQbfap8Vy7jccT
         /bkNk80SxHFtXACSsBkIghYfBUd1jfYAq6Fy+awf5L9+XjOkEKTCdk1BwDXF9VAj7Cv4
         PHOJqaBtr/F/FHJPl5r4YmD+rK/y4FN+u9PW0NCWUq9WqZ2iCthkMLHUL2rkzt+4YAnh
         cw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zqeTFrmm9hzoE8Ei7WXbY06jiJr+QU1mv/oiGm2r+iM=;
        b=DpD0pX6zXr8R/86tKn9/TutUUX+a3pmv3tMuqvS/8zCzGHqoy5Nn++NC9ufLGPPrQg
         fK01XrHKnFb745srIFG4xECWzIwhwSXs55L2KQpr9VZ/PwQSGQ35VXZZ7Wv9oPfIJdeG
         eZfNvmag2nbSytLA3gNnOWwAo6ijAnRcDlauyU6ir0HvjNvBYSbuhNPw9wvSiNT74WvT
         8YxvXUL4ABcqmCm4Jo96nP3/SvgeWeWQXEmTPSHlNgTk2fmyjEu60Lyr3BKWlNiIJ9LJ
         99WdLjfjoGZn+cGM+4MiTQyUX7bEsELFMzsZp/rdPI2RZXU2/kQhhf6/HSWvyDBCKK9B
         Bnng==
X-Gm-Message-State: ANhLgQ2qVgNKxRbJdS3j7bPWoALHp2arnLm58qun3OaWzrRUgYQ7BDIc
        AMUfnN9b5UaqI4WuvU3FrHozmcMyjVS8/Uj9YjoSvtKhQo0=
X-Google-Smtp-Source: ADFU+vszSA1o2pLvYq/qAGXkejNLNYNwz+wQgc4J+iZlYicvbNaHvb+fJa86UFSBzrGtE96xtl6uovy7A2xL2/8WhFA=
X-Received: by 2002:a05:6830:18d4:: with SMTP id v20mr598129ote.23.1584470485004;
 Tue, 17 Mar 2020 11:41:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200317182754.2180-1-cai@lca.pw>
In-Reply-To: <20200317182754.2180-1-cai@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Tue, 17 Mar 2020 19:41:13 +0100
Message-ID: <CANpmjNPXewChhNiXy5SV-dYTiFN96hJKYXdkHyFYgZHu8c7Qnw@mail.gmail.com>
Subject: Re: [PATCH] mm/kmemleak: silence KCSAN splats in checksum
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>, catalin.marinas@arm.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Mar 2020 at 19:28, Qian Cai <cai@lca.pw> wrote:
>
> Even if KCSAN is disabled for kmemleak, update_checksum() could still
> call crc32() (which is outside of kmemleak.c) to dereference
> object->pointer. Thus, the value of object->pointer could be accessed
> concurrently as noticed by KCSAN,
>
>  BUG: KCSAN: data-race in crc32_le_base / do_raw_spin_lock
>
>  write to 0xffffb0ea683a7d50 of 4 bytes by task 23575 on cpu 12:
>   do_raw_spin_lock+0x114/0x200
>   debug_spin_lock_after at kernel/locking/spinlock_debug.c:91
>   (inlined by) do_raw_spin_lock at kernel/locking/spinlock_debug.c:115
>   _raw_spin_lock+0x40/0x50
>   __handle_mm_fault+0xa9e/0xd00
>   handle_mm_fault+0xfc/0x2f0
>   do_page_fault+0x263/0x6f9
>   page_fault+0x34/0x40
>
>  read to 0xffffb0ea683a7d50 of 4 bytes by task 839 on cpu 60:
>   crc32_le_base+0x67/0x350
>   crc32_le_base+0x67/0x350:
>   crc32_body at lib/crc32.c:106
>   (inlined by) crc32_le_generic at lib/crc32.c:179
>   (inlined by) crc32_le at lib/crc32.c:197
>   kmemleak_scan+0x528/0xd90
>   update_checksum at mm/kmemleak.c:1172
>   (inlined by) kmemleak_scan at mm/kmemleak.c:1497
>   kmemleak_scan_thread+0xcc/0xfa
>   kthread+0x1e0/0x200
>   ret_from_fork+0x27/0x50
>
> If a shattered value was returned due to a data race, it will be
> corrected in the next scan. Thus, let KCSAN ignore all reads in the
> region to silence KCSAN in case the write side is non-atomic.
>
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Marco Elver <elver@google.com>

Thanks,
-- Marco

> ---
>  mm/kmemleak.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index e362dc3d2028..5e252d91eb14 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1169,8 +1169,10 @@ static bool update_checksum(struct kmemleak_object *object)
>         u32 old_csum = object->checksum;
>
>         kasan_disable_current();
> +       kcsan_disable_current();
>         object->checksum = crc32(0, (void *)object->pointer, object->size);
>         kasan_enable_current();
> +       kcsan_enable_current();
>
>         return object->checksum != old_csum;
>  }
> --
> 2.21.0 (Apple Git-122.2)
>

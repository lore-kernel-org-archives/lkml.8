Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22665C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE1D9205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="seylWOpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgCQNbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:31:32 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:39793 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgCQNbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:31:31 -0400
Received: by mail-ot1-f67.google.com with SMTP id r2so6175438otn.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 06:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DXs/jX6e7R5DcQDvcvz4p2Rj3LVNM0uxyKYbz4RQLUM=;
        b=seylWOpvKMPn9Yr7bi17uwl4zHN6VRIYA61HJ+za+Pb0nrHGpTlM8bN+bw4Gt14xrC
         iF1IPUtFT/v8yZYlKq/Kto+YKlD053y1YedrnvlItJ8WNp1yRgv9V6o6EMOBdlTO7e8u
         +f70P1y8xC8j4cv6UUxaHdyg6GUV2dpRBCoZ+Vk3+bLJ8cfcHqv/RCshzA3Xw1qcvsme
         XlArM/aOBuLsLIhdzy/iggagkZd/rWbpcUw/huLOdKVmrSrY/Vp0S2166dMc4mD4RZO8
         AYdBxYO9Ay5w7nmBgnZsWWL6tPWbhIfzTud1XLw7NFRqJTHLLrjUwps9uB3NXgQDwCHC
         Q/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DXs/jX6e7R5DcQDvcvz4p2Rj3LVNM0uxyKYbz4RQLUM=;
        b=N/BAKvi5J2Ui24yXWNxb/pjpbIsCDRb4Ms+fnZCtaeXvACWYoBhjPc/RM4x7P1A2M7
         svCTUPZjq3yToN6XGqchzTsc+jisBj5hyoH3rv1O7tsYfNhqWW+9ICbsdlRug3aPeA0m
         TckWS4OkND77keoacht2CewEpl/XYgW5X4AORYZ7Ll6HagxDNgJrybk/72MPcM0VvQm5
         Y0fTVuf4aT3ax/ESpisnVYz9ehUw3YsqctZP38RlF2y7BjGWvbKZ/jTdYTmR2iMbCeGS
         S3PBqSi6L8POcj1ZQewVHXopP15GxW13/BdItt7SKIYUeyekh7pR+AaBMw1S7SmNFPU2
         m8/w==
X-Gm-Message-State: ANhLgQ0wVTpqUKfzscgfpExMDBNmyDdtNwzKgJKLG004CEpm/P8lfu+X
        4od/uY1e3SgZOtv6Eo0y8lWTdV//lG2JFYUsRrmX1w==
X-Google-Smtp-Source: ADFU+vvR4Xd6NW2c0219OA19u3Yc7B245HLSRbn1hd7O9QHEDzHxvDiw9ePE/v9nxCEVJUGmkfhBWbcWQqIk9JEBVrs=
X-Received: by 2002:a9d:6d87:: with SMTP id x7mr3846382otp.233.1584451889960;
 Tue, 17 Mar 2020 06:31:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200317132157.1272-1-cai@lca.pw>
In-Reply-To: <20200317132157.1272-1-cai@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Tue, 17 Mar 2020 14:31:18 +0100
Message-ID: <CANpmjNPRTEsaTxDeMnz8T6BtfEx5yzgFCYNP2KZkedZ2kq9ZUw@mail.gmail.com>
Subject: Re: [PATCH -next] mm/kmemleak: annotate a data race in checksum
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>, catalin.marinas@arm.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Mar 2020 at 14:22, Qian Cai <cai@lca.pw> wrote:
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
> corrected in the next scan. Thus, annotate it as an intentional data
> race using the data_race() macro.
>
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  mm/kmemleak.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> index e362dc3d2028..d3327756c3a4 100644
> --- a/mm/kmemleak.c
> +++ b/mm/kmemleak.c
> @@ -1169,7 +1169,12 @@ static bool update_checksum(struct kmemleak_object *object)
>         u32 old_csum = object->checksum;
>
>         kasan_disable_current();

Suggested:
+ kcsan_disable_current();

> -       object->checksum = crc32(0, (void *)object->pointer, object->size);
> +       /*
> +        * crc32() will dereference object->pointer. If an unstable value was
> +        * returned due to a data race, it will be corrected in the next scan.
> +        */
> +       object->checksum = data_race(crc32(0, (void *)object->pointer,
> +                                          object->size));

This will work with the default config, because for word-sized-aligned
writes no marking is enforced. But this will still cause a data race
if the write is e.g. due to a memcpy.

There are already markers for KASAN around, so the most reliable thing
is to just disable KCSAN in this region.

>         kasan_enable_current();

Suggested:
+ kcsan_enable_current();

Thanks,
-- Marco

>         return object->checksum != old_csum;
> --
> 2.21.0 (Apple Git-122.2)
>

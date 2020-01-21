Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8774C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7C52253D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 10:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmJnj0WP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgAUKXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 05:23:48 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34966 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbgAUKXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 05:23:48 -0500
Received: by mail-io1-f68.google.com with SMTP id h8so2308581iob.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 02:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NPi3Lmn/rLl5sk7+WqJ3pNoshTfD7fI1hPp452tWTQs=;
        b=AmJnj0WPV9MuXMY3kGrAjCWYVVWhQDd2aluXD0Oj1SQd9UPT2WDpG2gj7hxLjW3WVY
         OdB7NPqJOmFhQNA2ZOyjIFfBKVuvsc0Ql0SbuukOVxPrTN1BwnmauwIfuABceYHB+Tig
         yCTCuttWzXNtleeCzlHEVOGY3tIo7iG/Wx9LNEXNIsvE5e7GDTCY9sLwGewtPh8ndl7T
         gwQdET5WhNMlHz1fRPRwhv7z7IuLp/RtzYUE4GXwJxCC04pSSP/HYUwlFc6az1LCxb+O
         OJyJehPZQxEpdqt6aHgZXO6kTWjFj/Y+ibg7j3Qdc9dEYA6mJNDRMn+L7wouSeRAFVGD
         SAYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NPi3Lmn/rLl5sk7+WqJ3pNoshTfD7fI1hPp452tWTQs=;
        b=ObbVYoj3ESCMJ0w+s5Wub1nZRe0Y2BOL3F1btm/cDSM6uX+Yyh3urPAa8b57VLsE6M
         0x7CHO1L1Di4wOeVgvrJbTeWK7Vtxqs4rqz6ddsaRfmdsHoIqk1U13Wzcy2GPalB1DFc
         UEW+KKEf9q/TBksZRaxjcbzt9T70fRD1xFTKVTsglehYzRXfmW3tjnukdBMtpjHIBaR6
         kjtrzykcH/WguhnRZrstDLG0mzzKo3ySIZ72R04oztHN6DcMgdR0DdDFDknFxsTedPva
         jFdKQxUEynmljmNw0Dx1MWHd8U2605EoMlUPL7Lm+0KZZ0vKgdR0O5VIZVQOkWCbGHKK
         45BA==
X-Gm-Message-State: APjAAAX4uVdLlTueWMIw8xGr6u1KhCwv9ePAQX1XxJkXKD5iHm4yw0Ew
        iFqA6IbwwQDy5U+rMTdvyIdbEd8j30KZrYNIKXs=
X-Google-Smtp-Source: APXvYqy5txtGIUOlVMW00U6h6TUq4v7ArC+trH+W23WSkjui7DAbUKjy1gz6j6gSVWyd8H40U/IPOfju3T++/58bEoE=
X-Received: by 2002:a6b:8f11:: with SMTP id r17mr2541090iod.50.1579602227546;
 Tue, 21 Jan 2020 02:23:47 -0800 (PST)
MIME-Version: 1.0
References: <1579596552-257820-1-git-send-email-alex.shi@linux.alibaba.com>
In-Reply-To: <1579596552-257820-1-git-send-email-alex.shi@linux.alibaba.com>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Tue, 21 Jan 2020 11:23:35 +0100
Message-ID: <CAHpGcMJ6DazJ_rMPB2uUKfH-1oxVy=RoLvt2nMEvcdWWCnWjDw@mail.gmail.com>
Subject: Re: [PATCH] fs/gfs2: remove IS_DINODE
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex,

Am Di., 21. Jan. 2020 um 09:50 Uhr schrieb Alex Shi
<alex.shi@linux.alibaba.com>:
> After commit 1579343a73e3 ("GFS2: Remove dirent_first() function"), this
> macro isn't used any more. so remove it.
>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Bob Peterson <rpeterso@redhat.com>
> Cc: Andreas Gruenbacher <agruenba@redhat.com>
> Cc: cluster-devel@redhat.com
> Cc: linux-kernel@vger.kernel.org
> ---
>  fs/gfs2/dir.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
> index eb9c0578978f..636a8d0f3dab 100644
> --- a/fs/gfs2/dir.c
> +++ b/fs/gfs2/dir.c
> @@ -74,7 +74,6 @@
>  #include "util.h"
>
>  #define IS_LEAF     1 /* Hashed (leaf) directory */
> -#define IS_DINODE   2 /* Linear (stuffed dinode block) directory */

The same is true for the IS_LEAF macro. I'm adjusting the patch accordingly.

The other patch removing the LBIT macros looks good as well, so I'm
applying both.

Thanks,
Andreas

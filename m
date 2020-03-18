Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85289C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A8C020771
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iAeIBdla"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgCRMOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 08:14:18 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:41421 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgCRMOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 08:14:17 -0400
Received: by mail-vk1-f196.google.com with SMTP id q8so7001690vka.8
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 05:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=og0LDHDGJi+jmOmmQp4Rk2H6PUrLgVc6fcIsRCRNLD0=;
        b=iAeIBdlaaFvGcjmOV9nnbG4Q+ZKQ58q6k1c/nmRUOMcJSdQdGoeupdtrE0kMoc4lpt
         tEZueJQn3kCsdxcxN9odshFTtplAHptMXbyeDvQnnTC6abmb/DbaTG/Gjk/rjKhu34XH
         F2ITAgNyF83lzIz/61qEASXmvPCKRW+M9iJ+PbaFQzhZAIZB3yw8fhmgkCI09aEuas4p
         npdO3N3Ju7my6YLRjznwctZm7KlW4PbyQN6a5kYxyGYntxrnLPxGzzpswV6X9ffChNMZ
         S4QnHDcw9NCHeG0/8rpOn7HeDWK04qk/2DZsOqiKAaNE6IF1N8/U/0XYPUt7g3do7k6m
         eh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=og0LDHDGJi+jmOmmQp4Rk2H6PUrLgVc6fcIsRCRNLD0=;
        b=CTpluNu3EOAFkoNgiePRpoNzLnuVdawsPL/4aUnvuC8Omw1DbswvRYbXBZX0RhpVsA
         8Iph1WEheF4ac/wCvAajKM833SnOkyXF9wAAEI6+bGdQalI2eoqi+ja5Gr1UvnSokSbu
         we2N5QwWra2j7iQKkDSc41VhL2Avqg9AFCVcQ8NgRIomq32gJfiuYF6nU/HTK5xKZvby
         zl0iVrB3C3+MPGQJq/l+gEFNlfexRjXt8qrT8VndABAH+d7KCMsNtwPXcgIUeKeiTqWI
         ebxz/Np3CD3iTtU8V8ti9v52V0Un7HdKaib+gzdjYNaB+mFt3NSN6RAgCUC0Z2iEIGWB
         MqLQ==
X-Gm-Message-State: ANhLgQ1IzsQyAt8XhfSe8yEn+wS+TcX+oA6smfHf7WLMcYC53wYRdN3u
        BpFzD7fvOJyf5VcyD0LumLX0a0ChNTm3TPKEylWK8/KwWR4=
X-Google-Smtp-Source: ADFU+vtuxafvF6plHBJVfKJ7U23/fBbB1V91FZHEJpgZp+l9v0FqrX8HUV0TNGlgraDKAKeMO6f2LK/g141VKeZjYYs=
X-Received: by 2002:a1f:ee05:: with SMTP id m5mr3020614vkh.9.1584533656113;
 Wed, 18 Mar 2020 05:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200225101710.40123-1-yuchao0@huawei.com>
In-Reply-To: <20200225101710.40123-1-yuchao0@huawei.com>
From:   Ju Hyung Park <qkrwngud825@gmail.com>
Date:   Wed, 18 Mar 2020 21:14:04 +0900
Message-ID: <CAD14+f3pi331-V0gzjtxcMRVaEn3tPacrC20wtRq9+6JY9_HVA@mail.gmail.com>
Subject: Re: [PATCH v2] f2fs: use kmem_cache pool during inline xattr lookups
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao.

I got the time around to test this patch.
The v2 patch seems to work just fine, and the code looks good.

On Tue, Feb 25, 2020 at 7:17 PM Chao Yu <yuchao0@huawei.com> wrote:
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index a3360a97e624..e46a10eb0e42 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -23,6 +23,25 @@
>  #include "xattr.h"
>  #include "segment.h"
>
> +static void *xattr_alloc(struct f2fs_sb_info *sbi, int size, bool *is_inline)
> +{
> +       *is_inline = (size == sbi->inline_xattr_slab_size);

Would it be meaningless to change this to the following code?
if (likely(size == sbi->inline_xattr_slab_size))
    *is_inline = true;
else
    *is_inline = false;

The above statement seems to be only false during the initial mount
and the rest(millions) seems to be always true.

Thanks.

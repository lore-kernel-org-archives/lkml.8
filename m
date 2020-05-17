Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAE7C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 21:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB40C207D3
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 21:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IRCvmfBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgEQVjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 17:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbgEQVjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 17:39:51 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B09BC061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 14:39:51 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c24so6585803qtw.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 14:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXQSpo5cOSVhswku2XbziWLym4GqZt6GcybWhlW7HkQ=;
        b=IRCvmfBkpaRfxNOUPPCR/hBNAViX/cvtUaNm27KNkJ/l9DmhNzD66nZJb12UbMAAHS
         DhpX1THLXZ9brLgO6YCFm4ymQikeG2HM8O4UmjmjevM3DSxP88f/sokRBfCoeLrYqQqw
         fWVWdVcxjnNRaFLLyNa3WqQk0pKKcVqGqxowFVsQsvSI4Ty1+NNhTXk5KrKcpp3XB7wL
         wklWF49OvbBYbBJ6+TN9Kx6E3MLPeAFsXcP/IYFQY80lXXGmdAyRoT0sVbfzgj5rObqi
         bQM4hJooDpbHZ8lLbKMB3tQMPvkZGXUKcqCRiqMHSXezddtFBdQhHtZQqMmVvvKI8oPP
         invQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXQSpo5cOSVhswku2XbziWLym4GqZt6GcybWhlW7HkQ=;
        b=hBAzM7IPAUyPj9ozbzv241AzLeXAEs72kTYrKN2XbuSJL4eoebIGEoLhqO6qF5kWhq
         NvNpbpYAY6g4+aW7vhTDyTMYXVKEWNYwOZ1omfLDagPBTRymlRCVgGud+/dc3FLUnHkY
         YmVKJhp66MhG1rjiCAG4OQwW6KQqb191T/fkqjbpOJDpQjUDjpH/q81+4WIzeS8vjBRp
         lCjRaEC3/i8zyo+wkB9R0AVdX5dFzLH7aNnf3N9xJCVl/i4EL4kK1NWUWE/i3cqC0MQN
         8mXLNlW0mCoI41OErP2kY7ifWguuXsAXwIJQKR4GVULckup65j1wZcZ4uNUuZLE1kmhf
         4RwA==
X-Gm-Message-State: AOAM532J/gMzNHNJaYzQAHjp20/YmuKYen5bgaYtZECsY7Mbfx4ypwnU
        qgk+cc1i/KkLpWlWiOekWSa4gogWKBbDpcvWy0LUJw==
X-Google-Smtp-Source: ABdhPJyu1/pp1+dd5u1Mh4CvToq01YPVEZoUBmwc4NcKE5KzMsrD9d2oBzS123FiHqkqb7CUyPMK6xR0zLlyHFn0U4A=
X-Received: by 2002:ac8:fb5:: with SMTP id b50mr13533689qtk.164.1589751590455;
 Sun, 17 May 2020 14:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200502124802.9758-1-richard@nod.at>
In-Reply-To: <20200502124802.9758-1-richard@nod.at>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 17 May 2020 23:39:39 +0200
Message-ID: <CAFLxGvw9Tc9dr+=Dyuut9gXeLfUg2aUROGdZ4-g5=_OtS_hnLA@mail.gmail.com>
Subject: Re: [PATCH] ubi: Fix seq_file usage in detailed_erase_block_info
 debugfs file
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-mtd@lists.infradead.org, ben.shelton@ni.com,
        LKML <linux-kernel@vger.kernel.org>, zach.brown@ni.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 2, 2020 at 2:48 PM Richard Weinberger <richard@nod.at> wrote:
>
> 3bfa7e141b0b ("fs/seq_file.c: seq_read(): add info message about buggy .next functions")
> showed that we don't use seq_file correctly.
> So make sure that our ->next function always updates the position.
>
> Fixes: 7bccd12d27b7 ("ubi: Add debugfs file for tracking PEB state")
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  drivers/mtd/ubi/debug.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
> index 54646c2c2744..ac2bdba8bb1a 100644
> --- a/drivers/mtd/ubi/debug.c
> +++ b/drivers/mtd/ubi/debug.c
> @@ -393,9 +393,6 @@ static void *eraseblk_count_seq_start(struct seq_file *s, loff_t *pos)
>  {
>         struct ubi_device *ubi = s->private;
>
> -       if (*pos == 0)
> -               return SEQ_START_TOKEN;
> -
>         if (*pos < ubi->peb_count)
>                 return pos;
>
> @@ -409,8 +406,6 @@ static void *eraseblk_count_seq_next(struct seq_file *s, void *v, loff_t *pos)
>  {
>         struct ubi_device *ubi = s->private;
>
> -       if (v == SEQ_START_TOKEN)
> -               return pos;
>         (*pos)++;
>
>         if (*pos < ubi->peb_count)
> @@ -432,11 +427,8 @@ static int eraseblk_count_seq_show(struct seq_file *s, void *iter)
>         int err;
>
>         /* If this is the start, print a header */
> -       if (iter == SEQ_START_TOKEN) {
> -               seq_puts(s,
> -                        "physical_block_number\terase_count\tblock_status\tread_status\n");
> -               return 0;
> -       }
> +       if (*block_number == 0)
> +               seq_puts(s, "physical_block_number\terase_count\n");
>
>         err = ubi_io_is_bad(ubi, *block_number);
>         if (err)
> --

Applied!

-- 
Thanks,
//richard

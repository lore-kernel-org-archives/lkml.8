Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4BB7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A0EE20674
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hvP2SxRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgFCHDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 03:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgFCHDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 03:03:54 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106B4C05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 00:03:54 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id q8so1121958qkm.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 00:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QzVzuQF02fR+c0YY6XKBCSbJXl7wL1vS1Ln1HL3oxGw=;
        b=hvP2SxRps2n5aDrbSR8AAQbnQC0t0zBApBAx25ugAFYja0lvhsnGmNibf86F7WvKGg
         J+O6rwI5Za3ngxG/RuczGwvXZ3CddVudqhO6xw7M7+73T2uBDtS7ELpJWP2naiVjX2H2
         CUUDBo8X/Wj/yf47+Ks7aZYgLdUeFkRoGjh3cdwA5sXdAsmV5J6+cQcqppbz4qujvnsL
         E67tZfym83Fdq1LejN6YfBTcKeO6oORXbhs+wk7R7Gy2OqWZHE9MOPoAQS/lnrQFzyyG
         AjE9anYFv4LZXRYmgdLwgbr9woyk8RnVX049/PQ0knkZFQzkAmEDQi+vxY7QJ6WXUua9
         yONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QzVzuQF02fR+c0YY6XKBCSbJXl7wL1vS1Ln1HL3oxGw=;
        b=Z1cmeNPgh9jpzqqW5boo9IDgJkJgnnrxPhNLGtObrHQq7tahcNfFN25nKtTKwpFxN5
         kqgV374dhH64jBnL7QotcYDk5YLpkhcisKsMwlorCChBxUdz+iCapOZMps5r46xwwroq
         ify5kBQ8SeF1kz6/GXzcuooc4QGx09AIl9iah+O+X6RoRMP4qumhe15rcxrfLYR655GU
         ChNoSpLLCzMTUrUgJH2Um1+U3i0ZKKnOmONebn3zt+rLm95x3wWTXV6p1GkEsp6Uan43
         tlOfFWxmalAM1iL3AuHvFB8U+ktWjNUrCGnoOL/6C9J6Y9iMQsyxNAZ3WZZw925d8xap
         sckg==
X-Gm-Message-State: AOAM5338XqA3EAN/wKlt1bgX5LQyRAa66Aezw8Y5epm5udT7AcatARYR
        S90uwIY4ofTJkzRVqM4juRkinlpqMGMMF/cPu0aunphQ
X-Google-Smtp-Source: ABdhPJwS785WPHrjWKaLX4MeXy/6grzSvVxeAqt/HilgrtQDmL2JfnOGPBC89BA9nkq4UOir+8xy7GPL5j/4cJuIFrQ=
X-Received: by 2002:a05:620a:15f4:: with SMTP id p20mr26692587qkm.283.1591167833314;
 Wed, 03 Jun 2020 00:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200423025827.48736-1-lizhe67@huawei.com>
In-Reply-To: <20200423025827.48736-1-lizhe67@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 3 Jun 2020 09:03:42 +0200
Message-ID: <CAFLxGvzZequ2JtzaVOxSst_sH7PPWpWVF5nHv=B8oxLpy=wDjw@mail.gmail.com>
Subject: Re: [PATCH v2] jffs2: fix jffs2 mounting failure
To:     Zhe Li <lizhe67@huawei.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 4:58 AM Zhe Li <lizhe67@huawei.com> wrote:
>
> Mounting jffs2 on nand flash will get message "failed: I/O error"
> with the steps listed below.
> 1.erase nand flash
> 2.mount jffs2 on it (this mounting operation will be successful)
> 3.do chown or chmod to the mount point directory
> 4.umount jffs2
> 5.mount jffs2 on nand flash
> After step 5, we will get message "mount ... failed: I/O error".

The important step is missing. You need to unmount before jffs2 is done
with erasing.

>         if (c->nr_erasing_blocks) {
> -               if ( !c->used_size && ((c->nr_free_blocks+empty_blocks+bad_blocks)!= c->nr_blocks || bad_blocks == c->nr_blocks) ) {
> +               if (!c->used_size && ((c->nr_free_blocks+empty_blocks+bad_blocks) != c->nr_blocks || bad_blocks == c->nr_blocks) &&
> +                   !(has_root_inode(c) && !has_other_inode(c))) {

I see the problem but I don't think it is wise to implement such a workaround.
IIUC the real issue is that c->used_size being zero but
c->nr_free_blocks+empty_blocks+bad_blocks does not sum
up correctly in this situation.

-- 
Thanks,
//richard

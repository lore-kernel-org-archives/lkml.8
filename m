Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C8E5C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 22:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB12420684
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 22:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GH8rXg/R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726383AbgCHWWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 18:22:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40952 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726346AbgCHWWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 18:22:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id e26so7753311wme.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 15:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=URASEgXLCXmYqmGOZmBnXuA4vIEVErfWf/qZrIyg958=;
        b=GH8rXg/RBoeVCHRmXU7UaG368GOcyNH1caDPqDVVF6GbTSgYso6W3DLUf7SrTbO6sA
         bkwMeYCDv+XETt8/tzyMDVtZj5OZfWcoCNNHKpWIDyLFe3tbQVNgVqkPz22BD/em0q3f
         hacqUYidd7GIJWHIe2nXG1VB2emWOM+LtvhnNXGEiq6ReuAVIAuo0wM6kwUA6AZHr7VX
         9JWOxz4FT2imO1mc7qnLiZuBNrLI5agTs1E8VH3TPvUfO+Y6ep3uQytJzfYOG3xsD8Rr
         tK1I2UcRyS5bprFNdWETLDrJmhSOu9pwrmnfplky0VTsnLFUGg/bqUjYNFCdzUopV2/T
         4YPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=URASEgXLCXmYqmGOZmBnXuA4vIEVErfWf/qZrIyg958=;
        b=tj/79mjIg2NYp4KZanmRCiz9XMqLiRnveBR7DThNpA6p/ge7qmOK5W9uL7lqEGfnDk
         mEPgniSjepuKfSSngtazBM4Oun4040djGKxqdjPpJHYK9FwcdkSltt08HWNzsmB4rTQC
         D5JBkBzAStZ4F/GwCHmHoggYkIzkaejtWASYU3vfw6T/8+taRk6/9IZn4dnd4zkFDI+p
         07M+jWkDf6OqBYCNM4SHZw+vkVooaS0nwTBaqPqjlh+aU4FZGhHidhrU8mrhf4RU6g2o
         3aJ9vwQsxKspEQ5Vc7eRkrx/U4r/RUiahvGzUXUkHSjrodqJ//2IxV2JUM91bUBpqBPP
         eSCA==
X-Gm-Message-State: ANhLgQ2aaKjFKW9DcWyoGQxIb93XUA9OQ5Dru0xLuLotZtosp5hzjWwD
        gytZZQrj3LpR4cGdP1mQAxnlyKb0SAQwWraOGuY=
X-Google-Smtp-Source: ADFU+vvmDxhucOTTMIf2dZU/EvIWNTT6rVpb/WkHwSfEH980ZDe/pVqVUBboccsignoRfBDUB2/VxyGnIFC2zjAwXiY=
X-Received: by 2002:a1c:2d88:: with SMTP id t130mr17785876wmt.68.1583706140146;
 Sun, 08 Mar 2020 15:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <1583228423-60816-1-git-send-email-chengzhihao1@huawei.com>
In-Reply-To: <1583228423-60816-1-git-send-email-chengzhihao1@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 8 Mar 2020 23:22:08 +0100
Message-ID: <CAFLxGvxgzPx=8VxqiamDxjdKwH6rhxJaXnqiJ+3w--p+i32vJA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix two mem leak bugs
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "zhangyi (F)" <yi.zhang@huawei.com>, linux-mtd@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 10:33 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>
> Zhihao Cheng (2):
>   ubifs: ubifs_jnl_write_inode: Fix a memory leak bug
>   ubifs: ubifs_add_orphan: Fix a memory leak bug
>
>  fs/ubifs/journal.c | 1 +
>  fs/ubifs/orphan.c  | 9 +++++++--
>  2 files changed, 8 insertions(+), 2 deletions(-)

Thanks for fixing, applied!

-- 
Thanks,
//richard

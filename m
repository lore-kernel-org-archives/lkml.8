Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C22DC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 22:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0869620748
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 22:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JO/zYu9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390121AbgAPWpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 17:45:24 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41807 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732417AbgAPWpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 17:45:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so20829459wrw.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 14:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZeEx6vriQEqUZqvv01zk5S/tyK4ds56A87BGFV2fdo0=;
        b=JO/zYu9/0B1QqfWk+Q90BO8T36nWjCEP/YqBt2+1t6iCF3P6VwHPIiIMeynH+Bhv55
         kPWdlzTgaAgFMQRfpCr6D5dzTeesa8rygYDAeaMvPfIrEXwCEn+8vxI25g54ecrlZJBN
         PiJc01/a42az6zmQV2n/NAOGJ/yiScTNSIdiBHjBjXzVAHki5SrJNlUya2Z72x9fRpzw
         fBxmCvMLlyfrZK7D31ZrdKo7kiUM69JenaK1BgzhgHSzeoUEDWKh1dc5kaVavpMpLcAx
         fdRwfBbLV2jHZSvjFyInwFPUh4tzghTMEgRwY1MvfN+Jn0ksENiXujDRc2JwgQImVzEh
         ghuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZeEx6vriQEqUZqvv01zk5S/tyK4ds56A87BGFV2fdo0=;
        b=EIjUtZFCm/7P3xtHJaQ/Kf0aSRcRI5VOHkr56AFZpR7l9BtSThX63pGp3iOlKxNuxh
         FANgAcd7mbaJAiIavGOYPzFJi6VdHu7oLx6VXzgFlhW3BSJyHFrnTQp6fQlEg8V47BoQ
         0g6i/1hlyjXnNo+GD42UPVjy3ktVaZYyBCsQHy9hZ+icYQjLCyelZj924bkAbkk1H34d
         kz6ZSdZ14/SZptyjMrMNuZNW+Zei2/GM+OWM/2Bsu8qiSYZhmjB029jxcLhQmfvglTX+
         lTEDNAFkTTu6WVQgYTaaGlvNoHKJ/nV7vHbtQz9Fu/gUHkwpcCfo9kIHeuqhrlOIOIK1
         txRA==
X-Gm-Message-State: APjAAAU+SVyGEKsvqDGUYsoxeGY9QkD4xoYsxBxQdrw+mfCkVkysnkYa
        F3s0wXucqMsq8DbqunUucebre+Ix9cD5C95nZ7c=
X-Google-Smtp-Source: APXvYqzX3JZISkEyu4h9LVKxefhdR3EDfZD0YaZJpT7SsgFJ2KKaPaKUHxWUXIoKZZ8s08rQPeXGFIMy32GOGFLx9Dk=
X-Received: by 2002:adf:e5ce:: with SMTP id a14mr5528976wrn.214.1579214721659;
 Thu, 16 Jan 2020 14:45:21 -0800 (PST)
MIME-Version: 1.0
References: <1578736236-141308-1-git-send-email-chengzhihao1@huawei.com>
In-Reply-To: <1578736236-141308-1-git-send-email-chengzhihao1@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Thu, 16 Jan 2020 23:45:10 +0100
Message-ID: <CAFLxGvzOeL_0Lq30rvbaSuxsFZSzYSvKw2V=C1gvbad9VPjiEQ@mail.gmail.com>
Subject: Re: [PATCH v2] ubifs: Fix deadlock in concurrent bulk-read and writepage
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "zhangyi (F)" <yi.zhang@huawei.com>, linux-mtd@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 11, 2020 at 10:43 AM Zhihao Cheng <chengzhihao1@huawei.com> wro=
te:
>
> In ubifs, concurrent execution of writepage and bulk read on the same fil=
e
> may cause ABBA deadlock, for example (Reproduce method see Link):
>
> Process A(Bulk-read starts from page4)         Process B(write page4 back=
)
>   vfs_read                                       wb_workfn or fsync
>   ...                                            ...
>   generic_file_buffered_read                     write_cache_pages
>     ubifs_readpage                                 LOCK(page4)
>
>       ubifs_bulk_read                              ubifs_writepage
>         LOCK(ui->ui_mutex)                           ubifs_write_inode
>
>           ubifs_do_bulk_read                           LOCK(ui->ui_mutex)
>             find_or_create_page(alloc page4)                  =E2=86=91
>               LOCK(page4)                   <--     ABBA deadlock occurs!
>
> In order to ensure the serialization execution of bulk read, we can't
> remove the big lock 'ui->ui_mutex' in ubifs_bulk_read(). Instead, we
> allow ubifs_do_bulk_read() to lock page failed by replacing
> find_or_create_page(FGP_LOCK) with
> pagecache_get_page(FGP_LOCK | FGP_NOWAIT).
>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Suggested-by: zhangyi (F) <yi.zhang@huawei.com>
> Cc: <Stable@vger.kernel.org>
> Fixes: 4793e7c5e1c ("UBIFS: add bulk-read facility")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206153
> ---
>  fs/ubifs/file.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied. Thanks a lot for hunting this down!

--=20
Thanks,
//richard

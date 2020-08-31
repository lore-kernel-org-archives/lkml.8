Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D0DC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58E020767
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kpvTUnxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgHaPWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726755AbgHaPWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:22:18 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0006C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 08:22:17 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id h10so6332443ioq.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 08:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v6aATz1DrVzTsNm6cohCGLPYmM1JDr9u4o7wfl1KrmQ=;
        b=kpvTUnxia+Vb6v+2T62Y1tzsvRiUWtVSiYS8bxwIgN+SjgF7L1liSKiLaaoKbbqJso
         9SPZVUN5K3oaoyI7rEAOsAgh9o7gV/yXCgF+5srCxYXCHpF4WuTl/ElWZtu6YLhSCg60
         Pzu62ZNUGtY4niWkO/jRXwatOwWCKX6zAeW6q7+SjjomqfpYfr+1ETFayYIJAqfNZ4G+
         qHNe8QjTj+pZjvHt/z/KzTqZx6L/2K7SgrBekZjb57pJ6xB0LYFrRW4EUeDWbf4lMZJ6
         93/xr1CVxvjJmyZhwEkSAAdiSeAcr6lfw+RsmoWqkZhas3cbbgY8xkYxcf3SD7ofLm/F
         kFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v6aATz1DrVzTsNm6cohCGLPYmM1JDr9u4o7wfl1KrmQ=;
        b=MVauvNZUj9T8/S+AJobMd+uSWmwhWsA2Cvd7O7TftB+akGBK6PcXhRUjtzLl8MzJjz
         haEuxpc2gAHfdLijiX21Fado4jA4TZn0a4foK7AzcaYfJQbSRjODI253byuFSRtRl2gy
         lScONBZdcTaSYK6ZGuaVCmFzx6yQLBD2RSjWKuH4lgSRI6nYBcsds8iisBRpY76xfZeb
         HSZQhWegyCDccwfObQO0E3dHcBUGra6urtl4+B+IYl9GWtDA+YUTBV1f5oqn7wLQNqjM
         Dsa4le3WL03H04wRKyTS8fQBz+/kjcw3o6BagVrHf991jSujIb32NTmFRGmWiuefPB54
         EdgA==
X-Gm-Message-State: AOAM530IMFzkeIMyTH/ykui9FWt8wOs/BaFBy0PlXHILLHZyJbmqfmAc
        RqfEPYg+U1lLw0DV393MVOvwKlmCysHJiW9L
X-Google-Smtp-Source: ABdhPJyAgM2GlRZVCWCkUnBO1XNUnkD9OMa7NSlRGQqHiZ2S//nbyzT3RwaPgka2CDaZG5IjCJjVhw==
X-Received: by 2002:a02:c8c8:: with SMTP id q8mr1642061jao.46.1598887336702;
        Mon, 31 Aug 2020 08:22:16 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m3sm4704997ill.57.2020.08.31.08.22.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2020 08:22:16 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] fat: Avoid oops when bdi->io_pages==0
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        fsdevel <linux-fsdevel@vger.kernel.org>
References: <87ft85osn6.fsf@mail.parknet.co.jp>
Message-ID: <b4e1f741-989c-6c9d-b559-4c1ada88c499@kernel.dk>
Date:   Mon, 31 Aug 2020 09:22:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87ft85osn6.fsf@mail.parknet.co.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 29, 2020 at 7:08 PM OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> wrote:
>
> On one system, there was bdi->io_pages==0. This seems to be the bug of
> a driver somewhere, and should fix it though. Anyway, it is better to
> avoid the divide-by-zero Oops.
>
> So this check it.
>
> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> Cc: <stable@vger.kernel.org>
> ---
>  fs/fat/fatent.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
> index f7e3304..98a1c4f 100644
> --- a/fs/fat/fatent.c   2020-08-30 06:52:47.251564566 +0900
> +++ b/fs/fat/fatent.c   2020-08-30 06:54:05.838319213 +0900
> @@ -660,7 +660,7 @@ static void fat_ra_init(struct super_blo
>         if (fatent->entry >= ent_limit)
>                 return;
>
> -       if (ra_pages > sb->s_bdi->io_pages)
> +       if (sb->s_bdi->io_pages && ra_pages > sb->s_bdi->io_pages)
>                 ra_pages = rounddown(ra_pages, sb->s_bdi->io_pages);
>         reada_blocks = ra_pages << (PAGE_SHIFT - sb->s_blocksize_bits + 1);

I don't think we should work-around this here. What device is this on?
Something like the below may help.

diff --git a/block/blk-core.c b/block/blk-core.c
index d9d632639bd1..10c08ac50697 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -539,6 +539,7 @@ struct request_queue *blk_alloc_queue(int node_id)
 		goto fail_stats;
 
 	q->backing_dev_info->ra_pages = VM_READAHEAD_PAGES;
+	q->backing_dev_info->io_pages = VM_READAHEAD_PAGES;
 	q->backing_dev_info->capabilities = BDI_CAP_CGROUP_WRITEBACK;
 	q->node = node_id;

-- 
Jens Axboe


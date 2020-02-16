Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A25AC2BA83
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 07:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F60520857
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 07:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAbgxHfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgBPHqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 02:46:42 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33940 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgBPHqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 02:46:42 -0500
Received: by mail-ot1-f66.google.com with SMTP id j16so13210005otl.1
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2020 23:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kj2lE0jHDBa2FxapHGg1DD4EY4FRFGnToV7pEuklTd8=;
        b=gAbgxHflRHUuYX0gda/X4GBGNO18szIyG2edr2LCaYV9RI6DV21LkOssLzSyMwigHr
         BXP2pfCii1hxN7/51ejAASwSZYPQB0soT1F5EMKnIFsH58o7QY8ai1Qz3UQW9CgpEiNI
         3I+0TSYtLyrdn8sWC2q9weHCV9zCTXNMRKUpl6LBKpfPbMcVded9dyffSg0Wg568BttQ
         L56dCKagXUd2NI9tgrpaJH9W7hxOlttZGvIvHfeJF/cNKF4xKwQY7d00z77afIhQlrIV
         5mY4f/KOyDXwD8yTwbEbm4gOvHZZuWHj59ovFI+PA4K8q3kbOmtlceH6UQRgNFssl+Wh
         dixg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kj2lE0jHDBa2FxapHGg1DD4EY4FRFGnToV7pEuklTd8=;
        b=Y/ZjE58mYDS4nuNWocQuKCuFVslGIZxJqVchEcUpG5d6ZoBuT3P1YN0CMy98ZDE7xv
         xBBw9ZKQ29Re9j1jIgJA5eCf9B2tAOfgzAzF2SAIPbAg1GxMV6VxY6EKIRPBK3fEWbt5
         n5/WnQDWBwTHG4mfPUwnWmTaRt/UIzqLmLr2j6OlfHyBJJhXhuqmofRYGaL3VSBn0TVj
         7rskU6DDHV2cHpDSqjIdqPvexWTPOaDlaQbeC52Nde8kQZFYxbKK/os1iHoagjDYKk1j
         P7qmaqqg+BnEOFXHfcr+JLca/ezwsdvHLdJLSm7DWVwyI9y4g5BjB7VFn4iVPy1TshgX
         8Ymw==
X-Gm-Message-State: APjAAAUMfHcSoUpJSycu9nt0+SQg/7R8iA6yynCNDHbNft+CtFSeK6pe
        piFsSFR8tbIPkf+XqJ2C4gGfYzFs
X-Google-Smtp-Source: APXvYqyEJ55CSatcdJZKGpRX/SkBTQMott4Gv5M5GnWG+srfHaPgcFgbJNha6HQb6sr2fZYtNew5Rg==
X-Received: by 2002:a9d:6415:: with SMTP id h21mr8611393otl.152.1581839201169;
        Sat, 15 Feb 2020 23:46:41 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id c7sm4178864otn.81.2020.02.15.23.46.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 15 Feb 2020 23:46:40 -0800 (PST)
Date:   Sun, 16 Feb 2020 00:46:39 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     virtualization@lists.linux-foundation.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] virtio_balloon: Fix unused label warning
Message-ID: <20200216074639.GA25292@ubuntu-m2-xlarge-x86>
References: <20200210093328.15349-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200210093328.15349-1-bp@alien8.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 10:33:28AM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Fix
> 
>   drivers/virtio/virtio_balloon.c: In function ‘virtballoon_probe’:
>   drivers/virtio/virtio_balloon.c:963:1: warning: label ‘out_del_vqs’ defined but not used [-Wunused-label]
>     963 | out_del_vqs:
>         | ^~
> 
> The CONFIG_BALLOON_COMPACTION ifdeffery should enclose it too.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: David Hildenbrand <david@redhat.com>
> ---
>  drivers/virtio/virtio_balloon.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 7bfe365d9372..b6ed5f8bccb1 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -959,9 +959,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  	iput(vb->vb_dev_info.inode);
>  out_kern_unmount:
>  	kern_unmount(balloon_mnt);
> -#endif
>  out_del_vqs:
>  	vdev->config->del_vqs(vdev);
> +#endif

I noticed the same issue and sent an almost identical patch [1] but I
kept the call to del_vqs outside of the CONFIG_BALLOON_COMPACTION guard
since it seems like that should still be called when that config is
unset, as that was the case before commit 1ad6f58ea936 ("virtio_balloon:
Fix memory leaks on errors in virtballoon_probe()"). Is this patch fully
correct? I am not a virtio expert at all, just noticing from a brief
reading of this function.

[1]: https://lore.kernel.org/lkml/20200216004039.23464-1-natechancellor@gmail.com/

Cheers,
Nathan

>  out_free_vb:
>  	kfree(vb);
>  out:
> -- 
> 2.21.0
> 

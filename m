Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C541DC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 879C020C09
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 19:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGAYc71d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgIITET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 15:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgIITES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 15:04:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5221FC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 12:04:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id t10so4129269wrv.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 12:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=DL1SEibpeaqz3go7znBIkPpEohNdMbTETgjj6/Qc+uI=;
        b=bGAYc71dTBUOxZpxb7MWxow5YO9o0MBt1KqSE2i6A/MBqhBn839NsSqZeMoJMbawYF
         oU0KA7NSK55AppGuSbmHixR8pnue99eSMn2eEXpriKkdSWLHFU0e8GvU127KRvRHQ8GF
         RI19me743BgvvDuiXedHL9g/35MYle5WNbNGus79KBPU0bEcT9cG7u22U3ypXvJ7IutF
         qx9BY+ff6WNmhp9ikh48ylgrbs4blr0GxIWejb4ZnqBKnwTZZYnK3leh/zhHbMKRm/4Z
         16hUjqkRI6sunC0YvSsXILW5Ti0OB85exvPkpcyOLSYDHy/q+i3MJqE2ZGF5OT+F4G4g
         qr+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=DL1SEibpeaqz3go7znBIkPpEohNdMbTETgjj6/Qc+uI=;
        b=MT6ezj2N+53iXgzgS/MHXLhMbH7SQ19+Fe6EMfnumiWrXtpFAsdNFqF8t8+l66+C7x
         CZT7FTPk5pUP7p080VsyZMo2TunVnRZfxJVZ1QZXluPMUnC0ZjOl52eX8HBFFxeP6vqS
         mggYehvDV6dp8VNQRm0JULNYNf4uVOecS+7G0Aky5ItPKpu2ERXWBXsAIvZEZ+77RWAU
         BytR1/192m8UR63arNKsuGNrkD4fbW1U66dv1VoeR6dIO0SiztC3PXEai1zgJKmVy+uC
         HdDbstgRHrjytawi4ZcHidEVkLaHgNw+MXPCKugdFuKxEzLLuVhhirSDJpV9YLYPEUtV
         VLAA==
X-Gm-Message-State: AOAM533pUeuxDVuOj1ZxcmWwi8hFsfQJcCt5vKcxo3dTDVBRp9HlufBi
        cLlAO8wAPN4b47Vmmrw2pD9hNf4/xUc5XwFD
X-Google-Smtp-Source: ABdhPJwnSjwKUhbDxSi4Hx9jU8v3Rzho6NFLXjRpmX50GxpevZ75GgJaoCwlPEPcwEOoXbPZ7MnDdg==
X-Received: by 2002:adf:db43:: with SMTP id f3mr5634313wrj.219.1599678256633;
        Wed, 09 Sep 2020 12:04:16 -0700 (PDT)
Received: from [192.168.0.16] (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id f1sm5492410wrt.20.2020.09.09.12.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Sep 2020 12:04:16 -0700 (PDT)
Subject: Re: [PATCH] fs: omfs: use kmemdup() rather than kmalloc+memcpy
To:     Bob Copeland <me@bobcopeland.com>,
        linux-karma-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20200824211755.597245-1-alex.dewar90@gmail.com>
From:   Alex Dewar <alex.dewar90@gmail.com>
Message-ID: <5efaa7be-1890-0169-d133-8dd40b238d6d@gmail.com>
Date:   Wed, 9 Sep 2020 20:04:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200824211755.597245-1-alex.dewar90@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2020 22:17, Alex Dewar wrote:
> Issue identified with Coccinelle.
Gentle ping?
>
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
>   fs/omfs/inode.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
> index b76ec6b88ded..8867cefa79cf 100644
> --- a/fs/omfs/inode.c
> +++ b/fs/omfs/inode.c
> @@ -363,12 +363,11 @@ static int omfs_get_imap(struct super_block *sb)
>   		bh = sb_bread(sb, block++);
>   		if (!bh)
>   			goto nomem_free;
> -		*ptr = kmalloc(sb->s_blocksize, GFP_KERNEL);
> +		*ptr = kmemdup(bh->b_data, sb->s_blocksize, GFP_KERNEL);
>   		if (!*ptr) {
>   			brelse(bh);
>   			goto nomem_free;
>   		}
> -		memcpy(*ptr, bh->b_data, sb->s_blocksize);
>   		if (count < sb->s_blocksize)
>   			memset((void *)*ptr + count, 0xff,
>   				sb->s_blocksize - count);


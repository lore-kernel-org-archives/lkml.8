Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71939C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 14:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CD3D20FC3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 14:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="azMuqrPN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgHUOLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgHUOLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 10:11:47 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C433C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 07:11:47 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id o22so1244575qtt.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 07:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=/O7GsQlyOvKMn4vyIwYIr3C3iH5spCXWnHT7lFFAbyY=;
        b=azMuqrPNOdNg2w70CvNRuUyt5rnFriNwiKakFhXOpvnFpexz7yruIqjma3h0vFsJ29
         1Qy0FCVqaVtCmh+9q0zyYjIBhcOXxgTRKGSxLUkCIeRf4CLq+NcBGNGQHRaHsLRM67cj
         mO8wJHaXCIGKyaDZBpS5StuxO/+6sdVbK+Bftmmbx2FeI8hJcTGrXqpVUlD+96TC+idA
         rweeIzIkcDeFBMkBNVHufmb7P9Eyd2+Ttbf2rZ6nSnk7eWFWInSZiifqIYYoCLOceKKA
         gzz+kpZG1PXyqTCHH1VqnSrKjJU6DzN9aAx7bmd+f7xzRETL0xhfOacaPITRtNkDhr5U
         Ur6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/O7GsQlyOvKMn4vyIwYIr3C3iH5spCXWnHT7lFFAbyY=;
        b=W4cHiGdZyqR89ky402/6clkFBMmXhjtHDa2xTVGha6d5Ny1wIvo3D3/9UAOhf5UT46
         jbQ93z/mrlcLsmfR25C4bBnrazOwa0yHpMkXZv9cNi20LBW0YTgiZDzpiw0/SXGzOCHV
         POV962H19oKNDNfswkp3ObsAjxZwVuExQZL0AOU5l9erZAJ8Z0wkB9HG5LBgqxRLMyVl
         0WPFsAjMPDyd4z/xQS8k45gvPZCY/6A40rYEHRkVfj7//kcoYqiEzBNScqDOL3oHGM9a
         RliRJg+jhFLs+3pJLaxjmQBsvco2BwUVMk4FfdpFYOz5IAnCz60vr0rwLCxxCjapRa3d
         Mlcg==
X-Gm-Message-State: AOAM530arMLnrc1Yy0gVSTnqC4R7vE1DxlZAJZbqaLxCAX7wlrbsQPXR
        6s8xH/XbLSm8P7lFtzRzWigzs75E9NpKIrU4
X-Google-Smtp-Source: ABdhPJzfnGpcJKcS4ULozLzoVaIH2pkxr/lK8lZcQc6x9wmaPcOQ6uDtYUIhhN4cj4uKEdsMM0D9Mw==
X-Received: by 2002:aed:2dc1:: with SMTP id i59mr2956362qtd.340.1598019106177;
        Fri, 21 Aug 2020 07:11:46 -0700 (PDT)
Received: from localhost.localdomain (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id x28sm1798067qki.55.2020.08.21.07.11.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 07:11:45 -0700 (PDT)
Subject: Re: [PATCH] btrfs: check return value of filemap_fdatawrite_range()
To:     Alex Dewar <alex.dewar90@gmail.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200821124154.10218-1-alex.dewar90@gmail.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <c3c0ddbe-e225-22a4-c9bf-9317a50c211b@toxicpanda.com>
Date:   Fri, 21 Aug 2020 10:11:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821124154.10218-1-alex.dewar90@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/20 8:41 AM, Alex Dewar wrote:
> In btrfs_dio_imap_begin(), filemap_fdatawrite_range() is called without
> checking the return value. Add a check to catch errors.
> 
> Fixes: c0aaf9b7a114f ("btrfs: switch to iomap_dio_rw() for dio")
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
>   fs/btrfs/inode.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index 7b57aaa1f9acc..38fde20b4a81b 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -7347,9 +7347,12 @@ static int btrfs_dio_iomap_begin(struct inode *inode, loff_t start,
>   	 * outstanding dirty pages are on disk.
>   	 */
>   	if (test_bit(BTRFS_INODE_HAS_ASYNC_EXTENT,
> -		     &BTRFS_I(inode)->runtime_flags))
> +		     &BTRFS_I(inode)->runtime_flags)) {
>   		ret = filemap_fdatawrite_range(inode->i_mapping, start,
>   					       start + length - 1);
> +		if (ret)
> +			return ret;
> +	}
>   
>   	dio_data = kzalloc(sizeof(*dio_data), GFP_NOFS);
>   	if (!dio_data)
> 

Had to check to make sure there's no cleanup that's needed, there isn't, 
you can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef

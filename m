Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC3CC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:15:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38CEA21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 16:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583856919;
	bh=5B7f7iMicXNmubmqlX5vKEndbJydDCOLljZZexLnsC0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1o466YCg2ak19EsZLHzpQlEXUa2+sXS3V2q1mcLgWPDICH8nB9vMIMU0ipFaZi71E
	 ZVlglm5d86DkqIWQg1E58khgKA5iV1STwo04WPJ3Pc0SE8EBvnDFJLgMVavmSj6DDd
	 tpHFPDUmZQP0OSvmyo3s5M+qKVeAYedusDDRXs8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgCJQPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 12:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:39740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbgCJQPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 12:15:17 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0C6A20873;
        Tue, 10 Mar 2020 16:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583856917;
        bh=5B7f7iMicXNmubmqlX5vKEndbJydDCOLljZZexLnsC0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HGGaSYt+LLXeCifV5rE2zEG9j8k3JLp9ZtvnClVAmGdIMNY+uF+1Ifdv7nRqqH58s
         9gv6S4+LS7+4lSysbdYlMsAIS1YZpcZQSzK4wGkvs1/uq8ne7MlxnIceSlPfNiMWRW
         q4hEF4zU4b5Nm0A7+lRgncmeIuVCCSOzFD8hy7Xs=
Date:   Tue, 10 Mar 2020 09:15:15 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 1/5] f2fs: change default compression algorithm
Message-ID: <20200310161515.GA1067@sol.localdomain>
References: <20200310125009.12966-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310125009.12966-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 08:50:05PM +0800, Chao Yu wrote:
> Use LZ4 as default compression algorithm, as compared to LZO, it shows
> almost the same compression ratio and much better decompression speed.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index db3a63f7c769..ebffe7aa08ee 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1577,7 +1577,7 @@ static void default_options(struct f2fs_sb_info *sbi)
>  	F2FS_OPTION(sbi).test_dummy_encryption = false;
>  	F2FS_OPTION(sbi).s_resuid = make_kuid(&init_user_ns, F2FS_DEF_RESUID);
>  	F2FS_OPTION(sbi).s_resgid = make_kgid(&init_user_ns, F2FS_DEF_RESGID);
> -	F2FS_OPTION(sbi).compress_algorithm = COMPRESS_LZO;
> +	F2FS_OPTION(sbi).compress_algorithm = COMPRESS_LZ4;
>  	F2FS_OPTION(sbi).compress_log_size = MIN_COMPRESS_LOG_SIZE;
>  	F2FS_OPTION(sbi).compress_ext_cnt = 0;
>  	F2FS_OPTION(sbi).bggc_mode = BGGC_MODE_ON;

This makes sense, but it's unclear to me why comparing the different compression
algorithms is happening just now, after support for both LZO and LZ4 was already
merged into mainline and now has to be supported forever.  During review months
ago, multiple people suggested that LZ4 is better than LZO, so there's not much
reason to support LZO at all.

- Eric

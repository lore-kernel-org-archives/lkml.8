Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7B6C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DD422083E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598896936;
	bh=1BSfVGYPM5em9cDJnKj94QsfZf/L2qKC8T3By5pkXos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RnqRTvWYa5e9u4D6enZ3qvumTLkptgZVpGMA+3cn8xyNQgvFF5J/69a/WkSEmIdVx
	 QG2HIgOovQXGlckZFCFSmV+EFXuVMiaQxz5R/JHMT27XNy9YrHq7sZ58D9dRmOwc1o
	 kA5Cor7ajhd/MkspjDRhOJGVALIUntElSvd01hmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgHaSCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:02:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729029AbgHaSBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:01:44 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9F422083E;
        Mon, 31 Aug 2020 18:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598896903;
        bh=1BSfVGYPM5em9cDJnKj94QsfZf/L2qKC8T3By5pkXos=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rd9KwLFdgKeEZwSOUv3XU7M7Bf36F9tw2s05UxvyIusTaB5OJfPqVizaYVDFLkzav
         PFI2Be8gDLXplWNqHwMTZLZ30/l3fDp9dmuq/NRUp10+2WxsHRNAXwwA3lpF/P4Rz6
         6aOmsfuqQ/b5s0a9nI/oP/y9TOR3vpJhNzJiYh68=
Date:   Mon, 31 Aug 2020 11:01:43 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH v2 5/5] f2fs: support age threshold based garbage
 collection
Message-ID: <20200831180143.GB3665231@google.com>
References: <20200804131449.50517-1-yuchao0@huawei.com>
 <20200804131449.50517-6-yuchao0@huawei.com>
 <20200825193404.GA2614120@google.com>
 <7986af8c-1fe9-7140-f1c0-d8b4a58f702c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7986af8c-1fe9-7140-f1c0-d8b4a58f702c@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

Applied. Thanks.

On 08/31, Chao Yu wrote:
> Hi Jaegeuk,
> 
> I've changed code a bit to fix some bugs, including:
> - gc_idle = 3 (GC_IDLE_AT) description
> - disallow set gc_idle to 3 if atgc is off
> - keep compatibility with checkpoint disabling
> 
> Could you please check and merge below diff?
> 
> From: Chao Yu <yuchao0@huawei.com>
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  Documentation/ABI/testing/sysfs-fs-f2fs |  3 ++-
>  fs/f2fs/gc.c                            | 12 +++++++++++-
>  fs/f2fs/sysfs.c                         | 11 ++++++++---
>  3 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> index 7f730c4c8df2..834d0becae6d 100644
> --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> @@ -22,7 +22,8 @@ Contact:	"Namjae Jeon" <namjae.jeon@samsung.com>
>  Description:	Controls the victim selection policy for garbage collection.
>  		Setting gc_idle = 0(default) will disable this option. Setting
>  		gc_idle = 1 will select the Cost Benefit approach & setting
> -		gc_idle = 2 will select the greedy approach.
> +		gc_idle = 2 will select the greedy approach & setting
> +		gc_idle = 3 will select the age-threshold based approach.
> 
>  What:		/sys/fs/f2fs/<disk>/reclaim_segments
>  Date:		October 2013
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 6413886e52d4..3c0edb8b4cc5 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -388,6 +388,16 @@ static void add_victim_entry(struct f2fs_sb_info *sbi,
>  	unsigned long long mtime = 0;
>  	unsigned int i;
> 
> +	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)) {
> +		if (p->gc_mode == GC_AT &&
> +			get_valid_blocks(sbi, segno, true) == 0)
> +			return;
> +
> +		if (p->alloc_mode == AT_SSR &&
> +			get_seg_entry(sbi, segno)->ckpt_valid_blocks == 0)
> +			return;
> +	}
> +
>  	for (i = 0; i < sbi->segs_per_sec; i++)
>  		mtime += get_seg_entry(sbi, start + i)->mtime;
>  	mtime = div_u64(mtime, sbi->segs_per_sec);
> @@ -721,7 +731,7 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
>  		/* Don't touch checkpointed data */
>  		if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED) &&
>  					get_ckpt_valid_blocks(sbi, segno) &&
> -					p.alloc_mode != SSR))
> +					p.alloc_mode == LFS))
>  			goto next;
>  		if (gc_type == BG_GC && test_bit(secno, dirty_i->victim_secmap))
>  			goto next;
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index 88ed9969cc86..bacfa9c35e6b 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -375,12 +375,17 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
>  		return count;
>  	}
>  	if (!strcmp(a->attr.name, "gc_idle")) {
> -		if (t == GC_IDLE_CB)
> +		if (t == GC_IDLE_CB) {
>  			sbi->gc_mode = GC_IDLE_CB;
> -		else if (t == GC_IDLE_GREEDY)
> +		} else if (t == GC_IDLE_GREEDY) {
>  			sbi->gc_mode = GC_IDLE_GREEDY;
> -		else
> +		} else if (t == GC_IDLE_AT) {
> +			if (!sbi->am.atgc_enabled)
> +				return -EINVAL;
> +			sbi->gc_mode = GC_AT;
> +		} else {
>  			sbi->gc_mode = GC_NORMAL;
> +		}
>  		return count;
>  	}
> 
> -- 
> 2.26.2
> 

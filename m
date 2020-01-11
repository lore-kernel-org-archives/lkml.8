Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7137C282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 18:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A487320866
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 18:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578765723;
	bh=xBwEHaQLQ7XFWxxFbQb0IlckhNDeBh4BgRorj+oDTlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yix+mcFb2vuXh2rq/h9e3gHfdRdtSBuTOaH9WLxPYGRhZp50q1zG5/8tMyC1EDunq
	 HtjpXEqnK57cfKTv22t0rI3jKSyGTNmJCV81/qCmFCo7XtVR5Lq8gX4JVVKBJnDpc/
	 6GG9TDJwULbShP1Y6mlxL/iLbDRJgR/sDAvwBaRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730696AbgAKSCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 13:02:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:54922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729957AbgAKSCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 13:02:02 -0500
Received: from localhost (c-98-234-77-170.hsd1.ca.comcast.net [98.234.77.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F8EB2084D;
        Sat, 11 Jan 2020 18:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578765721;
        bh=xBwEHaQLQ7XFWxxFbQb0IlckhNDeBh4BgRorj+oDTlA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xq5+AKirLc3je3FDEVhd/0s2iHNamGVxg9guhWHbXIMAueSMV4OEw3sRV4tHrBdiW
         UoQ7W5r63Bvt9MbFVFvwzCgj2IEVyGJVFcwMs5twXY7lwDOW9NW9DOEB9ZskgP63Gl
         PUVaPalbnbuhmFCmjjKEu37L1K7UDgt0mT19GdrE=
Date:   Sat, 11 Jan 2020 10:02:00 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [RFC PATCH v5] f2fs: support data compression
Message-ID: <20200111180200.GA36424@jaegeuk-macbookpro.roam.corp.google.com>
References: <c7035795-73b3-d832-948f-deb36213ba07@huawei.com>
 <20191231004633.GA85441@jaegeuk-macbookpro.roam.corp.google.com>
 <7a579223-39d4-7e51-c361-4aa592b2500d@huawei.com>
 <20200102181832.GA1953@jaegeuk-macbookpro.roam.corp.google.com>
 <20200102190003.GA7597@jaegeuk-macbookpro.roam.corp.google.com>
 <d51f0325-6879-9aa6-f549-133b96e3eef5@huawei.com>
 <94786408-219d-c343-70f2-70a2cc68dd38@huawei.com>
 <20200106181620.GB50058@jaegeuk-macbookpro.roam.corp.google.com>
 <20200110235214.GA25700@jaegeuk-macbookpro.roam.corp.google.com>
 <3776cb0b-4b18-ae0d-16a7-a591bec77a5e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3776cb0b-4b18-ae0d-16a7-a591bec77a5e@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/11, Chao Yu wrote:
> On 2020/1/11 7:52, Jaegeuk Kim wrote:
> > On 01/06, Jaegeuk Kim wrote:
> >> On 01/06, Chao Yu wrote:
> >>> On 2020/1/3 14:50, Chao Yu wrote:
> >>>> This works to me. Could you run fsstress tests on compressed root directory?
> >>>> It seems still there are some bugs.
> >>>
> >>> Jaegeuk,
> >>>
> >>> Did you mean running por_fsstress testcase?
> >>>
> >>> Now, at least I didn't hit any problem for normal fsstress case.
> >>
> >> Yup. por_fsstress
> > 
> > Please check https://github.com/jaegeuk/f2fs/commits/g-dev-test.
> > I've fixed
> > - truncation offset
> > - i_compressed_blocks and its lock coverage
> > - error handling
> > - etc
> 
> I changed as below, and por_fsstress stops panic the system.
> 
> Could you merge all these fixes into original patch?

Yup, let m roll up some early patches first once test results become good.

> 
> >From bb17d7d77fe0b8a3e3632a7026550800ab9609e9 Mon Sep 17 00:00:00 2001
> From: Chao Yu <yuchao0@huawei.com>
> Date: Sat, 11 Jan 2020 16:58:20 +0800
> Subject: [PATCH] f2fs: compress: fix f2fs_put_rpages_mapping()
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/compress.c | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> index 502cd0ddc2a7..5c6a31d84ce4 100644
> --- a/fs/f2fs/compress.c
> +++ b/fs/f2fs/compress.c
> @@ -74,18 +74,10 @@ static void f2fs_put_compressed_page(struct page *page)
>  }
> 
>  static void f2fs_drop_rpages(struct compress_ctx *cc,
> -		struct address_space *mapping, int len, bool unlock)
> +					int len, bool unlock)
>  {
>  	unsigned int i;
>  	for (i = 0; i < len; i++) {
> -		if (mapping) {
> -			pgoff_t start = start_idx_of_cluster(cc);
> -			struct page *page = find_get_page(mapping, start + i);
> -
> -			put_page(page);
> -			put_page(page);
> -			cc->rpages[i] = NULL;
> -		}
>  		if (!cc->rpages[i])
>  			continue;
>  		if (unlock)
> @@ -97,18 +89,25 @@ static void f2fs_drop_rpages(struct compress_ctx *cc,
> 
>  static void f2fs_put_rpages(struct compress_ctx *cc)
>  {
> -	f2fs_drop_rpages(cc, NULL, cc->cluster_size, false);
> +	f2fs_drop_rpages(cc, cc->cluster_size, false);
>  }
> 
>  static void f2fs_unlock_rpages(struct compress_ctx *cc, int len)
>  {
> -	f2fs_drop_rpages(cc, NULL, len, true);
> +	f2fs_drop_rpages(cc, len, true);
>  }
> 
>  static void f2fs_put_rpages_mapping(struct compress_ctx *cc,
> -				struct address_space *mapping, int len)
> +				struct address_space *mapping,
> +				pgoff_t start, int len)
>  {
> -	f2fs_drop_rpages(cc, mapping, len, false);
> +	int i;
> +	for (i = 0; i < len; i++) {
> +		struct page *page = find_get_page(mapping, start + i);
> +
> +		put_page(page);
> +		put_page(page);
> +	}
>  }
> 
>  static void f2fs_put_rpages_wbc(struct compress_ctx *cc,
> @@ -680,7 +679,8 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
> 
>  		if (!PageUptodate(page)) {
>  			f2fs_unlock_rpages(cc, i + 1);
> -			f2fs_put_rpages_mapping(cc, mapping, cc->cluster_size);
> +			f2fs_put_rpages_mapping(cc, mapping, start_idx,
> +					cc->cluster_size);
>  			f2fs_destroy_compress_ctx(cc);
>  			goto retry;
>  		}
> @@ -714,7 +714,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
>  unlock_pages:
>  	f2fs_unlock_rpages(cc, i);
>  release_pages:
> -	f2fs_put_rpages_mapping(cc, mapping, i);
> +	f2fs_put_rpages_mapping(cc, mapping, start_idx, i);
>  	f2fs_destroy_compress_ctx(cc);
>  	return ret;
>  }
> -- 
> 2.18.0.rc1
> 
> 
> 
> > 
> > One another fix in f2fs-tools as well.
> > https://github.com/jaegeuk/f2fs-tools
> > 
> >>
> >>>
> >>> Thanks,
> > .
> > 

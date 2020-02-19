Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C9A1C34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 603C724655
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582080570;
	bh=pOEc9MEZ6T3vljY0q9joT1dIPADh7c/sUtPf/8kggMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cTo6shrvBnCoU0ObN1G1nOsG2hWq/hdlQJbUbYbMaTElHjQWoTwbQjS4HMWfUXWfL
	 dwp8N4e6GTOThwJRzGMwRbhvxkaP/fw29WauFmbShMheoDoad6op7tXVhfl2wJGoz3
	 XqrPBy5G3syKBb71QjlIZoSOnKWTpurnFOdnZWRk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgBSCt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:49:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:33772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728027AbgBSCt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:49:29 -0500
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 858F824654;
        Wed, 19 Feb 2020 02:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582080568;
        bh=pOEc9MEZ6T3vljY0q9joT1dIPADh7c/sUtPf/8kggMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tkBphdEXciG/bwBiAOIIhSYPuMeHdIWO0uxMZpL3fzTZhoAR1aoCXZO/tH87u8s9U
         KPcA7GhWRjiysUMR0tEoGNPW/ip5Ngqm2Y0pywj2dgV8OA9GYlDt1gRcmo18BgvkWB
         Yij4dbl2lXpt1mvwI2Uo7AbpdKRdT54rsW7Hqq2k=
Date:   Tue, 18 Feb 2020 18:49:28 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 1/3] f2fs: avoid __GFP_NOFAIL in f2fs_bio_alloc
Message-ID: <20200219024928.GA96609@google.com>
References: <20200218102136.32150-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218102136.32150-1-yuchao0@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/18, Chao Yu wrote:
> __f2fs_bio_alloc() won't fail due to memory pool backend, remove unneeded
> __GFP_NOFAIL flag in __f2fs_bio_alloc().

It it safe for old kernels as well when thinking backports?

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/data.c | 12 ++++--------
>  fs/f2fs/f2fs.h |  2 +-
>  2 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index baf12318ec64..3a4ece26928c 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -54,17 +54,13 @@ static inline struct bio *__f2fs_bio_alloc(gfp_t gfp_mask,
>  	return bio_alloc_bioset(gfp_mask, nr_iovecs, &f2fs_bioset);
>  }
>  
> -struct bio *f2fs_bio_alloc(struct f2fs_sb_info *sbi, int npages, bool no_fail)
> +struct bio *f2fs_bio_alloc(struct f2fs_sb_info *sbi, int npages, bool noio)
>  {
> -	struct bio *bio;
> -
> -	if (no_fail) {
> +	if (noio) {
>  		/* No failure on bio allocation */
> -		bio = __f2fs_bio_alloc(GFP_NOIO, npages);
> -		if (!bio)
> -			bio = __f2fs_bio_alloc(GFP_NOIO | __GFP_NOFAIL, npages);
> -		return bio;
> +		return __f2fs_bio_alloc(GFP_NOIO, npages);
>  	}
> +
>  	if (time_to_inject(sbi, FAULT_ALLOC_BIO)) {
>  		f2fs_show_injection_info(sbi, FAULT_ALLOC_BIO);
>  		return NULL;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 5316ac3eacdf..65f569949d42 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3343,7 +3343,7 @@ void f2fs_destroy_checkpoint_caches(void);
>   */
>  int __init f2fs_init_bioset(void);
>  void f2fs_destroy_bioset(void);
> -struct bio *f2fs_bio_alloc(struct f2fs_sb_info *sbi, int npages, bool no_fail);
> +struct bio *f2fs_bio_alloc(struct f2fs_sb_info *sbi, int npages, bool noio);
>  int f2fs_init_bio_entry_cache(void);
>  void f2fs_destroy_bio_entry_cache(void);
>  void f2fs_submit_bio(struct f2fs_sb_info *sbi,
> -- 
> 2.18.0.rc1

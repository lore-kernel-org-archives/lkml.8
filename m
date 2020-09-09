Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA79C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 03:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E8EB21973
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 03:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599622086;
	bh=yzC3pCeyfI5uFIun3bqi6B7dO5+teVjviJKxlHi7g9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YIHhqoZ61mne2qMpIU9YKBooHfw6cboOp/S9TJUUV7jXVjFzunRbss0NxcE+TLBwL
	 SuXtGUuqZQPhE4R5jR3W+SvpgcY4r/GuunkjrdTut9IyGjvfeHM8bObe6sruVeFzdm
	 O3u0Hek5aa3LWWq2Q19OjlneyE06iyWK/knzSRj0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgIID2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 23:28:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:36164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbgIID2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 23:28:04 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37DCB20EDD;
        Wed,  9 Sep 2020 03:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599622083;
        bh=yzC3pCeyfI5uFIun3bqi6B7dO5+teVjviJKxlHi7g9g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJAKmp492OjH2PaDukesr862GMPGdJqtGH/Cb2DCicdFsGLJcT40D/dj58DQL46+v
         CFAKWJBacg906/jo17EUZ4aoCdu3CinvlsJeH023JxrsjUKtLcjWaLnBqKnjEu81Fo
         rDfThrbofVVxfxadvUNtGItHW2Mt1+lfK+yCCEQs=
Date:   Tue, 8 Sep 2020 20:28:02 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: clean up vm_map_ram() call
Message-ID: <20200909032802.GA3377963@google.com>
References: <20200909023634.3821423-1-daeho43@gmail.com>
 <4c8971ce-98b5-4675-8310-5e9af0a14bb6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c8971ce-98b5-4675-8310-5e9af0a14bb6@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09, Chao Yu wrote:
> On 2020/9/9 10:36, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> > 
> > Made f2fs_vmap() wrapper to handle vm_map_ram() stuff.
> > 
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> 
> LGTM,
> 
> I think it should be merged into original patch. :)
> 
> Maybe Jaeguek could help to do that.

Yeah, no worries. :)

> 
> Thanks,
> 
> > ---
> >   fs/f2fs/compress.c | 42 ++++++++++++++++++------------------------
> >   1 file changed, 18 insertions(+), 24 deletions(-)
> > 
> > diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
> > index 357303d8514b..7895186cc765 100644
> > --- a/fs/f2fs/compress.c
> > +++ b/fs/f2fs/compress.c
> > @@ -557,6 +557,20 @@ static void f2fs_compress_free_page(struct page *page)
> >   #define MAX_VMAP_RETRIES	3
> > +static void *f2fs_vmap(struct page **pages, unsigned int count)
> > +{
> > +	int i;
> > +	void *buf = NULL;
> > +
> > +	for (i = 0; i < MAX_VMAP_RETRIES; i++) {
> > +		buf = vm_map_ram(pages, count, -1);
> > +		if (buf)
> > +			break;
> > +		vm_unmap_aliases();
> > +	}
> > +	return buf;
> > +}
> > +
> >   static int f2fs_compress_pages(struct compress_ctx *cc)
> >   {
> >   	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
> > @@ -593,23 +607,13 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
> >   		}
> >   	}
> > -	for (i = 0; i < MAX_VMAP_RETRIES; i++) {
> > -		cc->rbuf = vm_map_ram(cc->rpages, cc->cluster_size, -1);
> > -		if (cc->rbuf)
> > -			break;
> > -		vm_unmap_aliases();
> > -	}
> > +	cc->rbuf = f2fs_vmap(cc->rpages, cc->cluster_size);
> >   	if (!cc->rbuf) {
> >   		ret = -ENOMEM;
> >   		goto out_free_cpages;
> >   	}
> > -	for (i = 0; i < MAX_VMAP_RETRIES; i++) {
> > -		cc->cbuf = vm_map_ram(cc->cpages, cc->nr_cpages, -1);
> > -		if (cc->cbuf)
> > -			break;
> > -		vm_unmap_aliases();
> > -	}
> > +	cc->cbuf = f2fs_vmap(cc->cpages, cc->nr_cpages);
> >   	if (!cc->cbuf) {
> >   		ret = -ENOMEM;
> >   		goto out_vunmap_rbuf;
> > @@ -728,23 +732,13 @@ void f2fs_decompress_pages(struct bio *bio, struct page *page, bool verity)
> >   			goto out_free_dic;
> >   	}
> > -	for (i = 0; i < MAX_VMAP_RETRIES; i++) {
> > -		dic->rbuf = vm_map_ram(dic->tpages, dic->cluster_size, -1);
> > -		if (dic->rbuf)
> > -			break;
> > -		vm_unmap_aliases();
> > -	}
> > +	dic->rbuf = f2fs_vmap(dic->tpages, dic->cluster_size);
> >   	if (!dic->rbuf) {
> >   		ret = -ENOMEM;
> >   		goto destroy_decompress_ctx;
> >   	}
> > -	for (i = 0; i < MAX_VMAP_RETRIES; i++) {
> > -		dic->cbuf = vm_map_ram(dic->cpages, dic->nr_cpages, -1);
> > -		if (dic->cbuf)
> > -			break;
> > -		vm_unmap_aliases();
> > -	}
> > +	dic->cbuf = f2fs_vmap(dic->cpages, dic->nr_cpages);
> >   	if (!dic->cbuf) {
> >   		ret = -ENOMEM;
> >   		goto out_vunmap_rbuf;
> > 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

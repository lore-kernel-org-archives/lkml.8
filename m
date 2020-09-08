Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F01CC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 15:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD5E229C6
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 15:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbgIHPfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 11:35:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:33484 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730393AbgIHPYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:24:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9FC06AD1E;
        Tue,  8 Sep 2020 11:37:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1018B1E1325; Tue,  8 Sep 2020 13:37:45 +0200 (CEST)
Date:   Tue, 8 Sep 2020 13:37:45 +0200
From:   Jan Kara <jack@suse.cz>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Boqun Feng <boqun.feng@gmail.com>,
        Yuqi Jin <jinyuqi@huawei.com>
Subject: Re: [PATCH RESEND] fs: Move @f_count to different cacheline with
 @f_mode
Message-ID: <20200908113745.GA4070@quack2.suse.cz>
References: <1592987548-8653-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592987548-8653-1-git-send-email-zhangshaokun@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 24-06-20 16:32:28, Shaokun Zhang wrote:
> get_file_rcu_many, which is called by __fget_files, has used
> atomic_try_cmpxchg now and it can reduce the access number of the global
> variable to improve the performance of atomic instruction compared with
> atomic_cmpxchg. 
> 
> __fget_files does check the @f_mode with mask variable and will do some
> atomic operations on @f_count, but both are on the same cacheline.
> Many CPU cores do file access and it will cause much conflicts on @f_count. 
> If we could make the two members into different cachelines, it shall relax
> the siutations.

<snip nice unixbench results>

Thanks for the patch! The wins for your microbenchmark heavily sharing
struct file are nice but I'm not sure your change is a universal win. When
struct file is not shared (which is far more common), hot code paths like
__fget() or __fget_light() will now need to fetch two cache lines from
struct file instead of one. So I don't think that for most users the
tradeoff is really worth it...

								Honza

> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 3f881a892ea7..0faeab5622fb 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -955,7 +955,6 @@ struct file {
>  	 */
>  	spinlock_t		f_lock;
>  	enum rw_hint		f_write_hint;
> -	atomic_long_t		f_count;
>  	unsigned int 		f_flags;
>  	fmode_t			f_mode;
>  	struct mutex		f_pos_lock;
> @@ -979,6 +978,7 @@ struct file {
>  	struct address_space	*f_mapping;
>  	errseq_t		f_wb_err;
>  	errseq_t		f_sb_err; /* for syncfs */
> +	atomic_long_t		f_count;
>  } __randomize_layout
>    __attribute__((aligned(4)));	/* lest something weird decides that 2 is OK */
>  
> -- 
> 2.7.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BF4C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11BDA2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586897880;
	bh=BBKaYlIjH81DUlBwwxmMyjGo3d8JBG5QNSGH9c0REEg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=X1wHVqnz4dSpUoYE5+fVEtPiJsjbyMLlROEL/t03menD3OelrTOw59qtBO5y4vYXJ
	 +APZbe19y2xIVsusWd3tlh950eSP+9kAjkRBaYhA39czr1MbTvbw8eMvIDA7xV9kRJ
	 jQvH27QOHeI6HZpdnmnh0AThL05lXOs/Xux5KkWs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633510AbgDNU55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:57:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633482AbgDNU4p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:56:45 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4839120644;
        Tue, 14 Apr 2020 20:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586897804;
        bh=BBKaYlIjH81DUlBwwxmMyjGo3d8JBG5QNSGH9c0REEg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=A3kNqvQd7nwiKw3MNOI4MiR63Kmtcee046VFmXCFTC5Rk12jAQD8Eb7EkFZDaNgKb
         v3Q0ZQJYNr+F5nD23dBHh8tBC0QVNrclacTj0mxlAbWufMX/CsnfLJO6sV/bokoLVP
         61gSOxYJY8mpBYCMX9G031XTIEkb8OpOqLjQSF7g=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1D8A7352286D; Tue, 14 Apr 2020 13:56:44 -0700 (PDT)
Date:   Tue, 14 Apr 2020 13:56:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     dave@stgolabs.net, josh@joshtriplett.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH-next] locktorture: use true, false for bool variable
Message-ID: <20200414205644.GS17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <1586779379-103799-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586779379-103799-1-git-send-email-zou_wei@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 08:02:59PM +0800, Zou Wei wrote:
> Fixes coccicheck warning:
> 
> kernel/locking/locktorture.c:689:6-10: WARNING: Assignment of 0/1 to bool variable
> kernel/locking/locktorture.c:907:2-20: WARNING: Assignment of 0/1 to bool variable
> kernel/locking/locktorture.c:938:3-20: WARNING: Assignment of 0/1 to bool variable
> kernel/locking/locktorture.c:668:2-19: WARNING: Assignment of 0/1 to bool variable
> kernel/locking/locktorture.c:674:2-19: WARNING: Assignment of 0/1 to bool variable
> kernel/locking/locktorture.c:634:2-20: WARNING: Assignment of 0/1 to bool variable
> kernel/locking/locktorture.c:640:2-20: WARNING: Assignment of 0/1 to bool variable
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Applied, thank you!

							Thanx, Paul

> ---
>  kernel/locking/locktorture.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index 5efbfc6..8ff6f50 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -631,13 +631,13 @@ static int lock_torture_writer(void *arg)
>  		cxt.cur_ops->writelock();
>  		if (WARN_ON_ONCE(lock_is_write_held))
>  			lwsp->n_lock_fail++;
> -		lock_is_write_held = 1;
> +		lock_is_write_held = true;
>  		if (WARN_ON_ONCE(lock_is_read_held))
>  			lwsp->n_lock_fail++; /* rare, but... */
>  
>  		lwsp->n_lock_acquired++;
>  		cxt.cur_ops->write_delay(&rand);
> -		lock_is_write_held = 0;
> +		lock_is_write_held = false;
>  		cxt.cur_ops->writeunlock();
>  
>  		stutter_wait("lock_torture_writer");
> @@ -665,13 +665,13 @@ static int lock_torture_reader(void *arg)
>  			schedule_timeout_uninterruptible(1);
>  
>  		cxt.cur_ops->readlock();
> -		lock_is_read_held = 1;
> +		lock_is_read_held = true;
>  		if (WARN_ON_ONCE(lock_is_write_held))
>  			lrsp->n_lock_fail++; /* rare, but... */
>  
>  		lrsp->n_lock_acquired++;
>  		cxt.cur_ops->read_delay(&rand);
> -		lock_is_read_held = 0;
> +		lock_is_read_held = false;
>  		cxt.cur_ops->readunlock();
>  
>  		stutter_wait("lock_torture_reader");
> @@ -686,7 +686,7 @@ static int lock_torture_reader(void *arg)
>  static void __torture_print_stats(char *page,
>  				  struct lock_stress_stats *statp, bool write)
>  {
> -	bool fail = 0;
> +	bool fail = false;
>  	int i, n_stress;
>  	long max = 0, min = statp ? statp[0].n_lock_acquired : 0;
>  	long long sum = 0;
> @@ -904,7 +904,7 @@ static int __init lock_torture_init(void)
>  
>  	/* Initialize the statistics so that each run gets its own numbers. */
>  	if (nwriters_stress) {
> -		lock_is_write_held = 0;
> +		lock_is_write_held = false;
>  		cxt.lwsa = kmalloc_array(cxt.nrealwriters_stress,
>  					 sizeof(*cxt.lwsa),
>  					 GFP_KERNEL);
> @@ -935,7 +935,7 @@ static int __init lock_torture_init(void)
>  		}
>  
>  		if (nreaders_stress) {
> -			lock_is_read_held = 0;
> +			lock_is_read_held = false;
>  			cxt.lrsa = kmalloc_array(cxt.nrealreaders_stress,
>  						 sizeof(*cxt.lrsa),
>  						 GFP_KERNEL);
> -- 
> 2.6.2
> 

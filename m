Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F403C2D0F0
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AFBF20675
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585610707;
	bh=CW5W2odPF+X6jORiftGFOScxeCEkL8MSvWI5irb+e0o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=xJFNrM/YecuALebMMLXx/wQrK4TD4ylH01kQlSweYsIyKGMgNeuzRHXn/reC6qr0s
	 NuVyup4ovKeBZZPZ9aMq9TA++DNDCHWwvtBcHy+8hg+wR/2xUvhX9A3AKA1PbBJTxd
	 uHwqy/h242LW4UdBfpH5QQVRzQOF8f2ZQS4AkUUM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbgC3XZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729360AbgC3XZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:25:06 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6597D20733;
        Mon, 30 Mar 2020 23:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585610705;
        bh=CW5W2odPF+X6jORiftGFOScxeCEkL8MSvWI5irb+e0o=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=S3uI88bTqKZzYLy91vMNO4bJJddG5wvwNkFYadqaAnLjdYEI1HOJpNNh5J3gcaMC/
         fy1/ClnNa5Z/pAnSs+HlhN4Krzrb31JVlXehWbfGMx2Gtay+NQuLppE85lYZHzvlAq
         ydJTWEGKQA5K4jY4Ot9epYlD8hijT2IaSAolkQW8=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3A1E43523140; Mon, 30 Mar 2020 16:25:05 -0700 (PDT)
Date:   Mon, 30 Mar 2020 16:25:05 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Maddie Stone <maddiestone@google.com>,
        Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 08/21] Revert "list: Use WRITE_ONCE() when
 initializing list_head structures"
Message-ID: <20200330232505.GD19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200324153643.15527-1-will@kernel.org>
 <20200324153643.15527-9-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324153643.15527-9-will@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 03:36:30PM +0000, Will Deacon wrote:
> This reverts commit 2f073848c3cc8aff2655ab7c46d8c0de90cf4e50.
> 
> There is no need to use WRITE_ONCE() to initialise a non-RCU 'list_head'.
> 
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Will Deacon <will@kernel.org>

And attention to lockless uses of list_empty() here, correct?

Depending on the outcome of discussions on 3/21, I should have added in
all three cases.

							Thanx, Paul

> ---
>  include/linux/list.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/list.h b/include/linux/list.h
> index c7331c259792..b86a3f9465d4 100644
> --- a/include/linux/list.h
> +++ b/include/linux/list.h
> @@ -32,7 +32,7 @@
>   */
>  static inline void INIT_LIST_HEAD(struct list_head *list)
>  {
> -	WRITE_ONCE(list->next, list);
> +	list->next = list;
>  	list->prev = list;
>  }
>  
> -- 
> 2.20.1
> 

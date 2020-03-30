Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB45CC2D0F1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BA1420774
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 23:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585611152;
	bh=8b5HIjf7fUEp9ElalKXw7B8EDu2hSeQR4NS2umfR6BM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=yWiKlf7PuMtkzYmBrs8+QEbatJGaoUXMpD+UF0+3Pgz4GmoyLW36aLuOE61TyoQCP
	 nrpAf4gyhJ2dBm1jGMxSEYnohIzFgwF2jotw8iTuDgXnVCYe4AtEn/WLW/m6ytFPoH
	 lFziaNeW/i1HJ8Q3o6l7tjptqGK/PPAvQeuI43VA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729363AbgC3Xcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 19:32:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:38352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728537AbgC3Xca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 19:32:30 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FB7D20771;
        Mon, 30 Mar 2020 23:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585611150;
        bh=8b5HIjf7fUEp9ElalKXw7B8EDu2hSeQR4NS2umfR6BM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BluPqwgNhvMqV0zGuT57PqZr56rwdmxMcr223hkonDn0I00AwCaitFsFBKt+pixN1
         H5Y0OX22+SWSMcTL2Sy6fy1bGjEsc9r2fLGJVdwQ+phFxc9eQYhqmX0g5N8FjzQawb
         Xyv5YxqNpj2JfF7xMU6P2QQdCn8rpY1GaG1ybH3c=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E81093523140; Mon, 30 Mar 2020 16:32:29 -0700 (PDT)
Date:   Mon, 30 Mar 2020 16:32:29 -0700
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
Subject: Re: [RFC PATCH 12/21] list: Poison ->next pointer for non-RCU
 deletion of 'hlist_nulls_node'
Message-ID: <20200330233229.GG19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200324153643.15527-1-will@kernel.org>
 <20200324153643.15527-13-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324153643.15527-13-will@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 03:36:34PM +0000, Will Deacon wrote:
> hlist_nulls_del() is used for non-RCU deletion of an 'hlist_nulls_node'
> and so we can safely poison the ->next pointer without having to worry
> about concurrent readers, just like we do for other non-RCU list
> deletion primitives
> 
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Will Deacon <will@kernel.org>

Agreed, any code having difficulty with this change should use instead
hlist_nulls_del_rcu().

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/list_nulls.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/list_nulls.h b/include/linux/list_nulls.h
> index fd154ceb5b0d..48f33ae16381 100644
> --- a/include/linux/list_nulls.h
> +++ b/include/linux/list_nulls.h
> @@ -99,6 +99,7 @@ static inline void __hlist_nulls_del(struct hlist_nulls_node *n)
>  static inline void hlist_nulls_del(struct hlist_nulls_node *n)
>  {
>  	__hlist_nulls_del(n);
> +	n->next = LIST_POISON1;
>  	n->pprev = LIST_POISON2;
>  }
>  
> -- 
> 2.20.1
> 

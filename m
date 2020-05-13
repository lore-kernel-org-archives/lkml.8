Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBD2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 22:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F22B2065C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 22:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589409715;
	bh=TctJClh3bXeDVJJ2/6XxJRe2TCYoY13ybyBMQN9qnE0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ZpgmsZDjNAY43j1VRqr3/i50q1fiSolyyYJqWoesZ5dx15Z2Im/uUE1DnBkMcSm1y
	 LLKamVrl9RrWH7iiSpVuF1nq7n/bT7cC2oh1InnD7egRaSW2sVtWt8uztj5YjwdtBv
	 UQ8ibGkYk6MXO5wM6LqRX6Hs0Z8yVngzY9tv3JOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731421AbgEMWly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 18:41:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:57256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726383AbgEMWly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 18:41:54 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC876204EF;
        Wed, 13 May 2020 22:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589409713;
        bh=TctJClh3bXeDVJJ2/6XxJRe2TCYoY13ybyBMQN9qnE0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=fl9UdENus+D7MZ+ZWOYQt3WzKVKDuSrjbfB4Tqf+0cOEyHqJ7neqle4od9Iph3oJL
         r0YVIBMrHAqBdl6hwWutkFUnF7ZMLBFD9T8mgmyIWkx2RW3Qx4ANbcK0ATB52j3Onw
         Ngo8UF84Ui+ooaMVUQQI6qpp3dpBS9PKD/3SQyvQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 26799352352C; Wed, 13 May 2020 15:41:53 -0700 (PDT)
Date:   Wed, 13 May 2020 15:41:53 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org
Subject: Re: [PATCH 11/11] rcu: constify sysrq_key_op
Message-ID: <20200513224153.GB2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200513214351.2138580-1-emil.l.velikov@gmail.com>
 <20200513214351.2138580-11-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513214351.2138580-11-emil.l.velikov@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 10:43:51PM +0100, Emil Velikov wrote:
> With earlier commits, the API no longer discards the const-ness of the
> sysrq_key_op. As such we can add the notation.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: rcu@vger.kernel.org
> Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>
> ---
> Please keep me in the CC list, as I'm not subscribed to the list.
> 
> IMHO it would be better if this gets merged this via the tty tree.

Works for me:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/tree_stall.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index 119ed6afd20f..4e6ed7b91f59 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -729,7 +729,7 @@ static void sysrq_show_rcu(int key)
>  	show_rcu_gp_kthreads();
>  }
>  
> -static struct sysrq_key_op sysrq_rcudump_op = {
> +static const struct sysrq_key_op sysrq_rcudump_op = {
>  	.handler = sysrq_show_rcu,
>  	.help_msg = "show-rcu(y)",
>  	.action_msg = "Show RCU tree",
> -- 
> 2.25.1
> 

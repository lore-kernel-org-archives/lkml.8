Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1021C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 16:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89A872074D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 16:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgFMQlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 12:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgFMQlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 12:41:53 -0400
X-Greylist: delayed 2610 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 13 Jun 2020 09:41:52 PDT
Received: from smtp.tuxdriver.com (tunnel92311-pt.tunnel.tserv13.ash1.ipv6.he.net [IPv6:2001:470:7:9c9::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A0966C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 09:41:52 -0700 (PDT)
Received: from 2606-a000-111b-4634-0000-0000-0000-1bf2.inf6.spectrum.com ([2606:a000:111b:4634::1bf2] helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1jk8XY-0002Cu-MZ; Sat, 13 Jun 2020 11:57:55 -0400
Date:   Sat, 13 Jun 2020 11:57:51 -0400
From:   Neil Horman <nhorman@tuxdriver.com>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Vlad Yasevich <vyasevich@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanxzhang@fudan.edu.cn, kjlu@umn.edu,
        Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH] sctp: Fix sk_buff leak when receiving a datagram
Message-ID: <20200613155751.GA161691@hmswarspite.think-freely.org>
References: <1592051965-94731-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592051965-94731-1-git-send-email-xiyuyang19@fudan.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 08:39:25PM +0800, Xiyu Yang wrote:
> In sctp_skb_recv_datagram(), the function fetch a sk_buff object from
> the receiving queue to "skb" by calling skb_peek() or __skb_dequeue()
> and return its reference to the caller.
> 
> However, when calling __skb_dequeue() successfully, the function forgets
> to hold a reference count of the "skb" object and directly return it,
> causing a potential memory leak in the caller function.
> 
> Fix this issue by calling refcount_inc after __skb_dequeue()
> successfully executed.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
>  net/sctp/socket.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> index d57e1a002ffc..4c8f0b83efd0 100644
> --- a/net/sctp/socket.c
> +++ b/net/sctp/socket.c
> @@ -8990,6 +8990,8 @@ struct sk_buff *sctp_skb_recv_datagram(struct sock *sk, int flags,
>  				refcount_inc(&skb->users);
>  		} else {
>  			skb = __skb_dequeue(&sk->sk_receive_queue);
> +			if (skb)
> +				refcount_inc(&skb->users);
For completeness, you should probably use skb_get here, rather than refcount_inc
directly.

Also, I'm not entirely sure I see how a memory leak can happen here.  we take an
extra reference in the skb_peek clause of this code area because if we return an
skb that continues to exist on the sk_receive_queue list, we legitimately have
two users for the skb (the user who called sctp_skb_recv_datagram(...,MSG_PEEK),
and the potential next caller who will actually dequeue the skb.

In the else clause however, that condition doesn't exist.  the user count for
the skb should alreday be 1, if the caller is the only user of the skb), or more
than 1, if 1 or more callers have gotten a reference to the message using
MSG_PEEK.

I don't think this code is needed, and in fact will actually cause memory leaks,
because theres no subsequent skb_unref call to drop refcount that you are adding
here.

Neil

>  		}
>  
>  		if (skb)
> -- 
> 2.7.4
> 
> 

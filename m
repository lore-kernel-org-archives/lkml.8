Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBE0C43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 17:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 343B82075A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 17:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599412821;
	bh=gY0MbL1YxNuEnkMuu3vubZVNy3OOd3AYpKVyrrMY72s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RlqvD2LFiNv/Vu+v8e47CBYbMUPsKYpbH/3SxdSpM1tgqZmdvETd+oU8tfNFQQ6dT
	 s76X7YYELtSPvYBeofXhRL33lZxSKZja7R734FyL9Y0+LKb+k62/O/+/rJ7RAQ9qn0
	 O7I9fNWrBekH2rlrUR3OC0Ngg45VjsvmweRqi4VY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgIFRUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 13:20:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgIFRUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 13:20:15 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 132E520709;
        Sun,  6 Sep 2020 17:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599412815;
        bh=gY0MbL1YxNuEnkMuu3vubZVNy3OOd3AYpKVyrrMY72s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aij6baaKG0nixHhLci5OgaZ/ZqJ11xCeBozFrig23KcdyETOBY3CfnRwUjkTuqZ+A
         T+NHpXd91Q06JNC15sGETUTpwgl/qeHTP/KfEpqEupZo7ne1g9K9yFepVb4zqAEgM/
         7arZV7LqyDVJORsf6hD5BQn/EnQAefuuX6CY01Mc=
Date:   Sun, 6 Sep 2020 10:20:13 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Wang Hai <wanghai38@huawei.com>,
        David Miller <davem@davemloft.net>,
        John Ogness <john.ogness@linutronix.de>,
        Mao Wenan <maowenan@huawei.com>, jrosen@cisco.com,
        Arnd Bergmann <arnd@arndb.de>,
        Colin King <colin.king@canonical.com>,
        Eric Dumazet <edumazet@google.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] net/packet: Remove unused macro BLOCK_PRIV
Message-ID: <20200906102013.7b7553cf@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <CA+FuTSfWP+=Lm8h_PLNsrAaV5s-ACbS=YMBqjy=UpCuDEMhzKA@mail.gmail.com>
References: <20200905085058.68312-1-wanghai38@huawei.com>
        <CA+FuTSfWP+=Lm8h_PLNsrAaV5s-ACbS=YMBqjy=UpCuDEMhzKA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Sep 2020 11:15:05 +0200 Willem de Bruijn wrote:
> On Sat, Sep 5, 2020 at 10:53 AM Wang Hai <wanghai38@huawei.com> wrote:
> >
> > BLOCK_PRIV is never used after it was introduced.
> > So better to remove it.
> >
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Wang Hai <wanghai38@huawei.com>  
> 
> Acked-by: Willem de Bruijn <willemb@google.com>

Applied, thanks!

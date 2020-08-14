Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740BBC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 20:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54A2C2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 20:55:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgHNUz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 16:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgHNUz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 16:55:28 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926F5C061385;
        Fri, 14 Aug 2020 13:55:28 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B0516127471E4;
        Fri, 14 Aug 2020 13:38:41 -0700 (PDT)
Date:   Fri, 14 Aug 2020 13:55:26 -0700 (PDT)
Message-Id: <20200814.135526.430805159179452727.davem@davemloft.net>
To:     fazilyildiran@gmail.com
Cc:     kuba@kernel.org, courtney.cavin@sonymobile.com,
        bjorn.andersson@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dvyukov@google.com, elver@google.com,
        andreyknvl@google.com, glider@google.com, necip@google.com,
        syzbot+f31428628ef672716ea8@syzkaller.appspotmail.com
Subject: Re: [PATCH] net: qrtr: fix usage of idr in port assignment to
 socket
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200814101000.2463612-1-fazilyildiran@gmail.com>
References: <20200814101000.2463612-1-fazilyildiran@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 14 Aug 2020 13:38:42 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Necip Fazil Yildiran <fazilyildiran@gmail.com>
Date: Fri, 14 Aug 2020 10:10:00 +0000

> diff --git a/net/qrtr/qrtr.c b/net/qrtr/qrtr.c
> index b4c0db0b7d31..52d0707df776 100644
> --- a/net/qrtr/qrtr.c
> +++ b/net/qrtr/qrtr.c
> @@ -693,22 +693,24 @@ static void qrtr_port_remove(struct qrtr_sock *ipc)
>  static int qrtr_port_assign(struct qrtr_sock *ipc, int *port)
>  {
>  	int rc;
> +	u32 min_port;

Please use reverse christmas tree ordering for local variables.

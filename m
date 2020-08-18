Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F84C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 497052076E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgHRTpa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 15:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgHRTpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:45:19 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AC2C061389;
        Tue, 18 Aug 2020 12:45:19 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 91896127A25A1;
        Tue, 18 Aug 2020 12:28:32 -0700 (PDT)
Date:   Tue, 18 Aug 2020 12:45:17 -0700 (PDT)
Message-Id: <20200818.124517.1912943894802724387.davem@davemloft.net>
To:     linmiaohe@huawei.com
Cc:     kuba@kernel.org, edumazet@google.com, kafai@fb.com, ast@kernel.org,
        jakub@cloudflare.com, zhang.lin16@zte.com.cn,
        keescook@chromium.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: Avoid strcmp current->comm with warncomm when
 warned >= 5
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200818114132.17510-1-linmiaohe@huawei.com>
References: <20200818114132.17510-1-linmiaohe@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 18 Aug 2020 12:28:32 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaohe Lin <linmiaohe@huawei.com>
Date: Tue, 18 Aug 2020 07:41:32 -0400

> @@ -417,7 +417,7 @@ static void sock_warn_obsolete_bsdism(const char *name)
>  {
>  	static int warned;
>  	static char warncomm[TASK_COMM_LEN];
> -	if (strcmp(warncomm, current->comm) && warned < 5) {
> +	if (warned < 5 && strcmp(warncomm, current->comm)) {
>  		strcpy(warncomm,  current->comm);
>  		pr_warn("process `%s' is using obsolete %s SO_BSDCOMPAT\n",
>  			warncomm, name);

We've been warning about SO_BSDCOMPAT usage for almost 20 years, I think
we can remove this code completely now.

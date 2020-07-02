Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09C7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 00:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9793120748
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 00:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgGBAnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 20:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgGBAnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 20:43:43 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C8EC08C5C1;
        Wed,  1 Jul 2020 17:43:43 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6CD3A14E50EC7;
        Wed,  1 Jul 2020 17:43:42 -0700 (PDT)
Date:   Wed, 01 Jul 2020 17:43:41 -0700 (PDT)
Message-Id: <20200701.174341.468821653864668258.davem@davemloft.net>
To:     danny@kdrag0n.dev
Cc:     jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sched: Allow changing default qdisc to FQ-PIE
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200701230152.445957-1-danny@kdrag0n.dev>
References: <20200701230152.445957-1-danny@kdrag0n.dev>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 01 Jul 2020 17:43:42 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Danny Lin <danny@kdrag0n.dev>
Date: Wed,  1 Jul 2020 16:01:52 -0700

> Similar to fq_codel and the other qdiscs that can set as default,
> fq_pie is also suitable for general use without explicit configuration,
> which makes it a valid choice for this.
> 
> This is useful in situations where a painless out-of-the-box solution
> for reducing bufferbloat is desired but fq_codel is not necessarily the
> best choice. For example, fq_pie can be better for DASH streaming, but
> there could be more cases where it's the better choice of the two simple
> AQMs available in the kernel.
> 
> Signed-off-by: Danny Lin <danny@kdrag0n.dev>

Applied to net-next, thank you.

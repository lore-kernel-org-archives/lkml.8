Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F54C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D2DD20780
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 01:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgGABhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 21:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbgGABhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 21:37:00 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25821C061755;
        Tue, 30 Jun 2020 18:37:00 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F240A128107E6;
        Tue, 30 Jun 2020 18:36:58 -0700 (PDT)
Date:   Tue, 30 Jun 2020 18:36:58 -0700 (PDT)
Message-Id: <20200630.183658.1733479085086002611.davem@davemloft.net>
To:     dan.carpenter@oracle.com
Cc:     bjorn.andersson@linaro.org, manivannan.sadhasivam@linaro.org,
        kuba@kernel.org, wenhu.wang@vivo.com, wgong@codeaurora.org,
        cjhuang@codeaurora.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net] net: qrtr: Fix an out of bounds read
 qrtr_endpoint_post()
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200630114615.GA21891@mwanda>
References: <20200628104623.GA3357@Mani-XPS-13-9360>
        <20200630114615.GA21891@mwanda>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 30 Jun 2020 18:36:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 30 Jun 2020 14:46:15 +0300

> This code assumes that the user passed in enough data for a
> qrtr_hdr_v1 or qrtr_hdr_v2 struct, but it's not necessarily true.  If
> the buffer is too small then it will read beyond the end.
> 
> Reported-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reported-by: syzbot+b8fe393f999a291a9ea6@syzkaller.appspotmail.com
> Fixes: 194ccc88297a ("net: qrtr: Support decoding incoming v2 packets")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied and queued up for -stable, thanks Dan.

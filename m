Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5AAC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB2120678
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 17:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbgDIRJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 13:09:26 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:33206 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgDIRJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 13:09:26 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B2B67128C125F;
        Thu,  9 Apr 2020 10:09:25 -0700 (PDT)
Date:   Thu, 09 Apr 2020 10:09:25 -0700 (PDT)
Message-Id: <20200409.100925.1802925797170855675.davem@davemloft.net>
To:     wenhu.wang@vivo.com
Cc:     kuba@kernel.org, bjorn.andersson@linaro.org, wgong@codeaurora.org,
        allison@lohutok.net, willemb@google.com, arnd@arndb.de,
        johannes.berg@intel.com, cjhuang@codeaurora.org,
        tglx@linutronix.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@vivo.com
Subject: Re: [PATCH v3] net: qrtr: send msgs from local of same id as
 broadcast
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200409025414.19376-1-wenhu.wang@vivo.com>
References: <20200409025414.19376-1-wenhu.wang@vivo.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 09 Apr 2020 10:09:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Wenhu <wenhu.wang@vivo.com>
Date: Wed,  8 Apr 2020 19:53:53 -0700

> If the local node id(qrtr_local_nid) is not modified after its
> initialization, it equals to the broadcast node id(QRTR_NODE_BCAST).
> So the messages from local node should not be taken as broadcast
> and keep the process going to send them out anyway.
> 
> The definitions are as follow:
> static unsigned int qrtr_local_nid = NUMA_NO_NODE;
> #define QRTR_NODE_BCAST	0xffffffffu
> 
> Fixes: commit fdf5fd397566 ("net: qrtr: Broadcast messages only from control port")
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>

Please do not put the word "commit" in your Fixes: tag in the future,
it does not belong there.

Applied and queued up for -stable, thanks.

Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45C8C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865302487D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 17:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbgDFRZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 13:25:32 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57424 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgDFRZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 13:25:31 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 58CD015DA6725;
        Mon,  6 Apr 2020 10:25:30 -0700 (PDT)
Date:   Mon, 06 Apr 2020 10:25:29 -0700 (PDT)
Message-Id: <20200406.102529.1213420746741832154.davem@davemloft.net>
To:     decui@microsoft.com
Cc:     willy@infradead.org, netdev@vger.kernel.org, willemb@google.com,
        kuba@kernel.org, simon.horman@netronome.com, sdf@google.com,
        edumazet@google.com, fw@strlen.de, jonathan.lemon@gmail.com,
        pablo@netfilter.org, rdunlap@infradead.org, jeremy@azazel.net,
        pabeni@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net] skbuff.h: Improve the checksum related comments
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1586138364-71127-1-git-send-email-decui@microsoft.com>
References: <1586138364-71127-1-git-send-email-decui@microsoft.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 06 Apr 2020 10:25:31 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com>
Date: Sun,  5 Apr 2020 18:59:24 -0700

> Fixed the punctuation and some typos.
> Improved some sentences with minor changes.
> 
> No change of semantics or code.
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Applied, thanks.

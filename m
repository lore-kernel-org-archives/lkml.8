Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8783EC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CE420658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 22:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732774AbgCPWES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 18:04:18 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48548 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732709AbgCPWER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 18:04:17 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C9A10156D3FE7;
        Mon, 16 Mar 2020 15:04:16 -0700 (PDT)
Date:   Mon, 16 Mar 2020 15:04:16 -0700 (PDT)
Message-Id: <20200316.150416.703162062113777580.davem@davemloft.net>
To:     wei.zheng@vivo.com
Cc:     catalin.marinas@arm.com, will@kernel.org, jdmason@kudzu.us,
        yeyunfeng@huawei.com, guohanjun@huawei.com, tglx@linutronix.de,
        info@metux.net, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        kernel@vivo.com, wenhu.wang@vivo.com
Subject: Re: [PATCH] net: vxge: fix wrong __VA_ARGS__ usage
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200316142354.95201-1-wei.zheng@vivo.com>
References: <20200316142354.95201-1-wei.zheng@vivo.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 16 Mar 2020 15:04:17 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zheng Wei <wei.zheng@vivo.com>
Date: Mon, 16 Mar 2020 22:23:47 +0800

> printk in macro vxge_debug_ll uses __VA_ARGS__ without "##" prefix,
> it causes a build error when there is no variable 
> arguments(e.g. only fmt is specified.).
> 
> Signed-off-by: Zheng Wei <wei.zheng@vivo.com>

Does this even happen right now?  Anyways, applied.

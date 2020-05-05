Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC56C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 21:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41C95206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 21:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729316AbgEEVYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 17:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728660AbgEEVYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 17:24:41 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC4CC061A0F;
        Tue,  5 May 2020 14:24:40 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 682151281606D;
        Tue,  5 May 2020 14:24:40 -0700 (PDT)
Date:   Tue, 05 May 2020 14:24:39 -0700 (PDT)
Message-Id: <20200505.142439.1075452616982863931.davem@davemloft.net>
To:     bhsharma@redhat.com
Cc:     netdev@vger.kernel.org, bhupesh.linux@gmail.com,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        aelior@marvell.com, GR-everest-linux-l2@marvell.com,
        manishc@marvell.com
Subject: Re: [PATCH 1/2] net: qed*: Reduce RX and TX default ring count
 when running inside kdump kernel
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1588705481-18385-2-git-send-email-bhsharma@redhat.com>
References: <1588705481-18385-1-git-send-email-bhsharma@redhat.com>
        <1588705481-18385-2-git-send-email-bhsharma@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 05 May 2020 14:24:40 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhupesh Sharma <bhsharma@redhat.com>
Date: Wed,  6 May 2020 00:34:40 +0530

> -#define NUM_RX_BDS_DEF		((u16)BIT(10) - 1)
> +#define NUM_RX_BDS_DEF		((is_kdump_kernel()) ? ((u16)BIT(6) - 1) : ((u16)BIT(10) - 1))

These parenthesis are very excessive and unnecessary.  At the
very least remove the parenthesis around is_kdump_kernel().

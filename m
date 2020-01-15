Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4F5C33C9E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 02:32:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50C724671
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 02:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgAOCcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 21:32:02 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:51600 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728862AbgAOCcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 21:32:02 -0500
Received: from localhost (unknown [8.46.75.2])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 39FFA158087E3;
        Tue, 14 Jan 2020 18:31:48 -0800 (PST)
Date:   Tue, 14 Jan 2020 18:31:38 -0800 (PST)
Message-Id: <20200114.183138.2165891554137732877.davem@davemloft.net>
To:     niu_xilei@163.com
Cc:     tglx@linutronix.de, fw@strlen.de, peterz@infradead.org,
        steffen.klassert@secunet.com, bigeasy@linutronix.de,
        jonathan.lemon@gmail.com, pabeni@redhat.com,
        anshuman.khandual@arm.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v4] pktgen: Allow configuration of IPv6 source address range
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200114031229.8569-1-niu_xilei@163.com>
References: <20200114031229.8569-1-niu_xilei@163.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 14 Jan 2020 18:32:01 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niu Xilei <niu_xilei@163.com>
Date: Tue, 14 Jan 2020 11:12:29 +0800

> Pktgen can use only one IPv6 source address from output device or src6
> command setting. In pressure test we need create lots of sessions more
> than 65535. So add src6_min and src6_max command to set the range.
> 
> Signed-off-by: Niu Xilei <niu_xilei@163.com>

Applied to net-next.

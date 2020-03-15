Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87F4C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 07:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EFB2205C9
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 07:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727732AbgCOHlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 03:41:49 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:36146 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727238AbgCOHlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 03:41:49 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 629C7141C8E5E;
        Sun, 15 Mar 2020 00:41:48 -0700 (PDT)
Date:   Sun, 15 Mar 2020 00:41:47 -0700 (PDT)
Message-Id: <20200315.004147.1120686648335353500.davem@davemloft.net>
To:     bay@hackerdom.ru
Cc:     oliver@neukum.org, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cdc_ncm: Fix the build warning
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200314053324.197745-1-bay@hackerdom.ru>
References: <20200314053324.197745-1-bay@hackerdom.ru>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 15 Mar 2020 00:41:48 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Bersenev <bay@hackerdom.ru>
Date: Sat, 14 Mar 2020 10:33:24 +0500

> The ndp32->wLength is two bytes long, so replace cpu_to_le32 with cpu_to_le16.
> 
> Signed-off-by: Alexander Bersenev <bay@hackerdom.ru>

Applied, thank you.

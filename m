Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FA4C0044D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 03:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFC8F2074A
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 03:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgCNDn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 23:43:58 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:48504 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgCNDn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 23:43:58 -0400
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7E99E15A1577C;
        Fri, 13 Mar 2020 20:43:57 -0700 (PDT)
Date:   Fri, 13 Mar 2020 20:43:54 -0700 (PDT)
Message-Id: <20200313.204354.1099710416713347967.davem@davemloft.net>
To:     bay@hackerdom.ru
Cc:     oliver@neukum.org, gregkh@linuxfoundation.org, info@metux.net,
        tglx@linutronix.de, kstewart@linuxfoundation.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] cdc_ncm: Implement the 32-bit version of NCM
 Transfer Block
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200313213823.178435-1-bay@hackerdom.ru>
References: <20200313213823.178435-1-bay@hackerdom.ru>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 13 Mar 2020 20:43:57 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Bersenev <bay@hackerdom.ru>
Date: Sat, 14 Mar 2020 02:38:20 +0500

> The NCM specification defines two formats of transfer blocks: with 16-bit
> fields (NTB-16) and with 32-bit fields (NTB-32). Currently only NTB-16 is
> implemented.
> 
> This patch adds the support of NTB-32. The motivation behind this is that
> some devices such as E5785 or E5885 from the current generation of Huawei
> LTE routers do not support NTB-16. The previous generations of Huawei
> devices are also use NTB-32 by default.
> 
> Also this patch enables NTB-32 by default for Huawei devices.
> 
> During the 2019 ValdikSS made five attempts to contact Huawei to add the
> NTB-16 support to their router firmware, but they were unsuccessful.
> 
> Signed-off-by: Alexander Bersenev <bay@hackerdom.ru>

This patch is already in my net-next tree.

You need to submit the follow-up fix all by itself, relative to my
net-next GIT tree.

You must always post patches against the GIT tree that your change
is targetting, that way you will avoid situations like this.

Thank you.

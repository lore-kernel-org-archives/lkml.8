Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EBAC47247
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D5521835
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:51:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgEFCvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 22:51:08 -0400
Received: from ozlabs.org ([203.11.71.1]:39119 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgEFCvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 22:51:07 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49H1Ld6Wwmz9sT5; Wed,  6 May 2020 12:51:05 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 43c8a496fa37187b54f7df71fb8262acc6bf6200
In-Reply-To: <1588154448-56759-1-git-send-email-wangxiongfeng2@huawei.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, <geoff@infradead.org>,
        <benh@kernel.crashing.org>, <paulus@samba.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/ps3: Move static keyword to the front of declaration
Message-Id: <49H1Ld6Wwmz9sT5@ozlabs.org>
Date:   Wed,  6 May 2020 12:51:05 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-04-29 at 10:00:48 UTC, Xiongfeng Wang wrote:
> Move the static keyword to the front of declaration of 'vuart_bus_priv',
> and resolve the following compiler warning that can be seen when
> building with warnings enabled (W=1):
> 
> drivers/ps3/ps3-vuart.c:867:1: warning: ‘static’ is not at beginning of declaration [-Wold-style-declaration]
>  } static vuart_bus_priv;
>  ^
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/43c8a496fa37187b54f7df71fb8262acc6bf6200

cheers

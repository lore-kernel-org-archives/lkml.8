Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2727AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06EC6206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgENTrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728079AbgENTrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 15:47:06 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDC58C061A0C;
        Thu, 14 May 2020 12:47:05 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 3AF94128CF126;
        Thu, 14 May 2020 12:47:03 -0700 (PDT)
Date:   Thu, 14 May 2020 12:47:00 -0700 (PDT)
Message-Id: <20200514.124700.630104670938763588.davem@davemloft.net>
To:     kuba@kernel.org
Cc:     wenhu.wang@vivo.com, elder@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@vivo.com
Subject: Re: [PATCH] drivers: ipa: use devm_kzalloc for simplicity
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200514101516.0b2ccda2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20200514035520.2162-1-wenhu.wang@vivo.com>
        <20200514101516.0b2ccda2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 14 May 2020 12:47:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 14 May 2020 10:15:16 -0700

> On Wed, 13 May 2020 20:55:20 -0700 Wang Wenhu wrote:
>> Make a substitution of kzalloc with devm_kzalloc to simplify the
>> ipa_probe() process.
>> 
>> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> 
> The code is perfectly fine as is. What problem are you trying to solve?

I agree, these kinds of transformations are kind of excessive.

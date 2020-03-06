Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0BAC3F2D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD3102073D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 02:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgCFCI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 21:08:26 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:58762 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgCFCI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 21:08:26 -0500
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7FCE11581B2D3;
        Thu,  5 Mar 2020 18:08:25 -0800 (PST)
Date:   Thu, 05 Mar 2020 18:08:23 -0800 (PST)
Message-Id: <20200305.180823.1274906337509861200.davem@davemloft.net>
To:     sfr@canb.auug.org.au
Cc:     sameo@linux.intel.com, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        johannes@sipsolutions.net
Subject: Re: linux-next: the nfc-next tree seems to be old
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200306104825.068268eb@canb.auug.org.au>
References: <20200130105538.7b07b150@canb.auug.org.au>
        <20200306104825.068268eb@canb.auug.org.au>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 05 Mar 2020 18:08:25 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 6 Mar 2020 10:48:25 +1100

> On Thu, 30 Jan 2020 10:55:38 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi Samuel,
>> 
>> I noticed that the nfc-next tree has not changed since June 2018 and
>> has been orphaned in May 2019, so am wondering if the commits in it are
>> still relevant or should I just remove the tree from linux-next.
> 
> Since I have had no response, I will remove it tomorrow.

We've been integrating NFC patches directly into my networking tree for
a while now, so this is indeed the thing to do.

Thanks.

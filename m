Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C39C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 07:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 659B320734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 07:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbgFBH33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 03:29:29 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:65091 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgFBH32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 03:29:28 -0400
Received: from [10.193.177.142] (arunbr.asicdesigners.com [10.193.177.142] (may be forged))
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 0527TG6D030367;
        Tue, 2 Jun 2020 00:29:17 -0700
Cc:     ayush.sawal@asicdesigners.com,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the net-next tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
References: <20200602091249.66601c4c@canb.auug.org.au>
From:   Ayush Sawal <ayush.sawal@chelsio.com>
Message-ID: <8a8bc5f4-2dc3-5e2c-3013-51954004594c@chelsio.com>
Date:   Tue, 2 Jun 2020 13:01:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200602091249.66601c4c@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen & David,

On 6/2/2020 4:42 AM, Stephen Rothwell wrote:
> Hi all,
>
> In commit
>
>    055be6865dea ("Crypto/chcr: Fixes a coccinile check error")
>
> Fixes tag
>
>    Fixes: 567be3a5d227 ("crypto:
>
> has these problem(s):
>
>    - Subject has leading but no trailing parentheses
>    - Subject has leading but no trailing quotes
>
> Please do not split Fixes tags over more than one line.

I am so sorry for this mistake.
Is there a way to fix this?

Thanks,
Ayush




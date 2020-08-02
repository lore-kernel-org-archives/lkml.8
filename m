Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B516FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 07:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9346F2075A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 07:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgHBHbm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 03:31:42 -0400
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:56824 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725850AbgHBHbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 03:31:41 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=wenan.mao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U4Spuqd_1596353498;
Received: from B-W105MD6R-2041.local(mailfrom:wenan.mao@linux.alibaba.com fp:SMTPD_---0U4Spuqd_1596353498)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 02 Aug 2020 15:31:39 +0800
Subject: Re: [PATCH -next v2] virtio_net: Avoid loop in virtnet_poll
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200802003818-mutt-send-email-mst@kernel.org>
 <1596347793-55894-1-git-send-email-wenan.mao@linux.alibaba.com>
 <20200802022549-mutt-send-email-mst@kernel.org>
From:   maowenan <wenan.mao@linux.alibaba.com>
Message-ID: <6543a874-7f2f-ea73-8c24-b75788ea6379@linux.alibaba.com>
Date:   Sun, 2 Aug 2020 15:31:38 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200802022549-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/2/20 2:26 PM, Michael S. Tsirkin wrote:
> 
> Just noticed the subject is wrong: this is no longer
> a virtio_net patch.

thanks, I will change the subject and send v3.

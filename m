Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C2E2C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3712206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732939AbgGVUqg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 16:46:36 -0400
Received: from smtprelay0032.hostedemail.com ([216.40.44.32]:55562 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726452AbgGVUqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 16:46:36 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 2D8AB1D6A0374;
        Wed, 22 Jul 2020 20:46:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: vase54_4e01a1326f39
X-Filterd-Recvd-Size: 1999
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 22 Jul 2020 20:46:33 +0000 (UTC)
Message-ID: <8721f64a3150e1e5c4813738f470443297ef1cdd.camel@perches.com>
Subject: Re: [PATCH v2] net-sysfs: add a newline when printing 'tx_timeout'
 by sysfs
From:   Joe Perches <joe@perches.com>
To:     David Miller <davem@davemloft.net>, stephen@networkplumber.org
Cc:     wangxiongfeng2@huawei.com, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 22 Jul 2020 13:46:32 -0700
In-Reply-To: <20200722.132311.31388808811810422.davem@davemloft.net>
References: <1595314977-57991-1-git-send-email-wangxiongfeng2@huawei.com>
         <20200721.153632.1416164807029507588.davem@davemloft.net>
         <20200722082741.1675d611@hermes.lan>
         <20200722.132311.31388808811810422.davem@davemloft.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-22 at 13:23 -0700, David Miller wrote:
> From: Stephen Hemminger <stephen@networkplumber.org>
> Date: Wed, 22 Jul 2020 08:27:41 -0700
> 
> > On Tue, 21 Jul 2020 15:36:32 -0700 (PDT)
> > David Miller <davem@davemloft.net> wrote:
> > 
> >> From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> >> Date: Tue, 21 Jul 2020 15:02:57 +0800
> >> 
> >> > When I cat 'tx_timeout' by sysfs, it displays as follows. It's better to
> >> > add a newline for easy reading.
> >> > 
> >> > root@syzkaller:~# cat /sys/devices/virtual/net/lo/queues/tx-0/tx_timeout
> >> > 0root@syzkaller:~#
> >> > 
> >> > Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>  
> >> 
> >> Applied, thank you.
> > 
> > Could you add
> 
> Stephen, of all people you should know by now that all of my commits
> are %100 immutable.  So commit log changes cannot be made after I've
> applied the patch, ever.

Maybe it's time to use git notes?



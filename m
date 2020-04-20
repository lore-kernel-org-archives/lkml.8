Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69619C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 512602071C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 18:00:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgDTSAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 14:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgDTSAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 14:00:07 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C099C061A0C;
        Mon, 20 Apr 2020 11:00:07 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 13619127D1E53;
        Mon, 20 Apr 2020 11:00:03 -0700 (PDT)
Date:   Mon, 20 Apr 2020 11:00:00 -0700 (PDT)
Message-Id: <20200420.110000.944435201264166335.davem@davemloft.net>
To:     xiangxia.m.yue@gmail.com
Cc:     syzbot+7ef50afd3a211f879112@syzkaller.appspotmail.com,
        dev@openvswitch.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, pshelar@ovn.org,
        syzkaller-bugs@googlegroups.com, yihung.wei@gmail.com
Subject: Re: [PATCH] net: openvswitch: ovs_ct_exit to be done under ovs_lock
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1587063451-54027-1-git-send-email-xiangxia.m.yue@gmail.com>
References: <000000000000e642a905a0cbee6e@google.com>
        <1587063451-54027-1-git-send-email-xiangxia.m.yue@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 20 Apr 2020 11:00:03 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xiangxia.m.yue@gmail.com
Date: Fri, 17 Apr 2020 02:57:31 +0800

> From: Tonghao Zhang <xiangxia.m.yue@gmail.com>
> 
> syzbot wrote:
 ...
> To avoid that warning, invoke the ovs_ct_exit under ovs_lock and add
> lockdep_ovsl_is_held as optional lockdep expression.
> 
> Link: https://lore.kernel.org/lkml/000000000000e642a905a0cbee6e@google.com
> Fixes: 11efd5cb04a1 ("openvswitch: Support conntrack zone limit")
> Cc: Pravin B Shelar <pshelar@ovn.org> 
> Cc: Yi-Hung Wei <yihung.wei@gmail.com>
> Reported-by: syzbot+7ef50afd3a211f879112@syzkaller.appspotmail.com
> Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>

Applied and queued up for -stable, thanks.

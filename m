Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB51FC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C71FF206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgCMBpC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 21:45:02 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:33468 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726194AbgCMBpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 21:45:02 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1jCZNL-00086Z-QQ; Fri, 13 Mar 2020 02:44:35 +0100
Date:   Fri, 13 Mar 2020 02:44:35 +0100
From:   Florian Westphal <fw@strlen.de>
To:     syzbot <syzbot+68a8ed58e3d17c700de5@syzkaller.appspotmail.com>
Cc:     coreteam@netfilter.org, davem@davemloft.net, fw@strlen.de,
        hdanton@sina.com, jbenc@redhat.com, kadlec@blackhole.kfki.hu,
        linux-kernel@vger.kernel.org, moshe@mellanox.com,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        pablo@netfilter.org, sd@queasysnail.net,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Subject: Re: WARNING in geneve_exit_batch_net (2)
Message-ID: <20200313014435.GY979@breakpoint.cc>
References: <0000000000000ea4b4059fb33201@google.com>
 <000000000000c7979105a0a311f6@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000c7979105a0a311f6@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+68a8ed58e3d17c700de5@syzkaller.appspotmail.com> wrote:
> syzbot has bisected this bug to:
> 
> commit 4e645b47c4f000a503b9c90163ad905786b9bc1d
> Author: Florian Westphal <fw@strlen.de>
> Date:   Thu Nov 30 23:21:02 2017 +0000
> 
>     netfilter: core: make nf_unregister_net_hooks simple wrapper again

No idea why this turns up, the reproducer doesn't hit any of these code
paths.

The debug splat is a false-positive; ndo_stop/list_del hasn't run yet.
I will send a fix for net tree.

Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DADC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09F9720738
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgG0Ti5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgG0Ti5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 15:38:57 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD68C061794;
        Mon, 27 Jul 2020 12:38:57 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BF56C1276E442;
        Mon, 27 Jul 2020 12:22:09 -0700 (PDT)
Date:   Mon, 27 Jul 2020 12:38:54 -0700 (PDT)
Message-Id: <20200727.123854.863832576284265842.davem@davemloft.net>
To:     lkp@intel.com
Cc:     bkkarthik@pesu.pes.edu, jmaloy@redhat.com, ying.xue@windriver.com,
        kuba@kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        kbuild-all@lists.01.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net: tipc: fix general protection fault in
 tipc_conn_delete_sub
From:   David Miller <davem@davemloft.net>
In-Reply-To: <202007272337.Rd2io2fw%lkp@intel.com>
References: <20200727131057.7a3of3hhsld4ng5t@pesu.pes.edu>
        <202007272337.Rd2io2fw%lkp@intel.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 27 Jul 2020 12:22:10 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kernel test robot <lkp@intel.com>
Date: Mon, 27 Jul 2020 23:52:50 +0800

> All warnings (new ones prefixed by >>):
> 
>    net/tipc/topsrv.c: In function 'tipc_conn_send_to_sock':
>>> net/tipc/topsrv.c:259:10: warning: 'return' with a value, in function returning void [-Wreturn-type]
>      259 |   return -EINVAL;
>          |          ^
>    net/tipc/topsrv.c:247:13: note: declared here
>      247 | static void tipc_conn_send_to_sock(struct tipc_conn *con)
>          |             ^~~~~~~~~~~~~~~~~~~~~~

Please look at the compiler output when you submit changes.

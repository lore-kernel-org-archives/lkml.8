Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650A2C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 462C72072D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 22:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgDUWor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 18:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725850AbgDUWor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 18:44:47 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D4AC0610D5;
        Tue, 21 Apr 2020 15:44:47 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B3557128E927C;
        Tue, 21 Apr 2020 15:44:46 -0700 (PDT)
Date:   Tue, 21 Apr 2020 15:44:46 -0700 (PDT)
Message-Id: <20200421.154446.751452614071821376.davem@davemloft.net>
To:     jslaby@suse.cz
Cc:     kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, zeil@yandex-team.ru,
        khlebnikov@yandex-team.ru
Subject: Re: [PATCH] cgroup, netclassid: remove double cond_resched
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200420070424.5694-1-jslaby@suse.cz>
References: <20200420070424.5694-1-jslaby@suse.cz>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 21 Apr 2020 15:44:47 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Slaby <jslaby@suse.cz>
Date: Mon, 20 Apr 2020 09:04:24 +0200

> Commit 018d26fcd12a ("cgroup, netclassid: periodically release file_lock
> on classid") added a second cond_resched to write_classid indirectly by
> update_classid_task. Remove the one in write_classid.
> 
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Applied, thanks Jiri.

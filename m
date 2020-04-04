Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A43EC4332B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 15:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C304206E6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 15:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586015573;
	bh=4H9E3gSuaSn9uvkor1QWgps9xa/Z1XpQlQv7xa0Zgvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KG8QJ3SPcYH2Ib2drUvBhzdJyBaspLFHcNelap1wYGAE4m1cYkK8Azlzp3F9SQwZV
	 DLW1iXOPwUfrNzk0y/1bFbGNPicdWWfJ1f3JLZpY1TXGawcgQQjEjFwuMDCtpOLvFB
	 HSReNidK/mSragr5Lt4qKIM0g+173jRXyakfLja8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgDDPww (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 11:52:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgDDPww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 11:52:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1464B206E6;
        Sat,  4 Apr 2020 15:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586015571;
        bh=4H9E3gSuaSn9uvkor1QWgps9xa/Z1XpQlQv7xa0Zgvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P2KHYR5dHl0VliFsumjMid349+Sxr5PqUgBgdbfynunDxuc7rZVIYrDV8i/wSX0En
         YtZCD9pdP5pQ1s8EF6w+I2qvd1oXzgRwryuq0ak3hCFVFPxPaAqCPFAjAJcXP5r2nx
         D4qdNGjUMrlsunYcL3wH6kX1tm4IQY/cnmqh7gk8=
Date:   Sat, 4 Apr 2020 17:52:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Taehee Yoo <ap420073@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, rafael@kernel.org,
        j.vosburgh@gmail.com, vfalico@gmail.com, andy@greyhouse.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        mitch.a.williams@intel.com
Subject: Re: [PATCH net v2 3/3] net: core: avoid warning in
 dev_change_net_namespace()
Message-ID: <20200404155247.GE1476305@kroah.com>
References: <20200404141922.26492-1-ap420073@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200404141922.26492-1-ap420073@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 04, 2020 at 02:19:22PM +0000, Taehee Yoo wrote:
> When interface's namespace is being changed, dev_change_net_namespace()
> is called. This removes and re-allocates many resources that include
> sysfs files. The "/net/class/net/<interface name>" is one of them.
> If the sysfs creation routine(device_rename()) found duplicate sysfs
> file name, it warns about it and fails. But unfortunately, at that point,
> dev_change_net_namespace() doesn't return fail because rollback cost
> is too high.
> So, the interface can't have a sysfs file.

Why don't you check for a duplicate namespace before you do anything
like mess with sysfs?  Wouldn't that be the correct thing instead of
trying to paper over the issue by having sysfs be the thing to tell you
not to do this or not?

> The approach of this patch is to find the duplicate sysfs file as
> fast as possible. If it found that, dev_change_net_namespace() returns
> fail immediately with zero rollback cost.

Don't rely on sysfs to save you from this race condition, it's not the
way to do it at all.

greg k-h

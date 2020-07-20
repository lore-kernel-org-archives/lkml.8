Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A28AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02DEF2177B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgGTBw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 21:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgGTBw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 21:52:27 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5D2C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 18:52:27 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxKyS-00GFpV-2E; Mon, 20 Jul 2020 01:52:12 +0000
Date:   Mon, 20 Jul 2020 02:52:12 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jianyong Wu <jianyong.wu@arm.com>
Cc:     ericvh@gmail.com, hch@lst.de, dhowells@redhat.com,
        lucho@ionkov.net, asmadeus@codewreck.org,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Kaly.Xin@arm.com, justin.he@arm.com, wei.chen@arm.com
Subject: Re: [RFC PATCH 0/2] vfs:9p: fix open-unlink-fstat bug
Message-ID: <20200720015212.GN2786714@ZenIV.linux.org.uk>
References: <20200720014622.37364-1-jianyong.wu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720014622.37364-1-jianyong.wu@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 09:46:20AM +0800, Jianyong Wu wrote:
> how to reproduce:
> in 9p guest:
> 
> struct stat *statbuf;
> int fd;
> 
> fd = open("tmp", O_RDWR);
> unlink("tmp");
> fstat(fd, statbuf);
> 
> fstat will fail as "tmp" in 9p server side has been removed. 9p server
> can't retrieve the file context as the guest has not passed it down.
> so we should pass the file info down in 9p guest in getattr op.
> it need add a new file member in "struct kstat" as "struct istat" does.

Er... what struct istat?

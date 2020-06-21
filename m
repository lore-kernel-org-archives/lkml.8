Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B9EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 13:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FAEE2477D
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 13:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbgFUN4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 09:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729649AbgFUN4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 09:56:39 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0EFC061794;
        Sun, 21 Jun 2020 06:56:39 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 51A05C01D; Sun, 21 Jun 2020 15:56:38 +0200 (CEST)
Date:   Sun, 21 Jun 2020 15:56:23 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Alexander Kapshuk <alexander.kapshuk@gmail.com>
Cc:     lucho@ionkov.net, ericvh@gmail.com, davem@davemloft.net,
        kuba@kernel.org, v9fs-developer@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/9p: Validate current->sighand in client.c
Message-ID: <20200621135623.GA20810@nautica>
References: <20200621084512.GA720@nautica>
 <20200621135312.78201-1-alexander.kapshuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200621135312.78201-1-alexander.kapshuk@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Kapshuk wrote on Sun, Jun 21, 2020:
> Fix rcu not being dereferenced cleanly by using the task
> helpers (un)lock_task_sighand instead of spin_lock_irqsave and
> spin_unlock_irqrestore to ensure current->sighand is a valid pointer as
> suggested in the email referenced below.

Ack.
I'll take this once symbol issue is resolved ; thanks for your time.

-- 
Dominique

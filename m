Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57488C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3437E2467F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgBZLVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:21:44 -0500
Received: from ms.lwn.net ([45.79.88.28]:34376 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbgBZLVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:21:44 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 803B26D9;
        Wed, 26 Feb 2020 11:21:42 +0000 (UTC)
Date:   Wed, 26 Feb 2020 04:21:37 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: fix filesystems/porting.rst whitespace
Message-ID: <20200226042137.05e9ead3@lwn.net>
In-Reply-To: <20200225165954.GA11763@cisco>
References: <20200220214009.11645-1-tycho@tycho.ws>
        <20200225032028.2bda9de8@lwn.net>
        <20200225165954.GA11763@cisco>
Organization: LWN.net
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020 09:59:54 -0700
Tycho Andersen <tycho@tycho.ws> wrote:

> > So I don't see that problem in my builds, and it doesn't show in the
> > version on kernel.org either.  What version of sphinx are you running?  
> 
> It's actually the default vim syntax highlighter that gets confused in
> my case,

So this is actually a vim bug, then, right?

Thanks,

jon

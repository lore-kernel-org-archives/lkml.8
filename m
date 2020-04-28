Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538D7C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B7CA20746
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 16:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588091111;
	bh=OfzuQfCr95V52OJ0ynUHWXMas+ESmMauGDE883x1Bok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XFLth00FFrEpmPIdSIy+r+QpTlO1ZzRmhO99DjZXySC8aDRUd0idYi5Ulaavijxp1
	 HSySycetUKgiVkIKHGJFKzI58wpG/5a8XaEKq7qvyGJhldlxSx7iNaUSXAuUc3d7aj
	 fS13hLqwHvqH6sLA0ZCcyKQEiGAfXE+dXFnjSqP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgD1QZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 12:25:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:43394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727920AbgD1QZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 12:25:10 -0400
Received: from linux-8ccs.fritz.box (p3EE2CE96.dip0.t-ipconnect.de [62.226.206.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A65A206D8;
        Tue, 28 Apr 2020 16:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588091109;
        bh=OfzuQfCr95V52OJ0ynUHWXMas+ESmMauGDE883x1Bok=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gMjWzoDa4nFQZBB9EN5J1uwi75ghkxF7M4Aru0k1+9JBSbD5YiUY7ixisqmdNNmdP
         +/IaMJB0obmdWB9vYrQLHTmjuHS9ewBCWv1jERNvvdYAGcIpeYy2Ud2BYCJJlB/uFb
         TqVgTgbwwpWbFXpZBJkALYZgFrK5anTqVX+yT7Pw=
Date:   Tue, 28 Apr 2020 18:25:05 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Joe Lawrence <joe.lawrence@redhat.com>
Subject: Re: [PATCH v3 09/10] module: Remove module_disable_ro()
Message-ID: <20200428162505.GA12860@linux-8ccs.fritz.box>
References: <cover.1587812518.git.jpoimboe@redhat.com>
 <33089a8ffb2e724cecfa51d72887ae9bf70354f9.1587812518.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <33089a8ffb2e724cecfa51d72887ae9bf70354f9.1587812518.git.jpoimboe@redhat.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Josh Poimboeuf [25/04/20 06:07 -0500]:
>module_disable_ro() has no more users.  Remove it.
>
>Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
>Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Hm, I guess this means we can also remove the module_enable_ro() stubs
in module.h and make it a static function again (like the other
module_enable_* functions) as there are no more outside users. I have to
remind myself after this patchset is merged :-)

Jessica

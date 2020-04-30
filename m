Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B074FC8300C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EAA4207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588245039;
	bh=TsI/BKu4593Rcdqo2h9eyVYN7ozdDVL7qnI3d8BKDU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QcRNgiNTvygP5IzR7GAE8tuBCLIs5FU30B6HxKylm6iNw7PGNsiQaFklHqy5ri+6A
	 m2BOp9RHCVB9Glf6hm1I9Z8EgQyHponFoZbOoipAl+v+vpe21EDEmEbLlpWl5zhzzj
	 zy4oYHI2pPXUyeKGpv6N/EIHKzzSO4CQ5cByKvC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgD3LKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:10:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgD3LKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:10:38 -0400
Received: from linux-8ccs (p3EE2CE96.dip0.t-ipconnect.de [62.226.206.150])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A00A720757;
        Thu, 30 Apr 2020 11:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588245038;
        bh=TsI/BKu4593Rcdqo2h9eyVYN7ozdDVL7qnI3d8BKDU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MajYZnwnuJZ0SVyD/k1pSZHgRImpw5nnRSW6P/xXqhY5QZ/+JDyC15wZg1g4tz6KQ
         cQbjatF9k2NZjv5y3isq/a+Y+ycEKGf96HBNBdKXjIOan8imCt7H3ED+H2mwzPPAU8
         +2anzj0vlveaQHM0xhMJHk8lGNwcw46rcm7LIwOQ=
Date:   Thu, 30 Apr 2020 13:10:33 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH v4 11/11] module: Make module_enable_ro() static again
Message-ID: <20200430111032.GA4436@linux-8ccs>
References: <cover.1588173720.git.jpoimboe@redhat.com>
 <d8b705c20aee017bf9a694c0462a353d6a9f9001.1588173720.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <d8b705c20aee017bf9a694c0462a353d6a9f9001.1588173720.git.jpoimboe@redhat.com>
X-OS:   Linux linux-8ccs 4.12.14-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Josh Poimboeuf [29/04/20 10:24 -0500]:
>Now that module_enable_ro() has no more external users, make it static
>again.
>
>Suggested-by: Jessica Yu <jeyu@kernel.org>
>Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Thanks! Since this patch is separate from the rest and it's based on
modules-next, I can just take this last patch through the modules tree.

Jessica

Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFFEC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 650DA20663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KCXMH0Xm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgEGMi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725857AbgEGMi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:38:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CE4C05BD43;
        Thu,  7 May 2020 05:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=x7a5h9WTqM4yCISP3EIHuRz1Lfgk3lAikosybsy34bY=; b=KCXMH0XmVUixlNhtZMZxdwknCs
        ML6pWmj7ff8v0hRpx8nT+Cb1Tvu/mo14l44obO31K1Nl3zqMHdLGz/K2DNmIzkZLMO7o9rGtQ/naq
        R+IGa3V8jLe2OPthTdKVtf/qv/cU67vk9MoQqtAxjfLF/dkdXYdMf/3sLEjzp2JYwPhqdC95d+JP9
        tsSnP2ucjFM4N/+UmVmR9NPlI5P3tSKDd5hzkolU6Tnj0WhoRnBJBfVvaTDstQOIpkRBFIYK34H8A
        V6ZWE+fBG0fjbNZvbnqlrqWpoW2RFYWLWgotJShKI5wQFj9qCQDJagxxpP2qv4JGS7CqXueYe8I2J
        0QRAAmYw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWfnj-0004CD-Uu; Thu, 07 May 2020 12:38:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E57C53012DC;
        Thu,  7 May 2020 14:38:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C7C982013428F; Thu,  7 May 2020 14:38:52 +0200 (CEST)
Date:   Thu, 7 May 2020 14:38:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Julien Thierry <jthierry@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86 <x86@kernel.org>
Subject: Re: [tip: objtool/core] objtool: Make handle_insn_ops() unconditional
Message-ID: <20200507123852.GB3762@hirez.programming.kicks-ass.net>
References: <20200428191659.795115188@infradead.org>
 <158835734130.8414.1839500420306776239.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158835734130.8414.1839500420306776239.tip-bot2@tip-bot2>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 06:22:21PM -0000, tip-bot2 for Peter Zijlstra wrote:
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index 068897d..6591c2d 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2259,6 +2259,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
>  				return 0;
>  		}
>  
> +		if (handle_insn_ops(insn, &state))
> +			return 1;
> +
>  		switch (insn->type) {
>  
>  		case INSN_RETURN:

Fun question; when an instruction has both a hint and ops, who should
win? I'm currently in that situation and I'd like the hint to win, but
is that 'right' ?

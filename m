Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E14C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09AEE2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597321634;
	bh=ZM05qRl9adziUioNGZnH/EmQXZxVRnO2i+z+DS6i7Ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0LqqaFYTv6kMhRjrSJdhDQ+C85k2bmAAoWLVaSMHqWoigk2GcjLw8u1WNlJPhVEeN
	 Gp2suXBPcWkJkY7dhES50SsVelLJONw323QAiijbGYDJj2ogX8XV8vlPxB2CqUC8VA
	 l1w1yUvBER1fyHJ+EJxAtnPWPH8DWHive/XMoEWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgHMM1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 08:27:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:36564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgHMM1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 08:27:00 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47D0F2078D;
        Thu, 13 Aug 2020 12:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597321619;
        bh=ZM05qRl9adziUioNGZnH/EmQXZxVRnO2i+z+DS6i7Ls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nJYX7dkcQTFxiM/2cXeixc3cYc/nKpu49W5ozAharvesMrU1Ao9W3nZEPCOjuLjyh
         Um98qJSTHHy5rJcWHMvIxHxkQghAZbaVUrh+BlDmz5BIz5u6ci23tizczciFBvwSko
         bqAmh90fbOktdhuK4drQpWWZTPDV6KH+A1Boh91Y=
Date:   Thu, 13 Aug 2020 13:26:55 +0100
From:   Will Deacon <will@kernel.org>
To:     Huang Shijie <sjhuang@iluvatar.ai>
Cc:     peterz@infradead.org, mingo@redhat.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation/locking/locktypes: fix the typo
Message-ID: <20200813122654.GA10180@willie-the-truck>
References: <20200813060220.18199-1-sjhuang@iluvatar.ai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813060220.18199-1-sjhuang@iluvatar.ai>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 02:02:20PM +0800, Huang Shijie wrote:
> We have three categories locks, not two.
> 
> Signed-off-by: Huang Shijie <sjhuang@iluvatar.ai>
> ---
>  Documentation/locking/locktypes.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/locking/locktypes.rst b/Documentation/locking/locktypes.rst
> index 1b577a8bf982..4cefed8048ca 100644
> --- a/Documentation/locking/locktypes.rst
> +++ b/Documentation/locking/locktypes.rst
> @@ -10,7 +10,7 @@ Introduction
>  ============
>  
>  The kernel provides a variety of locking primitives which can be divided
> -into two categories:
> +into three categories:
>  
>   - Sleeping locks
>   - CPU local locks

Acked-by: Will Deacon <will@kernel.org>

Will

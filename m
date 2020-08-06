Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B16C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C923206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9FGsIsd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgHFTEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgHFTEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:04:52 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1407C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 12:04:51 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id l23so22209860edv.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 12:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OAu2FsIdT/Af1bgzbaks/MsaryD2Qq0m1XVOnruTc4Q=;
        b=s9FGsIsduvqKTkJ/8xJSIxfu6td51/sCQXrBUcEK6b7KZh45voFJqxOwxaco8tqxuJ
         LGyFkpMw1gaQfns1E7m7hk1G5TgptBIpXrTo2v8SqH/qxx9R4EvIuoDUkmsBZcY4qoW9
         GPc29A5a5El8jN89jD5jcqi1mZH6onO/0OtyJLdCwyMa96Xi1KYOCp0rll8pF98kJEef
         ZmJKyCTHpT9DLy6rtqH0p1au+h9RTSMkqMasszcnFmCDX6ROd99IRWin00lW45fc3SRA
         4/AB6klEVrNE6uvsO4GsHCX4JEXXVLTX1VIT7SItRpzygKt9gowhCAcI2hI2X2yBSGaQ
         mFvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OAu2FsIdT/Af1bgzbaks/MsaryD2Qq0m1XVOnruTc4Q=;
        b=qPuYvF6iX8sFNN5Y99mkblVXDGfHbjXtVcbPERNGaYqZZCPMgvlTeZYRZJiVCsDL3p
         Vg+3+9mIIaEZDRkNEcwWLEaMJzU9vPMrWveppRsNRr/cZQ+ubBRrcYvuG27slzat5BuB
         IB6VA0vskPfNWpoDItSq/E4b8RWxPvylfyuamFQlSuDY51eWnUqJHG/iXHSoT9afBZ9C
         zOd5dsp+Wqm+b5kqJASUQE3QaLLthdIA0jvACPkqCQgaDFcc+Pw3eBg+EMpZDdDgGMiN
         8wANAuFmAfqJRs0EFLjWP3WtsJOsCdj2VvnG1xe4dzlFME32cl2utZ2MxQ6oUvDA3x+W
         1xlA==
X-Gm-Message-State: AOAM5319Y4V+9gTpkQ/hMLGZOrGartofH/3S9uEOr1UnBXrUOV4Kyd78
        WkOvAgA7J0IAUCMBv/bBVgg=
X-Google-Smtp-Source: ABdhPJyvG7rjAq0tJb1OxgQQcpzr9RyVUbCWSGg7fnFubUO7ZGXeWPUGz9zLfFpf+qPQFmsBbsMAWA==
X-Received: by 2002:a50:f687:: with SMTP id d7mr3210799edn.306.1596740690676;
        Thu, 06 Aug 2020 12:04:50 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:d567:ec52:e0a5:f485])
        by smtp.gmail.com with ESMTPSA id x1sm4309881ejv.11.2020.08.06.12.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 12:04:50 -0700 (PDT)
Date:   Thu, 6 Aug 2020 21:04:49 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v2 5/6] openrisc: signal: Fix sparse address space
 warnings
Message-ID: <20200806190449.xqflhmbiiv5btusf@ltop.local>
References: <20200805210725.310301-1-shorne@gmail.com>
 <20200805210725.310301-6-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805210725.310301-6-shorne@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 06:07:24AM +0900, Stafford Horne wrote:
> ---
>  arch/openrisc/kernel/signal.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
> index 4f0754874d78..7ce0728412f6 100644
> --- a/arch/openrisc/kernel/signal.c
> +++ b/arch/openrisc/kernel/signal.c
> @@ -76,7 +76,7 @@ asmlinkage long _sys_rt_sigreturn(struct pt_regs *regs)
>  	 * then frame should be dword aligned here.  If it's
>  	 * not, then the user is trying to mess with us.
>  	 */
> -	if (((long)frame) & 3)
> +	if (((__force unsigned long)frame) & 3)
>  		goto badframe;

Same as patch 6, the __force is not needed.
  
-- Luc

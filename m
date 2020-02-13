Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB76C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 05:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FFA2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 05:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T62CKdFr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbgBMFml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 00:42:41 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43706 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgBMFml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 00:42:41 -0500
Received: by mail-pf1-f193.google.com with SMTP id s1so2455499pfh.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 21:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l3fC7d9p2hDnV1O6sE47mVWCvfvZGL5+HxAj+Md7Lc0=;
        b=T62CKdFr4fxXFFolO534bUAx5TuqPWnzHsFLyNj3hNnvdursXIKGRIx9OwvNQdblEa
         f3zcwktKN0UyiuaNORzYgMB1AHrQ3JBzdmYGKHT8mkG6uY/2xj+IyzMCvqxhwQQ9u7x/
         yYOk5us7rV5DT0som65N5iwUVKuO0LA4HJl9Ax+jo5iUtzjVtah7lUGaKMcE+2k0V8Pl
         wCfFQwVPngqZ9AZd/jJl7Z3t7haTve9AAlJHmmjDISe02zthyZugs+rWozorhVZd1jWP
         93JgUyitKSVuaZrAoqTjmUFHmxJ+d9xKA475QnmC9Cx2C9WHj6SGAJpSfkqXr6k5P+/F
         OT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l3fC7d9p2hDnV1O6sE47mVWCvfvZGL5+HxAj+Md7Lc0=;
        b=F9pN4othCk/0Vgc8/Ii0W9Nw5kLRJsX+wyK4xzeGyOY16+I/h4n2Mb06+33abmd6MF
         2YjalMfVcDKZh8BUoZJnRMjrMyyIjPg+/fO2s4XFaXpa55mCQUG+VZ4LCGAjdfzEwFzw
         ibSuniXYcL+7cwrTVWWIpuXAsbru93w6yIV65OMK9Cj0yhclZUoU3Plw+Fyd8JMtZBqc
         8Yu7NWKe6ZjKd8t+sgxteUyVu7IPhqql70qAIZAC4eps36FxleYe4CUu6hsLdMwDQo81
         mtunvu12tMzi/Tbasx1A+JjpIs4giZlzrrxlMfoSvjhG8wWuWEBMFrO19pDxeTq1KPIt
         FXdA==
X-Gm-Message-State: APjAAAXwT+uj9k7lPm/CE8uIYvUbMCPNSNRDCK+dJvkX8nKBP4Kt1/gI
        ZVhEd2HeN13O18dWU29EEBk=
X-Google-Smtp-Source: APXvYqyUxe7EYa42/2FGmXN9rs9QBSvCVXUdopificAVMg5Klb19y9xwFLv+/DX3VE5Ui3NsQHWGyQ==
X-Received: by 2002:aa7:951c:: with SMTP id b28mr11882993pfp.97.1581572560379;
        Wed, 12 Feb 2020 21:42:40 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id l5sm996424pgu.61.2020.02.12.21.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 21:42:39 -0800 (PST)
Date:   Thu, 13 Feb 2020 14:42:37 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] printk: Move console matching logic into a
 separate function
Message-ID: <20200213054237.GD13208@google.com>
References: <e6b63bc26108c6e3645f9ea9e03aba38fd8b8464.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6b63bc26108c6e3645f9ea9e03aba38fd8b8464.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/06 15:02), Benjamin Herrenschmidt wrote:
[..]
> +
> +	/*
> +         * Some consoles, such as pstore and netconsole, can be enabled even
> +         * without matching.
> +         */
> +        if (newcon->flags & CON_ENABLED)
> +                return 0;
> +
> +	return -ENOENT;
> +}

Looks good to me // modulo checkpatch warnings //

Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss

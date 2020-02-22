Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA140C35669
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 06:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89775208C3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 06:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="YgYqaaBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgBVG0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 01:26:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40798 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgBVG0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 01:26:44 -0500
Received: by mail-wr1-f65.google.com with SMTP id t3so4388403wru.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 22:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/59J0H3GMLZGQBLxUb/P9gfXRVxPokMyJCYkW6dkkKw=;
        b=YgYqaaBlYOEfNDyadkILBH204HirajE3Z3I6L46m+XYGL+RnnSyqssH5LRBF8pMbnD
         rQtwZBIeDF3K2aQKN4zQ444s8Sa7e3aV9hEH9D40u5crwSoUAh4FqtgVnSwoPWKNubm6
         wO7MwJntiLJZyKKaytoOmia6jISJjJbEjGHXFc/G2TxotGF4hDPK5hAGgR27FMYX5otV
         i+u9jQB+XjJ4GnYQKIpoAbPpId20EBlfrdC0atRKSbwC7cx8qdAKuptu/8+DYGQZGI3X
         U124fcx9wtju0mIA7qZIyGSUQsER9a9jIctkjwhvw/ASrxNdJ4jsgL/H2veTEWvaZyeM
         m9Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/59J0H3GMLZGQBLxUb/P9gfXRVxPokMyJCYkW6dkkKw=;
        b=dx+D4N5+xaub8yGzTWUz8jlRg4+A46/rFbGYEKabbmBNXmVzSa9VmO7LQawlVCIbQg
         YtOb4E9EsYpIWTZDXLKKbXfpjgniHcWHOv6oAnm8Jl5yv/zHnav3fDkwcTJkEozUCDlU
         GsHjYy24K26mAWntyT25cb9vZ/KBRYUhY9iQeHbbfd4u24eBAodPPTZZt9xs66Gpo/gN
         R6+Ih9CDvyeJ0XhAYPbLBPhjxgrnVPO8jkq+cigXsc5NDYHVdm8MAcRX8EKSWbN4zL6J
         Mi85xQ+ARmx+i7s2B1puiymCySaeYzm/u9T/LOxjR3xpV+7KXNFIwPQLLTfju1Gk5wHP
         iOqQ==
X-Gm-Message-State: APjAAAV29kRVXdFfncrpQD5DAZoGwIqFrRsO8ZL6n24/B/lc8ZBdkWo/
        +XZ+BOfQqGpriVaE+E8Q3XjkDQ==
X-Google-Smtp-Source: APXvYqzJCvVsgqjVymg7udnn6kagPdqKPFB6BfUwZSDat3KQhYu5qWhke/ZVlGCJiAG2QeUeiqvJhw==
X-Received: by 2002:a5d:4687:: with SMTP id u7mr51024980wrq.176.1582352801556;
        Fri, 21 Feb 2020 22:26:41 -0800 (PST)
Received: from localhost (ip-89-177-130-96.net.upcbroadband.cz. [89.177.130.96])
        by smtp.gmail.com with ESMTPSA id h5sm7655640wmf.8.2020.02.21.22.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 22:26:41 -0800 (PST)
Date:   Sat, 22 Feb 2020 07:26:40 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     madhuparnabhowmik10@gmail.com
Cc:     jiri@mellanox.com, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        frextrite@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org
Subject: Re: [PATCH] net: core: devlink.c: Hold devlink->lock from the
 beginning of devlink_dpipe_table_register()
Message-ID: <20200222062640.GA2228@nanopsycho>
References: <20200221180943.17415-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221180943.17415-1-madhuparnabhowmik10@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Feb 21, 2020 at 07:09:43PM CET, madhuparnabhowmik10@gmail.com wrote:
>From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>
>devlink_dpipe_table_find() should be called under either
>rcu_read_lock() or devlink->lock. devlink_dpipe_table_register()
>calls devlink_dpipe_table_find() without holding the lock
>and acquires it later. Therefore hold the devlink->lock
>from the beginning of devlink_dpipe_table_register().
>
>Suggested-by: Jiri Pirko <jiri@mellanox.com>
>Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>---
> net/core/devlink.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/net/core/devlink.c b/net/core/devlink.c
>index 3e8c94155d93..d54e1f156b6f 100644
>--- a/net/core/devlink.c
>+++ b/net/core/devlink.c
>@@ -6840,6 +6840,8 @@ int devlink_dpipe_table_register(struct devlink *devlink,
> {
> 	struct devlink_dpipe_table *table;
> 
>+	mutex_lock(&devlink->lock);
>+
> 	if (devlink_dpipe_table_find(&devlink->dpipe_table_list, table_name))
> 		return -EEXIST;

You have to handle the error path.


> 
>@@ -6855,7 +6857,6 @@ int devlink_dpipe_table_register(struct devlink *devlink,
> 	table->priv = priv;
> 	table->counter_control_extern = counter_control_extern;
> 
>-	mutex_lock(&devlink->lock);
> 	list_add_tail_rcu(&table->list, &devlink->dpipe_table_list);
> 	mutex_unlock(&devlink->lock);
> 	return 0;
>-- 
>2.17.1
>

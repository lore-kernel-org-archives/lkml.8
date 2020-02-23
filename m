Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BD5C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 11:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A27E20637
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 11:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="1wmQJcbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbgBWLBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 06:01:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42122 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbgBWLBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 06:01:50 -0500
Received: by mail-wr1-f66.google.com with SMTP id p18so3354055wre.9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Feb 2020 03:01:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nNPrsHRgMBJ28633rhUatoFgkN3nEJ6CqDkonaiRJ/k=;
        b=1wmQJcbXK3udpuO0gJvSAevchnQrhS2D7iwgDR1V8N3PQ74b1eL7Yrs6PqK3XV3V6M
         ocNPnJS9P/0wS4k7EWEbPX2Yu4Wufml3iccw/opY89TOWUuuY/tnGDCXFec5JCV8iOoR
         74kg3BTywFpFxFn0dpRRgcPLG+87/M+kX3lr6JnYKGSKIXDqp5AWUdgZ0nFrgey07Vty
         f7q3LWvpm8YY6RSJ6xEIfT+YMdme8rU+KeDJ1M6ZcafHdlmL+ccxtOhRcoieEEazU5MM
         SgUVEtJc4CBGTs+vw6M1079J9y214WLO3sz88SdF3hWC9oUwWRYaGQGJithrQ1mnteO6
         TFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nNPrsHRgMBJ28633rhUatoFgkN3nEJ6CqDkonaiRJ/k=;
        b=pMOSEIGPw63I8rtmbQiIywmCV3QSzE8N2onJX+m8WaI2LZZ0gZQBTtn3nsGnmER79q
         dkwUOQVglIX0bT8yC2hO7KblSe+LWmMRmrlL6LO5YMl3hmFUAmWtFejAqt3tA0Kl6XV3
         /nCYk6UE5HoojVJSs91d72J959/NVbisZniFRIcDm/HndayLhJutIqqki40cDx4iyR28
         HF4m1zY1HJUqesabdVyyCbVAQG+X43LfXYJEDD2hzzoBnP829owe7bndx6oqvGGIAomQ
         mxBxanQJbbXWwb3w6CFUFqN1DksTXpe+HyoQ7PAqdy591azMDXm3xDeUpMZu2bpyeGIW
         OBVw==
X-Gm-Message-State: APjAAAVU7FV/swVv8uW/IFeT6oc+12X0Vf8PORWHooa2jOKDucoI9S71
        amXKwScmNgFOtG6ynxpGLXS9LQ==
X-Google-Smtp-Source: APXvYqzgEMCZfzOoWDjWUaSpZbFzGH0LqC4DP638gxs1UJpsD7iwLnM7GXZGsNgvTL88KtPUPTvErg==
X-Received: by 2002:adf:e68d:: with SMTP id r13mr4306936wrm.159.1582455707231;
        Sun, 23 Feb 2020 03:01:47 -0800 (PST)
Received: from localhost (ip-89-177-130-96.net.upcbroadband.cz. [89.177.130.96])
        by smtp.gmail.com with ESMTPSA id x7sm12742129wrq.41.2020.02.23.03.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2020 03:01:46 -0800 (PST)
Date:   Sun, 23 Feb 2020 12:01:45 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     madhuparnabhowmik10@gmail.com
Cc:     jiri@mellanox.com, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org, paulmck@kernel.org
Subject: Re: [PATCH] net: core: devlink.c: Hold devlink->lock from the
 beginning of devlink_dpipe_table_register()
Message-ID: <20200223110145.GE2228@nanopsycho>
References: <20200223105253.30469-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223105253.30469-1-madhuparnabhowmik10@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sun, Feb 23, 2020 at 11:52:53AM CET, madhuparnabhowmik10@gmail.com wrote:
>From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>
>devlink_dpipe_table_find() should be called under either
>rcu_read_lock() or devlink->lock. devlink_dpipe_table_register()
>calls devlink_dpipe_table_find() without holding the lock
>and acquires it later. Therefore hold the devlink->lock
>from the beginning of devlink_dpipe_table_register().
>
>Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>---
> net/core/devlink.c | 25 +++++++++++++++++--------
> 1 file changed, 17 insertions(+), 8 deletions(-)
>
>diff --git a/net/core/devlink.c b/net/core/devlink.c
>index 4c63c9a4c09e..61a350f59741 100644
>--- a/net/core/devlink.c
>+++ b/net/core/devlink.c
>@@ -6838,26 +6838,35 @@ int devlink_dpipe_table_register(struct devlink *devlink,
> 				 void *priv, bool counter_control_extern)
> {
> 	struct devlink_dpipe_table *table;
>+	int err = 0;
> 
>-	if (devlink_dpipe_table_find(&devlink->dpipe_table_list, table_name))
>-		return -EEXIST;
>+	mutex_lock(&devlink->lock);
> 
>-	if (WARN_ON(!table_ops->size_get))
>-		return -EINVAL;
>+	if (devlink_dpipe_table_find(&devlink->dpipe_table_list, table_name)) {
>+		err = -EEXIST;
>+		goto unlock;
>+	}
>+
>+	if (WARN_ON(!table_ops->size_get)) {
>+		err = -EINVAL;
>+		goto unlock;
>+	}


Put this check out of the lock please.


> 
> 	table = kzalloc(sizeof(*table), GFP_KERNEL);
>-	if (!table)
>-		return -ENOMEM;
>+	if (!table) {
>+		err = -ENOMEM;
>+		goto unlock;
>+	}
> 
> 	table->name = table_name;
> 	table->table_ops = table_ops;
> 	table->priv = priv;
> 	table->counter_control_extern = counter_control_extern;
> 
>-	mutex_lock(&devlink->lock);
> 	list_add_tail_rcu(&table->list, &devlink->dpipe_table_list);
>+unlock:
> 	mutex_unlock(&devlink->lock);
>-	return 0;
>+	return err;
> }
> EXPORT_SYMBOL_GPL(devlink_dpipe_table_register);
> 
>-- 
>2.17.1
>

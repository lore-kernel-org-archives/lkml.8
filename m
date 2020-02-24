Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3934C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:52:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73CEB20836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="rRWh5ZbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgBXKwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 05:52:12 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39595 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbgBXKwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:52:11 -0500
Received: by mail-wm1-f68.google.com with SMTP id c84so8852954wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 02:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+/3oknbjjXh74tXkJ87bK1AQRcBTEShGAS9TRSr6HFc=;
        b=rRWh5ZbInWogei16TJbuZiPxb08LdmfbYKsu5d4uW34t6VXfELPhC3SQaZAb8nhIPo
         Wda/hWbSbM7MxeAD3Zt6HuJx8bFQQjiKkNKkDvG+JWmW7Uvgld7TDHmG5zF0TOL2KgNT
         RHUpAwJZt3Rrxc5MWW7UlWVtHLBdqv3qMC3mAEJ7ddzaaAdX97ry+iiJXwKHGNPFH+aG
         1+QNifHvI6Bvj8yw6q9EWNAcXOxr2p9fMUzpcgbpJaW1lD51/PglYCiql3QagLVDcAYz
         WkQEALiNuhOOiSkrL8vJONmUL1vKMkP1gO8SqDrDeYgWZnE4PMDa/4xJV+VgDgbUgD4s
         GhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+/3oknbjjXh74tXkJ87bK1AQRcBTEShGAS9TRSr6HFc=;
        b=pbBrW/t/0KUCRllo3BNjZ5vT3rMgmN0r/RPs0hrtL9L34uRJc7LSb/Jze5sq7/iTXc
         Y1JBDdgqQUx12R2sKCJL50lABtqgAYiqLbT7ADUl42v1nNXWqdmKm6lTqVUnTTg9qUAi
         H9FO1ARHxCjHvzTv1cwEFF+4j6mcqM3qd7hFnd1EKJqT+TYNkqkj3LzB+tjZX9+ZR8h0
         COARz5ml2HIjDuf95prcOnePcEyw4rEs/IbLhaGMzeA6KSdG1ccZevmta8zt5gvaBDgt
         aO3wDLk48meDaEB/+bTyPaf98Fj+Op5pcdUXGxlPha/ec4COk1u2zI5zfESQDl9BLlUK
         XAJg==
X-Gm-Message-State: APjAAAVOP+w5e4IN4/Uw/7RlU8AyWgahngBVf9SiivgmSElqxrtX7u9u
        GYJZUw+fWQp3Tc2Vl/G4LjGQhA==
X-Google-Smtp-Source: APXvYqxP173/3xNIfZXcna9Yb7nuBIf8//+b+CatKWU3a/Qh6VaE8qWvRUIK35pa/v+MuRKN2M85Vw==
X-Received: by 2002:a1c:8055:: with SMTP id b82mr21965462wmd.127.1582541530156;
        Mon, 24 Feb 2020 02:52:10 -0800 (PST)
Received: from localhost (ip-89-177-130-96.net.upcbroadband.cz. [89.177.130.96])
        by smtp.gmail.com with ESMTPSA id z16sm777239wrp.33.2020.02.24.02.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 02:52:09 -0800 (PST)
Date:   Mon, 24 Feb 2020 11:52:09 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     madhuparnabhowmik10@gmail.com
Cc:     jiri@mellanox.com, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        frextrite@gmail.com, paulmck@kernel.org
Subject: Re: [PATCH] net: core: devlink.c: Use built-in RCU list checking
Message-ID: <20200224105209.GB16270@nanopsycho>
References: <20200224093013.25700-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224093013.25700-1-madhuparnabhowmik10@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Feb 24, 2020 at 10:30:13AM CET, madhuparnabhowmik10@gmail.com wrote:
>From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>
>list_for_each_entry_rcu() has built-in RCU and lock checking.
>
>Pass cond argument to list_for_each_entry_rcu() to silence
>false lockdep warning when CONFIG_PROVE_RCU_LIST is enabled.
>
>The devlink->lock is held when devlink_dpipe_table_find()
>is called in non RCU read side section. Therefore, pass struct devlink
>to devlink_dpipe_table_find() for lockdep checking.
>
>Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>---
> net/core/devlink.c | 18 +++++++++---------
> 1 file changed, 9 insertions(+), 9 deletions(-)
>
>diff --git a/net/core/devlink.c b/net/core/devlink.c
>index e82750bdc496..dadf5fa79bb1 100644
>--- a/net/core/devlink.c
>+++ b/net/core/devlink.c
>@@ -2103,11 +2103,11 @@ static int devlink_dpipe_entry_put(struct sk_buff *skb,
> 
> static struct devlink_dpipe_table *
> devlink_dpipe_table_find(struct list_head *dpipe_tables,
>-			 const char *table_name)
>+			 const char *table_name, struct devlink *devlink)
> {
> 	struct devlink_dpipe_table *table;
>-
>-	list_for_each_entry_rcu(table, dpipe_tables, list) {
>+	list_for_each_entry_rcu(table, dpipe_tables, list,
>+				lockdep_is_held(&devlink->lock)) {
> 		if (!strcmp(table->name, table_name))
> 			return table;
> 	}
>@@ -2226,7 +2226,7 @@ static int devlink_nl_cmd_dpipe_entries_get(struct sk_buff *skb,
> 
> 	table_name = nla_data(info->attrs[DEVLINK_ATTR_DPIPE_TABLE_NAME]);
> 	table = devlink_dpipe_table_find(&devlink->dpipe_table_list,
>-					 table_name);
>+					 table_name, devlink);
> 	if (!table)
> 		return -EINVAL;
> 
>@@ -2382,7 +2382,7 @@ static int devlink_dpipe_table_counters_set(struct devlink *devlink,
> 	struct devlink_dpipe_table *table;
> 
> 	table = devlink_dpipe_table_find(&devlink->dpipe_table_list,
>-					 table_name);
>+					 table_name, devlink);
> 	if (!table)
> 		return -EINVAL;
> 
>@@ -6814,7 +6814,7 @@ bool devlink_dpipe_table_counter_enabled(struct devlink *devlink,
> 
> 	rcu_read_lock();
> 	table = devlink_dpipe_table_find(&devlink->dpipe_table_list,
>-					 table_name);
>+					 table_name, devlink);
> 	enabled = false;
> 	if (table)
> 		enabled = table->counters_enabled;
>@@ -6845,7 +6845,7 @@ int devlink_dpipe_table_register(struct devlink *devlink,
> 
> 	mutex_lock(&devlink->lock);
> 
>-	if (devlink_dpipe_table_find(&devlink->dpipe_table_list, table_name)) {
>+	if (devlink_dpipe_table_find(&devlink->dpipe_table_list, table_name, devlink)) {

Run scripts/checkpatch.pl on your patch. You are breaking 80-cols limit
here.

Otherwise, the patch looks fine.

> 		err = -EEXIST;
> 		goto unlock;
> 	}
>@@ -6881,7 +6881,7 @@ void devlink_dpipe_table_unregister(struct devlink *devlink,
> 
> 	mutex_lock(&devlink->lock);
> 	table = devlink_dpipe_table_find(&devlink->dpipe_table_list,
>-					 table_name);
>+					 table_name, devlink);
> 	if (!table)
> 		goto unlock;
> 	list_del_rcu(&table->list);
>@@ -7038,7 +7038,7 @@ int devlink_dpipe_table_resource_set(struct devlink *devlink,
> 
> 	mutex_lock(&devlink->lock);
> 	table = devlink_dpipe_table_find(&devlink->dpipe_table_list,
>-					 table_name);
>+					 table_name, devlink);
> 	if (!table) {
> 		err = -EINVAL;
> 		goto out;
>-- 
>2.17.1
>

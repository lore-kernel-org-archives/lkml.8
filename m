Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2982EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3AC42063A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="K78QVysR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387522AbgHQRet (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388766AbgHQQgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:36:17 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A826C061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 09:36:15 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r2so15633836wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 09:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tMKZiqsnqbFn8irAos+7042bqmvB89r7nqqfmhiQHfo=;
        b=K78QVysR/ZXWdJzwnTE9+KxjBbE/Y/0ZpwohxOrT5y9/OftqWcr5xzJIlbwLekGgCD
         AzjyOmMsCnAhIHmANFO6PcZk+f7jw38DIFVqAdauXUn0no6OoCnzSGALl/llQxwVMyB9
         dmfjQa/P08oKzJr/KjIMmquNjKfIIJlYZfnDOh0XrhTENT4dpLcNJt8xOseOAFKRdWuy
         /Msww2d8SNJQ0uK56YuwOQRD/NnF+WNHPLbOmqWKGMGVfi9BUXxjeL98ly5tajpGMEQ4
         9/vi7KAW+rxQBqUxJh3LiN67WOZWgRIBEyiviGwh/1zjIEoaxeNLt28s3ieKrnvkmPOQ
         RmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tMKZiqsnqbFn8irAos+7042bqmvB89r7nqqfmhiQHfo=;
        b=cRAthXxbcrq62ZFYyTbr93jgRonCiMHHLfGzWvyDjeQJaLwG+dx03J6jvnTFfkmKyN
         sV8fJr9RKiOG+EiYqObboBnMrNPmqUygRowIUHtCqhySAfye2N5lAAxnL8I8hnPi8f+Z
         8IYhvKNjq9AUUKl6jgvc3DnHKXJ1JTZANOOa75jwIAJ5gxWbtMRKbFly9DLJm8YYbkpZ
         V1TYaXTcuzzs1bJPYdu8dLf7JTEsc0s1I01qDJqtr1oZvxHP65GBzjlZFP6ovPsY9bjQ
         f6PEctHuiXPe3oUnI0A/gJ5gKlJ6lFFtVOrZGd7qw5mUuHfpXEtjUYUX3YD5TIOp9qHY
         NVHQ==
X-Gm-Message-State: AOAM531uP8rUJl0RkZ99vB0DQuXEQMNeLeiCn3T/moFnKMFhOtko0ekq
        03YPIN7mFJvN3LbrcQvDKwcFYA==
X-Google-Smtp-Source: ABdhPJwDBmTguVh7tFQOOiwAudU2uFsHEUGITgyfcQtT/I3p0LfCTVZrNU6xs66eYZbi2RKBqrEmdg==
X-Received: by 2002:adf:a1c6:: with SMTP id v6mr16170552wrv.197.1597682173655;
        Mon, 17 Aug 2020 09:36:13 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id f124sm30083480wmf.7.2020.08.17.09.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 09:36:13 -0700 (PDT)
Date:   Mon, 17 Aug 2020 18:36:12 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Moshe Shemesh <moshe@mellanox.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next RFC v2 01/13] devlink: Add reload action option
 to devlink reload command
Message-ID: <20200817163612.GA2627@nanopsycho>
References: <1597657072-3130-1-git-send-email-moshe@mellanox.com>
 <1597657072-3130-2-git-send-email-moshe@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597657072-3130-2-git-send-email-moshe@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Aug 17, 2020 at 11:37:40AM CEST, moshe@mellanox.com wrote:
>Add devlink reload action to allow the user to request a specific reload
>action. The action parameter is optional, if not specified then devlink
>driver re-init action is used (backward compatible).
>Note that when required to do firmware activation some drivers may need
>to reload the driver. On the other hand some drivers may need to reset

Sounds reasonable. I think it would be good to indicate that though. Not
sure how...


>the firmware to reinitialize the driver entities.
>Reload actions supported are:
>driver_reinit: driver entities re-initialization, applying devlink-param
>               and devlink-resource values.
>fw_activate: firmware activate.
>fw_live_patch: firmware live patching.
>

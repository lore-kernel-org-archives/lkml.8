Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529D2C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A69B2083E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 10:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="XqB9pDZF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgHaKon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 06:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgHaKol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 06:44:41 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61077C061575
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 03:44:41 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z4so2639053wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 03:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=k+EYgDY4h1YnjFAKejF6GzhKvmGlD2uTuVOl9S42RJU=;
        b=XqB9pDZFFdbsN4WAsjqI6EX/O5KjFFP6wjsWbg9oDnQZBxcMHzwP7YSIBUJt5O0VAX
         OJAyoBLH3V7jmSvh8XTcTRa/7UPkOSfImLuCq65zVihXa3b96Ef1YlqhHN96BiRyrjt8
         RTNB3lCbQlbWxey2ErX645oW0ro3qstDprORVaDt1QBJAJser/0m/EPKi9yovckee5B9
         FA/j6+zfLwp03TvPPRgHW2DyLPXKn/l4Z3kKweG8Z5yvPyvnsOc2ag7LSWwMd5wumTWj
         o78Tmnuo5V11ZRQwk2ZMqofBq8HQwnVGCOfFw/Nntf3JUFQFnKJQJyLcFDVmQSe9rAaY
         jejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k+EYgDY4h1YnjFAKejF6GzhKvmGlD2uTuVOl9S42RJU=;
        b=qd/FSwe9D/ckmbQCkIlE5eSoZX8Dlz3mSGdsnZtvouKQsVVNwi6BYRtEjZ7tCRbDsW
         VU6VN3xfa4tNMbRb8BqT3KpGP7Pq+i0EMM+vXTRKQk0RiBUdmiENNPxEpYPVFYSTOTaE
         ClexzhLHtXIRLQxijQ/wyxAiN2cPPAWrxdQYZbHxnR7afQ5dr+rBkEQXgn5od6Zd6I0W
         TLdyOYlyVNq+KF1lPb+5foODrdW0/wOC8W0SKVb4DGGV8R5lLESrGXcLQlYrlhkQnDva
         phuEMYxVub4MS3QDHZQhzGsSUWXv88HYXT0ZG6bu2ZeuHrTaoNjJb1p7SvBMU2cmovRW
         cofA==
X-Gm-Message-State: AOAM533vCGByho5F3lkygbiZ7/fQYW03jh3bvGsHFLOWLw/SdOTN4j95
        FOvfYSgcqLJGpHGgIyJIQild/A==
X-Google-Smtp-Source: ABdhPJyRFov4JuNLN5DAXSh9XQtJj9BZLjKnRtnTEzitPpCAZ1aI/EixspeKXwmvuQAztWmzQIGZzQ==
X-Received: by 2002:adf:e58b:: with SMTP id l11mr1162050wrm.210.1598870679800;
        Mon, 31 Aug 2020 03:44:39 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id l10sm9639574wru.59.2020.08.31.03.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 03:44:39 -0700 (PDT)
Date:   Mon, 31 Aug 2020 12:44:38 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Moshe Shemesh <moshe@mellanox.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next RFC v3 03/14] devlink: Add reload actions
 counters to dev get
Message-ID: <20200831104438.GA3794@nanopsycho.orion>
References: <1598801254-27764-1-git-send-email-moshe@mellanox.com>
 <1598801254-27764-4-git-send-email-moshe@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1598801254-27764-4-git-send-email-moshe@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sun, Aug 30, 2020 at 05:27:23PM CEST, moshe@mellanox.com wrote:
>Expose devlink reload actions counters to the user through devlink dev
>get command.
>
>Examples:
>$ devlink dev show
>pci/0000:82:00.0:
>  reload_actions_stats:
>    driver_reinit 2
>    fw_activate 1
>    fw_activate_no_reset 0
>pci/0000:82:00.1:
>  reload_actions_stats:
>    driver_reinit 1
>    fw_activate 1
>    fw_activate_no_reset 0
>
>$ devlink dev show -jp
>{
>    "dev": {
>        "pci/0000:82:00.0": {
>            "reload_actions_stats": [ {

Perhaps "reload_action_stats" would be better.


>                    "driver_reinit": 2
>                },{
>                    "fw_activate": 1
>                },{
>                    "fw_activate_no_reset": 0
>                } ]
>        },
>        "pci/0000:82:00.1": {
>            "reload_actions_stats": [ {
>                    "driver_reinit": 1
>                },{
>                    "fw_activate": 1
>                },{
>                    "fw_activate_no_reset": 0
>                } ]
>        }
>    }
>}
>
>Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
>---
>v2 -> v3:
>- Add reload actions counters instead of supported reload actions
>  (reload actions counters are only for supported action so no need for
>   both)
>v1 -> v2:
>- Removed DEVLINK_ATTR_RELOAD_DEFAULT_LEVEL
>- Removed DEVLINK_ATTR_RELOAD_LEVELS_INFO
>- Have actions instead of levels
>---
> include/uapi/linux/devlink.h |  3 +++
> net/core/devlink.c           | 37 +++++++++++++++++++++++++++++++-----
> 2 files changed, 35 insertions(+), 5 deletions(-)
>
>diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
>index 0a438135c3cf..fd7667c78417 100644
>--- a/include/uapi/linux/devlink.h
>+++ b/include/uapi/linux/devlink.h
>@@ -478,6 +478,9 @@ enum devlink_attr {
> 
> 	DEVLINK_ATTR_RELOAD_ACTION,		/* u8 */
> 	DEVLINK_ATTR_RELOAD_ACTIONS_DONE,	/* nested */
>+	DEVLINK_ATTR_RELOAD_ACTION_CNT_VALUE,	/* u32 */
>+	DEVLINK_ATTR_RELOAD_ACTION_CNT,		/* nested */
>+	DEVLINK_ATTR_RELOAD_ACTIONS_CNTS,	/* nested */

Be in-sync with the user outputs. Perhaps something like:
	DEVLINK_ATTR_RELOAD_ACTION_STATS
	DEVLINK_ATTR_RELOAD_ACTION_STAT
	DEVLINK_ATTR_RELOAD_ACTION_STAT_VALUE
?

> 
> 	/* add new attributes above here, update the policy in devlink.c */
> 

[..]

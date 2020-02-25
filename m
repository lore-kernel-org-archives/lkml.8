Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1AEEC35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7447320CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="xz6KmNkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730177AbgBYNGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 08:06:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43977 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729193AbgBYNGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 08:06:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id r11so14650014wrq.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 05:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uMjhr8CMWX21ynVJVCnTzKkHtTnq0PDF47au6rdT/nQ=;
        b=xz6KmNkK/lHhlnyw2oikBfjwgiFERtVWum9ciRHolZ7CEkp1ZJSYhrecY4iYbaJ3DN
         hRrD+zuzyRgxzJLrDiDAwDO9t9GHOainLRXJlillHMi4led/g/3ZawzpDt7RwYi4vtxe
         DtlfzUHEatOoLGQnXjpNSisijiJvcc0m71D8e7qZeEpWG+DgeVENJaXVdv4VS1JZGRtX
         bLZgsah8Hxihi7TjIsvj75xjcw7negQb3RkjNAkfOwRHObuT22b+zZZ5e8hGBLmvNr9I
         E4OuHGm7J/ZH3aDcZodqk2eoTsS51nckhzmHZTcFaysuHLYA1N8JQOp/eNbM7SkQsRx3
         om2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uMjhr8CMWX21ynVJVCnTzKkHtTnq0PDF47au6rdT/nQ=;
        b=juaXCnqBYNWEINM6Rwyin8efHbkeSe6iYF8ywigMxxWPblAWSa2Nyv8dwNnxUa74W7
         xMnVvKt/Risbo6rNioW8AkGVE1c8RzcIWDd94Zk9zZgVLD6JkT0FZLDony5rZ2H9+twP
         AXJOhB48CgsLP80wxiCBvs0GrnJ/jTCUr+M7HvtCu4IW94FKK6NEKC0RFg7j/TQCGzHY
         d+f7UM/S75yz/8Fw1MjbtMwPkOh7NyVqTMdT8oUBRrIZVQrmjbm6lHv/rhYyMREpCQFB
         q2t1uK3sr1ctkfnXlAg3VjTZM0KTfeVYJHgD95VWblPO26wBljrHKk3IkhcPTVEHKlfb
         z5qg==
X-Gm-Message-State: APjAAAXEJkL2DXZkvZOJwJ566JRei9xaP9crXNrh1yj5p6/2Ak4KLJG3
        MHiaiZ+K6yD/iPKhFPi1maGPJw==
X-Google-Smtp-Source: APXvYqxavRUvXtPThejGl2mpg0JIuneJtxsS5/rFce8Vy/41DqKJfXTbqBZl7KDpyOoc1duWXrlehA==
X-Received: by 2002:a5d:51ce:: with SMTP id n14mr74348991wrv.426.1582636007795;
        Tue, 25 Feb 2020 05:06:47 -0800 (PST)
Received: from localhost (ip-89-177-130-96.net.upcbroadband.cz. [89.177.130.96])
        by smtp.gmail.com with ESMTPSA id l17sm23554997wro.77.2020.02.25.05.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 05:06:47 -0800 (PST)
Date:   Tue, 25 Feb 2020 14:06:46 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     madhuparnabhowmik10@gmail.com
Cc:     jiri@mellanox.com, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        frextrite@gmail.com, paulmck@kernel.org
Subject: Re: [PATCH] net: core: devlink.c: Use built-in RCU list checking
Message-ID: <20200225130646.GD17869@nanopsycho>
References: <20200225122745.31095-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225122745.31095-1-madhuparnabhowmik10@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Feb 25, 2020 at 01:27:45PM CET, madhuparnabhowmik10@gmail.com wrote:
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

Reviewed-by: Jiri Pirko <jiri@mellanox.com>

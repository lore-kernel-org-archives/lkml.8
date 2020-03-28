Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7A7C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 10:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13538206F2
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 10:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="WmDZ7yik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgC1KIJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 06:08:09 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35852 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgC1KIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 06:08:09 -0400
Received: by mail-wm1-f65.google.com with SMTP id g62so15423188wme.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 03:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LmXzIdsgOGOrYXNyO5YlJa3HyL+hZye7blb+c0Swzc0=;
        b=WmDZ7yik0sLkHcczuVaK0qyto4JitTtfPFmIpjBd9wNtV4zoys6/yedhUUNx2tE8as
         Tw1HQntF4KHvZ0waYrJacDy34yDtBpO8/T0F5EBkCpPHyAJtdQyXly9OexUYuy43H9nC
         48QMgD9CfF8F4pQmsVTSTGCdqrdPGvYT9cI8NkOLz6Eh2WYyqJD3aLnNz9yBdE7CN7jZ
         DF2/92YC48LxReVqy/6UTMluKOp/f6CzRHjOkRCptWTqiTAF+EgvaiqmA+vQYYaXq7EZ
         xlIIZcI9JAYva4gaFMSgvsS8ECZBJ/yTPd7C9E159JELk1kS81hmM5dX3Vy8QNmKJ9ZV
         UFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LmXzIdsgOGOrYXNyO5YlJa3HyL+hZye7blb+c0Swzc0=;
        b=OopOx/HRNSsWC/HJFtnNiic5QH8XcFLIp1nJBSlKrU+Nkr73+jqC7+X8jJfCjOQxuk
         R805bpWOiwk5Ock2/dQWvz+NX/PC/MjSXjiI6QsqQN5xidvXb9FPQ4UKVKL3DWYkYEGI
         oaboMII8mjBpJEd4LtWF2p43DipBcKIEtKJtdQrHwGw2k04UMs4OfQNRWk9vzz/5bcQx
         NDJa2yjk/bH4MNqpune1MEIq6rRuyb9j9Sl5L2HLY01+2s6fjnXkv+eiDLRPlnVzUjxU
         M6MooMqGGdLDGIUMkW/G+BvLKvePYscHOehejIyYLUN0D3myktTvAMvhw4BBHJz404In
         AhyQ==
X-Gm-Message-State: ANhLgQ1r4JZs4tjsnJ0o1AcrY3mY7HoARgJ6WUJk/UuYlPeRTtlg3lmo
        PVopfSmIwTDlGo11JF02yzrqjQ==
X-Google-Smtp-Source: ADFU+vsNR1mrhIcAfevBCNXwc4R7vToBFdkBDFd3MJHvo7dEc9SPf2sPNpROD3ab5FuvnU+PGOlMmg==
X-Received: by 2002:a7b:c343:: with SMTP id l3mr3320247wmj.38.1585390086574;
        Sat, 28 Mar 2020 03:08:06 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id w204sm11970180wma.1.2020.03.28.03.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 03:08:05 -0700 (PDT)
Date:   Sat, 28 Mar 2020 11:08:05 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 00/12] ethtool netlink interface, part 4
Message-ID: <20200328100805.GO11304@nanopsycho.orion>
References: <cover.1585349448.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1585349448.git.mkubecek@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Mar 28, 2020 at 12:00:58AM CET, mkubecek@suse.cz wrote:
>Implementation of more netlink request types:
>
>  - coalescing (ethtool -c/-C, patches 2-4)
>  - pause parameters (ethtool -a/-A, patches 5-7)
>  - EEE settings (--show-eee / --set-eee, patches 8-10)
>  - timestamping info (-T, patches 11-12)
>
>Patch 1 is a fix for netdev reference leak similar to commit 2f599ec422ad
>("ethtool: fix reference leak in some *_SET handlers") but fixing a code
>
>Changes in v3
>  - change "one-step-*" Tx type names to "onestep-*", (patch 11, suggested
>    by Richard Cochran
>  - use "TSINFO" rather than "TIMESTAMP" for timestamping information
>    constants and adjust symbol names (patch 12, suggested by Richard
>    Cochran)
>
>Changes in v2:
>  - fix compiler warning in net_hwtstamp_validate() (patch 11)
>  - fix follow-up lines alignment (whitespace only, patches 3 and 8)
>which is only in net-next tree at the moment.
>
>Michal Kubecek (12):
>  ethtool: fix reference leak in ethnl_set_privflags()
>  ethtool: provide coalescing parameters with COALESCE_GET request
>  ethtool: set coalescing parameters with COALESCE_SET request
>  ethtool: add COALESCE_NTF notification
>  ethtool: provide pause parameters with PAUSE_GET request
>  ethtool: set pause parameters with PAUSE_SET request
>  ethtool: add PAUSE_NTF notification
>  ethtool: provide EEE settings with EEE_GET request
>  ethtool: set EEE settings with EEE_SET request
>  ethtool: add EEE_NTF notification
>  ethtool: add timestamping related string sets
>  ethtool: provide timestamping information with TSINFO_GET request

FWIW, this looks fine to me.
set-
Acked-by: Jiri Pirko <jiri@mellanox.com>

Thanks Michal!

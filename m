Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14667C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D67DD206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 10:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597658914;
	bh=mhwwseTMojZKjYYfFPAsqjgfigNvODx9HTzsqIkO5hI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GYPLfq+b19qW5O9aisfyhcGtp33V+TXPNQJXJGNUTd3qDdG66v4QiuexNbyxsvR9J
	 GExESBKrKL5ckWX/5cUxKmtmXrckfran9JR/681NeEC+foM5Ioky5/Yut4lhK7JYkD
	 ME/1baXmWrrRH+hdYDWuCKbU51/NWCdmVbB+KXqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgHQKIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:08:32 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35877 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgHQKIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:08:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id t23so16819935ljc.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 03:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XhlSNhtZvHLg+bhgqbrpT6hylh072knTGhczA9B2mA4=;
        b=YLbz1cbz1OubuoDAA7IOcy4wdKPT7GjxI3f/3qS4r4vWqnyfdzcf0Wa/PDnc8zVaAH
         IxgYfkgcveBFCsHyq0W7ufKh0VydOTdTCCLxfDtjcYNM4tjtr/lS1/4B9q15+KDO2wwK
         Ujh4GslKYrFInEWlZz7IyR0/xKGeSwzCXUYJ8ao/axNyMJDum55J2ZSvkFETCVUWAk+3
         nSfoZzb7WJdR+xHFdUduLVZjN2z0NFtbtLUWL6riKFbMCfviIuxsFyXqToPwYqWWDrB7
         egUxaIg9byNkyHzL9lu7zahw8IzFu2tSAM+SudFVhR9/PF4qJ/iw+vTqutzwgfKa6wAz
         WPsg==
X-Gm-Message-State: AOAM530UDKv+8M45jwXVxpHuN1E9ueHzigKxpCmSnu3/96r6kqSwpoKF
        wOwYdhJH+UlGnAWNaBtlclA=
X-Google-Smtp-Source: ABdhPJyD/+m0rGpxyR4+YdYy2a57ZFOOj41ukpuKcL2yjP3l0AcQIxK7AYwT4qmHAmZq+vtvc9iAbg==
X-Received: by 2002:a2e:865a:: with SMTP id i26mr6711762ljj.246.1597658910158;
        Mon, 17 Aug 2020 03:08:30 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id g19sm4926712ljn.91.2020.08.17.03.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 03:08:29 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1k7c43-0001DO-Hm; Mon, 17 Aug 2020 12:08:28 +0200
Date:   Mon, 17 Aug 2020 12:08:27 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Wang Qing <wangqing@vivo.com>
Cc:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/greybus: Use kobj_to_dev() instead
Message-ID: <20200817100827.GB3383@localhost>
References: <1597289690-22857-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597289690-22857-1-git-send-email-wangqing@vivo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 11:34:48AM +0800, Wang Qing wrote:
> Use kobj_to_dev() instead of container_of()
> 
> Signed-off-by: Wang Qing <wangqing@vivo.com>

I'd shorten the summary somewhat:

	greybus: use kobj_to_dev()

but looks good otherwise.

Acked-by: Johan Hovold <johan@kernel.org>

Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04234C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 16:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C5E20809
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 16:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pensando.io header.i=@pensando.io header.b="m0I6KYnG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgG2QpH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 12:45:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgG2QpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 12:45:07 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345ACC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 09:45:07 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y206so2927147pfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 09:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=KCLCj+kEELlmTMD7QDHKj3NKkcBy7s9LRGvrZQnu9z0=;
        b=m0I6KYnGkAugRlwNdVhYb85cQfxLGhVB4yBW8C5IuKuLvlzgXlfVNykRJuQmpTNzMV
         PnQrEbRqx5Z30DzWit6Mk+xG3ePIbImu6d4qrvhYxrrxChiax19D/rk2LXVqJ66jrtTa
         ENUWH4UlGJISFjXOlB8oPPn2giSSG/O0VWMgnQbmyemJ6f90jwnm3IbVpgEMVa6EKyBB
         5pwTaZP7N1n8gVa4AQyS3jmoNCd5Dq5TKDnVslC/KVkRAT5P9fbdbXfMjc+CQt+x8Ss+
         Wcq6NB8uwejW6a4jwptntspjsZTj9RWEm59F0fCabuhfQac7FivwBid/1rtaVWz8ZbqM
         5OZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=KCLCj+kEELlmTMD7QDHKj3NKkcBy7s9LRGvrZQnu9z0=;
        b=ovMh4L13zf72tBbJiKOp3YMmoQOXI2ngbPrxtNsGo9Nljf7Rqyskvz+niyZfT5sUf4
         CbVcaLGZi46Acx0jkgTTh/wKTSGwcAxAMAaoE814YP94dgPaFm4yvyYjFBooUxlwK+PB
         hzhxbSHT56hTmpQDJYO5YpCYqpyxT2X5p2RWR57YnkjXLFTd35sbnTPYRe7AuZ7HRtDc
         NFLSiuto2cZyEM/bDpskGMOt3at1fXMbkfxw56ZGjWkbfc/mSeekQH/rszzgbmh+LuRo
         /5e54Srs8YzuJSFBaRREV0eXL44/e1dWvqLGx5/WSN+r6RjkNYDSD0rx5mKLoYMTh/yb
         OkUA==
X-Gm-Message-State: AOAM532626vuUEIuomB0DpMvn2N0i+eJXpssccwVhzmd1UkHER9g7uTt
        OLe3S4zK3u7xl13Z4Kqau8msIFA1B7E=
X-Google-Smtp-Source: ABdhPJzvwoBEDd2xj1CQKMX7hxC5hIss2Y0UQ8ssG9xZaerGcM/dwWl3hzinDP/xg7FMZJKk/0W7vA==
X-Received: by 2002:a65:6150:: with SMTP id o16mr29456425pgv.237.1596041106296;
        Wed, 29 Jul 2020 09:45:06 -0700 (PDT)
Received: from Shannons-MacBook-Pro.local (static-50-53-47-17.bvtn.or.frontiernet.net. [50.53.47.17])
        by smtp.gmail.com with ESMTPSA id y7sm2830939pfq.69.2020.07.29.09.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 09:45:05 -0700 (PDT)
Subject: Re: drivers/net/ethernet/pensando/ionic/ionic_lif.c:2004:3-9:
 preceding lock on line 1998 (fwd)
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <alpine.DEB.2.22.394.2007291836240.2459@hadrien>
From:   Shannon Nelson <snelson@pensando.io>
Message-ID: <cb1aa251-b3b4-1286-760e-58db5f63f422@pensando.io>
Date:   Wed, 29 Jul 2020 09:45:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2007291836240.2459@hadrien>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/20 9:37 AM, Julia Lawall wrote:
> Hello,
>
> It looks like an unlock may be wanted on line 2004.
>
> julia

Thanks for catching that, Julia.  I'll follow up shortly.

sln

>
> ---------- Forwarded message ----------
> Date: Thu, 30 Jul 2020 00:08:47 +0800
> From: kernel test robot <lkp@intel.com>
> To: kbuild@lists.01.org
> Cc: lkp@intel.com, Julia Lawall <julia.lawall@lip6.fr>
> Subject: drivers/net/ethernet/pensando/ionic/ionic_lif.c:2004:3-9: preceding
>      lock on line 1998
>
> CC: kbuild-all@lists.01.org
> CC: linux-kernel@vger.kernel.org
> TO: Shannon Nelson <snelson@pensando.io>
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   6ba1b005ffc388c2aeaddae20da29e4810dea298
> commit: 0925e9db4dc86daf666d9a3d53c7db14ac6d5d00 ionic: use mutex to protect queue operations
> date:   9 days ago
> :::::: branch date: 21 hours ago
> :::::: commit date: 9 days ago
> config: powerpc-randconfig-c004-20200728 (attached as .config)
> compiler: powerpc64-linux-gcc (GCC) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
>
>
> coccinelle warnings: (new ones prefixed by >>)
>
>>> drivers/net/ethernet/pensando/ionic/ionic_lif.c:2004:3-9: preceding lock on line 1998
> # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0925e9db4dc86daf666d9a3d53c7db14ac6d5d00
> git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> git remote update linus
> git checkout 0925e9db4dc86daf666d9a3d53c7db14ac6d5d00
> vim +2004 drivers/net/ethernet/pensando/ionic/ionic_lif.c
>
> beead698b1736df Shannon Nelson 2019-09-03  1992
> 086c18f2452d002 Shannon Nelson 2020-07-07  1993  int ionic_reset_queues(struct ionic_lif *lif, ionic_reset_cb cb, void *arg)
> beead698b1736df Shannon Nelson 2019-09-03  1994  {
> beead698b1736df Shannon Nelson 2019-09-03  1995  	bool running;
> beead698b1736df Shannon Nelson 2019-09-03  1996  	int err = 0;
> beead698b1736df Shannon Nelson 2019-09-03  1997
> 0925e9db4dc86da Shannon Nelson 2020-07-20 @1998  	mutex_lock(&lif->queue_lock);
> beead698b1736df Shannon Nelson 2019-09-03  1999  	running = netif_running(lif->netdev);
> b59eabd23ee53e8 Shannon Nelson 2020-06-18  2000  	if (running) {
> b59eabd23ee53e8 Shannon Nelson 2020-06-18  2001  		netif_device_detach(lif->netdev);
> beead698b1736df Shannon Nelson 2019-09-03  2002  		err = ionic_stop(lif->netdev);
> 086c18f2452d002 Shannon Nelson 2020-07-07  2003  		if (err)
> 0925e9db4dc86da Shannon Nelson 2020-07-20 @2004  			return err;
> b59eabd23ee53e8 Shannon Nelson 2020-06-18  2005  	}
> 086c18f2452d002 Shannon Nelson 2020-07-07  2006
> 086c18f2452d002 Shannon Nelson 2020-07-07  2007  	if (cb)
> 086c18f2452d002 Shannon Nelson 2020-07-07  2008  		cb(lif, arg);
> 086c18f2452d002 Shannon Nelson 2020-07-07  2009
> 086c18f2452d002 Shannon Nelson 2020-07-07  2010  	if (running) {
> 086c18f2452d002 Shannon Nelson 2020-07-07  2011  		err = ionic_open(lif->netdev);
> b59eabd23ee53e8 Shannon Nelson 2020-06-18  2012  		netif_device_attach(lif->netdev);
> b59eabd23ee53e8 Shannon Nelson 2020-06-18  2013  	}
> 0925e9db4dc86da Shannon Nelson 2020-07-20  2014  	mutex_unlock(&lif->queue_lock);
> beead698b1736df Shannon Nelson 2019-09-03  2015
> beead698b1736df Shannon Nelson 2019-09-03  2016  	return err;
> beead698b1736df Shannon Nelson 2019-09-03  2017  }
> beead698b1736df Shannon Nelson 2019-09-03  2018
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


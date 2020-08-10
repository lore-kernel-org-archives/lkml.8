Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707E1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 00:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A65320716
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 00:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHk1a2IN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgHJAKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 20:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgHJAKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 20:10:06 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32EAC061756
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 17:10:05 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id f26so6297052ljc.8
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 17:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TWLt1k5zX2YKi6sCRPWP13aF+qGzu/CFXY17A/sQ11g=;
        b=MHk1a2INiWDPvNxD8mHZ/HvoDvbVIdib3uHW6TtmXeogom0baOiu/jFakUQxESxr64
         ZJXcAd2lO2tfjNh4sUWIPMeMZgFMBHlNngrZcjU/OHFUYrt/AS5KuM+zfQZIWre0EJ11
         DwZw5Q9ayoN3QD5j1I58qEIkcKALo3DMmuidSH9Y63i4lTsDaRM2lyOl1nRgG78UjFt4
         bY/doyDPPYRGuJLmYUNgrBxRRyVpIYS7lYFR+hC+riFnCIZ1cVyIOH9D9a1+5FbdjWsZ
         HeCKo9kw4pYnzHWmO1TNQ1vk3jx+4txefsTjfAKJ1PvPvr8FKfPuds1t3B84Qk+iHs0J
         ojYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TWLt1k5zX2YKi6sCRPWP13aF+qGzu/CFXY17A/sQ11g=;
        b=I08MT2vMZ7S6KSqe/e7wRvPnjgeLEvD8LbJ9DqnmD+G3u/ucblsL0R4Rf1MdqgDHqC
         1RRI9Dohub7JWUDAmFK5Q50+Q8v4JUS6AV41uvspV+XVPgURJklHlUuv2n1DBaEREvUI
         v+jf9lf6NIx++GDASJS7Ha/HMJ1g5K5D78WZVw1sF0AyjeHoiy6hA2q3o8VFQjaPskVL
         cP8PJdEV/HLFxGwHZHd0/p9qryug2LLUPjc7StUATbcXMwdfOUsOA2bmh0bnQ683seTM
         Ci0mIkh0dQydK1VDGJW7Ctr83RmBG0lzvxCytgDNh1bBQ5jiMLk4cr9Msp/YfzzCFjGL
         MZ7g==
X-Gm-Message-State: AOAM5335xudZ7PsXNPdNa2jiNL9vRZkkyxJDGEZqiMzp4PZGCp1EhifF
        i8dwKxnNsNktIJOAIOMUyVOoi5f2
X-Google-Smtp-Source: ABdhPJyIMdHzMfLifix963oh6/ZlNqO13wZJFZusMRXZKlbibE120BW3lyAKPop1jnN02kBpxQLOPg==
X-Received: by 2002:a2e:9557:: with SMTP id t23mr10919201ljh.85.1597018200095;
        Sun, 09 Aug 2020 17:10:00 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id d6sm8698327ljg.25.2020.08.09.17.09.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2020 17:09:59 -0700 (PDT)
Subject: Re: regulator: deadlock vs memory reclaim
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20200809222537.GA5522@qmqm.qmqm.pl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <dd8354c4-a116-0714-6c20-46cacfd16a54@gmail.com>
Date:   Mon, 10 Aug 2020 03:09:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200809222537.GA5522@qmqm.qmqm.pl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

10.08.2020 01:25, Michał Mirosław пишет:
> Hi guys,
> 
> Commit f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
> from Nov 2018 tried to fix possible deadlocks when handling coupled
> regulators. Unfortunately it introduced another possible deadlock,
> as discovered by lockdep (see below), instead.
> 
> regulator_lock_dependent() starts by taking regulator_list_mutex, The
> same mutex covers eg. regulator initialization, including memory allocations
> that happen there. This will deadlock when you have filesystem on eg. eMMC
> (which uses a regulator to control module voltages) and you register
> a new regulator (hotplug a device?) when under memory pressure.
> 
> There is also another problem with regulator_lock_dependent(): all the
> w/w rollback stuff is useless: because of the outer lock, there can only
> be one contendant doing multiple-lock-grabbing procedure. In this setup,
> the procedure cannot detect other processes waiting on
> regulator_lock_dependent() and it cannot signal (wound a transaction of)
> current holders of locks taken by regulator_lock().
> 
> Basically, we have a BKL for regulator_enable() and we're using ww_mutex
> as a recursive mutex with no deadlock prevention whatsoever. The locks
> also seem to cover way to much (eg. initialization even before making the
> regulator visible to the system).
> 
> To fix the regulator vs memory reclaim path I tried pushing all allocations
> out of protected sections. After doing a few patches, though, I'm not sure
> I'm going in the right direction. Your thoughts?

IIRC, taking the regulator_list_mutex within regulator_lock_dependent()
is needed in order to protect the case of decoupling regulators.

Perhaps moving out allocations or making them GFP_NOWAIT should be the
easiest solution.

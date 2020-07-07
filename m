Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B260C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1668C2063A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:35:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="MaVN0XDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgGGIfU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 04:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727064AbgGGIfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:35:19 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22492C08C5DB
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 01:35:19 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q4so13195373lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 01:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VSt2gNx7u5TrD0wymr8ZWYE3yS5oRsktvc3jsQJqJl0=;
        b=MaVN0XDpN+6YXgXhI+/d1XIwktyVJq2MXzZmQphSJQiPKOhqpTZnASup4ownD/YivG
         0Wowib0FRUT5Wi7NYvSbFiCLeRfSPRu2yaXncXj7GDvA+bHhz3kXWn4UOeps5lqYW6u+
         7XVUihn894JZD3TC09c3XR3v7f5icLOgjcfSmnEMy/WMTzIAbTWpDB3ZgWuaaWbYVzp6
         HjNb5Rv19G39IONz2dp7wYJxfdKf6txXu7aLF/hrJJYXmPWcznshP9N9/chaZfeEmrdj
         81TWlSuoJrAMVyiehInhNEKw6xi6rX5yYfHCsVP191LzBSqCs+MKboOs351cGw7xNfdN
         PnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VSt2gNx7u5TrD0wymr8ZWYE3yS5oRsktvc3jsQJqJl0=;
        b=C8B8ittC+WT98XZYqMZrlBzkaoukwFKHAFFrq+Z6hOP3HkuavYl7NJqr7x/QJh9mGU
         U/Q5JXP66qcer+USbrR0ZiKzDWILabRAgpAAPBnhS8ecbQiEKiAA7Cuf5Rvugp0Cgfih
         nMqycRxXd+SKRqxTf5dCo3AS/7qOsQ67LXYSYgr8xrqetSVju3A3Cex3gzmS4KG1kyZf
         cXvyJKVD/MQ8EtzdXgfMfFBWNgB829hMnZxxBHt8jOP7zX4wyfJMmYwRdwzrUUEe+AdV
         eA6ygW5+3XwqZO+t6nDoFmOQKlZxcJMkb28RbRr7SkyYyA1VU//1ZXtsj+/ybB+efPNJ
         dCug==
X-Gm-Message-State: AOAM5316x9ZrrnZsguKwot9qZeAXpSA3ya6o64XnJiVrkeW8jGyQOcyF
        STrrHxViPf4t7v3srf3VvyaV6Q==
X-Google-Smtp-Source: ABdhPJyL8zCRmUmt9EUAMx/qZ2oMUFwZLKzoSi2UGulxyukwEAxXwTu09QNmVeVfBnsbIwB+vB638Q==
X-Received: by 2002:a2e:4b12:: with SMTP id y18mr26715115lja.117.1594110917491;
        Tue, 07 Jul 2020 01:35:17 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:4609:f5ea:9102:8276:8e24:1626? ([2a00:1fa0:4609:f5ea:9102:8276:8e24:1626])
        by smtp.gmail.com with ESMTPSA id i2sm9381ljn.109.2020.07.07.01.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 01:35:16 -0700 (PDT)
Subject: Re: [PATCH v3] usb: gadget: function: fix missing spinlock in
 f_uac1_legacy
To:     qiang.zhang@windriver.com, balbi@kernel.org
Cc:     colin.king@canonical.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20200705124027.30011-1-qiang.zhang@windriver.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <09b2225a-d9c8-c40f-1e73-e18ece80e3bb@cogentembedded.com>
Date:   Tue, 7 Jul 2020 11:35:12 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200705124027.30011-1-qiang.zhang@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.07.2020 15:40, qiang.zhang@windriver.com wrote:

> From: Zhang Qiang <qiang.zhang@windriver.com>
> 
> Add a missing spinlock protection for play_queue, because
> the play_queue may be destroyed when the "playback_work"
> work func and "f_audio_out_ep_complete" callback func
> operate this paly_queue at the same time.

    It's play_queue. :-)

> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Zhang Qiang <qiang.zhang@windriver.com>
[...]

MBR, Sergei

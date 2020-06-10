Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D23DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 02:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 070C920734
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 02:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sK8rI60A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgFJCWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 22:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgFJCWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 22:22:00 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E66AC05BD1E;
        Tue,  9 Jun 2020 19:22:00 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id e9so284015pgo.9;
        Tue, 09 Jun 2020 19:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=6MDJxP19WPGYDK5RYXnflZJ1FBWzKzFWdzGVhyzU/Lk=;
        b=sK8rI60AsbWsh3JwhXzYcXyAkUhNHSg2pbGU2IX1PaiSdhY41fcfiMd3U9UxqkcM/t
         bLihMU3wAZlB64dayGyl6qz11RNWB9Dc7jIfvnXJqZlUI0PuJWys60vW+OZ0/tPTy96f
         GbtZPqawK7zvLXWlSpolLOTp0711JoWQT9PR8h0kCwb/gA1KVxZ9IwCm3Nx15sjmqN23
         A/4dpBuCWPfvwVspmyzYn8grolZC/Qglbkq1ufgDWJX+FvjgnNXu85WUOaZJEHIOZXls
         cl+vwwWpYx79bIiPfIZiYN+Rwv3uwvmVWm0p6L3QRDQ0en/yeCmJ3EJO1Vmm8DJCCGsf
         vYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6MDJxP19WPGYDK5RYXnflZJ1FBWzKzFWdzGVhyzU/Lk=;
        b=Mx68GPj17ldSddFiGhwVPg+NzKNrG+CCC2hG5ZQNnkQhNo7U98K4ly3SZfu5nneA8e
         POBoKLQhGSJxspJ8ZOgtSS+ZB/zHgw71aBoGOPsHXf+5pZ6hK9PCt7vC3PmWHEstMeN/
         dqeKmIkkMqPLBRnKw6PSRaH0kqpCc3ICr6cH/kfmjZ0dbVXt/gCqIG3DEsD+RLn2ijlv
         u++UxelXZ7865xkS/j0V6Mr9Tp5x2PyzXTReOYJmeyiWZAOlDWPchb6i4BjUahOPnIqY
         3B/YmcSmXU/+j9HjtGA2Ndx+G6sdtAHuCzUJVzVDslK/If3h4SMYqWXuTLtsN4MX//X0
         c8Yg==
X-Gm-Message-State: AOAM531dzhUdO108ZdetyR/aFL3sDLQy/GdBneyDTu/t/XjSPsBO4guF
        oqaSOC3qS+AwitXjbjK/hW0=
X-Google-Smtp-Source: ABdhPJzhBd02ppYU69Tbttf4OygJ4jKSUHDwxH0mbLQ80yfFlk2lgSGlv77qWFGMBQvEjdbXdu5bIA==
X-Received: by 2002:a63:6dc7:: with SMTP id i190mr781038pgc.171.1591755720098;
        Tue, 09 Jun 2020 19:22:00 -0700 (PDT)
Received: from [10.230.188.43] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y23sm9328956pgc.78.2020.06.09.19.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 19:21:59 -0700 (PDT)
Subject: Re: [PATCH 4/4] mips: bmips: dts: add BCM6362 power domain support
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        hauke@hauke-m.de, zajec5@gmail.com, tsbogend@alpha.franken.de,
        robh+dt@kernel.org, jonas.gorski@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20200609105244.4014823-1-noltari@gmail.com>
 <20200609105244.4014823-5-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <5876ff02-5cc7-961f-eec7-95449fd2adae@gmail.com>
Date:   Tue, 9 Jun 2020 19:21:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200609105244.4014823-5-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/9/2020 3:52 AM, Álvaro Fernández Rojas wrote:
> BCM6362 SoCs have a power domain controller to enable/disable certain
> components in order to save power.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

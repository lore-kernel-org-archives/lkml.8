Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCEAC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 04:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09045207C4
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 04:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uKFKfeqw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgFNEv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 00:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbgFNEv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 00:51:29 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D10C03E96F;
        Sat, 13 Jun 2020 21:51:29 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id k6so477315pll.9;
        Sat, 13 Jun 2020 21:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=GPdUnLBBlI1W+2fQHzzwL32K7KSISeO1ca9MabQWUn0=;
        b=uKFKfeqwEGgC5L/xU7SuS7HBJVk1KXUR93JW8ta/5JeXrgYZUwuigQ859Ax+1wjQ4Y
         qblVsmk+l6yQg8bkjsURu8mx+4/WjZQXzWBKZ8pTlsTkaWa90B8wBLgVUpZ9OA1RreQa
         +dwqYHU30jCFTDYRNFyxrl/tJPSyqomCEsc9g+bxQebn5b+KoNueyhQ7fZuAfw84nyLC
         g70gzD1J3fdKl7OuMP4UwM87RF/0VjuoQC+FZwMBmF6iIONSKv19By9gLXZG+1JuWsFs
         IyC4GJ+hq34lF0eAVgdKmQ63A2j/gvjVdwbJOV5sCXYlLrp7NPAtSPwoc/uCSqRYBXOz
         JISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GPdUnLBBlI1W+2fQHzzwL32K7KSISeO1ca9MabQWUn0=;
        b=j89VV/NYwUhzWDtbQR07APb/YRNAIAF84H5L4cwi44qGQ0ryUr/28iQLCliiaFI6ju
         gW/58pvIgCy2aEpNK9tN5TdIqB4e1dnnwZxAVQoE+hq8KpZMGXRPq+WB1s5uQmBfc43M
         NOEvEXXZOQ/LIOwiivsKPQk62ZPsV+5kesi2KF6AnTXgkdODd03xKrToGniUEl5jcUu6
         MWVhWlKcU5kYgfxY/PoH1hj9aGvOGDzqLSjGSWjSDBh36GSRqYqOXgerbruzSrATOg1G
         FXuOX5XxEkuZR4PtDUJcK4FO3wwQVET1hRSmFJwuvuHcX5gEYcIv0euMb4aJL7m4Suoy
         eLOw==
X-Gm-Message-State: AOAM532kQoBHjb2Bfe11ULYy5uC718M6OkmK5Rf2XgROCRgAc0ovWSeG
        wvPeCd7R3xyAT54xlsriQi0=
X-Google-Smtp-Source: ABdhPJxio/0T/lFZkIX0NKGFqr9UESJToTmjv16qgMVQPATv7LWdeDb7ONQ2C9TQrAVWt1fQ/lqjqg==
X-Received: by 2002:a17:90b:4d08:: with SMTP id mw8mr6083654pjb.119.1592110288770;
        Sat, 13 Jun 2020 21:51:28 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id y7sm10091984pfq.43.2020.06.13.21.51.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2020 21:51:27 -0700 (PDT)
Subject: Re: [PATCH v4 9/9] mips: bmips: add BCM6318 reset controller
 definitions
To:     =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        tsbogend@alpha.franken.de, f.fainelli@gmail.com,
        jonas.gorski@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <20200610172859.466334-1-noltari@gmail.com>
 <20200613083813.2027186-1-noltari@gmail.com>
 <20200613083813.2027186-10-noltari@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <3af9c4d5-2454-c41a-36da-df2cf710d8ce@gmail.com>
Date:   Sat, 13 Jun 2020 21:51:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200613083813.2027186-10-noltari@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/2020 1:38 AM, Álvaro Fernández Rojas wrote:
> BCM6318 SoCs have a reset controller for certain components.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>

Acked-by: Florian Fainelli <F.fainelli@gmail.com>
-- 
Florian

Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F23C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 13:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE66020679
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 13:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHDGDdA6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729089AbgFVNkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 09:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728605AbgFVNkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 09:40:46 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A217C061573;
        Mon, 22 Jun 2020 06:40:45 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c21so9630226lfb.3;
        Mon, 22 Jun 2020 06:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DKCkItewvHrTs2k8QFit3hIhI+zhzJPCW7qZry58T7E=;
        b=RHDGDdA6XvMPld+h8oVQ8VGqWtamUH9IP3s5O0umg3aViAetdlw9ndoFXIJpIjBlLi
         iS67pOYWOuahjaNkD93Ma4eRoyUP/EMuQU7KNAH50Awf2qeT4sbcw4HVr6lL3NCvOpBH
         c/KFSklOKmoi/e8uwKH3MOhkHM21xI7TqEllbeP13qKBbESFXswZwdHMOuEbWWlSgIAR
         rnjWYNQ3KIh/jU6bgNWOwTRZD0Uyakw/hnTIQ2UtKLwtlaO9F7+rfy89z2csJxhs/sOu
         jiDSp+ODov/6TyAfZLeVUJ1TNKrtpYd7B9+x2MBh/dsPXRDqfWU0aABpr9T4Kc32excw
         EyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DKCkItewvHrTs2k8QFit3hIhI+zhzJPCW7qZry58T7E=;
        b=EqeQIpKQ7ww9S1w7CYA7yvbUSP8jb0R2yy1Br3Rt39LKsN3xi18KVM/MJxo+hcrt0n
         H0QbFxX8h2HDgtLpRFczPDaA0x9PQKiXNQpKjxM8VjatJWZMfzlGq+ZD/lSWdE4t2hAl
         bSvJo6m6m5LNpu+jDqsl70I0PA64CXlWGg6ZsRGADOzAc1jCrBagJxUNtiZt8wwsdIVa
         qDQPZxmuKGkP0qNk6S0LU0+ME2A9As+ni3IGGrwzv7FbrD5QXuUny75ghuDtgT8mvGKM
         P/QQ9gT9ZCqYh82a511gI+eSRUHNRmxjCyM55qqMkJ9fHlJyApuf8B8CCQYfBwTJ9sG1
         59xw==
X-Gm-Message-State: AOAM532WhEtP03ndpPhysNWLXH6/BKoIB6TiNPzu1ZGfrnzPQXkqjUDZ
        eJWyoYqHk9Qq8ZtOyGP+5/Kf87nC
X-Google-Smtp-Source: ABdhPJyPdQDJrLqZNuusxWqg0pbI3BD5XgSX18Loo0iV3cZZRStbBPxOt63+mnY4/gAitUUv+Fa2VA==
X-Received: by 2002:a19:4285:: with SMTP id p127mr9320654lfa.74.1592833243786;
        Mon, 22 Jun 2020 06:40:43 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id s18sm3183832ljj.63.2020.06.22.06.40.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 06:40:43 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] drm/panel-simple: Correct EDT ET057090DHU
 connector type
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200621222742.25695-1-digetx@gmail.com>
 <20200621222742.25695-2-digetx@gmail.com>
 <20200621222922.GA25355@pendragon.ideasonboard.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0974c58b-71e8-623e-cb04-d19a5167a30c@gmail.com>
Date:   Mon, 22 Jun 2020 16:40:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200621222922.GA25355@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

22.06.2020 01:29, Laurent Pinchart пишет:
> Hi Dmitry,
> 
> Thank you for the patch.
> 
> On Mon, Jun 22, 2020 at 01:27:41AM +0300, Dmitry Osipenko wrote:
>> The EDT ET057090DHU panel has a DPI connector and not LVDS. This patch
>> corrects the panel's description.
>>
>> Reported-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>> Fixes: 94f07917ebe8 ("drm/panel-simple: Add missing connector type for some panels")
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thank you! :)

Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4821BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:48:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14566206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fxTHC5rL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbgGHPsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728777AbgGHPsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:48:38 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 251C1C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 08:48:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id j18so3768377wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 08:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=mCGlXJbPz29nuSuX3AsD3+lrQ3NSO5N9mbtfPf6Q12A=;
        b=fxTHC5rLWr4pv2K/FclgqkgW+EsmDkMo02gBnq/UclXkEnbt1+YMqRF1s8g0I/rtcC
         uq0IZ8t0o5wWwiU8zYK3MZgkp5mUVqT2mhK7loqVsg8ojgJkBjHu1zpuV5BVH9pDnnX1
         xqSdFFqWYolDNiqy77wS7aTgo0JMPp93jTETKGBC6AN9z6CBXP+F+HfO6Vr3N7+MlU55
         024Hqhe7igvxKVoz2kwLSmj+b/g7eVC+52u+IbU64OnIC/9QO8nl0R7DB09P8m9xgV8T
         7tJsZ6UxISl27hOIP8ZFjMe4xSIYRamw737u3ryYU7TPy/3wjNIHEpDAwBtIT9fnn7AV
         jYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=mCGlXJbPz29nuSuX3AsD3+lrQ3NSO5N9mbtfPf6Q12A=;
        b=BObafB8Xd48bQuwopwfyacUG8JAr1Ohzn4vbH0EJkUHQogoQJnEP2kYMdG9NcCTC7z
         iRlLWEqM9vxhw4zhFsMGQaBnEYU1B0JWZC6leISblxBcR+6zha8RgBqdC9Je0WiFCWTv
         9FW9YEaMfHAhZ/gg0mt4Mbmt+LB/gGAX0Dxi0ycoEx1DmOA5p70R5m0lmueOL4y2pUbe
         2ltfu8QDKS9pa27PHupnL2SIeSPEKw/zkL1ZNnqGZh63Ara93e7tAW/DYaZDC9aN/Bp3
         wS4umUhJQgfQ8u55IuzCOKkIwYroxQPVEHmzfbN8R0IfmATG+DSb2bBnaDhotLNJz3Mo
         uRGg==
X-Gm-Message-State: AOAM5323925M65O2S7C7hIAlSTaM0c4uMocEMlWYhQbXXWntZ5PAE31U
        tJQazdUsLimG8R/qgCDhEKCFW/mn
X-Google-Smtp-Source: ABdhPJy1BP6aRMyI4ALwwd8TO9LqG2ZoJGkKfB/kJyRiaqED9vf7VHvWR/OHiyWFI7rWd7oEPeo1Kw==
X-Received: by 2002:a1c:cc0c:: with SMTP id h12mr10618301wmb.140.1594223316604;
        Wed, 08 Jul 2020 08:48:36 -0700 (PDT)
Received: from [192.168.1.64] (bl8-158-27.dsl.telepac.pt. [85.241.158.27])
        by smtp.gmail.com with ESMTPSA id k185sm204577wmk.47.2020.07.08.08.48.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 08:48:35 -0700 (PDT)
To:     linux-kernel@vger.kernel.org
From:   Andre Coelho <andrealbergaria@gmail.com>
Subject: linux code
Message-ID: <3e091370-53d7-563e-1b6f-3a6febb50533@gmail.com>
Date:   Wed, 8 Jul 2020 16:48:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

i had an idea to implement functions as "raw" and not use libs...for 
instance

strcpy(); (instead of calling the function, write the instructions on 
the source code)


what do you think of this?

I would like to get messages and comments (cc)


Thanks


-- 
André Albergaria Coelho
andrealbergaria@gmail.com


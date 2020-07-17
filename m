Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5C9C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:29:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 486C220838
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 03:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u/vFuHb1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgGQD3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 23:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgGQD3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 23:29:52 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20475C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 20:29:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j4so9473609wrp.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 20:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ky3pimPFweyNfqvYDv94PBwjLv7m1EFkI2rLzTVNn80=;
        b=u/vFuHb1WW8fkceQ5PEdGBeX2vsMWW38dATV/hPehexhtQwCgSf3c2FPbeJWVdeUnn
         1dbaEryzEkDiqL6txThpuuAwMvzoiPC/yBl9WUrv3yNuPUpZv2IGvuHxcW/gXBrk5d4n
         FCH83dMO1ZnNZdGoOHcKaAgaTdrHQ3FbN0od9sdM9vj4rGycjikiyQlmmDFJ5odSP+3B
         23p6nUVFxddmaJouarbtK78LvDaWwUiCyrNAqxnP9tuMRqUO6FO+yM4+LrO3/popZto2
         Sjsa4tKp0kyAdZDoaNv8g5D8Uy1CBPf6TKngT/pu85OsrrMM0R9olj0AyJPOko5xKewJ
         Oo0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ky3pimPFweyNfqvYDv94PBwjLv7m1EFkI2rLzTVNn80=;
        b=Nhot0x1HvBtPqTVSNHNkSt9hiymJzFsz/0c17MF9Bv3DtUFg7sH2OCFmP/jr74CSB7
         E7apz/6fsar8FAP4dbB2uhYPD+jC15gFEGUk4SHNOSIUO4WfR9R14QHMKKV0VWN4Bb85
         ZKsztl+t+q63+mRnQh0C3zsv+LDcGFiICC00yeGJgQnD0rYIH73nHqsUJ50l1AYDZ2FX
         gcwE5KeHTLwkY1w75ODHAzqFO1mHWHUueKTxTUl084VDYRxu4YbMph3v2hALmSxP3Xkc
         vBq42Ykm2vwwYp8uKIyTJbCvFV6T8QR3vGly/fthyj1gq+HkRQNfOvdwR3ZiD4UuWdbY
         6oYQ==
X-Gm-Message-State: AOAM532wuio8aejk9vQ+KT8lFoWCMsLWWy+KNndDZ/rgSiBAyREhZufz
        vx/c1hfDBZLz+/s0oRP+vXADcM5m5B4=
X-Google-Smtp-Source: ABdhPJxVj+MCX4B7lZxB8OC98GAdhDHzTIgAkM0BbLc56W0D8a4XUldJtOaPBu/WIyXmWeuxXra6sQ==
X-Received: by 2002:adf:c986:: with SMTP id f6mr8226495wrh.168.1594956590391;
        Thu, 16 Jul 2020 20:29:50 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9880:a643:3e69:6393? ([2a01:e34:ed2f:f020:9880:a643:3e69:6393])
        by smtp.googlemail.com with ESMTPSA id g13sm12505902wro.84.2020.07.16.20.29.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 20:29:49 -0700 (PDT)
Subject: Re: [PATCH 1/1] clocksource: Ingenic: Add high resolution timer
 support for SMP/SMT.
To:     =?UTF-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, hns@goldelico.com, paul@boddie.org.uk,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, paul@crapouillou.net
References: <20200526162154.15443-1-zhouyanjie@wanyeetech.com>
 <20200526162154.15443-3-zhouyanjie@wanyeetech.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5ddbc182-dd4c-b880-7a49-9ce120f3309b@linaro.org>
Date:   Fri, 17 Jul 2020 05:29:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200526162154.15443-3-zhouyanjie@wanyeetech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2020 18:21, 周琰杰 (Zhou Yanjie) wrote:
> Enable clock event handling on per CPU core basis. Make sure that
> interrupts raised on the first core execute event handlers on the
> correct CPU core. This driver is required by Ingenic processors
> that support SMP/SMT, such as JZ4780 and X2000.
> 
> Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
> Tested-by: Paul Boddie <paul@boddie.org.uk>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

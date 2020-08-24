Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FAFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0111420720
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zh2M+CRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbgHXHTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 03:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbgHXHTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 03:19:50 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84836C061575
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 00:19:49 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id t14so7157641wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 00:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A4jrcUKhNyq6Ips6PWENqMHRhy4MlDm4qFkTIUeY6sU=;
        b=Zh2M+CReCdB2DseDfEg+S/ILDu5sh9phoSgnmyvis+VRzOt3gmJamiBVybr2DBJ0BY
         cikhFUufbOjs789a2MCxgb3HIjF5D3/xa9DbYXZ0kRAf8tfyA2EUfVcpGdTcK+FZOJ3a
         rjti/cvJ4St0QbexsEFngNr4lWMcMRkIyU1WhRatyXjQh4bPiTByH5oXVqfnHTU/AiuU
         gZAwrZL92ny/djvuJ23htyoYiQ7ATW6XAODpulq8J8gGmAaE3lUt49DwuCXZgQiTVgz+
         vMXraotcCTAvaMM2+fq3QYvAxb/HA0ah5c3QYsx4ZXyMlPXFLS/5OA0QGc7MwEeo0NbG
         Wi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A4jrcUKhNyq6Ips6PWENqMHRhy4MlDm4qFkTIUeY6sU=;
        b=p8EpInW08JmBhqOvgzZDn7CNnWARMeaJRJenRIt33l5mW7Lx8tWjir0+ynfMT8C5i1
         n7buDZHKj7uPBaddwZdYtNkgZUXqh9TJUVr24Ye0psT21L2RsKOjgR7e4uZT8jBTDPHW
         qGdg9hXtaoSotUgim2K/Dl0I/gXDLoyYrSK+WubelN83AhSPdhpmUDBAEOloQKIEjfO2
         bg/wNRmWB3j4ETVFiUXnf4v4jJzRTG1oT5FdSTM07Uytzo74A/zCELZir3jUZEwT2MKJ
         KN8bJct+bGBlkQ9obysoKgSeUY3dYJVsIXldavFkWm1hqoo4RqWQVj43WgxhJEUOVnt2
         ySTQ==
X-Gm-Message-State: AOAM530RuPs5kB1RlyE2jetYjlGOIb4iAgOxvfWLXnnLsyd9hkHzt+XH
        c9bmA5nIdIah0Spi5IMPGhlrCmqp+q5mZQ==
X-Google-Smtp-Source: ABdhPJxSuUa0KM13DRe5+ateKWf+FPyJpUyDzLii4cr5Vd9MNz3oLrpbagXrGXXemMNa/KjKiddxrQ==
X-Received: by 2002:a1c:16:: with SMTP id 22mr2436523wma.75.1598253587747;
        Mon, 24 Aug 2020 00:19:47 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:cd42:2fa4:120f:76b0? ([2a01:e34:ed2f:f020:cd42:2fa4:120f:76b0])
        by smtp.googlemail.com with ESMTPSA id u13sm7501851wmm.20.2020.08.24.00.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 00:19:47 -0700 (PDT)
Subject: Re: [PATCH] drivers: thermal: Kconfig: fix spelling mistake "acces"
 -> "access"
To:     Colin King <colin.king@canonical.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200810082739.48007-1-colin.king@canonical.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <c317ce98-c20d-3c24-2f77-1758dc784de9@linaro.org>
Date:   Mon, 24 Aug 2020 09:19:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200810082739.48007-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/2020 10:27, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in the Kconfig text, fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

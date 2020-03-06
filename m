Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7EEC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 361C320848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ehVOXLJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCFOtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:49:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50754 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgCFOtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:49:21 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so2761937wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 06:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1+4/YwU+Usb1oVmJl3//eNyzmJTWp3zz4UR1oIfLCA4=;
        b=ehVOXLJ+CwITW97dFDoPyd0CdcL469/JhP/WWjWW77+mY3v64PBKTkfmhKQ153C3jL
         X8JMXKUeJV5WAYf21tKvLzaaO5HQ665xAfsI6AaqCOWD3jFxiW0A9w9+yeNBkgVl4YBq
         6Ydt7w6e1gnqUkyEd2xhkqcne0EucC0uBovpHsKSj2mdtNsV+smfZhpErvXT3gS8bKDp
         GlKcWkwY+HeT0JqIfHt4K/zGb/ir2RfXEfUf3ZsfqOZY88+a+TghVpOxYCfkEomryep9
         QGY7Zdb7JSUGUIHgZeYUg/QmM1r8VBSjPkKKTXTnkEbd75pcYJEgty09U/Sf8+xp9G5Q
         8Ylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1+4/YwU+Usb1oVmJl3//eNyzmJTWp3zz4UR1oIfLCA4=;
        b=jcnUEqgBtEtY3TgX5v/GHVJuLvdnOUMW5pFkc9AihS7Qe2IN82/Dn2XvVQL3XhD6t5
         A36ShpgR7enikAZ5HULPTQSA7cUboGiiYs7dcVx44+myqAGkF9QBJoiJzzngcBDyoPIc
         T+TPA4fxQR0++iiraOZ/zT8p69AXfvy1SxA+1Zy0RZ0JQ9wCb0hkWnbQN8ZXD1cl1mEH
         jL08xiBJvHK4vaEjzdWGdewrjhwPhd/mk/td87fsWWG3cfnnQJC2iXr8FIPuLJsHzQLf
         Q0I01NPfqMgDImBig78PBZfFKhNknFooPo7P2mBRqz5P5QFOMuGDkOv9u7u9LBiHGc0e
         GR2Q==
X-Gm-Message-State: ANhLgQ3koQCxSh3BvEbI0HJNjjPhyj+RXW6ZWCEE/AJ7zO6CpSC/utSt
        yJo8VBHy6VS0kkt4WcSG0ozSKg==
X-Google-Smtp-Source: ADFU+vt02skvUOmOWeCxPPtGgBlvv3qVC+uHoHPL2OtEEJqDaFpuamb9odBmp/vuBHnDMyRkTFU5xQ==
X-Received: by 2002:a1c:bc84:: with SMTP id m126mr4339612wmf.171.1583506160216;
        Fri, 06 Mar 2020 06:49:20 -0800 (PST)
Received: from [10.83.36.153] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id q12sm52080489wrg.71.2020.03.06.06.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 06:49:19 -0800 (PST)
Subject: Re: [PATCH -next] selftests/timens: Remove duplicated include
 <time.h>
To:     YueHaibing <yuehaibing@huawei.com>, shuah@kernel.org,
        tglx@linutronix.de, 0x7f454c46@gmail.com, avagin@gmail.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200306031705.25008-1-yuehaibing@huawei.com>
From:   Dmitry Safonov <dima@arista.com>
Message-ID: <d2dd6da8-b24c-ead8-f66e-2a8c532a8830@arista.com>
Date:   Fri, 6 Mar 2020 14:49:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200306031705.25008-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/20 3:17 AM, YueHaibing wrote:
> Remove duplicated include.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks for the cleanup,

Reviewed-by: Dmitry Safonov <dima@arista.com>

> ---
>  tools/testing/selftests/timens/exec.c   | 1 -
>  tools/testing/selftests/timens/procfs.c | 1 -
>  tools/testing/selftests/timens/timens.c | 1 -
>  tools/testing/selftests/timens/timer.c  | 1 -
>  4 files changed, 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/timens/exec.c b/tools/testing/selftests/timens/exec.c
> index 87b47b5..e40dc5b 100644
> --- a/tools/testing/selftests/timens/exec.c
> +++ b/tools/testing/selftests/timens/exec.c
> @@ -11,7 +11,6 @@
>  #include <sys/wait.h>
>  #include <time.h>
>  #include <unistd.h>
> -#include <time.h>
>  #include <string.h>
>  
>  #include "log.h"
> diff --git a/tools/testing/selftests/timens/procfs.c b/tools/testing/selftests/timens/procfs.c
> index 43d93f4..7f14f0f 100644
> --- a/tools/testing/selftests/timens/procfs.c
> +++ b/tools/testing/selftests/timens/procfs.c
> @@ -12,7 +12,6 @@
>  #include <sys/types.h>
>  #include <time.h>
>  #include <unistd.h>
> -#include <time.h>
>  
>  #include "log.h"
>  #include "timens.h"
> diff --git a/tools/testing/selftests/timens/timens.c b/tools/testing/selftests/timens/timens.c
> index 559d26e..098be7c 100644
> --- a/tools/testing/selftests/timens/timens.c
> +++ b/tools/testing/selftests/timens/timens.c
> @@ -10,7 +10,6 @@
>  #include <sys/types.h>
>  #include <time.h>
>  #include <unistd.h>
> -#include <time.h>
>  #include <string.h>
>  
>  #include "log.h"
> diff --git a/tools/testing/selftests/timens/timer.c b/tools/testing/selftests/timens/timer.c
> index 0cca7aa..96dba11 100644
> --- a/tools/testing/selftests/timens/timer.c
> +++ b/tools/testing/selftests/timens/timer.c
> @@ -11,7 +11,6 @@
>  #include <stdio.h>
>  #include <stdint.h>
>  #include <signal.h>
> -#include <time.h>
>  
>  #include "log.h"
>  #include "timens.h"
> 

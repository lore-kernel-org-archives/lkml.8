Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE14C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 853BD20899
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 02:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8dKwqMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387945AbgFRCxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 22:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbgFRCw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 22:52:56 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61099C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 19:52:56 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id n24so4806899ejd.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 19:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lyuCHzRZOly3YN2RwSLfMIi4U3yEYNmX2xGRuqPMl4Q=;
        b=M8dKwqMYmYlYLVkkekxueIpbtGvaApi2cb/eRyGZayTasfyFuP7Xp8fQlB4WVwr6Ze
         PMuKqCPFBSZYelQMEGv0ZHQr2me/9duRSbV37jXlzKeL5xMmosH+AYC2m3drFBdkqdB8
         GxWIeUq1QUR1JtiBUpUlsS/lBh8Sgp4CGuEMEWyqd+NA3kU6aYBawa5qWKZk1PtFS/L5
         ulVqf++PHJJtNKy3J1LYeIAWxteseu6uq4lqdWWwEaTTt6GtoYhm5lMJR/SS7qjHiTij
         dNyMPkkpSyrS47oirMGVphS4+SedBG0wD54AXqbytMzSz7DMGGOV0OfXW2kxFtQ007yl
         MCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lyuCHzRZOly3YN2RwSLfMIi4U3yEYNmX2xGRuqPMl4Q=;
        b=WOy68OXc5S8UuNJz4Ve5j/RFQl8tJGjGSjpBtOZ1VgIgXhAO41l1IQWBwNnczJ6V3A
         wNDlr1nH8Se130TXGUHVdF9XpjpAaZ5MF1+h/MKQN97hyu+x81wZMyUgOrWpDLQkY/JS
         HlBlqAZxWyw02gpYmr8FHJglLYi+vmkZnsUilzDgk6GV9QpKZnlTJ6/J6T+m65qyQ2/0
         7xHP7XJEyR8bJLZ2/pNhyA5RFrYK2SF3E9g/zV9a46VbHgbYUxvO9dybOGhz3wCziYM6
         GcqqPxprrSXmNiKxzpZyRqcCYUkAc0av0EAnJkFEGXPgogz0rYsopsZDb4vYmy9dNv5v
         3IVQ==
X-Gm-Message-State: AOAM533ISHlnyDRsnH4FktmlTSvPMY4kFbLC+GwI0JbM5U9XwxZIGqwe
        A8g5bWwOduV+qpMrYKsL6yIrLi6q
X-Google-Smtp-Source: ABdhPJyAd+HaslxPq/S9zMxmzZfDYYpASsSKOKvGjdbZS8eU3dVTzAbsJVSQIHonHrLJFpt8XuB/wQ==
X-Received: by 2002:a17:906:5f93:: with SMTP id a19mr1998450eju.10.1592448774865;
        Wed, 17 Jun 2020 19:52:54 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id jt16sm1258728ejb.57.2020.06.17.19.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 19:52:54 -0700 (PDT)
Subject: Re: [PATCH] tools/thermal: tmon: include pthread and time headers in
 tmon.h
To:     Markus Mayer <markus.mayer@broadcom.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Brian Norris <computersforpeace@gmail.com>
Cc:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200617235809.6817-1-mmayer@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <f5e160e0-ac4f-8c14-d06e-38f859690ff9@gmail.com>
Date:   Wed, 17 Jun 2020 19:52:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200617235809.6817-1-mmayer@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/17/2020 4:58 PM, Markus Mayer wrote:
> Include sys/time.h and pthread.h in tmon.h, so that types
> "pthread_mutex_t" and "struct timeval tv" are known when tmon.h
> references them.
> 
> Without these headers, compiling tmon against musl-libc will fail with
> these errors:
> 
> In file included from sysfs.c:31:0:
> tmon.h:47:8: error: unknown type name 'pthread_mutex_t'
>  extern pthread_mutex_t input_lock;
>         ^~~~~~~~~~~~~~~
> make[3]: *** [<builtin>: sysfs.o] Error 1
> make[3]: *** Waiting for unfinished jobs....
> In file included from tui.c:31:0:
> tmon.h:54:17: error: field 'tv' has incomplete type
>   struct timeval tv;
>                  ^~
> make[3]: *** [<builtin>: tui.o] Error 1
> make[2]: *** [Makefile:83: tmon] Error 2
> 
> Signed-off-by: Markus Mayer <mmayer@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

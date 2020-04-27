Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D981C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24B2D20738
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qv7q+HQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgD0RNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgD0RNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:13:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386F5C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 10:13:36 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d15so19845303wrx.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 10:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8R9bSwl/J7P81nQdPOmr5lSfIYOo3b9iphlZL1wJKPg=;
        b=qv7q+HQ9kd3Dp+kLeQad/wlNiJsl+g/jLf4HnqCrRUKpNwAbV+opyHaaNEQH4KiHKl
         Lo33OkY9dOw93RQnOyrX3q5DORMB0ITRh1ce9C0iYNrQX8F1YWN7g4JaPl6SvlwKjbI7
         NSn2ITENeZ7r/dZmxJCyerVFZfJ1t0pcSix/GrJfpOfGn55TNsPjFGvVpsfn74jRPMGP
         IHl/WxA7apNHrNOO48NBKtL8WyvlbJZuqcQJEA3sY9zPdFe7IMaW1pkGy8hgv5qk9kAP
         uau4t5HQxt1/Ib4iRAZ3squd0EKnm9+MTlqCAKkEgCEvA9BrsTUCHS9PwIqcYJ1kTCES
         uHBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8R9bSwl/J7P81nQdPOmr5lSfIYOo3b9iphlZL1wJKPg=;
        b=rw3bnGbghBsVFfbO+r0QlEbMkPgoqlgbsnxb2jMxWyg4pF3PW8yp1Hrsr66dSqX/ty
         0GgE3vpHoAtRVdCmEvv/hQnC06Ge7ZPZRjDWsSN5TmvFm5MkBwubxxf3lW/n1VsufVSH
         lJvDdQVv2CxgdUwUAJL9R/uAikG8dyaacf8LwgLTShy2LopjT+IIDkXfWvtuTrv4y9Rq
         k5F2dCXC7RCfqSkUFVt+dpHdoDPUZolS6r16fh+Y7v5isZOsmodlIBVfh0ikAbGZOgVz
         veJhLf72txwVDZxEGS9vAlgwVCuFyHfrtyM5Kn9ABlWPYCSvp/YTJsnlkAlMp8sOKrwl
         aVhw==
X-Gm-Message-State: AGi0PuaZinSIQwP428txuOj/qPJGBNgjv8J+TZjKDoAZIUoga5PE6Zue
        6USv+xfUe6pq+1yT7tAOBoj35A==
X-Google-Smtp-Source: APiQypInI7PA6UMX/pE+l61c+qeNhBE9E5JGRoT2thPBw7qsKMmvL0f4I+1BW5nT1/OkMyBbQdmqKQ==
X-Received: by 2002:a5d:694a:: with SMTP id r10mr28527069wrw.228.1588007614805;
        Mon, 27 Apr 2020 10:13:34 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id y10sm15924202wma.5.2020.04.27.10.13.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 10:13:34 -0700 (PDT)
Subject: Re: [PATCH 1/2] drivers/clocksource/timer-of: Remove __init markings
To:     Baolin Wang <baolin.wang7@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
References: <d2934f74d77c637c41d7cb98710cb5363d09e83b.1585021186.git.baolin.wang7@gmail.com>
 <CADBw62pmiguVmuq334eskLAZ5CkrjxohW_fXNjNev+O1U15=OQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <bd800f7b-05fd-b393-fba6-1965ba89e1b3@linaro.org>
Date:   Mon, 27 Apr 2020 19:13:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CADBw62pmiguVmuq334eskLAZ5CkrjxohW_fXNjNev+O1U15=OQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2020 04:55, Baolin Wang wrote:
> Hi Daniel,
> 
> On Tue, Mar 24, 2020 at 1:59 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>>
>> From: Saravana Kannan <saravanak@google.com>
>>
>> This allows timer drivers to be compiled as modules.
>>
>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> 
> Do you have any comments for this patch set? Thanks.

If my understanding is correct, this patch is part of the GKI picture
where hardware drivers are converted to modules.

But do we really want to convert timer drivers to modules ?

Is the core time framework able to support that (eg. load + unload )


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

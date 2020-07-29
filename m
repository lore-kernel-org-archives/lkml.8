Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E38FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0AB2070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GP4Y3u9B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgG2OJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG2OJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:09:48 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E747BC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 07:09:47 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k8so3115170wma.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 07:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HifLDNTRhw4RF6cmowmnJkzv7TwOr6d+/p0pc7iXFD4=;
        b=GP4Y3u9BfIuKSgVtheFgW9RvCMPNoUCdlkTHq1u+BqFvLrPNSoyDOgabSNihlOt7+j
         qFi3x8bZk7Nb6AFTbc5SxvVYenYodICwtZTAUKqv+HFHkRLVNVgu6LMXl+NKHZruKtgV
         70RShXQaH91UyfN1+a4Giz/h3RajHZkIZGhecKxNIlrXapTOkHa8eCFzpEwTMkvITDXH
         6gdpW3wLhq1JrGY91Hp+WgM3mC/ZkNLUBgEIwChbu36gwV9b2fv7Yb7v/hp17Vedyok6
         pxSq5h10qGn1yKMELwqNFT/9++9gxRciqRqOSI7n8queifnvpQjGVDjsjKIX2vGIBfhz
         7lKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HifLDNTRhw4RF6cmowmnJkzv7TwOr6d+/p0pc7iXFD4=;
        b=nh3RNhNs/sr+G13HkkbKuLXHnHg3yY3EibXUZV+wQtOSgFRwcOCg++I16QqrKK8AWZ
         YHTX7VEZ9gN9uSIc3NpCbDV6jcuZPXu4UZ+FKsNLAg/j9XDyDhAyKnkOaFBLq3XUjnGY
         LOYeRnNLwLO/uwx8T6PvqGD6J+z+vQMd9NtjL2kC2+vIj7WuNS9npAXa/OUljznzzDFm
         fkXBH2VWK38AhODG2en7g1q9WNB5qGTFxG/rzzdw2D4yMjyaua75y+lZIJQdIArLJ2cf
         GmPqpcHbaTofUm3Baukw7+o7xYLCDzUMM4tz8nXBFJxiygNlrftgix9Yqv9bojTgsrKP
         ikIg==
X-Gm-Message-State: AOAM531KKAVTVJbVlzOZvMoKjsw3BGEB/kscpZ1Peqt+PO8JI2SOm+Yv
        /oq1ghVUvee5cE/sxqiU1vtBzg==
X-Google-Smtp-Source: ABdhPJyeN6M7QDZUYn748zIH40ZRGyVaJy1mgyXmzMAqrdEAGWmzUNzlTqYk3fUvc27yhNy5f6cIBQ==
X-Received: by 2002:a1c:1bce:: with SMTP id b197mr8968527wmb.32.1596031786542;
        Wed, 29 Jul 2020 07:09:46 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:812d:95b8:6384:6e20? ([2a01:e34:ed2f:f020:812d:95b8:6384:6e20])
        by smtp.googlemail.com with ESMTPSA id f63sm656270wmf.9.2020.07.29.07.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 07:09:45 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] kernel: time: export sched_clock_register function
To:     Freddy Hsin <freddy.hsin@mediatek.com>,
        linux-mediatek@lists.infradead.or,
        linux-arm-kernel@lists.infradead.org,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org, chang-an.chen@mediatek.com,
        Baolin Wang <baolin.wang7@gmail.com>,
        wsd_upstream@mediatek.com, kuohong.wang@mediatek.com,
        stanley.chu@mediatek.com
References: <1595931377-21627-1-git-send-email-freddy.hsin@mediatek.com>
 <1595931377-21627-2-git-send-email-freddy.hsin@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <6535cd1b-327c-db4b-e6d8-9a29a5847e17@linaro.org>
Date:   Wed, 29 Jul 2020 16:09:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595931377-21627-2-git-send-email-freddy.hsin@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Freddy,

On 28/07/2020 12:16, Freddy Hsin wrote:
> export sched_clock_register function, because the Mediatek timer
> loadable module depends on this function

That is not a sufficient reason to ask for exporting a symbol from the
core framework.

It is the second patch asking for exporting the symbols because of GKI.

If we want to do this move, it is important to understand what that will
imply by doing the changes as a whole:

 - Identify the routines which will need EXPORT_SYMBOL_GPL

 - Show it is safe to use them with what that implies as module. eg.
What about cpuidle drivers using the broadcast timers?

 - As pointed by Thomas, TIMER_OF_DECLARE must be adapted to handle the
module cases

The conversion to all modules is not as straightforward as just
exporting a symbol and the changes must be provided with the proof the
impact has been studied and anticipated.


> Signed-off-by: Freddy Hsin <freddy.hsin@mediatek.com>
> ---
>  kernel/time/sched_clock.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
> index fa3f800..e1d5afe 100644
> --- a/kernel/time/sched_clock.c
> +++ b/kernel/time/sched_clock.c
> @@ -239,6 +239,7 @@ static enum hrtimer_restart sched_clock_poll(struct hrtimer *hrt)
>  
>  	pr_debug("Registered %pS as sched_clock source\n", read);
>  }
> +EXPORT_SYMBOL(sched_clock_register);



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

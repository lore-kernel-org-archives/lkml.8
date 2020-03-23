Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1952BC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:05:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2585206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 21:05:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="w0nVY/jG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgCWVFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 17:05:24 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:35155 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgCWVFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 17:05:24 -0400
Received: by mail-vk1-f196.google.com with SMTP id n198so3040447vkc.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 14:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=afgnjkDJ/R+0EdXTGL+409eIfOJr3eWoeZR0O+51R6M=;
        b=w0nVY/jGdqLmt49rqhh/Y6tL2SnwaSNPXgMzQsNqnAtNVahj3eUnRvPrdrsOAUkX/6
         4/FNI/IQfzJr7WhfoOr/oNuKlXVM99+6nV6FU3Hn7CiuDmODZOtdfFSG3VZCtylp4yTu
         /THiOqbqRCbP+MMzNMZu8+GH/n9NX5N8zqweOA8MbT9bomaxtOge0ati1P21G2/dqpJo
         KYzMEbroCTHNHICjNpUjVZrxUOH+BXpsFaF6sN4xH6xGwMxn3b8u4u4309xCWOadrScU
         FI3v1Z7DWk6McdknmRIt/R1AfHFQa3DvhFGg9E8LILW6fxD1ypsBVv5ifbjp2JEH9iin
         yeag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=afgnjkDJ/R+0EdXTGL+409eIfOJr3eWoeZR0O+51R6M=;
        b=tKvoYOdVzylRk25l1/1ry5wMwBv+7RfWkuj321BEBXIPDoNmkf2cLRh/flP7dly/Co
         5cJM3w62X6MlZzQLoB9L7IRCzHa+xcF5RiKGhijI0wHaKDgMTHqj/EujVUlbYbMm9Qpx
         VgtYdJstR+kffZa7OuGtJ9cD3+51Mrd8IxCsEXaFdGwPLyro/eub5AyPKEMABpYglUcQ
         sNioewRbsDe4/uAOKwgEpGo78hKTOkrl7NKXdrwHCUk/BFqcEuUJ7QEvV/9rTn8MZmo6
         BeGtR6mgQpJfTFUKouMLibamfxH11jRSCZvyaN82gB2QyEcwzBWV+yJrTEGl35Vnk03B
         eDIQ==
X-Gm-Message-State: ANhLgQ1YomH2kchCY82i39kVgsj94NBwzbm7eGUuFTwbSJaGTtX0g5Ka
        BvuKveFF6EQuTUvk4vuVfIVgPZS1q5KlTvu2PKOsRg==
X-Google-Smtp-Source: ADFU+vvrjH5G4g0feRHSk0fyCI3ZyCF0GzPEmwvvKlkfu1dSa1Gzs9wMxucKb1tWPtNV9pfbDVTM+69gfAiozqy50Sw=
X-Received: by 2002:a1f:2882:: with SMTP id o124mr16886445vko.86.1584997520484;
 Mon, 23 Mar 2020 14:05:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200321092740.7vvwfxsebcrznydh@macmini.local>
In-Reply-To: <20200321092740.7vvwfxsebcrznydh@macmini.local>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Tue, 24 Mar 2020 02:35:09 +0530
Message-ID: <CAHLCerOFg30GEaQgV=4ccgA1fG6P3OTgaG33pw-3YCtuD5mSmA@mail.gmail.com>
Subject: Re: [PATCH] thermal/drivers/cpufreq_cooling: Fix return of cpufreq_set_cur_state
To:     Willy Wolff <willy.mh.wolff.ml@gmail.com>
Cc:     Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J.Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy,

On Sat, Mar 21, 2020 at 2:57 PM Willy Wolff <willy.mh.wolff.ml@gmail.com> wrote:
>
> The function freq_qos_update_request returns 0 or 1 describing update
> effectiveness, and a negative error code on failure. However,
> cpufreq_set_cur_state returns 0 on success or an error code otherwise.
>

Please improve the commit message with context from your earlier bug
report thread and a summary of how the problem shows up.

Thanks,
Amit



> Signed-off-by: Willy Wolff <willy.mh.wolff.ml@gmail.com>
> ---
>  drivers/thermal/cpufreq_cooling.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
> index fe83d7a210d4..af55ac08e1bd 100644
> --- a/drivers/thermal/cpufreq_cooling.c
> +++ b/drivers/thermal/cpufreq_cooling.c
> @@ -431,6 +431,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>                                  unsigned long state)
>  {
>         struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
> +       int ret;
>
>         /* Request state should be less than max_level */
>         if (WARN_ON(state > cpufreq_cdev->max_level))
> @@ -442,8 +443,9 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
>
>         cpufreq_cdev->cpufreq_state = state;
>
> -       return freq_qos_update_request(&cpufreq_cdev->qos_req,
> -                               get_state_freq(cpufreq_cdev, state));
> +       ret = freq_qos_update_request(&cpufreq_cdev->qos_req,
> +                                     get_state_freq(cpufreq_cdev, state));
> +       return ret < 0 ? ret : 0;
>  }
>
>  /* Bind cpufreq callbacks to thermal cooling device ops */
> --
> 2.20.1
>

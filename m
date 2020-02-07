Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7639CC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3909F206CC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="toifvqRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgBGKmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 05:42:51 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45769 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgBGKmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 05:42:51 -0500
Received: by mail-wr1-f67.google.com with SMTP id a6so2025323wrx.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 02:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qDkH1wBqbkFy75xFhrPhCgOyeDjnS7+r/oyOVLe1k5Q=;
        b=toifvqRLuznhIjT1TQtnUIM2/IewyX8HxzVO/EqFRXeVm5Ri0LqZa8QPJDDJcfd9/T
         7eRKB7+EVYB6uamOUWQOU+fg0OM+Jgj+e9th/UKncT3aAjydevsqbOgLwgM0P+LEiRn9
         lwiFxNdI+Pv9eGVvJpFq/hOnJFaRiNt2JBpGaM2p/ZrB/ls/95lFtFuVdt3htu5MGc6S
         VLekV/FSBp74TUjFM7QTr3JF5jkK2sPBD9EzKt4xqIws29LXkqqpLHLC8InrqomlIaHh
         0J3jwz1DQwMBNI1BOfrHP6OOWqbOtMFTdwSkYHxRCHaVzfmAWZlQhjqrdmZhlse7bHtP
         NQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qDkH1wBqbkFy75xFhrPhCgOyeDjnS7+r/oyOVLe1k5Q=;
        b=DkPkjgS9Zf+QafGjbKNye2xbeYwDvmKTWQcnRblOth849hoxEHXqKKNuJWsxaCDbJd
         E84HBHg+OF/y41Yu+ChwAXuiyg6gjwzuE9/np06y/mucVhr6G7K70vne4026lfsKhCwT
         hTFmy/mF7Qz6XT4jgRK+kX20hcYcSvXRTCDXK22NW4dp/YC70r7Ect8zhKJFBgb/EWOD
         atJepbhovxi5qX7sfR1bxUvMwiU3iR47FxgB1f5Nwfld7zBYGZPkKeSQlpNoa1Z4PqEn
         H3Qf2t64c0TIPE0ewPoubUeAKx5ixvCYkaOPIDMlymatzQbb0caXed0Lg5fsVZg90YPL
         zkXA==
X-Gm-Message-State: APjAAAUQkg+YPkRfqeo6hSSOwd3vtt9OYaJbkS4kwykDBkMJIj5aDr0+
        UIm5pwjeJeoNTaAJxytRvGDFPnuvGzo=
X-Google-Smtp-Source: APXvYqxrDGrmzNVPDJeD5NRu5+GE1vfit/h5LsknCesjhQ9+C9q3/I+WCt6Zovrr58PK6xNyJZUaFQ==
X-Received: by 2002:a5d:4052:: with SMTP id w18mr4009472wrp.112.1581072168225;
        Fri, 07 Feb 2020 02:42:48 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id o187sm3235720wme.36.2020.02.07.02.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 02:42:47 -0800 (PST)
Date:   Fri, 7 Feb 2020 10:42:44 +0000
From:   Quentin Perret <qperret@google.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        adharmap@codeaurora.org, pkondeti@codeaurora.org
Subject: Re: [PATCH v4 0/4] sched/fair: Capacity aware wakeup rework
Message-ID: <20200207104244.GA228234@google.com>
References: <20200206191957.12325-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206191957.12325-1-valentin.schneider@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 Feb 2020 at 19:19:53 (+0000), Valentin Schneider wrote:
> Pixel3 (DynamIQ)
> ++++++++++++++++
> 
> Ideally I would have used a DB845C but had a few issues with mine, so I
> went with a mainline-ish Pixel3 instead [1]. It's still the same SoC under
> the hood (Snapdragon 845), which has 4 bigs and 4 LITTLEs:
> 
>   +-------------------------------+
>   |               L3              |
>   +---+---+---+---+---+---+---+---+
>   | L2| L2| L2| L2| L2| L2| L2| L2|
>   +---+---+---+---+---+---+---+---+
>   | L | L | L | L | B | B | B | B |
>   +---+---+---+---+---+---+---+---+
> 
> Default topology (single MC domain)
> -----------------------------------
> 
> 100 iterations of 'hackbench -l 200'
> 
> |      |   -PATCH |   +PATCH | DELTA (%) |
> |------+----------+----------+-----------|
> | mean | 1.131360 | 1.102560 |    -2.546 |
> | std  | 0.116322 | 0.101999 |   -12.313 |
> | min  | 0.935000 | 0.935000 |    +0.000 |
> | 50%  | 1.099000 | 1.097500 |    -0.136 |
> | 75%  | 1.211250 | 1.157750 |    -4.417 |
> | 99%  | 1.401020 | 1.338210 |    -4.483 |
> | max  | 1.502000 | 1.359000 |    -9.521 |
> 
> 100 iterations of 'sysbench --max-time=5 --max-requests=-1 --test=threads --num-threads=8 run':
> 
> |      |      -PATCH |      +PATCH | DELTA (%) |
> |------+-------------+-------------+-----------|
> | mean | 7108.310000 | 8731.610000 |   +22.837 |
> | std  |  199.431854 |  206.826912 |    +3.708 |
> | min  | 6655.000000 | 8251.000000 |   +23.982 |
> | 50%  | 7107.500000 | 8705.000000 |   +22.476 |
> | 75%  | 7255.500000 | 8868.250000 |   +22.228 |
> | 99%  | 7539.540000 | 9155.520000 |   +21.433 |
> | max  | 7593.000000 | 9207.000000 |   +21.256 |
> 
> Phantom domains (MC + DIE)
> --------------------------
> 
> This is mostly included for the sake of completeness.
> 
> 100 iterations of 'sysbench --max-time=5 --max-requests=-1 --test=threads --num-threads=8 run':
> 
> |      |      -PATCH |      +PATCH | DELTA (%) |
> |------+-------------+-------------+-----------|
> | mean | 7317.940000 | 9328.470000 |   +27.474 |
> | std  |  460.372682 |  181.528886 |   -60.569 |
> | min  | 5888.000000 | 8832.000000 |   +50.000 |
> | 50%  | 7271.000000 | 9348.000000 |   +28.566 |
> | 75%  | 7497.500000 | 9477.250000 |   +26.405 |
> | 99%  | 8464.390000 | 9634.160000 |   +13.820 |
> | max  | 8602.000000 | 9650.000000 |   +12.183 |


So, it feels like the most interesting test would be

 'baseline w/ phantom domains' vs 'this patch w/o phantom domains'

right ? The 'baseline w/o phantom domains' case is arguably borked today,
so it isn't that interesting (even though it performs well for the
particular workload you choose here, as expected, but I guess you might
see issues in others).

So, IIUC, based on your results above, that would be:

|      |     base+PD |  patch+noPD | DELTA (%) |
|------+-------------+-------------+-----------|
| mean | 7317.940000 | 8731.610000 |   +19.318 |
| std  |  460.372682 |  206.826912 |   -55.074 |
| min  | 5888.000000 | 8251.000000 |   +40.132 |
| 50%  | 7271.000000 | 8705.000000 |   +19.722 |
| 75%  | 7497.500000 | 8868.250000 |   +18.283 |
| 99%  | 8464.390000 | 9155.520000 |    +8.165 |
| max  | 8602.000000 | 9207.000000 |    +7.033 |

Is that correct ?

If so, this patch series is still a very big win, and I'm all for
getting it merged. But I find it interesting that the results aren't as
good as having this patch _and_ phantom domains at the same time ...

Any idea why having phantom domains helps ? select_idle_capacity()
should behave the same w/ or w/o phantom domains given that you use
sd_asym_cpucapacity directly. I'm guessing something else has an impact
here ? LB / misfit behaving a bit differently perhaps ?

Thanks,
Quentin

Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4182C2BC0E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 04:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88C06206EB
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 04:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c7qfDC09"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgHaElu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 00:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgHaElg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 00:41:36 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B8CC061755
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 21:41:35 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id m8so3888571pfh.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 21:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tKBW/F//Odqb5tM/8/4W6YOQLh46rA7wiAa9+W09lUs=;
        b=c7qfDC09HduGCiqIk+BgOYpQ9cvQvrcoJ68UU8Om0zB6UfcJuBggEjd3zzgQiQSvWz
         0cx6iY68Z3P6Wp/t5Qbf/E6ovg3xn5scdjX29vQ9aEWfrxC9SJUv5iGNJgN6lD2ORyYg
         U3IerKG6ipw6v5cNOcAXAWk6qtm+Ey1GST3evZhR46so5KxZy9kA1E2TtjvhZoaKFjov
         bHVxUnufMR8HN58YdZNjvhAg9uS3dFQuD8Ufk6DrYMO0/QP+sv2gTl7u734p3k2lGHps
         rZcq/O8vyDLshkQH+D1qAiHIycDiP2Fk7+LrYiXCUxIhlK3MLYABLrKOALQqyvQyFpaD
         VQYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tKBW/F//Odqb5tM/8/4W6YOQLh46rA7wiAa9+W09lUs=;
        b=U1SEqwE0F2Rl/GMJRfHHtkza0HWdKVgs+b+yG3UFXjRqwDlCVRsz9rq5vqlVs6BJO9
         LK8eX5DZyg0DmrhzpdILVi4UpagEukGsdEcBMSxeu6T/zXd2bPOof168oPE6IovqinPm
         g9cxTsCX9A/K6ZX4Zm/PmGAUY6OiTfE/gpHKZ/E4x4vmQZ9yz65g6fHlwxqJTcqNNsce
         GZzr8zoBaQ9LoA8x6EWDGWqpI70gwNIcHECxkLP4bI8Tg0lcFTvkx6OZ4E5GaCggFk3x
         gUbkxazZKWR3jgAl8ssZXTqCibMI0cc6xIYPN3T29b0awQT1nzH0iXOZ/gihoxvH0+UW
         aT0g==
X-Gm-Message-State: AOAM532ksH9edBznJtJ4DcbzRHoG5hyiiZbrIeyHceW/4azy/aMQrH44
        UNWEKTN4vRNa/Ns5090YtA+1VwR+7dM/Lw==
X-Google-Smtp-Source: ABdhPJwRrm2hAT1+zyOzYg5wvxBV6hOve2sGkJOFOkrgXNNu1vlfGDGouDr0VBs0EX8TzqHhtvmClQ==
X-Received: by 2002:a63:354:: with SMTP id 81mr7199979pgd.216.1598848895038;
        Sun, 30 Aug 2020 21:41:35 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id a10sm6214503pfl.28.2020.08.30.21.41.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Aug 2020 21:41:34 -0700 (PDT)
Date:   Mon, 31 Aug 2020 10:11:32 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        open list <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, sbhanu@codeaurora.org,
        Sibi Sankar <sibis@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <sboyd@kernel.org>, nm@ti.com
Subject: Re: WARNING: at drivers/opp/core.c:678
 dev_pm_opp_set_rate+0x4cc/0x5d4 - on arm x15
Message-ID: <20200831044132.jb7aflr2sfbart2z@vireshk-i7>
References: <CA+G9fYvK5UkERLuBSRH5t2=j5==dbtw45GTMta9MafyJDqFsFA@mail.gmail.com>
 <20200827094651.3grvs6ungv3dh7y3@vireshk-i7>
 <20200827211832.3ebeda8a@canb.auug.org.au>
 <20200828045128.y7ybkd7dnvn4h6dt@vireshk-i7>
 <CA+G9fYsn1S-SieuP85-Z4qKO+aNyqJarrBR0xx0X-YbtF9eo0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYsn1S-SieuP85-Z4qKO+aNyqJarrBR0xx0X-YbtF9eo0g@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-08-20, 15:42, Naresh Kamboju wrote:
> Viresh,
> I have applied the v2 patch series on top of linux next-20200824.
> and tested again the reported kernel warning is fixed [1]
> 
> [1] https://lkft.validation.linaro.org/scheduler/job/1717615#L1881

Hi Naresh,

You meant this one ?

[PATCH V2 4/8] mmc: sdhci-msm: Unconditionally call dev_pm_opp_of_remove_table()

Great, thanks a lot for testing these.

-- 
viresh

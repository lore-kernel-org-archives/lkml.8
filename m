Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8FBC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 07:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CDC2206F7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 07:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U97OPPtV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgDJH6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 03:58:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55232 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgDJH6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 03:58:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id h2so1661495wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 00:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EVPFhIaLQy4jMpwt7Ws80UbGnhhDyDK/W85xuqU809A=;
        b=U97OPPtVjY6bx3XpYlYW1qT0kdhs4PYoRiGkwjL1+CtHxOHHXtMluQtQK6r5t6vyDB
         zHVCz+uYnsZzl5vK/4jsb4a7sygFIHs7AaqFkK5P8f4Dv/Jvl+MD04gO1SQCzgJsJiTG
         jOB0gIX6V7Jdn+63vjG0PMifI8tkVljNAyJ5fakRjI8XTl+DpuWHxa4ng8k51UKoMH+O
         uDrrkjcLZBEg+1yymdAnOohU5YA+XQXxfsbjqrNEiNuo1UQ+LyZ+DEQlSboivEUEyNRm
         mfnjrXUCJCa5aA5ZkSQ+pDXVuYuSSrfZ3pjfdCuZ39DBke5mJJj4rGNibKw292ttU6sm
         lTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EVPFhIaLQy4jMpwt7Ws80UbGnhhDyDK/W85xuqU809A=;
        b=HrP90oAhrBXyP3lwJgEfNctIuiG0BcEQyhI/u6CkV0kyfDcdxCEFo1XChnAijL40I1
         vVqftlKnwne19HiU5tlFTuf3kpqyJlNBcSfshsELqZxsXXJ9zfyIdxzRhUDs7DeO3e5D
         0Z0ZSdbdlJYNZmz6H5zkocKx72qIUDZ0tUaX83f+UNYoLvZKCYDUEz06DLgZDdah7trX
         ++VUnA+xmSCGmAyoI5+lazxgKdXvmFWG5afxogx6M1BSOSJLH7rxqf2hdcWiEHyTNvOQ
         N3l0dwlWLi6raqVawdf2eBWVGfuqKPTx8Jy0QdohexiFfittRNewki2NSPoMnDSpf0EY
         F/nA==
X-Gm-Message-State: AGi0Pubw5R1SJ5X5mtuFf5zlpBmPid4FYnv10i1JcVhzeGa1NmcM1K3o
        B/B+KotqGRJ5cUW3WZ9a2i7yvQ==
X-Google-Smtp-Source: APiQypJruAvbbWmgTp7tYy6+69EWw4BLdixeZWDT+T26NIvRMylTqGC7sUIpEqVHULbRgcqvyIGi/g==
X-Received: by 2002:a05:600c:2f17:: with SMTP id r23mr3681714wmn.81.1586505510682;
        Fri, 10 Apr 2020 00:58:30 -0700 (PDT)
Received: from [192.168.1.5] (212-5-158-142.ip.btc-net.bg. [212.5.158.142])
        by smtp.googlemail.com with ESMTPSA id y2sm1907569wrh.90.2020.04.10.00.58.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 00:58:30 -0700 (PDT)
Subject: Re: [PATCH V2] venus: core: remove CNOC voting while device suspend
To:     Mansur Alisha Shaik <mansur@codeaurora.org>,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org
References: <1586503045-18630-1-git-send-email-mansur@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <22207225-866b-a424-6937-ae88ff94d373@linaro.org>
Date:   Fri, 10 Apr 2020 10:58:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1586503045-18630-1-git-send-email-mansur@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Mansur,

On 4/10/20 10:17 AM, Mansur Alisha Shaik wrote:
> The Venus driver is voting Configuration NoC during .probe but not clear
> voting in .suspend. Because of this NoC is up during shutdown also. As a
> consequence the whole device could leak energy while in .suspend.
> 
> So correct this by moving voting in .resume and unvoting
> in .suspend
> 
> signed-off-by: mansur alisha shaik <mansur@codeaurora.org>

Signed-off-by: Mansur Alisha Shaik <mansur@codeaurora.org>

Please configure git and use 'git commit -s' to sign off your commits
next time. I will correct that when applying.

> ---
> Changes in V2:
> - As per stanimir comment changed the commit message.
> 
>  drivers/media/platform/qcom/venus/core.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Acked-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>

-- 
regards,
Stan

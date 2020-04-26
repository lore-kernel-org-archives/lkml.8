Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235A2C55191
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 00:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03EF720748
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 00:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Amd0JZPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgDZAgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 20:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725962AbgDZAgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 20:36:37 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433E6C061A0C;
        Sat, 25 Apr 2020 17:36:37 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id k28so10830234lfe.10;
        Sat, 25 Apr 2020 17:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A7N+uweKX+04I/97tdi//DPnyW5rsGkuCQW0SIFkJgQ=;
        b=Amd0JZPoDxFrF2SJwAILtl+b+NedLVOtr+wSvM/cmbyyfQAi9ZQZGivo0R1AOTm6DL
         L6pimm7/mJDbzTW1aaVJp+javcpn0q3jSAFBQG39IjdRbxL3yHHm3sF721jN6mjRr3Fr
         QnjuOYR9tyVBQqO/J9uEA2zMAxxcgHH8HSxt86ie3e4dpypw4WzJRqekqHKN92pHT0/o
         bzqiOU1eWfyHVRHylfPdNeG8m1ELSH4jMayig7xyUx83YlhoVRBAKhuI+NRGuCt6ROVC
         MaNdiywggCXOEjlNtkRvEfz4B1aOtLfBxQzbb0EY9Vn7IbJ8x0SMvavbjMo8LxYkXrsz
         dmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A7N+uweKX+04I/97tdi//DPnyW5rsGkuCQW0SIFkJgQ=;
        b=rOeEWAHd68TPBovguc/sD/2e9gO5EIMnb2sZQBIcSJGTF0iAKNctiM24uICZsFa0/T
         456BNOp3dca4haGA95H+iSrSxVmyKskWS0bM3YmS3W9ZSIa30cCo408AgU1NJFCcrnsH
         /tFHb4NgAV4oonUl8D5M4xz153RFAmZiHvMMdn0rGXDHPQVFsUs1yF3JhFLJHsJBqRXC
         614dJR7rz/FIUj2gyq1hZLrj89w5vpEb94RqN5s633Ih7G0CjPJzNwuevC6eKpk5yjo+
         2FaHY3CieeNk2JDHO1S8j1bBt3cY0RMOtk8LP8egw4kSxhatiK+ZN7HxkDWAc3nBBxVo
         nsAA==
X-Gm-Message-State: AGi0Pua2ZvdT2uKtdBw4JUrbS9Knke2XxwOQ1ZnKddwpZTbhXirwXfQD
        wIyFL+7knKNYS42KWFCycQoLsg5D
X-Google-Smtp-Source: APiQypJu7PALKoIdggVZp0FT8l8W24TOYecAVJhw8cLt+x/vusCKYZHAlLTLgwvgEXFnQEPcpmSUTA==
X-Received: by 2002:ac2:5192:: with SMTP id u18mr10869262lfi.114.1587861395483;
        Sat, 25 Apr 2020 17:36:35 -0700 (PDT)
Received: from [192.168.2.145] (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.googlemail.com with ESMTPSA id x80sm7997729lff.23.2020.04.25.17.36.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2020 17:36:34 -0700 (PDT)
Subject: Re: [RFC PATCH v10 6/9] media: tegra: Add Tegra210 Video input driver
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, frankc@nvidia.com,
        sakari.ailus@iki.fi, helen.koike@collabora.com
Cc:     sboyd@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1587700513-28449-1-git-send-email-skomatineni@nvidia.com>
 <1587700513-28449-7-git-send-email-skomatineni@nvidia.com>
 <6ca93ff9-ca59-544f-767c-4355d01a5c20@gmail.com>
 <62546d1f-eca5-06be-2bc2-e45ccd53830a@xs4all.nl>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <50fd1016-ca8b-ec5d-e5a8-f257138b152e@gmail.com>
Date:   Sun, 26 Apr 2020 03:36:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <62546d1f-eca5-06be-2bc2-e45ccd53830a@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

25.04.2020 12:36, Hans Verkuil пишет:
...
>> The media/tegra/ sounds a bit too generic, the media/tegra-vi/ path
>> should better reflect the driver, IMO.
>>
>> It also should be better to name the compiled kernel module as tegra-vi,
>> IMO.
>>
> 
> The driver name and the directory should be in sync, so either tegra-video
> or tegra-vi for both. I have no preference myself, as long as they are the
> same.
> 
> This can be done as a follow-up patch.

Given that this driver isn't going to be reused by older pre-Tegra210
SoCs, perhaps it will also be worthwhile to name it as tegra210-vi or
tegra210-video.

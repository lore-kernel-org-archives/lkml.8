Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4DEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2CAF2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 20:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xBqxvNtR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732954AbgGVUxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 16:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgGVUxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 16:53:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC33CC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 13:53:41 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z15so3158127wrl.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 13:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wW1DnZUWsofUTsgq+SLIFFLK+QTi/i/SCIuuZe0zTuE=;
        b=xBqxvNtRAbVNzKi8m6DikHLFc+9OXAfODM07PrW7ZXGcgFqaAShTK9ZevI6rC/50Vx
         T3LkAPx0np+GKaOINKHbRYRSBaaInIq3+Na8JEddD9+p51gpUs4Shc9ekXmnxQxPUFh1
         x4Cqpy36Gwqgm6a51V2ZzJ6d8SoRj+G9spBvTlJLVc+myruCAYjg+s+RmSs9rDwgTpTR
         095Hp9uOoVN+0UW8SrjTmGmTBL8+8cnnKdJ/6TRKNwfqC/T4x9LTN46qcQuMAgcSr6hp
         8zORA/TICAtwoG4KKEs+NtwGYgHzBoK//7zBN4OJU0fb7lakXJ9qsOvB8BlZMziamx1r
         yH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wW1DnZUWsofUTsgq+SLIFFLK+QTi/i/SCIuuZe0zTuE=;
        b=Esqd9Xpv1YtsB9L5Jh7u6Iu4Jy3r6AXGzesKsWjSO/9U7KEQwoQDlYi4o45FMBxNu2
         9ZlmNy+cDpa7Af1Ffb8hMTseKQs6dvau9eh4yqnxXlfiDRdvP/M0V2sXBqdwLtaoQF6l
         zP+Wnl/4CBk7QgE0ea8FpmzZwZ5qCufocAGQTJKmq3D/vmczlaa5GnYBuhUyz5nb8seQ
         zCqlgAIDe5mxtfziGhlyxC9ArnTUDiFwdCt6a6ahB41DJ2QYgQi/VSngjQtc9sZYrOTs
         Aee/apFOcP02hwiD4NYd1V4rQBZn+zauzVO6U3xbenbarg1Y3EPF01O7ypWK1zJ1T7Ki
         C2Ng==
X-Gm-Message-State: AOAM533HghAVZEvMFsG2KrR8O1lQzOqrpAOEHHa40RJC+OZ1sWQQ9ZYn
        ZhpARKEQTlwwwqEJs25nBlIwqQ==
X-Google-Smtp-Source: ABdhPJykdASjtyMzlCtVwepVTUMPp3k0tgyzj7RZ/FooIEL5CK7t55xKRjy3K92F2davzXSbL6sREA==
X-Received: by 2002:a5d:5151:: with SMTP id u17mr1163528wrt.154.1595451220103;
        Wed, 22 Jul 2020 13:53:40 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:dca7:8d30:33fa:daac? ([2a01:e34:ed2f:f020:dca7:8d30:33fa:daac])
        by smtp.googlemail.com with ESMTPSA id y189sm1092416wmd.27.2020.07.22.13.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 13:53:39 -0700 (PDT)
Subject: Re: [PATCH v11 0/2] Add support for the OST in Ingenic X1000.
To:     =?UTF-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        tglx@linutronix.de, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, paul@crapouillou.net
References: <20200722171804.97559-1-zhouyanjie@wanyeetech.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <eb817f3d-3be5-76d8-90f7-09309fecfcff@linaro.org>
Date:   Wed, 22 Jul 2020 22:53:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722171804.97559-1-zhouyanjie@wanyeetech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2020 19:18, 周琰杰 (Zhou Yanjie) wrote:
> v10->v11:
> Fix typos.
> 
> 周琰杰 (Zhou Yanjie) (2):
>   dt-bindings: timer: Add Ingenic X1000 OST bindings.
>   clocksource: Ingenic: Add support for the Ingenic X1000 OST.
> 
>  .../devicetree/bindings/timer/ingenic,sysost.yaml  |  63 +++
>  drivers/clocksource/Kconfig                        |  12 +-
>  drivers/clocksource/Makefile                       |   1 +
>  drivers/clocksource/ingenic-sysost.c               | 539 +++++++++++++++++++++
>  include/dt-bindings/clock/ingenic,sysost.h         |  12 +
>  5 files changed, 626 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
>  create mode 100644 drivers/clocksource/ingenic-sysost.c
>  create mode 100644 include/dt-bindings/clock/ingenic,sysost.h

Applied, thanks


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

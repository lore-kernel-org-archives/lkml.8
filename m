Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488D7C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 07:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B046208DB
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 07:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598081686;
	bh=uWhK2kB63bc95+/YRIP/+2rvQLcpNbxSFxJhEFldkhU=;
	h=Subject:To:References:From:Date:In-Reply-To:List-ID:From;
	b=rGJzhr9ULhrDjtMBojYsoQ6ppqwiLPs4cXoAi08Di3jr/WsakWF7Gy8HzxQPJLzVG
	 92vnL7noz+rcTIPakkmFfizeOUez0Ny+Z7GerKjm721r6M74I5KRygS+QbD3OBZSIJ
	 DJnywKiASOM68MeamxskwXbN+zm7hZSIPHuDZa5A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgHVHeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 03:34:44 -0400
Received: from mail-ej1-f49.google.com ([209.85.218.49]:44346 "EHLO
        mail-ej1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgHVHen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 03:34:43 -0400
Received: by mail-ej1-f49.google.com with SMTP id bo3so5165242ejb.11
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 00:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v1InE3ULzicYdyVB4JrOyBrw0xip+nnOctvuAzrJ6gc=;
        b=CZp4+HwU46O6m7s4njZuZhdGDbXIjJjg3iX9bEeAByHEr/jZhMTWbZF1YTA4QPO2vx
         v7unAjydotnGhJerFTPryNMXUDSQqcjrJyfbwUiU4X9AXxXquWga0GuvzrCnz5EKTnM8
         TidU3zlxVCoFVWH2BWThd4F+HZfiQyKLE4kiuoCIonU/oxHfE1dc6zW+mQf+DCztc5qw
         9DKxg91YD05j+f420JEA4S5X3zU/kaVYw8zZwP65zMlK+jVqtvBxieRhh4ZeKtUWDFN2
         tAl7hK056ep+1makWAqGY7XZUZZ1kW7Eq/VwW4UWjlmLZont85tt/eh1ir+4sTfjbePE
         vrFw==
X-Gm-Message-State: AOAM530APBIFma2d2GKdQIIy2PIvQuLIENLXMqDocF9v1fNBqgEqM4OQ
        vtJMYKtgjQLpp3Fp78tQHYeOxiVSmtE=
X-Google-Smtp-Source: ABdhPJw8Mf4cSh0+FDnh5WmV4yyx2NA5yG+0+zdlV5m1uJqrL++c+X1DZt5Tpk9Cb5pAWQMNy5h50A==
X-Received: by 2002:a17:906:12c7:: with SMTP id l7mr6383619ejb.306.1598081681706;
        Sat, 22 Aug 2020 00:34:41 -0700 (PDT)
Received: from [192.168.1.47] (185-219-167-24-static.vivo.cz. [185.219.167.24])
        by smtp.gmail.com with ESMTPSA id k10sm2753169ejj.108.2020.08.22.00.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2020 00:34:40 -0700 (PDT)
Subject: Re: KASAN: use-after-free Write in vcs_read
To:     syzbot <syzbot+ad1f53726c3bd11180cb@syzkaller.appspotmail.com>,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        jslaby@suse.com, jslaby@suse.cz, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, nico@fluxnic.net,
        syzkaller-bugs@googlegroups.com
References: <0000000000005d511305ad725632@google.com>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <c432d894-eae6-1541-0f29-267b4a16b3ae@kernel.org>
Date:   Sat, 22 Aug 2020 09:34:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <0000000000005d511305ad725632@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22. 08. 20, 9:31, syzbot wrote:
> syzbot has bisected this issue to:
> 
> commit b1c32fcfadf5593ab7a63261cc8a5747c36e627e
> Author: Jiri Slaby <jslaby@suse.cz>
> Date:   Tue Aug 18 08:57:05 2020 +0000
> 
>     vc_screen: extract vcs_read_buf_header

It's like 7th e-mail about the very same issue. Can it be
suspended/acknowledged somehow?

> Reported-by: syzbot+ad1f53726c3bd11180cb@syzkaller.appspotmail.com

I haven't managed to find the root cause on Fri yet, I will chase it on
Mon again.

thanks,
-- 
js
suse labs

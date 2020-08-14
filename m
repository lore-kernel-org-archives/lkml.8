Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49BCEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 02:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B0B82078B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 02:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwq3CcVc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgHNCWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 22:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgHNCWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 22:22:50 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8953EC061757;
        Thu, 13 Aug 2020 19:22:50 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mw10so3685885pjb.2;
        Thu, 13 Aug 2020 19:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=B+pntnVo3xNQlG6KGrAyxLXpLyOgixbesPmFmGDwe1Q=;
        b=kwq3CcVcB7K3oUwV3SnUP41NFYmYKoqU2EemBPk7+ZgEE2/YgWMpnvl348mV+5Nx9Q
         RHTS9nVW1CH2Sp+6ZyVHZrnxdNlM+eQLkJO6ou7FtJdUozBvH4ZTja/y7cRxnr2sNlhf
         PynIxNFLOpoQutCNrZjOjUdwPpk0/H8ROTPHhs9S5XoaEYFFnDVdMm1o934AMtDpTq7M
         bpVtgog2JUldz22+yr/I85hWEAT4fBuwdIC7SkZ6FRcQU6fAroXHQGeBMjqf3Pdkefb6
         Fw7BOZjghIau1sy5OVngnwu3pyEdyn8TAcstyxpS+9zRUSWQIXeZJ3/0rUM2swY1+B3n
         A0Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B+pntnVo3xNQlG6KGrAyxLXpLyOgixbesPmFmGDwe1Q=;
        b=oJsLU//L3El+gpyJVfjA+YjE9EtHPO1zvLAQdm4mfmidPasOMY5lVuZs0Zhg8JdBLk
         iX3NDDzEzlkphSvBblEZSzZEcD97EYJOg3y5QQyRX6S7CyuNIeZc13f19SX3Oo6JauBb
         3XkC22r/ci/KN1crwwUBlhg6yVIOACGw3ul8rH1/+jHLH3ydLiw9/A7k3aCLAmo5NonM
         FMStHF9LeYfPc38UVfAYhR0vIpM1eWAK0UZB4DPg+j8gDfyj7hgbdeemmemNtvNKR2Gf
         frs8YPL2TkZln12AKTbG+DlbscTpGEm/KVS0s/mLxQFeAqD6KLLAM1On11dci9G/fleF
         Vm7w==
X-Gm-Message-State: AOAM532p3ib0VQP9oLzX19dvK0QHOqTgmxmVT+3AG8OzmAmRBLQMXwIK
        jy+DDkmt50g6vDPlCWM8snbTGIMe
X-Google-Smtp-Source: ABdhPJxGOH93+2h/+JBa/vBGhyJvJlTIS4OVwbfK7k96Mh22vEmFdczY3ocPqCqeeHfywKVCESz67A==
X-Received: by 2002:a17:90b:f11:: with SMTP id br17mr505406pjb.68.1597371769462;
        Thu, 13 Aug 2020 19:22:49 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u1sm6466395pgf.69.2020.08.13.19.22.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 19:22:48 -0700 (PDT)
Subject: Re: [PATCH] MIPS: ftrace: Remove redundant #ifdef
 CONFIG_DYNAMIC_FTRAC
To:     Zejiang Tang <tangzejiang@loongson.cn>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1597370895-5412-1-git-send-email-tangzejiang@loongson.cn>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <6db80fad-1ace-70b6-080b-c06ac9c07d22@gmail.com>
Date:   Thu, 13 Aug 2020 19:22:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <1597370895-5412-1-git-send-email-tangzejiang@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/13/2020 7:08 PM, Zejiang Tang wrote:
> There exists redundant #ifdef CONFIG_DYNAMIC_FTRAC in ftrace.c, remove it.

There is a missing E at the end of CONFIG_DYNAMIC_FTRAC in your subject 
FWIWW.
-- 
Florian

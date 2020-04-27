Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2004BC5519A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2E6D2075B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="z62B+eAr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgD0Izx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbgD0Izw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:55:52 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABF2C061A41
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 01:55:52 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 131so13103940lfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 01:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WD5CEB84PYGnkljL91GU2HcSm2iIFIOGAEJsr9kazRQ=;
        b=z62B+eAr+yM46IxeY8gnFq4+/05zI8Pp7FzGBNxc+cOimcXV9BbkiB9B8YMHwNB43m
         iEraiix7QoT9Pk+EHtQtZI32w9hTCaYnSYKM1UbwJTH841lEx45GP0Z8vW/mxgtjHZnO
         2tlsS6THKasOoUi2Gngvwcx/jd4NWcGG1pyfZ25RPkEqy+zW14qoWpZ4/MvGGgU+LSTf
         N2yyppMDSVk9XZk2d9mTojaCCkiCleasYPN2oCt9WTJG2UHFAeTqZXxvs8X/pX4Be8Dt
         lK5G5cceSluGCOLNmwpMC/zDT21VL/KzoX/SpPVaM3t+CbhiC5qRKnbS7MEFKNI0dAar
         ZxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WD5CEB84PYGnkljL91GU2HcSm2iIFIOGAEJsr9kazRQ=;
        b=RSyf+CSbgMmbQPc3VCCwye4bpAEGjg4IMLeOJPKQbgZzIU8atV72KKujzzmiFpxUFd
         Opc09i9mZ/GrhKoAVFVik4GQmI5XmQFa/CspUlzzdAAWFPJtg9BqKo9f7H1kAM80eGyE
         w+nTVxnmDtofrBDdgTdCpXdyXeIXupYnIwggUVHTKd0zCip0iQIisjYrcF2WVuKA0vi/
         wEQPJC/lB1WzGkRv1Gg2LB1/zAEw3awIWTMhQKETg92sGh47EMG8gDu+pzfGz9LGXbW5
         Ysp0LEZlQ7EFAltYC4e7ycUgRdHdLV1BAPNBDeFDqF8X+JUOHrBy8sPb9mQpRRYnMqom
         hqOA==
X-Gm-Message-State: AGi0PuY4y9a4h0i3wvYpaUczuWNL99prLkLwX06g2a8M4yxdEJYUJmch
        ObbvPQeoUJwRofHy9fv0N2w3xSM4Bcblkg==
X-Google-Smtp-Source: APiQypKg8ICDhALT6WfGHqbNjZJaOhMacL43TYecRqgG/lMHD2ZFu4RjWmIrjEPtdmDqejxbHtNtMQ==
X-Received: by 2002:a05:6512:74:: with SMTP id i20mr14801520lfo.104.1587977749779;
        Mon, 27 Apr 2020 01:55:49 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:468e:1152:9c79:cdeb:725:5fa4? ([2a00:1fa0:468e:1152:9c79:cdeb:725:5fa4])
        by smtp.gmail.com with ESMTPSA id y9sm4001767ljy.31.2020.04.27.01.55.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 01:55:48 -0700 (PDT)
Subject: Re: [PATCH 2/2] mips/mm: Enable SOFT_DIRTY for all 64bit systems
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, akpm@linux-foundation.org
Cc:     sunguoyun@loongson.cn,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
        Dmitry Korotin <dkorotin@wavecomp.com>,
        Daniel Silsby <dansilsby@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200426174058.1181837-1-jiaxun.yang@flygoat.com>
 <20200426174058.1181837-2-jiaxun.yang@flygoat.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <2f94a9ce-74a2-29a0-3b1c-d4b2906e2750@cogentembedded.com>
Date:   Mon, 27 Apr 2020 11:55:44 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200426174058.1181837-2-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 26.04.2020 20:40, Jiaxun Yang wrote:

> 64bit systems always have enough page table bits.
> So we can safely enable it for all of them instead of for Loongson
> only.
> 
> If oneday 32bit systems get 64bit PTEs than we can drop this
> limition.

    Limitation?

> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
[...]

MBR, Sergei

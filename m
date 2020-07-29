Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCC2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 16:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDFF22075F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 16:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bxyy99ha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgG2Q1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 12:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgG2Q1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 12:27:54 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 034B3C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 09:27:53 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id d14so22744501qke.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 09:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:from:message-id;
        bh=TSOUnId3DuMbnDTET43bmbbVarii+aBx7RtYK9sFGI4=;
        b=Bxyy99ha50PW4hDp5OSpq2zaLscxBmrgvzCGqhIhptXqDKMOc1pynDiDso5nbUVsnO
         TogS7VEU8pK/ZIOzxESG3F0q+lZrooGqM592M88X1gopqe9Sn0GC1U8Zt+92sU+QruAZ
         eh83ZHIFIVihQDag6Goy40JdoVfHKTO5TNSingm8jl2VeQ6eVS87v9Du6z22l68EQO88
         MpnedOmA59UeAOQM8rO6atV3mlVe3ukJ3TSNtAoJBgVlEkX29sq2JGkBZWw2F43a7LF8
         SGJ7DCRdyG3lwchjnjuZeiIa9A/33+cBnmXyoWE/yp6+SJXK6t6hiM9E91q9VKIx/vJ8
         jDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:from:message-id;
        bh=TSOUnId3DuMbnDTET43bmbbVarii+aBx7RtYK9sFGI4=;
        b=JvwYaua56PElszT0It0JzzAkllMN58k9zR0x6ExNRi5kSB71V9CTP1gPosm+E0vQ6Y
         fS10+zViHa0MBzDSDaer9GuaV8a3rVNh7CRAaHzJqUOfBZFl54UXXPl1fH1SzY2IM9Hg
         iPTGP3xXz4+TKtSawtxLySy64nXorWT2/KCjZZ1VaYpythSb6QrIREMe4JrB4ZNs7dK8
         sF9DphsU+3OE02Irq2bNQuff40iUnUGTfKXW0cSm3/GEK+Dtx25KV7aSo3SZNvSHkX7j
         v6aq7+JW0Y22cchUMc/xQhpAAReHf4CkiTbC05Ue6WNVj1Tjaju29Yi5LTXORTM/awHr
         pQ2g==
X-Gm-Message-State: AOAM531y4H6nMc/VKIWtmuvOwqhddMaLXle/wtSy4ZhaGui9rZMmBK1N
        NGJJpQQ25jyiBzBpiU/6/je8V0v+WvQ=
X-Google-Smtp-Source: ABdhPJz9SgAQHHXjDtUQoHgMrEtIW1VxLo/mDCm19xd3Je+oPKNdHQjstERn9hbl+gus0EUEmoPoKA==
X-Received: by 2002:a05:620a:b8c:: with SMTP id k12mr33151429qkh.69.1596040073032;
        Wed, 29 Jul 2020 09:27:53 -0700 (PDT)
Received: from RedmiNote8Pro-Redmi.localdomain ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id i18sm2049270qtv.39.2020.07.29.09.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2020 09:27:52 -0700 (PDT)
Date:   Wed, 29 Jul 2020 13:27:32 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <20200729160220.GB2655@hirez.programming.kicks-ass.net>
References: <20200729155647.xte33krus3mak3wu@altlinux.org> <20200729160220.GB2655@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Should perf version match kernel version?
To:     peterz@infradead.org, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, "Dmitry V. Levin" <ldv@altlinux.org>
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Message-ID: <7CEC30D2-0C1E-4E88-A1D2-35C121EB1013@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On July 29, 2020 1:02:20 PM GMT-03:00, peterz@infradead=2Eorg wrote:
>On Wed, Jul 29, 2020 at 06:56:47PM +0300, Vitaly Chikunov wrote:
>> Hi,
>>=20
>> It seems that most distros try to have perf version to match with
>> running kernel version=2E Is is requirement? Would it be better to have
>> single perf from kernel mainline to work with any (older) kernel
>> version?
>>=20
>> We have different kernel versions in ALT Linux (stable for 4=2E19, 5=2E=
4,
>> and 5=2E7) and I want to understand if we should have three perfs or
>> single package will be enough=2E
>
>We strive to have it all compatible, older perf should work on newer
>kernel and newer perf should work on older kernel=2E
>
>How well it's all tested is another=2E
>
>Personally I often use a very old perf=2E

Yeah, never was a requirement, if you find some problem using a new perf o=
n an old kernel or the other way around, please report=2E

- Arnaldo

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E

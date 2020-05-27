Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5B4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D778F20899
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:44:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JO4hX5vo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387581AbgE0MoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 08:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387514AbgE0MoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 08:44:22 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331E2C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 05:44:22 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id dh1so11014563qvb.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 05:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=SG6R5fwcwu0F3wXBZAetFtlGMrCPJrWFQW7Tk4R8pX8=;
        b=JO4hX5voxOSBXrFSDCfVw+fU62Ree4bW4Gy/nlNHSBO1n6UWZrpq8mvT8fC5YaJ2w1
         pp8wQ8vb/F9udJvwHpWe0OBLKrmexHwi+TdPMmUSz0O3B5ID6xLVA0VOQciRNt7mvxGw
         A4PABBg/oAvMzPdS/iJn2OAXDHb2XyuFGU6m+w0qAj2/Rq7/BWkMgSMex4/4wc1KvFmQ
         gTp8vxtwz5eCDOe8de+CJNYDvfYEAlZMGHqhuV1Wxmgadjtdyamdj+3UodxPr1wGDl23
         tEZ2ICPVIt7C5nqLMV6HGv0c6PWtdybcP0cFzzf6SXMxQrqy738pVMY7x3wOcgiztCAX
         NZhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=SG6R5fwcwu0F3wXBZAetFtlGMrCPJrWFQW7Tk4R8pX8=;
        b=HEGcL2ZA49FKXc4h74GpiryyXsCvrL1ZwOuTrQBGoUkgr9t+GO5MXfrQRCTTXNXAzO
         XU+efLu96USBwa7cVJHiKq8IEqwhSKJzCQiIrcoCAGg6tCnwvBVe/NOBsspmA3SbLOEg
         GLjvvQY6zfijsL1XJtdfkHyCta/s8J2iC+ky6s0PAcVpTL9pa3V88XcOuVpLm6lodUgj
         XhNxJ7ebHjeZvh8+NrCJtVBE8nsuvsrIwtCh2orn+rhGn245d2pIX/JBgGf+842gqW/3
         S6tIWvJDbLC6JNdRHY89nQqR7vDocTlsUVDTM640ewQbSzZ8WwrqwVifRFzYVgUjHFsE
         GvdA==
X-Gm-Message-State: AOAM532Y49P4Ok7HyDG2WdGZDXZjj274htS3Zb0bkg3vlafy3tSnKI7J
        kMQAAMDM096DVn6A9jVCTIU=
X-Google-Smtp-Source: ABdhPJwakQCUE8zxEyozSmQIsktEcJrASJvgQJPKyDtIxsRIVMwLdjYWz6d4+l/FnbrcS94apfuEKg==
X-Received: by 2002:a05:6214:1021:: with SMTP id k1mr3776904qvr.180.1590583461236;
        Wed, 27 May 2020 05:44:21 -0700 (PDT)
Received: from [192.168.86.185] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id b11sm2275339qti.50.2020.05.27.05.44.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 May 2020 05:44:20 -0700 (PDT)
Date:   Wed, 27 May 2020 09:43:40 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <xgl9367mndy6.fsf@arm.com>
References: <20200522065330.34872-1-nick.gasson@arm.com> <20200526115547.GF333164@krava> <xgl9367mndy6.fsf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] perf jvmti: remove redundant jitdump line table entries
To:     Nick Gasson <nick.gasson@arm.com>, Jiri Olsa <jolsa@redhat.com>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Message-ID: <FAA0E3A0-505F-4EEE-9509-A174FACB6AC6@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On May 27, 2020 2:29:05 AM GMT-03:00, Nick Gasson <nick=2Egasson@arm=2Ecom=
> wrote:
>On 05/26/20 19:55 PM, Jiri Olsa wrote:
>> On Fri, May 22, 2020 at 02:53:30PM +0800, Nick Gasson wrote:
>>> For each PC/BCI pair in the JVMTI compiler inlining record table,
>the
>>> jitdump plugin emits debug line table entries for every source line
>in
>>> the method preceding that BCI=2E Instead only emit one source line per
>>> PC/BCI pair=2E Reported by Ian Rogers=2E This reduces the =2Edump size=
 for
>>> SPECjbb from ~230MB to ~40MB=2E
>>>=20
>>> Also fix an error in the DWARF line table state machine where
>addresses
>>> are incorrectly offset by -0x40 (GEN_ELF_TEXT_OFFSET)=2E This can be
>seen
>>> with `objdump -S` on the ELF files after perf inject=2E
>>
>> hi,
>> I can't apply this on latest Arnaldo's perf/core:
>>
>> patching file jvmti/libjvmti=2Ec
>> Hunk #1 FAILED at 32=2E
>> Hunk #2 succeeded at 67 (offset -4 lines)=2E
>> Hunk #3 FAILED at 85=2E
>> Hunk #4 succeeded at 114 (offset -7 lines)=2E
>>
>
>Sorry I based this on my earlier patch series below but I didn't
>realise
>that wasn't merged to perf/core yet=2E Could those patches be applied
>first? I believe Ian added a Reviewed-by for all three=2E
>
>https://lore=2Ekernel=2Eorg/lkml/20200427061520=2E24905-3-nick=2Egasson@a=
rm=2Ecom/T/

I'll check, thanks
- Arnaldo

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E

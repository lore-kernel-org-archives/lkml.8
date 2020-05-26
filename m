Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23533C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 029202088E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 20:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tsy3Axra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391101AbgEZUTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 16:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390072AbgEZUTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 16:19:38 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385EAC03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 13:19:38 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id z1so5207549qtn.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 13:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:user-agent:in-reply-to:references:mime-version
         :content-transfer-encoding:subject:to:cc:from:message-id;
        bh=eGrZ5Z25UeU34jwZ5F+ogfpWW5+KOBdpUEpF//oRRUo=;
        b=Tsy3AxraLmkuCWRExRuWlKbMpIxdip3P/SJeZZ8Mmral4GykuahocEMfZKJ3sj9C3C
         HCkmBttZHZtlA4y1DSU2J8LtgTcbtguDrqAFOqgakTh/rnh7XO/mdPXkv6onuCj+Yooe
         7BOgGmEwm/cM/Lbt4IkeZG54NgMI7R12XsDyPzTyeSPoAODR3TtyyC1JBppXB2JYO2Vj
         MBpFTDyEefx6iC87BPF++SifQ1tajkq0B6p/+x6buRv/vUcOLxcatYZWrrKohFqY1Aa2
         AKeGo0yc53BE44MllPloHMZ5oAA1EcIkZu1q48zqFTpTCwmhfNehf6jyzexQI6cBDJIH
         bH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=eGrZ5Z25UeU34jwZ5F+ogfpWW5+KOBdpUEpF//oRRUo=;
        b=gmb+gZEclNoRk6cnrqElv5BelG8CAE0G+J9by/wvBlkqdpp/5EnT4PS/6co3DbxYX6
         2WKB9Gu53Yex2X/g5eP0BabxOrMy8aDw0Lj/JpXgAlR7arEL2KZu7FbHYRC0fBOx+sKn
         P8j4WPaUNSIeZeEDq7yyL1IG9AmxKL67Sc3CyvMA4fIMJHIyFjQIWZ5gkOvxcT3vC/m+
         CpTEvxbzHq8avDCMHBGEiGkPZIg8Hiic66Y2JsvaER+EXIarQkWh/Sg0VgmpXNlPF8Sb
         UA/GihcvQfTEB4MmvlA8D/nSaIRk6VNvxC6Ju8fG82g6L0jbwEFiaWjEzGEYjKUi9XKE
         ukrw==
X-Gm-Message-State: AOAM531Y0SEafAF/+tK0Z0a02+vmo7KGXWgVfyefvTwCCIt4+M7x7sAH
        BmEx3GfaeOXu0vr85CoCBIA=
X-Google-Smtp-Source: ABdhPJzmCku52w9qpYj0l+eU4ivinCEblkCigYkaMpQxkUIQEzDHH2JDK6SFJNGu1ihmsrgw1aiPfw==
X-Received: by 2002:ac8:6f1a:: with SMTP id g26mr613532qtv.121.1590524377267;
        Tue, 26 May 2020 13:19:37 -0700 (PDT)
Received: from [192.168.86.185] ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id m33sm630032qte.17.2020.05.26.13.19.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 13:19:36 -0700 (PDT)
Date:   Tue, 26 May 2020 17:18:58 -0300
User-Agent: K-9 Mail for Android
In-Reply-To: <20200526195438.GC2206@willie-the-truck>
References: <20200504115625.12589-1-leo.yan@linaro.org> <20200522030919.GE32389@leoy-ThinkPad-X240s> <20200526102602.GA27166@willie-the-truck> <20200526104337.GA7154@leoy-ThinkPad-X240s> <20200526195438.GC2206@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 0/3] perf arm-spe: Add support for synthetic events
To:     Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linaro.org>
CC:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Al Grant <al.grant@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Message-ID: <A92F8BED-232A-4645-9786-941469BCC9F3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On May 26, 2020 4:54:39 PM GMT-03:00, Will Deacon <will@kernel=2Eorg> wrot=
e:
>On Tue, May 26, 2020 at 06:43:37PM +0800, Leo Yan wrote:
>> On Tue, May 26, 2020 at 11:26:03AM +0100, Will Deacon wrote:
>> > On Fri, May 22, 2020 at 11:09:19AM +0800, Leo Yan wrote:
>> > > On Mon, May 04, 2020 at 07:56:22PM +0800, Leo Yan wrote:
>> > > > This patch set is to support synthetic events with enabling Arm
>SPE
>> > > > decoder=2E  Since before Xiaojun Tan (Hisilicon) and James Clark
>(Arm)
>> > > > have contributed much for this task, so this patch set is based
>on their
>> > > > privous work and polish for the version 7=2E
>> > > >=20
>> > > > The main work in this version is to polished the core patch
>"perf
>> > > > arm-spe: Support synthetic events", e=2Eg=2E rewrite the code to
>calculate
>> > > > ip, packet generation for multiple types (L1 data cache, Last
>level
>> > > > cache, TLB, remote access, etc)=2E  It also heavily refactors
>code for
>> > > > data structure and program flow, which removed unused fields in
>> > > > structure and polished the program flow to achieve neat code as
>> > > > possible=2E
>> > > >=20
>> > > > This patch set has been checked with checkpatch=2Epl, though it
>leaves
>> > > > several warnings, but these warnings are delibarately kept
>after
>> > > > reviewing=2E  Some warnings ask to add maintainer (so far it's
>not
>> > > > necessary), and some warnings complaint for patch 02 "perf
>auxtrace:
>> > > > Add four itrace options" for the text format, since need to
>keep the
>> > > > consistency with the same code format in the source code, this
>is why
>> > > > this patch doesn't get rid of checkpatch warnings=2E
>> > >=20
>> > > Gentle ping =2E=2E=2E
>> > >=20
>> > > It would be appreciate if can get some review for this patch set=2E
>> >=20
>> > I was hoping that James Clark would have a look, since he was the
>last
>> > person to go near the userspace side of SPE=2E
>>=20
>> Yes, I have offline synced with James and James has verified this
>> patch set at his side=2E
>>=20
>> I don't want to rush to ask Arnaldo to merge patches, so just
>> want to get wider reviewing if possible; otherwise, I will rebase
>this
>> patch set and resend to ML=2E
>
>One thing that might be useful is if James could offer his Tested-by or
>Acked-by on the public mailing list=2E Neither Arnaldo nor I have details
>about your offline sync!

That always help, indeed :-)

>
>Will

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E

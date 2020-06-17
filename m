Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAACC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:27:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82B4B21532
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X9G2VFwG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgFQQ10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbgFQQ1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:27:22 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70509C06174E;
        Wed, 17 Jun 2020 09:27:22 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id d27so1690911lfq.5;
        Wed, 17 Jun 2020 09:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tBdtd4BbSytzH+yn8Qia+tXk6Gs+WeAHP5EfpLtwsp8=;
        b=X9G2VFwG+kypTS6e33cyAimN3ATS28yZLc7+RSukAtDpY5QYY5eBQglww7MLPaD83h
         rIjriWkglL5vxCbr9qVzPqpgVokj4HScFR3NLVbSnJXCLhoTuTj9hjZnei3VFIo0eqdT
         LDdAFXSb1RyMLiZvwWwcKSt7m2G/hqSM8WsK1nQImL+Lgc8EdmrtI9Zvmo64XBYkLspo
         xTE3pCfFLaIOAqBCJsNxj7FNwkdMsZrASXddwxBKlVreXyld5TyYvyUtvfvplsRnZEIe
         tKAUpR/W47SCAZ205IDRQmsy0dVteCso6LPZyUvfG+rAVyFXWxHSUIjXfKdtl+GpzcdF
         gceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tBdtd4BbSytzH+yn8Qia+tXk6Gs+WeAHP5EfpLtwsp8=;
        b=ADUEy6W/ZfBTc2MypJaRmIYSrHWp3Mjw90Lvdv6AJZdjbiEHHQzFpb7/6/o5S8MZEv
         ad6fScbY/UKbTJTRfHCqsQR3W+SM/E+6gwW7PtzlH2PcZ3sQCzhTLhzxF3nb8EImiyUZ
         G719tdhEwG7YTt4fXdkoDmBhZOD4n6mkJzjjh2HkvQaf8hq17vEtOJk00IyEDUjb62H/
         l/cceZMFans6BvVGPKaYCuSyMFWLPyuZ/KTFAI3BTzR3N6vG0W9yyDUSpRGMRQ3x4Ci5
         wSKjR1SkSJeVuReBc2+/SrFZ9HFlJ21vCfLepF6mKDNu+oGUAr2WIGhtSjs7Mxk10kcC
         dTPQ==
X-Gm-Message-State: AOAM531IFpsq5e2PGbkyUmokP8wjpp+uo7HAsemq/ZkGIJBJmP3iNfxz
        hPr2i0E67zTfvdCOIv2orxk=
X-Google-Smtp-Source: ABdhPJzdlve8SscpxQ5lGHRdQw8g0xXtnEZx4khfcDzoIbDFkaI6tCr5C/kFsj24d1QGCa4B73gq5w==
X-Received: by 2002:a19:8389:: with SMTP id f131mr4963732lfd.16.1592411240453;
        Wed, 17 Jun 2020 09:27:20 -0700 (PDT)
Received: from [192.168.2.145] (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.googlemail.com with ESMTPSA id b25sm66852ljo.16.2020.06.17.09.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 09:27:19 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] 180 degrees rotation support for NVIDIA Tegra DRM
To:     Daniel Stone <daniel@fooishbar.org>
Cc:     Emil Velikov <emil.l.velikov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>, linux-tegra@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
References: <20200614200121.14147-1-digetx@gmail.com>
 <CACvgo51QuXMgWhFk4C=3rGvUZDX1_W0RZtVb5RtRPiHTpMebWQ@mail.gmail.com>
 <8f789ef5-bebf-c869-784d-afda70fc1fb8@gmail.com>
 <CACvgo50oSMbgXw1vHwVT4hhGe6g3YzKQEohCLJdfDq+0UaN1jw@mail.gmail.com>
 <646b3f37-0f72-7f3b-388f-f71dbcdd5c84@gmail.com>
 <CACvgo50BFH5qsPyWx9a1aZ4k5bzjSN-3KTU0BvnZ-nG-hfzKOQ@mail.gmail.com>
 <fe845434-cbf6-29d4-eeb6-8868d628fd04@gmail.com>
 <CAPj87rPwwHWtYpuZfiTMyELvr3D+UAY8CVnH3v6+Lo1-UMRRVA@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <36496bd6-b18a-de97-1afb-f2f8aeb3feaf@gmail.com>
Date:   Wed, 17 Jun 2020 19:27:18 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAPj87rPwwHWtYpuZfiTMyELvr3D+UAY8CVnH3v6+Lo1-UMRRVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

17.06.2020 12:34, Daniel Stone пишет:
> Hi,
> 
> On Tue, 16 Jun 2020 at 22:16, Dmitry Osipenko <digetx@gmail.com> wrote:
>> The panel's orientation could be parsed by any panel driver and then
>> assigned as the connector's property in order to allow userspace/FB-core
>> to decide what to do with the rotated display. Apparently upstream
>> kernel supports only that one Samsung device which has display panel
>> mounted upside-down and it already uses the custom DT properties for
>> achieving the 180 rotation. So I don't quite see any panel drivers that
>> instantly could benefit from using the rotation property. Perhaps I can
>> add the orientation support to the panel-simple driver, but will it be
>> useful to anyone?
> 
> Yes, exposing it to userspace is helpful, since Weston at least will
> parse the property and then apply the correct transform:
> https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/315

Hello Daniel,

Thank you very much for the pointer! I missed that Weston now uses the
panel's orientation. I gave a quick test to the recent Weston and indeed
it applies the transform in accordance to the connector's orientation
property.

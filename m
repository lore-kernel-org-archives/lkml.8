Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D30FC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7801C20757
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 17:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrDyMiyN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbgD1Ruu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 13:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbgD1Ruu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 13:50:50 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5C4C03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 10:50:50 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id q2so10827253qvd.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 10:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4RsoYDdTGu1SZ+s46DR7Sp4Vbgb9d386KsPLmLSTiqw=;
        b=YrDyMiyNCzxWECcH0V0f3xofFUSdJeusuMiG7X15GKAQ0vYe39ceX5HCEYlYg0VG3S
         7+5JlXXp3an8Qt+HUemrMnXLjXY435z74/PTqaheVvPMus0ddIXXVszvS/JSqE48ZbdF
         QLsDBdkv7hHzggeHEcqFhDDXiuVJy9O53JkqRgbgWRI/cCVGi/zY04GlDptgdGZngHPI
         Jke4Wl3wrW3tQD/QWFAyO332DqOHbX2FRXAjRoSZXJSG42bsOsSGeP9pc7jGXKio/Wf2
         rA6pw8cpHVZ9EDFmvejsod2sx5n0jyjkPX+Q9pRH/KmEZwjbsv1faQwNrSLiS67FxkVY
         nmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4RsoYDdTGu1SZ+s46DR7Sp4Vbgb9d386KsPLmLSTiqw=;
        b=fGPQBwEzSvLnh5EmWNEXPw+JrB+wUS5pKYOe5wHa1jlkxjQHWFCtBg/UNE+TMiAuRA
         IXMdt6OIhzb9VbCMi078BF/q5VR3Jbg9BYH8BpKuC8xqQ6oT6C4y5QGfIkDup4z6JaAm
         tD6ccAnh+6jK9N9PEnwUxqsKRVYNHDT9auKEzujPtg6XYKYmQDUpbcxcUX2BTwP4nEXO
         mTDJq/08RiymMJ7cJziqj2ssi0eVgv2u8a5sQ7F0nFB+QbGcbe81kB8FCIrEaFxkz4m1
         Swk04aAisGOT07eA2tcrKoWE2X1cwwzhVykK3mY1/SKsEH8ezO8MdvKfD7tZYBbKZhkB
         vX/g==
X-Gm-Message-State: AGi0PuZgbx5pLWXiSDGXUYybWF3UhJC73ghGJCVQK/FqIDiZ9CVm6ayQ
        McvWTQJsUeXOa2pa63aEw38=
X-Google-Smtp-Source: APiQypIueOIN167ElVB/8dF0GEXs7LDtcOAJf/t20iMH2Ji2Y9QYBU+6psehmcOX7Oo7HL5XZ7A3ZA==
X-Received: by 2002:a05:6214:1812:: with SMTP id o18mr29787810qvw.64.1588096249237;
        Tue, 28 Apr 2020 10:50:49 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id e8sm13395494qkl.57.2020.04.28.10.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 10:50:48 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 126F4409A3; Tue, 28 Apr 2020 14:50:46 -0300 (-03)
Date:   Tue, 28 Apr 2020 14:50:46 -0300
To:     Zou Wei <zou_wei@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] perf script: remove unneeded conversion to bool
Message-ID: <20200428175046.GD5460@kernel.org>
References: <1587904265-865-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587904265-865-1-git-send-email-zou_wei@huawei.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Apr 26, 2020 at 08:31:05PM +0800, Zou Wei escreveu:
> This issue was detected by using the Coccinelle software:
> 
> tools/perf/builtin-script.c:3285:48-53: WARNING: conversion to bool not needed here
> tools/perf/builtin-script.c:2839:36-41: WARNING: conversion to bool not needed here
> 
> The conversion to bool is unneeded, remove it

Thanks, applied,

- Arnaldo

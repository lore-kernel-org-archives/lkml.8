Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F316C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF8F22C9F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596488751;
	bh=BRNU18Dd2KXV4shv+fX1dMhET2qEHhyQRbZE4S9P2dI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gprtl6NkIdal3Gd2eDpYaMWM1BA9amdt7MXDaY1HSftmRSkrmdoztN0mO6HfFR+0w
	 zJ52b3Ut+FLNwsiYNmfP9xcZ5HRZvZ0jIkYdNQtlPa1KUvbNothQw2ALE4QmTKviZi
	 7PTwgi9iFo0aleXtbXV2wDIZdq6qfywKeI/TKOLU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgHCVFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgHCVFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:05:49 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 726AEC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 14:05:49 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id i80so21191311lfi.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 14:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CKnuHzsPFl3igWb8A7Hqb4zxCAnSQsvvvuOQtZj62Yg=;
        b=bDASN69sSb9uMh0TJLpCPepp3MmCFHCIGBlN2sijiSgnFv+KcJOKK2TxJQTHm90WSK
         2vtr8w9lVx6HUAYgnD62xrWS96qR/oWrJX+YcbPzNwh6BlUcztXOWxvKrrk6qMad1rI+
         BoSlcfsCOQttzv8zWsudz+wIl8atq1nIl+cbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CKnuHzsPFl3igWb8A7Hqb4zxCAnSQsvvvuOQtZj62Yg=;
        b=M75dZOvm9PqUWlmzMF/Q2ti0oLub7VpF6XBliSEgh2KVHE+vtMRk2kB56FZAAfywDw
         AxkF3FSYAKes/7ZCJlh4WvoQ2zCmZvSuwxrH/ygALUrztaDQK56IvOO78NVymmAanQL5
         M1xh38sqSXI2L8hoQh+F2CKSqnx6ebxtDeUYvLKjYhbv4sTTwdAkmRU4AUeyTXnyoeg1
         xsR50P+yy9d+7xjH0bs5ftgqWglzfwtvtz6Edr16EczG5OUuvIXvk/otI9zdXTbvKZb0
         Ms6U5wvs+yluQZ14H0hEy51eXsnoO7sHzMnSWuposxbo6FrAgVcoKb0eGSqNGFarfIBA
         ou1A==
X-Gm-Message-State: AOAM530hZXrRXroJyXn3ndSQeLGiXB5Z30Xtzr8u7OeMyLOFTzURbkzn
        F/R/NdvSemz2ucz+ce03bdMjpKw9wKg=
X-Google-Smtp-Source: ABdhPJw9A5D9YoHPptKLLE8QOme5vMYjDuhQ5K+bI3JnMRlKAb5y7qmgcquVRoT5uJZkOYB/3lVheA==
X-Received: by 2002:a19:c7d7:: with SMTP id x206mr9153024lff.67.1596488746350;
        Mon, 03 Aug 2020 14:05:46 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id j2sm4625075ljb.98.2020.08.03.14.05.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 14:05:45 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id v4so31529291ljd.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 14:05:45 -0700 (PDT)
X-Received: by 2002:a2e:9a11:: with SMTP id o17mr1326612lji.314.1596488744685;
 Mon, 03 Aug 2020 14:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200803093939.GA8243@kernel.org>
In-Reply-To: <20200803093939.GA8243@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 3 Aug 2020 14:05:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wipLW2khbyYT2sGPm4p6ru+0brUxRRwiRD6zBo37WYAAg@mail.gmail.com>
Message-ID: <CAHk-=wipLW2khbyYT2sGPm4p6ru+0brUxRRwiRD6zBo37WYAAg@mail.gmail.com>
Subject: Re: [GIT PULL] remove unicore32 support
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Guan Xuetao <gxt@pku.edu.cn>,
        Guenter Roeck <linux@roeck-us.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 2:39 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> The unicore32 port do not seem maintained for a long time now, there is no
> upstream toolchain that can create unicore32 binaries and all the links to
> prebuilt toolchains for unicore32 are dead. Even compilers that were
> available are not supported by the kernel anymore.

Fair enough, pulled. If things change, it's always there in the git
history and people can resurrect it.

               Linus

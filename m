Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A21C33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD5B20718
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h6fTyk31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgAWWyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 17:54:21 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35095 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729154AbgAWWyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 17:54:21 -0500
Received: by mail-lj1-f196.google.com with SMTP id j1so232532lja.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 14:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4i0xRegMdNqxOxG+y1FBl3qD0d4qg24N4qcbY2rQ3vQ=;
        b=h6fTyk31IwwLg8KNhheI3woUC/D2zkf8XziVhs7JXsImTaRLC2DXm9BJAE6u+BMgjK
         73MNy0gWxtpbOyDwxzvluEvf+NqpO/USzFZ726Oz2yVqZNBJk/Lpps9OfFcYEj6AfB9L
         o1Gs5eQMBdoRwGanZpLB0BWUuybs52+Nj83ZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4i0xRegMdNqxOxG+y1FBl3qD0d4qg24N4qcbY2rQ3vQ=;
        b=EyfLABjDtW/+k3YhyOTo0EsZGQq4UXeIQ2mV5p9Okmt07Y66r5wZ8CxUv6oDT/JRBM
         Y4PORhbJL17frnMnAPwtKvmOCysTxqmiGrNHqn4zkPIYxRECr4H6j/GZF1mAzrBtmxNL
         I0ijHXhPUMuyBPmXa5ezGMl49Scplx9L++mE1eaGdhJwPomB0ByuZ4cBsgS1E8+4HYtZ
         WjD4KauY1GARvsolY9atW6JO2GjogDp+dgDk7qo7jHp+iBDTcqDRuQpWdn/U+rVQ38ZI
         P+a8dS5X+no9ps/OXiOWnx6dI7toRpZfQjcI4jGH6F9HiSy1JQ7b6TO/e3xGBE94cH24
         zccQ==
X-Gm-Message-State: APjAAAW2J0zO7nZItTTFusYeyN5TY9HIx7eMC8BO1TeDhgshXgK1KNgk
        7L3mux0JOeA8G4LUlipyyAu18cYJV40=
X-Google-Smtp-Source: APXvYqymlv+5s6VwulJwt5dNHqTQa9ANpOTXIVmdivvgOPGvqrPgjXETqXNPG1AWAdBEMykOo+xF+A==
X-Received: by 2002:a2e:9b93:: with SMTP id z19mr422726lji.290.1579820058873;
        Thu, 23 Jan 2020 14:54:18 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id m3sm1744104lfl.97.2020.01.23.14.54.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 14:54:18 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id l18so3612662lfc.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 14:54:17 -0800 (PST)
X-Received: by 2002:a05:6512:2035:: with SMTP id s21mr31943lfs.99.1579820057323;
 Thu, 23 Jan 2020 14:54:17 -0800 (PST)
MIME-Version: 1.0
References: <20200123131236.1078-1-sibis@codeaurora.org> <20200123131236.1078-2-sibis@codeaurora.org>
In-Reply-To: <20200123131236.1078-2-sibis@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 23 Jan 2020 14:53:41 -0800
X-Gmail-Original-Message-ID: <CAE=gft7sztBTs4mhF2X0eKnjJNBBRxXP5VOr4rsAw=SOYDi4jg@mail.gmail.com>
Message-ID: <CAE=gft7sztBTs4mhF2X0eKnjJNBBRxXP5VOr4rsAw=SOYDi4jg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] remoteproc: qcom: q6v5-mss: Use regmap_read_poll_timeout
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ohad Ben Cohen <ohad@wizery.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 5:13 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Replace the loop for HALT_ACK detection with regmap_read_poll_timeout.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Evan Green <evgreen@chromium.org>

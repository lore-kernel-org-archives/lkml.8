Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831FBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ED5D206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 17:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ylu6kQeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgFBRjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 13:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgFBRjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 13:39:51 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A73C08C5C1
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 10:39:50 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id z9so2962224ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 10:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WFiNn0czVB+5Qq9qqdAj5GWmVsqpkK4lAR8rumTBlGI=;
        b=Ylu6kQeCiib8NSRj21Glov2/3k76t5BUisJNWTzmtl0NInwNiQekUahRsaCY986xQj
         +i14XNoukMO/gkMjW/DGRgytDn8FdWidix9tjt4lcw/R4hip81CyQ0Hb/OelssRrnFWW
         shR+LH6YHd83epU1et01q3pe9k1pQQ9wK2D2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WFiNn0czVB+5Qq9qqdAj5GWmVsqpkK4lAR8rumTBlGI=;
        b=ukCwyWyFJsdXBp1CaPXWCesl9dXj2KChFFd4Z9/VXX45+aiXz0Jy/V+fNrvTv+yxU/
         n8aLu57fwPAk1S+oeFE0hDYwkjHiWFmxyKzRXBJzzgSqCJmO/SNi80PBgg4E88QWYtgC
         UfmnL3IJMOws9+4AHuoxn9SpsSJtJ11Gl2Mjt+RUXz3/yHZAsnT5dAGjAmqEyM2RAnje
         xdHcLa0OE2Z8L9gJzySynXjcNAcipVbYJZMgoB/Th8bMu02+4dsbao8U42nhFg8a8CEI
         +bulhOrtsmNZ1ggeb+/VTLI9JwY93VLkoZvwQwT0yinLZm4nEdDOnu7byWEJ1Pe7A5mu
         WEnA==
X-Gm-Message-State: AOAM533/gcMKGFs2K98fnrKJGc6kj6ljP14dTdPHHjlME33AEvzaRaxF
        +OjkGdaggld/RDlGdSr7xf5CQ5W7d+o=
X-Google-Smtp-Source: ABdhPJyHvi43CtJPzlNgGmoJZjEx+wmEVI8102L1oZKDr8cFng2quBhcLzF2N+jjpwHk+IUdewHdYQ==
X-Received: by 2002:a2e:584e:: with SMTP id x14mr109930ljd.380.1591119588271;
        Tue, 02 Jun 2020 10:39:48 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id f18sm847666lfh.49.2020.06.02.10.39.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 10:39:47 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id w15so6660234lfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 10:39:47 -0700 (PDT)
X-Received: by 2002:ac2:44bb:: with SMTP id c27mr257871lfm.59.1591119586548;
 Tue, 02 Jun 2020 10:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200602163257.26978-1-sibis@codeaurora.org> <20200602163257.26978-2-sibis@codeaurora.org>
In-Reply-To: <20200602163257.26978-2-sibis@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 2 Jun 2020 10:39:10 -0700
X-Gmail-Original-Message-ID: <CAE=gft5RNxfUwDBrFe=NTXm5P75Bp19SRX-bL8kyy-dnr2P3xg@mail.gmail.com>
Message-ID: <CAE=gft5RNxfUwDBrFe=NTXm5P75Bp19SRX-bL8kyy-dnr2P3xg@mail.gmail.com>
Subject: Re: [PATCH 2/2] remoteproc: qcom_q6v5_mss: Remove redundant running state
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ohad Ben Cohen <ohad@wizery.com>, rohitkr@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 9:33 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Remove the redundant running state, as an equivalent is maintained in
> the common q6v5 resource handling helpers.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

This variable was written to and never read, sigh. Thanks for cleaning it up.

Reviewed-by: Evan Green <evgreen@chromium.org>

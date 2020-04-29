Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E49BC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67786208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BrwJd7jH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgD2R2U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726493AbgD2R2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:28:19 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859CBC03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 10:28:19 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id h6so2403129lfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 10:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gsj/DMCdq2iHsv9iEgXgXTTdBXXORDwu7caTzYP7OC0=;
        b=BrwJd7jHAjw/ndKeVTDpR19v/ATSbqBb1x/5jMBcAmWWLYzhUU0mhqocbwlSjelc+/
         TS+pjF4F06f6y7KRfVmNvULvilWng5nsq6/LOfIBTZVCduGAQDW9ErnXCy5dlYQxyN2C
         yKfSS8+yRr3IK2V9SY0WJCnKvhNO8YUy30oGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gsj/DMCdq2iHsv9iEgXgXTTdBXXORDwu7caTzYP7OC0=;
        b=sIzKRP19j+7fhImr0viMBvEzm3lcXf22+e/AcytdVpLOX/TT0Z7NKbG1JOTxcvmnFA
         ZwXmDMwARxNnI82Hlj1ZOoVrD2Ws4RRAz5DCMgumkALP1Dfu0OgXJj9N16rxCFnzZMVt
         LicVJaPGapUSmsiZpRtztOEb1Ack87nx/lhlEGlBvcDilcnEh2WwnutQyLN3eVyLuTrG
         5qUtNa1Y+i4boQBoYf3ieLZzA4Kju0mWUXhIXxek2ibhiSzgDXyINnmNysa6q+h19kMl
         NqzniPs1HP9L3029YQ9JCaZmO3d0fLDj0u77JFULeXLmfY8VfMgaRG8n85FxU/ibXgas
         mlvA==
X-Gm-Message-State: AGi0PuYZLLDETAnXWTYhNxr7YU3EyZq3V/mJL7HkDRewd3wiTygtyUQF
        /ym9YysgDRYE9SMfmeJxm3uM4k5xvdA=
X-Google-Smtp-Source: APiQypIXN3qRD9SubLb2pyZJ6L6EjzIit+nIBMXCUSJR+kVV/ihoZPFEz/qnklDVNrBjJEp05olAyw==
X-Received: by 2002:ac2:46ea:: with SMTP id q10mr24290655lfo.128.1588181297579;
        Wed, 29 Apr 2020 10:28:17 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id u16sm2865053ljk.9.2020.04.29.10.28.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 10:28:16 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id u15so3521435ljd.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 10:28:16 -0700 (PDT)
X-Received: by 2002:a05:651c:449:: with SMTP id g9mr21840460ljg.278.1588181295980;
 Wed, 29 Apr 2020 10:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200415145110.20624-1-sibis@codeaurora.org>
In-Reply-To: <20200415145110.20624-1-sibis@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 29 Apr 2020 10:27:39 -0700
X-Gmail-Original-Message-ID: <CAE=gft5REvz+0JLHtEN1BXmvWzMxftdecxPedLizgS47x1Sq7w@mail.gmail.com>
Message-ID: <CAE=gft5REvz+0JLHtEN1BXmvWzMxftdecxPedLizgS47x1Sq7w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Drop all accesses to MPSS PERPH register space
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ohad Ben Cohen <ohad@wizery.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 7:51 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> 7C retail devices using MSA based boot will result in a fuse combination
> which will prevent accesses to MSS PERPH register space where the mpss
> clocks and halt-nav reside. Hence requesting a halt-nav as part of the
> SSR sequence will result in a NoC error. Issuing HALT NAV request and
> turning on the mss clocks as part of SSR will no longer be required
> since the modem firmware will have the necessary fixes to ensure that
> there are no pending NAV DMA transactions thereby ensuring a smooth
> SSR.
>
> Sibi Sankar (2):
>   dt-bindings: remoteproc: qcom: Replace halt-nav with spare-regs
>   remoteproc: qcom_q6v5_mss: Drop accesses to MPSS PERPH register space

I haven't tested things in the "production" fuse configuration yet,
but in my current configuration I've got a tree that's running the
modem well.

Tested-by: Evan Green <evgreen@chromium.org>

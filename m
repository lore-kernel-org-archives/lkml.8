Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43996C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19A3E2465A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OkVCGz+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgAUTXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:23:11 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41779 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgAUTXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 14:23:11 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so4033791ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 11:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YKI7RZmx8WIsu/1jkmDBgBIbsrKWimA13AS/a7z41jM=;
        b=OkVCGz+bGet4DPAM/foAEd9BMUu/jrSmT5bD+lpif+woa/1qtYAWKeuae3GN1TXxFC
         fN0PjCyqJxDQXlc+HzwCvn72zC4m1voNdy8vYPK0I2oa076DFfMzYlcS3h8Z7dEUCVhr
         sYhona6mMCuJpDxIy1Tjb8BqMVtEPGCLKgWhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YKI7RZmx8WIsu/1jkmDBgBIbsrKWimA13AS/a7z41jM=;
        b=i+6XI06q8Rda9kmrOPQRk/41kTRmiv8t5qSBIJrwA9nGoDYoQ9mU1TxE0IBtiqA8K/
         oUO3nIop8iAGmsPYmzdZUxBJdW10tSg2Q3eh+J9VaWS2Z59Y+Rsie/lQ1M8Dj8CVYOwR
         Dp8YVf2tgQD5+tlmcLtW+TzFIoRaJeLrcoCPlzgwmkBLcHiLXr3qXkiSUcnatbMH6iPE
         1gd0o3QmCuV5iF1+SvfdMIfwgnyvHUt97Wo4zxqiuUl3y/OryITRyf8oabzP9M+T93K5
         1DYtt5DYQFapyVVFvyUUy1ICn5OsaNhQXxJHTLIe8jD07GDfj+OQ3a1/AyBkZJ7yCyzQ
         t22g==
X-Gm-Message-State: APjAAAUSpg5ul1IOoFYDaOIamzr5hwrP2YRNxBiA04W0MW56hl/yEUKS
        SuePQyx8VUidjMCnZslIjyoM0+LKa84=
X-Google-Smtp-Source: APXvYqwVETQ8RMmzinQpYCHCh8fcBXWJ2rhQ1DQXdFnPiLFuCdNEoOq7Asz4bkJFBrc22OubRRvHUg==
X-Received: by 2002:a2e:5304:: with SMTP id h4mr17998766ljb.75.1579634588198;
        Tue, 21 Jan 2020 11:23:08 -0800 (PST)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id s4sm19549117ljd.94.2020.01.21.11.23.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 11:23:07 -0800 (PST)
Received: by mail-lj1-f173.google.com with SMTP id m26so3989416ljc.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 11:23:07 -0800 (PST)
X-Received: by 2002:a2e:b4cf:: with SMTP id r15mr15921775ljm.52.1579634586588;
 Tue, 21 Jan 2020 11:23:06 -0800 (PST)
MIME-Version: 1.0
References: <20200117135130.3605-1-sibis@codeaurora.org> <20200117135130.3605-3-sibis@codeaurora.org>
In-Reply-To: <20200117135130.3605-3-sibis@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 21 Jan 2020 11:22:30 -0800
X-Gmail-Original-Message-ID: <CAE=gft4Erwjgvj18DuiJaTEUz=1DwzSBtiCTU0QuoGO1+kzsNg@mail.gmail.com>
Message-ID: <CAE=gft4Erwjgvj18DuiJaTEUz=1DwzSBtiCTU0QuoGO1+kzsNg@mail.gmail.com>
Subject: Re: [PATCH 2/4] remoteproc: qcom: q6v5-mss: Improve readability
 across clk handling
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

On Fri, Jan 17, 2020 at 5:51 AM Sibi Sankar <sibis@codeaurora.org> wrote:
>
> Define CLKEN and CLKOFF for improving readability of Q6SS clock
> handling.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

It took me awhile to wrap my head around how this new define,
Q6SS_CBCR_TIMEOUT_US, sometimes replaces HALT_CHECK_MAX_LOOPS and
sometimes replaces SLEEP_CHECK_MAX_LOOPS. I guess they're conceptually
different but set to the same value for now? And you've fixed up a
place where the wrong one was used? If you thought the distinction was
meaningless I'd also be fine merging these two defines into one.
Either way, assuming the above is intentional, this looks ok to me.
Thanks for renaming that define.

Reviewed-by: Evan Green <evgreen@chromium.org>

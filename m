Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86195C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCC120678
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 19:23:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HoAKMG0w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgAUTXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 14:23:15 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43649 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbgAUTXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 14:23:12 -0500
Received: by mail-lf1-f65.google.com with SMTP id 9so3251934lfq.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 11:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8rCcwlzRHHVYg3hiCBv7NmxGLfftNkVC0+svQxkapXc=;
        b=HoAKMG0wQ2wIiKTC05L+Bn7mtOknDgXQI4PO9uIp4w2SGyA4WKzyeicjM+2gCmY1jr
         vp7Mvfiy1LQGZhgbceOZp21oRkuxUd4XkR1DsidRJ+8vvN8/hSyc9kwfO3vsE4cQ1Lnu
         C9t8CGrIJFnHRmoI4O30boqJZqDvvlnB7z7GY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8rCcwlzRHHVYg3hiCBv7NmxGLfftNkVC0+svQxkapXc=;
        b=qeY201tcqDanezTyO5EsHa60p1nyy+9XeonaBBxcE3aA07ZvaskTsbY1qfheK1R5Zo
         FsWrtGXP7Q3nrO6gfD36K1TPhVu0k+Q4Q37x7pQneHqW3+sGTo3JfPiu2lKBOXvK7WSC
         sqeKktplkEvW4+ZtUkc5p/7cf4GXgkdcpvlG5ztkGgdkKPxYVKY4Id+ZQHN127WeOXMt
         G780QSqhQtgcJQI/mJmbY0TuM9u0n2Jo3Ey9XikrhA5VZZBw0nACfHnqOtzbaSBG6/NQ
         4r2Qw/cBBsBibCi8leJkmxjMlcesS9RSzMHSfv6VozugZmMRqSd785lpNvtcNzzP6c2i
         Q4Zw==
X-Gm-Message-State: APjAAAU0Yig0WA0+AO/xmMGI354VAflnM1/iTI1t+t4HEgbUCsjDsTTp
        Q9QcPDFXqzTLE6gQRfErKxM9u21HXII=
X-Google-Smtp-Source: APXvYqzppbWoRepa/Fgc7nUGeGVPBeq4Ldm0HD2pd+S7Jph7d6PqCNEOwILt0sK/3OGII35QRw3AkQ==
X-Received: by 2002:a05:6512:2035:: with SMTP id s21mr3191308lfs.99.1579634590235;
        Tue, 21 Jan 2020 11:23:10 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id p15sm19366566lfo.88.2020.01.21.11.23.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 11:23:09 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id y4so4021923ljj.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 11:23:08 -0800 (PST)
X-Received: by 2002:a2e:87ca:: with SMTP id v10mr3453604ljj.253.1579634587850;
 Tue, 21 Jan 2020 11:23:07 -0800 (PST)
MIME-Version: 1.0
References: <20200117135130.3605-1-sibis@codeaurora.org> <20200117135130.3605-4-sibis@codeaurora.org>
In-Reply-To: <20200117135130.3605-4-sibis@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 21 Jan 2020 11:22:31 -0800
X-Gmail-Original-Message-ID: <CAE=gft6WN52R1BckbgK9XCTB8TTY5Z6mh3QooceHTTtzVUmFLw@mail.gmail.com>
Message-ID: <CAE=gft6WN52R1BckbgK9XCTB8TTY5Z6mh3QooceHTTtzVUmFLw@mail.gmail.com>
Subject: Re: [PATCH 3/4] remoteproc: qcom: q6v5-mss: Rename boot status timeout
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
> Rename the FSM timeout on SC7180 to BOOT_STATUS_TIMEOUT_US.
>
> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>

Reviewed-by: Evan Green <evgreen@chromium.org>

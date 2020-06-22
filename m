Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7D4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 06:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 932E225414
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 06:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L680i4qL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbgFVGSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 02:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731238AbgFVGSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 02:18:51 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD0CBC061795
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 23:18:49 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 9so17887552ljc.8
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 23:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EwHajz3b3OzliZZ0iljg79Qo0FRnx6yIvPIMoMPNCF0=;
        b=L680i4qLfffD6qOBHAVVNs/RTGmimhbH54HePc+aAEEFMZsU+KwUMLtg0o3/KjZxwi
         AsJtSTQQ9TWWeiUXdQ6E95DBB6nBEu9Bw9RHmSduuUFi5efeqeK0TwchSwQmEm1b/LR9
         guCuBfe2PDw3TrUU4GG5GeGv7DXpvHYmlHIldJ2LtIJ7sYX6q2DjQR1wjBtOZiQOZo0Z
         c9Wg8EN9kOlCKoKR3DMaVb8rhfL6NJ6XMN3s8YaoUJrXHuvkQxL1kSCVF2HJjwP4WKbo
         VBXH7bVYaJLr5EKRWY/wyAk5DctM3eO6l3XrzLPT9iajAEGxLTpci91ZvZNz83XG70eE
         IcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EwHajz3b3OzliZZ0iljg79Qo0FRnx6yIvPIMoMPNCF0=;
        b=BSSph9oxtHjWHP0DPudwtasC74GWcZL6Jk+SrPdlhlQMIwSyvRW4AHqf+x3aX0cKvH
         7YKY+fWVk+gKy9Ajp+qpLbs0vubHqtJ7fU5ufrsKrLuRzIRhLH9Y/XFTakLBQoyGCoA4
         p150kQArRCgO7YFj9uPkGVXUP2RKMGK7be0xGqlatP2h8/+HzXCTelkm9bqrJoXO6qah
         iq8i0kJHDok74zj2zujIqhIDrcnqcQtZYT9M8mQkPYZEUHDEuoGGL0tNsUTSuIAb/mgf
         jqqefS6IUV0dEouCM2Da/zZSTsK8boylDKWua3snLKxERuwh43KLgTsiKriQgpCIV4Ly
         tmww==
X-Gm-Message-State: AOAM531ey/+ki0TDCtpPTsTHIlnpH0v71GkcnoAo8KlEVR3MnkhjrBgO
        W518rhAZ0FyNuCqOA+5MvpcGI9s6CoFOB1+ZCZ9qsw==
X-Google-Smtp-Source: ABdhPJzk1dBKVTKlDCM/pQw++y3L1fqg3Nln3xfdv33XwAIbfQ+dtjXOSdb7gqcWA/t3i5e0VbW2AJq+r8s5HIFRXi8=
X-Received: by 2002:a2e:9116:: with SMTP id m22mr7607612ljg.431.1592806727377;
 Sun, 21 Jun 2020 23:18:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200617065658.27567-1-naresh.kamboju@linaro.org> <20200621074003.GJ128451@builder.lan>
In-Reply-To: <20200621074003.GJ128451@builder.lan>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 22 Jun 2020 11:48:35 +0530
Message-ID: <CA+G9fYvOSRL5WaU1tYTxe4Y16h_kBbNsOibsH6Od5dc1tcmK6Q@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: qcom: q6v5-mss: Fix kfree build error
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, inux-remoteproc@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Vinod Koul <vinod.koul@linaro.org>, agross@kernel.org,
        Ohad Ben Cohen <ohad@wizery.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-remoteproc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jun 2020 at 13:12, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Tue 16 Jun 23:56 PDT 2020, Naresh Kamboju wrote:
>
> > This patch adds linux/slab.h to fix build error in qcom_q6v5_mss.c
> >
> > Build error:
> >  ../drivers/remoteproc/qcom_q6v5_mss.c:
> >   In function =E2=80=98q6v5_mpss_init_image=E2=80=99:
> >  ../drivers/remoteproc/qcom_q6v5_mss.c:772:3:
> >   error: implicit declaration of function =E2=80=98kfree=E2=80=99;
> >   did you mean =E2=80=98vfree=E2=80=99? [-Werror=3Dimplicit-function-de=
claration]
> >    772 |   kfree(metadata);
> >        |   ^~~~~
> >        |   vfree
> >
> > Signed-off-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>
> Thanks for the patch Naresh, it looks correct but I've not seen this
> build error myself. Could you please let me know what you built to get
> this and if you have any suggestion on what caused it? (So we can add a
> Fixes: tag etc)

Thanks for the review.
This was an arm64 modules build failure on linux -next 20200616 tag.
This fix has already been taken care of by
Herbert Xu <herbert@gondor.apana.org.au> and got merged.
Fixes: f0187db056dc ("iov_iter: Move unnecessary inclusion of...")

ref:
https://lore.kernel.org/lkml/20200616010502.GA28834@gondor.apana.org.au/

- Naresh

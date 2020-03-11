Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D4FC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 193902071B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:56:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yhFVqmA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbgCKO4X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:56:23 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39104 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729521AbgCKO4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:56:22 -0400
Received: by mail-io1-f67.google.com with SMTP id c19so1125308ioo.6
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 07:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zTBV1YV3MWdb88U2GtxQ8xdAPJhTSTNkra9Wzo0FSoA=;
        b=yhFVqmA0mw7SIwGb2k1318DO/Sz1xqmtBVpayL5T/+MNoLyYQdl3vvfkfx+OPKIGtp
         qJYYbXaUwpU9U98TivjFYmiOtDGC2eV1b265v+1iIeui+JMhHgZjPDX7v5/UOML/2nWB
         ziq+1Bwj/vp4XaeXepVoYGQROxMJ3mST/ruK+qQGdi1p9gbSGHcmAt3uBR8uW1T+GMTD
         eBmS5kBggJMafWBOTW53HwZ0JfsH4hP9QKqpAUHiVDB7rlRI+qOZHlzs7uc3XxOgbriv
         PAPLwTmnt2U6U1YsLIGsjQrvjoBdVG7qaoAceM1FbAd20h7vWQfAv1zLeytBo1iFSZr9
         2+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zTBV1YV3MWdb88U2GtxQ8xdAPJhTSTNkra9Wzo0FSoA=;
        b=REunUJ+T1WB5XHtEkewzvSbAfpXoeWAhexauEOY44EjmTOulplZZALzPzrqdXHazvx
         veDyVhLts6jCqoxFwAlGPAawEMzFf98I5weCgbHlRYVqDr1BhOmzHDIqBcmi/LCv9QwF
         DnlbT4H3Vk3bq7fQ5YUp7SrpRjirSxKfVhg2GuAvOPFEdYpTyDq8waCKp5dzbXKe1cNc
         /wFQ8TVhdofctP8EeXbtWE6F9Bb/Z5Y1R00WY5v3pnVzFFF5a1B87QaRAZHKT7upCsDF
         E+4IpwYva/9LKDm7NFCPQhD04ATtmhpwb2GMwiPYpnL4yZFBRJ7FqtgnCRqms6ng0fWv
         ZW6A==
X-Gm-Message-State: ANhLgQ3DRRpOQ6wQ4ejmaksroFj+YdQdPWsSntdoI5rtNqQzhiw+ZqiZ
        COVymc7yP5YKu0eupY4IqLS+BbaF3SnNHOCB8zwf9w==
X-Google-Smtp-Source: ADFU+vuRW1nomFcPvzWBLuYgbUK8v9DGDA24FGpWP+NG9mIP2DDhnFVzli1dWdcisFuOO2nJlSp7fr/j3+8QHforTC8=
X-Received: by 2002:a05:6602:2c89:: with SMTP id i9mr3294108iow.131.1583938581643;
 Wed, 11 Mar 2020 07:56:21 -0700 (PDT)
MIME-Version: 1.0
References: <1583924072-20648-1-git-send-email-loic.pallardy@st.com>
In-Reply-To: <1583924072-20648-1-git-send-email-loic.pallardy@st.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 11 Mar 2020 08:56:08 -0600
Message-ID: <CANLsYkyOPM4euJh-vr7-2z-CxMw=vFrWSXKGswt4ZMutcyEEaw@mail.gmail.com>
Subject: Re: [RFC 0/2] Allow client to recover crashed processor
To:     Loic Pallardy <loic.pallardy@st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        Suman Anna <s-anna@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020 at 04:54, Loic Pallardy <loic.pallardy@st.com> wrote:
>
> The following 2 patches propose some changes to allow user space
> client to shutdown and restart a crashed co-processor.
> This is required when auto recovery is disabled at framework level or
> when auto recovery procedure failed.
>
> Sent as RFC as may be part of Mathieu's proposal for early boot/late
> attach support

Perfect timing - thanks for sending those out.

Mathieu

>
> Loic Pallardy (2):
>   remoteproc: sysfs: authorize rproc shutdown when rproc is crashed
>   remoteproc: core: keep rproc in crash state in case of recovery
>     failure
>
>  drivers/remoteproc/remoteproc_core.c  | 8 +++++++-
>  drivers/remoteproc/remoteproc_sysfs.c | 2 +-
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> --
> 2.7.4
>

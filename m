Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13ACC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 21:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5FB2082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 21:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bphTE9jn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbgBDVSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 16:18:09 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:38812 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727619AbgBDVSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 16:18:08 -0500
Received: by mail-vs1-f68.google.com with SMTP id r18so12458423vso.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 13:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+YV7XvdlsIH5IDESBp45bVi5suaLif02bOusLL/UcAg=;
        b=bphTE9jnt5pwshYrT5bVIe6w+pYy2uTHTOXG6zCT/v03+zOC2lc8VCPBqK8yQrSx/5
         mdNdS0Hg9A8cnU6gYq/C50cIyByUlThuUSRMW9Hn/rWs/3L7rWzw4UvULJ4VQWtnGpRg
         xa9In03NU2Po3Hd6I1ppVTeQh0gOd3walkFVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+YV7XvdlsIH5IDESBp45bVi5suaLif02bOusLL/UcAg=;
        b=s8x2VJd2hOeqyK6wpx7FG7ECXhuelsLlRE33yGuAKSQyJ6dBiuVUL34lEkV9dh3J87
         /tVfT3qk3prsCifTeVb5ohzHG/tk1id1gN7Y+vNMennTh5BR790MSc110Wb84rq/ceJC
         81yXxrLm1VOqCT7cRtBa0n7OjG486qPKFjv2Dei1FHAWu5HAnRhbGfsh5B99LAC/n6Q3
         c+u0q4SSZAxFwIncCpgXlEoMahia+hBu3Sgy16b55bjEyL2vRZfsokjPhHFPxCB1Wexu
         7xbQoH5xlD1F8HAbtM+nIIkb2FAcafvurPkfbyRGmAyx5eFBLf/ue/M8qcTV/ftLjJz0
         6BGA==
X-Gm-Message-State: APjAAAWP0xZrsf/VRwumWmyJw1wrglzMJJ7glWfhRxPGKDMCtLg23Bxd
        TEV3fXlBOswxa0njhd61uZ5YYtzgO88=
X-Google-Smtp-Source: APXvYqy0WBZtUwdW2VvEB6vnKPmrHFPD9pviSgMVfq2+W13+SHT3YDotwPy21E69PSDF5WT5xW47pA==
X-Received: by 2002:a67:6601:: with SMTP id a1mr19755620vsc.0.1580851086770;
        Tue, 04 Feb 2020 13:18:06 -0800 (PST)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com. [209.85.217.52])
        by smtp.gmail.com with ESMTPSA id v21sm5630386vkd.54.2020.02.04.13.18.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 13:18:06 -0800 (PST)
Received: by mail-vs1-f52.google.com with SMTP id b79so12420415vsd.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 13:18:05 -0800 (PST)
X-Received: by 2002:a67:e342:: with SMTP id s2mr19486104vsm.198.1580851085540;
 Tue, 04 Feb 2020 13:18:05 -0800 (PST)
MIME-Version: 1.0
References: <20200204193152.124980-1-swboyd@chromium.org> <20200204193152.124980-2-swboyd@chromium.org>
In-Reply-To: <20200204193152.124980-2-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 4 Feb 2020 13:17:54 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Wf99AkNqtJ_W92sDNGS3dKQN3FK3960-=Oq8sJf7kKVA@mail.gmail.com>
Message-ID: <CAD=FV=Wf99AkNqtJ_W92sDNGS3dKQN3FK3960-=Oq8sJf7kKVA@mail.gmail.com>
Subject: Re: [PATCH 1/3] i2c: qcom-geni: Let firmware specify irq trigger flags
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-i2c@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Feb 4, 2020 at 11:31 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> We don't need to force IRQF_TRIGGER_HIGH here as the DT or ACPI tables
> should take care of this for us. Just use 0 instead so that we use the
> flags from the firmware. Also, remove specify dev_name() for the irq
> name so that we can get better information in /proc/interrupts about
> which device is generating interrupts.
>
> Cc: Girish Mahadevan <girishm@codeaurora.org>
> Cc: Dilip Kota <dkota@codeaurora.org>
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/i2c/busses/i2c-qcom-geni.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BEAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2217207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="koJMedVI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730970AbgFRUKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgFRUKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:10:01 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37125C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 13:10:01 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id k13so4280376vsm.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 13:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FSwUDJQJDD2aFeE7AG8B7gwG/F8HVyWOYHj+N8WDvHg=;
        b=koJMedVIB9/8FYoo3ICOMGrEkn7oiQpS3inzL5oZp6a4TYfZL5WhLQ8L8SZyqrFEv2
         C3h4FeUJMoRd4JAHQg4d1XaqgoFcDrm+Tg4iDinifrhpHEjDK6Rvwk5cFrynYYQGvLAH
         j6uk3LzHMuSgjFsiG7c2h95oQfFiTEd2dihgQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FSwUDJQJDD2aFeE7AG8B7gwG/F8HVyWOYHj+N8WDvHg=;
        b=so4kpj63fTdh4cvV5shWbYDrqDd+66RunIAl3VE8KfabDZZlAuVJhV74s2kgBfX9nz
         xTXqJ73u1EM50otHD94h7yy55OOozsy7Jarb2XJfJrCCTs1bIm2sM+3GaSbVtPopIAwu
         yaU7oRjYpm+YfaOa1WRXDM+tWHllZBl8Q3rc6e3B7UQix9wVXcJYApTw4jsBE69uo1aY
         FSq1r7myFA9wcFmiGLnot2diwfm9R3gdlNUwI7hb+PzZJByWQEjdCD+xAyTJHLehxZpG
         C9zRlqKFF9klPqFQkWk+eVcMb4TfghOlERzE2J6BkiebihQjM1bR/m4nB/sEXUNm2kP9
         LBmA==
X-Gm-Message-State: AOAM532oD++yMwEpXjZRCFcVC++dSBvsJXV7rlsm7F83paw3AzpqyRtl
        rYX+RQ3VyrA33WaJalckC2Z0Kgm0HrU=
X-Google-Smtp-Source: ABdhPJydSvHzb1+a2Bg5W2ni638FEf4HRrCO03I9C/BnZ3BQwX55WQgRvJL+dtS+VgJJSm9IAvO/nQ==
X-Received: by 2002:a67:e90e:: with SMTP id c14mr5274276vso.185.1592511000265;
        Thu, 18 Jun 2020 13:10:00 -0700 (PDT)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id x6sm433539vsx.25.2020.06.18.13.09.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 13:09:59 -0700 (PDT)
Received: by mail-vs1-f49.google.com with SMTP id o2so4318126vsr.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 13:09:59 -0700 (PDT)
X-Received: by 2002:a67:8881:: with SMTP id k123mr5031158vsd.198.1592510998962;
 Thu, 18 Jun 2020 13:09:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200618150626.237027-1-dianders@chromium.org>
 <20200618080459.v4.5.Ib1e6855405fc9c99916ab7c7dee84d73a8bf3d68@changeid> <159250352382.62212.8085892973272354046@swboyd.mtv.corp.google.com>
In-Reply-To: <159250352382.62212.8085892973272354046@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 18 Jun 2020 13:09:47 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xh3+cROZC8dCn99MLkngsyBcxq+Gv1CERayZXExwdygA@mail.gmail.com>
Message-ID: <CAD=FV=Xh3+cROZC8dCn99MLkngsyBcxq+Gv1CERayZXExwdygA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] spi: spi-geni-qcom: Don't keep a local state variable
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jun 18, 2020 at 11:05 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Douglas Anderson (2020-06-18 08:06:26)
> > @@ -126,20 +120,23 @@ static void handle_fifo_timeout(struct spi_master *spi,
> >         struct geni_se *se = &mas->se;
> >
> >         spin_lock_irq(&mas->lock);
> > -       reinit_completion(&mas->xfer_done);
> > -       mas->cur_mcmd = CMD_CANCEL;
> > -       geni_se_cancel_m_cmd(se);
> > +       reinit_completion(&mas->cancel_done);
> >         writel(0, se->base + SE_GENI_TX_WATERMARK_REG);
> > +       mas->cur_xfer = NULL;
>
> BTW, is this necessary? It's subtlely placed here without a comment why.

I believe so.  Now that we don't have the "cur_mcmd" we rely on
cur_xfer being NULL to tell the difference between a "done" for chip
select vs. a "done" for transfer.

* When we start a transfer we set "cur_xfer" to a non-NULL pointer.
When the transfer finishes we set it to NULL again.

* When we start a chip select transfer we _don't_ explicitly set it to
NULL because it should already be NULL.

* When we are aborting a transfer we need to NULL so we can handle the
chip select that will come next.

I suppose it's possible that we could get by without without NULLing
it because I believe when the "abort" IRQ finally fires then it will
include a "DONE" and that would presumably NULL it out.  ...but I
guess if both the cancel and abort timed out and no IRQ ever fired
then nothing would have NULLed it and the next chip select would be
confused.

Prior to getting rid of "cur_mcmd" this all wasn't needed because
"cur_xfer" was only ever looked at if "cur_mcmd" was set to
"CMD_XFER".


One part of my change that is technically not related to the removal
of "cur_mcmd" is the part where I do "mas->tx_rem_bytes =
mas->rx_rem_bytes = 0;".  I can split that as a separate change if you
want but it seemed fine to just clean up this extra bit of state here.

-Doug

Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1549C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A931206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:12:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aUVNgh6t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390445AbgF2VMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730149AbgF2S5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:44 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F3DC030F1B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:29:43 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id x62so13302281qtd.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 09:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eAEmaN/NdVFefXDM6LfGtyV/V/D8hHRz0d76RasnyHc=;
        b=aUVNgh6tt8rsssN1Zw55aKmbKP1FBMvcU6Li23i8y2DGTLDckWw/CTpboiYvWDGDFE
         U1DxleAoFoNnmxvS84E+CNSUXnw9SzDbuEdu9Uk3O23rG09zQF/yAlaCZhvHE5XyPq+k
         z7z9o8GsnZKiEPRibPmxlmSJv9GgZciUoiK08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eAEmaN/NdVFefXDM6LfGtyV/V/D8hHRz0d76RasnyHc=;
        b=eSV+i2bG/Pz0nqBdvSPWRYo71Y9P1ampP/QP8G16XJFD2a9+dDRVKEmv5/9zblF9ke
         DfNcJkRivtYy4Ncnt58EnWeik+VNNBUlXx3Md49sxOp+IGWbJtq9Vsh289dvsu8S/pBE
         rESeJsh666Y7NKQlw66ZI5EGwQN1rbiU92I/Ap+kbK3FhbNtjrEmAVhKyttf/jLt/lOp
         xZwmMM4+gGVBiezEgRYMN0sYZMwH3Ri1Ka5UX9vtop2W8HdJxgMap7ig/kW3kxsMrNh6
         VLzv6blEA0sStgF6D/DcIVsDghmut1gp1vdxBxJ40ORSL3S9RuyOPUnPgJweOtX5JaEh
         v+7A==
X-Gm-Message-State: AOAM531DFj9uS+UCf/uY+byqdlnGq92CfJxWhr0nBoOJakFKSgunKzv2
        UtbOBMhrKYsTOLfgx71SPrxvIvfQRVMrYUxAMoldGQ==
X-Google-Smtp-Source: ABdhPJyJcSRHPydBEPn+HrFFAz4W0t9grJUr11/a8seW7COTXxyCGGTrC9xcPD9k+gx/hDH5i0au+pkPrSsko76LuN0=
X-Received: by 2002:ac8:1991:: with SMTP id u17mr15942854qtj.93.1593448182155;
 Mon, 29 Jun 2020 09:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200629161333.2110327-1-pmalani@chromium.org>
 <20200629161333.2110327-2-pmalani@chromium.org> <CABXOdTe_t94GL6soaZbXp5TVxnG72zHRqh_qTa+zpmzTCw50ng@mail.gmail.com>
In-Reply-To: <CABXOdTe_t94GL6soaZbXp5TVxnG72zHRqh_qTa+zpmzTCw50ng@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 29 Jun 2020 09:29:30 -0700
Message-ID: <CACeCKafrDOyziU5-FmOWQ8cPojxTgwo49osZFgmeO4O33QAGbg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_typec: Add PM support
To:     Guenter Roeck <groeck@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Thanks for reviewing the patch.

On Mon, Jun 29, 2020 at 9:25 AM Guenter Roeck <groeck@google.com> wrote:
>
> On Mon, Jun 29, 2020 at 9:13 AM Prashant Malani <pmalani@chromium.org> wrote:
> >
> > Define basic suspend resume functions for cros-ec-typec. On suspend, we
> > simply ensure that any pending port update work is completed, and on
> > resume, we re-poll the port state to account for any
> > changes/disconnections that might have occurred during suspend.
> >
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Remove #ifdef-ery, add __maybe_unused tag to functions.
> >
> >  drivers/platform/chrome/cros_ec_typec.c | 26 +++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> > index 630170fb2cbe..b2e7e928e788 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -725,11 +725,37 @@ static int cros_typec_probe(struct platform_device *pdev)
> >         return ret;
> >  }
> >
> > +static int __maybe_unused cros_typec_suspend(struct device *dev)
> > +{
> > +       struct cros_typec_data *typec = dev_get_drvdata(dev);
> > +
> > +       cancel_work_sync(&typec->port_work);
> > +
> > +       return 0;
> > +}
> > +
> > +static int __maybe_unused cros_typec_resume(struct device *dev)
> > +{
> > +       struct cros_typec_data *typec = dev_get_drvdata(dev);
> > +
> > +       /* Refresh port state. */
> > +       schedule_work(&typec->port_work);
> > +
> > +       return 0;
> > +}
> > +
> > +static const struct dev_pm_ops cros_typec_pm_ops = {
> > +       SET_SYSTEM_SLEEP_PM_OPS(cros_typec_suspend, cros_typec_resume)
> > +};
> > +
> > +#define DEV_PM_OPS     (&cros_typec_pm_ops)
>
> I don't think this define adds any value.

Right. Sorry, got sloppy here. Will push another patchset. Thanks for
catching this.

Best regards,

>
> > +
> >  static struct platform_driver cros_typec_driver = {
> >         .driver = {
> >                 .name = DRV_NAME,
> >                 .acpi_match_table = ACPI_PTR(cros_typec_acpi_id),
> >                 .of_match_table = of_match_ptr(cros_typec_of_match),
> > +               .pm = DEV_PM_OPS,
> >         },
> >         .probe = cros_typec_probe,
> >  };
> > --
> > 2.27.0.212.ge8ba1cc988-goog
> >

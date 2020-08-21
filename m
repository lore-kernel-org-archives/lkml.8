Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E23C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F22F206DA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 16:50:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="X2CKbIJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgHUQuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 12:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbgHUQuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 12:50:04 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA2FC061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 09:50:02 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id t10so3063505ejs.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 09:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XYCTWQk0laqVOOppyvOGRK+sDe7eGSnOJ2JCeNqCPQ0=;
        b=X2CKbIJpkTLzgsWlRP2JtwgYiIBv9S4Mpnx7WMBh0JyqpACFEgKE+3vA7rlr69KGUn
         5Hl6n9+E2bNe+8mWI+oeHmzBZlI3Yj4dVgrd7RjSj3HYesfFzOtaJdOzOFCFS0oP5217
         xzwK7efDRNOIMCEcMDNmW2OIM5HpArpLEOmpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XYCTWQk0laqVOOppyvOGRK+sDe7eGSnOJ2JCeNqCPQ0=;
        b=jJxKS6DiHz/gOkgssTJ/sZRBL4+9inkMeHmefz7Tbi09GvULK19Ym56P5s/mXMsEEq
         F+U+xqkiwqIVsaRIOR85q6hYlhwVrO/4orkruo37SzMB9km8DDF0oTyxLn8ZGIXdmA99
         ZHSurgXtRSOk9h4K6G/S5CthL0J5rlXwny/D0YJufeO1TkZuBUp2hlUGW5DK7hntvEf8
         Bdvb90yrWDHCNYkXivtFqDOUGM2oJCiXXKV6LWRl7F2epleA44OlpUOYg/8pjen89qHG
         G2cgSCY9EAWqzcrO1lX3tGB40d1pe8kCCkgpyI9Mvlz8EM8SuwJ9bsqkoVLGbcBrvdkz
         Ughg==
X-Gm-Message-State: AOAM533Z2/BwnC5/RAw0+S0oz2rf4oFNWvIRnSd+Jtg2DoecFIxGB03M
        athe/F0eS3DlPI2Ux1LPg70cEH2cao0hlmGqt0gxuQ==
X-Google-Smtp-Source: ABdhPJybEmrl+ZD97uBTzzArG12ayrllyV6oSam+TVCBGOVztXu5+GGIHnjCo899GSGgve7+yDqXTbrRiWs7EsF2UsE=
X-Received: by 2002:a17:906:d054:: with SMTP id bo20mr3931788ejb.9.1598028601414;
 Fri, 21 Aug 2020 09:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200821010333.20436-1-mmayer@broadcom.com> <20200821054023.GA3906@kozik-lap>
In-Reply-To: <20200821054023.GA3906@kozik-lap>
From:   Markus Mayer <mmayer@broadcom.com>
Date:   Fri, 21 Aug 2020 09:49:50 -0700
Message-ID: <CAGt4E5sxpOpMNERKfamWL02sRSc7SuA19K8gECOL_kHD6FKuzA@mail.gmail.com>
Subject: Re: [PATCH] memory: brcmstb_dpfe: fix array index out of bounds
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 at 22:40, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, Aug 20, 2020 at 06:03:33PM -0700, Markus Mayer wrote:
> > We would overrun the error_text array if we hit a TIMEOUT condition,
> > because we were using the error code "ETIMEDOUT" (which is 110) as an
> > array index.
> >
> > We fix the problem by correcting the array index and by providing a
> > function to retrieve error messages rather than accessing the array
> > directly. The function includes a bounds check that prevents the array
> > from being overrun.
> >
> > Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> > ---
> >
> > This patch was prepared in response to https://lkml.org/lkml/2020/8/18/505.
> >
> >  drivers/memory/brcmstb_dpfe.c | 23 ++++++++++++++++-------
> >  1 file changed, 16 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
> > index 81abc4a98a27..a986a849f58e 100644
> > --- a/drivers/memory/brcmstb_dpfe.c
> > +++ b/drivers/memory/brcmstb_dpfe.c
> > @@ -190,11 +190,6 @@ struct brcmstb_dpfe_priv {
> >       struct mutex lock;
> >  };
> >
> > -static const char * const error_text[] = {
> > -     "Success", "Header code incorrect", "Unknown command or argument",
> > -     "Incorrect checksum", "Malformed command", "Timed out",
> > -};
> > -
> >  /*
> >   * Forward declaration of our sysfs attribute functions, so we can declare the
> >   * attribute data structures early.
> > @@ -307,6 +302,20 @@ static const struct dpfe_api dpfe_api_v3 = {
> >       },
> >  };
> >
> > +static const char * const get_error_text(unsigned int i)
>
> The pointer itself is returned by value and you cannot return a const
> value. I mean, you can but it does not have an effect. Only pointed
> memory should be const (const const char*).

v2 is on the way.

Regards,
-Markus

> > +{
> > +     static const char * const error_text[] = {
> > +             "Success", "Header code incorrect",
> > +             "Unknown command or argument", "Incorrect checksum",
> > +             "Malformed command", "Timed out", "Unknown error",
> > +     };
> > +
> > +     if (unlikely(i >= ARRAY_SIZE(error_text)))
> > +             i = ARRAY_SIZE(error_text) - 1;
> > +
> > +     return error_text[i];
> > +}
> > +
> >  static bool is_dcpu_enabled(struct brcmstb_dpfe_priv *priv)
> >  {
> >       u32 val;
> > @@ -446,7 +455,7 @@ static int __send_command(struct brcmstb_dpfe_priv *priv, unsigned int cmd,
> >       }
> >       if (resp != 0) {
> >               mutex_unlock(&priv->lock);
> > -             return -ETIMEDOUT;
> > +             return -ffs(DCPU_RET_ERR_TIMEDOUT);
> >       }
> >
> >       /* Compute checksum over the message */
> > @@ -695,7 +704,7 @@ static ssize_t generic_show(unsigned int command, u32 response[],
> >
> >       ret = __send_command(priv, command, response);
> >       if (ret < 0)
> > -             return sprintf(buf, "ERROR: %s\n", error_text[-ret]);
> > +             return sprintf(buf, "ERROR: %s\n", get_error_text(-ret));
> >
> >       return 0;
> >  }
> > --
> > 2.17.1
> >

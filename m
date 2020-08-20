Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A5EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F76620724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FxtAaQHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730497AbgHTRYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbgHTRX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:23:59 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5D7C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:23:58 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id kq25so3454708ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FSEoi89dHfhzP32ddR5j968nwd71ucC9yk+h6uBOV28=;
        b=FxtAaQHphv14xbyM7ngVPajpiRbWySCAkBgXGB3jsIyE2OrnpIDSuLLNPHbwWREaNi
         viUeJr9a0BpFBvV8kooP7S7PxLqua3ElF/xNUAqGdzEzycHzxJtqeUS0EHuN9jEvUUkL
         7WDFeQ72BQkrRIhIwqay7/HZQ81jZDjZQn+sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FSEoi89dHfhzP32ddR5j968nwd71ucC9yk+h6uBOV28=;
        b=NFEBwh5ApFA8DOc7n0yfMDI7tsONOZ7uEsoea8RymIpS/Oq64yEswGljPlAhNkX2WD
         BCLh1t2c7pew2Q8VFFe3Xw8RAGcpwewAFbREOXbcpuGX7o5qT2nTAPuKFrdyCNrouUIe
         DuD0I00J3r8LR1TXmlkzwV3K5YXwsJRHKUavdKsWLuQ2wVgZFuSoUXGyLfE0PGO2wNrl
         Ky+OEz2bTL7iqKaF49XocFAUspApH6FKxDZVCY04+o5fLnk5uGlESH9jVm/3UJogbH+8
         KMhLIAtXfvAtgidkc1/WTxp3DeCZPN24Mzwh4uyvDYaOVDd8NgT8RAdIbnV8au9htkwP
         hxKg==
X-Gm-Message-State: AOAM531TZuHsGD1gpXvOpzVkuZgLmmWPy6Cbt5+E8kGXkbwSXInPIB2M
        ZgLgOFhLcKyLawYacr5EKGBimsUMO5R2xQWYb18qCQ==
X-Google-Smtp-Source: ABdhPJyao9He4BbnUXPa54gIMkC0Vw0O31b5BxC+Mk8grEr1dPsR5gmYR2tWBo3RzyIyQzdoUNQ3Zp+iwi3aLaIgu1A=
X-Received: by 2002:a17:906:d187:: with SMTP id c7mr4444516ejz.196.1597944236714;
 Thu, 20 Aug 2020 10:23:56 -0700 (PDT)
MIME-Version: 1.0
References: <38d00022-730c-948a-917c-d86382df8cb9@canonical.com> <4acc34c4-9c17-41f7-2e39-7eda16792572@gmail.com>
In-Reply-To: <4acc34c4-9c17-41f7-2e39-7eda16792572@gmail.com>
From:   Markus Mayer <mmayer@broadcom.com>
Date:   Thu, 20 Aug 2020 10:23:45 -0700
Message-ID: <CAGt4E5s_=Tai=fTB37VibaCF=2F69vO3ZbVAsBCZXLK2CNiVAQ@mail.gmail.com>
Subject: Re: out of bounds access on array error_text[] because of -ETIMEDOUT
 return from __send_command()
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Colin Ian King <colin.king@canonical.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Aug 2020 at 11:34, Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 8/18/20 5:21 AM, Colin Ian King wrote:
> > Hi,
> >
> > static analysis with coverity has found a buffer overflow issue with the
> > brcmstb driver, I believe it may have been introduced with the following
> > commit:
> >
> > commit a7c25759d8d84b64c437a78f05df7314b02934e5
> > Author: Markus Mayer <mmayer@broadcom.com>
> > Date:   Tue Apr 2 16:01:00 2019 -0700
> >
> >     memory: brcmstb: dpfe: wait for DCPU to be ready
> >
> > The static analysis is as follows for the source file
> > /drivers/memory/brcmstb_dpfe.c :
> >
> > 684 static ssize_t generic_show(unsigned int command, u32 response[],
> > 685                            struct brcmstb_dpfe_priv *priv, char *buf)
> > 686 {
> > 687        int ret;
> > 688
> >    1. Condition !priv, taking false branch.
> >
> > 689        if (!priv)
> > 690                return sprintf(buf, "ERROR: driver private data not
> > set\n");
> > 691
> >    2. return_constant: Function call __send_command(priv, command,
> > response) may return -110.
> >    3. assignment: Assigning: ret = __send_command(priv, command,
> > response). The value of ret is now -110.
> >
> > 692        ret = __send_command(priv, command, response);
> >    4. Condition ret < 0, taking true branch.
> >
> > 693        if (ret < 0)
> >
> > Out-of-bounds read (OVERRUN)
> >    5. overrun-local: Overrunning array error_text of 6 8-byte elements
> > at element index 110 (byte offset 887) using index -ret (which evaluates
> > to 110).
> > 694                return sprintf(buf, "ERROR: %s\n", error_text[-ret]);
> > 695
> > 696        return 0;
> > 697 }
> >
> >
> > Function __send_command() can return -ETIMEDOUT and this causes an
> > out-of-bounds access on error_text[].
>
> Markus, what do you think of this:
>
> diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
> index 60e8633b1175..b41c6251ddc3 100644
> --- a/drivers/memory/brcmstb_dpfe.c
> +++ b/drivers/memory/brcmstb_dpfe.c
> @@ -445,7 +445,7 @@ static int __send_command(struct brcmstb_dpfe_priv
> *priv, unsigned int cmd,
>         }
>         if (resp != 0) {
>                 mutex_unlock(&priv->lock);
> -               return -ETIMEDOUT;
> +               return -ffs(DCPU_RET_ERR_TIMEDOUT);
>         }
>
>         /* Compute checksum over the message */
>
> That way we only return DCPU-style error code from __send_command and we
> de-reference error_text accordingly? Or we could just introduce a proper
> lookup with a function instead of a direct array de-reference.

Let me do some experiments. What you are proposing should work and is
in line with the current code. A lookup function might be cleaner,
though.

Thanks,
-Markus

> --
> Florian

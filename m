Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAA0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D758206BE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 07:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpaVPjaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgGCHz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 03:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbgGCHz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 03:55:29 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C90CC08C5C1;
        Fri,  3 Jul 2020 00:55:29 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id ga4so33164769ejb.11;
        Fri, 03 Jul 2020 00:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fTwxTX3lFaXQfpGF8WrHjZ4nudeN/Udeni+zhLUnCvc=;
        b=SpaVPjaMnFzQwxkrqren2c5gluTMM06oLE3DokQdyhlOp29LwESSWmcHl4qYLGbfBO
         +O9YBgdzUkvyCsVtcqVBJfyR18toE3sxz2TmgS3dajJ0peuT5Swl+z27NlYlOPgewf7t
         UH39mxwb8R3cSiWarOqX34Dpp6LC0UI/7vcZieY7z3Cx72mGvMtjjTfkcw8IKGqY5W0q
         BhO4lVfAiV+YVqwOdtVs4CUwAfzX2qKs/DKoglIgOSBUG48A4pBqFxe3uQZbCG+lpRlL
         g2wvdps1w2yIUKbhx4WFRHbMd1cI8dJyAcih6rz/Bl0yM68oCyl73VdMW8m/dVVr4d9W
         B7vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fTwxTX3lFaXQfpGF8WrHjZ4nudeN/Udeni+zhLUnCvc=;
        b=LZb77FGxz7FORwMPIDbKnHtlr965Nscr0tVDxxboLpQaH6rBxyvDi4wsVe/oDz8nNs
         m2Ce2MA0Od1HMs2KjX3jcAUpJo/82vAg43u6FcQXzosmCuP9b+b7D1gLRSghg+VrxbqW
         +yruXEdQuA3T+ix9KajqlqCzDhhElnvLHY4Bzsq09xpd6zV402Q0eDuDW4D1c+Lf30zg
         Zst9K4uLCVk1aXUHr6zTdn5XxBYSIgqv532SWaO+h/z6zAx5rpQT1lHHMZVmpETq3Tkc
         Nan2GaD3qle1tIpCMG2662b2sXRPxHUMcIoSzg7QBl7L/vuOBeuIHSYsJ3vTPXRAXf6Z
         ftag==
X-Gm-Message-State: AOAM531c589pQD/4brtGgZkjzqunxqAIukd30g5Rrm/sKrYOtauYpPYH
        pVdwQeHMk5/sM+0vI8MhPC4cstsrBr17g6gmdRg=
X-Google-Smtp-Source: ABdhPJz6fwPZkrY9L42bGm444d1WyCatcvdmy6Wi9LsWodQ4QxiW0oZszOLBWn9xc7ILi9PYDvUjDDttttJeURkP40c=
X-Received: by 2002:a17:906:1414:: with SMTP id p20mr30410902ejc.247.1593762927651;
 Fri, 03 Jul 2020 00:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <1593701576-28580-1-git-send-email-amittomer25@gmail.com>
 <1593701576-28580-2-git-send-email-amittomer25@gmail.com> <20200702210014.GA1685248@bogus>
 <CABHD4K8=8+fFu=ZjQHEgR44x+QsvLZ+LW7w=XKH7O4oXu+QY4A@mail.gmail.com>
In-Reply-To: <CABHD4K8=8+fFu=ZjQHEgR44x+QsvLZ+LW7w=XKH7O4oXu+QY4A@mail.gmail.com>
From:   Amit Tomer <amittomer25@gmail.com>
Date:   Fri, 3 Jul 2020 13:24:50 +0530
Message-ID: <CABHD4K-_jmC512_ckmw66FppJHitkU8j-M9TQ316+M9zou3Fmg@mail.gmail.com>
Subject: Re: [PATCH v5 01/10] dt-bindings: dmaengine: convert Actions Semi Owl
 SoCs bindings to yaml
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Andre Przywara <andre.przywara@arm.com>,
        cristian.ciocaltea@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        dan.j.williams@intel.com, linux-actions@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 12:48 PM Amit Tomer <amittomer25@gmail.com> wrote:
>
> Hi Rob,
>
>
> > If you already ran 'make dt_binding_check' and didn't see the above
> > error(s), then make sure dt-schema is up to date:
> >
> > pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade
> >
> > Please check and re-submit.
>
> I wasn't able to reproduce it, even after updating the dt-schema.
> Kindly have a look at logs:
>
> https://pastebin.ubuntu.com/p/xTBNNyBdFv/

Looks like, dtschema even after upgrade pointing to older commit "6a941d46b9f5".
Wondering why it has not been pointing to latest commit "6a941d46b9f5"

After upgrading the pip version for python3, and upgrading the dt-schema again
https://pastebin.ubuntu.com/p/Rd9knQgvKH/

Issue is still reproduced.

Thanks
-Amit

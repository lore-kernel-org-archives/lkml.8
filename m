Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53244C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C1D920724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyMlCpMD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732547AbgFWLgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 07:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732519AbgFWLgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:36:03 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC2FC061755;
        Tue, 23 Jun 2020 04:36:03 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id v19so12605407qtq.10;
        Tue, 23 Jun 2020 04:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4pFgJBI5OCUGefSIcYA75cTva8JFYmUiXoqYx+WyG9c=;
        b=HyMlCpMDocjfKKBdCi+o40gBFKbEJLUZrOAhvFFx4oLGKFgYQ+huI9As79YT6CAjOa
         z2C/Xdl9JZ0KjIxf0z+fW6ABlByiQ5bya+k/eGUH/aF4IHdwR1bTNNip68uuIJe7WlpH
         YMSHIlyZqfTwCdwD010jH6B7e3ALpCGY4ELBk3/yM9GQQH47+gIQ0ImwuYYE2D+5Njhv
         0ym+2XuFqxH3sJwOokUV7b1thTP7Nbqy0B6kLt7X61WBzB3zDn8HOkMNTidrlrHhGmhe
         bjqpiyKJ8IZ+hJ6oXMGZZc8CVPLZSl1qwaaUZry6fOksDMILHtAjkq1qVnFnpIWu5FzY
         mlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4pFgJBI5OCUGefSIcYA75cTva8JFYmUiXoqYx+WyG9c=;
        b=VM/NwN4AjO/jRBqmMrnh+5Akp5DW/K0KK08PDJIe5B9MhPPkHZ7YKqxt/ebFqXzyoj
         rCa1hWoGkfyPQdeRtkfULdMndjIZ3f3fxM9RbzbT6eQbEiqIrg71qNY0F7IYs6GQtssi
         KTQ3gUROZI4VwSwsD74VXCJtVjTXMUyCf443lO5WMTXQ9mEThPk+dQlf97seqWNwoRZ7
         zMVJRa2DtIPUCb3/jwRMoSI4ANyuCh2I8wgEQ6H876RD2uoRB019YEysqaCmQt70VRKu
         dovMGA8NL89+fgF3qqwUBvN1aQpmpk6xSY3yqrVHvm5/dNXnd4euAnBcov/x0GwPOBrx
         p1XQ==
X-Gm-Message-State: AOAM532xW/anfwfuvWHxH6Ah1qx59UV3QMeZfpYT3/fg18YipiVNIP1U
        xC9TRL9P9a4li/EPFUkdsxuEnk/9SAnN8NYOOww=
X-Google-Smtp-Source: ABdhPJxO61T03lcfmOJXo9ryxEyKF6k7r6xNQ5tVWce+sBxYQ2LVJuylLY2ZNsYXy4zLvna194XXAG3+GxjVNzCv12s=
X-Received: by 2002:ac8:41c6:: with SMTP id o6mr15036092qtm.292.1592912162502;
 Tue, 23 Jun 2020 04:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <39ac8f24-3148-2a3d-3f8d-91567b3c4c9e@web.de> <CAA+D8APR2NGAn9jRDSZzr1fgj5u0hAvH19VxZS+tj2A7j3PCuw@mail.gmail.com>
 <24be48d2-63de-b900-cec7-d21e83a89ca2@web.de>
In-Reply-To: <24be48d2-63de-b900-cec7-d21e83a89ca2@web.de>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 23 Jun 2020 19:35:51 +0800
Message-ID: <CAA+D8AMSVCbJtcDoCbsMeV6ygrSdARpn3_PWE83mitcnkA1Tog@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: fsl_mqs: Don't check clock is NULL before
 calling clk API
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        linuxppc-dev@lists.ozlabs.org,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Xiubo Li <Xiubo.Lee@gmail.com>, Timur Tabi <timur@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 4:55 PM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> >     clk_prepare_enable and clk_disable_unprepare check the input
> >     clock parameter in the beginning of the function,
>
> These functions call further functions which perform null pointer checks.
>
>
> >                                                       if the parameter
> >     is NULL, clk_prepare_enable and clk_disable_unprepare will
> >     return immediately.
>
> The interpretation of these function implementations seems to be reasonable.
> Would you like to achieve any improvements for the corresponding software documentation?

Which document do you mean?

>
>
> >     So Don't need to check input clock parameters before calling clk API.
>
> What do you find imperative in this wording?
>
> Another wording alternative:
>    Thus omit extra null pointer checks before four function calls.
>
> Regards,
> Markus

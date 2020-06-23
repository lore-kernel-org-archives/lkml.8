Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38539C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03624206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tqu8srst"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732930AbgFWPAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732825AbgFWPAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 11:00:25 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18B1C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 08:00:24 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id g7so16849901oti.13
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 08:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J3Py/e0EAEs9RUrr8T4mWT1R7lpK0/V1LxV4aW8OhiI=;
        b=Tqu8srstBJnJvULE+NV55KPYkz0W350W0h0k641IrfFkHC/pmEUOr4/LlDLX4hlXkY
         M03xtFy0VwTKSYodk5ZQbSg7dhhvsAZl7JFiueIuUQdd2f2sNIz817bB4Jws++MNmxVg
         h0HEVHsKT2uYYi3h0nw6rrCRiHuUUfqZwVUYuqpdFmJ8QSb2lYi+63bS71QJ2zhlwDsA
         ufY9TmRgSBpVQ4CuUxCbfziH1QA//NF4kw24bF7ZFq18liI22wYaTf6iMYLe/LP0i5Nq
         eDcf4MMA3mIFieOYlADiSaoSxObEorVOEc4lw//W9HixUFq8rsdeIQnFGw9JE8hmk2S4
         Kqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J3Py/e0EAEs9RUrr8T4mWT1R7lpK0/V1LxV4aW8OhiI=;
        b=I0baRnSEHaya7YoWarHxyeS3kEudvgk2TvImifqKCqtdsn+dTMxqJniDGEOLmE20AP
         YRfW1JQXNfqh4qA0iWL0f1Kc2ZyVia/opJYu74a8z0Vh3SqracpufmP8NiGveMBdYh/b
         Q/fBG5xk0UlHVzRoheC56RY7JpKSe+HrbcUoCyrv9CEaUkdJ3ZqsTC4o4sUSphJ3KeEJ
         lFHEV7xkuT9cQkEK+XxhGRn5yOQ6NNKw2Jo/oNdO/4PLYnUNYuSAP1xIKCx7w0Kmryiq
         xhotsXt4vkTu/RasZgEgVO5BxsVOJXKyYJEGNaUlK/3D1gsOcX04SWYWE4ytYbafmed8
         mvsA==
X-Gm-Message-State: AOAM531+02yB2QhLSj6w3ACYnkc/i1TRFh6us/guDA/Ifo5iHqtsns7X
        ZIHI+MHDziIlzad/EbHXLxjj4mE7r9gOeMEX76M=
X-Google-Smtp-Source: ABdhPJw/D2XcRcHIL1lWL677bjsyJTNqrfeCQ8lSYL3XHQAvzdF1qbSLpWcxp7h9oE5uwp5HYA/oBzsS0jGZPpF2+SQ=
X-Received: by 2002:a9d:7083:: with SMTP id l3mr19525734otj.232.1592924424246;
 Tue, 23 Jun 2020 08:00:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200613201703.16788-1-TheSven73@gmail.com> <CAOMZO5ANnvsJ2iGrQSHiLUpd8RKCEmNZSdAvVFEQpqu8zvpp5Q@mail.gmail.com>
In-Reply-To: <CAOMZO5ANnvsJ2iGrQSHiLUpd8RKCEmNZSdAvVFEQpqu8zvpp5Q@mail.gmail.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 23 Jun 2020 11:00:12 -0400
Message-ID: <CAGngYiWXQ2iLMvhbKsVmdoiqSeS7onVWmo4z+dJHhXf1pBT9Uw@mail.gmail.com>
Subject: Re: [PATCH v1] ARM: imx6plus: enable internal routing of clk_enet_ref
 where possible
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On Tue, Jun 23, 2020 at 10:19 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> You should limit this to imx6 quad plus only, so you would better
> check against "fsl,imx6qp".

Excellent suggestion, thank you ! I tried to determine if running on a plus by
using the method from imx6q_init_machine(). But yes, checking for
"fsl,imx6qp" sounds much more elegant.

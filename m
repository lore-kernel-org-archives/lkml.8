Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CF1C433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:18:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9479207F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="blU+NE79"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732717AbgG1TSh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728751AbgG1TSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:18:36 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A93C061794;
        Tue, 28 Jul 2020 12:18:36 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id v22so4858250edy.0;
        Tue, 28 Jul 2020 12:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oa15p4iXa6GJWXcRKbHat247Q7cvm1xa0u7tYmwOk/s=;
        b=blU+NE79hmQP+AWK2v6QHIjREnaP4/YLScYIEh3rWReHYQ1hpM4CB6natewhEcZJg3
         At/DtAoJ9fBGj4g3ZnXIMFH10prYf+AFTHKPO+8fGRN1w55P9BQqv5CG5MoRsyeuOUGy
         POKNlHiYWWDnRAmGiURfH6NrFotdNYkduTjxfX1eU8AGv+UrcTi8XLXCxBpX95UH/nrL
         VkdM0HjfPkXJVbmw5xo9QFfmCuDC7uGtgEvhLlgy6LaFCwHAms40eJR1/qxhoNZR63Us
         RkobSo+XmF/XkyPrpesTskiyKBR75/rYao7GhgZ+zXjoQJs1dT76PdO1tV+cozSe21+o
         52EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oa15p4iXa6GJWXcRKbHat247Q7cvm1xa0u7tYmwOk/s=;
        b=Uy4PPF4woKMyS4JMu3Q8HWUxMMcMppymWPzWFO6BqnxBP+0fmOjBK6P7V1tSYLiaSJ
         FSMI7a1eWs4SHcT78TgnltknunaOvUZHJKLWLsb3N/ZNYecj9pq/3+Y6YZc8Xm5ipCtX
         TkuOU7c5ZwCnkFlajsyRqrIvG7ty6ZQwP3ilZaKMxH+zyw2kfIfnqgucNbU85FP4ZdSX
         /IMvp3OrwQylnw3FoD3IZer9TR0MIbtrR7YiuwHx1sytaGFVPxwqRx0Lhqmt+TK947BI
         9hqI8YTgkYn+EwXc29Wx4X77wNJeGhC9hFwm9f1N7j7F1jIwNsirRv7YlDg3sb5qsCgf
         GsYQ==
X-Gm-Message-State: AOAM5317sbn/o/tDDTFAyNXOBIcr5GsnBpRQP394iRbL/Fxv1fVIAGR3
        WsG0EwYB2GkZtLxd8doVuAFQ32wrNjvL85Kq5lA=
X-Google-Smtp-Source: ABdhPJy5S7ubQoYm3tHb4jW0VlpjbyrDB7KIdVKen1wY3pcq2mMJd8xXnF7ClZtX7lLSpJPEPi2etzzsUrRn6G+1/8E=
X-Received: by 2002:a05:6402:1d0a:: with SMTP id dg10mr26396667edb.110.1595963915038;
 Tue, 28 Jul 2020 12:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200728074602.14218-1-amelie.delaunay@st.com> <20200728074602.14218-4-amelie.delaunay@st.com>
In-Reply-To: <20200728074602.14218-4-amelie.delaunay@st.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 28 Jul 2020 21:18:24 +0200
Message-ID: <CAFBinCDd_9HJA4TT2mS007xFyO4jovt+Xrpejppzzq2Ty-JDmg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] usb: dwc2: don't use ID/Vbus detection if
 usb-role-switch on STM32MP15 SoCs
To:     Amelie Delaunay <amelie.delaunay@st.com>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Fabrice Gasnier <fabrice.gasnier@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amelie,

On Tue, Jul 28, 2020 at 9:46 AM Amelie Delaunay <amelie.delaunay@st.com> wrote:
>
> If usb-role-switch is present in the device tree, it means that ID and Vbus
> signals are not connected to the OTG controller but to an external
> component (GPIOs, Type-C controller). In this configuration, usb role
> switch is used to force valid sessions on STM32MP15 SoCs.
>
> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
thank you for updating this patch - please add my:
Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>


Martin

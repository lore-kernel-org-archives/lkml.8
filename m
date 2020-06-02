Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A69DBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80638206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 12:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JetxGkcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgFBM5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 08:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgFBM47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:56:59 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC23C061A0E;
        Tue,  2 Jun 2020 05:56:59 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id a10so1195623uan.8;
        Tue, 02 Jun 2020 05:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BpsIlBQ5nejFohRETbNb9q04gA6fq5BCcsSBn6KKApI=;
        b=JetxGkcmZWwBcj73qk5GvrPQ52LZYWBhk1chHXBbYxrojwIOYCdLU6/e4biJGuow5b
         tVoDhU2dirPxe0+SQa6spJ5Di7Jjk0/Bkgco+Tpe0Z3oAFDHwh0KzP7w92q5qj/3/x3Q
         9L8vVzBOe32M8mc6kbcNKPmzg0fzMn/paYJ/jnoHguC1SPWDNX9zXsXanb+WqbRV+249
         QMj5r88MFMgwB/mim2CvQ6KmhxANKMbwldClAaVj/3SBwiVC5ZmtFzpv9tadk+xPBodH
         xg5ImqIr4I7KAgHbdnae1fbbQpdjwEwen0yl9P7/GvxCOo+2LHlSYtreF+iVF4LI/u8f
         8AVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BpsIlBQ5nejFohRETbNb9q04gA6fq5BCcsSBn6KKApI=;
        b=PKkx4xmIBXJtad+QTQRR6oeT9vTjYqg6ss9NBreIy6NKlUurbVwR5gEQ8S+6Ryz8Yb
         17CnHYAOM4rktD1zJMhMzW2jUTzX9YSxnVH20pCXaFO4BQ1D2BQ2l6deCt2q57/UH/up
         mpIHBuDDTHv3pLM8fze7oYYp7B/FtnjGhTHZUABDHlxkSO3nFwesg6/eju7lb1S5FyZp
         kCoCo4W9PfSzrtnJ962ufV8y4RH7sU9wL3jNqHb/MgJvOIGHIvkjUwTNHNZ1KcQCTfjD
         5lAVUej5dZAZZyM8zn0ONJFcfQw8qryZJr+wMIZ9m81tr3gN+OxilqB/dDlAQePky7vh
         Y3pA==
X-Gm-Message-State: AOAM53174QG3mV1MyUUoZkzMorYgoR0ZMzoduvJMRFMGooJgad01Ejxq
        XVrhVu6Uz+FYA+RNnvDl5Cm/3t0kHSbwdxMy9XM=
X-Google-Smtp-Source: ABdhPJy94b4dAChxDuW4wDOKIg2tO2nMimj827DSzBUBaeBS4xq/NcIVF/RbxLJKqEmvBcwkcK/jKU0XrmmGsie+2ZA=
X-Received: by 2002:a9f:22e1:: with SMTP id 88mr13225614uan.19.1591102618237;
 Tue, 02 Jun 2020 05:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200427081952.3536741-1-adrian.ratiu@collabora.com>
 <20200427081952.3536741-9-adrian.ratiu@collabora.com> <4acc09e8-0610-01f6-b18d-3ffc390c45a3@st.com>
 <87blm387vt.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
In-Reply-To: <87blm387vt.fsf@iwork.i-did-not-set--mail-host-address--so-tickle-me>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Tue, 2 Jun 2020 13:53:40 +0100
Message-ID: <CACvgo51QyzEa8LFpGq5zjYV-0TifQRtNh4WhMYy8jNtaswxd7Q@mail.gmail.com>
Subject: Re: [Linux-stm32] [PATCH v8 08/10] drm: stm: dw-mipi-dsi: let the
 bridge handle the HW version check
To:     Adrian Ratiu <adrian.ratiu@collabora.com>
Cc:     Philippe CORNU <philippe.cornu@st.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Adrian Pop <pop.adrian61@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Yannick FERTRE <yannick.fertre@st.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@collabora.com" <kernel@collabora.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Mon, 1 Jun 2020 at 10:14, Adrian Ratiu <adrian.ratiu@collabora.com> wrote:
>
> On Fri, 29 May 2020, Philippe CORNU <philippe.cornu@st.com> wrote:
> > Hi Adrian, and thank you very much for the patchset.  Thank you
> > also for having tested it on STM32F769 and STM32MP1.  Sorry for
> > the late response, Yannick and I will review it as soon as
> > possible and we will keep you posted.  Note: Do not hesitate to
> > put us in copy for the next version  (philippe.cornu@st.com,
> > yannick.fertre@st.com) Regards, Philippe :-)
>
> Hi Philippe,
>
> Thank you very much for your previous and future STM testing,
> really appreciate it! I've CC'd Yannick until now but I'll also CC
> you sure :)
>
> It's been over a month since I posted v8 and I was just gearing up
> to address all feedback, rebase & retest to prepare v9 but I'll
> wait a little longer, no problem, it's no rush.
>
Small idea, pardon for joining so late:

Might be a good idea to add inline comment, why the clocks are disabled so late.
Effectively a 2 line version of the commit summary.

Feel free to make that a separate/follow-up patch.

-Emil

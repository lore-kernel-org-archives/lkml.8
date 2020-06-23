Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F43BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02416207D0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 18:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPXs9lF/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387421AbgFWSlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733165AbgFWSlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 14:41:12 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5CDC061573;
        Tue, 23 Jun 2020 11:41:11 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i27so24581616ljb.12;
        Tue, 23 Jun 2020 11:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/6YdGiBITKKzNIQbw47C6ji/hg1a8eKGH7oczoUcSo=;
        b=sPXs9lF/lUUGcWy42QnCtmivc3p9nTsoNU3JnkrO63Fs8rlie/nhiK9nw72KXjwNqt
         eKMltgtMswEI1J9XSeMF9QXdAhcML4e+zt+6YexIcWMXPhxSQdPL0b9xkzrA3R+w/Mxz
         XlQwH4iq/Ge1T1S/1QCKBmNwn70Q7tw8i5jUx8r3EJM8iVWNLT5JuEA+GA/HtKEXB3ty
         2nnkLWt2TVpNbnlpiL5UElQ0yX/KX2W0G1iiZ71W4F4V82I9jgaSKMcRiGN2eBlbu7vw
         Go8D6SS6R0HsxALSor18b5NyZ5ykzynoKHTjxAmu7dr4sh9r7HCw/YlUnM/FZl1KoBqN
         WWaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/6YdGiBITKKzNIQbw47C6ji/hg1a8eKGH7oczoUcSo=;
        b=KbZs0+VjLhMIEjsyjkeO3Ge56p9GisQ17VmU/3iMC8BqaD9AO1Oet5JO0TwZTyNCTm
         s/XngktxiQf8/+BtBi2G86EmEdIYSyramzOnK4wY2fhzMF5C10m4sNZjZqR4HC0Rjm2f
         dtoAXzB7BryZJS95/uXu9NPSRF9iTDIS8eiF5x8oO8c5l//upmgPFxAF6pYitjN48E36
         QUloxXRDQPY5yiMDIYpeDl7LoQ8zdXizYBRQ5QeRXwptBvYzsgEQNE1gvV4rn8pAT6Vb
         WnpqpYLDqq6jleqUBV5XnW8v/+t/dXQG/aWSja8qcOjI+UKLUTDPQUNUychpApJu7q+1
         qabA==
X-Gm-Message-State: AOAM531Qw8crWF6h8urb8iUo0ROJh4U0uxwDnoFVrfdYyKwH3ypArdnV
        UYQsrU3eFvynuL8Ej4L7jzW27MEp0EAjyZKAGBo=
X-Google-Smtp-Source: ABdhPJxZW5hHQAEdPViFCb2ETcNyjjV7UMxxbY4S9UPHG7EKSjbfSWNf+LE7Jqd1cVCdCbHRsAKIA7KGLd+adlBYXSY=
X-Received: by 2002:a2e:6c15:: with SMTP id h21mr12345490ljc.403.1592937670037;
 Tue, 23 Jun 2020 11:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <1592937087-8885-1-git-send-email-tharvey@gateworks.com>
In-Reply-To: <1592937087-8885-1-git-send-email-tharvey@gateworks.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 23 Jun 2020 15:40:58 -0300
Message-ID: <CAOMZO5CbLvf_iV5K1zXZdYqgpBqrOZmTGR=NYyL+j73ojTGOnw@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] ARM: dts: imx6qdl-gw551x: fix audio SSI
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

On Tue, Jun 23, 2020 at 3:31 PM Tim Harvey <tharvey@gateworks.com> wrote:
>
> The audio codec on the GW551x routes to ssi1
>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Shouldn't this have a Fixes tag, so that it could be backported to
older stable kernels?

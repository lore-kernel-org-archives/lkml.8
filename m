Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D07C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A465220728
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 12:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gNMuhELw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgAOMrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 07:47:04 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39694 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgAOMrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 07:47:04 -0500
Received: by mail-lj1-f195.google.com with SMTP id l2so18368729lja.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 04:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LKM41qfZK+I1YPOs3sE0ln+ytjb0AeE1CS75B4GClME=;
        b=gNMuhELwoO28aS9RrTIh/9249e1lPntBbdbAhxIt/a5SboIutP1c//C+mVDqR4q3Z6
         /pMkgdWk4sIKijEfs9JvArrTWEUpuvIMBbByausxTy30f0TEnOA3SY2E9UGpF71fPWs0
         vXtSTf9z1wONQDaLg03dtE9BQyn7/rBqnuAUWoy+1YpuFMnKLbokY+nXxC/aexy9WA8/
         HlzSf1FzshN7h3ZBGJctu3Z0b65JD05cTf8n9JlFEdl+Da3o9yKthGB6O/uWsWvpswo6
         EdjeFs8bpAwDrR6d8llwIytZHYhrCokCkbVLuXwYq60OKSkFZFHVIHr3zsX/YF1Lm910
         ZZDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LKM41qfZK+I1YPOs3sE0ln+ytjb0AeE1CS75B4GClME=;
        b=TMd6cg3rgasVj+q1xwZq29TvnBWbFDd0Bea4uTdgup/gRkMTfmjNRF3WGxykdMVtwv
         AuP1kpB8QPAuHEeY/BseuDTA+7e14x7/WFZthNEcQhLsGqc/w8xm4aFPC/EA1p+7KtVa
         VqEOiK18Diql361s1/ryHYIBVOc/SVaq9DVVCkRGrP+Q3oQ+c3EozpDjDIe5eBuI436h
         qWbSeMfBJ/Or3cMBs3+lZdTxad824mgH6uZIaEv/llnhjwJEisVZY4Jk0EI7k9iR2Zrg
         fYMQoI1vwxs5H2FQIxZEfWI0PngqTHWJh1X8IOeZvuDmVRx8frG4oYRQ0NrI167jI56w
         RNew==
X-Gm-Message-State: APjAAAWpOR0Tq1PuBLxfCvn5WtLmwsUbNN+sGr4EJBalrBSEepkpxD+k
        jSmokc2WN4LHK7o4ea0wtaEzROxTlYv1feHTDQzlWw==
X-Google-Smtp-Source: APXvYqxgC8+7LaK6QdmhvvjkFCM2K1oiJ6yj576t1oav2aAPfmEdhF224oj2nleQBgwhKi4di3PdkxDOsJLznvwlhHY=
X-Received: by 2002:a2e:918c:: with SMTP id f12mr1683852ljg.66.1579092422193;
 Wed, 15 Jan 2020 04:47:02 -0800 (PST)
MIME-Version: 1.0
References: <20200110035524.23511-1-rayagonda.kokatanur@broadcom.com>
In-Reply-To: <20200110035524.23511-1-rayagonda.kokatanur@broadcom.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Jan 2020 13:46:51 +0100
Message-ID: <CACRpkdZhEQ9-d+NSB0++EEbLs3RQxfRHVubuqB-SPv130YW-SQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: iproc: Use platform_get_irq_optional() to
 avoid error message
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc:     Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Li Jin <li.jin@broadcom.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 4:55 AM Rayagonda Kokatanur
<rayagonda.kokatanur@broadcom.com> wrote:

> Use platform_get_irq_optional() instead of platform_get_irq() to avoid
> below error message during probe:
>
> [ 0.589121] iproc-gpio 66424800.gpio: IRQ index 0 not found
>
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>

Patch applied with Chris' ACK.

Yours,
Linus Walleij

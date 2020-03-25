Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1FEC43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 23:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A4982073E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 23:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OpH/8hZQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727491AbgCYXCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 19:02:05 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37718 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgCYXCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 19:02:05 -0400
Received: by mail-lf1-f68.google.com with SMTP id j11so3252026lfg.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 16:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BhYWNeuI7fxySpW45Kxze00QPvGt6EkBnz4YWCMRr38=;
        b=OpH/8hZQTg2SJikq6biTXo8/bYAy9RmjdvGqmZlTRV2KiX5dw9BrFyEVWY6DgVdUOh
         0vO/66dL7horRhNEjDgdgJPwTyV9MMkTE5UhTxhsUFyXanIrspkrbwp8IqF1pJ6iXl2U
         mHUwamaKdQXgC/T6Y1RSX+Qz09H5nRkqHt4Rt6fq2OEz3G7aI53HRH4nsQ2b9VHdh9JH
         Oo4b4ZYlplhiUGso2Sr+Dd7tmT5AjYI86K0z4RUj3FeckZDawYobat7KQQL7H4RBVU0s
         Z/M61Qqb8q7PxeWcPaY+/eZ9V1xuvzhqWx9OgL7tI8A7cJVCac7b99AFBV4dJg+1FVEq
         AxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BhYWNeuI7fxySpW45Kxze00QPvGt6EkBnz4YWCMRr38=;
        b=tJWrBpr4YsqnvH3AtGGorGLSfbhzuemBfBcJPgRI53T2LdRdQ9XeR3sM16zpZdepM+
         0Riw113WguieX8/tfdbYFu3lze7hlrE/hbF9vIxiLsUwX9NkT5pH20+0szdn8+UUJMiC
         cuDfNTqS9xy4Mo8gCcOONkKKBMP1qj7QhWxALMedsiU4Dvz0/Xddxm2Ior3AZ+6enGxo
         35S0+WSmAfbrnGVJ0pO3lt3768JwWsqkT+x9tvHiLazz8S0tylpp3PVZN6Qvms7FjObG
         Wbldh3oYIqZj0Eo9/cOVnl+nGigOJiI0LlvhZcH/vm7TNns26/+2EvGIdG5rnyR70n30
         rsAQ==
X-Gm-Message-State: ANhLgQ2mjrq7BuyzBRPAFimxG/aJIAT5Ng2bvdoenMRn6EQvzYlz5g+7
        KorqDxXwSmvRjYH+tBX/4mDxfHhZPox844ggMqSePw==
X-Google-Smtp-Source: ADFU+vtJik8NSp1FnZI4YjNb2Y+iw3oCOKRIyxD47R3rfEGrNA1Ywfe/cEKGAWBVGf9RtW8IvODoCsveb82PZVjsVao=
X-Received: by 2002:ac2:5f7c:: with SMTP id c28mr3528125lfc.4.1585177322363;
 Wed, 25 Mar 2020 16:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <1583780521-45702-1-git-send-email-opendmb@gmail.com>
In-Reply-To: <1583780521-45702-1-git-send-email-opendmb@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Mar 2020 00:01:51 +0100
Message-ID: <CACRpkdZiqT4hOS6bqucW7uG1ZQeijKQ1_OX2n3F8xO_H3y4-xw@mail.gmail.com>
Subject: Re: [PATCH V2] gpio: brcmstb: support gpio-line-names property
To:     Doug Berger <opendmb@gmail.com>
Cc:     Gregory Fong <gregory.0xf0@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 8:02 PM Doug Berger <opendmb@gmail.com> wrote:

> The default handling of the gpio-line-names property by the
> gpiolib-of implementation does not work with the multiple
> gpiochip banks per device structure used by the gpio-brcmstb
> driver.
>
> This commit adds driver level support for the device tree
> property so that GPIO lines can be assigned friendly names.
>
> Signed-off-by: Doug Berger <opendmb@gmail.com>

Patch applied with the ACKs!

Yours,
Linus Walleij

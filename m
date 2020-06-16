Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B018EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F61720B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fbajd8JY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgFPNuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbgFPNub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 09:50:31 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D054CC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 06:50:30 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id y13so953783lfe.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 06:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wklf5cduJTJAJSagxCZumX6yp4Hs/DNK3FMK6q52ulU=;
        b=fbajd8JY6EU5T65vTAox3j3j/UZcRkLsWmnhWNiGEKqmgtMSBIZ4ORKA9QXN6dbr+V
         d+j0MQ4OtwlRLwIqF7P/NZdBisemn4F3q3QIV/dc2262ECub3QuRhmQvRp4JfB5919eW
         ffnaGL7TAi+pGAKfxrKkweuqA9OXyj0AYY3ijtQcMHthw00h1WdiaFZmY7O6bBR+m1lw
         Qe3tEjhG0OZpa8YfSbpVo7l6c9kl+h7sivrB+YchfuxuswK9UdLKYMbmgwcHGvzxmKXw
         doqOOzoqUmgsqYdUKLCP6OA9BAcd2MWT/tRyL6eY27z15I149Jf6QOUWniEmaWV2vpdx
         x1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wklf5cduJTJAJSagxCZumX6yp4Hs/DNK3FMK6q52ulU=;
        b=HgzN8ThYbedZTeA62p5RuHXGOujxnX2esK3hl4ATceHusVJlzNdYSFNm9KeWEN0ZO/
         3POYVArVDdRl5troBnWi1p2uDKG9JhEWtoLsx5C/vvk+PoTOUWabcxyVI8T7sqXxQe21
         1GB33UtqW3XBxCxnuIqFcNCzkoPoPUaY6kawUKzaArVkzur4amttQCJZbFuqyasVXtGn
         nGEgB2P+kNUdXJWE+TgSjvGKK4/Mc+KhIeIRGayn3AjRbtYrhNmwulcH6S0REPj5XBwj
         Kj10jnC0ht8KDvjhr1delb35SnvxmE57j2atfAALHji3Khb+WPIef7VjRkD+DgmK7Sgw
         Cfuw==
X-Gm-Message-State: AOAM533Iy4MS89w2kKAm7sgYtWR5uDQqO+HY3og9nl3qLzNdB2X2WE1Z
        wNpuStKCHkb0qVJvdhXgQTGjnuwL9IZ1QhcV5WDSK5swuc8=
X-Google-Smtp-Source: ABdhPJx9KyXZK7Z/6zNonFouOfo1+V9/FZ8bo3GzemYuTqETrcc2CZb22ALh+Gf2oItWAbfviIDofbV5tiP7NBW5AWU=
X-Received: by 2002:ac2:41d4:: with SMTP id d20mr1812062lfi.204.1592315429181;
 Tue, 16 Jun 2020 06:50:29 -0700 (PDT)
MIME-Version: 1.0
References: <1591253979-29067-1-git-send-email-sumit.garg@linaro.org> <20200615201907.GE5416@linux.intel.com>
In-Reply-To: <20200615201907.GE5416@linux.intel.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 16 Jun 2020 19:20:17 +0530
Message-ID: <CAFA6WYOpXmdabrpbyJqeknkwv1NeD4+tp95zP+si23SSXDwJdQ@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: tee: Document TEE kernel interface
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        op-tee@lists.trustedfirmware.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 at 01:49, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Thu, Jun 04, 2020 at 12:29:39PM +0530, Sumit Garg wrote:
> > Update documentation with TEE bus infrastructure which provides an
> > interface for kernel client drivers to communicate with corresponding
> > Trusted Application.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
>
> Please at least broadly describe the update in the commit message.
>

How about following additional info to the above commit description?

Brief description of changes:
- Add a section to describe TEE kernel interface along with a TEE
client driver example snippet.
- Add a sub-section for OP-TEE driver to describe OP-TEE specific
device enumeration.

-Sumit

> /Jarkko

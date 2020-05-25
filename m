Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6D1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F41D20723
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 11:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cGvQN129"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390293AbgEYLpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 07:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390245AbgEYLpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 07:45:09 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11E8C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 04:45:08 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id a4so10329468lfh.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 04:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bWYfxIAWJy3heGwDbod2HfNErYY2yOdF0+bL0dgrzOk=;
        b=cGvQN129jZ03uNW9j+qvcX5jWlaAZ8AAzHOCfHxJTwvDjBuCB1OKZ8aidES7+y1FR7
         gaRIB5wbOwxz0WcvkiNdMvNcp4RWIfM8L6nuFRsN8GM5hgK5GNj0bZeiopR+21N8XIp7
         iXYdae1wOjFJXBmrSu6MYQh4vx5kseSvORdwT62G2VH838nh3AxAuraffLkLl2nBdE9E
         wgfWBIm8zPbKBIWEk8sJfhlg5wTSsHHuZ6PbEPdG5tKEj4HV+wWHCwerT3L4I33gbmUm
         qBXO9Uv40r4m8Mg1l1d7deYJMVg6yi4y/znpWijaCP7BvzsyLn9nwknen5BaSGd8sVg3
         MkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWYfxIAWJy3heGwDbod2HfNErYY2yOdF0+bL0dgrzOk=;
        b=gA5HUTBenoj4XrjVyvp+7cdeFp19kziWIThSItiydtdmI0fR8r4kP2Uf1JQeriE2HG
         J+W4PLIdB2kQ5vKyVsqlYf26GVggJW/DXmGWq52cP1pHmUqINFTDBtXXR+epr/RtfjGV
         CG5FWLZqUBx9Biy8rP7WGG1crkQ7J2Xrn/zZ9RBRIvmg6t6J8czupvkCaIb8YWlTRitR
         OvqI2i8wvnqPGTxKAbI9o4/Gz9xkaYKA1J1dvUr6MPODWD2Bm7ePFovbyEocLRLmS3eQ
         niFa2VQWWvdZmufzYv8BaqFc7wQS0yUK42G4L3xv6StxvBfKIaR5bVzKAuTG8WsZxb5W
         kRfw==
X-Gm-Message-State: AOAM5324+zgUlgB02ZlEEH8RdWEU+dQ/kOHHrzXbKrNTAELToF7A2Y3f
        gKDlbnM23vn7Acy3nBcR8BeoSX2W1qAj5TYptYc9Zw==
X-Google-Smtp-Source: ABdhPJzusZSjGYrEnidjjwfBSedPoPmO8dGLBM9cFYuYbatE3hBg4B6svhZ1k3sgXNKUJ+IluzbUuOsq5IvXBPu1/V0=
X-Received: by 2002:ac2:5a07:: with SMTP id q7mr14346771lfn.77.1590407107211;
 Mon, 25 May 2020 04:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200523170859.50003-1-sudeep.holla@arm.com> <20200523170859.50003-2-sudeep.holla@arm.com>
In-Reply-To: <20200523170859.50003-2-sudeep.holla@arm.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 May 2020 13:44:56 +0200
Message-ID: <CACRpkdb251_0RoALAV+TFXcXPMZojKuJkZWm-67=Y7fNEB+=HA@mail.gmail.com>
Subject: Re: [PATCH 1/8] soc: realview: Switch to use DEVICE_ATTR_RO()
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 7:09 PM Sudeep Holla <sudeep.holla@arm.com> wrote:

> Move device attributes to DEVICE_ATTR_RO() as that would make things
> a lot more "obvious" what is happening over the existing __ATTR usage.
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

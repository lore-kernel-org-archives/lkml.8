Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7706C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1A0220756
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 14:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaA0+jQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHLOoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 10:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726434AbgHLOoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 10:44:11 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2385FC061383;
        Wed, 12 Aug 2020 07:44:11 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id a65so2102395otc.8;
        Wed, 12 Aug 2020 07:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xHViXDWcaL5XfNSH272S9iDsrjwnvk4hUcO/qoZuaVs=;
        b=VaA0+jQ74AeZSOrwygkYlWSRj0z7ACT7aZlVtDLpBi5z7N7CEUAlMJmjhsbvlcNBh+
         gHU7bvyECTt/OMIXuH5HcA0paxBOB5E2E3mf1XwthH0vynG6EE1csykq0mpafmhxIg1k
         i7p5lldt7ssk7xGcmKXT0igFJ328lQ6vkMyiNp7zXyeea5IZoI3rU4LOvOg5gnZxnc00
         1QYjWT3Mo17KHjB12lXrmsBcPkNWHkWi0/49dhx70O9DGCzV+CjLuZVz/NI70lBQnH89
         8yicIJz7L3lfR8C/2+3mhVMme/mhwecO84y9WAjYAk0WKYBugqPsvd3QNMa4DVXHCYa+
         RtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xHViXDWcaL5XfNSH272S9iDsrjwnvk4hUcO/qoZuaVs=;
        b=I6hfwAjl9UROV9t8CnMfcGybGebwQ55xXYRgGDF2qxVDLOAUcPwvuy+Y4ZamGI+hqF
         KDv15Fm7qNtdyg4HJZQFwlKFtETuDvwYR+z2pioE518PWXRg4PN8Y6uYdH1YulTQsbZv
         JKNmnuSqKTiYgZ4zY+zLh+qwrpbI2RZtJPB0ASI6SK1HvN6SrTs+NFhLDwamTwxlAK53
         /TkVMN9V7smydq+q43iv12/Y/qEgEOApl1NcWoZZsZDwvIn2KBo+4+L6R8P1CaKMRAB2
         ebIluKl9RJcDEjbCdIhgHz1y4FEHOMUw9GKltckqAaLUzPz6iPRaTiT8+wlDKGa9bAfZ
         N45g==
X-Gm-Message-State: AOAM530lXDVITbJ2l9uWVX+gYRacWk64IAluuAdMyKpc1ivmBaAa33Yk
        iFbMqydbVtx8Sw5FX1llpIJV8sj0p9vP6uwgMGU=
X-Google-Smtp-Source: ABdhPJySHEBwiOi3qXSQCHV3l6a9l5hLKG96zwi1N2QEUT6FjWsrZwLXke9DhCaXu30Osnb4KgJRz45QoixNcPkNq00=
X-Received: by 2002:a9d:22a5:: with SMTP id y34mr40314ota.0.1597243449856;
 Wed, 12 Aug 2020 07:44:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAGngYiVa9v9jGPNu4W+KHUnvemKU-BVE89-XNLcWOmoZjAPMTg@mail.gmail.com>
 <24f1687c-043a-a15e-0be4-8392e7b5c96b@metux.net> <CAGngYiVokqYkEiQTcqAMnvif3qEWkPOb1cAk+4rvwgxBKZ5Ukw@mail.gmail.com>
 <1acc987a-d844-fca7-77eb-cf1d466f35c1@metux.net>
In-Reply-To: <1acc987a-d844-fca7-77eb-cf1d466f35c1@metux.net>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 12 Aug 2020 10:43:58 -0400
Message-ID: <CAGngYiUN4Cmf+bJDYJJwTi1DC1bZSa==AfATG+jdjmXqQxcL4A@mail.gmail.com>
Subject: Re: [Q] devicetree overlays
To:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 9:28 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> But I've still got another problem: how can I use DT along w/ ACPI ?
>

That's a very good question. I focus on arm, so I'm unfamiliar with ACPI.
Hopefully someone with ACPI knowledge can chime in.

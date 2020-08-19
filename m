Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A65B5C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FEE4204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 13:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vKaD8Sx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgHSNfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 09:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728580AbgHSNfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:35:22 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B64CC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 06:35:22 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id b17so24666366ion.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 06:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hQbF5ToGvxtok3B/02NDGGrHeRjOkJ58wAMUSrl6Pas=;
        b=vKaD8Sx9KmC3IIMDIQCjFPpu/NbsjPZssGuEjvUjMhvGEQBmdkX4cxvmSNSWCrPpfQ
         Jh89OXy5iodfr8DU27Y+zTXRqJ83sAcBQk3xtbDuyxRrQOUhDm+ojd1kKTAxud38+0XZ
         /yqP+p2fnHm0Fa3pFV+d3n3bkYoiP1Uk/amk+zFNQbXA/ugglYnhe4zbkt1IXu2oNIC6
         B0GceuzO7SUNanXjFrOrREzEYkKZo9waYMeq5bYt1ZiYPSFs94UqT9cXmuKs2vpjtyBG
         GjfhWektczaOz8SyqhH87G5aoZfm3UQBYKoVp3Ej8ptmbQbAvGdYXVQAKp78UwVD+mER
         AEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hQbF5ToGvxtok3B/02NDGGrHeRjOkJ58wAMUSrl6Pas=;
        b=aDFeNn0BtfhIF4y8RiEm4DpKx93Xr4G+0gUG3rahCsActJsJnuAlG/xbi0w2w8XdbE
         0QPB3Jnxbvl8ipeHGfYoQK3wfhMNsvdwqIVwgcIRL7yT7widZtnWKFs8jNl1kQJsT0ut
         xe6z8JnfpEW8HN023ffoOtJEvyR3kdZdpOJLvdUd7Fo1/bCyhDgR3YuLBGBBSiFVpYIA
         NmeDuSWKRBw6r7CuXhdG2gqtybCIluFkHI4KDYkux2BgLsqhl9CGEGjwa55WVBAfzK/j
         Tj9Sb/hedo2orKiluEfzfqOl3XZd8c9XHfzb9ATwkXJGJYOQ70bewdE9WfkfjCof9Oza
         Cveg==
X-Gm-Message-State: AOAM532y2GiX2FAqbJyYJutDWmmCLvLPUxMzF92M1AUYlMa0VKQBHLQr
        aWehNnP7iWT9QdSvlU77zmMHEWAAUbwohmfSBmD4W9xqvI+jIw==
X-Google-Smtp-Source: ABdhPJy7fpbKA4HrI6eBBnJsIpumTwdYNdK0/ohsv+IJtnagN8iLmxtFuzQvZmKvg9G01hldaFmE53nOjxbyMlk/lvs=
X-Received: by 2002:a5d:80c9:: with SMTP id h9mr18805669ior.73.1597844121380;
 Wed, 19 Aug 2020 06:35:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200819020503.3079-1-thunder.leizhen@huawei.com>
 <20200819020503.3079-2-thunder.leizhen@huawei.com> <5cc26ce3-963e-3ab6-6f97-706cea00c5f3@web.de>
In-Reply-To: <5cc26ce3-963e-3ab6-6f97-706cea00c5f3@web.de>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Wed, 19 Aug 2020 23:35:08 +1000
Message-ID: <CAOSf1CGJ6JNBuN+EpLttpf0HYOtN8dpqoTscGYHEbxqb9ANkVg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] libnvdimm: Fix memory leaks in of_pmem.c
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 10:28 PM Markus Elfring <Markus.Elfring@web.de> wrote:
>
> > The memory priv->bus_desc.provider_name allocated by kstrdup() is not
> > freed correctly.

Personally I thought his commit message was perfectly fine. A little
unorthodox, but it works.

> How do you think about to choose an imperative wording for
> a corresponding change description?

...but this! This is word salad.

> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=18445bf405cb331117bc98427b1ba6f12418ad17#n151
>
> Regards,
> Markus

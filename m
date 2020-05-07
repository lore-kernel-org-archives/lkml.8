Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C75DC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 420E520870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:54:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GC2cNFbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgEGMyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725947AbgEGMyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:54:20 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29738C05BD43;
        Thu,  7 May 2020 05:54:20 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id js4so551290pjb.5;
        Thu, 07 May 2020 05:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zft9HmfE/cb19n4/HL8+WvtZ/FjZoMDNx3WAUznuwF4=;
        b=GC2cNFbWuQrdvino/O5PK8jtbZyu070ia6LRYJpmpxBckEfO0f0wJosaeUAA7Ccfqy
         4ke5vEAA+FEzIBSbR312EMTF+L5WRKpKEtG54Wup1vlsglpVCvO/5fteqEyBOKs50FRM
         tRWfR0akv29PY66OLqXdrcw/0fNQoPi2FW4B7H46lwE2H/Vcrs99upppoQP4ZDRRtN86
         WWgFsFxw/ScSDgH5KMusKRrgjrXxzuTllf4KTl0+W/ZtMBDnfzBs2v9Am07daVxlmD8P
         yMFPVJt67uxVyg1K3B8VH4m8CbEEMJ9yN1Hn627UFXrwdfeA63YNJNq1L5Lff1wK3xLj
         mrUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zft9HmfE/cb19n4/HL8+WvtZ/FjZoMDNx3WAUznuwF4=;
        b=s0LEJCYKulmHO/k62cUwN0p3NQVQtBaRjz9i9nySL8b+La9vdpUuuRfr/VAuKnvT00
         zWr4cFl5AQlc0U5zCCxG/I+MLJ2Dafdu505RZMvngcdlaeqgVos/dVgqt0LHw0j9K5Nn
         T0Bq27+6tQ/iK/d//OqGXEQMVm2goYxsXCsyoKOoYVU0mHOWw9HtFLlZpr6w+njUcfXY
         kBYOm7etGVVE4jGWlD4gNaqphng7NtGR796Bek1BszEacaXow4Fp/RWh9cQj5K05yfXL
         9OINJGCFdbnABlZ7OVn7CJYY/BulfVbadj7GdGilXZ0O9AXJ3klUddOT/i+BmLnLID95
         9Rew==
X-Gm-Message-State: AGi0PuaYTGNGadTxjz5sI/NN7nzPceKcFoNKeZa+oqdt5h1UI0+fQchw
        Q9iHH30Y1vElFHBEaemJErDmZaZYekMFGNkaClQ=
X-Google-Smtp-Source: APiQypKJ/6VrPRxAWhwc2DxkNb5irAjHvIlLvXW9OzFqYnbNVbGewzZdeJSVOLX7iGwM9EfTn4MNTztUtOeGjkgg27U=
X-Received: by 2002:a17:90a:37a3:: with SMTP id v32mr15294905pjb.2.1588856059648;
 Thu, 07 May 2020 05:54:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200507094242.7523-1-koba.ko@canonical.com> <20200507111331.dzge7htw5toejh72@pali>
 <CAJB-X+WKqrWuKK0=BWtj7f8AovsMzbCO-QaLi2ZaP0_Q6321WQ@mail.gmail.com> <20200507114517.tslux7m7aysuwaok@pali>
In-Reply-To: <20200507114517.tslux7m7aysuwaok@pali>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 May 2020 15:54:06 +0300
Message-ID: <CAHp75Vcz+HgR1Vxjio+HvLOi_gpZiZLe4P-iPtsLRY8nVWE2+w@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: dell-laptop: don't register
 platform::micmute if the related tokens don't exist.
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     Koba Ko <koba.ko@canonical.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 2:45 PM Pali Roh=C3=A1r <pali@kernel.org> wrote:
> On Thursday 07 May 2020 19:27:47 Koba Ko wrote:

> > don't understand "registration and deregistration would be optional',
> > could you explain more!?
>
> After your patch led_classdev_register() function is not always called.
> And led_classdev_unregister() should not be called when there is no
> device registered.

I think it's not a strong requirement after the commit
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?i=
d=3D1dbb9fb4082ce2a2f1cf9596881ddece062d15d0

--=20
With Best Regards,
Andy Shevchenko

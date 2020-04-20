Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2334C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E9D0206F6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 15:30:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bp8Y7lB6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgDTPaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 11:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgDTPaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 11:30:25 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DE43C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 08:30:25 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d17so12679697wrg.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 08:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PD5DeOdqi6e0MkxPAfwdJyP3eDR+86tLjrIumXPzzT4=;
        b=bp8Y7lB6hXvn9JH54tFD2UDbpwmiblTLlKAIT3+DCmvZle1bg3aC3vYn1nqOyiR5OY
         HgL3OGsbeJva2GrenO/QQ9jEXf99AjvliEDPB66I7Q3lm0BMgokvt7k9nT4P1r6k8aCn
         5PLeAowMTscry4PrfawUrthTM4pC+ndE/nZL5Zv9YlQ0cyO1KWbw11HmyXClk5QiMx+G
         1A+0vJ5x/0My02ge4tzFk8os5rcxhHmpPqt88QASYX3j7OJFqLDkeX20CT4Ald8jIsYD
         jUITLIwrB69buHlkbfNn8nJX2dyIUQkrPgAK9AToP92RpJSZ0C5ftuPFuOyAtZ5ipn3C
         ralw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PD5DeOdqi6e0MkxPAfwdJyP3eDR+86tLjrIumXPzzT4=;
        b=cycjovXNkZAFREZHfF8P6Vp73p+ajgVOURrWvVgN2izu/YqT1Y5aqjaca165+O4mC2
         PG5oHR4wNEc56bXVNu4iEXdGa5MfZFZ4Sk0vnl/53WzSoGOIWoG/yliLeyfyml580vGt
         UZA9pl36U+WTtxtc65YWr324m+F0TwFdLmQZiLHIx6DKVXOxUaDa1Khiacvd9JiM+RC7
         92IIWQZqrggFCPPhj+aJ29aOZWJw5ZF3TZ6wjZJV+I/Z/35BxOqCIFOPCEavSaAzkM7x
         2gTmr6FfgGzX3ccBUsVbtcd8PfWvsidPwVPNxj2kdtMNLUJVbFYqaAahGkNtW3IkjzRG
         vgrQ==
X-Gm-Message-State: AGi0PuYo3QkWjBSLLvJJElzJWHccAVhbICjXKJKHtxVSdXc2g+zrFNc+
        OeRofkg+IPL8iLrwH5f7DesJDmxCYXeOWX26a+U=
X-Google-Smtp-Source: APiQypJNVGW7y4CcAc7fYlBuLAQtsl07x5NtoSods0LPEQbSJ1ymdgu97+hTSGZ3nDodKZ90UfA1dTb1tUYmxNTUDzs=
X-Received: by 2002:a5d:498d:: with SMTP id r13mr20138167wrq.374.1587396623955;
 Mon, 20 Apr 2020 08:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsN=SNp7Ub3KHmsGrg+5R1g13HMea2+Jw+hTer3g74q21Q@mail.gmail.com>
 <4a9ae285-f126-c83b-b55f-36bd7a4403a0@gmail.com> <CABXGCsNSni7cjufva_n-VZQ4HKY2osBL4JB2kk_z7Pzv2u10MQ@mail.gmail.com>
In-Reply-To: <CABXGCsNSni7cjufva_n-VZQ4HKY2osBL4JB2kk_z7Pzv2u10MQ@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 20 Apr 2020 11:30:12 -0400
Message-ID: <CADnq5_NXtSfn1C8kceQ_Bfmu9LbgRTPVq_s6yk-6BG23ZB10Qg@mail.gmail.com>
Subject: Re: BUG: kernel NULL pointer dereference, address: 0000000000000026
 after switching to 5.7 kernel
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
        "Russell, Kent" <Kent.Russell@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 7:13 AM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> On Sat, 11 Apr 2020 at 14:56, Christian K=C3=B6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
> >
> > Yeah, that is a known issue.
> >
> > You could try the attached patch, but please be aware that it is not
> > even compile tested because of the Easter holidays here.
> >
>
> Looks good to me, so it's pity that this patch did not exist in the
> pull request https://patchwork.kernel.org/patch/11492083/

It should show up in the next drm-misc PR:
https://cgit.freedesktop.org/drm/drm-misc/commit/?h=3Ddrm-misc-fixes&id=3D8=
623b5255ae7ccaf276aac3920787bf575fa6b37

Alex

>
> --
> Best Regards,
> Mike Gavrilov.
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

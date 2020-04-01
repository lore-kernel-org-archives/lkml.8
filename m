Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC04CC2D0F3
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C24EE20776
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vis5kbVh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732749AbgDAPHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:07:50 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45912 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732643AbgDAPHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:07:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id t17so26166652ljc.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 08:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WedDbKscds1ScdlD9Vgo8BPtCth3GHq3H8QxE59GeR0=;
        b=Vis5kbVhSKwdnTHbh23flW5MVbI/z6DrT9FnkVi7g7tdVv75rRUaDVBOfa3kleOMMc
         d2o0Mh3II9WvRbLDYg7UoJ/yj6wn7CMM0G8PQZAFNclbBZEPTtwEYs/3Ir/p+11c/mIS
         HK2wwZoCUdbIISE63nN1tKpkmDutDW9iq0SIuUPh4Fi0hyzEporbrUd71ACnROY8MF5A
         KvmCDwzArkRjLe827L0b1Emw1DZfceNJM0NOxLYrUtm9D8gGB2oDVz6N347ysAiomGtv
         sJJvbzfXfuZ4y070hR6dq9mtchy/vI83/jQHBXDKCPtJWObGwqoxMtu+sGl2NoPx/zkp
         f/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WedDbKscds1ScdlD9Vgo8BPtCth3GHq3H8QxE59GeR0=;
        b=WKlOYHPxzbYISrrdjgOE5NKpc0lubMrj6DMr49LdaCu+KUn+laY0TizyXMUEv56Ual
         bUVSeDQMG6EPiHBYe7s2Gzg6P1yMB0NwoiPszxdCj93TqbbF/hnG73uJxlWUspfeggXC
         IdNXs932tTBEMy6d1VMBJbEbsFYiwSt7QO2Iqk3+X4mOKW8CbyCckG2gkWig8U1bJwtE
         EqgHHE++dNXeMLPMlNZauy9XMU4OC4jUztf1HRJzxhzq+hqZXNDWm6BJ0pbF42/Vb/xD
         qc9Y/CIMke3W239WVRH173rzxlBkm/Lqb5brzk/d/Cc586tf/zX/EMBgtovmCaL/9bll
         kydw==
X-Gm-Message-State: AGi0PublTu/T8g1p0bI43d8/37Zzbx9m9YgQWXbJAuhdWvsIff1m7MSa
        nJY2b/RkIqDWItZKbpmWKaqUt4lzDBHQbI42MtxLqQ==
X-Google-Smtp-Source: APiQypI7DWIapsgX2mpmJ7dyihC8+otTy79jKFraWuScfSK4kCBWYFwG/YLyjIrnGq2ISWt8eTduQN1mYdpFNsX9RRs=
X-Received: by 2002:a2e:89c5:: with SMTP id c5mr1025906ljk.48.1585753667081;
 Wed, 01 Apr 2020 08:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200331085308.098696461@linuxfoundation.org> <CA+G9fYsZjmf34pQT1DeLN_DDwvxCWEkbzBfF0q2VERHb25dfZQ@mail.gmail.com>
 <CAHk-=whyW9TXfYxyxUW6hP9e0A=5MnOHrTarr4_k0hiddxq69Q@mail.gmail.com>
 <20200331192949.GN9917@kernel.org> <CAEUSe7_f8m0dLQT1jdU+87fNThnxMKuoGJkFuGpbT4OmpmE4iA@mail.gmail.com>
 <20200401124037.GA12534@kernel.org> <CAEUSe7-ercqbofx93m-d0RNW_dQqr1U7F7JYQ5X81CHSkq4KDw@mail.gmail.com>
 <20200401143427.GB12534@kernel.org>
In-Reply-To: <20200401143427.GB12534@kernel.org>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Wed, 1 Apr 2020 09:07:34 -0600
Message-ID: <CAEUSe7-eJrWWH=L+mfj80sMU1S16_yuE4fbeodpvQG0jRU9b5A@mail.gmail.com>
Subject: Re: [PATCH 5.6 00/23] 5.6.1-rc1 review
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, 1 Apr 2020 at 08:34, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Apr 01, 2020 at 07:45:53AM -0600, Daniel D=C3=ADaz escreveu:
> > This worked on top of torvalds/master and linux-stable-rc/linux-5.6.y.
> >
> > Thanks and greetings!
>
> Thanks, I'm taking this as a:
>
> Tested-by: Daniel D=C3=ADaz <daniel.diaz@linaro.org>
>
> Ok?

Yes, I  build-tested those.

Thanks and greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org

Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B20C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 06:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82EB12075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 06:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="a75yW7ab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgEKGym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 02:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726438AbgEKGym (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 02:54:42 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2888AC061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 23:54:41 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m18so6675832otq.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 23:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6+amfEosJ/bxoBXLb6j1uSeLid6XebkwIxNU/VrJcPg=;
        b=a75yW7abW6pGtQ5fe3DEi2pjcgbX5xc8WztVZeVFufziZx+d4V/T7QWjUoYYjsQuwb
         GtNIfRw6PJb58i5XEzZbAaD5M8SFtzAl/aTandUu2B7fnwEgyUudv3FPKJ5ronfxP/FI
         NIm+Dsy0EOGR9NxCo47VECaQ9mHt4pySNhDk9umEDl2i7/k194FpMlsXW4eKXaEqsFud
         PHd3Z/NyuUmFRAQ/lXMhK/NhDv8eBPGdi/RcONTBtN1S9taAF5Fgi7zV141t5W4onNBL
         oJgzgyIvJlbeSgA/HdvDP9k+S5gA38olwYyc3vOKcDZWrZXRYbk2EYVzgQV5BI8sIOHd
         4fQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6+amfEosJ/bxoBXLb6j1uSeLid6XebkwIxNU/VrJcPg=;
        b=XEJ2f7msZTy2r4mL+Wwar9+glWpLDCZNtwueI3Zpf6VGuX3c/Q6WgqdSEf42FVhuHk
         qoXdPjmQTsBWWM7AJ0uDGh36TJp9fsJY21R7enFgY8hRXSDv5N1VtmUb80qLxsv26dlS
         HS3jGBya7G8xIZcozOFjPfnj5fu4W6dlyDWFfcsvoWkaxp6+JpiAEbxK2sdo90ySv+ys
         5Ec/hGH7AmL2vsPhWYEvHbgddDvwwomTIA0HFtZLxuWf3neO3SyYI2isk3z3xNmP6faZ
         W8jABtgdNcQ6WP3HITG6oJt6bZ9uUwtVgh5F1zaWfZa0PfbEXOxdTj+3zgbIg16tc12x
         7MaQ==
X-Gm-Message-State: AGi0Pua+DTe0Dw/6BhenEiW0K8SAisnulwKf+uWSZLh7CXaH+YIGR1xt
        h1eGJs+/rDtxsjo8MoqXSbnKSB/7VNwl4QFAderoig==
X-Google-Smtp-Source: APiQypLkNnC4oo0clTiNZcwduav+zSJ51Ke8PRXADTGgd3N/ohCp/OedUzze728dcG1VvvKoKW2dxexVu0OnsACtau0=
X-Received: by 2002:a9d:7312:: with SMTP id e18mr8580141otk.33.1589180080183;
 Sun, 10 May 2020 23:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAB4CAwdqo7=MvyG_PE+PGVfeA17AHF5i5JucgaKqqMX6mjArbQ@mail.gmail.com>
 <5029155.caIQduTdCh@kreacher> <CAB4CAwfFeJjrxQvpUz3V6VMW4aHWd7iZD6Xpu6rAnaPv=ZpFeg@mail.gmail.com>
 <79452135.44xTU8OeJi@kreacher>
In-Reply-To: <79452135.44xTU8OeJi@kreacher>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Mon, 11 May 2020 14:54:29 +0800
Message-ID: <CAB4CAwfSAjZUTf5DwqrJUV5BH5mx6EZMnnDjkCLHb_nA6jjvsA@mail.gmail.com>
Subject: Re: System fails to exit s2idle by a keystroke on my laptop
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Seth Forshee <seth.forshee@canonical.com>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 9, 2020 at 12:50 AM Rafael J. Wysocki <rjw@rjwysocki.net> wrote=
:
>
> On Friday, May 8, 2020 10:22:09 AM CEST Chris Chiu wrote:
> > On Fri, May 8, 2020 at 2:05 AM Rafael J. Wysocki <rjw@rjwysocki.net> wr=
ote:
> >
> > =EF=BC=A8i Rafael,
> >     Thanks for your patch. I tried it on my laptop and it's also
> > working fine. Wake up by keystroke/power button/lid open all work as
> > expected. Thanks.
>
> Thanks for the confirmation!
>
> Please also verify the final version of the patch available from
>
> https://patchwork.kernel.org/patch/11537215/
>
> Of course, it will only make a difference if the ec_no_wakeup switch is s=
et
> on your system (either as a result of blacklisting or via the kernel comm=
and
> line).
>
> Thanks!
>
>
>

Thanks. Rafael. I've tested it on my laptop and it's still working well.

Chris

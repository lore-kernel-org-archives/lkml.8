Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA68FC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0B9D20663
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hackerdom.ru header.i=@hackerdom.ru header.b="Z06ioZWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbgCMVnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 17:43:11 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:41162 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgCMVnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 17:43:10 -0400
Received: by mail-vs1-f67.google.com with SMTP id k188so7213438vsc.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 14:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hackerdom.ru; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ylFj3zeTIZkFpwpBxoZ98U2goVEkQPraU3e8Q+0STys=;
        b=Z06ioZWXC9qUUMYFklSpMq4HebUP9H/56Nk8CjwMebDGvQI//jW95kLICwKWPVbRYZ
         N3a412jfCIbuFWlFtMP3YyOY8GbdjYIdi0FBYICkC7JUlgyiZtZ+jqFp1W7d3OAxlrIw
         JFSRJFQG5a7oMEKaaB952DdHgKGaGGAXwXkR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ylFj3zeTIZkFpwpBxoZ98U2goVEkQPraU3e8Q+0STys=;
        b=Aoz9Xy/41nWTlAaR8I/VKUxkchAje2E76Wyj03ZouoKBjdzVbe7yg+1Dmvo8O0dZ21
         0qJQ9b68aK8NeJ1MbJwuYm7IQw9BzorFCbAqgbbJV12A30AChkAd+5NX/ikA3hV81H+U
         Fx48KmXg5HsOPzwCi8FNXOLb0yrugXF211kQ9g2ycONTCeeJ8MZ7xldM9nG6MIpS33Sm
         Z6MGOFYFV9K3EVFGGWUawfV9ol1MdY+gRhb/8Cxg+Il6mV8lWV8zJFjdSZEgxAdRZKqn
         LjiYV6FyQ8joxkP1v4rQgqaBSmmYC2u9/x+8TXTP3Q6YH1NK8/VgQMf/FKEChdbuYEAY
         9yEQ==
X-Gm-Message-State: ANhLgQ0i0ycqfU05qysL4J2ORpfCRvaAePm8r0+r3bglz+EQdJJ4KRfq
        GYiRcF7jxP5FflHnMi60OoL6RYIKcCHakRjFIPrmgQ==
X-Google-Smtp-Source: ADFU+vs61bZAervmQ3vm6cH24IQ0ejqgD9VitKVaeya5atguiynC6c+jppIvMnwe9pEQLGJ3qWOpR44GGFrtziyG03Q=
X-Received: by 2002:a67:88c8:: with SMTP id k191mr10538682vsd.110.1584135789094;
 Fri, 13 Mar 2020 14:43:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200313205415.021b7875@canb.auug.org.au> <CAPomEdz6pVnD39iZHSEd3gwEhgP2g8B5vTvqBP7eEHEAvTvFMg@mail.gmail.com>
 <20200313.112105.352870193577036810.davem@davemloft.net>
In-Reply-To: <20200313.112105.352870193577036810.davem@davemloft.net>
From:   =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0LXRgNGB0LXQvdC10LI=?= 
        <bay@hackerdom.ru>
Date:   Sat, 14 Mar 2020 02:42:57 +0500
Message-ID: <CAPomEdweTzsy=jiokMKV_enE=EkDocXxV3BZTV3ocAy50zvRwg@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the net-next tree
To:     David Miller <davem@davemloft.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, done.

Best,
Alexander Bersenev

=D0=BF=D1=82, 13 =D0=BC=D0=B0=D1=80. 2020 =D0=B3. =D0=B2 23:21, David Mille=
r <davem@davemloft.net>:
>
>
> Please submit this formally, inline and not as an attachment, to netdev.
> Otherwise patchwork will not pick it up and it will thus not get tracked
> properly.
>
> Thank you.

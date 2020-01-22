Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374D1C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 21:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED98D2465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 21:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579726928;
	bh=mI1h+XcUohH1Ah0tPd29whLheExYAGqOqauXp6wVM8Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=susIYY7j6CctMX/tM7DnxnBqgF7955+dK0Zg0U8dAw9H3nrOrmyf2LjRNK9+xuAht
	 6AbEIxtsmmk390atDQ+A56vKI18slExmyNyfzOpBYOcbIWg/2VjoGVy2Vpqc2TIHkj
	 QobnLEwHF0onxsyJ7lOm91r9ZnQIdRfxF1JrIKgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgAVVCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 16:02:06 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42150 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgAVVCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 16:02:06 -0500
Received: by mail-lf1-f68.google.com with SMTP id y19so655854lfl.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 13:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hP1mENuItdJnN2aVntO5IMnlJCI7lfXArukwoEVqH/I=;
        b=Atv4A5J15roxDToZcP61ysc18ZTE6nszskdZa28nkL7KJWUTLnHzBqR9QFtpRpHtnm
         T1ItpDcHVq3ctozS7CL2QGu+dUmvkYE0sSYvclZRaEoMooONPNIt0/VrDiSfz0HJCMU2
         +fPIUDF3rnWCLtLj2Tm3MzXz3gKuLrkpFvHDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hP1mENuItdJnN2aVntO5IMnlJCI7lfXArukwoEVqH/I=;
        b=frRO0Fmw7IfjOYLti3M+DLBWaB8u+rsIOyWQNFrdBlw3aRo/N/GrsXWHOv7Lwy+NQL
         6/EFS0UgY5YPtyg84aSToeuMNXgnOxLoEVier0CxLQSgEbs4r+ZZweUdGOyyeO7la/+d
         PfSCbVbSbeX3Ireu5TozkVkRc0/YKXCqhLILuK6Tavg7XiOvKSPXCBPggd6R+r/QXgIO
         sglnuocfdHnxcb1ZzZgU+OBgvWJQaR4+hUBiEemidMOeBrB7txejsMWUq+sBBT3mxSDS
         cO+fX4dejyAKEl2aoE2vazBPqOE0PKycLEcCB78zv2OHCPV66uGCCTyBOUDnYYE9zyQq
         AMkg==
X-Gm-Message-State: APjAAAUYLVL8kJWw+HIlTCCSncjNelShMS+CL9iHk/+l5y+rGX0xXHN6
        uVStPuO4ZYpbZA0R9faWxwdYqOf2aeE=
X-Google-Smtp-Source: APXvYqygsunQ5ppel5clXtfj2s6RwRWwVx/N1wGEfuBY/XzfNiFOZfKQHjMr6qBM1d0silUYMm/9oQ==
X-Received: by 2002:a19:c648:: with SMTP id w69mr2710698lff.44.1579726923932;
        Wed, 22 Jan 2020 13:02:03 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id k23sm21218912ljj.85.2020.01.22.13.02.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2020 13:02:03 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id h23so620731ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 13:02:02 -0800 (PST)
X-Received: by 2002:a2e:7a13:: with SMTP id v19mr20632976ljc.43.1579726922616;
 Wed, 22 Jan 2020 13:02:02 -0800 (PST)
MIME-Version: 1.0
References: <20200122201711.GA29496@amd>
In-Reply-To: <20200122201711.GA29496@amd>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Jan 2020 13:01:46 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjDUy5_070R-3W15+Aknjsnhe=EmSeKQ6mt=dOxe3zNeg@mail.gmail.com>
Message-ID: <CAHk-=wjDUy5_070R-3W15+Aknjsnhe=EmSeKQ6mt=dOxe3zNeg@mail.gmail.com>
Subject: Re: [GIT PULL] LEDs changes for 5.5-rc8
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 12:17 PM Pavel Machek <pavel@ucw.cz> wrote:
>
>       leds: lm3532: add pointer to documentation and fix typo

You should just have fixed the grammar error in that string too while
fixing the typo.

   "Too many LED string defined\n"

that would have been better with "strings", since it's plural.

I didn't bother to fix it up, just reacted to it since I was looking
at the changes. Not important.

               Linus

            Linus

Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FF5C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 21:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA202078C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 21:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxS+qmPB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727928AbgDCVxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 17:53:23 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46182 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgDCVxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 17:53:23 -0400
Received: by mail-ot1-f68.google.com with SMTP id 111so8874689oth.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 14:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WkVgfhf1jxt3Qcf1HJwqyy0TSMOQ4/cQvIXHGEwbDuY=;
        b=QxS+qmPBgxo5vX/QyhllnCiawfcz5y9/M9UxOwdlfMJPVpefDzmTVnrXkHrZzB5Id0
         hZDndsAvkwX1Lwyc/IUkRPYL0PARNl9hU69JY/xa0I9IQ9Gm3J7wn1D/UUnwZn+swiXG
         vyr1SBnSonlB1gjjcOphc7NqfG+1iDRH6H2exOcAmE7Fv6J9qdsnw9j9pq1isQ1gd5oW
         D6S3BFDNPjtoh0lUaVoNrucu4Ppt80vlg7s0wYjjF21gSSoitxXeaISqZZAy/FFnZMZT
         obUL9IOcaeSghSztiDkKi5QpIdwLEhS8NJUBk+YljIS16NC+LAcA7Xj1kkXrDpO/+pGM
         SfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WkVgfhf1jxt3Qcf1HJwqyy0TSMOQ4/cQvIXHGEwbDuY=;
        b=dZUbsIkQLWIOQFnBhPIijv6mo0nCvf7dEnpJuqpBR3LVvVFJkOKIwmmRM71vDGyMJ4
         glqq+9wtDp4pH7c0Is/03MLbJi2GxAmx90ebYErfev8+pMOLNrnzxnXjg1XTWSSr0DaQ
         L8JmNdCPt8rw7GRC2neIs8xdL75p11EBs3BR92KXNqQxSNXVu352t/+JCdkknB8b0W2o
         QvLoi+lHxO0KuBF9mRMxyx/gysf5aOt6GofcaR1Mg5hI1UXtKK7Cm+Y386zTvOe6EE8I
         GkRuAdNZFKMMhaHQ4sjEir2T40TiNkjY/tbRIBkZ0XSdkbwXfYA/GwZDqtafCd6rPraV
         qziQ==
X-Gm-Message-State: AGi0PubGLawo25AA5S2/zTJuU3nSXlN6H0eXhqAZUvfxrtlMY6iPB9/G
        sPH0Dp11hsjETk20PSdk6M8KUNQ6ORdzki9awcw=
X-Google-Smtp-Source: APiQypJSeVyKS9Ri7WzRD18HhnNx30wQ80U7I7LjklcP7lED2dlpI6RzKyOiylq/liehLbkdChLyvCFxJCI76LNz1KE=
X-Received: by 2002:a05:6830:2318:: with SMTP id u24mr8110267ote.106.1585950802563;
 Fri, 03 Apr 2020 14:53:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200401143904.423450-1-dima@arista.com> <20200401144610.GA2433317@kroah.com>
 <b0099c8c-5bab-960a-8d0d-4691e11a462f@arista.com> <20200401151222.GA2508664@kroah.com>
 <87pncqu0cv.fsf@mpe.ellerman.id.au>
In-Reply-To: <87pncqu0cv.fsf@mpe.ellerman.id.au>
From:   Dave Airlie <airlied@gmail.com>
Date:   Sat, 4 Apr 2020 07:53:10 +1000
Message-ID: <CAPM=9tzujQOXo5Df+UZLTW5pp3JNfchSX-0KVZmOidvFQWxkCw@mail.gmail.com>
Subject: Re: [PATCH] tty/sysrq: Export sysrq_mask()
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Safonov <dima@arista.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "kernelci.org bot" <bot@kernelci.org>, Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Apr 2020 at 11:46, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> > On Wed, Apr 01, 2020 at 03:49:56PM +0100, Dmitry Safonov wrote:
> >> On 4/1/20 3:46 PM, Greg Kroah-Hartman wrote:
> >> > On Wed, Apr 01, 2020 at 03:39:04PM +0100, Dmitry Safonov wrote:
> >> >> Build fix for serial_core being module:
> >> >>   ERROR: modpost: "sysrq_mask" [drivers/tty/serial/serial_core.ko] undefined!
> >> >>
> >> >> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >> >> Cc: Jiri Slaby <jslaby@suse.com>
> >> >> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> >> >> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> >> >> Signed-off-by: Dmitry Safonov <dima@arista.com>
> >> >> ---
> >> >>  drivers/tty/sysrq.c | 1 +
> >> >>  1 file changed, 1 insertion(+)
> >> >
> >> > Is this a new problem?  What commit does this fix?
> >>
> >> Right, sorry I've managed to forget adding the tag:
> >>
> >> Fixes: eaee41727e6d ("sysctl/sysrq: Remove __sysrq_enabled copy")
> >>
> >> Maybe also:
> >>
> >> Link:
> >> https://lore.kernel.org/linux-fsdevel/87tv23tmy1.fsf@mpe.ellerman.id.au/
> >
> > Thanks, that works.  WIll queue this up after -rc1 is out.
>
> Why wait until after rc1?
>
> It's a build break for a bunch of folks and the fix is obviously correct
> (famous last words).

definitely seems like something that should be fixed prior to rc1,
s390 builds in fedora are hitting it.

Dave.

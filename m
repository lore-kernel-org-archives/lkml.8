Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C949DC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3AF0214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:10:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="zawuOQt5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395114AbgAPSKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:10:01 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35643 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395107AbgAPSJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:09:58 -0500
Received: by mail-ot1-f68.google.com with SMTP id i15so20237820oto.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 10:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FzuZRenN/3UczXLj3+thO7tKTqsTx9weWp2ttaG3+Ko=;
        b=zawuOQt5P47InN/xf28+hOOPRs0JqfEPg7d21bnyv89wscVYKmezFAfp43eeV4aj1z
         amFHw66rURc66/hjqx+kl6xxu+bxKSxkeEHWHRlL7UAodZS4USBNj/I1Y1mC8w76qAPe
         oJPFMagtBnvN/9TXG8ZOcyPhNz9NfaMSlmontOpFUyjwa9D5ipU4d2BAQTFZtbYH0LO8
         AsAKOyhzVopHd0EMrUJCO/LYIHUuDEZldvlymyKTVB297Erz7EZ9RyUbVBQeAe7/Ja4V
         HC9yWT8qYYbgQJarOSQ/z9QpA6XabIQSANO7+YXGXik4Wuxi4b0InRmGg+tFAxyTAk/5
         dK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FzuZRenN/3UczXLj3+thO7tKTqsTx9weWp2ttaG3+Ko=;
        b=RBkiDDEsvW7FZE7VNOVT4NG8oMQv2ddtwcJd2YTTlXcJwcnLIf6nmtIaC1pZEQGoW6
         Afx2nBj/Zt2ztm1xA5qqVIVNtqMS3A1aisK5VGDm3sEgwRWglaJc98kA5sA0IxNnOScS
         3/pEjrGJnmgKTZfu/qM8IkhHYqh0XoXcs9rDmNWRblosLVmD1nkKS7q76j8s3LuAraaL
         HQH3hLVqkoAgx5ybCB/oaGeO6CmY9hxVeUDhKy4Cbvy3Wqr0jTQHNtkCw+zmO6rQngVq
         JHphhL2CQ3D5K5J+QBxVABRXuDj0g8d5R57ueQdenW2et6gzTmLzKAIURUoN/Ck4F9RD
         Rntw==
X-Gm-Message-State: APjAAAUEHUSUVm/4tW6cw3CqNaeP//Kb43Uv9KeaaqHRL3N841FQrBSI
        cUMunrLQR3jtX4PlaQ3j99KqcopkbddJgGt96tTBGg==
X-Google-Smtp-Source: APXvYqxAe2+rFr7S0FrSp08rIPwAe1Wau7z51hUUxL0cS3xj2Ecu8Rh56J0DxcLVUk1gryZFW39U+zJXoh6ArDNKXCE=
X-Received: by 2002:a9d:68cc:: with SMTP id i12mr3043119oto.207.1579198197588;
 Thu, 16 Jan 2020 10:09:57 -0800 (PST)
MIME-Version: 1.0
References: <20200107180101.GC15920@redhat.com> <CAPcyv4gmdoqpwwwy4dS3D2eZFjmJ_Zi39k=1a4wn-_ksm-UV4A@mail.gmail.com>
 <20200107183307.GD15920@redhat.com> <CAPcyv4ggoS4dWjq-1KbcuaDtroHKEi5Vu19ggJ-qgycs6w1eCA@mail.gmail.com>
 <20200109112447.GG27035@quack2.suse.cz> <CAPcyv4j5Mra8qeLO3=+BYZMeXNAxFXv7Ex7tL9gra1TbhOgiqg@mail.gmail.com>
 <20200114203138.GA3145@redhat.com> <CAPcyv4iXKFt207Pen+E1CnqCFtC1G85fxw5EXFVx+jtykGWMXA@mail.gmail.com>
 <20200114212805.GB3145@redhat.com> <CAPcyv4igrs40uWuCB163PPBLqyGVaVbaNfE=kCfHRPRuvZdxQA@mail.gmail.com>
 <20200115195617.GA4133@redhat.com> <CAPcyv4iEoN9SnBveG7-Mhvd+wQApi1XKVnuYpyYxDybrFv_YYw@mail.gmail.com>
 <x49wo9smnqc.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49wo9smnqc.fsf@segfault.boston.devel.redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 16 Jan 2020 10:09:46 -0800
Message-ID: <CAPcyv4hCR9NV+2MF0iAJ5rHS2uiOgTnu=+yQRfpieDJQpQz22w@mail.gmail.com>
Subject: Re: [PATCH 01/19] dax: remove block device dependencies
To:     Jeff Moyer <jmoyer@redhat.com>
Cc:     Vivek Goyal <vgoyal@redhat.com>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        virtio-fs@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2020 at 1:08 PM Jeff Moyer <jmoyer@redhat.com> wrote:
>
> Hi, Dan,
>
> Dan Williams <dan.j.williams@intel.com> writes:
>
> > I'm going to take a look at how hard it would be to develop a kpartx
> > fallback in udev. If that can live across the driver transition then
> > maybe this can be a non-event for end users that already have that
> > udev update deployed.
>
> I just wanted to remind you that label-less dimms still exist, and are
> still being shipped.  For those devices, the only way to subdivide the
> storage is via partitioning.

True, but if kpartx + udev can make this transparent then I don't
think users lose any functionality. They just gain a device-mapper
dependency.

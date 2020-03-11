Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA20FC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775F92146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 03:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WN2FMsmW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgCKDIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 23:08:06 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39555 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbgCKDIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 23:08:05 -0400
Received: by mail-lj1-f196.google.com with SMTP id f10so605775ljn.6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 20:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S3McxT6mwdXQCq8O+GjT5AJS48P8WW7vRM4aVoEDZrE=;
        b=WN2FMsmWpOysqPSfDBICN4Poa3+vGkP++U+5vJWQ6YfDIO1/VHH3+/VCy+Y+cOUu1K
         QHhANIyshY2h681iGBXVGeuvgjf1VmpgkiaW+5bSYJFKaJ3KvM2HKXSyHgtYhldVb7gr
         MNzmb+upwFlvFJ+38IRXMwZvQEFTNJbbtYEVMXuV+8nSICJKe8quTFpOrYnpnbDndXmz
         BQC8wcte47/OIrsumaUqtlE/PaNJ8QY1I0UGRYSUuegdHUsIZrPtBLWZfwVSLxtidulW
         O0HX4kczBuEkvyAR5jsb+qmn50PwGlkfl9naVB3klLe7UhsPUX1GvK3Euf/p3g0Hlzlx
         smzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S3McxT6mwdXQCq8O+GjT5AJS48P8WW7vRM4aVoEDZrE=;
        b=b98uLIBKS2guWpWRu2ASxUUpQbWAl34u+MGv3ILbZV+MEPUrIamk2WY5FrP5eDA9eO
         mZCAaRsRfOrJ6hbT163xNulyfkbxDO6UHrRVXcW8xD4TxT23qm+PFK17LJEy0ASkAvvd
         QDL5k+2pnGCLAhNFTueOa5JeMz3vU0ZFjvxxXPnTZyoiGyiuu/nZqyAriUufQaRfyISo
         EOKlc5CEnFKu8DJk6dGIC+Vf6h6lhYGynoWxkBCldJuUwwjN+KIoCXsojYmsifcm+ahj
         0OGlyNQoo9dG2tRHRe7fP59BvUaN/miq4R3R3u5+ISMRPfdCj0Md79ZJix2ayXyXoNnp
         n0wA==
X-Gm-Message-State: ANhLgQ1XKgWqgyqjTjWB/CBPPOZMgtwW6M5PfoGY8nMl+KrLDIHFclR5
        npQDtiJO7c2IPOCECudA6/Fk0ij764Md9xTeDys=
X-Google-Smtp-Source: ADFU+vuBpPlJvzZE7Ab+A+IKVpjICviun07pi/CLEPsLZpCP3gLjVTqRifHwFgnqvya4v8+e2R+Lxl/dpar5Eo9Xvlw=
X-Received: by 2002:a2e:8597:: with SMTP id b23mr731142lji.181.1583896083646;
 Tue, 10 Mar 2020 20:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200309021747.626-1-zhenzhong.duan@gmail.com>
 <20200309021747.626-2-zhenzhong.duan@gmail.com> <20200309085335.GA14776@gondor.apana.org.au>
In-Reply-To: <20200309085335.GA14776@gondor.apana.org.au>
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Wed, 11 Mar 2020 11:07:52 +0800
Message-ID: <CAFH1YnOfDb759uRXhwsht7tTn2+9GS8PbmkwRKN9U+q0DsuzHw@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] misc: cleanup minor number definitions in c file
 into miscdevice.h
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matt Mackall <mpm@selenic.com>, jonathan@buzzard.org.uk,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Miller <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 4:55 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Mon, Mar 09, 2020 at 10:17:45AM +0800, Zhenzhong Duan wrote:
> > HWRNG_MINOR and RNG_MISCDEV_MINOR are duplicate definitions, use
> > unified RNG_MINOR instead and moved into miscdevice.h
>
> Please keep the HWRNG_MINOR name, RNG_MINOR could cause confusion.

Thanks for your suggestion, I'll use HWRNG_MINOR as the unique.

Zhenzhong

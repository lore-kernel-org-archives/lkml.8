Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041ABC3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBD832080D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="NnePBo6i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgAJLQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 06:16:28 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46242 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgAJLQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 06:16:26 -0500
Received: by mail-io1-f65.google.com with SMTP id t26so1640570ioi.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 03:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E0kTgke7i7no5YSGmsSsdd4ls6keOfUqGJvkD2ZqyfQ=;
        b=NnePBo6iCOPCCl8M3uUdxEi3EwgCfLxTravxBpRnXZlApT5tkOTYTwa5YdVOdf7Hqr
         InO7lLE8tbhmVGA1ABlD/sztCr/eIMOczIR1fivwLrjTlnuDqqwhfKKtW8tvpugFxWmg
         GNWAbWWujCvRjDbYEgDo7yrXAnrF7U7Hadn/or4/SYCnqQufiOsdeyAjytF9tveiYn+f
         oWbAHJ3uG61eS+jpIPo+RDY2SZBE1Gyzfup2d5vmYkV6IHtdsM+h0vWbki//QJRuoPKr
         t4U9hrqfIvz7+5UwF01sXX3QDVTz5ySaxHMVN8NN3icKAsX7aGNIo9vnQSu1nuFU4vQr
         P0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E0kTgke7i7no5YSGmsSsdd4ls6keOfUqGJvkD2ZqyfQ=;
        b=IVqZsz/yCkX5Bj/PJJaAC2YGXCu6/ZibqMNGptw5AIj8jRCfUsPOtH2LFk8JsAucPz
         xmHPtX3s2Rw9wi0IFb+uza3E4SrLQ6LjW/mmOFQWMSaAN7fDbgt19+jrdd/l0DM6Zww+
         Evv3HUryKA8RTmU2VLasK6vVF0BkcOqqEp7NrzllrzzGgiZO35hFVvTn2HR0VgyqaN2O
         gz+0YDrP7FbzIQKEloe4d/uZNsVLzKgDi7pDz2QDLmZ5Xo2ZH+1cHEoisrOh/szFwk+C
         QMNOdBnikpqr1OfaZxEHXphBcnZvtTk49h+GZxEWt7YlrLTLqCkyUJUBfmgH5FBIgs39
         fGqw==
X-Gm-Message-State: APjAAAXX8RBAZ7gYLEJQ68PZkvKVOM6j954nsPdglt7Hu8jeQPexRjyX
        6pTMH0wPleAOWtl3wzd/FZrxGcaJMSsFG8XEqvpzyQ==
X-Google-Smtp-Source: APXvYqwPTjV6sa9yurHRzaTSTH6oKZ7TDKuE4ojDTaVsHmqgvbewwCwQ+R1EOsG5qONsmgHQ1T36FBP4nbNDi2uHV78=
X-Received: by 2002:a5d:8952:: with SMTP id b18mr2031946iot.40.1578654985955;
 Fri, 10 Jan 2020 03:16:25 -0800 (PST)
MIME-Version: 1.0
References: <20200109154529.19484-1-sakari.ailus@linux.intel.com> <20200109154529.19484-6-sakari.ailus@linux.intel.com>
In-Reply-To: <20200109154529.19484-6-sakari.ailus@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 10 Jan 2020 12:16:14 +0100
Message-ID: <CAMRc=MfqRqtW=nMuKFcpLrBHYg7wwPboUEvYpj2sBXM8yWEM_w@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] at24: Support probing while off
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-i2c <linux-i2c@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 9 sty 2020 o 16:44 Sakari Ailus <sakari.ailus@linux.intel.com> napisa=
=C5=82(a):
>
> In certain use cases (where the chip is part of a camera module, and the
> camera module is wired together with a camera privacy LED), powering on
> the device during probe is undesirable. Add support for the at24 to
> execute probe while being powered off. For this to happen, a hint in form
> of a device property is required from the firmware.
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Why am I not Cc'ed on this patch?

Bart

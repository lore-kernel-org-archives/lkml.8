Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2C7C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E284820774
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9eYmY5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730307AbgF3N5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgF3N5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:57:23 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441D4C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:57:23 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id q15so510763vso.9
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IXsTiXAsxnAQJ7aitlJrFPNR2E+gaHvNeB72HxX9nTU=;
        b=C9eYmY5bBK3n7I1QkVBtkVG4XlIOsH/+tfTecqmKP/PA7GTmvE02rifiy9cf0/qwv+
         /E7XPk3G+YDeNrA5Wox+IMB9FQ3t0Yq/zsNLOG+1gSyATVCGCOhwpO1OJNgz+EpUM5wy
         k5vrRS0Xjq1cEJ286CYFwz/L48zFt8HWdzcEDx4ElugaE+8f2cGgzLyGsoeYkVzpRYqR
         6vEFBBgMRmBUSIiBuG0wr6sL78LAO/VPRl5DfWhvq5mse+97ItLvRp1icW4ou/1aLeoG
         E9ZhxRd+q1NSp/Mgz1gMAr9axYLMtFjz+8CUTsM+RfiBnYaMjRLu07ujsTAXblaH1sPf
         E/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IXsTiXAsxnAQJ7aitlJrFPNR2E+gaHvNeB72HxX9nTU=;
        b=E+jhDMGjRPBC9jSeigrfTkgrBccqcZAsHOhyYp/YUDUqrY8sKttD9mZfRNt72hYto9
         5QdyhIB7p+oBRTvjdNJPzjEiMzXNlBi3m7TyoO7Ecc7y/ULEWdFAKTWehYiGSko9rKn3
         Hjp5pX6CZbaUV1QRJ6UFogRBqqIpsnAow3hioqbKcdyi+v48w3ct2cHseNiHKn7jl1Mi
         lizAvumAzbbXTuDjDIRVQdmJ6c20aUxkkMw3mjR9vpn0AVmA5rwHwUfKD3UJPfzfaIYk
         3AvrT0rs6LsZlZbt5GFriI60X9gmHIoo4w3mSvH0n0NQlqz958b/+0Rx5opQYMiu7sri
         4Qgw==
X-Gm-Message-State: AOAM533QBTueQOc8uJQtdMlfFeVgt2YRTkJ05MsIKXiVxqc3YaaGDuS1
        5LLc0gVKd3Z5iM6+4EAr7VBnrLNfYzP2CKe882U4HG1s
X-Google-Smtp-Source: ABdhPJxYdZesGM942m5nkqwKRgVx8vQ4qhHIStGCrXYWPNlfvv/s/yKz5pZJRbpOD5jg172JEzHYQkInA3wEW+SSU5c=
X-Received: by 2002:a67:5cc6:: with SMTP id q189mr4885554vsb.3.1593525442442;
 Tue, 30 Jun 2020 06:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200629225932.5036-1-daniel.gutson@eclypsium.com> <20200630085641.GD637809@kroah.com>
In-Reply-To: <20200630085641.GD637809@kroah.com>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Tue, 30 Jun 2020 14:57:11 +0100
Message-ID: <CAD2FfiHHb=yA6MRsw2rPyJinthhFPNH2k6sLbthxcYVVaX5Mig@mail.gmail.com>
Subject: Re: [PATCH] SPI LPC information kernel module
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Daniel Gutson <daniel.gutson@eclypsium.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alex Bazhaniuk <alex@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020 at 09:56, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> Again, which makes it seem like securityfs is not the thing for this, as
> it describes the hardware, not a security model which is what securityfs
> has been for in the past, right?

It describes the hardware platform. From a fwupd perspective I don't
mind if the BC attributes are read from securityfs, sysfs or even read
from an offset in a file from /proc... I guess sysfs makes sense if
securityfs is defined for things like the LSM or lockdown status,
although I also thought sysfs was for devices *in* the platform, not
the platform itself. I guess exposing the platform registers in sysfs
is no more weird than exposing things like the mei device and rfkill.

Richard

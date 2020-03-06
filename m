Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C1C2C3F2D4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 06:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBF62072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 06:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgCFGkR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 01:40:17 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44405 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgCFGkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 01:40:17 -0500
Received: from mail-wm1-f69.google.com ([209.85.128.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <chia-lin.kao@canonical.com>)
        id 1jA6ec-0007AZ-Qs
        for linux-kernel@vger.kernel.org; Fri, 06 Mar 2020 06:40:14 +0000
Received: by mail-wm1-f69.google.com with SMTP id p186so264215wmp.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 22:40:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EpKnowuU59lPtoZuyG1qUEH+kEQ22uKgOl7ZuBWQsiA=;
        b=Ze7N2OJW5nFl9aawkrlCpywu98zCH+Y1coN3Gs7m8l4aWEvpo4P1KbEtxf2/T/KKvk
         GS+F1+kUjcRciWgvilbjc9yjbBMcCc5B5Vsgz+8zzcmIoW983joA8gfIsumcdyXbfYPl
         hy7y7Op2cBU3uWtNSi6aoAXFZ+xCy/u2RZDStjgWUHubFb06WeFMqdlsxCOI4CfFH2MK
         SbH/MvVFEj1vOgdoRQQiXKs4mqnZDAP0YgVnIQdQiXKzWt8rVn0y2BdI5nQblz/w8glj
         zDFSz/BfqpPV0ZJNcfeadx5Ztljx4xfaLNo459+VFHStNVq7P63sMxIESKdHv9W1VObB
         vGUw==
X-Gm-Message-State: ANhLgQ3bJG0y7vchifmCyDIVfYBqyqOXAYB8IujY5rbHfjphB9NHDdQC
        jdmP9oZjvzZcv1e9bbT5nTSf13XbM6gbPBP/m+9FsScTFPlYPVr7p+5MW43By8So1y++8lejCTI
        HDxViOiqujjWN/ppA8K2VIop9f05qYI4/wTKdzF5HvuXz5g2q8FwoJp9q/g==
X-Received: by 2002:a5d:4c52:: with SMTP id n18mr2392147wrt.403.1583476814527;
        Thu, 05 Mar 2020 22:40:14 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtW31iSGk+adXSK/Yr7Qi7q8DHETQMzekXTWHtim33Iv76ZWOnxUcuVVs8w7irYklXu27ruDt3hjgo/EiwdBc4=
X-Received: by 2002:a5d:4c52:: with SMTP id n18mr2392114wrt.403.1583476814289;
 Thu, 05 Mar 2020 22:40:14 -0800 (PST)
MIME-Version: 1.0
References: <20200305064423.16196-1-acelan.kao@canonical.com> <20200306041642.GD217608@dtor-ws>
In-Reply-To: <20200306041642.GD217608@dtor-ws>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Fri, 6 Mar 2020 14:40:03 +0800
Message-ID: <CAFv23Q=W8-hafqBkBeT0HXGBb6kJC=1dHwnGv57=Z3NTOH0-6w@mail.gmail.com>
Subject: Re: [PATCH] Input: i8042 - Fix the selftest retry logic
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-input@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

We have a Dell desktop with ps2 addon card, after S3, the ps2 keyboard
lost function and got below errors
Jan 15 07:10:08 Rh-MT kernel: [  346.575353] i8042: i8042 controller
selftest timeout
Jan 15 07:10:08 Rh-MT kernel: [  346.575358] PM: Device i8042 failed
to resume: error -19

Adding this patch, I found the selftest passes at the second retry and
the keyboard continue working fine.

Best regards,
AceLan Kao.

Dmitry Torokhov <dmitry.torokhov@gmail.com> 於 2020年3月6日 週五 下午12:16寫道：
>
> Hi AceLan,
>
> On Thu, Mar 05, 2020 at 02:44:23PM +0800, AceLan Kao wrote:
> > It returns -NODEV at the first selftest timeout, so the retry logic
> > doesn't work. Move the return outside of the while loop to make it real
> > retry 5 times before returns -ENODEV.
>
> The retry logic here was for the controller not returning the expected
> selftest value, not the controller refusing to communicate at all.
>
> Could you pease tell me what device requires this change?
>
> Thanks.
>
> --
> Dmitry

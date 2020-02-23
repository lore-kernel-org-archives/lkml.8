Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ABEC35666
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 17:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0D5C206E0
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 17:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q85srHue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgBWR52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 12:57:28 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39238 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgBWR52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 12:57:28 -0500
Received: by mail-lj1-f196.google.com with SMTP id o15so7507485ljg.6;
        Sun, 23 Feb 2020 09:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X4wMgbKJ5j4RGuZPikaFN+tz5pMB7rGvOfpwi9N1J1c=;
        b=Q85srHue5n2Ero/Bf8/TxmJFAzRy5NxD9cyZhzL6V/kSpEoPA9fDLuC3ssj9aXRy11
         VKWp8o6gbZygtoodNHI9CjKfpJ8BfBcV0CPEShfkdynz/ZCOqcGTrkZiMdL/z/v1F1/n
         oPZeBo4WNLCYJ7RTnOrA7/DflFNpd/npl74uaJSu3tuuJsV9WhgjAEVl7o2Zjf9w9Mlv
         mSVpcLESqJHpT22/zElCNBKTbUE9PqK/trPaYleM+iQXrKez9l8ixJSgaxYQ2jcLU2TA
         vW89/al7sgqu1GDloqkIByzqrOtmrycDC0ZcXTvDxPHtWQOMSVcPKw8DP2qBVD4NY0lB
         I+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X4wMgbKJ5j4RGuZPikaFN+tz5pMB7rGvOfpwi9N1J1c=;
        b=iwp2igMLV/ZZAHNfGl4+KJUo6K10Lhcb9qsSy55LmlmTlXwszVBc/+SB15/ajq7noO
         NEsngVpAlQcoNL0ObOR9eyjIonEpl/pWaduyZQNxCPLCil50DCs8zoXwZnxBMyh6s+0r
         EeiKihx9nZw9qEok49aRhCRifMtrTwfhmh8vuLOmI5OkxCORpwIRVH14aZ73ZGO2nt2+
         4c/qoAK9vIsTa80I+5oXzEaHtnj8E6czuWhhyzYP9kVxIyXnmYD+ee+F/Ay9mpU4pk8S
         uELXko8l/m1SpjCsSUw9RuwAqHlK3WMiBxqz0jbRu/9/+P1sJsOaHrH1jEBtrgj8xDzJ
         XY9w==
X-Gm-Message-State: APjAAAUBbMl+HYj0FAmRpLXJl5W8FhoXtIv4tslAogImVePmCvBVPj36
        SrNbhG/ieh7S4de+r1BwbufCftpYE2jC4W1AtQ==
X-Google-Smtp-Source: APXvYqxhOrZc+k4I0OjrO/lEd2pDJb18ypUruamx5T9p3bLL6lERG65aIAkYcEIK5j5ne9ezpWg1+6lkp2H4UZx/hHw=
X-Received: by 2002:a2e:86d6:: with SMTP id n22mr26255146ljj.77.1582480644237;
 Sun, 23 Feb 2020 09:57:24 -0800 (PST)
MIME-Version: 1.0
References: <CAM1AHpQ4196tyD=HhBu-2donSsuogabkfP03v1YF26Q7_BgvgA@mail.gmail.com>
In-Reply-To: <CAM1AHpQ4196tyD=HhBu-2donSsuogabkfP03v1YF26Q7_BgvgA@mail.gmail.com>
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Sun, 23 Feb 2020 18:56:58 +0100
Message-ID: <CAEJqkgipp7ZSerdsqpJKvrfuDQUSYFoUvYwjWCRRA2QS_8Ye_w@mail.gmail.com>
Subject: Re: [regression] nct6775 does not load in 5.4 and 5.5, bisected to b84398d6d7f90080
To:     Martin Volf <martin.volf.42@gmail.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sa., 22. Feb. 2020 um 12:13 Uhr schrieb Martin Volf
<martin.volf.42@gmail.com>:
>
> Hello,
>

Hello,

> git bisect found out the first bad commit is
> b84398d6d7f900805662b1619223fd644d862d7c,i801_probe
> i2c: i801: Use iTCO version 6 in Cannon Lake PCH and beyond
>
> Unfortunately I am not able to revert it in v5.4 to confirm it is really
> the culprit.

I don't think you need to revert that to test, just move back
Cannon Lake to use iTCO Version 4 in i801_probe().

Something like this:

https://crazy.dev.frugalware.org/CANNONLAKE-use-iTCO-ver4.patch

BR,

Gabriel C

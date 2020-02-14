Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291D6C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 10:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2F220873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 10:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C7y7H4jy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbgBNKQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 05:16:52 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46565 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729162AbgBNKQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 05:16:52 -0500
Received: by mail-lf1-f65.google.com with SMTP id z26so6357886lfg.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 02:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vmPFCYNd1b2Z269i3yTjn10KuJ/1yAN0FqONO4h3pYM=;
        b=C7y7H4jylEuEqMnGjgmT+H0M+h+femEJMIBzMgfB7vWd7xinxGtIWg5hjzVf97k5By
         81ichhlUxUcuE+gpzED+ObhW/gJUHJCXo9IIp0boG22bOraAX3BiBoHIYn9P8GpiYb8Y
         QRQCmU1ymbZCh4V933PSIeteImHsjiS8L3DcSHjmaCO869J2GUR2ocJ3uJW3Vy0CZvjo
         /SYd2V8GNZmLcti0/RWd8v9JbipZczwBq2DRNBnUskpwoxjESHOuZtbINP1ZI+8y/1XW
         kLzA7hV1HtTwhzhSMGIt+CelSr4UakLg/+G+0mSoxzCNAUYw2DrXYG8T4gXZjRjCKV+S
         m9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vmPFCYNd1b2Z269i3yTjn10KuJ/1yAN0FqONO4h3pYM=;
        b=IVpP3gO1PJHqevIJe4ik/Va+8MtX4hPeJgFRjODWoP21GuVdUug7tHbP1Kb8IOnVgl
         rnIZdpDWqt9Am+I7ETuaSslVOd0VHFinh++SLsdzHYdOvr906EYs9gcettn9E6BHuna3
         8QL/8tAfAExdW/BKUxpnyFH0yYdKezjCB7nXg3bWhgBO/vG5WwTPKL0mj7JOaBztCvuQ
         bskqIG40LTkQf08nh+Qg482Rw/NBOE1qepZshIJBOjdtBxjTwJMtgTKkOlu5lihafpFv
         cjHWHiucjioXpylXAl5yEzpLKeF7rYSdwmv9nMgHuxlmzPMUBKpT04PooJpwjRXhdskg
         Ucdw==
X-Gm-Message-State: APjAAAU3u6/D7ynAHAVub6yS3rBkNaEJWeB7lVMI6qEYNwPUKXIoSBGA
        EvxGimmw07lMGpUjkY+zKc/JYqLeEzjt2ZVc/vL2Zg==
X-Google-Smtp-Source: APXvYqy3A2UvE/PunEwc9b95paj1uRKlANgXjihOMn+iQGFlsaa0yHC/L21T4dFZZ7k9amkC+MY+YUVX95o0/o8skaU=
X-Received: by 2002:a19:dc14:: with SMTP id t20mr1309882lfg.47.1581675408867;
 Fri, 14 Feb 2020 02:16:48 -0800 (PST)
MIME-Version: 1.0
References: <1579439601-14810-1-git-send-email-sricharan@codeaurora.org> <1579439601-14810-2-git-send-email-sricharan@codeaurora.org>
In-Reply-To: <1579439601-14810-2-git-send-email-sricharan@codeaurora.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Feb 2020 11:16:37 +0100
Message-ID: <CACRpkda8XLZxqH9CROHUYpaq8z+z2zsdg8pyzqQ9DfavGMy6QQ@mail.gmail.com>
Subject: Re: [PATCH V6 1/5] dt-bindings: pinctrl: qcom: Add ipq6018 pinctrl bindings
To:     Sricharan R <sricharan@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        MSM <linux-arm-msm@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, sivaprak@codeaurora.org,
        Rajkumar Ayyasamy <arajkuma@codeaurora.org>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 19, 2020 at 2:13 PM Sricharan R <sricharan@codeaurora.org> wrote:

> Add device tree binding Documentation details for ipq6018
> pinctrl driver.
>
> Co-developed-by: Rajkumar Ayyasamy <arajkuma@codeaurora.org>
> Signed-off-by: Rajkumar Ayyasamy <arajkuma@codeaurora.org>
> Co-developed-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> Signed-off-by: Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>
> Co-developed-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---
> [V6]

Patch applied  for v5.7 with Rob's Review tag.

Yours,
Linus Walleij

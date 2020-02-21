Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07696C35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3631222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LrtzUHsh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgBUNra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:47:30 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39182 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgBUNra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:47:30 -0500
Received: by mail-lj1-f193.google.com with SMTP id o15so2252223ljg.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 05:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6RiDIgBnM17s0MhdLFdue8lQDMd7IU/QHmr8wXGck+U=;
        b=LrtzUHshefW35GP6ZfEoYXl7PU7Ew/G3Olj5e9FBDEm0N0uRMbD106U333sP+XdFGl
         oKIZmvtCNOzaLh17pnvgyRA9+mFeV7G+9zCVGN0pjQV4Y6p/E5NGzkm9wYYrevaEQjpH
         ejXx6bANY0OhMZKX5OJROiRHYzuvZONL0JDjbAp3mz/MMI1EqSr30aiIXqeP7kOVSXWj
         EOhrQ/o5tEXWomMLfszjof3ypPYs9bKQv/l9AgrwdmLRkYA9mvJuvmRj7Qgwl/h/viag
         DdLp7ObOU0eqfNlWn6lSSo0GUTsCIW+Bmq7+zPEFXWsJrqPGQr0cUm0eWkN6FTONdaeK
         chrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6RiDIgBnM17s0MhdLFdue8lQDMd7IU/QHmr8wXGck+U=;
        b=USFVG6ygO5Ywy3OSLnyAeW7CKeyn3X5srPzwEbx26KAdE+mrKJGdJxcX0T0UzG509u
         MM+Yh9tbc+No8RUzxAFm+iELLi9bb/GUN3YX7Rzj1ZRyMQobd99G4yWczHTN50CGDQHQ
         woHKYtUHkTxV2AZQBcLnKPKvodtEhpROgUiZuP1gv+It5xar5SzrVjH703pjt/2CF6Jq
         FsNIHbKOZXQMzVeuCDi9cA9ll6zJif9UdRL1yHObrBm2q+ugh+A7FrLDsGTwpVIYNfYi
         20ogKi0bLC04q7pRuQ85wWDfyRD3gkiEbXK5LS/F8mXLxjMXlrXdKKE1CAWyNw9mD0ko
         8V/Q==
X-Gm-Message-State: APjAAAWNwO/5++RqHoZD5j/e30ycxyj2uyULxCtdTcxc8KzLzF+g75VY
        tTuSnxz4vzKFJ/9dbqg3P1Ug2a8C4/K3cMQhUjfhRg==
X-Google-Smtp-Source: APXvYqy0v9gcI71kNOOkUK7oygUEUPyQ1/Vc5JOaBADO6tiKLQPSAXDQnjesGOK/oFE4d/DSEaPhvt5lW2ObMIsj1nI=
X-Received: by 2002:a2e:2a84:: with SMTP id q126mr21375720ljq.258.1582292846656;
 Fri, 21 Feb 2020 05:47:26 -0800 (PST)
MIME-Version: 1.0
References: <20200125113355.GA22220@Mani-XPS-13-9360> <20200214071856.197028-1-matheus@castello.eng.br>
In-Reply-To: <20200214071856.197028-1-matheus@castello.eng.br>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Feb 2020 14:47:15 +0100
Message-ID: <CACRpkdYbxCi3WGq7WBWVHmNmGSaWO4=VrxruBy87MKLK0464mQ@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl: actions: Fix functions groups names for S700 SoC
To:     Matheus Castello <matheus@castello.eng.br>
Cc:     pn@denx.de, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 8:20 AM Matheus Castello
<matheus@castello.eng.br> wrote:

> Group names by function do not match their respective structures and
> documentation defined names.
>
> This fixes following errors when groups names defined on documentation are used:
> [    4.262778] pinctrl-s700 e01b0000.pinctrl: invalid group "sd0_d1_mfp" for function "sd0"
> [    4.271394] pinctrl-s700 e01b0000.pinctrl: invalid group "sd0_d2_d3_mfp" for function "sd0"
> [    4.280248] pinctrl-s700 e01b0000.pinctrl: invalid group "sd1_d0_d3_mfp" for function "sd0"
> [    4.289122] pinctrl-s700 e01b0000.pinctrl: invalid group "sd0_cmd_mfp" for function "sd0"
>
> Fixes: 81c9d563cc74 (pinctrl: actions: Add Actions Semi S700 pinctrl driver)
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>
> Thanks Manivannan for the review.
>
> Changes since v2:
> - Mention s700 SoC on subject

I already fixed up the subject and applied :)

Please check the result.

Yours,
Linus Walleij

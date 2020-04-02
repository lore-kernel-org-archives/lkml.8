Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2BB4C18E5B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94536208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ACHfzrKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387613AbgDBHkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:40:19 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41998 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgDBHkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:40:18 -0400
Received: by mail-lj1-f196.google.com with SMTP id q19so2127226ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 00:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wxvF/+u7KELI/jIBwkyObWmgPCHKCclGo+byqnItBfc=;
        b=ACHfzrKps1Y4qZ9YwaFZz454GAI42WKp0MnKRH+8uzjnzI0AVl1GPC/yTcGOrmSQT7
         WwN6Lov4ZzMLjFKKNJHUAFzcJd0+Jonx/0LeOu4FWrjASmB9WAZzy9dKY9ldaKMWqXZC
         ZGAbfVQlR+9zU1P2eWd6rzDyyv9o1jkBqBs4xI8Ifbk6tT8lIXjGA+EL06SSRftkz9fF
         prWVWRQncTwRVneP0UDZZkl/58ymlrYkh5+MCxr6f8td2KYmIhhEzD8eBEjqUQuw3rjk
         2iHeZMh5rcmxyNZL9T8vMI1Q4JAMfFlYyYNtTJe6U0cN/uUYSOHDPCWNwWU0OjaqKSXX
         eWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wxvF/+u7KELI/jIBwkyObWmgPCHKCclGo+byqnItBfc=;
        b=brpbfR23FD6gf/0hkHC0PBNr15YKeoS82NV4QRnu4/RO2OjFPWrQnKoPoHT+vSZdeN
         LvUWrNu9AGDzsh9DsBoxEgnlLuHHE/ECxem1T+6oHh/vTGanFr00R6jiTmsdMXDP00fT
         W+9Gq2SOZ84hSGUYXDOPeN9AQA535RcVuo2duBtzVIuLly7yMp1LhkVrPPi/+lvihdlg
         e2L+n9avBFDlYMlWYNQrpDRUHwJqLsmDHb3yWCFc0HtOsO1mSW0n6W/7X1Xp8FWIGl2d
         q25hyDpRYMRnE0zUpWabynXyp65XX7a8nCyeZ655mnaYVKuyf55/PChlznfDRR8gSCy3
         2Cpg==
X-Gm-Message-State: AGi0PuakmuOhm9+nki6703NWzgk/KekwGjCDTxStzmKUL4wUSXNuqNUn
        N/SlrNFfaQJoroXVt/PTo6cT72veq17LIOlIPT2llg==
X-Google-Smtp-Source: APiQypJQrw2kGNxUc8CNT6NNf1617H7vjAW0LBY33E65eACRmhGlNj1w5ZKMZP3jhOmVn3FO45GGUDWdSL461+AF6lg=
X-Received: by 2002:a2e:5048:: with SMTP id v8mr1117658ljd.99.1585813216416;
 Thu, 02 Apr 2020 00:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <8d3579f4b49bb675dc805035960f24852898be28.1585734060.git.baolin.wang7@gmail.com>
In-Reply-To: <8d3579f4b49bb675dc805035960f24852898be28.1585734060.git.baolin.wang7@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 2 Apr 2020 09:40:05 +0200
Message-ID: <CACRpkdYYsPKFBKPVXHa-k5jmQ_8BPfpqmWAUNfSNzar+CedXmA@mail.gmail.com>
Subject: Re: [PATCH] Revert "gpio: eic-sprd: Use devm_platform_ioremap_resource()"
To:     Baolin Wang <baolin.wang7@gmail.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 11:59 AM Baolin Wang <baolin.wang7@gmail.com> wrote:

> This reverts commit 0f5cb8cc27a266c81e6523b436479802e9aafc9e.
>
> This commit will cause below warnings, since our EIC controller can support
> differnt banks on different Spreadtrum SoCs, and each bank has its own base
> address, we will get invalid resource warning if the bank number is less than
> SPRD_EIC_MAX_BANK on some Spreadtrum SoCs.
>
> So we should not use devm_platform_ioremap_resource() here to remove the
> warnings.
>
> [    1.118508] sprd-eic 40210000.gpio: invalid resource
> [    1.118535] sprd-eic 40210000.gpio: invalid resource
> [    1.119034] sprd-eic 40210080.gpio: invalid resource
> [    1.119055] sprd-eic 40210080.gpio: invalid resource
> [    1.119462] sprd-eic 402100a0.gpio: invalid resource
> [    1.119482] sprd-eic 402100a0.gpio: invalid resource
> [    1.119893] sprd-eic 402100c0.gpio: invalid resource
> [    1.119913] sprd-eic 402100c0.gpio: invalid resource
>
> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>

Patch applied.

Yours,
Linus Walleij

Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A61C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8998B20663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QoHbF8n+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbgCSW2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 18:28:08 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38194 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCSW2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 18:28:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id w1so4380836ljh.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 15:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cPY4yGqsVmjSkC4+Qbn00vPfMkEqDvIIRfhbCdPDITY=;
        b=QoHbF8n+l3rljrBdRj0dazA6824Cz9+VSZknbiL+/2NpUNn690cGYbD7S+o3C1e8aE
         vBP2xhwoSg58MlOtwVLxDh0YWkhMAcFG8rP/BYCzP1LN9hHsfrbol4hp3EyknXU5dVwv
         +odiVUrsoezd/JzIfZCRo6ZuEVZ0QEdd4tVp+Jz3KbjF0Ip2jnZDiHqNWCLQv5ayFpC4
         +Vdwm3wEGXBJtd3Ynh0bWhZVcclkjNHwyBSeZoP6drr94bcDXViEixPNN4nV2gpIKTcB
         9olUrxUWP0QkC69sjbGZLqnO+ZxhnkuTU5hXFfQyZntqH2kTbEiZRUCDZ7otDUcgYcR/
         Pjpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cPY4yGqsVmjSkC4+Qbn00vPfMkEqDvIIRfhbCdPDITY=;
        b=YCcbZVup2A5xDUb+Ym9AJGcGObImYQ1rcs0xBadkQrmJFqabomW0xGZWc3A5PRQxYG
         cj6FB5ZW4D5TEhLQJA1ptS/isL6CGNesegAbKkzVE/Y+FR+/plL7E+K58PovKlN5Y7kQ
         Hr00NmU2+6yGmS71+z02stQ/FGQifEMH7JJkGoFk1BIF2/zcW0kKkE5CTEkFc+6JEjbh
         BKErpjzRLckEzkO961NY1MqEadv0MeD0LSYF3R9782Y9Uecdxb3zop8dGH2GfIoqa2lX
         NEVsW5zFPAncnOplT6rZLBQTluB8obPQCK6b2MtiWxVWZLXxiss24BHT86j4NgY+buK8
         m6/A==
X-Gm-Message-State: ANhLgQ3bXNVd/nhWhjwoSKJ5GnOHB+U0AjIXM0Efzf4QdGoywmPO3r6A
        73bJ9bkWKe7+sOrI4nYbsJgyBExXmpr6spANnDLgcw==
X-Google-Smtp-Source: ADFU+vvOtD5TXrE6/8549mbEx43NTzKslm4CnrZBFrIbNGPMBdllKCIDvnPzK7abXAKB9AL0q2OIRRVoGn2ouVBUiL0=
X-Received: by 2002:a2e:9a90:: with SMTP id p16mr3552497lji.277.1584656886019;
 Thu, 19 Mar 2020 15:28:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200319123926.466988514@linuxfoundation.org> <20200319123926.902914624@linuxfoundation.org>
 <20200319133355.GB711692@pek-khao-d2.corp.ad.wrs.com> <20200319134710.GA4092809@kroah.com>
 <20200319144753.GD711692@pek-khao-d2.corp.ad.wrs.com>
In-Reply-To: <20200319144753.GD711692@pek-khao-d2.corp.ad.wrs.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 19 Mar 2020 23:27:53 +0100
Message-ID: <CACRpkdZcAR-XeJ34MSBqebAGB+ycHZN7i=KE9LHExW6zH2XMLA@mail.gmail.com>
Subject: Re: [PATCH 5.5 01/65] gpiolib: Add support for the irqdomain which
 doesnt use irq_fwspec as arg
To:     Kevin Hao <haokexin@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 3:48 PM Kevin Hao <haokexin@gmail.com> wrote:

> Yes, this commit does change the context of commit f98371476f36 ("pinctrl: qcom:
> ssbi-gpio: Fix fwspec parsing bug"). So I am fine to keep this in order to apply
> f98371476f36 cleanly. But there is no really logical dependency between these two
> commits, so another option is that we can adjust the commit f98371476f36 a bit in order
> to apply to v5.5.x cleanly without this commit, something like below. IMHO, it is more
> suitable for the stable kernel.

Thanks for fixing that so quickly Kevin! Much appreciated.

Yours,
Linus Walleij

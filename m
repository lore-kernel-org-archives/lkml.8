Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D12C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 21:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74792206CC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 21:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQn/C086"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgCFVFB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 16:05:01 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34556 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCFVFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 16:05:01 -0500
Received: by mail-lf1-f66.google.com with SMTP id w27so3028535lfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 13:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SCh5Ql6HsRbnpc5kyjGeCT+pabUAu/H2bKHYVfo8S94=;
        b=mQn/C086+loWZJWS11eH2w856sE1z4a6BNZ8EbGa34HEUBitdARVz+grDjXyWvYmOC
         ioRA05EJaXqWjHy7pt5GK+wS+SDi5iLcdUtip42dxVuCb9MZ4Thvq9vyIGbAEyOmg9Jp
         KWS8fTtac/F3TtmROlWVfPlJj6ooaaVQ/E4SBlSbfEDtHtn0KWppJQF4l4iFWuKLc0Ez
         ANyoyRiZ3dz+Yw0nYdOmThBUSryW2XFOjCkgzNbTS3AR/F5fwDx02bSGBe7sXYm0v93M
         zfxb7gPab9q0crF3to/0yqNaQT8mHd2ZF4wW2+IUdd+yk0OemRd9MgXzCOwZXQW7r4uX
         ANyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SCh5Ql6HsRbnpc5kyjGeCT+pabUAu/H2bKHYVfo8S94=;
        b=g9NWFD0KaQFw0hnLaRqsGG5AGCuBIQwuh5tmcptFUo2EaiHxHNgPD/B3NIUe/RoWxf
         /y7Ssi/ocMs22ZWKGEM9TUjVkr22RmSMOUmbe8Om4PPsLlOM8N34CcLa8l2T+Jl/xLr9
         yxt3e94tevBDpeVR9twWTfe5SIlabXek5Rfzm+MNm2AsWTEIgkqygWMwrTS2zJO1axfD
         w3VY0x2ZTJVUPxYq685CPVRG4izzSs0zfxCWkGnx9aOJrNflov0Fybb1QQ1IcDrbgFyp
         Bti1Z19BwzsEWXwSV+Cj077bixL9P0hlyxdoi93xlMSH6hzmrP4DTFLb281OLEZGQ94H
         D0Qw==
X-Gm-Message-State: ANhLgQ28qE173Q/htE6wrpMaQXXHZjVIwZVlNcnWk8+BCHkXPOEhn75G
        fydHmFyLSBmZyakac1qiaqa1BlYCyJcoItZo2Y4=
X-Google-Smtp-Source: ADFU+vsw0OZhhLVmX/IfKdDdSH7HO11gOQ9uTLgPFqxD/IUA8zEDYaIP9iPsglI3ZjxvplyRmcjdRV9JJPsfqmABV3A=
X-Received: by 2002:ac2:50cc:: with SMTP id h12mr1661206lfm.128.1583528699030;
 Fri, 06 Mar 2020 13:04:59 -0800 (PST)
MIME-Version: 1.0
References: <1574306441-29723-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1574306441-29723-1-git-send-email-krzk@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 6 Mar 2020 22:04:48 +0100
Message-ID: <CANiq72kLYDEN3W30M_FFfJmz6c4-EqAAFEXmXYnwc2STr0bJYA@mail.gmail.com>
Subject: Re: [PATCH v2] auxdisplay: Fix Kconfig indentation
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, Nov 21, 2019 at 4:20 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Adjust indentation from spaces to tab (+optional two spaces) as in
> coding style with command like:
>         $ sed -e 's/^        /\t/' -i */Kconfig
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks! Picking it up.

Cheers,
Miguel

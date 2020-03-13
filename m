Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5850C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5BF206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ee5U9Uz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgCMRic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:38:32 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40633 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgCMRic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:38:32 -0400
Received: by mail-ed1-f68.google.com with SMTP id a24so12879373edy.7;
        Fri, 13 Mar 2020 10:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R3dyNr4k5uWyS12uYVE6FnBN9I0mOgh5neR4n7Md79s=;
        b=ee5U9Uz3MBtT6Nz8t621V9cJN5wg3+7ZOmT+cjtjz9yVgKB6xgHYYRybpm0tjQ9QFW
         UGcjiprG0XDeCfpQbAFG3voJF42p6Tz15VbiqWg1ueGEmyyZ1wRpScmPVSclQ1Wo59Cp
         ig37pPj54xRLrAg5Ne+sMfrmKMbHCRItjmSra80vHh0cwjoHwx0JF00QJDe5Erhe5Kr1
         tTLxmCmwU71NpDntU9u6MzMCayInnzI7hiMNZfnfHdJDmESGEqGaMwasHrNoGnvcgC9U
         EeSrZgB7hscZD4CSfsB8PAdy+S1PbcjEjInySA6+4S0CDDeh7bTQcWiHUb32n41DthI7
         Px2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R3dyNr4k5uWyS12uYVE6FnBN9I0mOgh5neR4n7Md79s=;
        b=HYmRA4Tf+fjvicCzGBy7c76+m3SwRNDYqPOOcX7R3MzxMf59eg/Yno/w70PQYPUXH+
         d0eckgvheyhblmoFe4C/rd/9cpo8atW9dvDCr7bcnPAE7D7m/dpE3DKQayS1rpuGumTb
         EorfSsMzKgR1ZsfDM3n0rHPc9kF3OEtaIgdYh52WqIefJbk2+IAnIVfyjCntpZK3E9oh
         PItVbzQm4XYKmoW8KoXG6m3OhhJB+5mrjIAkmGs6n/CiG2ojL9LguUa8qnVC0SmbNR+F
         bjTh3Uy4ho3cPZHMbInBqop0kJGftwA5dFvoYYYWwcyOG1yOIpT42s5AzN4btXDzey14
         FQyw==
X-Gm-Message-State: ANhLgQ3VazZR6RuaImf8PHRbKBdnDzKgpyqRkqYEQ/tHJOYVz6vLtGj2
        ++EPcO9FAdmLyPr2RuBfH8mvSUDg1qTvR3jisvY=
X-Google-Smtp-Source: ADFU+vssY/N5sa0mg9a2KokRXIjoibkrN8m75YmXHtI7GyTMSTlWJ7b7VArj6jSyBMrODAOmFom6VKOCGt2GLlpPREw=
X-Received: by 2002:aa7:de85:: with SMTP id j5mr14292710edv.193.1584121110187;
 Fri, 13 Mar 2020 10:38:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200304005209.5636-1-afzal.mohd.ma@gmail.com>
 <20200305130843.17989-1-afzal.mohd.ma@gmail.com> <20200313124821.GD7225@afzalpc>
In-Reply-To: <20200313124821.GD7225@afzalpc>
From:   Matt Turner <mattst88@gmail.com>
Date:   Fri, 13 Mar 2020 10:38:18 -0700
Message-ID: <CAEdQ38E2VEK=XZySOdm=zPj6dAOf0FuzuS39Y+AYTFVctB6zuw@mail.gmail.com>
Subject: Re: [PATCH v4] alpha: Replace setup_irq() by request_irq()
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 5:48 AM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
>
> Hi Richard Henderson, Ivan Kokshaysky, Matt Turner,
>
> On Thu, Mar 05, 2020 at 06:38:41PM +0530, afzal mohammed wrote:
> > request_irq() is preferred over setup_irq(). Invocations of setup_irq()
> > occur after memory allocators are ready.
> >
> > Per tglx[1], setup_irq() existed in olden days when allocators were not
> > ready by the time early interrupts were initialized.
> >
> > Hence replace setup_irq() by request_irq().
> >
> > [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
> >
> > Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
>
> If this patch is okay, please consider acking it so as to take it via
> tglx.
>
> Regards
> afzal

Thanks afzal,

Acked-by: Matt Turner <mattst88@gmail.com>

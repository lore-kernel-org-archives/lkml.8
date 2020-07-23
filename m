Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056D2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D190F2065F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 19:04:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BL5e+goq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgGWTEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 15:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgGWTEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 15:04:52 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60746C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 12:04:52 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id h17so5970857oie.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 12:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nrteQfeFB1VOMIeZKa5j2Y8sJhqxd3Xa8dyvGy8bAxU=;
        b=BL5e+goq+hZCtnlyH8gKGW2pUUKZnCxZVFQySWnhl2lNq3a/VLbAwSRg99Lde1dev3
         Yu7DwmtVZmCjceuz77oJnaxPOz+WcOdmgfpaD2JESWKx6kdEPJTAVgXgaGlwhLe2Ypi1
         Vm3I3lRnEmRdWmXpRFmWO1K3BQWswP2E4v4FjQaU3edA4Ce6BR0Tmthqo50550H7oXxx
         T3OYVhuCFwzg+rMgj6H4robhcQDEXwTfWtq+tMS1F/+1x0JOjvQe6cX8aPMr1r4iIi+Y
         rIr79gj1nEoUrk4Ed1aPPzHeQASQ6g1/flWc2ea5w7UgHcbUTqB90JJorWGRDETB32uJ
         /Ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nrteQfeFB1VOMIeZKa5j2Y8sJhqxd3Xa8dyvGy8bAxU=;
        b=W6JoTcnXGjJaj+0mP80lST5D/1SmnSa+iknFtk98DaQJiIo6Xb4GpckIgU5KDY1fJp
         qxgeup2WxWgaYwd1HkTikBOP+5K1TlGucAMqeB2FLquSIIiefc9LOzOo86cpE1XHEZ2K
         PmBWikRyTJTDN6zl8eVBGg9zkkBfeyMiG0YVY7IypoKWHYq52kOuV+4Xe9qbwyET4oqD
         FYIc4ME64UiDnpLCuuW4Ze69rhYOEbTWi5GlYusUbnkiqFhbPP+cJ6imG2ntZtbnhJZO
         irDhrRuGA6SYBOBmUbcYAWHBryiVul1oQ/2i6WWWpxPE93vQzIRXJbETIKNlKwiUrrrF
         9xMw==
X-Gm-Message-State: AOAM533Vhf4GH83caWdgZ78E21prf+ujtgMxtqDgO3xd2V0pJI1S0BhL
        nY1MlDUsA+vwgk7AXZpVUZ5a/DIKvXlMUwR6uVE=
X-Google-Smtp-Source: ABdhPJyKmHZPXlHdMXUAeyHwy9OJNGA5/FEga6t3L8QLIIq8jPKaglCOPJThMcTGjHBbCpxvsS4UplgVLyDfC5m1x5s=
X-Received: by 2002:aca:57c5:: with SMTP id l188mr5237626oib.154.1595531091655;
 Thu, 23 Jul 2020 12:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200723152938.GA17799@ogabbay-VM> <20200723185931.GC3768907@kroah.com>
In-Reply-To: <20200723185931.GC3768907@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Thu, 23 Jul 2020 22:04:23 +0300
Message-ID: <CAFCwf10kNLNbeb0g8_Aujup+jAdBPGwyKODTc53iK+N0dKCJNQ@mail.gmail.com>
Subject: Re: [git pull] habanalabs pull request for kernel 5.9-rc1
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 9:59 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 23, 2020 at 06:29:38PM +0300, Oded Gabbay wrote:
> > Hello Greg,
> >
> > This is habanalabs pull request for the merge window of kernel 5.9. It
> > contains many small improvements to common and GAUDI code. Details are in
> > the tag.
> >
> > Thanks,
> > Oded
> >
> > The following changes since commit 7a4462a96777b64b22412f782de226c90290bf75:
> >
> >   misc: rtsx: Use standard PCI definitions (2020-07-22 13:39:31 +0200)
> >
> > are available in the Git repository at:
> >
> >   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2020-07-23
>
> My scripts spit out the following error when I tried to push this out:
>
>  Commit: fc83dc9787ce ("habanalabs: Fix memory leak in error flow of context init")
>         Fixes tag: Fixes: "habanalabs: Use pending cs amount per asic"
>         Has these problem(s):
>                 - No SHA1 recognised
>
>
> Your line:
>         Fixes: "habanalabs: Use pending cs amount per asic"
>
> should have a sha1 in it :(
>
> And use the proper format as well.
>
> Can you fix this up and resend the pull request?
>
> thanks,
>
> greg k-h

Sorry, my bad, I'll fix this right away.
Oded

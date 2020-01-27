Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662E6C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 07:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266C720702
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 07:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5o84jaz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbgA0H3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 02:29:38 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:40912 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgA0H3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 02:29:37 -0500
Received: by mail-ot1-f54.google.com with SMTP id i6so3581809otr.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jan 2020 23:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NfMrwB1dkIx18kXQujsnQe+a/E9cf+lBLu1cGJqqNxY=;
        b=A5o84jaz9pUdpt9W1GrwC+W/wsSbs8JVD8SXyzhWRKoxPDmYfEOJfXzJ1AFUzlub5E
         b6OseiA4BtqGKXurOGa/6GrPFjRdvI6hrON6ku9E72R9AI3tHnw4P5Xv+lkDJhegOtkm
         MSOZLqsXL//7XGAR1At5ix/PVsmYy1z2nsswZw5BD3/hGf7tppj6ts8FOX+LLHY5c7B5
         wd/PUcnEqkjel+4PuIW30WEimfAB/fIHFDTtdEs3R5rR2gVZNbjQ5Jgynh9YwE00zoxz
         9JlkfSMS/6VGVUMt81Aq6Blr/icElwPUrH/oOd9vLdF/nc8kYH3OL6bOJzc+Vj/NDvF4
         316A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NfMrwB1dkIx18kXQujsnQe+a/E9cf+lBLu1cGJqqNxY=;
        b=g4My3erx+FtP4fGwczpIpzHPfWI5y5rrPVh+ah2tr2aHizdi56qC3VMlJD4dDag3Z1
         QV5IUptghiYPtzaGznmYpQ9dWa6Fh0TZ/blzsotN3V4X0j7s7rLCaF1rcA+zCs//QZ4b
         ZfXtoX8VIioKXdyn8wyrv0vd2vD6XGZA8oD5ixp6ACLxwm3AYnayWWAXaOSFc+JxKgJ3
         E9eL97UfbXX7sFZe00Bx4zYB0J2Mle8g9fsRZu5IqVPyTkueoFk7By2O2rNnDryNhwKY
         3BmdK7QRLWy3uvwmeqvgEPFY6Ug09kB+wtb1yFy0D/3H/4s+C2AFxKf2orSLzgkIiIap
         osgg==
X-Gm-Message-State: APjAAAVyy7x8NG5EY77To2jLjLk1FGS620fGEoYLCCHyoLlgdRfP1fmy
        4R5Gq1TaSbXJpHheCKwhrWuwb5130x3sqtcpIWqBH7Uc
X-Google-Smtp-Source: APXvYqy1duEJsYsg2iN0Tu7wdJs60Lnfxv9aLCAzH7SwQE/LjloeQhS+pjVsujmpBNnMSwAJWJQggIQ0JYj2oJei3ts=
X-Received: by 2002:a05:6830:1d55:: with SMTP id p21mr11483452oth.145.1580110176778;
 Sun, 26 Jan 2020 23:29:36 -0800 (PST)
MIME-Version: 1.0
References: <20200127064007.GA12713@ogabbay-VM> <20200127071312.GB279449@kroah.com>
In-Reply-To: <20200127071312.GB279449@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Mon, 27 Jan 2020 09:29:10 +0200
Message-ID: <CAFCwf110FGemXFKgb1AyhA1ShC2dQdb1seeQF-COO=M0OMz97A@mail.gmail.com>
Subject: Re: [git pull] habanalabs pull request for kernel 5.6
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 9:13 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Mon, Jan 27, 2020 at 08:40:07AM +0200, Oded Gabbay wrote:
> > Hello Greg,
> >
> > This is the pull request for habanalabs driver for kernel 5.6.
>
> It's too late for this, sorry :(
>
> Code needed to be in my tree usually for a week before the merge window
> opens before I can add it to that merge window.  This got no testing in
> linux-next or anywhere else, so I can't take it.
>
> Feel free to split it up into bug fixes for 5.6-final and new stuff for
> 5.7-rc1 and I will be glad to take those after 5.6-rc1 is out.

ok, no problem, I'll do that.

>
> > In addition, I got my pgp key signed by Olof.J. I would appreciate it if
> > you could verify it.
>
> Any clues as to how to verify it, is it on a specific keyserver?
>
Nevermind, I managed it on my own. You can see it at:
http://keys2.kfwebs.net/pks/lookup?op=vindex&search=oded+gabbay

> thanks,
>
> greg k-h

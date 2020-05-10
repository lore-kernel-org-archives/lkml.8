Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC49C54E8B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 08:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C5B020820
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 08:35:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgEJIf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 04:35:29 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:47066 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgEJIf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 04:35:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id w7so6918902wre.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 01:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hFhG+vZs/X4tuUT4PqnSohgKP+CFxzcIDKpFvhiq2Dg=;
        b=AHb+wFKgDsE0w3dMaCnZIWYiolO/8kQQQQXUUtLh8FGLdZTOWrdTQoUzaDW3GA535s
         stJCnL7BNHaMZaIs70sNc1EADzzELvjxhwu6JocVT6ivzFPbeqhgY47BNY7jkDuwPbpf
         MsJRAmUrn9eP782ZCrQ8FGcJIRHp0To4Kz/BW9DQNvngbF+PA7E91wUdsCQlqOZEgbgN
         qUUbRx/8w4yXiDUCd2gc7CSIWQWwweWGCbpXuhliZWiChh5XV1V+msAgTPbVp7i6Rttx
         zic3bX+z+vVPqbbq0CFutSZbP81beIkXKlBffaZvAsSB+MtJeTKR1igYfzS67gkK5fTL
         I+Dg==
X-Gm-Message-State: AGi0Pub5SjnK3Iv2oqZzIDRjpxtgti6UP/IECULdp4i0wWW2epb0CBaV
        +D8NHATYEpLlQqTr18biOQloN1jMT/G3Wfll+7oUsf3s94+s
X-Google-Smtp-Source: APiQypL1p9BdfOAzzmp+n/a/4JAtl4MGpsbsogjDDiDXwhFnWp8k7Ijt9lWhxol8IIu94KfrvisAcXf3IBpj799R/N8=
X-Received: by 2002:adf:ec85:: with SMTP id z5mr1666465wrn.153.1589099727564;
 Sun, 10 May 2020 01:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200510060645.10159-1-john.oldman@polehill.co.uk> <20200510065519.GB3434442@kroah.com>
In-Reply-To: <20200510065519.GB3434442@kroah.com>
From:   John Oldman <john.oldman@polehill.co.uk>
Date:   Sun, 10 May 2020 09:35:14 +0100
Message-ID: <CA+JojbpnUxiONfG7tXdd8nt=uKLtnv65EtFeEAa0UKMkcQi6XA@mail.gmail.com>
Subject: Re: [PATCH V2] staging: vc04_services: vchiq_connected.c: Block
 comment alignment
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     nsaenzjulienne@suse.de, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback Greg.
Will resubmit the patch as you suggest.
Thanks
john

On Sun, 10 May 2020 at 07:55, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sun, May 10, 2020 at 07:06:45AM +0100, John Oldman wrote:
> > Coding style issue
> >
> > Signed-off-by: John Oldman <john.oldman@polehill.co.uk>
> > ---
> > v1: Initial attempt.
> > V2: Resubmitted with shorter comment line, as suggested by Greg KH.
> >
> > This patch clears the checkpatch.pl "Block comments should align the * on each line" warning.
>
> Why is this text not in the changelog area?  Don't you think that it is
> better than the 3 words you currently put there?
>
> Please fix up and resend.
>
> thanks,
>
> greg k-h

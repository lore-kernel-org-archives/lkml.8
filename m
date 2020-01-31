Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73804C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 03:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 332CE20708
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 03:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Jf3jwIJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgAaDoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 22:44:09 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38873 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbgAaDoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 22:44:09 -0500
Received: by mail-qk1-f193.google.com with SMTP id k6so5279720qki.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 19:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gnZ43qN7S1q4zZHme5V7oQ52yf1PnubAtyieKw4/fVY=;
        b=Jf3jwIJN6NmDEE5rHTH3bi4JBCItLuv4Z8GzrYcknpWQQ5kCZURSEcOUtxHYCcQ5eK
         rCg0uTFwevnnkGt785cjEtT+QPDAOFP1a5TzYfTETRSjUDZskAM/97VoZYjWatRYnYQz
         c7f6jh9skAy62+AXe7jyQE/Y6J/IYqqaExXZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gnZ43qN7S1q4zZHme5V7oQ52yf1PnubAtyieKw4/fVY=;
        b=V2eK2E2SpFOdlnS/5btMDfvrK0fp+zYEdRG8pEPct3mp6RHUCmJZzkHXOmB8MIErWg
         iYKtp0AvuaobGCRLkMe+3tC/DMYDivTrOmhVrGD5xoYL2HSXYts3+g+aIuFxVQigtxdJ
         1EwYQqHezWVCefHkzfCIw3pdFtoJLR0G9Io3oexH94PBGCqnVy/eF55Iew47PaNMSZor
         Y2qNBaLyhQbHMTOiDCMmwmNYbIW4Ci6s+mw6MNMQCvBRmNkPeyUwU+UyWb3C6KNz1wDI
         ZIY6BG+UG3SBjSA+Cg0hRes/CV6jDYbPcyr0AOd/IAgoej8BHXA4lBe74QuqegufZb7B
         4iig==
X-Gm-Message-State: APjAAAVdRY1MiUYzST5YyadiViVkCfng8eqC82tgpaBx7Vj5qkTmzlrN
        Gej9MoCVonCrCLJDC7hFufvEuWPi7BiB/kbYgvvXEA==
X-Google-Smtp-Source: APXvYqwD62nlQsAFr4t2VRsUvR/xF3QgSUs3f8+MA8JJi/UqziVen3riJEm4PChAbEVcrDuYZozUpVA7fDtvclfVkKg=
X-Received: by 2002:a37:d14:: with SMTP id 20mr8922868qkn.330.1580442248103;
 Thu, 30 Jan 2020 19:44:08 -0800 (PST)
MIME-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
 <20191211192742.95699-8-brendanhiggins@google.com> <CACPK8XctCb9Q2RaFVHEDuWxKDXpCWMWs-+vnKZ=SeTa3xRnT_g@mail.gmail.com>
 <CAFd5g45MFYMK-eZWPC5fhm2OkynUXKfArUVhbanYVH+qKRUwPg@mail.gmail.com> <CAFd5g454tX9zxRAq5T_pDGzcWt7u5r119wjo-BCGVq+=Ej4bGQ@mail.gmail.com>
In-Reply-To: <CAFd5g454tX9zxRAq5T_pDGzcWt7u5r119wjo-BCGVq+=Ej4bGQ@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 31 Jan 2020 03:43:56 +0000
Message-ID: <CACPK8XddCV6QnvRSS7WcyoN7W3yuUSbyT67on=EMhV7jWDExUg@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] fsi: aspeed: add unspecified HAS_IOMEM dependency
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Andrew Jeffery <andrew@aj.id.au>, Jeremy Kerr <jk@ozlabs.org>,
        Alistar Popple <alistair@popple.id.au>,
        Eddie James <eajames@linux.ibm.com>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>, linux-fsi@lists.ozlabs.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2020 at 09:46, Brendan Higgins <brendanhiggins@google.com> wrote:

> > > Do you want to get this in a fix for 5.5?
> >
> > Preferably, yes.
> >
> > > Acked-by: Joel Stanley <joel@jms.id.au>
>
> Hey, I know I owe you a reply about debugging your kunitconfig (I'll
> try to get to that this week); nevertheless, it looks like this patch
> didn't make it into 5.5. Can you make sure it gets into 5.6? It
> shouldn't depend on anything else.

Sure, thanks for the reminder.

Cheers,

Joel

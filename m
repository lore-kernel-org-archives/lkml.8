Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7007FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 19:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D02B2077D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 19:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="yLfHIAag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgFETiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 15:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbgFETiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 15:38:05 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926B2C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 12:38:04 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o15so11320833ejm.12
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 12:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eOF1BRH3hqUoMNIFRgJb8qWo4oAn8/8kkqpSwUrcV0E=;
        b=yLfHIAagpugDB4geFiVAXJJTQZXB+jW2HjJpn1vVvldz+/22CHGCzrUNeAIPsbbOvS
         Vj0WWKVboNAgnySpxH8lKz1enjBLbx+U5WnUNrph8o3tPLdFlnq4xLjeFaiD7zPvZ1HI
         E8vYm7qpO0BZDhJ5aa3p4Z+TUaHWun5mYVXiUYGP08452NKK4T0k3te3woXIIPw9YBVE
         a0T4s5ywxePv/JEhyEsXaKRaDhNAcQU2hG19R8cToaq5nYYP1zWYwiHczsHKzCW6EgA9
         q6UTJD57gk60CAfMC6sMGWtxCUx2KdpUpGUH6a4iVzNYkxQ8OyDLll7pBr07DdJfQFZI
         X9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eOF1BRH3hqUoMNIFRgJb8qWo4oAn8/8kkqpSwUrcV0E=;
        b=s4EZnWP9vU6I7Q2lL45PUaeVTqgFg5FOqR0r3ZUSFR+kFncLzbuUBO9JAlx0kHfdLz
         IHaWBkzR8x24xZtxyykJgEh6SziV+POJbQZpa8flD9jgyTXDYi8wwTds1SvIsg6usCwk
         vyxxs2oMhupvWzCaLyRX6qQh3GshXO3KGYIHkL+OekCbCTbq/thB4eCn1vMo/NlpwTJl
         AFUbSYw9BnqsC7OVPF1ZtFD60IL+gM5xKS54Q2VvgyyxoeTB2DJv9PeMWqKRm2HYeggZ
         xZ8KFLIAjN67GUx/mwfeYF+HoqqNuC2CYaCrhKU81u8R0JexmWdTTRpZBA/PlApl0/aZ
         SKMQ==
X-Gm-Message-State: AOAM533f4vSynyO0pUD7DQpqHQSkXko8zNGXD+HFXWgyNopNqhB/Tc7K
        snApl6f1zh7Ko0C+G/KmiEq/MuerG8zTkL8DXFb88xQ=
X-Google-Smtp-Source: ABdhPJynBTUuAesu8TZmhXmvdaQE0Ftl+C+xkFDUiYKUtjaE5qcD7vJ2l61mQAblJihXIT2xzHwpHUX6JZ9vZlZOznI=
X-Received: by 2002:a17:906:e257:: with SMTP id gq23mr9631120ejb.398.1591385882972;
 Fri, 05 Jun 2020 12:38:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200604163243.2575-1-nramas@linux.microsoft.com> <1591382782.5816.36.camel@linux.ibm.com>
In-Reply-To: <1591382782.5816.36.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 5 Jun 2020 15:37:52 -0400
Message-ID: <CAHC9VhS-EP=Kk3GKRzAGAYa5mqupkLQCHz_m_DgoAKRWcSTgLA@mail.gmail.com>
Subject: Re: [PATCH] IMA: Add log statements for failure conditions
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, tusharsu@linux.microsoft.com,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 2:46 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> [Cc'ing Paul Moore]

If it's audit related, it's generally best to CC the linux-audit list,
not just me (fixed).

It's not clear to me what this pr_err() is trying to indicate other
than *something* failed.  Can someone provide some more background on
this message?

> Hi Lakshmi,
>
> On Thu, 2020-06-04 at 09:32 -0700, Lakshmi Ramasubramanian wrote:
> > The final log statement in process_buffer_measurement() for failure
> > condition is at debug level. This does not log the message unless
> > the system log level is raised which would significantly increase
> > the messages in the system log. Change this log message to error level,
> > and add eventname and ima_hooks enum to the message for better triaging
> > failures in the function.
> >
> > ima_alloc_key_entry() does not log a message for failure condition.
> > Add an error message for failure condition in this function.
> >
> > Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>
> These messages should probably be turned into audit messages.  Look at
> integerity_audit_msg().
>
> Mimi
>
> > ---
> >  security/integrity/ima/ima_main.c       | 3 ++-
> >  security/integrity/ima/ima_queue_keys.c | 2 ++
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> > index 9d0abedeae77..3b371f31597b 100644
> > --- a/security/integrity/ima/ima_main.c
> > +++ b/security/integrity/ima/ima_main.c
> > @@ -756,7 +756,8 @@ void process_buffer_measurement(const void *buf, int size,
> >
> >  out:
> >       if (ret < 0)
> > -             pr_devel("%s: failed, result: %d\n", __func__, ret);
> > +             pr_err("%s failed. eventname: %s, func: %d, result: %d\n",
> > +                    __func__, eventname, func, ret);
> >
> >       return;
> >  }
> > diff --git a/security/integrity/ima/ima_queue_keys.c b/security/integrity/ima/ima_queue_keys.c
> > index cb3e3f501593..e51d0eb08d8a 100644
> > --- a/security/integrity/ima/ima_queue_keys.c
> > +++ b/security/integrity/ima/ima_queue_keys.c
> > @@ -88,6 +88,8 @@ static struct ima_key_entry *ima_alloc_key_entry(struct key *keyring,
> >
> >  out:
> >       if (rc) {
> > +             pr_err("%s failed. keyring: %s, result: %d\n",
> > +                    __func__, keyring->description, rc);
> >               ima_free_key_entry(entry);
> >               entry = NULL;
> >       }
>


-- 
paul moore
www.paul-moore.com

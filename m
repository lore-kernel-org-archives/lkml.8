Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7CFC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 21:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49D2820774
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 21:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqWLNyBy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbgC2V4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 17:56:01 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55605 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728966AbgC2V4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 17:56:00 -0400
Received: by mail-wm1-f66.google.com with SMTP id z5so17740671wml.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 14:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ulfC6hgy6ACkHw+iBinr76TbGOLClSVkLu9pFAuKoVk=;
        b=iqWLNyByOYdM4pCxKi6Y+Yw8cPv1WLvCSpp3c81OjmFm5ZdrBUX6u7jYDIQvci1j3v
         TXxbTQvIB7KB+VZYPD66CLdbbg7m27bNtAXVx00jWlGmnSx4MFgt4rd3dfMB3UForC/6
         FrgEw8ni2L5DlIFeNHOPKi5g/A2pRODrkZv2Ce4O8cNDkVAt1ph5z+TffaHEVIaqUD+/
         5WxGdas30Ni3v7IYugEe2KCW6YLvoMe0/GWhz+eh9DE0jBnGBgrrpRjl0kd85hDXlhKX
         ioVMNb141ADzdXw3Kjvp/C88HOsgGty0Ybyuj/rfuBAceHTl3sLIkVVEl2VIqigUVEKZ
         dP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ulfC6hgy6ACkHw+iBinr76TbGOLClSVkLu9pFAuKoVk=;
        b=tW4QZyWvdHaOIDAI327KfCSCy0BuWfJBb0ygaJYSN7+Iq7aZ9j53+/6wfqHbY5WNEB
         fKxWRZl329LfFqgaQ/H7YkTpfOeOfvmfHHtjBwRbcHVNOs2cjHTXFY2kc+RijEgoMS9Z
         uVhq4jird6Q0PmXE6GdTSgEZoZ1oIIkdxNinOZrKBT8Bhsh73vbqvrOXo9o7e3CMPh9m
         sxlFyGzGO+8oP+4B5op1ZDuAxIdpd+Pn7ieOFe6t14zNF3xvW347u7Tm5Hm8TNaGBndn
         OIeb+mUNoWH8hGlpXIEu3r2eex57s8uY54hyhMDzsCiZ9VRlof4W/4Nn2R6Ac9RDUCbz
         f6Pg==
X-Gm-Message-State: ANhLgQ1HjjV6Nx4+m7/0tRr8ifbL74TvxWyY0UHr1N/xpxj+/lb0yboT
        km2lBzsGvN9avCJC1CQj1HhS4gIbbRr7hRZv8tEGCtSe
X-Google-Smtp-Source: ADFU+vt4o6OKgj4Tc2ly+vS1OftlUznob/YFlYoFGGyRBxMgJFczwL6J9QTtAs7ggIIvx+dDrQ1mnnqZQOkeEOuRlD4=
X-Received: by 2002:a1c:2e10:: with SMTP id u16mr9475250wmu.143.1585518958887;
 Sun, 29 Mar 2020 14:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200216213624.800463-1-sjoerd.simons@collabora.co.uk> <74c04f11-4b67-d1a7-7d05-197a229b245c@cambridgegreys.com>
In-Reply-To: <74c04f11-4b67-d1a7-7d05-197a229b245c@cambridgegreys.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 29 Mar 2020 23:55:47 +0200
Message-ID: <CAFLxGvzuDJs7B7w6eF+dC634pVrK6BJPyfUOvXoACL7toYwoPg@mail.gmail.com>
Subject: Re: [PATCH] um: vector: Avoid NULL ptr deference if transport is unset
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Sjoerd Simons <sjoerd.simons@collabora.co.uk>,
        linux-um <linux-um@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Jeff Dike <jdike@addtoit.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 8:54 AM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
>
> On 16/02/2020 21:36, Sjoerd Simons wrote:
> > When the transport option of a vec isn't set strncmp ends up being
> > called on a NULL pointer. Better not do that.
> >
> > Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> >
> > ---
> >
> >   arch/um/drivers/vector_kern.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> > index 0ff86391f77d..ca90666c0b61 100644
> > --- a/arch/um/drivers/vector_kern.c
> > +++ b/arch/um/drivers/vector_kern.c
> > @@ -198,6 +198,9 @@ static int get_transport_options(struct arglist *def)
> >       long parsed;
> >       int result = 0;
> >
> > +     if (transport == NULL)
> > +             return -EINVAL;
> > +
> >       if (vector != NULL) {
> >               if (kstrtoul(vector, 10, &parsed) == 0) {
> >                       if (parsed == 0) {
> >
> Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Applied, thanks!

-- 
Thanks,
//richard

Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DE4C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 04:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65DB22078A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 04:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvkxLG6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgH0Exb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 00:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbgH0Exa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 00:53:30 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71D9C0612AC;
        Wed, 26 Aug 2020 21:53:29 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id h19so4899468ljg.13;
        Wed, 26 Aug 2020 21:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VfXaV7Ot1lSa8F3M4QFP11oTUsc4RIqW2P8Ni4Vvi3k=;
        b=FvkxLG6VoVE/W3qV25+mpcUx9KGnCIvR9cP/DI027OQMSjUTJEkVEbt92cLK5SDbD/
         UHVM7mQ1gtqhqmeWcDi2vlQu3y2J1l55ULb5ZhYN7DhI4JOhkbBnctK8pZtuZnM9Xrmt
         XFch2KrE2+H1Y7FusDDB3OFlVjLgjrP5c84HeM2HBqusfABp0rXpCQovfA5jHHBX5mHO
         fK091Eda4unJsViWrCCsz8Qky7f+3j8DhaUqZIkviewBvvO3n3Z8gSm9f78FYkbDyy+2
         5fnqOHa3/Z/bAYmuyudcPtft0cYUL+s70Uy1N6RetNVUBXteUKi1mgpoShreNI4GylzU
         WZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VfXaV7Ot1lSa8F3M4QFP11oTUsc4RIqW2P8Ni4Vvi3k=;
        b=fdy8LA7y/YjsVzCw5n1hErRb++u7y+Ecc8AUjJXQ674in8Dk3c9wtT68bRkMSDuTzM
         UWFKyOT4GNa0beYPIA0WP4KqkKlv+vhoHKhPRyweVNCNn3Y9nnSN+g5RKFbg4tEywrsf
         jTN4b0BgOFo1mDNb0YBcgvPcsqYsxDfVmTzJjm5+6YaIzldV7R+mbZPy8BsoDPX/NNz4
         gNYjwTDDQvcRE7VhYq3+8kAiX6Hx7+ZCCTNKOkrEN15wFkS4uarckujBstxgFX+yr6qI
         vw40LazgXZ6VrB0E1k0VaPycbIl0QTwAWUm+7MohPRf0vsAZh0i2QAOVBM4aCwXAvGzq
         gvkw==
X-Gm-Message-State: AOAM530m/hOfLCSfD1c05RdeeV3gA5RQ28Pe5mS3pLDsj0hd8xg585+M
        16oAjS7vosyE+vThngUTRP+e05wcl+H0M5F8V0Y=
X-Google-Smtp-Source: ABdhPJxiPd+z3Woi/CPVydxc4d5ALoYsOisEmeXn0aWdBmXlvi+FNKeUs3Edy9XlM9OaPmTX7nko4vme/6vJqKBA4u0=
X-Received: by 2002:a2e:4e09:: with SMTP id c9mr9113859ljb.283.1598504008139;
 Wed, 26 Aug 2020 21:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <1598498732-25194-1-git-send-email-u0084500@gmail.com>
 <1598498732-25194-3-git-send-email-u0084500@gmail.com> <b9c73699-bd84-52f7-e42d-a482036e78e0@roeck-us.net>
In-Reply-To: <b9c73699-bd84-52f7-e42d-a482036e78e0@roeck-us.net>
From:   =?UTF-8?B?5ZWf5Y6f6buD?= <u0084500@gmail.com>
Date:   Thu, 27 Aug 2020 12:53:16 +0800
Message-ID: <CADiBU3-PyA-BKLuSSQpWXj9_up8yWbDsSVxeqUEEkEqn9syRbw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] usb typec: mt6360: Prevent the race condition
 during module remove
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        matthias.bgg@gmail.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2020=E5=B9=B48=E6=9C=8827=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8811:34=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 8/26/20 8:25 PM, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Prevent the race condition from interrupt and tcpci port unregister
> > during module remove.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
>
> Please squash with the first patch of the series.
Done, squash into the first one and resend the patch. Thx.
>
> Thanks,
> Guenter
>
> > ---
> >  drivers/usb/typec/tcpm/tcpci_mt6360.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/typec/=
tcpm/tcpci_mt6360.c
> > index 6a28193..a381b5d 100644
> > --- a/drivers/usb/typec/tcpm/tcpci_mt6360.c
> > +++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
> > @@ -164,6 +164,7 @@ static int mt6360_tcpc_remove(struct platform_devic=
e *pdev)
> >  {
> >       struct mt6360_tcpc_info *mti =3D platform_get_drvdata(pdev);
> >
> > +     disable_irq(mti->irq);
> >       tcpci_unregister_port(mti->tcpci);
> >       return 0;
> >  }
> >
>

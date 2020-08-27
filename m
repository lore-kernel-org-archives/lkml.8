Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45387C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D5E20786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 07:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crDap6mO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgH0HLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 03:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727903AbgH0HLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:11:24 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D610C061264;
        Thu, 27 Aug 2020 00:11:24 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id y2so5251200ljc.1;
        Thu, 27 Aug 2020 00:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Nv57Gn1eKFngv8s/vSw/Btf+G9R1mZ77PltJIm2hCKI=;
        b=crDap6mOKZrR9ZAtjqKwuhuwWvD9xNLGT8q+sm69RRILe0fG9BkjV+7z0DZ127asDo
         I+jEutBlwKivDNRYRbrGNS/OqE+tcpehypYt15HUhqc2Kjr7Y1OukJc8fcpJnUpQ2WOh
         Dha8PJ14CUJGcZNonjI7mLJZVzAp9qOi39Cdrq5+DZ1Fv2v4QyP7va94M9rrogworQaC
         0SJXA3ZT22RqBUuEUM+8IZqjPOLxlVfBCVQ8Sb6qktu2lK0dfk15e8RrPKWBpWVW6eL9
         P8gH2vpUjlpKXaGVoT08tvMnBDWyerZBD7A+LvO1/xiF7WA8g8bRemf27ZBqYN+JDM7R
         HhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Nv57Gn1eKFngv8s/vSw/Btf+G9R1mZ77PltJIm2hCKI=;
        b=D+RYzdnDYZJvuB3lM36HHmstQkAUnyt60tN4quPIx5LcaTa0Z/g1+Nm6YasayobHqC
         d9TFdMh4a5mUJv1pF1ehxosTzfK90e1g+/qbwp2wAsEPP2yuss9SCa8+LexkyhIxctXm
         6xfGBLpWbWzajmcEsk9Wq9tKbYHRUhhIphUAIGFHLUFSljTVqGhwWn+Utcx7Z/AF0tyI
         h0l15NKp7cO3Az5jBXwHgqrOAUeJKE9ikOn8KNsCpNlvWeKpugtJjFmxTEyCWENFwlQg
         YrNfv2f+h5n3BpX+/tTZOeQMbe+gGzP838+9ZRywkjyWGyfdHTdKDfLDNWZKUTJWd/eV
         KdqA==
X-Gm-Message-State: AOAM5313AvtHONJTEXo/mmD8DkrXFNFkz4435YVEhwZqhW7YtDIM1J1C
        4W87HhDUyblky5DUYS4iaXAV+PG2Uv5AQKzc9xHnmjE5IHeMQw==
X-Google-Smtp-Source: ABdhPJzvJAEB9d5r9zidPaU9W1O7zcbNFi6NXmIb7tdkFFR+S/4m355fVHEQ2ZvkrN/Z08JyvffpgZG4T1Axqa0ooPg=
X-Received: by 2002:a2e:9b08:: with SMTP id u8mr8377257lji.208.1598512282738;
 Thu, 27 Aug 2020 00:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <1598503859-29620-1-git-send-email-u0084500@gmail.com> <20200827070010.GD813478@kuha.fi.intel.com>
In-Reply-To: <20200827070010.GD813478@kuha.fi.intel.com>
From:   =?UTF-8?B?5ZWf5Y6f6buD?= <u0084500@gmail.com>
Date:   Thu, 27 Aug 2020 15:11:11 +0800
Message-ID: <CADiBU3-GFkjA8p_tOkF-YcJf69K=Z48oDpme-rWWH3kEj=eaDA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] usb typec: mt6360: Add support for mt6360 Type-C driver
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        matthias.bgg@gmail.com, Guenter Roeck <linux@roeck-us.net>,
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

Heikki Krogerus <heikki.krogerus@linux.intel.com> =E6=96=BC 2020=E5=B9=B48=
=E6=9C=8827=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=883:00=E5=AF=AB=E9=
=81=93=EF=BC=9A
>
> On Thu, Aug 27, 2020 at 12:50:58PM +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Mediatek MT6360 is a multi-functional IC that includes USB Type-C.
> > It works with Type-C Port Controller Manager to provide USB PD
> > and USB Type-C functionalities.
> >
> > Add fix to Prevent the race condition from interrupt and tcpci port unr=
egister
> > during module remove.
>
> You merged two patches from v2 together, so that really makes this
> v3. Where is the changelog?

changelog
Add fix to Prevent the race condition from interrupt and tcpci port unregis=
ter
during module remove.

Do I need to resent the real V3 and mark the first patch for the
commit log like as below text?

Mediatek MT6360 is a multi-functional IC that includes USB Type-C.
It works with Type-C Port Controller Manager to provide USB PD
and USB Type-C functionalities.

V1 -> V2
1. Add fix to Prevent the race condition from interrupt and tcpci port
unregister
during module remove.

V2 -> V3
1. Merge V2 change into the first patch.


If yes, I can use this way to resend patch v3 for the readability.
>
> thanks,
>
> --
> heikki

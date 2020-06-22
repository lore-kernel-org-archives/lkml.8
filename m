Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D47C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B345D2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jE5MmJeq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgFVOtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:49:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25638 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729308AbgFVOtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592837348;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=naZjlXqAUuz9QFqq0p2KUyyeqf2h2ajScjOSS4MNLek=;
        b=jE5MmJeqWLtFkb2Ow3lARu/XoA5Z0WtvzVpYYmPV5cn+CwqexImtNDmcic1U2o6EZd9u4h
        Zk5pZc61gIR/xK7VH2N1AXI7wukGGgFdfiWnPAIonBoa8aghcsjrwcMQnlOBSGUKiLzI7+
        M1KzdL39arB56FCIRikkSeIXsxX1d38=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-lBDF-t9dPUi8NBncuG6c_A-1; Mon, 22 Jun 2020 10:49:05 -0400
X-MC-Unique: lBDF-t9dPUi8NBncuG6c_A-1
Received: by mail-oi1-f197.google.com with SMTP id d63so8119987oig.18
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 07:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=naZjlXqAUuz9QFqq0p2KUyyeqf2h2ajScjOSS4MNLek=;
        b=FAnfffAWt0u+0w9ueTqf5B3+wT7npo3Tyg3ED21trq1sgXsq/9oQerrjwfAOaHQvkI
         O2RVjN4pFE7K5PTHpnm+hGHP0oIl8nVYhP8BBvbN8eBNGG7uO3D6DB4+VsQg9FkC5ten
         ZDLUy1tY017JDVZdryWTQT9cIk5+Zazwdj4zR0ye+AbIrohXEhc74wpmBN/OkgZch5mf
         ctLndywO/VJoXRVCCl8miPJPQLNAAAmOGcvee3RxwIxAhJs3L3CKaneD0F+IWLvQBepa
         WT0Rbi0dl5hFDT0UByTxv8N2OuHcSd8uV0gvriQALuLU9pus0yb6xcWdId9+rx8vAgaW
         8q3Q==
X-Gm-Message-State: AOAM5338QU3M3/mt19F1OrZTKqfeOJdLa6BoCWUfZEhtpjZwxMdsN2dN
        d7f/MUraV/83QEfDZ8Y4gNCR4iIbIEpC/0/vga1Ljv42k2c6KDWagOnAMJ1W11BaYipERlVU47M
        ilcVoJlQgCzegXm8srcXTbvGLMo7fsUKrWHEANXUX
X-Received: by 2002:a9d:39b6:: with SMTP id y51mr12985160otb.175.1592837344595;
        Mon, 22 Jun 2020 07:49:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6oTCLYY5ewTtAXQxagLn65iRqRaS/ifJ30YW9dcHRfGmRzdPnCFDN3sUXNC+/uj6SNSIpnbpPZl7QUh97fIk=
X-Received: by 2002:a9d:39b6:: with SMTP id y51mr12985144otb.175.1592837344375;
 Mon, 22 Jun 2020 07:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200618090556.pepjdbnba2gqzcbe@butterfly.localdomain>
 <20200618111859.GC698688@lore-desk.lan> <20200619150132.2zrc3ojqhtbn432u@butterfly.localdomain>
 <20200621205412.GB271428@localhost.localdomain>
In-Reply-To: <20200621205412.GB271428@localhost.localdomain>
From:   Oleksandr Natalenko <oleksandr@redhat.com>
Date:   Mon, 22 Jun 2020 16:48:53 +0200
Message-ID: <CAHcwAbR4govGK3RPyfKWRgFRhFanWtpJLrB_PEjcoiBDJ3_Adg@mail.gmail.com>
Subject: Re: mt7612 suspend/resume issue
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Felix Fietkau <nbd@nbd.name>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Lorenzo.

On Sun, Jun 21, 2020 at 10:54 PM Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> > > +static int __maybe_unused
> > > +mt76x2e_suspend(struct pci_dev *pdev, pm_message_t state)
> > > +{
> > > +   struct mt76_dev *mdev = pci_get_drvdata(pdev);
> > > +   struct mt76x02_dev *dev = container_of(mdev, struct mt76x02_dev, mt76);
> > > +   int i, err;
>
> can you please double-check what is the PCI state requested during suspend?

Do you mean ACPI S3 (this is the state the system enters)?  If not,
what should I check and where?

Thanks.

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Principal Software Maintenance Engineer


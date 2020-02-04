Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DA0C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87CC52166E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 09:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="P60K4t5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgBDJZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 04:25:48 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35855 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgBDJZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 04:25:48 -0500
Received: by mail-ua1-f68.google.com with SMTP id y3so6471909uae.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 01:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/LrB1QQcfXPxi0BB+lcewM64zrtrSOEYAcITFbKQ4wI=;
        b=P60K4t5ggLQr/vhZHiXRlNywK69iPHwx590eFL3PWBdM4grhTUdcJtIzcoDprLCWT5
         7m0n41QNkC8//4JfksLTz3YdQUVxEAGSDuZ9j+W1a0nr+VT86k3WY6fHx1FvGidLTTLy
         +w3Et4GwWqW1Y/UOb4tyjt07vAISYdOcsP/ZwOg1V/KnnyOAF5auYXjo5JGMn7+72ZuG
         KOS57j5QABVOvSR/VaJ+0zijMitZCtAji/0qGDGkhMome9LKH3rlcKGXQN1d+0fDdjdr
         11d7hpEYBvM/Pc5HMA4mbzRQuC7Z5V/iFUQep1upy5JLQZhZKX4GTwvjnL9DG9LiIf3K
         gI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/LrB1QQcfXPxi0BB+lcewM64zrtrSOEYAcITFbKQ4wI=;
        b=DpAsAsj60zTQc4xDE/dMkAAUcmvQOMaLESZpOhURD7m4kJNqZQIrL7DbP7jGHx0alG
         Shn7ECm6YF2nkR/72De6K+ArhqWXXgn7BWYvi+F5JirBU8CNn6XVOvOoIJnZxAV23H4S
         ibO1Q4GRsD2QplAgnQPODS1bEPJeHZyz0ILLYFTGyrkj1rS8trmugOUq66FjVBtaf/CZ
         kLZd88Oc5PIspr+rkINQnqzRDaP/YH30mqRT2c+8CJ1icbCIsNp/wpp8m+WGr+DGRG7E
         0LT2paalE3QexKZRjlqkccVQ984O5aofl0O/Zvfjxbwkt+lj7SIJkd3ulM2Kjg801hNa
         RIEA==
X-Gm-Message-State: APjAAAVCUiABCM5BdhlzRNZlmMebasQja+YuB0KTana+qKnHyTby4U7t
        E22jd10CYUUB+tt0OU+oEwdl0jfY2C2DtAPZQkYONQ==
X-Google-Smtp-Source: APXvYqwgmuBZwg5kpKbNPQPbL9DX7UGf6nqnhW6qNJ300wkY5DIL2j8Eyl5WkLN8NrTTLujLR9GHxiRbWohjJDze1KI=
X-Received: by 2002:ab0:2a0c:: with SMTP id o12mr16324286uar.72.1580808347038;
 Tue, 04 Feb 2020 01:25:47 -0800 (PST)
MIME-Version: 1.0
References: <20200203091009.196658-1-jian-hong@endlessm.com> <aab0948d-c6a3-baa1-7343-f18c936d662d@linux.intel.com>
In-Reply-To: <aab0948d-c6a3-baa1-7343-f18c936d662d@linux.intel.com>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Tue, 4 Feb 2020 17:25:04 +0800
Message-ID: <CAPpJ_edkkWm0DYHB3U8nQPv=z_o-aV4V7RDMuLTXL5N1H6ZYrA@mail.gmail.com>
Subject: Re: [PATCH] iommu/intel-iommu: set as DUMMY_DEVICE_DOMAIN_INFO if no IOMMU
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lu Baolu <baolu.lu@linux.intel.com> =E6=96=BC 2020=E5=B9=B42=E6=9C=884=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=882:11=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi,
>
> On 2020/2/3 17:10, Jian-Hong Pan wrote:
> > If the device has no IOMMU, it still invokes iommu_need_mapping during
> > intel_alloc_coherent. However, iommu_need_mapping can only check the
> > device is DUMMY_DEVICE_DOMAIN_INFO or not. This patch marks the device
> > is a DUMMY_DEVICE_DOMAIN_INFO if the device has no IOMMU.
> >
> > Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> > ---
> >   drivers/iommu/intel-iommu.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index 35a4a3abedc6..878bc986a015 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -5612,8 +5612,10 @@ static int intel_iommu_add_device(struct device =
*dev)
> >       int ret;
> >
> >       iommu =3D device_to_iommu(dev, &bus, &devfn);
> > -     if (!iommu)
> > +     if (!iommu) {
> > +             dev->archdata.iommu =3D DUMMY_DEVICE_DOMAIN_INFO;
>
> Is this a DMA capable device?

Do you mean is the device in DMA Remapping table?
Dump DMAR from ACPI table.  The device is not in the table.
So, it does not support DMAR, Intel IOMMU.

Or, should device_to_iommu be invoked in iommu_need_mapping to check
IOMMU feature again?

Best regards,
Jian-Hong Pan

> I am afraid some real bugs might be
> covered up if we marking the device as IOMMU dummy here.
>
> Best regards,
> baolu
>
> >               return -ENODEV;
> > +     }
> >
> >       iommu_device_link(&iommu->iommu, dev);
> >
> >

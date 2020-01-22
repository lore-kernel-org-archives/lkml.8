Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306B9C33CB6
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0552465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 18:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cP2hgEdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgAVSP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 13:15:27 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35238 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVSP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 13:15:26 -0500
Received: by mail-pg1-f194.google.com with SMTP id l24so3944009pgk.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 10:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:subject:from:user-agent:date;
        bh=EmAL7GOGgg6j/HkDxl1w5C2l3eFXSyhiQn5oFiHpD5k=;
        b=cP2hgEdxOQ9YgVB61df2wiAknqcv9EPRfHGP55UvZ9LcMKNeUKRg11pEdDuLKa7uKq
         7W9BR+9VfrOtDYhpOtccn5PB9BRdX0HBttlwmUvjGCF+wZk4fkx0EjxTvnVuYBc11hKR
         aIcIC0yf9E5ZAW5WF3JOFsFpaaZllMBeLp9NE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:subject:from
         :user-agent:date;
        bh=EmAL7GOGgg6j/HkDxl1w5C2l3eFXSyhiQn5oFiHpD5k=;
        b=VeoRg7D4huMQmarsPnBNtssa5Zx+TFdmIsn/+Ei2hC0KArOCmDGkU+1YcKtY+wH0rE
         NK+tDMx3GfVT23PGVzLBSchDvQymVHqF0v4QpEMTTlRfYaHSgp4MVo9jxqjmULUh+Iwf
         623EFUD0yTHtYSA9qG7wbfocUPJlZct3J/0f39y4lIYwI1AVpwYwk0Hfespri4IAYb+4
         7ps32I3uD4hCCabSdfOUwndaTcI/kKnxpjWlh8SIwabfgvBmWl4nm7fY8lhjLW/skTar
         2Nr27NliyRmfE5pHeegaB7H5T9tjOJxPD81fdE/3YzVAo0JeS0pMrzt3sIDU/fnQxa/L
         TJYg==
X-Gm-Message-State: APjAAAVCNeCvBcoQilkmjOfyllZp7FkDO5UYv6uQRwry7x1QxxDwq8xV
        AnlkqDRfW5vCfg7lteaCIFMfchDxQY4cSw==
X-Google-Smtp-Source: APXvYqz9jd4ioW9dlzxeuYifq9XXJ4OQ4M+uOnbxPOrkGpP5ZFA0OAI40utZ8lasT5ilCWI+xQHVmw==
X-Received: by 2002:a63:220b:: with SMTP id i11mr12176884pgi.50.1579716925591;
        Wed, 22 Jan 2020 10:15:25 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id w20sm48106220pfi.86.2020.01.22.10.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 10:15:24 -0800 (PST)
Message-ID: <5e28913c.1c69fb81.8a690.7308@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <9158a0d87f6493977455179202cd86165437f5f6.camel@9elements.com>
References: <20191128125100.14291-1-patrick.rudolph@9elements.com> <20191128125100.14291-2-patrick.rudolph@9elements.com> <CAODwPW8Koy1BvKGJU6PKexYx+PNE+WY7+m69gcxT689vBy+AoQ@mail.gmail.com> <9158a0d87f6493977455179202cd86165437f5f6.camel@9elements.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Samuel Holland <samuel@sholland.org>
To:     Julius Werner <jwerner@chromium.org>, patrick.rudolph@9elements.com
Subject: Re: [PATCH v3 1/2] firmware: google: Expose CBMEM over sysfs
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 22 Jan 2020 10:15:23 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting patrick.rudolph@9elements.com (2019-12-19 23:12:22)
> On Mon, 2019-12-09 at 22:54 -0800, Julius Werner wrote:
> > > +static int cbmem_probe(struct coreboot_device *cdev)
> > > +{
> > > +       struct device *dev =3D &cdev->dev;
> > > +       struct cb_priv *priv;
> > > +       int err;
> > > +
> > > +       priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> > > +       if (!priv)
> > > +               return -ENOMEM;
> > > +
> > > +       memcpy(&priv->entry, &cdev->cbmem_entry, sizeof(priv-
> > > >entry));
> > > +
> > > +       priv->remap =3D memremap(priv->entry.address,
> > > +                              priv->entry.entry_size,
> > > MEMREMAP_WB);
> >=20
> > We've just been discussing some problems with CBMEM areas and memory
> > mapping types in Chrome OS. CBMEM is not guaranteed to be page-
> > aligned
> > (at least not the "small" entries), but the kernel can only assign
> > memory attributes for a page at a time (and refuses to map the same
> > area twice with two different memory types, for good reason). So if
> > CBMEM entries sharing a page are mapped as writeback by one driver
> > but
> > uncached by the other, things break.
> >=20
> > There are some CBMEM entries that need to be mapped uncached (e.g.
> > the
> > ACPI UCSI table, which isn't even handled by anything using this
> > CBMEM
> > code) and others for which it would make more sense (e.g. the memory
> > console, where firmware may add more lines at runtime), but I don't
> > think there are any regions that really *need* to be writeback. None
> > of the stuff accessing these areas should access them often enough
> > that caching matters, and I think it's generally more common to map
> > firmware memory areas as uncached anyway. So how about we standardize
> > on mapping it all uncached to avoid any attribute clashes? (That
> > would
> > mean changing the existing VPD and memconsole drivers to use
> > ioremap(), too.)
>=20
> I wasn't aware that CBMEM is used for DMA as there's no such concept in
> coreboot yet. For me it looks like the UCSI is regular DRAM mapped as
> WB accessed by the ACPI interpreter.
> I'll prepare a new patch-set using ioremap in all drivers that access
> CBMEM.
>=20

We shouldn't use ioremap() here as this isn't I/O memory. It's just
regular memory that wants be mapped with some particular set of
attributes, hence the use of memremap().


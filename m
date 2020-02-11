Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D2DC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D7820848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="aKwwSGpH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgBKJ0e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 04:26:34 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:44893 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbgBKJ0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 04:26:34 -0500
Received: by mail-qv1-f68.google.com with SMTP id n8so4623437qvg.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 01:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CyBYdlNzPZcwqhOp74T1XMugvpFC8qtdcMQo6cEAVoQ=;
        b=aKwwSGpHuYhhyh8Ot2HBH1TVPddBoOM1IgloUFLULdhrSN3NAPSuSZIWQs8eem4tri
         T7JYQJS3SZMMJYLfxkVjJnYpnWq8vNKGUZ7+5ls966HknA1txKwRewAYNTulEG8CUpmG
         GDdDFylpEZsBJcSszVTY6u6KdbmlgXJgUiCXMiofFArq16MvBKq2ZBX8Q8AFPcquEHVI
         zUNFHD65i3sVF7dgjDhGLUq/plddXcLFKeCo+DsO24NhkvixeZaEiZ4rGPNUElJjT5wQ
         oh8lCGjDizwiTjjb850NGgHBA1iHQwHXcj6zuGJpveK3VBScYP+jSgJ1mmBKxin3qI8h
         pQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CyBYdlNzPZcwqhOp74T1XMugvpFC8qtdcMQo6cEAVoQ=;
        b=a5zufoujNGAv4WD/SO50EgWKJZj67I1X9+GRGpcB1L6Bp2fm9qI7FezLKMQGH9Say0
         7DSbVN5Z9Tx1UtXMonoUN8h6GedhhoHtoTv3nDUtYkdh3afuE0SAyF4QSLN9DXtKGCfQ
         a3HX1Q78DsqbqyFo//jW6I62EtqQ4+XPPqpweA10BdY7VklX/UEKK5Ava2zz+m/+ie1c
         s3ixxvhYk2l826mKRWAtM2S1tehKSvT6JsYYljqgsGRQENjzTTyYKeHe4bEuCmFrSkjB
         5xjRsEBas/qANX4NYGyzSb4Yd9vzWfiiWlNPxgzrBPG+tc48ns2VCTmAYfBCB6oE6QVl
         n35Q==
X-Gm-Message-State: APjAAAWORO8Di40FiFPsI4fFu5D6ar1ZyR0+zSIRX9O5itOVcVgwDzSk
        GViTQJ7Yirob3vcmkYzTZBS0i+ESvkaIsGcFA8UXNQ==
X-Google-Smtp-Source: APXvYqzPhqgXg8EP9ZxxdpibAsoCpblQWH+qYglareF2FNtSQYF1Fewu3sUdaISV8w2mebYx/WU9YaLaEHyjLDPiH/o=
X-Received: by 2002:a05:6214:1389:: with SMTP id g9mr13997301qvz.40.1581413192840;
 Tue, 11 Feb 2020 01:26:32 -0800 (PST)
MIME-Version: 1.0
References: <20200203091009.196658-1-jian-hong@endlessm.com>
 <aab0948d-c6a3-baa1-7343-f18c936d662d@linux.intel.com> <CAPpJ_edkkWm0DYHB3U8nQPv=z_o-aV4V7RDMuLTXL5N1H6ZYrA@mail.gmail.com>
 <948da337-128f-22ae-7b2e-730b4b8da446@linux.intel.com> <CAPpJ_ecM0oCUjYLbG+uTprRk0=OTUBTxZc-d2BGBRDSYWk4uSQ@mail.gmail.com>
 <c8d89c4f-1347-8b9d-0486-a29dd081f26c@linux.intel.com> <CAPpJ_ec6H9fqSLA9L8QXir=FBjJqV7xcXp4ea+6XJ8MotDWVyg@mail.gmail.com>
 <b36c252b-943b-3b13-1f25-a8f23e431f39@linux.intel.com>
In-Reply-To: <b36c252b-943b-3b13-1f25-a8f23e431f39@linux.intel.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Tue, 11 Feb 2020 17:26:21 +0800
Message-ID: <CAD8Lp45U40ZLb8w22muDKQepXfuhW5hCdyzEtku11Y2X9ab=vQ@mail.gmail.com>
Subject: Re: [PATCH] iommu/intel-iommu: set as DUMMY_DEVICE_DOMAIN_INFO if no IOMMU
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Jian-Hong Pan <jian-hong@endlessm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 8, 2020 at 2:30 PM Lu Baolu <baolu.lu@linux.intel.com> wrote:
> > The devices under segment 1 are fake devices produced by
> > intel-nvme-remap mentioned here https://lkml.org/lkml/2020/2/5/139
>
> Has this series been accepted?

Sadly not - we didn't find any consensus on the right approach, and
further conversation is hindered by the questionable hardware design
and lack of further communication from Intel in explaining it. It's
one of the exceptional cases where we carry a significant non-upstream
kernel change, because unfortunately most of the current day consumer
PCs we work with have this BIOS option on by default and hence
unmodified Linux can't access the storage devices. On the offchance
that you have some energy to bubble this up inside Intel please let me
know and we will talk more... :)

That said, this thread was indeed only opened since we thought we had
found a more general issue that would potentially affect other cases.
The issue described does seem to highlight a possible imperfection in
code flow, although it may also be reasonable to say that (without
crazy downstream patches at play) if intel_iommu_add_device() fails
then we have bigger problems to face anyway...

> Will this help here? https://www.spinics.net/lists/iommu/msg41300.html

Yes! Very useful info and a real improvement. We'll follow the same
approach here. That does solve the problem we were facing, although we
needed one more fixup which I've sent separately for your
consideration: iommu/vt-d: consider real PCI device when checking if
mapping is needed

Thanks!
Daniel

Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6DBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20108206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 13:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591797403;
	bh=1Cj2Fu88LV4A1GgSyK0XUoUZIOiwmlOBdE+eZjQYBE8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=utyBiInTZukMYyndgm3VJDrJR/9J89hrIAlXWpDZpYv4p6W7C7nixsb6tvhiMaUSx
	 a7a3rd/C9Ep5cJqSrCw73isNcaDUbZhZMd2LdxYcwDJL3xA65DSkEEbAg6KD5yJYZg
	 HcKUfTSdWqJtUEsTF+QqdNtVCQ/HO+NIXv5e9/f8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgFJN4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 09:56:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbgFJN4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 09:56:40 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 293A4206F7;
        Wed, 10 Jun 2020 13:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591797400;
        bh=1Cj2Fu88LV4A1GgSyK0XUoUZIOiwmlOBdE+eZjQYBE8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cxfDQV9c7q2CTPvH9bVVbFxTVYhTD/TelQG5Yq27BP7A4hg/tJgMFNm8ivwMarGjO
         //yBZphNP8a1ZofgNgh46xyBh6cjhJOMoAjWU/nRxi9KUj5kZvUQmlGHWfusM5T/1r
         qGtTogDeicpAsCSSiGjscw3KPco8jXPwv6C5TMzs=
Received: by mail-ot1-f53.google.com with SMTP id k15so1749089otp.8;
        Wed, 10 Jun 2020 06:56:40 -0700 (PDT)
X-Gm-Message-State: AOAM531m1dZIFb+1rkI4bgBKmhKAaakL2oXHRFqarWQQcjeb7xzSCGyZ
        z3xE15fSJTypdATcudAE3ub/b6BYsO6mgi4WEQ==
X-Google-Smtp-Source: ABdhPJzmcV+9T4BOYZL9yyzPscKPz9ct+kzL7+78ybw2OrqunkEGa/Wxk94oESNvy8oQbfWj8DD4LjEjvLDexy9UwZ8=
X-Received: by 2002:a9d:c29:: with SMTP id 38mr2547303otr.107.1591797399576;
 Wed, 10 Jun 2020 06:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200601094512.50509-1-sudeep.holla@arm.com> <20200601094512.50509-2-sudeep.holla@arm.com>
 <20200609223551.GA1620273@bogus> <20200610074346.GB15939@willie-the-truck>
In-Reply-To: <20200610074346.GB15939@willie-the-truck>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 10 Jun 2020 07:56:28 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKFDBmyAVjWR9ZxOjU6j2fcCOz32rnnUwBAQzzh-vMa_A@mail.gmail.com>
Message-ID: <CAL_JsqKFDBmyAVjWR9ZxOjU6j2fcCOz32rnnUwBAQzzh-vMa_A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] dt-bindings: Add ARM PSA FF binding for
 non-secure VM partitions
To:     Will Deacon <will@kernel.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 1:43 AM Will Deacon <will@kernel.org> wrote:
>
> On Tue, Jun 09, 2020 at 04:35:51PM -0600, Rob Herring wrote:
> > On Mon, Jun 01, 2020 at 10:45:10AM +0100, Sudeep Holla wrote:
> > > Add devicetree bindings for a Arm PSA FF-A compliant non-secure partition
> > > at virtual interface(VMs).
> > >
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >  .../devicetree/bindings/arm/arm,psa-ffa.txt   | 47 +++++++++++++++++++
> > >  1 file changed, 47 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/arm/arm,psa-ffa.txt
> >
> > I'm hoping this goes away if the firmware is discoverable, but if not DT
> > bindings are DT schema now.
>
> We'll need the binding for the kvm host side, because there are plenty
> of partition properties that are not discoverable (e.g. number of vCPUs).

BTW, there's already a partitioning binding for Power in ePAPR. I've
not paid much attention to it, but maybe it could be useful here.

Rob

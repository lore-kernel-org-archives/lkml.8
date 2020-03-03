Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD23C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77542073D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583252808;
	bh=vsJgbdruHgBK38fy10b+tkrHQs0nqfHXmYGGdSdCSeg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=vpo4RXzIYixMUzxJuHSgeRmtUtX/7AbaBPrDAYg+78l83BzVfZ8eyoBWuyZBN1zIV
	 aEvlJdhgL8d6eLn3lk1YsBbCiQVovZZ0UJVJfCbqLom3f2n/yMVDDQItdTKuYbleI/
	 K3kTyxdSahqvO2uTeztkYh7gG5u6TdMTfrX7Lb+E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbgCCQ0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:26:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:42444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729438AbgCCQ0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:26:46 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3770820838;
        Tue,  3 Mar 2020 16:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583252806;
        bh=vsJgbdruHgBK38fy10b+tkrHQs0nqfHXmYGGdSdCSeg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pDllV1J8OXCSRDaFN2N41EicTiO4sV62Yiw/EnbjRRv7EEZ3gNFpH1qclkwO2g6wx
         HvD54cok0M1NIkhdv04OBgkG+Pso+gq/5VSuSerEDjxALhgxpWDCv9XHEsWS3VO9ux
         +bfMDfUflURBCeKcEAC3KUGbezLqZaH9wpY2VXm8=
Received: by mail-qt1-f179.google.com with SMTP id v22so3234512qtp.10;
        Tue, 03 Mar 2020 08:26:46 -0800 (PST)
X-Gm-Message-State: ANhLgQ17n/u1E+g/nxy3/Y9n54dJaKJ5733L+IAGs/oCvuD6yNhah3jF
        BvwhKVRJ6ivXWBITcyo0HZHkUPeQsUhj5T7pKg==
X-Google-Smtp-Source: ADFU+vv6Z0CBR5iu3C7uWQHlG/BBUbvUvPQTZbGd9V3M1spWP53cW66vgSQC33LfMLGBhIwiJL3sMSwIm1iScABBrMY=
X-Received: by 2002:ac8:7c9b:: with SMTP id y27mr5318510qtv.300.1583252805245;
 Tue, 03 Mar 2020 08:26:45 -0800 (PST)
MIME-Version: 1.0
References: <cover.1583127977.git.eswara.kota@linux.intel.com>
 <9f049a5fccd080bd5d8e9a697b96d4c40a413a0a.1583127977.git.eswara.kota@linux.intel.com>
 <20200303015051.GA780@bogus> <5b71670d-91a6-9760-f4da-1b6f014a1ea2@linux.intel.com>
In-Reply-To: <5b71670d-91a6-9760-f4da-1b6f014a1ea2@linux.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 3 Mar 2020 10:26:33 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLKFbaiaeNAq_b9xDQRWVG8dXkWt2+cKucRPEzynC20XQ@mail.gmail.com>
Message-ID: <CAL_JsqLKFbaiaeNAq_b9xDQRWVG8dXkWt2+cKucRPEzynC20XQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] dt-bindings: phy: Add YAML schemas for Intel Combophy
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 3:24 AM Dilip Kota <eswara.kota@linux.intel.com> wrote:
>
>
> On 3/3/2020 9:50 AM, Rob Herring wrote:
> > On Mon, Mar 02, 2020 at 04:43:24PM +0800, Dilip Kota wrote:
> >> Combophy subsystem provides PHY support to various
> >> controllers, viz. PCIe, SATA and EMAC.
> >> Adding YAML schemas for the same.
> >>
> >> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
> >> ---
> >> Changes on v4:
> >>    No changes.
> ...
> >> +additionalProperties: false
> >> +
> >> +examples:
> >> +  - |
> >> +    #include <dt-bindings/phy/phy-intel-combophy.h>
> >> +    combophy@d0a00000 {
> >> +        compatible = "intel,combophy-lgm", "intel,combo-phy";
> >> +        clocks = <&cgu0 1>;
> >> +        reg = <0xd0a00000 0x40000>,
> >> +              <0xd0a40000 0x1000>;
> >> +        reg-names = "core", "app";
> >> +        resets = <&rcu0 0x50 6>,
> >> +                 <&rcu0 0x50 17>;
> >> +        reset-names = "phy", "core";
> >> +        intel,syscfg = <&sysconf 0>;
> >> +        intel,hsio = <&hsiol 0>;
> >> +        intel,phy-mode = <COMBO_PHY_PCIE>;
> >> +
> >> +        phy@0 {
> > You need a 'reg' property to go with a unit-address.
> >
> > Really, I'd just simplify this to make parent 'resets' be 4 entries and
> > put '#phy-cells = <1>;' in the parent. Then you don't need these child
> > nodes.
> If child nodes are not present, use case like PCIe controller-0 using
> phy@0 and PCIe controller-1 using phy@1 wont be possible.

Yes, it will be.

For controller-0:
phys = <&phy 0>;

For controller-1:
phys = <&phy 1>;

Rob

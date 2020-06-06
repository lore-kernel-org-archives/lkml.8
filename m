Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E64C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 18:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFF94207BC
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 18:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591466992;
	bh=AdXh9USGqvK423RTVtesYTVU/mTWb+DOmiL4fy4PjZ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=E9WOKtKT9Su97XGx3GE+9OM2zCS1i1uXOLGoew/WlRCJP52xpohJdrjnK7p3kTBsE
	 D38hoiP8WwH5HIFQniS5tIvqa+f/vmwiuGwvlvNY4thRL6Z2Rl0v+JpZoePN9jjjzp
	 T4EZFOByh7qWkTP7qmqVoyBSw/7h/0pXVRiw+dN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgFFSJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 14:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728788AbgFFSJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 14:09:47 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E16DC08C5C2
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 11:09:47 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a25so15656079ljp.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 11:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rfZS6FD3PVKTeFod390EA9OFYChxy7azm74/xGOYsC8=;
        b=DgKPeLGSSTDInt10KbPCgP/rEDD+SgAJgEOpT14iuC7S68iv3fc74iAjfj9WZwuQ+d
         IqXb0HmIOILsKK7OCe3VsJaTzPGBsuOsqIQmnh5yznNkRCCilV2PA6SxzfGNjIy9nRZj
         S+Nb/3+/qsy0PuBAn7+aTt/7b4XFUNq/GACwQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rfZS6FD3PVKTeFod390EA9OFYChxy7azm74/xGOYsC8=;
        b=N2unQ3Dhp9FA5XZ/+FpUDXAXql/PfnplgKwpw0qtWojXPlFRDwuxb8D/OVC+EfYDhw
         WYe6KtllfIMxqFopCeXmFgEeer19g0NgarSuTFfGwOB/3JH7aLAynavksSWUvhT3/XEm
         NAWJ9wh5FAGMecnxAmQTd4eV1ng7An1EL49MMwao88wPqRBQoNx7wmYtR8B8HGI5noh9
         U6i4FMvKsYkSiYX1itlhFRKikFk9Mks938Ax5dlrkLwfaEG6BNS+DMaxM8DLCtJiApKR
         sn4Ln77g/3Mmqpb6Zj4cjNAphbOuFzCOXtgFZdyraW/PIdwO5mZbOUzAy8hwkE1RGmVw
         KWyA==
X-Gm-Message-State: AOAM5323swQ7khqHaL9XrcPr65F9t44WVscChFiCzx+7YAW1VZRhJhH2
        8dS/ot696o92UuTSH1qfCFhpCLDrD+o=
X-Google-Smtp-Source: ABdhPJwmbpOfy04J/heXu/JMBcDGlIIgaBlaVdXCrnyjjSpcDJ+2Rxf37MiudrxwH7SEZCq7on9sIg==
X-Received: by 2002:a2e:b8d4:: with SMTP id s20mr7570282ljp.177.1591466984700;
        Sat, 06 Jun 2020 11:09:44 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id k27sm2411528lfe.88.2020.06.06.11.09.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Jun 2020 11:09:43 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id c17so15610415lji.11
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 11:09:43 -0700 (PDT)
X-Received: by 2002:a2e:97c3:: with SMTP id m3mr7519625ljj.312.1591466982709;
 Sat, 06 Jun 2020 11:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200605202257.GA1152522@bjorn-Precision-5520>
In-Reply-To: <20200605202257.GA1152522@bjorn-Precision-5520>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 6 Jun 2020 11:09:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wien36zOp4aqf6XULz+7uM5rtxUb21xh8PGbTa-gL06aQ@mail.gmail.com>
Message-ID: <CAHk-=wien36zOp4aqf6XULz+7uM5rtxUb21xh8PGbTa-gL06aQ@mail.gmail.com>
Subject: Re: [GIT PULL] PCI changes for v5.8
To:     Bjorn Helgaas <helgaas@kernel.org>, Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 1:23 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> You should see two conflicts:
>
>   2) Documentation/devicetree/bindings/pci/cdns-pcie.yaml: conflict
>   between Rob's 3d21a4609335 ("dt-bindings: Remove cases of 'allOf'
>   containing a '$ref'") and Kishon's fb5f8f3ca5f8 ("dt-bindings: PCI:
>   cadence: Deprecate inbound/outbound specific bindings").
>
>   Kishon moved a hunk from cdns-pcie.yaml to cdns-pcie-ep.yaml and
>   cdns-pcie-host.yaml, so I think the new homes need Rob's change:
>
>     Documentation/devicetree/bindings/pci/cdns-pcie-ep.yaml
>     Documentation/devicetree/bindings/pci/cdns-pcie-host.yaml

I decided not to touch those two files, because the AllOf rules seem
strange, and not all were updated anyway, so I'm going to leave it to
others (ie Rob) to decide how they want to handle it.

I suspect your resolution is correct, but I also suspect it doesn't
_matter_, and since I don't understand the yaml rules I'll leave it
alone.

Rob?

              Linus

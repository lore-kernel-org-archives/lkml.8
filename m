Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4E0C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:16:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 815542075B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:16:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731069AbgGOKQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 06:16:11 -0400
Received: from mga05.intel.com ([192.55.52.43]:28453 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731040AbgGOKQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 06:16:10 -0400
IronPort-SDR: OPfbpLpCV5grY8BPlL/UXQkBUCqgtdqgi5bTLDFwv5qvC3B5s12F9DUxTWpJ/D7FYsELcjX6b0
 Zo9grfEfCZjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9682"; a="233972800"
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="233972800"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 03:16:10 -0700
IronPort-SDR: 5o2eJmdEkhntRPy8p6mMqA9SHZt1y0LbPbDRzfnij5q/4e31dpagqBYlogvp8vubmFNSujOx+s
 g/J3bjufbzuw==
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="460017463"
Received: from ykazandz-mobl1.ger.corp.intel.com ([10.251.85.102])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 03:16:05 -0700
Message-ID: <a4a2d3af6afcae5f368e0e6e1353f3a4743198cd.camel@linux.intel.com>
Subject: Re: [PATCH v3 2/7] dt-bindings: arm: Add Keem Bay bindings
From:   Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
To:     Rob Herring <robh@kernel.org>
List-Id: <soc.lore.kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, SoC Team <soc@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Date:   Wed, 15 Jul 2020 11:15:56 +0100
In-Reply-To: <20200714211122.GA2921587@bogus>
References: <20200714161305.836348-1-daniele.alessandrelli@linux.intel.com>
         <20200714161305.836348-3-daniele.alessandrelli@linux.intel.com>
         <20200714211122.GA2921587@bogus>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-14 at 15:11 -0600, Rob Herring wrote:
> On Tue, Jul 14, 2020 at 05:13:00PM +0100, Daniele Alessandrelli
> wrote:
> > From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > 
> > Document Intel Movidius SoC code-named Keem Bay, along with the
> > Keem Bay
> > EVM board.
> > 
> > Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
> > Signed-off-by: Daniele Alessandrelli <
> > daniele.alessandrelli@intel.com>
> > ---
> >  .../devicetree/bindings/arm/keembay.yaml      | 19
> > +++++++++++++++++++
> 
> /intel,keembay.yaml
> 
> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Thanks. I fixed the file name and the "$id:" field below and will re-
submit with your "Reviewed-by" tag.

> 
> >  1 file changed, 19 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/arm/keembay.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/keembay.yaml
> > b/Documentation/devicetree/bindings/arm/keembay.yaml
> > new file mode 100644
> > index 000000000000..f81b110046ca
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/keembay.yaml
> > @@ -0,0 +1,19 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/keembay.yaml#
> 
> And don't forget this update.
> 
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Keem Bay platform device tree bindings
> > +
> > +maintainers:
> > +  - Paul J. Murphy <paul.j.murphy@intel.com>
> > +  - Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +        - intel,keembay-evm
> > +      - const: intel,keembay
> > +...
> > -- 
> > 2.26.2
> > 


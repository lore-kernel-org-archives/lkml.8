Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86387C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDA520746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgCMM11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:27:27 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:60628 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbgCMM11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:27:27 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id D2E2C80307C4;
        Fri, 13 Mar 2020 12:27:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Dm24oyUx6UoH; Fri, 13 Mar 2020 15:27:23 +0300 (MSK)
Date:   Fri, 13 Mar 2020 15:26:34 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: syscon: Add syscon endian properties
 support
Message-ID: <20200313122634.lfdharbhxvnoew6r@ubsrv2.baikal.int>
References: <20200306130341.9585-1-Sergey.Semin@baikalelectronics.ru>
 <20200306130356.D9FCD8030794@mail.baikalelectronics.ru>
 <20200312211102.GA21647@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200312211102.GA21647@bogus>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 04:11:02PM -0500, Rob Herring wrote:
> On Fri, Mar 06, 2020 at 04:03:38PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > In accordance with the syscon-driver (drivers/mfd/syscon.c) the syscon
> > dts-nodes may accept endian properties of the boolean type: little-endian,
> > big-endian, native-endian. Lets make sure that syscon bindings json-schema
> > also supports them.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Paul Burton <paulburton@kernel.org>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > ---
> >  Documentation/devicetree/bindings/mfd/syscon.yaml | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> > index 39375e4313d2..9ee404991533 100644
> > --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> > @@ -61,6 +61,11 @@ properties:
> >      description:
> >        Reference to a phandle of a hardware spinlock provider node.
> >  
> > +patternProperties:
> > +  "^(big|little|native)-endian$":
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: Bytes order of the system controller memory space.
> 
> Common properties should have a type definition in a common schema. For 
> this one, I'd like it in the core schema in dtschema. 

So what do you suggest then? Will you move this file to the dt-scheme/schemas
in your repo? What shall I do with this patch, just drop? Or would you like me
to fork your dt-schema repo, add dt-schemas/schemas/mfd/syscon.yaml file similar
to this one with "*-endian" property supported, then pull-request or
send a patch with the alteration back to your repo?

> 
> I'd expect for any specific 'syscon', either none or only a subset of 
> these are valid, so I don't think this should be added here.

AFAIU mfd/syscon.yaml describes a generic syscon compatible with generic
driver drivers/mfd/syscon.c, which may have any of these properties
declared in its dt-node. We can't predict which one because, well, it's
generic. At the same time, yes, only a subset of these properties can be
supported by a specific system controller, which one can be determined
by the controller specific dt schema. So if we left the property here in
the generic syscon.yaml, then the controller dt-schema would have had a
pattern like:

>
> allOf:
>   - $ref: ../../mfd/syscon.yaml#
>
> properties:
>   little-endian: true
>
> additionalProperties: false
>

as I did for soc/baikal-t1/be,bt1-l2-ctl.yaml. See the patch: "dt-bindings:
Add Baikal-T1 L2-cache Control Block dts bindings file" in the corresponding
patchset in your email Inbox.

Regards,
-Sergey

> 
> Rob

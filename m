Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA76C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 303EA2073E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 09:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgCMJlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 05:41:04 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:60082 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgCMJlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 05:41:03 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 7CA7B8030886;
        Fri, 13 Mar 2020 09:41:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id teOI_MFyEwyH; Fri, 13 Mar 2020 12:40:59 +0300 (MSK)
Date:   Fri, 13 Mar 2020 12:40:17 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/22] dt-bindings: Add vendor prefix for Baikal
 Electronics, JSC
Message-ID: <20200313094017.y7nko4sx2dfcadnp@ubsrv2.baikal.int>
References: <20200306124705.6595-1-Sergey.Semin@baikalelectronics.ru>
 <20200306124832.986FE8030793@mail.baikalelectronics.ru>
 <20200312204406.GA4654@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200312204406.GA4654@bogus>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 03:44:06PM -0500, Rob Herring wrote:
> On Fri, Mar 06, 2020 at 03:46:47PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > From: Serge Semin <fancer.lancer@gmail.com>
> > 
> > Add "BAIKAL ELECTRONICS, JSC" to the list of devicetree vendor prefixes
> > as "be".
> > 
> > Website: http://www.baikalelectronics.com
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Paul Burton <paulburton@kernel.org>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > ---
> >  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > index 9e67944bec9c..8568713396af 100644
> > --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> > @@ -141,6 +141,8 @@ patternProperties:
> >      description: Shenzhen AZW Technology Co., Ltd.
> >    "^bananapi,.*":
> >      description: BIPAI KEJI LIMITED
> > +  "^be,.*":
> > +    description: BAIKAL ELECTRONICS, JSC
> 
> Also, is 'be' a well known abbreviation for this company. Perhaps 
> 'baikal' instead?
> 

Hm, I don't think that baikal is a well known synonym of the company
either. Seeing the company isn't well known in general.) Here the
'Baikal' name is mostly associated with the deepest lake in the world.)

We had a discussion amongst our team developers what abbreviation to choose.
Some of us suggested to use 'baikal' prefix too. But after all we agreed to
set the 'be' one as being short and yet compatible with company name. However
it's unlikely that developers looking at vendor prefix would think of a lake
first and, you are right, that 'baikal' word would point to the original
company name better than 'be'. On the other hand the chips the company
produces also have 'baikal' in their names: Baikal-T1, Baikal-M1, etc.
So the compatible strings of the SoC components either would look like:
- be,bt1; be,baikal-t1 (SoC/machine compatible strings)
- be,bt1-i2c; be,bt1-pvt; be,bt1-efuse; be,bt1-axi-ic; etc (individual
  SoC subdevices compatible strings)
or
- baikal,bt1; baikal,baikal-t1
- baikal,bt1-i2c; baikal,bt1-pvt; baikal,bt1-efuse; baikal,bt1-axi-ic; etc

First version seemed less cumbersome, having less 'baikal' in the
compatible strings. In the second case the vendor prefix turned to be
longer than the rest of the component name, which is supposed to be the
main part of the string.

So you think 'baikal' would be better anyway? It would be great to hear
your opinion about this in details, because we still have doubts which
prefix is better.

(I'm so persistent in describing why we chose 'be' prefix, because in
case of changing it to 'baikal' I would have to alter all the drivers
we wrote, which you must agree isn't that pleasant work.)

-Sergey

> >    "^bhf,.*":
> >      description: Beckhoff Automation GmbH & Co. KG
> >    "^bitmain,.*":
> > -- 
> > 2.25.1
> > 

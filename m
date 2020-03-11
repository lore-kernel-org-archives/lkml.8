Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	PDS_HP_HELO_NORDNS,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_PASS,SPF_NONE,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail-db8eur05on2056.outbound.protection.outlook.com ([40.107.20.56]:6017
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727307AbgCKDWh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 23:22:37 -0400
From: Robin Gong <yibin.gong@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "martin.fuzzey@flowbird.group" <martin.fuzzey@flowbird.group>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [RESEND v6  08/13] spi: imx: add new i.mx6ul compatible name in
 binding doc
Date: Wed, 11 Mar 2020 03:22:33 +0000
Message-ID:
 <VE1PR04MB6638FF9C3ED1A93FD5A6C2C289FC0@VE1PR04MB6638.eurprd04.prod.outlook.com>
References: <1583839922-22699-1-git-send-email-yibin.gong@nxp.com>
 <1583839922-22699-9-git-send-email-yibin.gong@nxp.com>
 <20200310184103.GA2192@bogus>
In-Reply-To: <20200310184103.GA2192@bogus>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
Message-ID: <20200311032233.F1mtwwb2I6bxF0kqWviJnFeqh6PIdaPs2q07JZnDw-w@z>

On 2020/03/11 Rob Herring <robh@kernel.org> wrote:
> On Tue, 10 Mar 2020 19:31:57 +0800, Robin Gong wrote:
> > ERR009165 fixed from i.mx6ul, add its compatible name in binding doc.
> >
> > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > Acked-by: Mark Brown <broonie@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
>=20
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>=20
> If a tag was not added on purpose, please state why and what changed.
Sorry, Rob, I forgot to add your reviewed tag on v5, will add it back incid=
entally in v7.


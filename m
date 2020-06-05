Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B531C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 580F52067B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=plvision.eu header.i=@plvision.eu header.b="bHvuv8RE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgFEKyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:54:03 -0400
Received: from mail-eopbgr00120.outbound.protection.outlook.com ([40.107.0.120]:21459
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726642AbgFEKyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:54:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YC2shG3a3rA4JlHyLF55VKnVq3gHZEtT19o9SLOWyoL540Q6d4BzZ7bxmm433vNHi6qgT3cUL2sjSPFmYkxqgXQuWaD6C/18/GdDCBqaTbJSuO9hmYHtUTDqzUT7kS3y67M87F9CTTA+jNHgioXv+y+7MyHEC5ky2hFoO24QwOX6b+fN8pe+Wzd+y5kTW+DHMvrA2Aw9eOY/ItTY2WTjzKNE4ymEkCIOkFQ72eXvLeMevxbelvN/M18B4pEOGPmvjLvZ+xlfT0Ws0zCQUNLDtoF1LEhMEJ5MFQwdWjFKGpT3TLVOGUHr1xls6l3u/YQuCK/new6HIFxLnelIdpEkLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAs0UJ28vlVT4dUuLneA5xFx1LaZx3GusZkk4HudTag=;
 b=OO9LDKZzN5tnU8Ls7Rb4vZINf1Z1psrvqc4MbwYi6Xr3XRNMtpXW4JU0vwbX8e9LjLxXeauUmeBUVg5UBVfAW2CB6cbM5YB2gciIamFwvvcDRNZxDHbyBhjMaavze83npt5hS7LzeiKPZqWz8JLZv+kZs7dLS7PkHFwuJ5z0OQfVN3DLZX8oKMdxl+fr//pxdicNwTxJIPMZ2V1P4Ez/E5sInwQa2GuHW1mk2vHrv42CfWL69IYSgTs7KzqVOJ4UEejsqYcPe7dV82dwJeabezI0FXL8eQsY3NHIaLYtNSKuW6FDtVjupKDIbdmgK1SKP9q6lspSZjD91IWCChOtlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eAs0UJ28vlVT4dUuLneA5xFx1LaZx3GusZkk4HudTag=;
 b=bHvuv8REY9yWzUuDU7qUOHN7OBxIX+aAx3BFw6aeMioPaurPYSlUjhJVoW2yOFusatcszlJqEuibSL4/dUptCPgJ/fMi5uRypqEsMw+7eD9PoY+cXArdxanJIIn1P7ZUlxwxlrJ4TRTF2BKEhxZJgZvKFOH38yfyBaqw0O+Zmdw=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0399.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:35::10)
 by VI1P190MB0415.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:32::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 10:53:58 +0000
Received: from VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 ([fe80::8149:8652:3746:574f]) by VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 ([fe80::8149:8652:3746:574f%7]) with mapi id 15.20.3066.018; Fri, 5 Jun 2020
 10:53:58 +0000
Date:   Fri, 5 Jun 2020 13:53:51 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Taras Chornyi <taras.chornyi@plvision.eu>
Subject: Re: [PATCH v2 2/2] nvmem: add ONIE NVMEM cells support
Message-ID: <20200605105351.GA1118@plvision.eu>
References: <20200529230451.21337-1-vadym.kochan@plvision.eu>
 <20200529230451.21337-3-vadym.kochan@plvision.eu>
 <8a8653c5-b112-4042-cbdf-8498e38d14ee@linaro.org>
 <20200601090300.GA21928@plvision.eu>
 <0d664272-4ef9-fe2c-02f4-60e9ecb41e20@linaro.org>
 <20200601102749.GA25323@plvision.eu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601102749.GA25323@plvision.eu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: AM6P191CA0001.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::14) To VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:35::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plvision.eu (217.20.186.93) by AM6P191CA0001.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8b::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Fri, 5 Jun 2020 10:53:57 +0000
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1b0269c-61e0-498c-f1f4-08d8093ebfb4
X-MS-TrafficTypeDiagnostic: VI1P190MB0415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1P190MB041553321056B970D2AEEB4E95860@VI1P190MB0415.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0425A67DEF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R3avPULzmW+9Idvx8y+d86c8oKMypw5XFkEjKrFA7gYvwtzUVNEpOIT6pJZt/akTJQd+hoAaScixekdwWQnJYlHYFq1F2k9zaBi3R0vaQSRgQ6BeIOBkH+paP86SizDtLFEP6bgXWfxpyxIocfZmrdWMsUvIBy20DBwH/NcJRuW2nXsEhpnT4F9YV1iK+raeomtjF9BO3//XTigGAqFM+V9YsifAwyNvceb3aSuZ1XroEa6BsTfdF/61QRD+TZKB3xuXYJ2f/MCAtLZ4d8QRHCCfiNXmYm4FMiK0Dwjpjgluha5r5nDdv30M30gH16X3wBUmaDZyO6XZYpSA+r59sA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0399.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39830400003)(346002)(396003)(136003)(376002)(83380400001)(33656002)(5660300002)(66476007)(2906002)(107886003)(36756003)(53546011)(316002)(66556008)(26005)(8936002)(16526019)(8676002)(6916009)(7696005)(1076003)(6666004)(52116002)(54906003)(8886007)(55016002)(186003)(508600001)(66946007)(2616005)(4326008)(86362001)(956004)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: hXPTq1rJaLqwZZiSXue0np+CGWBGiJ8a94lYo/hfd/BT2mbeYw9ZbRdf/+krOOyVxRUK1WH5sbvebp2g1BBsbqfHJRrvBJX3B65FM37+fWSvNYaoLeOrCKgyD0qCdjDZXrq5tGXdRlChhtuiflcfHEb6GH4ZxY+MRi23C75Bj6xVAkzLE8WhW/JD/0pBJX3HHyF8u7DLIgO8vncrNA57quU4YKfPfOVtAA/DCbNxZWyeJ/uvbAinqzYZk81K4Bi9vwOYvj62IDIt9XqV55IzQPu6pjONK3hMiJdpk0HwgK1q/VH2/O/sPSb4n+5SbcCKCQ2onM4GSUtcLgsuIY2hT//hGWAWc/tzv+Q55YP/9SBrc8qC3GhiHlisclHpTabgrmd9f8YjlS+c4pN9iT7uh709F9wKHD5Py/0OU7+t3KGWSv3zHAqOXfGX6CWxWQJob1xVCqmHvBX/yQjgajkhnDrMwby/CcXRDknjtob9ZYo=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b0269c-61e0-498c-f1f4-08d8093ebfb4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2020 10:53:58.4112
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I9Dj5c5HRV/Gbe8Ciz92dCErvoGBIi9hEF2BqdhY1j7pPo4h5HNCChUX5BtFpCq0h2YkF2LKwh3CYUFKH87jVUlQAOKml1ZPqzkcqSRIS2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0415
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On Mon, Jun 01, 2020 at 01:27:49PM +0300, Vadym Kochan wrote:
> On Mon, Jun 01, 2020 at 10:13:05AM +0100, Srinivas Kandagatla wrote:
> > 
> > 
> > On 01/06/2020 10:03, Vadym Kochan wrote:
> > > > > +
> > > > > +	nvmem = of_nvmem_device_get(np, NULL);
> > > > > +	if (IS_ERR(nvmem))
> > > > > +		return PTR_ERR(nvmem);
> > > > > +
> > > > TBH, this looks completely incorrect way to do this and misuse of nvmem
> > > > consumer interface.
> > > > 
> > > > Ideally nvmem provider driver should populate "cells" in struct nvmem_config
> > > > after decoding them and then register nvmem provider.
> > > > 
> > > > That should just work!
> > > > 
> > > > 
> > > > --srini
> > > But this is not nvmem provider but just describes the cells for any
> > > nvmem device, because ONIE uses special TLV structure on the nvmem
> > > device. So from the nvmem device point it is a consumer but provides the cells
> > > for the given device.
> > 
> > That still falls under nvmem providers responsibility to parse these cells
> > before registering it.
> OK, I thought that it is legal to have separate nvmem driver which
> provides access to the device itself, and other driver which describes the
> layout of the cells which might be applicable to any nvmem.
> 
> > 
> > BTW, where is the provider driver for this in kernel ?
> > 
> > 
> > --srini
> > 
> > > 
> One of the example is atmel eeprom (at24), but there might be different
> devices.
> 
> But can you please explain what is the technical/conceptual issue with
> this approach ?
> 
> Thanks,

I just I'd like to clarify if there is a way it can be acceptable. The
problem is that there is TLV format which  might be used on any nvmem
device which contains for example mac address which needs to be exposed
as nvmem cell. If to populate cells via nvmem_config then anyway I need
to parse these cells from the "target" nvmem device.

Thanks,

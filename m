Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D9FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 10:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59440206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 10:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=plvision.eu header.i=@plvision.eu header.b="kD62Apu6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgFAK2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 06:28:01 -0400
Received: from mail-eopbgr00091.outbound.protection.outlook.com ([40.107.0.91]:55031
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725788AbgFAK2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 06:28:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPIMQKSmAoGuaerUv4DXDLpRcsmdplBp6/qBo+OWHn1DROMNzUjjdOzOQWRWtirdMPkL5PQnN/oLcO3h4I9jLznLJwCFaztUGAB+1taRTn+hoWCg4y4Cuo2p0oUtXxZ+CyihsFDmhsLR4SCP+b3Xpgg6ifsBbO/oNmKhAzaicr/p0c6xZl1Il6AsnuFFio5UXvEZNXtXHs6gGfi6C0AAYaRq+qbhJgqwhZHa7F6hUilxswSzvcWZdStSVYQ7PleigojzTFplDLOLT3jcfeQf3FIGT+5TJNaeNtzk+dcdWVDdnQkCBUM+Hs4gq0LgLh6tWk42PnrvTAqHKSR2QJAJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZQF1M/ff9GQFpDDf9A1M3VK62c8+OePROKKdgbgOaA=;
 b=Ku5iJXW3Fuz8n9WG9+qq7AqZLDZG649ezmbt289FHRQ8bTxr9URnVuXxLEiLxi+e/56rz9R7Vhv8H60rW1GJU3CvD63T0J77AhPaEfxlFe53RIj+grWUPXrdPWs3GcLmZsymQwddIi7UC1wp3krBMYXaMuiEuQLgEVmT/wYa8d8ZDdkoeBJzachMpDU5e8ZRfyWQtYVOixsWugnkk2dLPszT3y6vLvxe3npMCME6x3k2RQKKXnthnUk1Ql+onSqlrGtvI/z3K6XqPLbfQJJRCpSN0ZwQRmr922Rj5PlupJzFxWj46q4GoBxyzV1UeQ+/eOZCE93/9D5Pxt+lXstkng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZQF1M/ff9GQFpDDf9A1M3VK62c8+OePROKKdgbgOaA=;
 b=kD62Apu6ipgP8Ixxp9NdjacROLVinDiSUe1CHaz1Dg2Tx3jr96SCi1xN9C82/kTYK/jMkdJR5c7RrY+xFo9e99XLuBcDDPYMUpPn1CuOyOUzaAnCBXIq2MCDBrI69g94h7r6c6SqARX9seeKLDaY/qH+P6glrDFNuRh8c2n07Ok=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0399.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:35::10)
 by VI1P190MB0512.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:2f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.21; Mon, 1 Jun
 2020 10:27:57 +0000
Received: from VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 ([fe80::8149:8652:3746:574f]) by VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 ([fe80::8149:8652:3746:574f%7]) with mapi id 15.20.3045.022; Mon, 1 Jun 2020
 10:27:57 +0000
Date:   Mon, 1 Jun 2020 13:27:49 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Taras Chornyi <taras.chornyi@plvision.eu>
Subject: Re: [PATCH v2 2/2] nvmem: add ONIE NVMEM cells support
Message-ID: <20200601102749.GA25323@plvision.eu>
References: <20200529230451.21337-1-vadym.kochan@plvision.eu>
 <20200529230451.21337-3-vadym.kochan@plvision.eu>
 <8a8653c5-b112-4042-cbdf-8498e38d14ee@linaro.org>
 <20200601090300.GA21928@plvision.eu>
 <0d664272-4ef9-fe2c-02f4-60e9ecb41e20@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d664272-4ef9-fe2c-02f4-60e9ecb41e20@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: AM6PR04CA0007.eurprd04.prod.outlook.com
 (2603:10a6:20b:92::20) To VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:35::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plvision.eu (217.20.186.93) by AM6PR04CA0007.eurprd04.prod.outlook.com (2603:10a6:20b:92::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Mon, 1 Jun 2020 10:27:56 +0000
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 043f6f2e-5d06-40bd-45b1-08d80616738e
X-MS-TrafficTypeDiagnostic: VI1P190MB0512:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1P190MB0512C4460180ABF1019123C5958A0@VI1P190MB0512.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uBhufkZSc+l1dgEvzM7ynpbDl564jzmKp8pQScw2E6veqMzvmgJbYFDdCPllUpC6cifHwfivGQ2oYwdEXe0eK09ohoUGJB5PQYIEwWoq9S5FYsEvjNHGKx1mjyBa7iw1WZmA0zscDEuunJ5gYdJsH2SjuyF4YM3A1CcSk3VK9y4MQ8CwZmvufbFz4R9Z7OB8/uQEGWjRJ0Hd9DohbfgO1KLh1nmyoQrV7wZ3WTE4cM24r1Q7rt0JtIXjMPcoxlXG4LgRp41ZHJ2XOcaN9HvzNF1SrY8ALBNToB4s5lvJAjVejoMF5ib2m9DpDssCmQA832mDFgubloU9qz7NC1EGMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0399.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(136003)(39830400003)(346002)(396003)(36756003)(55016002)(83380400001)(33656002)(8936002)(44832011)(86362001)(2616005)(107886003)(4326008)(956004)(508600001)(6916009)(26005)(54906003)(2906002)(53546011)(66556008)(8886007)(66476007)(186003)(66946007)(16526019)(6666004)(5660300002)(7696005)(316002)(52116002)(8676002)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 4aWhOWEqms7Z2XAW1/H+tMoCM8WY1GTKUWbGgo5YifYLSUMdlZG+ICcXizSYBTmjuxJ3xtrukylixLjbXONv51jHY25DYN+CTyHakUNTxm7o0N/CMZH5jdlI8gM8gcHD8IRZjgBdrNwA9FfQWFhJ3NRsu+q5bSE3NwOdE1iQRDVhOYR0ENrso5b+xsQwTyfmJurhFAGaY1oHwwgWbXiLWQyIJvxLh4S1GZXBh8z7gcl/bP+KArjmYQZlsIbFKRmpJSetbVdZQGyt/Khn7bDiL4wWiMnh3dFVUs8uO6phqk7eUx+XrnjE01DBT/HMwxdx3YAug/F2y6IDS5ArvCvt41T8YAH0z8552j9drlVMymqQ6P0skwubNLulfEotxfc6EtQhayywbbm+UCw9yTjvaa9Ua8DmNmcUjH0YcpRaeV/tzcQGBK786Lmedk8Zqx4Dgy7wcunyqG/jId73pHAk9XluIGWTfKphKraZghCPnuM=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 043f6f2e-5d06-40bd-45b1-08d80616738e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 10:27:57.2694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vXoEU9P1mg23VfO3MCAVUsKOAjTjRLs7hH7WtrR6Rr+lODA5salQ+gGXlG2toa50PthXsxqNLIlEvwwqzKCNn+m2uKfxhLu2WdDAe/7XIXA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 10:13:05AM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 01/06/2020 10:03, Vadym Kochan wrote:
> > > > +
> > > > +	nvmem = of_nvmem_device_get(np, NULL);
> > > > +	if (IS_ERR(nvmem))
> > > > +		return PTR_ERR(nvmem);
> > > > +
> > > TBH, this looks completely incorrect way to do this and misuse of nvmem
> > > consumer interface.
> > > 
> > > Ideally nvmem provider driver should populate "cells" in struct nvmem_config
> > > after decoding them and then register nvmem provider.
> > > 
> > > That should just work!
> > > 
> > > 
> > > --srini
> > But this is not nvmem provider but just describes the cells for any
> > nvmem device, because ONIE uses special TLV structure on the nvmem
> > device. So from the nvmem device point it is a consumer but provides the cells
> > for the given device.
> 
> That still falls under nvmem providers responsibility to parse these cells
> before registering it.
OK, I thought that it is legal to have separate nvmem driver which
provides access to the device itself, and other driver which describes the
layout of the cells which might be applicable to any nvmem.

> 
> BTW, where is the provider driver for this in kernel ?
> 
> 
> --srini
> 
> > 
One of the example is atmel eeprom (at24), but there might be different
devices.

But can you please explain what is the technical/conceptual issue with
this approach ?

Thanks,

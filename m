Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA25C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 04:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F1AC21883
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 04:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="r8xsncgV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MdCCv/HZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgGNEIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 00:08:37 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:30777 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgGNEIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 00:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594699738; x=1626235738;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=SRwsubRr2o7oCnz0+8wJ39l8zscgrTjLlpOsImSNGD4=;
  b=r8xsncgVvFWModKuVlqfaW3uw/CjWqRA4IF/xAD0LbmHl7JnCBY8BZTi
   G71ll5ppzM/Tj98jVr2ulaweFbXJ4EzWzy0rliPby/QWYeFBUj3eKIoU2
   EXGY4YmO/cRzu6jfcx+HKUd7qeszS2fHbZsUHG6q2vLzAev8vAQSxMnog
   GZi5hRHNRHXPlsUmj2JSbvAqSWfxS8E1pCN7BTCfhF6GWucXClNae8jX/
   IlOrmplwsEdv0WiHmLAWkZoFI6GpaglCqaZCkhszmoAbBV7XkBS2Onsc+
   zOHYQun2CiIbcoEf4b0IkcNZLSpI8lACCEJh9kbSMpap9a6sHdd4wJvJF
   A==;
IronPort-SDR: r2SNe48TsdKiei1fVQO1CgyiCKwR6l0LFIJlIndAQbkqwsJJfhmiDtqhGanyO5fMIj2ZbCR6po
 rRmgkV8cFvA+YlD916hMG98OI5rVeVzYfgd9XHDHystPOG52PAbmTL8HwLcmr25fVHhCLZlrTH
 RTr/yFip4vu9WVPKX7scyhES5Q1HBR0lT38GqEl+1n6tls9hiCGI46FjiKshXIjJWE/u0VRW/u
 wTXjXd8+glWqfWVyOLHmY3rieF3qZ9/raaSKDxDodyA9PkIIdsy0TG+Qjb0v+XI308bnoQ/7eU
 +fM=
X-IronPort-AV: E=Sophos;i="5.75,350,1589212800"; 
   d="scan'208";a="245408240"
Received: from mail-cys01nam02lp2056.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.56])
  by ob1.hgst.iphmx.com with ESMTP; 14 Jul 2020 12:08:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmMse8G0mD0biv+zUwI4CEv8XabPHE9YmCucjQXjlBxNmyhzKLy7ZDLkY9KIuJgRbVqycJt26RQwejWYtOHfxBBCQc18TdKs+uEzB+4zwHyAq250BVmZPzCZ/FMqefFtKfLZsdUM8RBHdk3aXPrZBc9gfUANoTW+QsufDo1RYGwys3m1m+4wQKU3vZjlNZnZ4p0JSmo/8q7CCGBFccTX+5vR03ECJNMWIasyyGWJiy1k7b4sgvBJTN7LJJ5ufpTRoYsWQaVoLBRICCPDybJf2ijccjKHK1xULYnAGi+REjb/fhFyB1AnJb8mG7Hwb9/Gyh4xJq1ayMfiqsoCfNA89A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRwsubRr2o7oCnz0+8wJ39l8zscgrTjLlpOsImSNGD4=;
 b=LsNI+ZtW2lVJcimwXgo0M/4vP1galjf5sx86Ag2LmXCPBe57KiNJCNmo83neHkv1zbIIhei6MrnNnsty6PwF1GEvyXty1Kk+/Lpr/7aYxBVnO27uSPOa98ca/xV0KxLN6XSiWujgTRkHaAJE//HlyFpeXk/wl/F+WXToCwUcXK9yTSTkJDlCxBGkvTytodt9yyQ7m5RSf4N+WrnLaA039GPaP1NR56XJjBrJlYkp1p8+bWt9oXxQ1IZYe7iP6hwRiwtBcEwQa2hC/b0AKwxO2TceAIq41ZJQXOcqqCRUKv9LM6UZ9jMcN3T1ES08NxuOXehdCvIdmJWska12xORJiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRwsubRr2o7oCnz0+8wJ39l8zscgrTjLlpOsImSNGD4=;
 b=MdCCv/HZJZTTqBNMxgvZFFuxW37QsdKNaYg9UU0DFQ9DNMUOPq6FGExcyA3TBNA52rv0kVQm5y1CKBafCplSiy5ZsZuBA5tQt4mKk0OYGktoJ1oh7JwsMkQZFXmapvysuhdIvYdvE3EWTf6xZjPBfxhNqR8Kzjy9O8vmjdoUeeA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7121.namprd04.prod.outlook.com (2603:10b6:a03:223::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 04:08:33 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 04:08:33 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>
CC:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "baolin.wang7@gmail.com" <baolin.wang7@gmail.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: Remove redundant validation in nvme_start_ctrl()
Thread-Topic: [PATCH] nvme: Remove redundant validation in nvme_start_ctrl()
Thread-Index: AQHWWN9KvInmw7yU802p8iILluvbIQ==
Date:   Tue, 14 Jul 2020 04:08:33 +0000
Message-ID: <BYAPR04MB4965DF607DCD4F59EAAD873186610@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <710eb90d9c1c125bdb37aae31ddc41a0f9782fa6.1594621435.git.baolin.wang@linux.alibaba.com>
 <BYAPR04MB49655C05950BC7BDAD30629F86600@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20200714032352.GA111285@VM20190228-100.tbsite.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 22181cfd-16bc-460f-63ac-08d827ab936a
x-ms-traffictypediagnostic: BY5PR04MB7121:
x-microsoft-antispam-prvs: <BY5PR04MB71211EC1A9C2730D72EB750986610@BY5PR04MB7121.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8+dZe8yQNeR5ssqBDOaGRHwajTDTQOqqqEyNBJ8iSa+Y6G7ulZihHeAutr8ZkbqaxTwxIAH23Z+5shNjwyB/3nFNX95cBtzycKwQzrrs/YxUJZ+JdmuYbbCm+UAj3Nq2wUMdslTFgUv351jgILNoNi2CfUJYFtosglzYMRINKEQM8NG2yO5+n88RTm+muEykIy5PoD2xsr2pwmCjCbAmwzp7zPl3Az/zwpm3JLsGb8pL0SYkTz8U5NbV8UHTw8L6c4wO23B06jGAVhqIyiFEBonYsIP8bn8upLNUXjIsSOFK20RRhdTxIUcsJmUyDBdfvHUKlsNbBhxvnH6EHOnTFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(478600001)(8936002)(110136005)(7696005)(76116006)(9686003)(52536014)(54906003)(55016002)(316002)(66946007)(66556008)(2906002)(64756008)(66446008)(66476007)(186003)(5660300002)(8676002)(6506007)(4326008)(26005)(86362001)(53546011)(4744005)(71200400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 4VcdoItiOrMc6X7HBtfifLYRRN2zqWqKlqJ8w1Xrk4rvmTHoy2eYxwaaGoAdKr8bUz8xMJ+6ukJcqqcfHo62pxzQx5sRn3SFL3WrVI/T4gW8lJOLpyas+ex4fkPiQc+xbEFG6zaI03M8wcnZ/r9W9h7vIiDsvYncFgJLaiVd5GY58LwcKT007bI8MZ13wWIun5HVV/OJLe+2Lnc6rqFqDP8nCajItaLS/sqt5840lr/mAnmjz3tWepzmFyJLrDywE/4ORuXLxF0L9KAw5sQZp2rnjGYPDRxaW5rce5XRWqEYUmKu16Fwuc50K7tb8Sa/4JDsNByb3HsdDNUQ6BgoBGdGvIXI4Bw70n9ZdafRq1kkbcD1hMQ/IIvq44SENJFsas2L9+aB2f20hrhMSsAAfNdx893OmmoX4TtqvPTsUxb3HuP+g4LARcFsuIj7Q+yZGPFDUh2ugHHtQMHwWvJ2BWOf/PRGHwOPADOtPJh9/SM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22181cfd-16bc-460f-63ac-08d827ab936a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 04:08:33.7330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SWB6uduIIz0eGDEm97bduSnRzbPxIAGCXmasP9tuLgaNJnQD8GHlpFAVBL+sY/iak5fTS/EIJvAmxrYQ4dEheJYH//7FedrboSX8ucc9/9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7121
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/20 20:24, Baolin Wang wrote:=0A=
>> Since start keep alive is so small to make a function call how about we=
=0A=
>> in-line the call ? untested patch :-=0A=
> I am Okay about your suggestion. Will send v2 with your suggested-by tag=
=0A=
> if no other objection. Thanks.=0A=
> =0A=
=0A=
Keith, Christoph are you guys okay with this ? OR we want to keep the =0A=
small helpers ?=0A=

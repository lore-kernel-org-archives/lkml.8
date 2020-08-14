Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4218DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 114CD20B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 11:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=plvision.eu header.i=@plvision.eu header.b="YHDuDjSO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgHNL47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 07:56:59 -0400
Received: from mail-vi1eur05on2107.outbound.protection.outlook.com ([40.107.21.107]:48986
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbgHNL45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 07:56:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jzWL8k002HxzSFOlRe67mUTHBMRq5yEgzBywoJiSvzqYfjZ5pcyKqYRI/Eo4JONMMeY+yIlsU4Aes63Z+egqNFypdR0zQb6BniSxBzt6C0SCv32fEcfJPngPF5Em3Ur+OTvjod1+Ll6OmRVlyGnFgq5orlZcBishKWhYlTNe3vDhF3NqKQjCObTg+VMfOVzcvl4gtXnUpXE31qOSLgyetmRJrXApTIPJpqBX2nH/nZD2UWQa+H29dT1jeRyh91v/WuUor7AdxfBHKMZtue6ZzIf1IfkEas7OkTTzPYm5ZYOFd1vnP57TpET8INw7XCqbX1MM0SPJ+p2iKiDQZqBW+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFUyassX0b4UZaVJEB/lmLG+G53Bdx79rn/Kd9756ng=;
 b=Lz11LiU1TOz5/8voI7rmweOQpJO8PLAGEVv9myGR0oHxv8CulYmRoHWwDlbWxPT7ax73MAoqBAC67piWCsgkz+wFWZQfPTdXevwm29+d2fMDlMu9/wsx8hcraszX2WMUqfW0DJavqVGWfCVOpMouZBoMougBWpuOe2uRwf3danNC4hS6KPXL7C/dJ75CLUkwEzKxI/i4Y7HrNH0j5BRGj2Gm7SQI91LdU0v0fVzcLyEQzcqClCJUqKSow0mNPX6PZrS84DJW6DQM7NrlTqvEc1xU87dvwlfxkm0yhdGjRpR0KeLXM9bYxdPpAqJvefYwBx2Ai+XWDY2YGepuNIFH7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFUyassX0b4UZaVJEB/lmLG+G53Bdx79rn/Kd9756ng=;
 b=YHDuDjSOrZyjggd7TyUhKsw5KvsuabIJl6MH0n+fWVfGDf//t25UK/MVSeHrPmQY4jOoy5r7CrMcHvtIgBObS8fBJRGx6X1+X+aoHZ8ODQ6UUm/WH95v+d0hmU+gEZ2a/K/P/oT921kYp20c+2MVfvn6oDYQUmpvFo3q9qs+QOk=
Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=plvision.eu;
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:56::28) by
 HE1P190MB0332.EURP190.PROD.OUTLOOK.COM (2603:10a6:7:62::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Fri, 14 Aug 2020 11:56:53 +0000
Received: from HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::b1a4:e5e3:a12b:1305]) by HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 ([fe80::b1a4:e5e3:a12b:1305%6]) with mapi id 15.20.3283.018; Fri, 14 Aug 2020
 11:56:53 +0000
Date:   Fri, 14 Aug 2020 14:56:50 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Taras Chornyi <taras.chornyi@plvision.eu>
Subject: Re: [PATCH v2 2/2] nvmem: add ONIE NVMEM cells support
Message-ID: <20200814115650.GE17795@plvision.eu>
References: <20200529230451.21337-1-vadym.kochan@plvision.eu>
 <20200529230451.21337-3-vadym.kochan@plvision.eu>
 <8a8653c5-b112-4042-cbdf-8498e38d14ee@linaro.org>
 <20200601090300.GA21928@plvision.eu>
 <0d664272-4ef9-fe2c-02f4-60e9ecb41e20@linaro.org>
 <20200601102749.GA25323@plvision.eu>
 <20200605105351.GA1118@plvision.eu>
 <9f73d7ea-1f1f-9820-a9d1-55baa984873e@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f73d7ea-1f1f-9820-a9d1-55baa984873e@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: AM6P194CA0068.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::45) To HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:7:56::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plvision.eu (217.20.186.93) by AM6P194CA0068.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend Transport; Fri, 14 Aug 2020 11:56:52 +0000
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62d7e0b4-b20a-4107-00e1-08d8404922bd
X-MS-TrafficTypeDiagnostic: HE1P190MB0332:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1P190MB0332FB03ADB16923EB51F6EE95400@HE1P190MB0332.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xS1vaIoyX2O3YbjVFPzdAdSdzQGc/HaoFKunqAcW9aS+emjU7CVBaCFcd5zmPy7EVjPKSHupRC9WSTgNW1oBfgRzB1251QayWHxti8LLnKXU6yhZBkvIaIxb6LLaCJDlFEZTE35PJplgt3TIa3ut9ZFPfWwlRmbqSvoAFMj28lCn36hmiTUfo3DLW1NXGlwqinAcj1khIhGLDf9pHvDT6rKEZ3dCZh42s5b2FNqDqkPVwwDTuaAtDjCuUf2Y1oNqxePm8hCOxa5N+IphMoj7280rEuW8WqTWaj/E9pIpaFIq+K5kZsa+/SulR/eThjOPccb7RvXhcll5jLirIm5qNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1P190MB0539.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39830400003)(376002)(346002)(396003)(136003)(86362001)(54906003)(55016002)(2906002)(1076003)(36756003)(186003)(16526019)(7696005)(8886007)(6916009)(33656002)(66476007)(2616005)(66556008)(956004)(508600001)(66946007)(5660300002)(26005)(53546011)(52116002)(316002)(107886003)(4326008)(44832011)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: yiHjSD7VIlmcMrXzGmCHxPB3u9nktcOQaFpqGzVdZhnAdUz47rhbfqMp65YokAYCxvMw1KMCueqPOWaIo3q/Rhi18UkB9d8keC50LSmgLupSZj+rO0qkKOQdfmYiATmtOKg9EPgWKo52Dgegg2yg12cztIsuDk6/OAS3edCXwcCMLW7KkYbDPouEPI3CPGloPR3f9dYEPq9QLHbnZoHDgbxqUl1zKAh8BzdvDp9/A43FohCBaP3XUDTbZ5jn6f2h6vZtngXkMJzs7d3O+sDI2Vc9RnQ8LylAXRkbBcom9yScUJGdmgLGpcAsXFwGJPXI1MWmOy3wXJ0vb5PqB0iB1RlDMAcCwWaSsaxcVWXTYeD2/gzLh2n4dLsY9Kb/ZAKYJ12eoHOkKWr8APsMo39WF79hQNMxujwPWZ8XahUDmIs9v4/NxkjdXgaI3CIt4Y/0maA6jnlhQrFbhtRTCiV5RWrhkTP1Mwo1cPO7+Vzf0KHwrlLyKhJ0kH5eR4hfaDVzloglEoroAm2j6xV+P7s93RayILXUzXZHnnRPInw+Vw4SbPoAy84F7d5xCmo1mwdPAoIN47SoA/8aijhysNCT5eq1R6LOm1gSVViUqNZ5gz04xcko0GZjYR9jWFkUApP55/rW0iv03i0IG8WIH0lAiQ==
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d7e0b4-b20a-4107-00e1-08d8404922bd
X-MS-Exchange-CrossTenant-AuthSource: HE1P190MB0539.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2020 11:56:53.7464
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M1PohuwzGZtCECJqWKuh664qFm70smNLvQUglhDCShremxIOtwjul9a0l3sG428ZX25rSRjIg8tgQwlW1nV1VBhdQbQKVkUyKppvmk3bEpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1P190MB0332
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

On Mon, Jun 15, 2020 at 12:06:11PM +0100, Srinivas Kandagatla wrote:
> 
> 
> On 05/06/2020 11:53, Vadym Kochan wrote:
> > > One of the example is atmel eeprom (at24), but there might be different
> > > devices.
> > > 
> > > But can you please explain what is the technical/conceptual issue with
> > > this approach ?
> > > 
> > > Thanks,
> > I just I'd like to clarify if there is a way it can be acceptable. The
> > problem is that there is TLV format which  might be used on any nvmem
> > device which contains for example mac address which needs to be exposed
> > as nvmem cell. If to populate cells via nvmem_config then anyway I need
> > to parse these cells from the "target" nvmem device.
> 
> 
> 
> As a first step this need to be part of the provider logic to parse this
> before nvmem provider is registered. If there are more users for such
> parsing, we can think of adding some level of parsing to nvmem core itself.
> 
> Hope this answers your query.
> 
> Thanks,
> srini

Thank you for suggestion, I did not answered because I was not sure
about the way how to provide this cell parser registering, still
I am not sure about the preferred way. What about the following way:

    1) nvmem provides API for registering cell-parser.

       Looks like it might be similar to the API for adding the
       cell-table by using device's name.

    2) cell-parser driver registers itself using API from above
       (I am not sure on which initcall stage better to perform
       registration to be registered before the nvmem drivers probe)

    3) during nvmem_register() (before adding cells from table) core
       tries to find parser by matching on device's name.
       
       If parser is found - then core calls the callback with passing the pointer to
       nvmem device.

    4) cell-driver is called via on-parse callback.

       During this callback the cell-parser driver can parse the nvmem
       device and register cell table.

    5) core adds cells from registered tables.


Thank you,

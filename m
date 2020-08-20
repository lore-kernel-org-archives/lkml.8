Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA4E5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BA58207FB
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 08:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="YRH9wwwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgHTIdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 04:33:19 -0400
Received: from mail-bn7nam10on2063.outbound.protection.outlook.com ([40.107.92.63]:33363
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725852AbgHTIdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 04:33:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CiE1SvDYzFsvdnUN13s90T75pu4tEGuw0LwI1H107jLisrX5R4XbXz4VyP9YAcCRASRvIn903gYUWFW9PkGYPc+HS6bePDo0wvr/ZAJusstiWM3+QY5nBSKqFlCYR4OoNprRUMOboKMqust9gRGPYStYpfNWSMcFYRz+tqok4WzkLnkZg/km2troCAwX+AqcZfjdDQ90j8j1cPH+joNgzYHHF1s7iVUzetXv0PjgZS58neDTy3TTrPNZCONdbI4pOimADp5nPnSlmJAvqT4YrLeT2flMIdh1nV4lKawHUOegdIF1CdtdNKi8q0zwljvf9wfKZiZCfMaOzKOFhFMp1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNq1FKkyApQ4pUJRVVvTf3LGi/RUv0NEH/cpVqwzyuE=;
 b=n5LjlhRLVNm2Wg3j4su83gWYKmIR0dZ1x4DmYqhm+PJXsRFKueFA49MZ4iRzlEDOeHR+2UkARmT5TaNWQB3tBi8dKiyOwOUsl5DfPzUx6/dIDL9cibgi4G/W9KLKHDabRc/9rMUyl5MqJzim/Rdnd8n2Vm4zschasXlxFFk1L9Sj3LqQ+kZxWzPSlJlXeDJrA/oLmObpU8px9otXpN2CwVYDwpG424F2VjJVmuh5Emcpr+X/CHbABUGi+qid66QNrEfDp+Rx+pMN3irmUsMCW0YVPTGQ1cqBXCSJRbBznuLrjKKpiB+1nNxGESAO+4A2wPz3yY0l7mvg9Px6oaSRqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNq1FKkyApQ4pUJRVVvTf3LGi/RUv0NEH/cpVqwzyuE=;
 b=YRH9wwwxQGsGL1grTqvw6eNWE9Yokx1qtrigXSW4c/OXW4dE7ZNAng022THxB1iCxQfZTxM6L/9uupwvxm8WJg2q+4a0HymP2d0EncFI9Lh+odTJG3hi9JPoLHwP4MUu4DG/lz1R3DAapGVgQYVrzD0HpKwDGLklC0qEfgBnRak=
Authentication-Results: st.com; dkim=none (message not signed)
 header.d=none;st.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN7PR03MB4547.namprd03.prod.outlook.com (2603:10b6:408:9::22)
 by BN7PR03MB4546.namprd03.prod.outlook.com (2603:10b6:408:c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 20 Aug
 2020 08:33:14 +0000
Received: from BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f]) by BN7PR03MB4547.namprd03.prod.outlook.com
 ([fe80::3cda:7634:5802:df5f%7]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 08:33:14 +0000
Date:   Thu, 20 Aug 2020 16:32:32 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH 11/12] regulator: stm32-vrefbuf: Fix W=1 build warning
 when CONFIG_OF=n
Message-ID: <20200820163232.54b59e1d@xhacker.debian>
In-Reply-To: <20fc45ab-4daf-3855-5817-1898d50c9efc@st.com>
References: <20200820152926.42c48840@xhacker.debian>
        <20200820154626.79d83157@xhacker.debian>
        <20fc45ab-4daf-3855-5817-1898d50c9efc@st.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TYAPR01CA0027.jpnprd01.prod.outlook.com
 (2603:1096:404:28::15) To BN7PR03MB4547.namprd03.prod.outlook.com
 (2603:10b6:408:9::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by TYAPR01CA0027.jpnprd01.prod.outlook.com (2603:1096:404:28::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 08:33:11 +0000
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3fb0b14-946d-4978-ab03-08d844e3ae11
X-MS-TrafficTypeDiagnostic: BN7PR03MB4546:
X-Microsoft-Antispam-PRVS: <BN7PR03MB4546C6AFC32AB012C368FDDAED5A0@BN7PR03MB4546.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:59;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0VAkl2IUuEtjIJSnxdjlpYccMoOaUc6xRrtXu3wxE092jY92DBbBmoIuNy7dDnUKQNh1a1prEdslgoeJVeA1RJMlO1zKsPywEI6n280ubjjZ0LeIdMPrxeoNldqrCdACsEtbvvKvtOkmZgtYgDrvsgRvBIurmE3wq8NLeBoTGcCxUHmcQjUzZjm/D4ML4iXg8s09gSDJmo/yr/4JrYh59P/0lVbXOFH6CAo92ZNNG/2YJFr1FFuH0L8c5jbengDpxQVqyS3vGkO+RqLBo6vJ88jVPNs5fhjLLswIiO1Jl5v5BMBHXRkTUoEsKPjwuhr9FrsyIAg1c0BYpQfydp3mm/G+M5mAqUzzaBo3TyjyN0nOQeqD0ToTlSMCeTgNlcYF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR03MB4547.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(366004)(136003)(39860400002)(66476007)(66946007)(8676002)(1076003)(26005)(5660300002)(478600001)(66556008)(16576012)(86362001)(83380400001)(316002)(6486002)(110011004)(2906002)(6916009)(6666004)(9686003)(8936002)(54906003)(956004)(53546011)(4326008)(186003)(52116002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: RGKnKh+FNHKP9mHYinfs50r8ILfynt2ISUfz6qzZPYjBqBEvGb2PTJ2fJo53p0dmpODH5sV2rZVW9HdP2eeoIgWs19RZaXZi6jvyOMAhmLNvowNNHEn0zMzMNh+c58HebhFYpGPWF4J1z0KeuMY5rmD+8mnmVWKpcQsliVWsawdOa0u9ZqQD9RGjMPwVoIbHyULUPmDTEKtWh9sXhR42pnF02BX7yFEd5+BysDIYocIQ8QucP7WmQcrTCDy826UZYTKhK0DXpz28zBGHEHeoJy3jvOTzmKFaWRtGbnZyYaI9Okp/o09FFop95CMLxxJFwVLaq0jiZkSL3v0myzRWjy4D9GoKLvlQunx/rMDYkOKDF178diU0/h30ZbmdnyJRKhJgT+bdtmqOX9K4G4tdAXUzOvveMUnMZxfJUy6wH8CsguAuF8JVMFAm5cMAvPbYLQL7795srC6QKJv0ey6skpDMLy+SHAFnPDu2C0M30DNh9DzI2EXL48cejYgKN4tSxTCmEPa4ftey8oPcjsSbKatUqDd12O7DQRA2stbZgCSHqMZ7HLMDl4CSrL1muCV6BOuDG9He1Jf1ElbvucajMzyFJi7a+7ApnqGnJY4wbgF/vD7XQ7/kkYjBPtPv0uzJoSPxn+w5H8Lt7bAaiYczrQ==
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3fb0b14-946d-4978-ab03-08d844e3ae11
X-MS-Exchange-CrossTenant-AuthSource: BN7PR03MB4547.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 08:33:14.4691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EEbl++hyYoOYesAZO1m7ai/c/rtsikGHAkVKj3zjn34osGu9i57crLhZ0YlzAfiLqKeyvpXxkBAEox8+45SEVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB4546
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 10:13:12 +0200 Fabrice Gasnier wrote:

>=20
>=20
> On 8/20/20 9:46 AM, Jisheng Zhang wrote:
> > Fix below warning when CONFIG_OF=3Dn:
> >
> > drivers/regulator/stm32-vrefbuf.c:287:34: warning: =E2=80=98stm32_vrefb=
uf_of_match=E2=80=99 defined but not used [-Wunused-const-variable=3D]
> >   287 | static const struct of_device_id stm32_vrefbuf_of_match[] =3D {
> >       |                                  ^~~~~~~~~~~~~~~~~~~~~~
> >
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  drivers/regulator/stm32-vrefbuf.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/regulator/stm32-vrefbuf.c b/drivers/regulator/stm3=
2-vrefbuf.c
> > index 992bc18101ef..5a5c12d9ea22 100644
> > --- a/drivers/regulator/stm32-vrefbuf.c
> > +++ b/drivers/regulator/stm32-vrefbuf.c
> > @@ -284,11 +284,13 @@ static const struct dev_pm_ops stm32_vrefbuf_pm_o=
ps =3D {
> >                          NULL)
> >  };
> >
> > +#ifdef CONFIG_OF =20
>=20
> Hi Jisheng,

Hi,

>=20
> You could probably adopt "__maybe_unused" here ? E.g. like:

__maybe_unused also fixes the warning. I'm not sure the maintainers' prefer=
ence.

Hi Mark,

which solution do you prefer?

Thanks in advance

>=20
> static const struct of_device_id __maybe_unused stm32_vrefbuf_of_match[] =
=3D {
>=20
> I can see other drivers use this already for the same.
>=20
> Thanks,
> Best regards,
> Fabrice
>=20
> >  static const struct of_device_id stm32_vrefbuf_of_match[] =3D {
> >       { .compatible =3D "st,stm32-vrefbuf", },
> >       {},
> >  };
> >  MODULE_DEVICE_TABLE(of, stm32_vrefbuf_of_match);
> > +#endif
> >
> >  static struct platform_driver stm32_vrefbuf_driver =3D {
> >       .probe =3D stm32_vrefbuf_probe,
> > =20


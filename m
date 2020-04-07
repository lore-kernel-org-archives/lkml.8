Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43EAC2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BAAB20692
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:12:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=plvision.eu header.i=@plvision.eu header.b="xt64h3VU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgDGPMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:12:33 -0400
Received: from mail-eopbgr20116.outbound.protection.outlook.com ([40.107.2.116]:59900
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728917AbgDGPMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:12:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NP5nCKdGpozCbktulTLUQqdrPiIr4RC0YPMovI7ITC5A2nWPDj6a0UoKEcZOydSNAGnhxsALGUfA6pMvqwxPntD1IOY3okF1xqpMpeuLfo8DPef2VGHLA8Y1IaxBFSMWJ9VTLObBqKMwfMUG9pSTxMrTymgACmmsy32O7SlLWYahiWVbBASmmv95aywqlSKLYSRri73ItS2qzxo3ulWO6nP3U3DqcS5rJ61SdXNS/fjCa1g2GpGvDWIUWYA+XgWkIRjPCCjrym0X6qXyS5I25LEWD/DqB3MOBGw4fHtxdmkEGnyUFeO9VH5uPhCJTeOjnfF0+n5UswZeBo7jg4E/3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVyGZ0W3n6/Ua3Xqa7jQMTgP2dcmUSlWGYX24XKFU5w=;
 b=ZNuu8MK9lRJBI+hCUP93FVJNaWDCD9pGyq/102+naUfk+JQ2KVg/Aylh8u+JgURivNlkhjNKRtjsAN8K2fhxIhhTxp3FmLwPXphscGQ+wFSM96fCTOATosqtVlFPyUY1OU/vZYXuOFqyT4TDNR7tVIY6DEpzn9YGjLe2C5NHNbex/ZEd50oXY7K4j8tYkAKPpgrISf12JXlWQjvsV6ncLE1ZXlnVofoog4gwDAKHzVom5UFpEtm3ULJEPUWmQAfTFMey3IG+foY+8lyS/xPXo1GV1M0ERMC3RH+5avmou6rd2xBfU0sXPW7tyvrfP/iAZ3ckHJW2KyyTQ5Ru31wLpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVyGZ0W3n6/Ua3Xqa7jQMTgP2dcmUSlWGYX24XKFU5w=;
 b=xt64h3VUjoQKmLPJ82eT00B8gNQraV+X11hsK5eKvbDdFI+wZwCi9hkf8SWDwn3qpocFVBsg/PT9j0GEu6Mh43C9y0LOB1j3nal7azmzmV1LHAlamHSKU1wEiBFOmusZlr1oDjd3UORGbVG0ylF3zsQHv1O2LoLz6CChXVkgGgk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vadym.kochan@plvision.eu; 
Received: from VI1P190MB0399.EURP190.PROD.OUTLOOK.COM (10.165.195.138) by
 VI1P190MB0429.EURP190.PROD.OUTLOOK.COM (10.165.197.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2878.20; Tue, 7 Apr 2020 15:12:23 +0000
Received: from VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 ([fe80::f983:c9a8:573a:751c]) by VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 ([fe80::f983:c9a8:573a:751c%7]) with mapi id 15.20.2878.021; Tue, 7 Apr 2020
 15:12:22 +0000
Date:   Tue, 7 Apr 2020 18:12:19 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Gregory CLEMENT <gregory.clement@free-electrons.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bus: mbus: export mvebu_mbus_{add,del}_window for modules
Message-ID: <20200407151219.GB25149@plvision.eu>
References: <20200324190623.26482-1-vadym.kochan@plvision.eu>
 <20200325135801.GA29951@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325135801.GA29951@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: AM6PR0502CA0048.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::25) To VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:35::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from plvision.eu (217.20.186.93) by AM6PR0502CA0048.eurprd05.prod.outlook.com (2603:10a6:20b:56::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.22 via Frontend Transport; Tue, 7 Apr 2020 15:12:21 +0000
X-Originating-IP: [217.20.186.93]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e23670b0-36ad-405f-4c64-08d7db061288
X-MS-TrafficTypeDiagnostic: VI1P190MB0429:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1P190MB0429190E96B075BEE24036BE95C30@VI1P190MB0429.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-Forefront-PRVS: 036614DD9C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0399.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(136003)(366004)(39830400003)(346002)(396003)(376002)(316002)(4744005)(1076003)(6916009)(81166006)(44832011)(36756003)(8676002)(52116002)(8936002)(956004)(26005)(2616005)(81156014)(5660300002)(508600001)(7696005)(8886007)(186003)(33656002)(66556008)(66476007)(86362001)(2906002)(55016002)(16526019)(4326008)(66946007)(142933001);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: plvision.eu does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hD+Hw4kEpdm08NfeUTy3EFlkKuQKFLIUxyKTKINCVvdaVDJuTjXEnGnTyRfyA9AM+na1BT/d3IrMExYe5Q5OyeawUypi7mxuzeBPFWGtiliULUsy88uZQX69zA/2IZF9MAaYzXvDsF4k5qG4tpApNqvugsRB7x0e12iclVHVZQrvaQ+eoI8yiGdV8Kykd8OTCqPp/1JdMRy6O0PadPWDW+j1EQx9RkOh5TWtTGMi5VdkfHl7fGgDEUpy2nHmzLybtxDmdGI1cHvSlSREOkzumbmaLQjUqWiou4cinMGGqcWJAOes7hojyat4el4ETgPEtQq3vV55Vfycl47fidwda/9NkvnuqYcss7ibp6vHcJbKa5n6AVgTjyLzPewwzlktLwKY33FL3i6SBQ4fmD6wdV1YK9DtA7RE04b47L1U7WRe5pGUX4n0lArsaXNLe7YzHlE2Tc5XaRa/Hhi5OR3oRyKZAjjfP/BfzqwBGkWb+LdFHwV3BSqAaIg/1ZNkKTyW
X-MS-Exchange-AntiSpam-MessageData: Oe7zX42K7xnRDfsNmiuTvTDLT4hpwAaelRh4CJNZ5o2jyjNO4qzz92csoG40aju7KwN7M5QGmBKSQwEJfhWJoDKpfSrrkGLdUqr8SzQLxbHHLP15MTQ1c+3DgwNVwF2QQg/+/8Dcc7N/Vb1Dh62oWA==
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e23670b0-36ad-405f-4c64-08d7db061288
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2020 15:12:22.6451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0AVWSX07memi/vZCbbLZ6fzYqcekOb7yhuaijHKkch2hulWtnBtq4Ju1XPyhzLh/tSoh6p4ZzzaGZWVfkURG5ePnaASvMyBnjPwylwbS/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0429
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Wed, Mar 25, 2020 at 06:58:01AM -0700, Christoph Hellwig wrote:
> On Tue, Mar 24, 2020 at 09:06:23PM +0200, Vadym Kochan wrote:
> > Allow to add/del remap window by external modules at runtime.
> 
> Please send this together with your driver submission.

The driver itself is just servicing user process to configure io
windows via ioctl, so I think it is not so useful ?

Thanks,
Vadym Kochan

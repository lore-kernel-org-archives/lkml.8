Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F269C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D835820732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=criteo.com header.i=@criteo.com header.b="cWe64ODq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbgDMPte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:49:34 -0400
Received: from mail-vi1eur05on2101.outbound.protection.outlook.com ([40.107.21.101]:52321
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728194AbgDMPta (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:49:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFzOmcEjDr/E0sWs3vgJ1abFPuu3oIWMAM8aY5SkXGoyzMP3DGNJoxpEbgmKld7qHoYMTPhOEDuKxqzkoCpImB07qpcArnFBu0LinAvB+jp87QdNXsf9Vg3wM9bC0nxtx73h9poTz7+udV5u/EciM+Ju9CUP+aSCHA2ImfBWIU3jp9HxEn3rU/01nheA1Ob91DtAuHLjIM4vIz4h+Q8VAhwaUI4t8tuub1GMqm0HeY2WpfJ1NSjSJBg2A6jX5rN8KZIKysWYjJF5UURUgPWqHMaDcF446v2VynICRoLSOKzgJlM8LlLgcbfGECuuBgOMiAh485G4tl75HmiCixkqCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRajwoViSi7T6bNkE0m6fLWwfrHAjw3+CTO4J+5+kcY=;
 b=da6qFCWs27TindEMzsRlT4Hsis3cmo+U+TbYBkgnmPSA0aPGmpuMXxPyR0/A0KtakBfXqiDBFdUzHOHijW1UB2GumW+0QziknzkQw7EsZliX1eWCXJ5VQ/bzA22HkSZl1sKyY+GcgcpA04d7FjOiKg8+mK1Z2r6oVado9grZSlSWTFKeQwdDhdEZ0N7M3b7ltxd5WedxWn3bvgf9IQLSLHJEA7u+AsBMUKWB+uSzJdp5GrbOL6+MxrPsrcbn2UGkKJcNBJciUzz4/T9Cwi7e8pNdkQEyM0Nxh34TX+pxNgbJHDb81z0Y8cdM9GBcHz57p9G6UyjxKUPmNrM6rb6bnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=criteo.com; dmarc=pass action=none header.from=criteo.com;
 dkim=pass header.d=criteo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criteo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRajwoViSi7T6bNkE0m6fLWwfrHAjw3+CTO4J+5+kcY=;
 b=cWe64ODqCJjAQRvOiBIiUzP2mgR4ZGzJ9bBKadl9MRhjqdmjQ0gWOAFHdNGOZqqh3j0SuKVHFzmGKkKIZlO2LUpvXAbmsIhKdhjwECIurN4RoEQLWtWN+OZpnf/EEH8bx239NZs07qInamAu15hLASR6YYvVC/7ZkqT5fpgDIHw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=v.minet@criteo.com; 
Received: from AM6PR04MB4230.eurprd04.prod.outlook.com (2603:10a6:209:41::33)
 by AM6PR04MB5910.eurprd04.prod.outlook.com (2603:10a6:20b:af::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.20; Mon, 13 Apr
 2020 15:49:27 +0000
Received: from AM6PR04MB4230.eurprd04.prod.outlook.com
 ([fe80::f151:2536:ba90:6629]) by AM6PR04MB4230.eurprd04.prod.outlook.com
 ([fe80::f151:2536:ba90:6629%5]) with mapi id 15.20.2900.028; Mon, 13 Apr 2020
 15:49:27 +0000
Date:   Mon, 13 Apr 2020 17:49:25 +0200
From:   Vincent Minet <v.minet@criteo.com>
To:     linux-kernel@vger.kernel.org
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vincent Minet <v.minet@criteo.com>
Subject: Re: [PATCH] umh: fix memory leak on execve failure
Message-ID: <20200413154925.GA18663@criteo.com>
References: <20200413154244.18583-1-v.minet@criteo.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200413154244.18583-1-v.minet@criteo.com>
X-ClientProxiedBy: LNXP265CA0070.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::34) To AM6PR04MB4230.eurprd04.prod.outlook.com
 (2603:10a6:209:41::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from criteo.com (5.196.75.236) by LNXP265CA0070.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15 via Frontend Transport; Mon, 13 Apr 2020 15:49:27 +0000
X-Originating-IP: [5.196.75.236]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1006fc62-d28b-4e01-03ba-08d7dfc23f61
X-MS-TrafficTypeDiagnostic: AM6PR04MB5910:|AM6PR04MB5910:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB5910CCB1C8DC59D73716525990DD0@AM6PR04MB5910.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 037291602B
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4230.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(39850400004)(376002)(346002)(396003)(366004)(107886003)(5660300002)(478600001)(54906003)(4744005)(316002)(1076003)(8886007)(52116002)(7696005)(66556008)(66946007)(66476007)(956004)(2616005)(4326008)(36756003)(6916009)(81156014)(8936002)(2906002)(55016002)(26005)(8676002)(33656002)(16526019)(86362001)(55236004)(186003);DIR:OUT;SFP:1102;
Received-SPF: None (protection.outlook.com: criteo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ImysPhHZXcOGn4GQEoasEngotelpvFl4lxt0lud4dLIz4EkSXSqvsOugiB2kw5a3CuFNsAwksBGesGn40l1KaRzHKmvnNxhqqWJeyXJhvDLLzv9EheXVB/TT0rcadaKAaxS67b+RO6/zGVTq9TUfHo0vLOyw8nX5IrUhV2/FWE4djWGrvgzCNkphSJRXBJvwEfFKuqekdLVNLiLQy3AgH+zOz77Ai650PDeiwjM1JYnmFDZBFzbvxPEa7AGW5C9kxlxwkNTk69vEQjONxPEHSCvz2Kj2ZwkTT1rUDELV/IjNvPnONpOUw9eve9hbqVq++mS4+eO/MDivv5nttY+TCJDEpQYyTB/+ghw+20mTutnRLTMxiagGVkL7SpCKCudBlHkvijuTdlNt2az6bouNOxv1CUKfiu3GTKtI+Cgo8yodAY5Xg8xn8QPDYWGMqSK
X-MS-Exchange-AntiSpam-MessageData: Reyd1cu1U7el17PcQFQbBM9+wh55NJsi2J9qAjuKZgKcLffTwLUF38K14gHkbxW6SW22gEURH/ATfqcpn1sqmtrsZ/1Byu9oVeuEqkxBKHly4P2eoaUQn9Ho2LgTB8kdX+qYkSelQtdZlQjxzQPimQ==
X-OriginatorOrg: criteo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1006fc62-d28b-4e01-03ba-08d7dfc23f61
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2020 15:49:27.8235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2a35d8fd-574d-48e3-927c-8c398e225a01
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54FF1pW90wXlE1ekmodRYNyTpPGLggRg1PDsnT9EfnKPKIYo5j8QSMSMIhfd+8C+vXv32/rPH0HZlfE08FOjhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5910
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In my case, execve fails with ENOENT on a Tomoyo enabled kernel. It doesn't seem
like CONFIG_BPFILTER and CONFIG_SECURITY_TOMOYO are compatible as it is.

The UMH is executed via "do_execve_file", so we'll have bprm->filename set to
"none". This causes the following call chain to fail and search_binary_handler()
to return ENOENT.
  search_binary_handler() ->
  security_bprm_check() ->
  tomoyo_bprm_check_security() ->
  tomoyo_find_next_domain() ->
  tomoyo_realpath_nofollow()

I don't really know how to solve this. As I understand it, you really need
a "valid" pathname for Tomoyo and it's not obvious what that should be for the
user-mode blob.

-- 
Vincent Minet

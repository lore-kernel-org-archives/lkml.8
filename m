Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A3BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:29:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7274B2176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="jTwsphCW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgGTJ34 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:29:56 -0400
Received: from mail-bn8nam12on2085.outbound.protection.outlook.com ([40.107.237.85]:62688
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726520AbgGTJ3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:29:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8vdar3sv6FNjXXesVHGnEXZbTptboNeBxEPSHDHGdK5JUUMHdQVIUZnuja9sA1qQS9N7vL8KAoEG14y5IFxnI1QhMDHYlGWUt/OTbDLq52du/YdTGdAyWfr3TROSsXo36ZTSVU9AhsIU9/ExBSX7+Veo+zYsVLDUPBL3hmCmCGo6Gb0GAH9OP53rhgbf2ynMAXKpTApDBl5C7GGiV97ZMdDfNbyz4MZuodDufi8A0aPsg2fSCPGWlHtXIR9c+6yBNNoZhDLBW+pW1n/BDjT2bNZ8mP5QmOhWTxUdPtwmeAJC0J8aNKqS9fSjkvTQJycyYZ9BzDty8n8LRQVEt3OGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nek5Zqf8hx2vS9vYzikSMCmAdVX/iYhKdicyqZ+RA7w=;
 b=A1LU3owdLwy1hdozXHPZCo02MUsNImeaEpOP+9bzexj0W55nTS2edaYYrJ7etcJMKC06oKg7Rw96xAPBq+IRCM8vTLLwrnKDlLfxmigu7I8fpJpJ9UezXDwWHgIeaagPXZj22F7ZLfwJHuy0N4fIwD6Cuu2TAyFY+u1Ugvpw56wrzFFdCNW1h/EbHXSPvSGeha5n6+kpKATvwPJwLi4isOH4eOU44ye1aL9+D40GKtoSqY6KL/ROqaj7lqNNdISZLEfCidVCqIPoJVUxybfwGmuwhRceMXYrLRRxcEOLiCNTEPo+XQd7edpB3sTb236kJir2uIwhqzt5hVNIo+/eVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nek5Zqf8hx2vS9vYzikSMCmAdVX/iYhKdicyqZ+RA7w=;
 b=jTwsphCW2Uhz2vgCPlAoo/QbWkSuSIDyCSoJzicWemZMLzrzzKkbQfMglpm+OzTatNKYAwY25V3qI939G+AaHs6pi5Y3c4oVJQqu87vr80sTo0pWJnxu8IjxdwhZQvYQREQzjfEJpBmZbBA4bMVvKxUtyjbq8Ic1CdAgcSwvK7c=
Authentication-Results: chris-wilson.co.uk; dkim=none (message not signed)
 header.d=none;chris-wilson.co.uk; dmarc=none action=none
 header.from=synaptics.com;
Received: from BYAPR03MB3573.namprd03.prod.outlook.com (2603:10b6:a02:ae::15)
 by BY5PR03MB5347.namprd03.prod.outlook.com (2603:10b6:a03:218::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Mon, 20 Jul
 2020 09:29:53 +0000
Received: from BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::b5cc:ca6b:3c25:a99c]) by BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::b5cc:ca6b:3c25:a99c%4]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 09:29:53 +0000
Date:   Mon, 20 Jul 2020 17:29:00 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915: Don't force IOSF_MBI
Message-ID: <20200720170950.75c989d4@xhacker.debian>
In-Reply-To: <159501436493.15672.10863611355648667796@build.alporthouse.com>
References: <20200717141138.4a4289ac@xhacker.debian>
        <159501436493.15672.10863611355648667796@build.alporthouse.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HKAPR03CA0005.apcprd03.prod.outlook.com
 (2603:1096:203:c8::10) To BYAPR03MB3573.namprd03.prod.outlook.com
 (2603:10b6:a02:ae::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by HKAPR03CA0005.apcprd03.prod.outlook.com (2603:1096:203:c8::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.17 via Frontend Transport; Mon, 20 Jul 2020 09:29:50 +0000
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 442aebe8-4a0f-4fe6-2073-08d82c8f7529
X-MS-TrafficTypeDiagnostic: BY5PR03MB5347:
X-Microsoft-Antispam-PRVS: <BY5PR03MB53472B7CA6A28186D02220B9ED7B0@BY5PR03MB5347.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EkrP5L7WUDKCZQbJQXoac8Y2AkxsY5wxyjIyEw2mW8SIILo41lxg/+BBQfSjNXhn7mqHx0L7XexKmkwaGqQQ7uVg3ncg2TlII4J6218Y+UKF8X+EkeVEDEiqkovus4cYGOXmIRRneEEZR0/fIU0OFcKODPEfB7t0cYjx3Aa2aflHCaLzk9HvRWkoaAze0RFEEgAmZ0ohh8rB1rhE3u1zYyE8FRm08t/nlwWLxVOdRsv41pBJl6Bfbxke4xL/PutFgOA4bt986iMl4vxnlf4xTXhPNy2jAe2oLZ5y8S2Am9bgVNR6+zRx3pj+keNFB8INecI7xwf/mQmRCkQMxs+CwQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3573.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(39860400002)(396003)(136003)(376002)(346002)(55016002)(4744005)(9686003)(66476007)(66946007)(66556008)(5660300002)(1076003)(83380400001)(16526019)(2906002)(6666004)(26005)(8936002)(6506007)(7696005)(52116002)(478600001)(6916009)(186003)(54906003)(4326008)(8676002)(316002)(86362001)(956004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZNjqKIVarPanUTX4KRSDU+x0CmwXqZl4ffDw89Hs1ZeAEnluxc+M6eFY+h92J/nKiss+cxvffbH7sMwSDSwkAgc5DTOMY5rUzgorSFwarD+6g9MypMtmK8zyFzDf3pNW2JsVBFtX9FEkHDZEr9MxjYVT50Fkz4lv7mwrZEaQaaDFLcIhPYIOmrVC1anuBraCkFpsQOthzjDZWrMHRe6zVkcGKxNlODJ3SE2NekaIRbA6kS9/yubulqUbMejvQT2lgIqSoHC1gPVkxFfsshRU5gD2PDDFfDgrBTQieDSrm2F6e+0WJX1jQ24o3K2p8zTimrhPSfaXFqIcSDXLyPv/MxZEZ8TUBKlvvM1Y8k60UjSBHBEiGD/Tr7bLenljEUedThs8dIq5mbIVaAM/2+AZsZ8BIbpku88tG9EA4BiDiw4ZgV/ID2XF9Q0QANZQgozlDAtQUYZloXeMq7sPyDJXcBTJ122yaFY+xr+sqEMPTfzTTQ8Z5EC5SgdIjKO3OqN7
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 442aebe8-4a0f-4fe6-2073-08d82c8f7529
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3573.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 09:29:53.3318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+aNbSjdgogNjveQ6Mx2unXum4BKV5C24Y7tZ5Sb2Fgw5NFkCMxZ0G7BFWOO7opRMfEN0smjpEGCKN8uHCWifA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5347
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jul 2020 20:32:44 +0100 Chris Wilson  wrote:

> 
> 
> Quoting Jisheng Zhang (2020-07-17 07:11:38)
> > The i915 doesn't depend on IOSF_MBI, asm/iosf_mbi.h already defines
> > isof_mbi_* APIs when ISOF_MBI is disabled.
> >
> > Don't force IOSF_MBI to allow disabling IOSF_MBI for non SoC platforms.  
> 
> But it is required for Valleyview/Cherryview and we want to support
> those by default. Tricky.

If linux kernel is built for Valleyview/Cherryview, ISOF_MBI has to be
enabled. The dependency is met there.

Thanks


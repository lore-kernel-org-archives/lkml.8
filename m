Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D8AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7630F2177B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="kuiJbrdF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgHEISp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 04:18:45 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:21821
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbgHEISm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 04:18:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmV7/7cqpJEfowfqe96Qz3a2o2t5m/Dsi9paCv5Uz48Mrm4vdb+rkE4Oai0pxCZIO0qEPczvBanG2jio8joKFusdyR6lx0R83e5KCDB6dcOcFpXpe/qERm6yoh3el3RP68VY1INQWK56hrL8wgJVvsnCWY1isGpBbSN7vaYKt1711cGc+98N14ITzQsd65N7zGxaYNzN1zwfcSqJmov9NWZNhqJOdKMusgrXGD+Z3Igpxw2QePdNPiZyiWfstLVex4PiExF8HS77pXjdkGvfDeF1H4UX9d1JH+VUigODlFnOrRC6aoq/zEoJpfYQdW0lmofKWVlGfYzKmfUsjasgkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySbN9CGJmo/XJtFvGMYhyjeC4zxcgvebMSz2uChAi3U=;
 b=PHK0nH0vCaDWKgyQGt5WiPrb9fzP9prppov6PkMO7JgoQqIkJ6b+HiaUtMzVtyaa4J8stCc7ajSVWIJDkO5wAcquQDxf13j5T50N/6LxtRkUmLAAf2YNF1jCEiQg5ODE9g9HkXkIcABp6Cw8scjF3JKW6tkuksOAh+V0CwGg6f21ZuA0LHYcpK6bkSNTCuzHQBpiJ5ISb9YVs9XxHpti8ZaQkpV0JgvxdLwrmRJvc02G/v1AZVRA/TfC3E9m8yImn/Jcrpgl2Hm3kjHDJoC0zP0td/JWT+tZpQe9CXb835vhxYzRVcfJ9WuYsxR0I7GiER169mTf5Qu8OV2pH4jkOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySbN9CGJmo/XJtFvGMYhyjeC4zxcgvebMSz2uChAi3U=;
 b=kuiJbrdFc2JRuhhms1ZqZ3DcrzoItdJAxdd3DHrQeE8O0C2Sem382pPAEOOPBxj7u8nCjbKf3xKIn/gyYJahNtjMH7Uyw57cuLqUDR7JzRGI35fHgtj9oQO0s4FAqfUNx6kdMeB9llzC/YEKXHYKg4Q9dHWIf69x1OUmKEbjzQk=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com (2603:10a6:208:b3::15)
 by AM0PR05MB5715.eurprd05.prod.outlook.com (2603:10a6:208:11e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Wed, 5 Aug
 2020 08:18:38 +0000
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813]) by AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813%7]) with mapi id 15.20.3239.021; Wed, 5 Aug 2020
 08:18:38 +0000
Date:   Wed, 5 Aug 2020 11:18:34 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, parav@mellanox.com
Subject: Re: [PATCH V4 linux-next 00/12] VDPA support for Mellanox ConnectX
 devices
Message-ID: <20200805081834.GA116971@mtl-vdi-166.wap.labs.mlnx>
References: <20200804162048.22587-1-eli@mellanox.com>
 <20200804172726-mutt-send-email-mst@kernel.org>
 <20200805050105.GA5442@nps-server-21.mtl.labs.mlnx>
 <7b4b4944-9428-a6ca-8b94-69bfc2675286@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b4b4944-9428-a6ca-8b94-69bfc2675286@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20)
 To AM0PR05MB4786.eurprd05.prod.outlook.com (2603:10a6:208:b3::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mtl-vdi-166.wap.labs.mlnx (94.188.199.18) by FRYP281CA0010.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.13 via Frontend Transport; Wed, 5 Aug 2020 08:18:37 +0000
X-Originating-IP: [94.188.199.18]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5869927f-bc49-41db-d0f7-08d8391827ea
X-MS-TrafficTypeDiagnostic: AM0PR05MB5715:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB5715BB9506499E8B9359718DC54B0@AM0PR05MB5715.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ltab++I4dOx35dPGvQJUu8RsOWTOiqDjnjQmiLG4Ck0NUDCBr1pf1PG1wbp7xJkA5mpdunkXUoAWzgKQKyGNTjEYJocWV0yjzYvGAYwBpGJ3e5K7wUdAkG4pp+w9U+mNo/J3rgkv+PmzV8J1U/mgy7CCCfUWCrsD4cURMWtPmJxU/BS3Hg4TdJkNzsRRcmwANX5tnIlttmurHq6Llb5em/mamHoa4ggFkwVbJrVosZTCtMF6DMhAieuA+kud0S0hp9LxwewvNDsNuOxCEZKx9PEg/wE+JoUt+s5S7s4MptI51B+3aAYZ6CnBRR2noVX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4786.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(136003)(376002)(39860400002)(396003)(5660300002)(83380400001)(1076003)(6666004)(4744005)(66556008)(66476007)(2906002)(6916009)(8676002)(55016002)(9686003)(33656002)(186003)(86362001)(7696005)(52116002)(956004)(8936002)(66946007)(26005)(16526019)(478600001)(107886003)(4326008)(6506007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: eC5UJNja8yVxj46IiO4HgOKdxYrjTAJOFbk3zLyT34z7y2+K8hJQr7Z79JlbkuhN6FEdL1r1ZHgprLN7o/aD7c8weqxHqWlyM+4Njiz7/IkYxrciCnwTqsac2Yy051u/LwQ6a1u/mYMxKPXadZt4p13D3LW4IMeh6GAuJe8+a4mJ1J+ZfyzD/zam3j3lQmVRUk2+zM+XVIIGUnehRRx6f6c2Rpza/8fb77N++0HjPc2xdqdecOPW1ehAlrmN0H5pW1QbxF+hOVI32hzLbTST/td/1lQYZCE8YAPrZ/iqQdiwJKcpjSBqye9RWaPW2lKRmk2Vt/oS8y7E4WjmpdX0i4iHxK1i/EPE0i9ve/CEzZg7/WwbCaVJjqtDv4/w462/By2HeTvVqKERWGHIzxi8mV6ExqlZOy5F9C+x3Ncx3He4c1NJlJHhR011o6yMsCrbCihxD72BREDB0ujzfGU3C+LvfL2Hnt1+XSKB//M5OutIYm/JKhGhIwjuocD7HK4olcQjJF2yNaPvwK/ahMXGGRTMEiBv3ZKMW3TzqWFt5/6XDeb6k6bc2z+9p8q+qUec9/rZX2jmkjVJm6a+2A9IAwy4bltns0GYA7uCbR9etS/e4Rm6gkzR5ny8btcFxSlyGpejrSQQLH0GjH/tw+pNdg==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5869927f-bc49-41db-d0f7-08d8391827ea
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB4786.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 08:18:38.5673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AHpxPp7go56WAuFr+OZnasa8oCCXu0CBbJjF/IO+MO/dYYtSzuXki8U8e7NX5cVLj3UjW1NeeALZVIdNuyIw5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5715
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 04:12:46PM +0800, Jason Wang wrote:
> >
> >BTW, for some reason I did not get all the patches into my mailbox and I
> >suspect they were not all sent. Did you get all the series 0-13?
> 
> 
> I can see patch 0 to patch 12 but not patch 13 (I guess 12 is all).
> 
> Thanks
> 

Yes, I meant 13 patches 0-12.

Thanks

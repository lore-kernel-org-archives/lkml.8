Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A9FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB9E20810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i6UKNXAR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgE2Tcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:32:48 -0400
Received: from mail-dm6nam11on2070.outbound.protection.outlook.com ([40.107.223.70]:57271
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726751AbgE2Tcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:32:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJjDFU+pwDWepi7mx4lIYMxhBaNPLAGdkmC8QhEgHd26ysLcPwRupy0YS1uVOrxP0my940ZfsCGLiVlHopBh/yc3ExHGiwD1TmunSXqt7UQQrzI2txNErg3vF8YRFh7zpfAxJuxKjZ+WHFTNKuPZ8qTn/JBeRheQKgv+Y+c/lQq517eijpqtmb/4heu4iYqeZtBWuQXTuJYEWj/COPGgFj5mMrtMxv/g/41Z3U11CkyZ11px8gzJ2UiGWxAVPsnQLhNsOBD0hUjwQ6zyjByMfAajykTwZKUGDU/CMzVebxdIyPSoBYD5Cci0cyvURCrk/jPHDNdVJzRqDOL1g9ZybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvpHvVHnKfDpxZceEuvjBNq//Zg2Qao7+/wQzsaiGWE=;
 b=FW+o4XOAj2tAtX+xoIALtq9JHbogFFD3wVPJT3czSNzH6LQ5L9PrXn3301Qsp95TAEEfWnWkdA3AyB0BA25xXjtheIreOW96W9XhSLPPaoD6TRFENI11/bH1TqqvLXWWp/embOcrSGPK3mPrUy+qqfvCyQlsID5iV1nw0/DupzcyGMj7n7nCgWbeprSxjLonqf/sEXOsjn/LGsIAlV5fIdrj1DVyUVLz5HVP6HVnZRsuNvIIZlc8rtaplKrI57mm6oknadFzPUwrDzz5Inzci4Be5LWlRdCVNo1pyomZB8G41uUyUT/uKi6RNYpJr13N572M2um44zwSvudsojqvvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvpHvVHnKfDpxZceEuvjBNq//Zg2Qao7+/wQzsaiGWE=;
 b=i6UKNXARlv6lLG8rALdThxnWtAezDkjYmYH6iIJaYOXk30LyJbYp/lpT1VxiJSEl6Pe/3VoxVA6365SFAfspgzgUcchHdyGeKl0qhZe/90JHg95sG28Dvp8kKscrumyY8ZS4uirim7vSrD1h0YlVe/bD2OQmjDvMI7xFVqQCKl4=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN6PR12MB1218.namprd12.prod.outlook.com (2603:10b6:404:1b::7)
 by BN6PR12MB1635.namprd12.prod.outlook.com (2603:10b6:405:3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Fri, 29 May
 2020 19:32:44 +0000
Received: from BN6PR12MB1218.namprd12.prod.outlook.com
 ([fe80::b021:d7f2:52aa:1fc]) by BN6PR12MB1218.namprd12.prod.outlook.com
 ([fe80::b021:d7f2:52aa:1fc%8]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 19:32:44 +0000
Date:   Fri, 29 May 2020 14:32:36 -0500
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 5.6.12 MCE on AMD EPYC 7502
Message-ID: <20200529193236.GA4005540@yaz-nikka.amd.com>
References: <be415508-246f-d934-b449-4cadbdb0acc4@yandex.ru>
 <20200529115720.GF9011@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529115720.GF9011@zn.tnic>
X-ClientProxiedBy: SN4PR0201CA0061.namprd02.prod.outlook.com
 (2603:10b6:803:20::23) To BN6PR12MB1218.namprd12.prod.outlook.com
 (2603:10b6:404:1b::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yaz-nikka.amd.com (165.204.78.1) by SN4PR0201CA0061.namprd02.prod.outlook.com (2603:10b6:803:20::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18 via Frontend Transport; Fri, 29 May 2020 19:32:43 +0000
X-Originating-IP: [165.204.78.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 69eb3d1d-3bc7-4b2d-b7c3-08d804070f5d
X-MS-TrafficTypeDiagnostic: BN6PR12MB1635:
X-Microsoft-Antispam-PRVS: <BN6PR12MB163561A3817F6F1451D76718F88F0@BN6PR12MB1635.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04180B6720
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BZfUR43GgEkMhK4/i22dXOKG3dEZMqFPPcooMk7Vs1D8mh0cjhycs5RRXH5IA7Imvw18eVOT6IBeESxwVXNLvpNN6Hwa3Qnxlxfyuxbj37l6k5yOWqc2fRzwPb8ECCUhbMq7wq0fgwVJ2BIvPNRO6VowlwxApGvLXbdnlCdm4oJQhhjR5Jmqbpxal52OZWamaLdzV7xIzJoHksj/cC6CFa3ANiCLExl7ZSTsMtcaT7bJ7GZkWo+f1f1LKu0uhamPPRyukMSvJFz5/X77q6HLHEJkEL3nVnq77GcyA/HxWdsKyt47Mr1xt2MS3Srh8xZ5PpOpi+umFqVksODfu+cTaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR12MB1218.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(39860400002)(366004)(376002)(396003)(136003)(54906003)(66946007)(956004)(316002)(52116002)(7696005)(186003)(5660300002)(16526019)(26005)(33656002)(6916009)(44832011)(6666004)(1076003)(8676002)(2906002)(8936002)(4326008)(478600001)(66476007)(66556008)(86362001)(83380400001)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: PpOw0QGyNNms5beOWXwpY8cJKtpyp3J1GHkhTSNddtWNqMC0RWm5V80CtLS30Gi2d4XIbAZuQDoC+exjcnowCf8Aof7P/RnuT3thbe/0pQXPnMI1OWOOrU6HoyQfvTIGDG/bdySH+pwrhpXrNqOUWmWsEhLU5Dj5147nBvYML2SnvQZ6VGt+rQltylaXzVZkIhvDEqQfNSf8mfUzJbTXOsbuaqN+vJOxVyOosMcE5/UKH/0Iwh4d50CKW1a0wNJVkrh4uGca5VEOtQWK5d15ArbtZCfkVXmE+Bpgett1mk5FYIvPzSvwwZM1gsA1K765imQsAdLsWQlQX7K6iiDRh2LjjUkuuWpNiMBnpHLP0hqa5+qz8XGUv/ZEDcmIttNuvLAwjTYSMc8Rl7CViPdtUeSMEmfV0ckfmVpGduwZoC5i8fucAuT7W4ZY52Trmps2J8zvCNZ5FGCYylZdfQIFEFgZd5GX30jI1kBjHIJ/eeY=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69eb3d1d-3bc7-4b2d-b7c3-08d804070f5d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2020 19:32:44.4876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wvqNjfXHZuWFLzFEDteJiM7xIw2dQ0/SR4hWD4ReofKRknNAlQZNqmKyhjYi1RYQn6aSYS7VM8NlvzUH4yoavg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1635
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 07:57:20AM -0400, Borislav Petkov wrote:
> On Fri, May 29, 2020 at 01:55:29PM +0300, Dmitry Antipov wrote:
> > Hello,
> > 
> > I'm facing the following kernel messages running Debian 9 with
> > custom 5.6.12 kernel running on AMD EPYC 7502 - based hardware:
> > 
> > [138537.806814] mce: [Hardware Error]: Machine check events logged
> > [138537.806818] [Hardware Error]: Corrected error, no action required.
> > [138537.808456] [Hardware Error]: CPU:0 (17:31:0) MC27_STATUS[Over|CE|MiscV|-|-|-|SyndV|-|-|-]: 0xd82000000002080b
> > [138537.810080] [Hardware Error]: IPID: 0x0001002e00001e01, Syndrome: 0x000000005a000005
> > [138537.811694] [Hardware Error]: Power, Interrupts, etc. Ext. Error Code: 2, Link Error.
> > [138537.813281] [Hardware Error]: cache level: L3/GEN, mem/io: IO, mem-tx: GEN, part-proc: SRC (no timeout)
> > 
> > Is it related to some (not so) known CPU errata?
> 
> Who knows.
>

There aren't any reported errata related to this that I could find.

> > Should I try to update microcode, motherboard firmware, kernel, or whatever else?
> 
> Yeah, BIOS update might be a good idea, if there's a newer version for
> your board.
>

I agree. The link settings are generally tuned for the platform. So the
platform vendor may have a fix.

Thanks,
Yazen

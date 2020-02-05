Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750D8C352A1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4600920702
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="AmOcOPwN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgBEMtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 07:49:09 -0500
Received: from mail-vi1eur05on2134.outbound.protection.outlook.com ([40.107.21.134]:41703
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727068AbgBEMtI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 07:49:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ixn9wgNC2OAGNqalXucKBKqL8qgfDG1SEDXKF7P/0AoWozMgsFYMZID31XiKNRV7l/jpaaV3T67mdqS3W1Ejt6qo2446oJ1vbYy/+gwoHawEzgXXvO6mCY10tgJY/IwKxKdrlo1z7ghr66x7f3okKlgJRCcDtKYxL82e2o2kpATPaU4iRqHsyUybQHwoo/xfGs2P+T8ldHh6u3e22Ph6+q5bwkHjXNRsq7FJP+es7KWoP6EOv8vijKk/vGCdCKZQ6eYSmLb+kMfSkY50hb0lO1j1hl+1RTt7XCL0JMAiE7DEjCiwJzF9WUouHv9mM1uapaL3cs4Nlp9ebJL9CGVH1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fP/j7WVMA/aJTr2S5tqD8HIC9DFVmWq8mQrRwyN6O4M=;
 b=D2bSk2My7QZWEbUdxrov7LRtUai7GcNnoVrvAPT3eqUecve+g8uygqsrAuqasZAyFxq6uTadvYq+Eg+4rQJuj1G2i9h6Exd9VrbEZL+d9WTKSF6z2uOJl4KDfItarTr4+CGoSh3roZRzJvzbek45e7gf0EH5X+08i1cV730wXGMkh2X9byFo+WgV0RS+XSowCIIe6784UvK1SMIqeEIpNuljWp7kNcOaOMZSkTwl6eSptjUsC9E9h4EvxAKm+RMXT6Tkf8EDu3JfxHJH6z3m9JEBxRCW7H0zYI0289YaVyjTSayaHgzuHylcGc4fjDrDkHxB973VbH/xywyDgxmxJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fP/j7WVMA/aJTr2S5tqD8HIC9DFVmWq8mQrRwyN6O4M=;
 b=AmOcOPwNgSjo9xnW7huaiz+Rh4RzUGBSMsDDf9zg3uJrnHfYohzJcTxNywMjpLD245rJO1JmENqleKu6H5QsKuA26jj+YxIFLAyYt79qJRz8KW1nWA8UeRc1G0f4vDWQRy9I8PI52xOr3RIv2NQq3OLJ4Gg2BS06Mw4TYoU67jg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=matija.glavinic-pecotic.ext@nokia.com; 
Received: from VI1PR07MB6048.eurprd07.prod.outlook.com (20.178.123.204) by
 VI1PR07MB3854.eurprd07.prod.outlook.com (52.134.26.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.19; Wed, 5 Feb 2020 12:49:05 +0000
Received: from VI1PR07MB6048.eurprd07.prod.outlook.com
 ([fe80::dd1:76b6:26ca:e2e8]) by VI1PR07MB6048.eurprd07.prod.outlook.com
 ([fe80::dd1:76b6:26ca:e2e8%6]) with mapi id 15.20.2707.018; Wed, 5 Feb 2020
 12:49:05 +0000
Subject: Re: [PATCH RESEND] cpu/hotplug: Wait for cpu_hotplug to be enabled in
 cpu_up/down
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <d950a169-941e-7caa-608a-df97a127c95d@nokia.com>
 <87o8uf1r3w.fsf@nanos.tec.linutronix.de>
 <77570af6-733a-58e7-6975-b533a42daa4c@nokia.com>
 <87y2tiy1p3.fsf@nanos.tec.linutronix.de>
Cc:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
From:   Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
Message-ID: <247d9cfd-3624-6316-e1d0-0789f23333e9@nokia.com>
Date:   Wed, 5 Feb 2020 13:49:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
In-Reply-To: <87y2tiy1p3.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR09CA0051.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::19) To VI1PR07MB6048.eurprd07.prod.outlook.com
 (2603:10a6:803:d7::12)
MIME-Version: 1.0
Received: from [172.30.9.7] (131.228.32.167) by HE1PR09CA0051.eurprd09.prod.outlook.com (2603:10a6:7:3c::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.20.2686.32 via Frontend Transport; Wed, 5 Feb 2020 12:49:04 +0000
X-Originating-IP: [131.228.32.167]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 41d60a21-0653-42d9-5b2b-08d7aa39c89a
X-MS-TrafficTypeDiagnostic: VI1PR07MB3854:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR07MB385401B073E33DC426C5EC4CFF020@VI1PR07MB3854.eurprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0304E36CA3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(107886003)(6486002)(4326008)(81166006)(81156014)(8676002)(8936002)(31686004)(4744005)(36756003)(6666004)(31696002)(2906002)(86362001)(478600001)(52116002)(2616005)(16576012)(53546011)(66946007)(66476007)(66556008)(186003)(16526019)(316002)(26005)(956004)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB3854;H:VI1PR07MB6048.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iOBhxLRwCD89rdu0cG5S6jgbwH49rclrSLKDkhK5t7AXm6XplI7AXlE2cNKr2HNWto+x572CYXCzQkx6c8ybfbRbLE6BeZMiwB9E9KvfuXrV1aJgU1BhuTVxS7hwe86mVgQp42XylGbq6jbWytNKr1R4vyZfr2Ye3Tf42cnBdsVt9LSH9rRb87UXYAo5NABUgHaUD5i/cWnIieO2QFlFb4Qw8G6u1kQUW6BYHZBmPsR9yORSr3Tgh1zfKBUE/FiKJJpVgdWwR7GyBsvRrHHhuJqR8vD3WlUsEeD/FAaVzmnRq2b7VILw6PsQelGBBfCiXbW4a8HMuwy/MO2vQMSkBdlJkzsZwZ8muo0r4WMBM1d+RQIlBW22eAzrTpz7sxFOMVOZSZ7uc3T7egyJB7iCLGcJUgnuI6YrKDJ5ZmlUuzCX7s0Lnu13M1qfqawHz0Ho
X-MS-Exchange-AntiSpam-MessageData: RcMPFDQr7zfVxtBGIglZaND76kSVeUTDtsPd88GlyKbjyMeW/Ld+Nj37f8wTbUVTdi1PplVDT3XVwdv92fM/Aw1mfuOAavb9bRQs3mYEWci6wU3PhJrUKiRvrytJQrTGSWxOyG8x09/idqd9Z2u7lw==
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d60a21-0653-42d9-5b2b-08d7aa39c89a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 12:49:05.3210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4uB+zfQrZQxlgYL48lN5W/3ty32XNLyPblEcWDkbPwNzbb0tghuS3S86oHjcklMok6Lpc5aD9I5w20PJpEk35WLBAEvEhKsaPCnF4sItKaVCrNkClF3vumIN4qJLzgxw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB3854
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

On 02/04/2020 01:30 PM, Thomas Gleixner wrote:
> If you have that isolation thingies on the kernel command line there is
> no point in doing the cpu up/down dance. It's not providing you anything
> useful except steering interrupts away which you can do on the kernel
> command line as well with 'irqaffinity=...'.

Thanks for the info.

Regards,

Matija

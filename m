Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC63C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 368D021741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="n/aUm7WQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgBEOyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:54:35 -0500
Received: from mail-dm6nam12on2064.outbound.protection.outlook.com ([40.107.243.64]:6173
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727070AbgBEOye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:54:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OrBHMGf4feUP+u+QwGLQVTZ1hw/CSqVH53J7Q1cl1vImDxScsJSJdKmWnSORz6+4D9MU8r0NM44mCNfzqMBbd8k9PVw+cROBrhXiRefgEcbXHI1KG+MeeMTKWV7U4vvP6X5rX6bNJjdv8IZwee4M9a3o1pifr0xnKzC3BfY7dUNnBTUnxY31i+m+cBGyQl4iQsOMJWjMXBbz1kv9R4hXg3HFy7eS5fVXBs8apvgVviA405NQUzkgDrk6wFQoRVf0kn5PtlXRdo3eqQSV/rRt5eqae75SsRlBjpb5WUgwaUuEn0ej11HmMEQbEf0L8ZjXh17+HL4rzPk/8GF1XO69Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1JlVF3/VIBK21Jnm12o/7g3Ax+nQIpdp/NH3D4Q0XE=;
 b=P5Np1tbDPaRcEr4GDjskfihrlfl2JpVcX5Vd1Eee594OPW3HBSYIAeFwTMa6QNMPlD+BI1SkGMwFClIEOToZrgQ4DRAATXzMX16zph9lwYTKPWhRmfdc4j0hVAQjY3Yr8Y49ArOkyj1Qdr97TK/hJqASrAQ8/wIw1Z3oNwgpYkRXZbgn8u0lgJH5t72GP/4VnNg3aOWNFpn7nbkCnBjHmMMUd4+CbbUcXMv1sWmpFBW+1KKHW5SLHZ3r4Le2W230Mv3osW1KB1JW5RT/uIMwPsz8VjI99ZqvbGI6OZfSVszQrgJhyvzzr8S6ibZcKV8CcWIizEqUC3qRu0mH3kCvrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=aculab.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1JlVF3/VIBK21Jnm12o/7g3Ax+nQIpdp/NH3D4Q0XE=;
 b=n/aUm7WQKoHk3713aezUlX4j2zOWa2mQQVYuKhvzKpn79fSda2EjfmpT/Pu4c4fkJsWxxiQjmqw4CApweHevHhQjg1TmcKARUJq3IAEJOM6ey43KI55VOltm20I5738N1uKU/mgbbkyoZ2zuDL5bmBXNyTPrt3hJcr0IG+Kf+hA=
Received: from SN4PR0201CA0060.namprd02.prod.outlook.com
 (2603:10b6:803:20::22) by BYAPR02MB4216.namprd02.prod.outlook.com
 (2603:10b6:a02:fc::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.30; Wed, 5 Feb
 2020 14:54:31 +0000
Received: from BL2NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::204) by SN4PR0201CA0060.outlook.office365.com
 (2603:10b6:803:20::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Wed, 5 Feb 2020 14:54:31 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; ACULAB.COM; dkim=none (message not signed)
 header.d=none;ACULAB.COM; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT009.mail.protection.outlook.com (10.152.77.68) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2707.21
 via Frontend Transport; Wed, 5 Feb 2020 14:54:30 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1izM4U-0002SV-AU; Wed, 05 Feb 2020 06:54:30 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1izM4P-00037B-53; Wed, 05 Feb 2020 06:54:25 -0800
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 015EsJ2U001081;
        Wed, 5 Feb 2020 06:54:19 -0800
Received: from [172.30.17.107]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1izM4J-00036J-6s; Wed, 05 Feb 2020 06:54:19 -0800
Subject: Re: [PATCH v2] irqchip: xilinx: Add support for multiple instances
To:     David Laight <David.Laight@ACULAB.COM>,
        "'Mubin Usman Sayyed'" <mubin.usman.sayyed@xilinx.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "maz@kernel.org" <maz@kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "siva.durga.paladugu@xilinx.com" <siva.durga.paladugu@xilinx.com>,
        "anirudha.sarangi@xilinx.com" <anirudha.sarangi@xilinx.com>
References: <1580911535-19415-1-git-send-email-mubin.usman.sayyed@xilinx.com>
 <e0d01341ac5c417982da48074972f470@AcuMS.aculab.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <06caee69-38a2-13d2-d7b1-d882e7438057@xilinx.com>
Date:   Wed, 5 Feb 2020 15:54:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e0d01341ac5c417982da48074972f470@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(346002)(376002)(189003)(199004)(426003)(36756003)(2616005)(4326008)(478600001)(31696002)(31686004)(336012)(70206006)(70586007)(2906002)(9786002)(6666004)(356004)(316002)(107886003)(44832011)(54906003)(110136005)(8936002)(26005)(4744005)(8676002)(81166006)(81156014)(186003)(5660300002)(42866002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4216;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 36c597bb-6d2a-4329-f7a3-08d7aa4b4e6c
X-MS-TrafficTypeDiagnostic: BYAPR02MB4216:
X-Microsoft-Antispam-PRVS: <BYAPR02MB4216E14E4F0358722972E053C6020@BYAPR02MB4216.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-Forefront-PRVS: 0304E36CA3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: leLPu6NHgfS66LTAG2DXfncJ26bfA9uWW5iZWFRt1S85OektorH02zpTxdRKbkXdzEbqR6IMNk7sjUJyrzmgaM8BsHJlj3y4517EgBmp2Hb0hsGkNfGrD4Y6GuwvoWrX2rXOu4S7BQKtvzWA7mtf3hsCxsCZddizQBEpZR+hoH+fdZ204PxUnkEci3tWblFO5+NTx6MA1jgHMuAV2GBubP8QB58AyJShuzAZKer8vDsxUQOb8K/tLgyOhLoXze/0JzbTy5d6tPl3XK8GlKTlgbLnSZuQ2zRKgY9fAsGiI4VYWF9CfdOuKqPL/uZHlFpU5ulxDy0xIlHy1TTycg7UnvBKxwpI0sySgMPoLJ1CbtRO93YY1HTVaLTj8n4VPykinucT+uGWRVYVnJLEBttsrOGHDUQhVQ6shrKoIYECzEkug9eNIyzx5Zwf/r8f4RXvRQU/+JTG1Gx3FnkHjND3Olho4stLUAGYpwudPgFqPHc=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 14:54:30.9466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c597bb-6d2a-4329-f7a3-08d7aa4b4e6c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05. 02. 20 15:15, David Laight wrote:
>> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s)
>> confidential information that may be proprietary, privileged or copyrighted under applicable law. If
>> you are not the intended recipient, do not read, copy, or forward this email message or any
>> attachments. Delete this email message and any attachments immediately.
> 
> Deleted.....

:-) I got two copies. One without it :-)

Mubin: Please fix it.

Thanks,
Michal

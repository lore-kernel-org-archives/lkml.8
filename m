Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8922AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 12:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428C32067C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 12:17:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="aNw0RHz6";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="aNw0RHz6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730512AbgA0MRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 07:17:34 -0500
Received: from mail-eopbgr90055.outbound.protection.outlook.com ([40.107.9.55]:52992
        "EHLO FRA01-MR2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728733AbgA0MRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 07:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEn7KwgrhpAjn2DVb1uSa+SFenEcLgFpBioZZ0ANJTM=;
 b=aNw0RHz6fJxv33Pj7q2QC0RZSxjCGRh0yxtb05rwpJGTYBeYoVajZ9VZmFJsfTQC+8RSVbtHAO/41HeRiDI+uRR780OUeN/dTQxS/LqOW4bk6RxG74SCN0RZefoc+H/7B0uOvG69WaDDtt/nPZNVbYJw5Cu+chvinlKaoeYodo4=
Received: from HE1PR0802CA0020.eurprd08.prod.outlook.com (2603:10a6:3:bd::30)
 by PR2PR08MB4778.eurprd08.prod.outlook.com (2603:10a6:101:21::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.24; Mon, 27 Jan
 2020 12:15:49 +0000
Received: from DB5EUR03FT003.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::203) by HE1PR0802CA0020.outlook.office365.com
 (2603:10a6:3:bd::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.22 via Frontend
 Transport; Mon, 27 Jan 2020 12:15:49 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT003.mail.protection.outlook.com (10.152.20.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.18 via Frontend Transport; Mon, 27 Jan 2020 12:15:48 +0000
Received: ("Tessian outbound e09e55c05044:v40"); Mon, 27 Jan 2020 12:15:48 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 96f9cfec0e6cfcde
X-CR-MTA-TID: 64aa7808
Received: from 036538fc9136.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id AC3292EC-ABBB-4ED3-92C4-CDE241D38293.1;
        Mon, 27 Jan 2020 12:15:43 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 036538fc9136.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 27 Jan 2020 12:15:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5rLqdpmPR3QZvakwAV+pn0wUbr7gZarfSQpILlJgZPDY3hIjG2ykl07v5ud6gJeA6I2ZDVMx6cuHXiah+t0+u5F2n6ScnVvaPDEeh2gwYGFcdh/Kimx1CyrDFI321qQ+oOipPB7YiAXXEsZY7gr8mJlEnYFDqLkPOvdEh+huST9lK/GJSh/tBLzcultW6hGpNcd60ls0cJOH7IRp9ftLumoU3IY3ukfonfFtYDySUJ0Cfh3S3cYfwITjMYKXFi9+tNEuVTiweVesG4OKby11vfSnbtLBEhQ/AJN3oJPxEs6wf1Z/BnrcjoQN7QfqUPC3gBRqPzC6axz4XUowLjmow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEn7KwgrhpAjn2DVb1uSa+SFenEcLgFpBioZZ0ANJTM=;
 b=IkCIWzOQ1Ey78+3YsvAegv6qqhZpWLMBTk/uNaAVPSxBpWyVXb6b/SjAJklOpSeUSy8DozWx9yn+zr9VoePESdOnGxaQW1cBABxbpyHW09ScSrlmdAW9T9wbBteQiyzSSDiHaqZkVya2N4Ugo1gD/9izxsFKkkxjqyEgHlsu94zORKSBMcdq57npA518en0or4G3fL8siQWuPf8FWyEzK/wPVgvnVe7SoNLefCIO36yfUJQIGVibB0nusK6B79Ls5bnZk7EbtGvh9wBEWl5lBo46KuePn277Hui1cZItEU997teDMmBX4+XYCKIp3qNLwpVK2CMG2rWwVBSFJlczIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kEn7KwgrhpAjn2DVb1uSa+SFenEcLgFpBioZZ0ANJTM=;
 b=aNw0RHz6fJxv33Pj7q2QC0RZSxjCGRh0yxtb05rwpJGTYBeYoVajZ9VZmFJsfTQC+8RSVbtHAO/41HeRiDI+uRR780OUeN/dTQxS/LqOW4bk6RxG74SCN0RZefoc+H/7B0uOvG69WaDDtt/nPZNVbYJw5Cu+chvinlKaoeYodo4=
Received: from VI1PR08MB3742.eurprd08.prod.outlook.com (20.178.80.208) by
 VI1PR08MB2942.eurprd08.prod.outlook.com (10.175.242.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Mon, 27 Jan 2020 12:15:41 +0000
Received: from VI1PR08MB3742.eurprd08.prod.outlook.com
 ([fe80::1026:acb4:de49:dca4]) by VI1PR08MB3742.eurprd08.prod.outlook.com
 ([fe80::1026:acb4:de49:dca4%7]) with mapi id 15.20.2665.017; Mon, 27 Jan 2020
 12:15:41 +0000
Received: from lakrids.cambridge.arm.com (217.140.106.52) by LO2P265CA0393.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:f::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20 via Frontend Transport; Mon, 27 Jan 2020 12:15:41 +0000
From:   Mark Rutland <Mark.Rutland@arm.com>
To:     Anshuman Khandual <Anshuman.Khandual@arm.com>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <James.Morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: Drop do_el0_ia_bp_hardening() & do_sp_pc_abort()
 declarations
Thread-Topic: [PATCH] arm64: Drop do_el0_ia_bp_hardening() & do_sp_pc_abort()
 declarations
Thread-Index: AQHV1PcvcHkaSOETYEOvXe44YCuKxaf+bQqA
Date:   Mon, 27 Jan 2020 12:15:41 +0000
Message-ID: <20200127121538.GB5085@lakrids.cambridge.arm.com>
References: <1580118575-1705-1-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1580118575-1705-1-git-send-email-anshuman.khandual@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
x-originating-ip: [217.140.106.52]
x-clientproxiedby: LO2P265CA0393.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::21) To VI1PR08MB3742.eurprd08.prod.outlook.com
 (2603:10a6:803:c3::16)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Mark.Rutland@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1703361b-2bd3-4243-8669-08d7a322a507
X-MS-TrafficTypeDiagnostic: VI1PR08MB2942:|VI1PR08MB2942:|PR2PR08MB4778:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <PR2PR08MB47786266353CDC6E63C43341840B0@PR2PR08MB4778.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:1388;OLM:10000;
x-forefront-prvs: 02951C14DC
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(199004)(189003)(8676002)(66556008)(16526019)(81166006)(55016002)(5660300002)(66946007)(1076003)(26005)(478600001)(8936002)(64756008)(66476007)(186003)(316002)(66446008)(86362001)(6636002)(44832011)(52116002)(956004)(7696005)(54906003)(71200400001)(81156014)(33656002)(6862004)(4326008)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB2942;H:VI1PR08MB3742.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: UTDmTfj1/OlDlsMkgT2VvSczYze0EUzYprsnXL3QdmOZemm2VwZjpTYWCxZAcU0JvltpqZzdyeFZWoTMnLjCfix/aXAOpuYaNrUEm8OZKCj1nSfvdNcUFNubpRpYaTQgbxWiP6mR0LvE8zEQ92B3FN45XwVUfwmV7hKIjKk94fvQsNb4QOkDh/RjzGb1ZFefyCDTU2cwOmohZ0rQFcQUD3cq+dDBWnTWDVSpZMH/o0uDmpSs5ctieo9ssFZF3b86L5QnQ1GJYY4LYw9SMWlwICoVA7ugNH+/QO3wAQlmy3gyfhD7tNZH5sZKfC5B9MVtbnTeO0z020egVnqYO1FkxvrBrTniCr2LvAVxBAZS8JsnruohjDUKZIr8rM5XrYmB80ZDgZQlAOGypkkE74aPAjwl1ql9zBXikYB2+/F7bIazhPx28WhCkQIPB8RVd2QN
x-ms-exchange-antispam-messagedata: tqyDMF3nAmqNV65YOxTqsm/XmOxNvHDp1xsMQGyXDuymmygU38JBVlGP3shOjxRZ0ZunaBDg63Y8AxtFz0EJVYbvt347NCEThWzIy4PmGO7BN9QnzHeejCRVfnzYjEWjMaHgLgIvlTPxpr0SvuACuQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0DDF90DBEFD9D741B4CFA1512E3EB4C1@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2942
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Mark.Rutland@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT003.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(39860400002)(396003)(189003)(199004)(55016002)(316002)(70206006)(8936002)(186003)(16526019)(26005)(8676002)(956004)(1076003)(81156014)(81166006)(33656002)(336012)(54906003)(2906002)(4326008)(6862004)(70586007)(478600001)(86362001)(6636002)(7696005)(5660300002)(26826003)(356004);DIR:OUT;SFP:1101;SCL:1;SRVR:PR2PR08MB4778;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 404eb24c-f201-44de-e0d2-08d7a322a082
X-Forefront-PRVS: 02951C14DC
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jl7K8BkOBEBn/JYQHsfWjT4jE47gDkLch9zvzsxGajCTby6hLR4Af1hVlktM3IL+WyQdAvQDDmqax13lXpd6F0alYSDQIpOB2ookKyMfS2jsBk5vCxIRXKR9Nb4SZngO/wWBAm9apAcGBQpgF0BwGyrrMSqP5g//I1j/YvgN7I1YhW3T5+fOEYxIX7pDG2OeqJC/Be5GwYrTw9OngrrdrXSldQeGAPEV4KDFEg8kvKClKY0Zzg90WNC+fqmundUsNZfaMhHhv0OKtbQXNibchLAUEEAcQVkPWXif4yw1/WSPaHWoTvCUHrQdEuovgbAttq1n8eAFIRCVXuTq/up64xBeWMVKwzizDWXZfwdDQgvYQUmHhTjNhf+wE+WPNnojdpkvAEaQxVrx4wH9DeLOd5q63TJ/9+5ATY8x8yMGt26OLYwB8OH0T9tMpMkKF4I5
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2020 12:15:48.8633
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1703361b-2bd3-4243-8669-08d7a322a507
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB4778
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 03:19:35PM +0530, Anshuman Khandual wrote:
> There is a redundant do_sp_pc_abort() declaration in exceptions.h which c=
an
> be removed. Also do_el0_ia_bp_hardening() as been already been dropped wi=
th
> the commit bfe298745afc ("arm64: entry-common: don't touch daif before
> bp-hardening") and hence does not need a declaration any more. This shoul=
d
> not introduce any functional change.
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/exception.h | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/=
exception.h
> index b87c6e276ab1..7a6e81ca23a8 100644
> --- a/arch/arm64/include/asm/exception.h
> +++ b/arch/arm64/include/asm/exception.h
> @@ -33,7 +33,6 @@ static inline u32 disr_to_esr(u64 disr)
>
>  asmlinkage void enter_from_user_mode(void);
>  void do_mem_abort(unsigned long addr, unsigned int esr, struct pt_regs *=
regs);
> -void do_sp_pc_abort(unsigned long addr, unsigned int esr, struct pt_regs=
 *regs);
>  void do_undefinstr(struct pt_regs *regs);
>  asmlinkage void bad_mode(struct pt_regs *regs, int reason, unsigned int =
esr);
>  void do_debug_exception(unsigned long addr_if_watchpoint, unsigned int e=
sr,
> @@ -47,7 +46,4 @@ void bad_el0_sync(struct pt_regs *regs, int reason, uns=
igned int esr);
>  void do_cp15instr(unsigned int esr, struct pt_regs *regs);
>  void do_el0_svc(struct pt_regs *regs);
>  void do_el0_svc_compat(struct pt_regs *regs);
> -void do_el0_ia_bp_hardening(unsigned long addr,  unsigned int esr,
> -    struct pt_regs *regs);
> -
>  #endif/* __ASM_EXCEPTION_H */
> --
> 2.20.1
>
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

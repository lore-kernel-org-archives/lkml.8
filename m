Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0E57C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A4FF2067B
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="MJkmyUMh";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="MJkmyUMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729737AbgFOLnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 07:43:14 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:49101
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729642AbgFOLnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 07:43:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ma7y0JebvfR2qlgpX/GeMfqA09AcySzvtkwKLoE+LNY=;
 b=MJkmyUMhhPw6gwyBlCg/WnIRxV2tkc5bAglDsPQLyxN593H49AkfXSCp5boc8dSwOIAF9hgzoIU96BQhs+53UJEr9PgdANmzDcwfZmB46iVaoJoxVaLO0tSTkZgfK47AGuomPlPfk6BQE3wPwUGffGUIxgF47piVQs4MbFb5ylA=
Received: from AM7PR03CA0018.eurprd03.prod.outlook.com (2603:10a6:20b:130::28)
 by AM0PR08MB3666.eurprd08.prod.outlook.com (2603:10a6:208:dd::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.22; Mon, 15 Jun
 2020 11:43:05 +0000
Received: from AM5EUR03FT018.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:130:cafe::5a) by AM7PR03CA0018.outlook.office365.com
 (2603:10a6:20b:130::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19 via Frontend
 Transport; Mon, 15 Jun 2020 11:43:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT018.mail.protection.outlook.com (10.152.16.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Mon, 15 Jun 2020 11:43:05 +0000
Received: ("Tessian outbound 8bb15bb571b3:v59"); Mon, 15 Jun 2020 11:43:05 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 990b144d1fa36f7d
X-CR-MTA-TID: 64aa7808
Received: from cf8903235265.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id B5F5F256-C443-4D19-97A6-FEC4B41F19FD.1;
        Mon, 15 Jun 2020 11:43:00 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id cf8903235265.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 15 Jun 2020 11:43:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gl8cC8LGgthrucel3KrC44ctbPDhNbIH63Pj5ClunFnADdS7Eiym0Gtjed+262hNMZtWKUFoEoFSVBqVtOGJENcfKdDXuXWmiS+ZgTy23hQJOSfi5JHzKnIYWp2+INHjqGA5Ot7JW4aJn0jlAW3f2wWz+amMnI0LDJvziyi9qrOEj+yZD3eg+48h8sjW+6dEYibbubXnfV76Tw2acs4SEq7MXfO7MR5ZPdbxWlUeLqbE2ZcRpKBwl12tuxBj3WuJhkEYDLG4D/x6zQLA56bsGSm+1BVEApIJmA6cpAOwZXrR4OB87iHCmjpPkAge+JU1s5/EZpGLVxXHpJr18pSrDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ma7y0JebvfR2qlgpX/GeMfqA09AcySzvtkwKLoE+LNY=;
 b=MQPU3ZJkkUxtofxS/3AXQKrQr1dPC+MBNIWYNHlz/9DhcOUdEx7NtSPLUdLGJxxtWevKwprf31SSfjXnRMDARkLA/oVPo19kMOr5NUhb7IvSKrXkgmhPRDNtEgyDndGZO0H/2JbSE8tkMhB0upVTBzioy/26ptisvOdG1TJ2AqNHKfp/gGYLymfSCHLiLLfCpBMIjdXxmjPSnvcrD61r5p9Bqi67WwQW4aNz9ZCn7ixSHKVy1Arkaf7wK4fz/lLGKXnkrEKvmD1b0ZmsDi5GIAEkFtKa1/RLyyAzf/v7m0JRcLciBSo70kfASLLiDy4e2pqRaAWROJ375DNfsG8jmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ma7y0JebvfR2qlgpX/GeMfqA09AcySzvtkwKLoE+LNY=;
 b=MJkmyUMhhPw6gwyBlCg/WnIRxV2tkc5bAglDsPQLyxN593H49AkfXSCp5boc8dSwOIAF9hgzoIU96BQhs+53UJEr9PgdANmzDcwfZmB46iVaoJoxVaLO0tSTkZgfK47AGuomPlPfk6BQE3wPwUGffGUIxgF47piVQs4MbFb5ylA=
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
Received: from DB6PR0801MB1861.eurprd08.prod.outlook.com (2603:10a6:4:73::21)
 by DB6PR0801MB2087.eurprd08.prod.outlook.com (2603:10a6:4:77::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.23; Mon, 15 Jun
 2020 11:42:59 +0000
Received: from DB6PR0801MB1861.eurprd08.prod.outlook.com
 ([fe80::ac31:e5b9:8aa0:4a33]) by DB6PR0801MB1861.eurprd08.prod.outlook.com
 ([fe80::ac31:e5b9:8aa0:4a33%8]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 11:42:59 +0000
Date:   Mon, 15 Jun 2020 12:42:20 +0100
From:   Achin Gupta <achin.gupta@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, nd <nd@arm.com>
Subject: Re: [RFC PATCH 1/3] dt-bindings: Add ARM PSA FF binding for
 non-secure VM partitions
Message-ID: <20200615114220.GE46361@C02TC1ARHF1T>
References: <20200601094512.50509-1-sudeep.holla@arm.com>
 <20200601094512.50509-2-sudeep.holla@arm.com>
 <20200609223551.GA1620273@bogus>
 <20200610074346.GB15939@willie-the-truck>
 <5B3F18A4-5DA4-411E-9E26-7D25DEE3D414@arm.com>
 <20200611171222.GB7725@willie-the-truck>
 <20200615091639.GD46361@C02TC1ARHF1T>
 <20200615095133.GA2477@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200615095133.GA2477@willie-the-truck>
X-ClientProxiedBy: LO2P265CA0190.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::34) To DB6PR0801MB1861.eurprd08.prod.outlook.com
 (2603:10a6:4:73::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from C02TC1ARHF1T (217.140.99.251) by LO2P265CA0190.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21 via Frontend Transport; Mon, 15 Jun 2020 11:42:58 +0000
X-Originating-IP: [217.140.99.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 71719c1c-e5d6-4e98-44d7-08d8112144c7
X-MS-TrafficTypeDiagnostic: DB6PR0801MB2087:|AM0PR08MB3666:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB36668BC80C03BD751296865DFF9C0@AM0PR08MB3666.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 5NifFQqv5w0MYM6GIJcUdZbam8T8BzjbqsBzdMD9OgucXbeTkrPeSJ6RzygVpq0k1DhSIpw2mSN25T0HkH67m1ZaGsFtxWWcr2Cl/p2Hgwn/J5Qz6tZbBFFZT0Ak1YJwaAKTfTJMDVA95M1/WkblkyDzHJHtgIDomg6UYhj90Pzov/ok5cJ5Y1H+9rUARZ0t0Z33k/r66+/CdivhznpMFb9zr1ahMx+W83RreahpfcVV6QMLZ5gZ9SSVGGKhK87CMjoLdGvBfzJghpjwxrt6W61fL3OsLCXndBzA1MXAkwSXeEN0PH/bb0RbYE7WdxIsOmos5yOQJ1b4z3k/dA30dg==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0801MB1861.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(4326008)(16526019)(33656002)(186003)(55016002)(6916009)(8676002)(26005)(66946007)(8936002)(66476007)(5660300002)(1076003)(66556008)(9686003)(2906002)(316002)(52116002)(54906003)(44832011)(956004)(33716001)(6496006)(86362001)(83380400001)(478600001)(6666004)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: j6YNtTGdp/kYjGKTT7VVqkHCfbMbiazhHDp7gbZqaBcCPQJA17uJ0KtYYcppuI6SbRjH7j3/MHbvMMThavkJ/wSqy1V9ZZvlj/CYOQw3JWP2ETf2UkkAwu2Yer6+I2+9Jj9H6Lbjc0YwfJxZf/lKBwfZD40PdrBPkiZ4DjbegT1w/ZRtjs50Kc9OjTsr5jYcNojz6NVmbISE6rW7VJZ3ESMEnBVz/hL6B9qClODGcvowi6EWQ9Qo2yyPFhykeadFX6tuDgq6o4inMM63v1bUfvxwc4zT0YI1ki4YQuBlwv38DRGtOLKz8hMl1SMNYXhdfgDU2qTcQcbWqzxoxB1Oz/tWniBBmGbsBXwh+CUGK5wDr6o5tID3GgXQVjN2pHgOp9kPIS5jnfmpKvaYRoi2b1vqdI1EcxAmgPsFG2wf+SQyxRgnux+CrntbzUEpkwiuh8uXLXtBGF2uLj1OC4MJDM7PNqDNAldlmQaq60DCK7H7kNxRHZP5S7U/zhvwkrr/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB2087
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(46966005)(478600001)(336012)(956004)(70206006)(33716001)(26005)(55016002)(82740400003)(9686003)(186003)(33656002)(54906003)(47076004)(16526019)(5660300002)(70586007)(81166007)(6862004)(356005)(8936002)(1076003)(82310400002)(450100002)(8676002)(316002)(6496006)(86362001)(4326008)(44832011)(2906002)(6666004)(83380400001)(53546011)(36906005);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0f4457fa-6c72-40f8-5e21-08d8112140ac
X-Forefront-PRVS: 04359FAD81
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ALL8Vyz8q/ZRn+CcOMmvwfF/6eEL5LUuQdppv+9ry0TOErI/6rhaZS6n0H08f7lomfPw78+T+QBuaf7IZCRt1NbpWBCkca1qN2QDX+1CYB+JgEbJlGvewtZqc9aMIHXIP/rCc7+c3RQcAwpgBIEvh9+7+EWlB9PUbrRn+cdPJB9Rp0tB1rFtN8lH9HgCy1mxHC+YgLCuC+j5ZcfxLGJrXW5a5P63zViSWo+enVmuzA9T+XDcopKZfRi/19LDvPCuj/QUXJgACGkvbKLpp9xAC9Ta/C60braLhiwBUB+W0hkNr38Znkg4OTkA2dLufnlwVbhO3SEYpuXpAzf/dd6ae/pUAurJz4R2c1jl1o3xJXW5HYvtfagHB/DXtJh7P3fJvOwOLc8hxCDLU0IzQeYVqQ==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 11:43:05.7658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71719c1c-e5d6-4e98-44d7-08d8112144c7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3666
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 10:51:34AM +0100, Will Deacon wrote:
> On Mon, Jun 15, 2020 at 10:16:39AM +0100, Achin Gupta wrote:
> > On Thu, Jun 11, 2020 at 06:12:23PM +0100, Will Deacon wrote:
> > > On Thu, Jun 11, 2020 at 03:46:35PM +0000, Achin Gupta wrote:
> > > > > On 10 Jun 2020, at 08:43, Will Deacon <will@kernel.org> wrote:
> > > > > On Tue, Jun 09, 2020 at 04:35:51PM -0600, Rob Herring wrote:
> > > > >> On Mon, Jun 01, 2020 at 10:45:10AM +0100, Sudeep Holla wrote:
> > > > >>> Add devicetree bindings for a Arm PSA FF-A compliant non-secure partition
> > > > >>> at virtual interface(VMs).
> > > > >>>
> > > > >>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > > >>> ---
> > > > >>> .../devicetree/bindings/arm/arm,psa-ffa.txt   | 47 +++++++++++++++++++
> > > > >>> 1 file changed, 47 insertions(+)
> > > > >>> create mode 100644 Documentation/devicetree/bindings/arm/arm,psa-ffa.txt
> > > > >>
> > > > >> I'm hoping this goes away if the firmware is discoverable, but if not DT
> > > > >> bindings are DT schema now.
> > > > >
> > > > > We'll need the binding for the kvm host side, because there are plenty
> > > > > of partition properties that are not discoverable (e.g. number of vCPUs).
> > > >
> > > > Just trying to understand the req. a bit better…
> > > >
> > > > The FF-A driver in the host can use FFA_PARTITION_INFO_GET to determine
> > > > the count of partitions and their vCPUs.
> > > >
> > > > Is this about a guest being able to find out how many vCPUs it has?
> > >
> > > This is about KVM finding out the information it needs in order to spawn
> > > non-secure partitions. I don't see how it can do that with
> > > FFA_PARTITION_INFO_GET -- who would respond?
> >
> > Right! FFA_PARTITION_INFO_GET is meant to help the FF-A driver in the kernel to
> > determine partition properties. It assumes that EL2 SW has already read each
> > partition's manifest and will reply to this ABI.
> >
> > IIUC, with protected KVM, this information will have to be a part of the
> > manifest that the KVM host consumes.
>
> The host does not consume the manifest directly -- instead, the bootloader
> will use the manifest to populate these DT nodes. Again, these are *only*
> for non-secure virtual partitions which are to be managed by KVM.

Yes. Understand and agree. Manifest is an overloaded term. I was using it to
describe the DT nodes that the host will consume.

>
> > But then, can this be made discoverable (use a SMC for discovery) at all as Rob
> > had originally suggested. Firmware (Secure world) has no clue and the bootloader
> > is long gone.
>
> Make what discoverable?

I thought the original question was to make partition properties discoverable
instead of relying on DT nodes. I might have misunderstood. Looks like we are on
the same page in any case :o)

>
> > Separate topic, protected KVM does not get dibs on the manifest and it relies on
> > the KVM host to specify the address ranges for each partition? Does this not
> > mean that the KVM host can control the physical address space each partition
> > sees. This seems contrary to the isolation guarantees that protected KVM must
> > provide?
>
> The host is trusted during early boot, and gives up this trust after
> initialising EL2 fully. So roughly speaking, we:
>
> 	* Boot at EL2 and install a shim
> 	* Drop down to EL2 and start the host kernel
> 	* Before some initialisation (DT parsing, SMP bringup, etc)
> 	* Init KVM by calling back up to EL2 to install the full hypervisor
>
> At that point, the EL1 host is no longer trusted and the last call
> effectively "locks it out" from EL2.

Ok. Protected KVM (PKVM) must create S2 tables when asked to setup a partition
by the Host. My main concern is if PKVM must trust the Host to provide the
correct physical address space ranges for a partition?

I guess your point is this is not a problem since PKVM can lock the Host out of
those address ranges in any case?

It is a bit counter intuitive that the Host gets to see and potentially
manipulate information that was verified and extracted by the bootloader from
the partition's manifest. This hapens before PKVM sees the same
information. Can't put my finger on what could go wrong though. Depends upon the
threat model too!

>
> > > But you're right that number of vCPUs was a bad example. We also need
> > > information such as the entry point.
> >
> > Yes. From a spec perspective this should be specified in the partition manifest
> > unless the base address of the loaded image can be assummed to be the entry
> > point.
>
> Right, but the format of the manifest isn't defined by the spec so I really
> don't think it's something that Linux should be dealing with directly.

Agree.

cheers,
Achin
>
> Will

Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A0ADC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67CC92068E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="KwyOfUD5";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="KwyOfUD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgFOJRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:17:33 -0400
Received: from mail-eopbgr40063.outbound.protection.outlook.com ([40.107.4.63]:12930
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728986AbgFOJRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEm5mbDJcVCNHg4WEp6wbnYbahjZufexGnoIL2GMBcI=;
 b=KwyOfUD50KQpAmI6CdXAeW4g/4YrgsYyMJK1jksQ+khR2uCah9w5Vba8N+JTjLMxij63+GjBsvT+085F5DL6nWkRcPc+u82b51cGgjVRV6q24EyqBwycfQ/k/EhhIz7uFU4/CaANfRw/6GqbEnRZ4goTLnsvE++Y9iTd+P7kEpA=
Received: from AM6PR04CA0061.eurprd04.prod.outlook.com (2603:10a6:20b:f0::38)
 by AM7PR08MB5398.eurprd08.prod.outlook.com (2603:10a6:20b:103::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Mon, 15 Jun
 2020 09:17:26 +0000
Received: from AM5EUR03FT043.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:f0:cafe::c9) by AM6PR04CA0061.outlook.office365.com
 (2603:10a6:20b:f0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19 via Frontend
 Transport; Mon, 15 Jun 2020 09:17:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT043.mail.protection.outlook.com (10.152.17.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3088.18 via Frontend Transport; Mon, 15 Jun 2020 09:17:26 +0000
Received: ("Tessian outbound 56dbe829191e:v59"); Mon, 15 Jun 2020 09:17:26 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f22448e5125e39bc
X-CR-MTA-TID: 64aa7808
Received: from 875c345a3d9e.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id FDBEE1B2-3EA3-4511-8A10-CB590BDBB2C3.1;
        Mon, 15 Jun 2020 09:17:20 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 875c345a3d9e.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 15 Jun 2020 09:17:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZDWOK04ARKxK4FD+3E4M5BObMMcMUL2r+/aFasiyYBZah8D3x9onwUP9izkiJQrWTZeDH2rgpwf8XEoTIYfjS/NbsPS4QemybDBgQxH0lC2FEXZJ7HmTpc+iJxB6gdMGzvYGB07SM5fa609u5Om0w+La5B0IFLDwbY3PjoD1AvyaSn01bM7nMFO1hT7y1zzU07s9gmTebEdFHIEroTuOvyJfZ4ltABVDKFXWSLzd0M3GAZToy2IykUbSrFw+2WSsAhyjxFCCCNV8dblFIArGDe8RudcnpAc1vK35S9TMpwDjsmg88BSSxNLQYm9u7E9cAE34RFeUhAxh4UvA4pZBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEm5mbDJcVCNHg4WEp6wbnYbahjZufexGnoIL2GMBcI=;
 b=frTpq97JhGVbTUkemae0/kBJug7VOYpn+5CcnHPHPaQQzlJ2arUtekGoOMAYNPSZIEp8iRUOioDLGYcLbhdYo1aOlIhWtMtV5j9LSFX5Vu6/kIa45usQ6RuyDM59OAt1DW+RzX2eklix0cWwn7CILx21OUdGOt+2XqYdi6HGCTRWlDPqTz5SMgTHztuH/CAyC7d5QugladF19EkLoAfwwn5RHn9JegHLnfxNWdv8oWzMKHYxCVjBweUJ3Gwb1G81qpiLPTaIFTPxfExxPYYaKQPkzq3NspbCssBwKotbpWoB76aDfpYLlGm0quFEgG4TVcO4nM27yqrLRlg0ps4sug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WEm5mbDJcVCNHg4WEp6wbnYbahjZufexGnoIL2GMBcI=;
 b=KwyOfUD50KQpAmI6CdXAeW4g/4YrgsYyMJK1jksQ+khR2uCah9w5Vba8N+JTjLMxij63+GjBsvT+085F5DL6nWkRcPc+u82b51cGgjVRV6q24EyqBwycfQ/k/EhhIz7uFU4/CaANfRw/6GqbEnRZ4goTLnsvE++Y9iTd+P7kEpA=
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
Received: from DB6PR0801MB1861.eurprd08.prod.outlook.com (2603:10a6:4:73::21)
 by DB6PR0801MB1813.eurprd08.prod.outlook.com (2603:10a6:4:39::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Mon, 15 Jun
 2020 09:17:19 +0000
Received: from DB6PR0801MB1861.eurprd08.prod.outlook.com
 ([fe80::ac31:e5b9:8aa0:4a33]) by DB6PR0801MB1861.eurprd08.prod.outlook.com
 ([fe80::ac31:e5b9:8aa0:4a33%8]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 09:17:19 +0000
Date:   Mon, 15 Jun 2020 10:16:39 +0100
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
Message-ID: <20200615091639.GD46361@C02TC1ARHF1T>
References: <20200601094512.50509-1-sudeep.holla@arm.com>
 <20200601094512.50509-2-sudeep.holla@arm.com>
 <20200609223551.GA1620273@bogus>
 <20200610074346.GB15939@willie-the-truck>
 <5B3F18A4-5DA4-411E-9E26-7D25DEE3D414@arm.com>
 <20200611171222.GB7725@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200611171222.GB7725@willie-the-truck>
X-ClientProxiedBy: LO2P265CA0174.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::18) To DB6PR0801MB1861.eurprd08.prod.outlook.com
 (2603:10a6:4:73::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from C02TC1ARHF1T (217.140.99.251) by LO2P265CA0174.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18 via Frontend Transport; Mon, 15 Jun 2020 09:17:18 +0000
X-Originating-IP: [217.140.99.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5e12c8b5-c238-477a-f6cd-08d8110cebce
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1813:|AM7PR08MB5398:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5398B53EEB0F06CEA8293B85FF9C0@AM7PR08MB5398.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-Forefront-PRVS: 04359FAD81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: UeK3Mv+gnMEPE6PZoQK4NIiOb0MZzi+LbdERN3BChCn4y28fyOa73ARjuYi8ePHqpYmygTGjEcLo/lnCJdw9+WzTYzHWAlIVzAOeXLcaR9cQHJuNOIScUI5aA459NiYFpKSkmcG6lz1HEoKcKEFkU2FC0a5gsaIvldZPA5zQDJtIut/9cECqlywzqAFKxC58tzZAmd7uHYglMrYGex4mEnz8587WKSawkamxRqUWnMDXVwJKSMVHUF8DoZFC3Q5MYHvn4+MS8ItVLrlcL6VNzyPLpss0Xhf+zNN1QDMWVjOat98Rl3GOS9Q0BK6Ei0u1
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0801MB1861.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(33716001)(54906003)(478600001)(52116002)(9686003)(26005)(1076003)(86362001)(8936002)(2906002)(6666004)(66476007)(66946007)(6496006)(66556008)(44832011)(316002)(33656002)(186003)(8676002)(55016002)(5660300002)(4326008)(6916009)(53546011)(83380400001)(956004)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: jN5mu7mfwy7/K0mcKozwLWYUyO+CSiGpbbVoyEr09NaLPb11IirFYnXaA7scC0NImM5XZfMnYmU3n1jcMiDLY8LZjifdD2cK0EUMgO7u3755U/rKzvlY7Qbw9YNDaqHTttq14Sl4xnHRUUqfTlZoGYjw81ngz8Oc3Rseg1exb/Ye4TX7Jqp9s2SVS5KKM2Cp35M6sBr/MjW1vsnQoBaFs1w+WCV8BqM4FfUqUccAO182Kjh5Q7jX77DLPAF5oCPEYQ5VtpvVbCj+XrEK36PjhIaFlWS2y1Sw1TYrKKNU7UYEnAY2RI2iFVPA48rwr6VKroGwcr7VkyeE6aKM+q+fSaEtfIscNPR3pwmZXIuiNmFRV72xoGMQqey+u5HwVAM0nglCjziCY3KeZRm5RrCyfMp88zUUy5Jtzgqe1QEVA7DmepaufwrIGFhA4nGxAjX0m/Tqj9dQNaRPBW4kXxAyfGG10M1Nxcbot5udY9H2g/zdk2vhii0EC0+/FT8yzrcl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1813
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT043.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(376002)(136003)(39860400002)(46966005)(186003)(6862004)(16526019)(450100002)(8676002)(2906002)(9686003)(55016002)(70586007)(4326008)(6666004)(336012)(70206006)(956004)(8936002)(44832011)(82310400002)(33656002)(82740400003)(33716001)(81166007)(86362001)(6496006)(47076004)(53546011)(26005)(5660300002)(1076003)(83380400001)(316002)(478600001)(356005)(54906003)(36906005);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 18ed27a0-ec96-4454-d4c3-08d8110ce6e4
X-Forefront-PRVS: 04359FAD81
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hxvJCVaIGT9o/t/qTMCMBNqsDs+Ys5gRHV15O702oMvTywnIAPUOwNXLFzLCBeNZfPeI7MivQLgKVa7UUOPHbDxsrbYi5Gyqw4s7Px/isaZnBfTcKF352UaOQtAyQJLllQ8R0UMLWHoafVizALGdRpwlIl2rfgJjTl6AmlJMZbVD+WaG/jOCxPOy5qbFGyH/Rr5TyLEvFVqlqiKGjd/XZvg4V29fN9yCSlBmFNsABZyNswJlZymA8N2Z5DNOc5wngp3jul1SxakLANima9nJSrsyLMVz7+W5v7kzFQ35nbfN28eEVBuBShFov5/R+gAcibUnEEKcrWop6fY/xiWSQNKxLXXKmfLQb5k82UFyzGJ8wbhDAS+ByyTDGRe408FFyEfWJ1r95Cbmr6hARk0P9Q==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2020 09:17:26.5704
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e12c8b5-c238-477a-f6cd-08d8110cebce
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5398
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 06:12:23PM +0100, Will Deacon wrote:
> On Thu, Jun 11, 2020 at 03:46:35PM +0000, Achin Gupta wrote:
> > > On 10 Jun 2020, at 08:43, Will Deacon <will@kernel.org> wrote:
> > > On Tue, Jun 09, 2020 at 04:35:51PM -0600, Rob Herring wrote:
> > >> On Mon, Jun 01, 2020 at 10:45:10AM +0100, Sudeep Holla wrote:
> > >>> Add devicetree bindings for a Arm PSA FF-A compliant non-secure partition
> > >>> at virtual interface(VMs).
> > >>>
> > >>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > >>> ---
> > >>> .../devicetree/bindings/arm/arm,psa-ffa.txt   | 47 +++++++++++++++++++
> > >>> 1 file changed, 47 insertions(+)
> > >>> create mode 100644 Documentation/devicetree/bindings/arm/arm,psa-ffa.txt
> > >>
> > >> I'm hoping this goes away if the firmware is discoverable, but if not DT
> > >> bindings are DT schema now.
> > >
> > > We'll need the binding for the kvm host side, because there are plenty
> > > of partition properties that are not discoverable (e.g. number of vCPUs).
> >
> > Just trying to understand the req. a bit better…
> >
> > The FF-A driver in the host can use FFA_PARTITION_INFO_GET to determine
> > the count of partitions and their vCPUs.
> >
> > Is this about a guest being able to find out how many vCPUs it has?
>
> This is about KVM finding out the information it needs in order to spawn
> non-secure partitions. I don't see how it can do that with
> FFA_PARTITION_INFO_GET -- who would respond?

Right! FFA_PARTITION_INFO_GET is meant to help the FF-A driver in the kernel to
determine partition properties. It assumes that EL2 SW has already read each
partition's manifest and will reply to this ABI.

IIUC, with protected KVM, this information will have to be a part of the
manifest that the KVM host consumes.

But then, can this be made discoverable (use a SMC for discovery) at all as Rob
had originally suggested. Firmware (Secure world) has no clue and the bootloader
is long gone.

Separate topic, protected KVM does not get dibs on the manifest and it relies on
the KVM host to specify the address ranges for each partition? Does this not
mean that the KVM host can control the physical address space each partition
sees. This seems contrary to the isolation guarantees that protected KVM must
provide?

>
> But you're right that number of vCPUs was a bad example. We also need
> information such as the entry point.

Yes. From a spec perspective this should be specified in the partition manifest
unless the base address of the loaded image can be assummed to be the entry
point.

cheers,
Achin

>
> Will

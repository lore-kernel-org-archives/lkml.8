Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FC4C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BAF320758
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="5hh5fsQ5";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="5hh5fsQ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727792AbgGGGIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:08:34 -0400
Received: from mail-eopbgr20086.outbound.protection.outlook.com ([40.107.2.86]:31877
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727008AbgGGGIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1+j9ClshorGQ7SpVxIgSgbUxhaHtZ9yGrGWPJxNg/g=;
 b=5hh5fsQ5w1c54pf++kjoXJmERphVB+6gBMAy6Vvajkc4ij/TjWwROM24O9HAY+8wTR66dCf91Dtfa+4Qlskcj37g+6Q+Tjm8s1f3+7xnCVK3wm4CTpzPalbqzy6ed/MoaYloohv28+oO2irWAoasmfvmEIZjs2z7bzOydErnHP8=
Received: from AM5PR0402CA0019.eurprd04.prod.outlook.com
 (2603:10a6:203:90::29) by AM0PR08MB4977.eurprd08.prod.outlook.com
 (2603:10a6:208:163::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21; Tue, 7 Jul
 2020 06:08:29 +0000
Received: from AM5EUR03FT057.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:203:90:cafe::6) by AM5PR0402CA0019.outlook.office365.com
 (2603:10a6:203:90::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.21 via Frontend
 Transport; Tue, 7 Jul 2020 06:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT057.mail.protection.outlook.com (10.152.17.44) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.24 via Frontend Transport; Tue, 7 Jul 2020 06:08:29 +0000
Received: ("Tessian outbound e44de778b77e:v62"); Tue, 07 Jul 2020 06:08:29 +0000
X-CR-MTA-TID: 64aa7808
Received: from 513f3cd52b24.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 670B9F5A-F7B9-468B-B976-A26459C626F1.1;
        Tue, 07 Jul 2020 06:08:24 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 513f3cd52b24.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 07 Jul 2020 06:08:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ag7ZBpGqAoDqDiBtInl4tAIYS8vh4uO1adx2YmHnXrkVpdtkQteZTPNRAVhjndVvm/STF9Bap16KoV37/tjcHUi57p6Rq/M/nVp88nolNTaiWfukR8cVvJsHvbCF0BLjHwUfvxYuvwxPF3TO36aHS3bsrJmJzWzmxOOXWi5MCOoVEyt0olJ+trajLjHx+qA4eEwyzR8l68aBRLHvRPuSGoKtDWOqTwdP7T6alWFqyIG72bPMS0wgYdYoA57oY52H5HNNG4GaU86AJS7Vy69mD9+g0taIUwla65LA6TJqDomiLMPyXBwqBtNnodr2KH7HVZmZQ0bPncRYiih0Q256wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1+j9ClshorGQ7SpVxIgSgbUxhaHtZ9yGrGWPJxNg/g=;
 b=Dd2V0/6PVTb30VVl0JBxpUnHVVj/X6f6qI8yNDF1mD0V+S+ZOgVqOl8Y0SZ0+FoQf1D0uZPgzV9kT3jlSeKGQ1qzig+7x5P50MGzBYTaCNLE5AUA5ExPoVerHEWB5Ip48HerVQF7UWnZQE5qsj6sDLLyJaIOgharts5gbOaBzO6SnHtzjbXYH7icM2aVsM2BpZqfNE2P9d9L9p8nwtaS9cNjW0LELg07ZbNVBCAGJzh32j10DtH4AodRQV/hjJPbmxVuYnY0xAe5K2HyU1/uyOepdwDn58I9zBFcPmbkyU++pn3umwGCIZCPG9o6hKL7prOmeeeweKbHs2z73lmmiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1+j9ClshorGQ7SpVxIgSgbUxhaHtZ9yGrGWPJxNg/g=;
 b=5hh5fsQ5w1c54pf++kjoXJmERphVB+6gBMAy6Vvajkc4ij/TjWwROM24O9HAY+8wTR66dCf91Dtfa+4Qlskcj37g+6Q+Tjm8s1f3+7xnCVK3wm4CTpzPalbqzy6ed/MoaYloohv28+oO2irWAoasmfvmEIZjs2z7bzOydErnHP8=
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com (2603:10a6:20b:af::32)
 by AM6PR08MB5080.eurprd08.prod.outlook.com (2603:10a6:20b:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Tue, 7 Jul
 2020 06:08:21 +0000
Received: from AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0]) by AM6PR08MB4069.eurprd08.prod.outlook.com
 ([fe80::8c97:9695:2f8d:3ae0%5]) with mapi id 15.20.3174.020; Tue, 7 Jul 2020
 06:08:21 +0000
From:   Justin He <Justin.He@arm.com>
To:     Justin He <Justin.He@arm.com>
CC:     Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Kaly Xin <Kaly.Xin@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Subject: RE: [RFC PATCH v2 2/3] device-dax: use fallback nid when numa_node is
 invalid
Thread-Topic: [RFC PATCH v2 2/3] device-dax: use fallback nid when numa_node
 is invalid
Thread-Index: AQHWVCPVY5+RvFDzZEO2wqan5w9kVKj7n9gQ
Date:   Tue, 7 Jul 2020 06:08:21 +0000
Message-ID: <AM6PR08MB40699B8B08470564129F4C44F7660@AM6PR08MB4069.eurprd08.prod.outlook.com>
References: <20200707055917.143653-1-justin.he@arm.com>
 <20200707055917.143653-3-justin.he@arm.com>
In-Reply-To: <20200707055917.143653-3-justin.he@arm.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 87e84cc8-9fac-4593-8fca-6ac71b1809b2.1
x-checkrecipientchecked: true
Authentication-Results-Original: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
x-originating-ip: [203.126.0.112]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f4f31c2c-66b7-4a52-f9d8-08d8223c2b82
x-ms-traffictypediagnostic: AM6PR08MB5080:|AM0PR08MB4977:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB497777C57086002EA8447219F7660@AM0PR08MB4977.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:9508;
x-forefront-prvs: 0457F11EAF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Zq1R23CPnlG5shxJahYKnGQlI6FR2XdzkPPFKro9AtYsOySD2WJ5FYEynVPdaBg2+d7qaUGE6DAuRViUhDgq5ioxPRidC3LaCD1EuG9UTO66ekZB7X3xKTlnzVq3g68aaUMWhb9IzyW4ww0rdiqtU5E1qGJQwggWgJAqezEmQ497xNACkqVlUmx6WMgrx1BcCp74Dqmx+vuHXwRKEkqjrEk6WCV7/Mbcq//j0bQPixmCuDgaeD66TsD6MrJtMDZLcYzlNLnWtDWY66xgjJh0NmT0py0v8GN/b81c9bHrB0snIsH6omAfYPRaBG+GddYzpbZjtxXBiz8qbwcLoVizBA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4069.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39860400002)(366004)(376002)(346002)(52536014)(2906002)(5660300002)(54906003)(6200100001)(316002)(83380400001)(8676002)(33656002)(4326008)(66446008)(66946007)(76116006)(66476007)(66556008)(64756008)(26005)(71200400001)(55016002)(186003)(7696005)(8936002)(478600001)(6862004)(86362001)(7416002)(53546011)(6506007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: hto7kML7YmEtp8AzOA1llPIrx4Ol2mj+yHsKjov4snxw8PQDhI0kvIoyOziX2h4gXlqUPG+uSRdIL/p+qpzOO8lOuU4NlGcJ5jLgD4k1UGi2JrFlsp0mXSWemvxbwD59/qCwTpR44DnYhO7wlosJQ8UPohhs4v+W0uojuq7XVjWZXIGY0CpZA7ayLd2pMUgfB/xHagSk/oUPqw6r7sBhoMpUh+OePZyaYuARCYfEsJnBU1nyNkFFFZTdjxk1Ki9IOHfK1OCeTfKu2T2bRNCu/jmkZ030GmyUsu8rUVj3ZxG8c0CfFQcVMGaowElLtJcD5N84dVjjwtFblVUIfAFf47CqOaz+yN3jxyI4cP41/0s+VT/r5IlYYvP5poQjLSl06xwWu1LNOCel2XzjhzDuWuLkkMab5nw/OwESdX+HOwe7Nixl4wrdxSvRULCTsLR0GsflkmAZ6W95C+pzlFJCPS6IydsLlh42NAMq9O5+l1I=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5080
Original-Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT057.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(46966005)(47076004)(83380400001)(6200100001)(26005)(33656002)(8676002)(53546011)(70206006)(82310400002)(107886003)(7696005)(4326008)(36906005)(478600001)(81166007)(8936002)(356005)(6506007)(70586007)(6862004)(82740400003)(86362001)(316002)(2906002)(186003)(5660300002)(55016002)(54906003)(9686003)(336012)(52536014);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 939e9621-6bf7-4a66-dab3-08d8223c26b3
X-Forefront-PRVS: 0457F11EAF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ncc64qIj0tQpF/NtgbfE3CglROOUfkdxdjrUeB5hOjLHATh0dSn34YbijdNckThAa63/VyxvSl0hh26w7zLJvhvwJg7+4ktHCq/6MA8jvZW5duL1/M3PsTLPWPPeXhgZG9MEwcLTB+aM52UUsvofTZsH/Ye0EQdFed2MghNLqNDqpb5s6LTnyL2XEI0rI6cFK+f0OVcPhZmJP0mqwYWbmLRzn1dFThTD5LwwJrLtCBP0AzwRsESOhFDE8nuXsukajAYGXsXtYQF1wK5OZJsBN7iJBAn0EE8AY+icZQkEGc1Mrcq8McKPAT+mJHez4/lSE3SHecPVKJiP7L5KLZPi1p01cXdWWXFuJffLFu7FUvceBZI55kjYA+oyOY/cBATXYV7qmLjNZQo16G1AahLq+Q==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2020 06:08:29.5501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f31c2c-66b7-4a52-f9d8-08d8223c2b82
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT057.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4977
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[+] add Powerpc maintainers to check my concern about memory_add_physaddr_t=
o_nid
Exporting


--
Cheers,
Justin (Jia He)



> -----Original Message-----
> From: Jia He <justin.he@arm.com>
> Sent: Tuesday, July 7, 2020 1:59 PM
> To: Catalin Marinas <Catalin.Marinas@arm.com>; Will Deacon
> <will@kernel.org>; Dan Williams <dan.j.williams@intel.com>; Vishal Verma
> <vishal.l.verma@intel.com>; Dave Jiang <dave.jiang@intel.com>
> Cc: Michal Hocko <mhocko@suse.com>; Andrew Morton <akpm@linux-
> foundation.org>; Mike Rapoport <rppt@linux.ibm.com>; Baoquan He
> <bhe@redhat.com>; Chuhong Yuan <hslester96@gmail.com>; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> mm@kvack.org; linux-nvdimm@lists.01.org; Kaly Xin <Kaly.Xin@arm.com>;
> Justin He <Justin.He@arm.com>
> Subject: [RFC PATCH v2 2/3] device-dax: use fallback nid when numa_node i=
s
> invalid
>=20
> Previously, numa_off is set unconditionally at the end of
> dummy_numa_init(),
> even with a fake numa node. Then ACPI detects node id as NUMA_NO_NODE(-1)
> in
> acpi_map_pxm_to_node() because it regards numa_off as turning off the num=
a
> node. Hence dev_dax->target_node is NUMA_NO_NODE on arm64 with fake numa.
>=20
> Without this patch, pmem can't be probed as a RAM device on arm64 if SRAT
> table
> isn't present:
> $ndctl create-namespace -fe namespace0.0 --mode=3Ddevdax --map=3Ddev -s 1=
g -a
> 64K
> kmem dax0.0: rejecting DAX region [mem 0x240400000-0x2bfffffff] with
> invalid node: -1
> kmem: probe of dax0.0 failed with error -22
>=20
> This fixes it by using fallback memory_add_physaddr_to_nid() as nid.
>=20
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Jia He <justin.he@arm.com>
> ---
> I noticed that on powerpc memory_add_physaddr_to_nid is not exported for
> module
> driver. Set it to RFC due to this concern.
>=20
>  drivers/dax/kmem.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 275aa5f87399..68e693ca6d59 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -28,20 +28,22 @@ int dev_dax_kmem_probe(struct device *dev)
>  	resource_size_t kmem_end;
>  	struct resource *new_res;
>  	const char *new_res_name;
> -	int numa_node;
> +	int numa_node, new_node;
>  	int rc;
>=20
>  	/*
>  	 * Ensure good NUMA information for the persistent memory.
> -	 * Without this check, there is a risk that slow memory
> -	 * could be mixed in a node with faster memory, causing
> -	 * unavoidable performance issues.
> +	 * Without this check, there is a risk but not fatal that slow
> +	 * memory could be mixed in a node with faster memory, causing
> +	 * unavoidable performance issues. Furthermore, fallback node
> +	 * id can be used when numa_node is invalid.
>  	 */
>  	numa_node =3D dev_dax->target_node;
>  	if (numa_node < 0) {
> -		dev_warn(dev, "rejecting DAX region %pR with invalid
> node: %d\n",
> -			 res, numa_node);
> -		return -EINVAL;
> +		new_node =3D memory_add_physaddr_to_nid(kmem_start);
> +		dev_info(dev, "changing nid from %d to %d for DAX
> region %pR\n",
> +			numa_node, new_node, res);
> +		numa_node =3D new_node;
>  	}
>=20
>  	/* Hotplug starting at the beginning of the next block: */
> @@ -100,6 +102,7 @@ static int dev_dax_kmem_remove(struct device *dev)
>  	resource_size_t kmem_start =3D res->start;
>  	resource_size_t kmem_size =3D resource_size(res);
>  	const char *res_name =3D res->name;
> +	int numa_node =3D dev_dax->target_node;
>  	int rc;
>=20
>  	/*
> @@ -108,7 +111,10 @@ static int dev_dax_kmem_remove(struct device *dev)
>  	 * there is no way to hotremove this memory until reboot because
> device
>  	 * unbind will succeed even if we return failure.
>  	 */
> -	rc =3D remove_memory(dev_dax->target_node, kmem_start, kmem_size);
> +	if (numa_node < 0)
> +		numa_node =3D memory_add_physaddr_to_nid(kmem_start);
> +
> +	rc =3D remove_memory(numa_node, kmem_start, kmem_size);
>  	if (rc) {
>  		any_hotremove_failed =3D true;
>  		dev_err(dev,
> --
> 2.17.1


Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A644C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 14:50:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3769920719
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 14:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="HcX4EvYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgHaOuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 10:50:21 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:7312 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbgHaOuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 10:50:18 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f4d0dfd0000>; Mon, 31 Aug 2020 07:49:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 31 Aug 2020 07:50:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 31 Aug 2020 07:50:18 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 31 Aug
 2020 14:50:18 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Mon, 31 Aug 2020 14:50:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtcJWaAj2IRmjECrjrmN/pe/GOkHk31/FHAUWcrDvdBxTYNj0dSfb9zjWuvMoyAT6NtRJ4rCa7znSh6hJjTPLtFAncf9TFF5z4AAnr9TBlVoZXST4Q69I7xtu7RTv6d9wyfAFunV2pOSCUU99GheSzUsIoJD7K3PUceoWZR3xL6QE6Sd29bffK3xNJUqVOammsv52s/oiv953BALcSUn4BOUtG+QE52WxrlE4Fi44iXQ22J95+LHRxMikuKEYk+uTMNplD/kNYRNQwTGrRX9FmcsWFlRXS1uRdVFw4MlF7UD+pBnj8KONn+lBr2Zyqmxj7BXGyRxP8Cb8meP16MltA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Gk1Zpdrd6vCNw/Q0n5wQTCgNmjSl42X2mfV8a9X0hc=;
 b=KfwRyeYwYGH8aKvARvP68F1OOTWRZ6P6azJ7ANQo/U/GTspse8T2tkc40UOKRNGkD8aqRzmkz1B8Ladp+1DLoT0bvrFvOIDabufp6VXVpEqJ9+uaISRZunAAQD3wgxYrpEvL0Y5U8PbsC3nGXSrTKiGTZNxo/dkyvMfyA+4s4qnAvYMzU2KozbyqOmvYnp9/4iMV7ou/C2rf1T+xcDJUZAoosyMy4H983sju4l8j4PtlLkit7NisWaad2jYtZqAf3HrVyqD+Q5X5T4SEuzRZpnb/s5ksyGOSwKaNMYRwk6O4TcW9VxCA+Eada5X21OVbybKMj/f3K7/pdLIaG2SGMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2604.namprd12.prod.outlook.com (2603:10b6:5:4d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Mon, 31 Aug
 2020 14:50:16 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3326.025; Mon, 31 Aug 2020
 14:50:16 +0000
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
CC:     Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>
Subject: [PATCH] log2: add missing () around n in roundup_pow_of_two()
Date:   Mon, 31 Aug 2020 11:50:15 -0300
Message-ID: <0-v1-8a2697e3c003+41165-log_brackets_jgg@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BL0PR02CA0052.namprd02.prod.outlook.com
 (2603:10b6:207:3d::29) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by BL0PR02CA0052.namprd02.prod.outlook.com (2603:10b6:207:3d::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Mon, 31 Aug 2020 14:50:16 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1kCl8R-002Ptl-H4; Mon, 31 Aug 2020 11:50:15 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2058582-e967-4c15-e9b1-08d84dbd2ca7
X-MS-TrafficTypeDiagnostic: DM6PR12MB2604:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2604DCFEA0D30A47A65530B8C2510@DM6PR12MB2604.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HxMA7lLtWF5IJjFCGUfiMMdRHE1LwxPDDc7y6PAdno8iDNef/w7E5YdtdUL9gKCvEOXbQuFMf7b0e25Oin/GCHi/srLWOJAFbwV4G0jSSjUID8mGoCtIHcjVyWurVMqiAICJFJO28jbHCDXfR5cuI55hu9XxichCR+MtUJKANUXBCWR6ZDgLhl41uOdp/3GmwUsTqAAZJD/Hvq17Y/Edrnvycc7MQhqHlIhi55GrR42l4ENHwB8LskHh4sezNHBFwY2Tp9ZhMiQCNHtJkygdp/RCbXy6grBVApzMXswLc+KCllRrlICQ+fHFuvNFqszJT0XcTQ52FYtf2JaN6nXN4jR88yEjCBSYz5jBd8KGDsFIW1h6fDsGxhZ/KsHwXdpY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(366004)(396003)(8676002)(8936002)(83380400001)(9786002)(66946007)(9746002)(186003)(26005)(66556008)(316002)(4744005)(2616005)(66476007)(4326008)(478600001)(54906003)(2906002)(5660300002)(36756003)(86362001)(426003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: N5kjU5/+xz3GRsDHjJCGhfm2y6MnjEGn7TBDQrq9cB2X3wWnGUTAH8Vq2FRrcOe5pJH30LeTvCUQNXc0HN5cqL+DqiDphmcs886A09WQSpCsekpHeMgk4Bza4u3/YLBxtkMeNu3eLlQJDNxhYYnSWO/ak0Dvq0ahfMsQKktbRcDMJRq2oXp/E4r/J+EZ1WNd/i6JcYSOR2cKxNNr4OncnZW+pwoEzu+EimUDGzqxP/VP65Ywdo3OXxtJkMv1qYQdWg1ftQK4u+oTFtfIOZEIbdo1IFlk4AS5SLXIAhUyasKFQHRc6lR/BCJtUa9o2ftfrJ2YQvOBY5MhKLtD/V0uMfZj3v2Ecgg3+GEfYekno0bwGu9jl0UP1rn/6I6sWPz7ZGqPbaUeszCgPZ0xeRe2IbJOVZt7GiDrSLxNlek+eFkQ/JUTjGbpxmRCDChY8d/F9yzTi8FDYFc+RCSeOs7hEws60K0BbdA6/SjVuLDHfuZbi1DbalohleQghduy9Zg2m2mf1vEV4Df7KUO/PHY0fF3bB7yRZKDqkHUrq5lkSOpU9mTKtVkBc29rKmbOJEKv7JpP4Qz8lLve0OvfB1yIcLfOdZpew2PKEK/kXqNaBpvpKkBv1eArMWjJeb0GOUqRiSDPgDoqhFPsLIJMEYnGPw==
X-MS-Exchange-CrossTenant-Network-Message-Id: e2058582-e967-4c15-e9b1-08d84dbd2ca7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2020 14:50:16.8143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mqG7QUIMfDv6navqTWIerZeFao71UuDVLfQdgGr1ZjceAhmcDnLNWUP4lRrMBR/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2604
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598885373; bh=0eGKkWygtcr+sxBX1i4075OVxmJIZ+svQXiihDl4FL0=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:From:To:CC:
         Subject:Date:Message-ID:Content-Transfer-Encoding:Content-Type:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-Microsoft-Antispam-PRVS:
         X-MS-Oob-TLC-OOBClassifiers:X-MS-Exchange-SenderADCheck:
         X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
         X-Forefront-Antispam-Report:X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=HcX4EvYHnnfJryuZKpBy6uUSmXFlKe0+J43wxi/WwfTY+Tk2WSnUOXN7AUM8CTyqq
         hByko+0mmI81Jn72Yw1yszReG9KBstN9hS4C4YEJqh180iLq4NE7ubtWJ7oTdj+KdP
         oW5p3MBxTT4bDqqkqCxONlYxt32cyoak/NJ0ZezHAKMMrJzCaMZHem68f54mesDGgK
         0j7bOczLFdKSZQK3k9YAXAkUiD/wAVS8twSnhMIZy4ZhL75PMbsOW36GZG1T4QeEK0
         +lnaHNafb1atz7MXQJRgSg7GRmYWn1hyRuxcyusPJaYr2wtHVgMx6WtCqTUE54kATA
         jPyK8LuJPgFWg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise gcc generates warnings if the expression is complicated.

Fixes: 312a0c170945 ("[PATCH] LOG2: Alter roundup_pow_of_two() so that it c=
an use a ilog2() on a constant")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 include/linux/log2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Hi Andrew, I think this is appropriate for your tree? Thanks

diff --git a/include/linux/log2.h b/include/linux/log2.h
index 83a4a3ca3e8a76..c619ec6eff4aee 100644
--- a/include/linux/log2.h
+++ b/include/linux/log2.h
@@ -173,7 +173,7 @@ unsigned long __rounddown_pow_of_two(unsigned long n)
 #define roundup_pow_of_two(n)			\
 (						\
 	__builtin_constant_p(n) ? (		\
-		(n =3D=3D 1) ? 1 :			\
+		((n) =3D=3D 1) ? 1 :		\
 		(1UL << (ilog2((n) - 1) + 1))	\
 				   ) :		\
 	__roundup_pow_of_two(n)			\
--=20
2.28.0


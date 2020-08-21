Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DFEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CE052075E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QU57Ks1F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728653AbgHUNlJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:41:09 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4865 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbgHUNlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:41:08 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3fcee50002>; Fri, 21 Aug 2020 06:40:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 21 Aug 2020 06:41:07 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 21 Aug 2020 06:41:07 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 21 Aug
 2020 13:41:07 +0000
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Fri, 21 Aug 2020 13:41:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=duhgzgQiwGPe/Me9yC4MocrqmITnkVQehzygUcDyfJG7EabET28HA3J9+Xm9Yi5FQYPSjQ0X2fspP0GnmKmsdgYKJ04yH0MEoouwE9T/rZZC/GhkR6w6miyAJOQZYVusWptFrP1Xp+x+tNYv69q2nsnZgtwicmbb+/cGXPHt0stHcfiHtjKPpICh4xhE9yV0ojIdd1XM7VMnpYEnDVP5lLM2m623dvaJJc41SBsrEeJYM9vE8NYJyqPX/UvoHrHV20uA9rxtYy8dt5n8Sv2b+5LFufHcKB03hy4OqMde9k4eYvjOjS/E4RQLLRPXnbK0HSL17SvUsriUEHQ3xpIjpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fp+bi2c/EEx0HD3kR5JNoOOaorgtTTxyemlzMLWVlPk=;
 b=XFy/gh5TjQbxP62ZTtjP6RigsNw83w3JGZkGzKNPIHts8G3glSBtF9cm/HPMNRw+2bA+/dyKRCNhpWVLFBGtJrJjIRQK1tkykUuqfQY7WSQUoxDkDqDBo6c2wUNm9XVRb2RIQPuPJO2bKBI7FvZowJk9Kl5zeEOrbY7t/GcKYBX8yyvQblb2CLMqkI4/YE5eY23N7WZTNLfHmi5RRHPdE2Ze3PwZAoU+4ZZm2MmoGiZ6MxARCrCMHfFadNE35zHFw2ecCoQqjwTICzHb+q+iBtnyzeC8lVgo/Ds5WHkuSNIr5TGv+yrxMlnHyt3WpSubhvhbr7riyN0sao4dE3taNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR1201MB0108.namprd12.prod.outlook.com (2603:10b6:4:58::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Fri, 21 Aug
 2020 13:41:05 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::2d79:7f96:6406:6c76%3]) with mapi id 15.20.3305.025; Fri, 21 Aug 2020
 13:41:05 +0000
Date:   Fri, 21 Aug 2020 10:41:03 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next] MAINTAINERS: Update Mellanox and Cumulus
 Network addresses to new domain
Message-ID: <20200821134103.GA1152540@nvidia.com>
References: <20200810091100.243932-1-leon@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200810091100.243932-1-leon@kernel.org>
X-ClientProxiedBy: MN2PR16CA0015.namprd16.prod.outlook.com
 (2603:10b6:208:134::28) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR16CA0015.namprd16.prod.outlook.com (2603:10b6:208:134::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25 via Frontend Transport; Fri, 21 Aug 2020 13:41:04 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1k97Hz-00B07i-DX; Fri, 21 Aug 2020 10:41:03 -0300
X-Originating-IP: [156.34.48.30]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06750c44-c06c-4723-abe4-08d845d7d9b5
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0108:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0108245812CA597569FA2B84C25B0@DM5PR1201MB0108.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mkGIrqyF0FaDTLAnU+mKkCoilwguufL4pq9g6f9vQcTwyfXwe4UYOk/ShBjXrKHTBDVYScR59O7mCJdhJxeL9eC3cxNvZjM0C3eqil8r8R2OOjbdWnmhoVjEcLK8ZPIOBVZTT9MC+NXUl6a5VR4d/YtoIPX/UCSCvN/75OO5Aqa5DdlpkUuAt1be5KaRVaPITO/IxksBTHCBaNyTU7qBZqa7ZbgeeyXhhLeamMRhQMzogU7tqEgOcPBOqVfwFAb8nZuHP4C+1wiCWfIy4zbnpYmcoGqEdHSBbkOmz3D02HOHLdL3EBBe9WFcHmqgzLc1Mz+i78TfOeElpkczWRzobg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(39860400002)(396003)(366004)(8936002)(66476007)(36756003)(83380400001)(9786002)(316002)(26005)(8676002)(66556008)(478600001)(9746002)(2906002)(5660300002)(2616005)(186003)(33656002)(6916009)(54906003)(86362001)(426003)(4326008)(66946007)(1076003)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: t+CVSrCiZZTGZHXagWDhev+mYWuBlnkxfTxyPqUyky4RFguoplCwIYEH3nPlh15tiHuKBPjXhZpFrsiHSJrfcmuV17B+uoK5fG/Hp6b71qSG+kJSOmCPOX3a9ueiL7iyC740+3c7OiGIUr8vYjMJtqqb5/btDVCHxCgWPOrpCE1ZdMiIT+GLj9Ip6gp1i+OJE5eyjKH6vMa35mfNVK1Trjiz2kSSZAa0PrFnEUoFbcMDFzLm8B8aU0Tz4jUmgbLiYQTPAMqA72qG6FAVvDrr3l8+7o9thYzaiWZpVWIcxZk90OevnBOO6cqqZAMR64gl0zD3nJuSUYx2tAwnSNIPw64Ajva06THVfzmx9eDZdzXl06dneTFrLPu80W+epfjUlsKbjgt3lxMVYN3KxbsdlP0Pnj3ukyvNf6OKBcv0vDjmbeNk6nQTOVpM7OS/wlkxPlbHfwmdp1aKgS+HICCBu8sJYM5hDLHKJsFD0wsjqMjLFrDoP5uT17mnDgs07J2A/kf//7HDAxDGcZwXXrYHhlNILGiDR71eu8SR01hz1HD7Jrx+/R6PqmL4KRYp1VGDcH1sDK4wRJD+vY/ocZSJt/Ox5pSnDgHNxa83G7gjDocFLBo4/9A+uyDnxZrxw7vipLVIuWi4taRv4lED0Gfr1A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 06750c44-c06c-4723-abe4-08d845d7d9b5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 13:41:04.8400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3SJXd3FLkFPhHxGQaDtz8kTY66n8JYJZQ9Dvr83skQvNoQVT1GCEOQGdmBFv+rrv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0108
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1598017253; bh=Fp+bi2c/EEx0HD3kR5JNoOOaorgtTTxyemlzMLWVlPk=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:Authentication-Results:Date:From:To:CC:
         Subject:Message-ID:References:Content-Type:Content-Disposition:
         In-Reply-To:X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Originating-IP:
         X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id:
         X-MS-TrafficTypeDiagnostic:X-MS-Exchange-Transport-Forked:
         X-Microsoft-Antispam-PRVS:X-MS-Oob-TLC-OOBClassifiers:
         X-MS-Exchange-SenderADCheck:X-Microsoft-Antispam:
         X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
         X-MS-Exchange-AntiSpam-MessageData:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-OriginalArrivalTime:
         X-MS-Exchange-CrossTenant-FromEntityHeader:
         X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
         X-MS-Exchange-CrossTenant-UserPrincipalName:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=QU57Ks1F06vxDrgaSaUKHBBjo9xjf8ZXiAe3BW5upO4cwcihBQ68Eona0f2M5pgee
         SPAE0JruHNUr57whSRqyIryKqurkiR9k54jZlTlDdGBVJvugpI5ZJyyal6NEvbNSYu
         Gc3O3beCG/gsvUBMuKbE00rgENgw7NCwh1jDIzHcZi2YJbQARF9IEdEPmIuYEjk515
         kmkiYQ5BcqHTqKbV5RH92GQMuuAtUW3PKO4TlSxt80T5of/XBaRKNTzNwLdfJNyLNA
         LWv0rFjoxrkKoRlxdICIKO2SECHJkq+RObSNf41I7bYR6FqSY8xrkafKGuyFzO9D+d
         z5p654+r59EWg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 12:10:59PM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Mellanox and Cumulus Network were acquired by Nvidia, so change the
> maintainers emails to new domain name.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  .mailmap    |  2 ++
>  MAINTAINERS | 58 ++++++++++++++++++++++++++---------------------------
>  2 files changed, 31 insertions(+), 29 deletions(-)

Applied to for-rc, thanks

Jason

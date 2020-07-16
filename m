Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8760BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 642A1206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="QPIPnwkr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgGPI2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:28:49 -0400
Received: from mail-eopbgr70073.outbound.protection.outlook.com ([40.107.7.73]:33313
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725932AbgGPI2s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:28:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFCI/bXoa57I4VpuwfreHLQ2mx+qbJQLZvKf9D0qHbOMM1to30tW/F3XL34KdBU4geROIivapFh6w98/LmvtPICq66ITUzJB7H6H2oJjGMIjbKOiTSWlO0/wbEqtsx9YWQDoJFpw7M+Ax9sS7rZRPp1k9WODrvIOWcie3OfC3DJL1kKkIYUHf/A0nYLcEqopQn3ofK5Ou2eu7EOnVlI6w3sJbQ5fcT+PjQVP8XYY3Dp0qzwcXODisJyuT1ZkxZpaWAb8TmVOcI5AGcsY/pt/zjzWTnJEilqXADr+BtXOFPA9q4IrrrrVnsjdtKrhFhQxhRJ6qu2RFNjn7ddoB7FArw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uVPrPi4DrLNnzVVBM2zEc+++JvwjF1wh+wJTxjmqbg=;
 b=lCBxzUXp9Tf/DPrNEDyHjep4A0PnRKAZ06R8uX3HVp88Bq9ur9zBmnvkrCYG2l/JZ5C2vFxEww4FqA3XMnfMSGKdb5qr/tpfcgQWRjd31rJ82JnLmnm9rtXQ3n09LYsoCxUw5ZozzucsIu6MBWaWYgLKuq6z0cT4w+wRkm4DrffC0p1PTX+h1O6YxLTdYqC32FC3RCzTRrhbcJnB5UlpmGlPm0pjJiuVzn5wV6CSHZHVpClfqBx0Stb9Jnun6p0EVaRQ4ukKH7ZZqQebe1WK+hLfQWwyIFxmKpwECVSxq8k35icBh02LQZUg+PQrP1JMXkl8eP+AeZAZi8o8Zb/JMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uVPrPi4DrLNnzVVBM2zEc+++JvwjF1wh+wJTxjmqbg=;
 b=QPIPnwkr0CC/fUOYFQ7fulSqlcXLl3SARw/OxQHl4BlO4ulk76mJ8Vf2sg+So7C5AMWcO06dNTmmyN38HCYnL8DoRkpAIuwrJPTB8tOknvXbBx9x37paZyfhs3XArem5103FOxbEuEdpFHR2viI+zUrFK4Bk9FYvC2LEBfyDX9I=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com (2603:10a6:208:b3::15)
 by AM0PR05MB6404.eurprd05.prod.outlook.com (2603:10a6:208:141::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Thu, 16 Jul
 2020 08:28:44 +0000
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::e00a:324b:e95c:750f]) by AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::e00a:324b:e95c:750f%7]) with mapi id 15.20.3174.025; Thu, 16 Jul 2020
 08:28:44 +0000
Date:   Thu, 16 Jul 2020 11:28:40 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH vhost next 09/10] vdpa/mlx5: Add shared memory
 registration code
Message-ID: <20200716082840.GB182860@mtl-vdi-166.wap.labs.mlnx>
References: <20200716072327.5359-1-eli@mellanox.com>
 <20200716072327.5359-10-eli@mellanox.com>
 <61765932-5411-9f37-3a4a-ca5ac5daa28e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <61765932-5411-9f37-3a4a-ca5ac5daa28e@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: AM3PR07CA0054.eurprd07.prod.outlook.com
 (2603:10a6:207:4::12) To AM0PR05MB4786.eurprd05.prod.outlook.com
 (2603:10a6:208:b3::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mtl-vdi-166.wap.labs.mlnx (94.188.199.18) by AM3PR07CA0054.eurprd07.prod.outlook.com (2603:10a6:207:4::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.16 via Frontend Transport; Thu, 16 Jul 2020 08:28:43 +0000
X-Originating-IP: [94.188.199.18]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b75c0df3-4857-4244-17f3-08d8296240c5
X-MS-TrafficTypeDiagnostic: AM0PR05MB6404:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB640465D843EFAE457CA41DADC57F0@AM0PR05MB6404.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mbQtyVqaKAxvKrTMWBtKTOck0eq6zPXtd3BrDd3AL9XRvyn/EAtN/brNGoaY8T28KgnY3YnlkN8CGVVKIhBqhAq0U0N/XU2jZi18Cl1RvOcPTxKAD0/G8FsFkWV5pGYR2EAEofSqpOvMnrSOKPLs2BdIhDET76wDFmcZhKEvc9/j/4uXl/iBJeLu/EBwejK0CifZ/QjF65wD38iKTLjEb21ubSxf88+mEv4DFLnx2WaOzwOqGU8lAYmnn/J3kNQladQClP00tSdyDx9MY60Q63nSTDJtr7QbjGt0DcZLlsblA2CGN40Bh3q+XphcPsPbCksodIhGoXdIE8dSsdMFvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4786.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(107886003)(86362001)(6506007)(186003)(5660300002)(16526019)(4744005)(478600001)(55016002)(52116002)(8936002)(9686003)(7696005)(6916009)(1076003)(956004)(66556008)(66946007)(66476007)(2906002)(316002)(33656002)(26005)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Xyir1+zW7HXJP6TtTRydvm0x/DUmZ3lPa0C50xxeeZog+nyv4FZ0wZUCCoI3s9Ku1PbN02/goMUjObwiUyvHwUnO18RwPoreLCKGstoZs8CPVdU1a7F7QYX3kQfsX4nxUcq9A8UExkPr1LMumFz7sI8aWIX7Sg/lxm6Dvp78E0Iv25h4eUmXVAYSz6N+ybP3ONAGe0NaYz78IoNcXEDIB86Ol6Q07dwQgCv7iRGSTxQPm6bZT8YVQyv/L+VQAdnR75bDhRZRWETlVQ3rH6nvwhno5SfXmZIVtmtS+DJFQVJxIwv7ZPJAHcGUvyW+hCYDtNLgqCwe+ecln3H1+y43PTl9Hcmf8aE69sFt0vi3eLXoSKBi5xXwXrIVvMD8ZqduXdB3qZyLIfcGtsRimAbO+8TBzxZRPMk83ntfb2hJogtbwc/TpmfqBsUuaBlOm+titsaF6yMED7VKOAScLiS54hB6R9uDNyP3gVA5E7vBwkE=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75c0df3-4857-4244-17f3-08d8296240c5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB4786.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 08:28:44.4766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gqlj50FAuUEDzltdDsIBZl5ZhDWnbpZS7/EZnNffpxg4JBvaUYNAeJsPgGbl3MT9URRuij6xorr8+kLxduQP0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6404
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 04:13:21PM +0800, Jason Wang wrote:
> 
> On 2020/7/16 下午3:23, Eli Cohen wrote:
> >Add code to support registering guest's memory region for the device.
> 
> 
> It would be better to use "userspace" memory here since vhost-vDPA
> could be used by e.g dpdk application on the host in the future.
> 

How about replaciing "guest's memory" with "address space". It is more
general and aligns with the with the fact that virio driver can run in
the guest's kernel.

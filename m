Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F12C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82C6D2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SlbPIKkx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WmbJfu8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgD2KDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:03:32 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:39628 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726345AbgD2KDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:03:32 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 5BABE401E0;
        Wed, 29 Apr 2020 10:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1588154611; bh=wMklFKfkoXe1GVs0Rxa9f/G/aOi5b1LwPYJRxY4ZxJc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=SlbPIKkxZX5pIJttCyomrK1CkE+lW/w14hQ2zqsO47uMXzgA5mLP/Cw7ZruupcNqc
         NPoFSNx/RVSCY9IRifvpmtHfyJQtYwCF2J3WrRX+92L70meq7a7qFTwDKZHRO59MWT
         eR/720MUY/QJEbv36CVgX4npf1l6GFr2r0qTWyB3AO9G/iayf2oziRdY6IgaTW8Fzp
         f4ZUwFnUH0SIcSTwgU2KM54o+1m5CjMDSB/uXgFNAhUBDLU+MSqXcHRY1+9SCLpJ7r
         WNAB6hZdU0kgKUM50gXD0On6JESiovy3faKltbE1Su/V5bWCnceWPgJ5OI5KQUePsn
         FbFs9dctkVNwg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 01BDEA0069;
        Wed, 29 Apr 2020 10:03:28 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 29 Apr 2020 03:03:22 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Wed, 29 Apr 2020 03:03:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsrjEvqijF7lNks09jR+ICJiERTN9a1NAdR8lYUhMjWxslFVIgQ0NGCkoFidxrBSvtIhGmrSTGWxCr0PIYX3GfTtOkMmu+cY8gEEilC6JGFtjPqKfBOmkM3IorDI0UczKQhtBWqalPHFVDHcIeMldDcMSlxPsmuyJ7C2n2Wqd+V/kwvClt/8Ryv29We6r1zUX+uiAnBde1fbkzey/epAZZhKjS+bbM/IzT8EIChB9vovt3DA9VhSUiWrjWLfBoj3GgcyI1NcncjkZL6nugNaVfKDNBjs1+PYSDLsYRFQm0S+TaiB2VZ96VVqBS1w5Ra6aXi3JOa9RCGn3EctY2CXog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMklFKfkoXe1GVs0Rxa9f/G/aOi5b1LwPYJRxY4ZxJc=;
 b=Ib/URag1fTHM2zXb15Ed/3XgL79WgRMAKjBcvlSGFBg+UijL434tBOxGjjGd9DDXlOIwzI+6/Toa20l3Em0DQXURmhQhSwqqBafp87rePnL+pcd9aJjygvUR12QrgH3ilIOdgj/fJmpZqdnUNZcy2CY+J3KxPSOwUWwMbOGGdvUHNrdKxlbPXCr+twwro456rBKes5uzKm16MmAWgvWjoU0xd3nt6eB5Kbfi7JtlQzCPLh8J2E0w+sXiB2WVvE6mRa5/GIMFvujGK1qHpbZoStFMueKJrEE6HEwUv9fT3MCr1cjBtUeS/9ztoUaJ1WTraFLnTsT7Ai2i1zAYWF/MgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMklFKfkoXe1GVs0Rxa9f/G/aOi5b1LwPYJRxY4ZxJc=;
 b=WmbJfu8P6weEQqYN5Nrm2L5EOdPg1omJymReKkVL8sykZFCzL8mdLZDyUpc/AXDIpI3y8ZNvc5REx1ZXnk0LIXdnELCpSaE67Q1j6402xZQpq1Xt9EkfLqWi9MdhvP/I0GXvlupBwzWGlWdncc2MozR68yT4QJtnOUU5H/MtDp4=
Received: from CH2PR12MB3782.namprd12.prod.outlook.com (2603:10b6:610:23::28)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Wed, 29 Apr
 2020 10:03:21 +0000
Received: from CH2PR12MB3782.namprd12.prod.outlook.com
 ([fe80::c8ba:1b80:f234:e1c2]) by CH2PR12MB3782.namprd12.prod.outlook.com
 ([fe80::c8ba:1b80:f234:e1c2%2]) with mapi id 15.20.2937.023; Wed, 29 Apr 2020
 10:03:21 +0000
From:   Angelo Ribeiro <Angelo.Ribeiro@synopsys.com>
To:     Jose Abreu <Jose.Abreu@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
CC:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ARC: guard dsp early init against non ARCv2
Thread-Topic: [PATCH] ARC: guard dsp early init against non ARCv2
Thread-Index: AQHWHY4gqPzpvJC7j0qx04E/xf4m+KiPoJXQgAA+ibA=
Date:   Wed, 29 Apr 2020 10:03:21 +0000
Message-ID: <CH2PR12MB3782E5561AB98EDA1E350C02CBAD0@CH2PR12MB3782.namprd12.prod.outlook.com>
References: <20200428185024.5168-1-Eugeniy.Paltsev@synopsys.com>
 <BN8PR12MB3266393BD37EAABBF45D8AEFD3AD0@BN8PR12MB3266.namprd12.prod.outlook.com>
In-Reply-To: <BN8PR12MB3266393BD37EAABBF45D8AEFD3AD0@BN8PR12MB3266.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW5nZWxvclxh?=
 =?us-ascii?Q?cHBkYXRhXHJvYW1pbmdcMDlkODQ5YjYtMzJkMy00YTQwLTg1ZWUtNmI4NGJh?=
 =?us-ascii?Q?MjllMzViXG1zZ3NcbXNnLWE1N2E2MTk3LThhMDAtMTFlYS05ZDczLWZjNzc3?=
 =?us-ascii?Q?NGVlZGMyZVxhbWUtdGVzdFxhNTdhNjE5OS04YTAwLTExZWEtOWQ3My1mYzc3?=
 =?us-ascii?Q?NzRlZWRjMmVib2R5LnR4dCIgc3o9Ijg5OCIgdD0iMTMyMzI2MjgxOTc5MjY1?=
 =?us-ascii?Q?MTQ4IiBoPSI1ZGFiSk02YjVDUS9nRVY3NFVVVkNRWVhzVkU9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUI4?=
 =?us-ascii?Q?Z05KbkRSN1dBWktHQXZNUEpSWnZrb1lDOHc4bEZtOE9BQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFDa0NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQUhhV3lOQUFBQUFBQUFBQUFBQUFBQUo0QUFBQm1BR2tBYmdC?=
 =?us-ascii?Q?aEFHNEFZd0JsQUY4QWNBQnNBR0VBYmdCdUFHa0FiZ0JuQUY4QWR3QmhBSFFB?=
 =?us-ascii?Q?WlFCeUFHMEFZUUJ5QUdzQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FYd0J3?=
 =?us-ascii?Q?QUdFQWNnQjBBRzRBWlFCeUFITUFYd0JuQUdZQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFaZ0J2QUhVQWJnQmtBSElBZVFCZkFIQUFZUUJ5QUhRQWJnQmxB?=
 =?us-ascii?Q?SElBY3dCZkFITUFZUUJ0QUhNQWRRQnVBR2NBWHdCakFHOEFiZ0JtQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCbUFHOEFk?=
 =?us-ascii?Q?UUJ1QUdRQWNnQjVBRjhBY0FCaEFISUFkQUJ1QUdVQWNnQnpBRjhBY3dCaEFH?=
 =?us-ascii?Q?MEFjd0IxQUc0QVp3QmZBSElBWlFCekFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhrQVh3?=
 =?us-ascii?Q?QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3QnpBRzBBYVFCakFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVpnQnZBSFVBYmdCa0FISUFlUUJmQUhBQVlRQnlBSFFBYmdC?=
 =?us-ascii?Q?bEFISUFjd0JmQUhNQWRBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJtQUc4?=
 =?us-ascii?Q?QWRRQnVBR1FBY2dCNUFGOEFjQUJoQUhJQWRBQnVBR1VBY2dCekFGOEFkQUJ6?=
 =?us-ascii?Q?QUcwQVl3QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtB?=
 =?us-ascii?Q?WHdCd0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCMUFHMEFZd0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBWndCMEFITUFYd0J3QUhJQWJ3QmtBSFVBWXdCMEFGOEFk?=
 =?us-ascii?Q?QUJ5QUdFQWFRQnVBR2tBYmdCbkFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQnpB?=
 =?us-ascii?Q?R0VBYkFCbEFITUFYd0JoQUdNQVl3QnZBSFVBYmdCMEFGOEFjQUJzQUdFQWJn?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUhNQVlRQnNBR1VBY3dCZkFI?=
 =?us-ascii?Q?RUFkUUJ2QUhRQVpRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFB?=
 =?us-ascii?Q?QUNBQUFBQUFDZUFBQUFjd0J1QUhBQWN3QmZBR3dBYVFCakFHVUFiZ0J6QUdV?=
 =?us-ascii?Q?QVh3QjBBR1VBY2dCdEFGOEFNUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFC?=
 =?us-ascii?Q?ekFHNEFjQUJ6QUY4QWJBQnBBR01BWlFCdUFITUFaUUJmQUhRQVpRQnlBRzBB?=
 =?us-ascii?Q?WHdCekFIUUFkUUJrQUdVQWJnQjBBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBSFlBWndCZkFHc0FaUUI1?=
 =?us-ascii?Q?QUhjQWJ3QnlBR1FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFB?=
 =?us-ascii?Q?QUFBQ0FBQUFBQUE9Ii8+PC9tZXRhPg=3D=3D?=
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [95.136.124.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f295fcdf-64b2-42ec-8b9d-08d7ec248c5d
x-ms-traffictypediagnostic: CH2PR12MB4070:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB407078AF58300DC04E9ADDDFCBAD0@CH2PR12MB4070.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03883BD916
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3782.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(366004)(396003)(136003)(346002)(8936002)(55016002)(186003)(110136005)(5660300002)(7696005)(4326008)(66946007)(66556008)(64756008)(66476007)(33656002)(66446008)(76116006)(26005)(6636002)(316002)(71200400001)(8676002)(2906002)(86362001)(54906003)(9686003)(6506007)(478600001)(4744005)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 27WuWiOWycZLd6hi8PpnEc5IMA030t7qBrcsYa3nnMX0Tt7VfgGOJqH8t2MHS5xUR+/83IzcZSF3gKsXGXKMA592Rwbqv7jxyuLztQfrdrpk4VySp3GsZnz/a7dWPtQlqEJdtWjp9AYRZAWniK2OjmpE0N0PkkTqje6al7UdY6Zn3qv/tt4X0yU7xwFdiDWOcD7jPtVNJsKEtdTM05iVJEKgoyStL8PX5R+EaVVasSrBOrDHjC9gbTpLSQm9bOlUyqWJX9TGp5WBALHM+x9EJW5oR0YyppQ47AtmkXl42J3AmA6MDWuHzAiwV9xj8NzwMie/O0Ln3l0J8ZvDU/ahkmKifFaTfaRIOq0CZEjp+/0p0rFHYneoqO6/XepcjtA5nPptCqWNEzfFVJrAlXekp2/AE9f7UeDVklNyCVXxgJh9V7LrHAn4xtcUNFdHnC09
x-ms-exchange-antispam-messagedata: TptUjgkGcidY7GJvZZBLOeYkSzRuJGHi0McpUFsy7RNM1U2tRPY3dQjIrhlq4rc3R14+6HqfegBrCi/kF5BnUAsYV6gL9x83TjRMv4X2jW90mKupv3a3V+mOc7Ptc2GNgyA9/+2yBoLt+qUoPRRscBbRbUE8wVNloHfGIwbenu9ATvhAJLtz08es+nIgWY7vIPJWAQbdVeUDbFHT4OLpar8a94xttoSbLRQrU8zEGqYEk/TxOfJgFqWZsZpuop+5HuDI2pqOnqTxlqZVZehPfZjNUuyrdgdbMPSMtgsejF+hRHOizpSvXBAu2bbEe6rmGVyE4cCDzIAHolYfoOyjiLjqdl9itV0bk7SsTBO5jTfh5Dv8lzLXWK5x+X2Y3l9ltEjoIf1RFN/hXfLLsNA0kuPPHrIb1/bVlkaczJftUp7vNhhnQEQy7gwWm1cruswY8mDeWJ2q5ZspTe15SEsIPUQbQH5y0yRnbM5Hli91iwXzKVhdizkTQEOySqnXKmgDjgaeo6kh1HWcouPoESkhM8sZK12oGNR58817mp20pypcaJfCg6FHSruto/3u12QX2vzcbdc654BF+Oubv6rykFXOfVm0Ok4E9DYOiB3iQT7XCrecH3WpWe3Izql+mhJCDD2V5ZxF9quzIiZNmC9JqO0N0QF5yMJZzcArBJbDoA28dxP+W4bD2B3H8opb9dospjh48uu1XdIXLZmqypDBxkd5QK5fuKdt/KZggGFRcpou7I6BGTTHWms829LVxiWpHPtqyapyT3mBFV5wogoySrs2CJjv5jCYIfNo7qv/Aas=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f295fcdf-64b2-42ec-8b9d-08d7ec248c5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2020 10:03:21.2963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DrmCrgtbycvyS9PUD5FA8dsnFf5I6Ss3UHI7P5L4lsIPxavFK3eJSOgpZDl2vPH4AEvG5B8EZXTdHrKtojuBSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugeniy,

Tested okay on a ARCv1.

Thanks
Angelo

Tested-by: Angelo Ribeiro <angelo.ribeiro@synopsys.com>

From: Jose Abreu <joabreu@synopsys.com>
Date: Wed, Apr 29, 2020 at 07:19:55

> From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> Date: Apr/28/2020, 19:50:24 (UTC+00:00)
>=20
> > As of today we guard early DSP init code with
> > ARC_AUX_DSP_BUILD (0x7A) BCR check to verify that we have
> > CPU with DSP configured. However that's not enough as in
> > ARCv1 CPU the same BCR (0x7A) is used for checking MUL/MAC
> > instructions presence.
> >=20
> > So, let's guard DSP early init against non ARCv2.
> >=20
> > Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
>=20
> Reported-by: Angelo Ribeiro=20
> <angelor@synopsys.com>
>=20
> ---
> Thanks,
> Jose Miguel Abreu



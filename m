Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE5EC34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA62B20718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EMweNETH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="fExKCes/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgBQPdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:33:01 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:50276 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727300AbgBQPdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:33:01 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4863340511;
        Mon, 17 Feb 2020 15:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1581953580; bh=JpUNJy/BWVpSOlN0lgkrOmNoJOZpTgTU7xekSlXQgv0=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=EMweNETHurtvV5NswFxgq7KqiegmyEqbdIWw+b93mK37kf8j+0582mYQa8u5oovZt
         ZQorJ+s402fXYV5qsnMlB81fju0e6A4V9733Minct7FG5VkXCwLTgrSi/loW87Ibdx
         TfE1KT8wLQCSNrsd4f8/9HlAEHiFLXSNO7SSqp7Xz/wi9ajiqAa07FhGm/Ao1W4OC6
         GN6oE1i3Z/P6UGW/YFnxGlOYfiZFK/cp5L8YRVMxRKLM//XaEkU9ND+WWAnlfvuLxa
         1rR+WQlkQOQEYoR5RNV0PQnpOGs3oOQNuOhZfBYLgM3ScLVb0s9tcQ0v7HhuqxZ1nu
         EOZL7X+i8sM2A==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id A93BEA006A;
        Mon, 17 Feb 2020 15:32:57 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 17 Feb 2020 07:32:56 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 17 Feb 2020 07:32:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CjX6whgadGJO6PluF3vFFBlCdsjA37rNIM0Ovxgpad8v0dzfYc613qXhF/pKbc1w3BrvS6VtRHcLCJMIOVAD+aw1b+JigUk25XlStbqvvfnNgbpXVURxU0J/BiIlUeXz+CTGrd903o99I/80oWuWcjFZLo6RTBsKObi99ib9tHFlsa9w4t5voVzjeQgdfcbW9pV/cKDc8IocaujDmNeKdLIkjR62DFN2yOPDoJbX+yTriKoLm+3fgL0W2/NMCgr8/kevvUJjw2fCkb6OGyUQysE76j8wXAX/qOBR/WAJwgnojbhlh0IaDedvGwEZgNZUHLaWTje04bhKwXbBXyV+bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poCJXRF+9SGVJLlmMRni8R060M9eIKKhlg3kb6BjCoM=;
 b=QJygOVxWDyuLlLGKiBxj6DSYrPW3qdjSx0iSU3yfWhTg0yW9u3ERi5fn25iJSTTb2t3gIqdSpU1KP4MY/5h38cwjhasihictwKSsuS8cJ5yjTZvtrPZj4ahK2OnUZOYrR55wNUOUTKmd11LkZ4BulXqrStOFvkK8yzqxEwv9sBsWJ2zfPKx+3/Jjtx+BW7FI1QFcVbbT12fZWPpqQVuPq+nlSZ7dwaMDnKGLIRHlmM6qL+N5XFpBcv6mA25Al17I/PR8p4SRHYRPHsaIPbcwTk4jl6Jx0Lcj+BegnRmGUtFKOXzdmWHFqJP4RuzcS/UYQv9q9S9PoW6RdicQPC6toA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=poCJXRF+9SGVJLlmMRni8R060M9eIKKhlg3kb6BjCoM=;
 b=fExKCes/R95/DBGAXt3MIGcTzql79vqqeCrXcBs3U2ko0dihEEP5QWvkLXfKdSr33QiCzP2x1snGHUD5BkA8SSxC848ANwH1/ZjU4W4FtN60OF8A/8cX65SrhrHq63rUhSgEyePlYX68YgnkkMgvsSUP/7wtAl0nHtgYTX4RuHA=
Received: from CH2PR12MB4216.namprd12.prod.outlook.com (20.180.6.151) by
 CH2PR12MB3813.namprd12.prod.outlook.com (52.132.246.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Mon, 17 Feb 2020 15:32:55 +0000
Received: from CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::c8d1:bea7:c855:bcfe]) by CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::c8d1:bea7:c855:bcfe%5]) with mapi id 15.20.2729.032; Mon, 17 Feb 2020
 15:32:55 +0000
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "wsa@the-dreams.de" <wsa@the-dreams.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: RE: [RFC v2 0/4] Introduce i3c device userspace interface
Thread-Topic: [RFC v2 0/4] Introduce i3c device userspace interface
Thread-Index: AQHV1p4wiafUt0giokeVAyQbyadp7qgflkqAgAABWkA=
Date:   Mon, 17 Feb 2020 15:32:55 +0000
Message-ID: <CH2PR12MB4216459E37F9AB1AAF0B2EFDAE160@CH2PR12MB4216.namprd12.prod.outlook.com>
References: <cover.1580299067.git.vitor.soares@synopsys.com>
 <20200217155141.08e87b3f@collabora.com>
In-Reply-To: <20200217155141.08e87b3f@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctYzI3NWU1MTktNTE5YS0xMWVhLTgyOGQtYjgwOGNm?=
 =?us-ascii?Q?NTlkN2ZjXGFtZS10ZXN0XGMyNzVlNTFhLTUxOWEtMTFlYS04MjhkLWI4MDhj?=
 =?us-ascii?Q?ZjU5ZDdmY2JvZHkudHh0IiBzej0iMTgzMSIgdD0iMTMyMjY0MjcxNzM1MDcy?=
 =?us-ascii?Q?NDc1IiBoPSJmTU5GVVI5Ukl5T2wxWjVlY2l4WDkvZkZMV2s9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQURi?=
 =?us-ascii?Q?cGo2RnArWFZBZWR1eWdGM3pJUHY1MjdLQVhmTWcrOE9BQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFDa0NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQXNQcFJHUUFBQUFBQUFBQUFBQUFBQUo0QUFBQm1BR2tBYmdC?=
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
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=soares@synopsys.com; 
x-originating-ip: [83.174.63.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9189184f-58d5-48e0-435f-08d7b3bea8d7
x-ms-traffictypediagnostic: CH2PR12MB3813:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3813C838C1FD3301AD4222F5AE160@CH2PR12MB3813.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0316567485
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(396003)(136003)(39860400002)(189003)(199004)(478600001)(52536014)(6916009)(71200400001)(7696005)(5660300002)(81166006)(316002)(33656002)(81156014)(8936002)(8676002)(6506007)(186003)(9686003)(4326008)(66946007)(66446008)(66556008)(66476007)(64756008)(76116006)(2906002)(86362001)(54906003)(55016002)(26005)(42413003);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR12MB3813;H:CH2PR12MB4216.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4jxK60/hj7I/WcYrDHym8Xz4vHF3lH7p92akskSRtpn7JFtnnuvkTxkJwq3CBf5nIBjFQfkP8VUoCwWx2GO2KwnbB3/5+/KyFqY+G2vDI8XIChXj04Jmltx3C2Q1OwGpDTyP6a3HYVeIbV4+o2NIJiPtw3pPb0FsxN0G4m0P/QA0ml8y8EygiJ9lKIEGl5zuDv23JxK3wtsEf2v900gpFoFvgQx+5D+ZLCqYgnntEK7rZh8mNXzGZXsARLNhq0jkmc4aEWH7cDZT7n1f92DE2Oe7SeYK1rZdJyrcD/+vjtEF6drL6glcdoC/HILtmcppgqfedrW6NOxQiu+27fiilX7+TdIKsZ/Nfi2/5nP3mDSodW3XsLbHVkdowCodwO4uwkTb80+OTs3xY9m46zTZNhCth9f2lLXvqw8EhaKHMobTDrunLAyhpDPZVErM6pdt1PFjOEjwf8siUcyPovx8lH/GfUjY9W0as1eOY5Tp6CDP1T9MMjTLSDZhrephi5vU
x-ms-exchange-antispam-messagedata: ErIPLFWgbWxr3NwyUTnRij1RhA7EqtRd9hVaWwcPVwB+eHCh5ghvYMlR4ctAvBVNbyR9s5JRZDUbXQwmlhl4W+RAO8gghrXMYeMB9XwmIER3/41h+kihmuthjbbZk5pBxeFGtb9tLRQ5xSl5DEULgw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9189184f-58d5-48e0-435f-08d7b3bea8d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2020 15:32:55.2429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PfOGNLmzncySuwTpbE3TpxyyUbBGCmXo8cON6jmdbKZptseAPJbATxhiXV9dj4sxTXKRASEMKo1BRJA4euGkUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3813
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Mon, Feb 17, 2020 at 14:51:41

> Hello Vitor,
>=20
> Sorry for taking so long to reply, and thanks for working on that topic.
>=20
> On Wed, 29 Jan 2020 13:17:31 +0100
> Vitor Soares <Vitor.Soares@synopsys.com> wrote:
>=20
> > For today there is no way to use i3c devices from user space and
> > the introduction of such API will help developers during the i3c device
> > or i3c host controllers development.
> >=20
> > The i3cdev module is highly based on i2c-dev and yet I tried to address
> > the concerns raised in [1].
> >=20
> > NOTES:
> > - The i3cdev dynamically request an unused major number.
> >=20
> > - The i3c devices are dynamically exposed/removed from dev/ folder base=
d
> >   on if they have a device driver bound to it.
>=20
> May I ask why you need to automatically bind devices to the i3cdev
> driver when they don't have a driver matching the device id
> loaded/compiled-in? If we get the i3c subsystem to generate proper
> uevents we should be able to load the i3cdev module and bind the device
> to this driver using a udev rule.

My idea was to expose every device to user-space by default so we can=20
test them without a driver (more or less the i2c use case) but as we=20
agreed during the i3c subsystem only expose devices that doesn't have=20
device driver.
I considered to have a uevent but to expose the devices by default it=20
would required something generic, what I didn't figure out and tend to=20
follow the i2c-dev module.

With this current approach even if a device has a driver we can unbind it=20
through the Sysfs and have access from user space which I found useful=20
for debug.

>=20
> Regards,
>=20
> Boris



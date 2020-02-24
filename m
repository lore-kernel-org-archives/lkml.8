Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10AADC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C52002080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HFJb2R5F";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="EkgDdgr8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727275AbgBXKxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 05:53:41 -0500
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:36026 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726216AbgBXKxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:53:41 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2C03E403FF;
        Mon, 24 Feb 2020 10:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1582541620; bh=A/SKchR19AwnNcUwaSmdBehJ7yjOvu22J6MWeHmGxEs=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=HFJb2R5FKMZ6vLfAYPD4Zd1VDQNIhBoMZnrmYuJeFKyktFjqluKfAUNiUnDAnYn7n
         8tLcCNNsPy26u8hxWaL4Wf5WsexrXmiz1GoGYynjOqfjA45v5CLd7Rd+S7WLKF+0m8
         Rbxy19D8NuJKdc6agqpvQWi3hqyPG1QElc5vTJCZfJdijXh8I6TQLPMa/QXHtrGcVT
         QZKQ8MkA1067iiFNdgXCYe9nzGcKiMnOY7GMBx8X6fnYZsbfy125GQkHNLT9PH9uf9
         8vB3nyznSpE8Z0Vpjf1i/gQx0JDwQHrZOS2W+PMyPJq9Aemt0cvC3ofdlYO7x/6PbG
         OwHIqBsTteH2g==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 2707CA0086;
        Mon, 24 Feb 2020 10:53:26 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 24 Feb 2020 02:53:26 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 24 Feb 2020 02:53:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTCq25bvyop/iJg7HG+xjalYW25YXNvysOXD4RqMzVgu604RAxf4tFGhTftT39qQUqULQ+AWsf10HnRiwgwu/ocIBrZmdkDLa53MjPTIz4lsBHxKMpbpwVG0ZMi8pTk0SwKm33CnVlrdZJgOWI1aMT3ZuOUnxDR6OuuNy9dh13XzzbeSMuKTRbY+d3uWZrAXXvCFF9R1p30IHl8M/uIf2yCGHjyaAu4uDtMFJqS9+271lYGOcRYU7EiY9l6INRO091EGND4nHpDq3GkD5a8u0K9nuZ4dnHgXYUa02hf5vAhHVGec/RiqlOXQ4XsNBtgY3u6Oigl3gptU4TsiDEQ0Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWGYbWv2vl50f1ILEatzgd71T+qYFAMRgClL7IPF4Lg=;
 b=OTNUdfTpfc0rLMGRS5s8AJID38/fH13kn3sY2TYpAxnfZ3C4MMBLmAg8ak3tb02wXya/yG2g0j+Xzd+0cNa7gRqB8QJ3UHfHfCXxskc63iLfw6O0C4Vtjn0vlrVX0JsnYg4/aasFXQxnQPb38kupadcpx3Xq9yqQSn6oANxTI4skEtAOurjEpqbZXgko10hZ0g1ZdP6hjwFY+qGO1EyYZn/Xv705QWR/eh6wjuMI6zNWKqD4Wbr/sFBTOO0xQQZKPUZQPIQ5FBA+7DCqw732FChSZYyACnaaRAhV8pJg02hiyolciNZFJm0F0gnFf3mn9JDSVGPLmI+ypODR8YBuvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWGYbWv2vl50f1ILEatzgd71T+qYFAMRgClL7IPF4Lg=;
 b=EkgDdgr86uYTfURugg07yXqfyUoXHoatAwq1qrNsbaWoc/sma7s1hxhJFfWhekRlQ9k5ZeLGNYR74qdoaj7FRWIOGhkIj1ggeJgQUen7G8VI0Ha5g3FA/HIrGGsH1WA3tjVXxkwfks99AfC5mMKRQs3Pvoj3dljmAvHUFHx+gY0=
Received: from CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23)
 by CH2PR12MB3734.namprd12.prod.outlook.com (2603:10b6:610:2a::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Mon, 24 Feb
 2020 10:53:25 +0000
Received: from CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::c8d1:bea7:c855:bcfe]) by CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::c8d1:bea7:c855:bcfe%5]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 10:53:25 +0000
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "wsa@the-dreams.de" <wsa@the-dreams.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>
Subject: RE: [PATCH v3 0/5] Introduce i3c device userspace interface
Thread-Topic: [PATCH v3 0/5] Introduce i3c device userspace interface
Thread-Index: AQHV5rqI90LrTPLnik2TPIdRwWN8OaghqdAQgACCowCAA55iQIAAI/EAgARAQmA=
Date:   Mon, 24 Feb 2020 10:53:25 +0000
Message-ID: <CH2PR12MB4216F86F6820CC5247B89BA8AEEC0@CH2PR12MB4216.namprd12.prod.outlook.com>
References: <cover.1582069402.git.vitor.soares@synopsys.com>
        <CH2PR12MB421604E9272413A6C456AB16AE100@CH2PR12MB4216.namprd12.prod.outlook.com>
        <20200219091658.7506e7bd@collabora.com>
        <CH2PR12MB4216ECDC745C8255DF8106A3AE120@CH2PR12MB4216.namprd12.prod.outlook.com>
 <20200221184116.1d8f0677@collabora.com>
In-Reply-To: <20200221184116.1d8f0677@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctZGVkOTViYzItNTZmMy0xMWVhLTgyOTEtYjgwOGNm?=
 =?us-ascii?Q?NTlkN2ZjXGFtZS10ZXN0XGRlZDk1YmMzLTU2ZjMtMTFlYS04MjkxLWI4MDhj?=
 =?us-ascii?Q?ZjU5ZDdmY2JvZHkudHh0IiBzej0iMjE0NCIgdD0iMTMyMjcwMTUyMDI1MTIx?=
 =?us-ascii?Q?NDM0IiBoPSJKVUZoVkE2U0tXUFl0aWFzM1pIc0pUWG5QKzQ9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUNh?=
 =?us-ascii?Q?SXRpaEFPdlZBWHFGYWhKcVVjaVZlb1ZxRW1wUnlKVU9BQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 5baf8db3-9208-4e80-cedf-08d7b917c611
x-ms-traffictypediagnostic: CH2PR12MB3734:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB3734A37BC98FCFE526A5EFDBAEEC0@CH2PR12MB3734.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(396003)(39850400004)(136003)(199004)(189003)(478600001)(6916009)(4326008)(81166006)(316002)(81156014)(54906003)(8676002)(8936002)(71200400001)(7696005)(55016002)(86362001)(52536014)(6506007)(5660300002)(26005)(186003)(66946007)(76116006)(2906002)(9686003)(33656002)(64756008)(66556008)(66476007)(66446008)(42413003);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR12MB3734;H:CH2PR12MB4216.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vJzjONwMrfdfLGBVJ5//zu0yV6ljATfOg16ID90CqtN4XtOoUc+3ekXYFXOauTbxo3klsTwj0Lc1t2wDtnXH9fNiMe/UyUbnGTxanRqFJ4JdSl9QaScJmjdrRhclvOm+snzyhQCHoF5DmnapPZV5vje5P2rMxjFXKQ5rNV8LOlhAKwdek6mwYHUW4OmuNGdu8I3rW6P3h/eLUqxU4Ps7I0YWQQiIeGCBIATWpFWTDVhbyeDjq+KVFmTy/XqKtufkFKnNFYMK28vNbAsZDZBYy/s9RuUG86bGvYVIuuUPHNzbJ5xTo74DXrivA2J8I5e2zF2cuXUN60FYyO4P4jzLg7Hk+86jP0yMv8yQUxHSnSTEGYV4GfAQTAOoriQ0EPD6szDPsh0iU6Yw9LCUillmOwxFTNCSilaWamc45+CijQTNBhBwKILFBAr7k1mRD21C193rpmHBJ7pB732lNJsafHWpbUV12eZ3RP2D82K+1l9xsXBHJJeMIY3Y5XU4q/jT
x-ms-exchange-antispam-messagedata: rnJL6pKWWUnTHnqgsojhQApMQUHfo/YUqRCqrhSzBwpBnJDgtK/MM+jN300Y1uQjDELJDSdhi6pov8ls4/8E0tScbzVIfK8nUGNgwJV9Y9peL7Bkbo+1P9vu3tbh0b4+JjyqznD+BCNL7r3H3twXTA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5baf8db3-9208-4e80-cedf-08d7b917c611
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 10:53:25.2735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 59P9CTTsprVWNRH/0u0xlB3ZpnRnuowEmG0m7XITSU++T2FDZKF7gVM1i3VSfu7+4hBhlXg5ccI8/5CjwhFa6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3734
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Fri, Feb 21, 2020 at 17:41:16

> > > >=20
> > > > I want to make you know that none of your previous comments was ign=
ored=20
> > > > and  I would like to start the discussion from this point. =20
> > >=20
> > > Sure, np. I'll probably wait for a v4 exploring the option I proposed
> > > then. =20
> >=20
> > I would like to check with you:
> >   - How can we prioritize the device driver over the i3cdev driver if t=
he=20
> > driver is loaded after i3cdev? Currently, this is done automatically=20
> > without any command, and for me, this is a requirement.
>=20
> No devs would be bound to the i3cdev driver by default, it would have
> to be done explicitly through a sysfs knob. Which makes me realize
> we can't use the generic bind knob since it doesn't let the subsystem
> know that it's a manual bind. I thought there was a way to distinguish
> between manual and auto-bind.
>=20
> >   - For the ioctl command structure, there is no rule about the way I d=
id=20
> > or what you proposed, both are currently used in the kernel. For me it =
is=20
> > one more structure to deal with, can you point the advantages of your=20
> > purpose?
>=20
> I don't have a strong opinion on that one, though I find it a bit
> easier to follow when the number of xfers is encoded in a separate
> struct rather than extracted from the data size passed through the cmd
> argument.

I will change it then. Do you have any suggestion for the naming to keep=20
it short?

>=20
> >   - Regarding the ioctl codes, I tried to use those after I2C.
>=20
> Why start from 0x30? It doesn't make sense to me. Just because you base
> your code on something that already exists doesn't mean you have to
> copy all of it.

I might be wrong but last I2C command is 0x20 and I tried to let some=20
free space in case they need.
Also I think that make sense I2C and I3C share the same 'magic number'.

BTW, in ioctl-numbers documentation there is no reference for code 0x07.

Best regards,
Vitor Soares

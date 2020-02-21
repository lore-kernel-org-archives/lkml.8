Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EEEC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7773620722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="SizZYtLp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="AAHZvz05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgBURI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 12:08:27 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:56264 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725957AbgBURI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:08:26 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EBC4DC0AC9;
        Fri, 21 Feb 2020 17:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1582304905; bh=t57XcAFXFwf12iWN2YPHqXwza58MTGrzdL/YRoyrOCA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=SizZYtLpdUSwd20sbyHOe9x4Eu0R8JOM43tM3LtTEM/Z28PMPetqf2YbZolCrjMey
         oGHHObsq7pzhJC/90doDI0877id7uQjHMksKggjGUhm9f3Tpi2R891bllomehZVo+C
         1Qw550TZK3UZ7g2ARQ1BgUKIhMVJoHYphmhqNvsoy+Ha5JWl5iP5q3ui77nU31sAar
         HZRGddpEiknvOE3V/kcrknrK40j/UbsNAnHNHrG1Iua73zlW/fOk3vtewWiYwWY2eg
         +W4lt5sC4DJ+QfZ7r46u6YtwL8AJPRA10lSf5mp3dYlAKXXXy61v88x7lZK3qCPKfQ
         EKMJTS2lZKEhg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id ABE7FA0069;
        Fri, 21 Feb 2020 17:08:23 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 21 Feb 2020 09:08:19 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 21 Feb 2020 09:08:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDVXXKY6N/JKpw/q/otsNQsZBhgKega8eVMGjoS75pcQK6h2tpNz38AA5z0q5/pWGcV33DcKCafY1rAaJt/3MP+UdHAqPh2/0MKIQ92j2vzim6i83nUQNW4CyVfLSoXnkDv2RG7HlxYqo66YUVUO+MYIMbv0NaRqyvhZ3Usiz+ulUbwpEnRih53tw+/Lk27FiqnTJPr7+tOltAu9AYJccMMx3d0ZS6rY/QKouNlTfztc6ZE5aJ2yWosawrEIo+64Aar0f8YMN6dHCwt/H/oFd2sbZWifYVHdk5RYuLU/hpuFGsCPe+Uc4s+jc64Yyrt7IdQZvCgwczvZorIIgpGdZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJ1Lh8t7msuHLMKjDHtyw5YWEjkaF+uz8oOwUf/Syv8=;
 b=Zus6iAFImqNS0DnfV7FP10+hWRuGTXndlsLttiyUEthGW8/qVPXkp1szmtmJHERuXz+sVogVpnXOY/UiIhLMn3+LVTYk6O+u5R4ZIYjHvP7dkuVpK4xfWHa+iUIIKqqp0VBW8CoriifGoRdGR3zkT8+LC8EE8WI2tXcg0hBz0IzCtgvNqfKnlZHfqZKZWv6gQ5L1eJeU7s6zZ9i+lqBdpxq7EE3A8ysE3uz3D7oH235ZXAuNComW2iifgEF9HKHCZiSYCO8FVSvAjrK31epG9OHy7eRMeMJ3WLkUREzzIMKU0MBjhajer6ARQN8ds/EmUlnCqvajYNCvkZvVqyEYdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJ1Lh8t7msuHLMKjDHtyw5YWEjkaF+uz8oOwUf/Syv8=;
 b=AAHZvz05L++2PlSPNeYW5p8ITFj11mMj5Y9A0JkZD5L3AuQ9IU6KPcC365yp1iUgFypf3leYm8IYI50jaHykF35t+3IcXrNIjvxgqNhAaRmL7Y1dHk3MHJJTv1TQjL/g8/28rXBFEfq6I0Y0rhjfbawyGp5lKnX9aSCSw7PJlio=
Received: from CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25; Fri, 21 Feb
 2020 17:08:17 +0000
Received: from CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::c8d1:bea7:c855:bcfe]) by CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::c8d1:bea7:c855:bcfe%5]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 17:08:17 +0000
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
Thread-Index: AQHV5rqI90LrTPLnik2TPIdRwWN8OaghqdAQgACCowCAA55iQA==
Date:   Fri, 21 Feb 2020 17:08:17 +0000
Message-ID: <CH2PR12MB4216ECDC745C8255DF8106A3AE120@CH2PR12MB4216.namprd12.prod.outlook.com>
References: <cover.1582069402.git.vitor.soares@synopsys.com>
        <CH2PR12MB421604E9272413A6C456AB16AE100@CH2PR12MB4216.namprd12.prod.outlook.com>
 <20200219091658.7506e7bd@collabora.com>
In-Reply-To: <20200219091658.7506e7bd@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctYmQ4MTIyNWUtNTRjYy0xMWVhLTgyOGUtYjgwOGNm?=
 =?us-ascii?Q?NTlkN2ZjXGFtZS10ZXN0XGJkODEyMjVmLTU0Y2MtMTFlYS04MjhlLWI4MDhj?=
 =?us-ascii?Q?ZjU5ZDdmY2JvZHkudHh0IiBzej0iNTEzNCIgdD0iMTMyMjY3Nzg0OTQ3NjU5?=
 =?us-ascii?Q?MzI0IiBoPSJnbTBDZ1QyQ2JObTAwZFkxNUNVNFR2MjBlUEk9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUE4?=
 =?us-ascii?Q?Y2dpQjJlalZBWWkzNE1jRUJkbGlpTGZneHdRRjJXSU9BQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 1af7a4d0-dd44-4acc-0876-08d7b6f0a4ee
x-ms-traffictypediagnostic: CH2PR12MB4296:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB4296352341BB383BE38AF654AE120@CH2PR12MB4296.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(9686003)(6916009)(8936002)(81166006)(55016002)(8676002)(81156014)(5660300002)(2906002)(4326008)(33656002)(52536014)(54906003)(6506007)(66946007)(7696005)(64756008)(71200400001)(966005)(66556008)(66476007)(86362001)(66446008)(26005)(76116006)(316002)(478600001)(186003)(42413003);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR12MB4296;H:CH2PR12MB4216.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ELPSm1JkvNo8UT1FP0yGXrCFpv0D+smNZfsfGNdrQwjhjaCWURSJ/gmVGW/Edpr6+VZBk1YNivKpAGzmOp9eOxOGCYlAm7BXB/3VGxc5C4x9NdDWJ9GPFM6ygDRfdnzSpMNsM5ln9R+tVbyNHTfgjSwKtPMrdqmsoK3Bz3n03AuveOMg3UuP0F3MskMUJScTm6Cigu4fICnoGG50PGNzbMk3hU/gILLtzNO+AGZVJ/1Uz20WLixzJZM4PvAlG69dZPtY+RLWKXVTrq4DXEz7LTnRr/KirYjg0lXLgCv4DP+ilUvMlBGNIJijs5J1gQJzVMDB/agpr0J0yz50WXU1UxXwW+7Cvw+SsyxKTWADmAG4velk8HLuuFCMg3NKvfacno0xKOa6dKrtql3Ao0QooYRt9mMutF/hlNVv4g8bvNp/lHuC+YTEGjj9mPz2tTddsnXYACXdSERjCp909NS/mfkHxEDV/TMvIAv0KYZwTTNQEI5kNNqkvp6TPXgNkfPWWBpQFILYzblA4vdna+I4uHikGHS3A3lVR6u0zv3TwJGwCnq5aHd7J1xg+N5n0lk4
x-ms-exchange-antispam-messagedata: wCgofDuiaBDR97dslORI4uJf1Ffoub6ta+upLO5BQH9cPjj006I+JpQTchDGS/6RVlmrWm5I7nBm9xa/zGYiv7vpt+dg6ynJLM+dzJkIbx/6mqaKqy6lKEt6/HJbWf3jLvCq+Mc1u5GdhL+CWM3fuQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af7a4d0-dd44-4acc-0876-08d7b6f0a4ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 17:08:17.0200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GjpJZTIQ341jrPcIIsfBq8NA3/yPN+h4t6+JbiYl0Q/TQXpB9qMcAdO0V75dTNNVdlyw5jqfpsj5G/GYDQXW1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Wed, Feb 19, 2020 at 08:16:58

> On Wed, 19 Feb 2020 00:39:31 +0000
> Vitor Soares <Vitor.Soares@synopsys.com> wrote:
>=20
> > Hi Boris,
> >=20
> > From: Vitor Soares <vitor.soares@synopsys.com>
> > Date: Wed, Feb 19, 2020 at 00:20:38
> >=20
> > > For today there is no way to use i3c devices from user space and
> > > the introduction of such API will help developers during the i3c devi=
ce
> > > or i3c host controllers development.
> > >=20
> > > The i3cdev module is highly based on i2c-dev and yet I tried to addre=
ss
> > > the concerns raised in [1].
> > >=20
> > > NOTES:
> > > - The i3cdev dynamically request an unused major number.
> > >=20
> > > - The i3c devices are dynamically exposed/removed from dev/ folder ba=
sed
> > >   on if they have a device driver bound to it.
> > >=20
> > > - For now, the module exposes i3c devices without device driver on
> > >   dev/bus/i3c/<bus>-<pid>
> > >=20
> > > - As in the i2c subsystem, here it is exposed the i3c_priv_xfer to
> > >   userspace. I tried to use a dedicated structure as in spidev but I =
don't
> > >   see any obvious advantage.
> > >=20
> > > - Since the i3c API only exposes i3c_priv_xfer to devices, for now, t=
he
> > >   module just makes use of one ioctl(). This can change in the future=
 with
> > >   the introduction hdr commands or by the need of exposing some CCC
> > >   commands to the device API (private contract between master-slave).
> > >   Regarding the i3c device info, some information is already availabl=
e
> > >   through sysfs. We can add more device attributes to expose more
> > >   information or add a dedicated ioctl() request for that purpose or =
both.
> > >=20
> > > - Similar to i2c, I have also created a tool that you can find in [2]
> > >   for testing purposes. If you have some time available I would appre=
ciate
> > >   your feedback about it as well.
> > >=20
> > > [1] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lkml.org_l=
kml_2018_11_15_853&d=3DDwICAg&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3DqVuU64u9x77Y0K=
d0PhDK_lpxFgg6PK9PateHwjb_DY0&m=3D1N2OHEqhXNvZn7HIjf_EmPX5N9wwBWLsUakJ9a1zn=
o0&s=3DRJ3Lr0SIvJYiKxLCFaV0_pNArfUJj7TxsJecNgYbTQA&e=3D=20
> > > [2] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com=
_vitor-2Dsoares-2Dsnps_i3c-2Dtools.git&d=3DDwICAg&c=3DDPL6_X_6JkXFx7AXWqB0t=
g&r=3DqVuU64u9x77Y0Kd0PhDK_lpxFgg6PK9PateHwjb_DY0&m=3D1N2OHEqhXNvZn7HIjf_Em=
PX5N9wwBWLsUakJ9a1zno0&s=3Dq4Oi7UD-dZ1YMlTN9prqycS1G1QvEUuBFnsABMGRuBk&e=3D=
=20
> > >=20
> > > Changes in v3:
> > >   Use the xfer_lock to prevent device detach during ioctl call
> > >   Expose i3cdev under /dev/bus/i3c/ folder like usb does
> > >   Change NOTIFY_BOUND to NOTIFY_BIND, this allows the device detach o=
ccur
> > >   before driver->probe call
> > >   Avoid use of IS_ERR_OR_NULL
> > >   Use u64_to_user_ptr instead of (void __user *)(uintptr_t) cast
> > >   Allocate k_xfer and data_ptrs at once and eliminate double allocati=
on
> > >   check
> > >   Pass i3cdev to dev->driver_data
> > >   Make all minors available
> > >   Add API documentation
> > >=20
> > > Changes in v2:
> > >   Use IDR api for minor numbering
> > >   Modify ioctl struct
> > >   Fix SPDX license
> > >=20
> > > Vitor Soares (5):
> > >   i3c: master: export i3c_masterdev_type
> > >   i3c: master: export i3c_bus_type symbol
> > >   i3c: master: add i3c_for_each_dev helper
> > >   i3c: add i3cdev module to expose i3c dev in /dev
> > >   userspace-api: add i3cdev documentation
> > >=20
> > >  Documentation/userspace-api/i3c/i3cdev.rst | 116 ++++++++
> > >  drivers/i3c/Kconfig                        |  15 +
> > >  drivers/i3c/Makefile                       |   1 +
> > >  drivers/i3c/i3cdev.c                       | 429 +++++++++++++++++++=
++++++++++
> > >  drivers/i3c/internals.h                    |   2 +
> > >  drivers/i3c/master.c                       |  16 +-
> > >  include/uapi/linux/i3c/i3cdev.h            |  38 +++
> > >  7 files changed, 616 insertions(+), 1 deletion(-)
> > >  create mode 100644 Documentation/userspace-api/i3c/i3cdev.rst
> > >  create mode 100644 drivers/i3c/i3cdev.c
> > >  create mode 100644 include/uapi/linux/i3c/i3cdev.h
> > >=20
> > > --=20
> > > 2.7.4 =20
> >=20
> > I want to make you know that none of your previous comments was ignored=
=20
> > and  I would like to start the discussion from this point.
>=20
> Sure, np. I'll probably wait for a v4 exploring the option I proposed
> then.

I would like to check with you:
  - How can we prioritize the device driver over the i3cdev driver if the=20
driver is loaded after i3cdev? Currently, this is done automatically=20
without any command, and for me, this is a requirement.
  - For the ioctl command structure, there is no rule about the way I did=20
or what you proposed, both are currently used in the kernel. For me it is=20
one more structure to deal with, can you point the advantages of your=20
purpose?
  - Regarding the ioctl codes, I tried to use those after I2C.



Best regards,
Vitor Soares

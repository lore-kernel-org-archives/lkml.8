Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6155C34024
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0A022464
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mNBtOEsN";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="GkTi2weN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbgBQPzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:55:14 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:55420 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729676AbgBQPzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:55:13 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E081EC0501;
        Mon, 17 Feb 2020 15:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1581954912; bh=nhXFS0CLEvAVDUzQmNbDScJl45tjtCFyKY2gP/Hf01w=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=mNBtOEsNi0UqkAXkLefPqEyXr90T5+8vXn/78N/xX2oqy/zWaweCpm4J/pzlvrlBe
         u3OlZ7dypZjJSHxxPM/QDdg6eWBr8zRNBm7zTFwzJxW1PgSE3y3UMS+O99Bylhdr9a
         MvOt9bYydbg6BdyMoU9HzOOPnD0E6H6HQqvmlCKw90F3IYRDYvpMBdrIGfRTZtqrGw
         OQFDHgwBLaieI6lfZ/fKFbRs88oIOaMIcI/IQqLOVQreBCuy5tngNUmJudJFh7zLs0
         9ZOpAu3NZQBmHbSoM+K+Ph0+rFyQuaXe9m93v0PuSTaL1+rhsiFzBPY4omXo2KiGoO
         ivAYQFtChzXAw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 07DC5A006A;
        Mon, 17 Feb 2020 15:55:10 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 17 Feb 2020 07:55:10 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Mon, 17 Feb 2020 07:55:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1hnznfvw4LFTBVZGi+pzKFzEKt+x12cxRBB1CdRKqvI2ad220XJUyYGPb7wfSyu4JYFyZz9cIAu1qEWDHOLabsV/MQoIfntzPVQnfgPsmfA1XZoKkn7xBjNyNfI/xs7jjNMwFL6f9JKOPi/Uvw2EWVBRosFWYCrWk01gKy9KC0YqNtfST3ABQJR/vAyPi7YM8TZKSQnYxuyQ1+OJeg9UkXXKlCOMmPNSguIVezkT2LmPD3mXel7MQqHYU/AKtUg8jdR8ngEy4DM7cW8yvI+jMEI6DT7ztd9fxStyqtW8ZLsODBB4DJHWi9aGkh1CbDbLqJwWu2ZfOas7+/SSKm/7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoDDW2BumwNooDFAk+QUZcVDk+2/BlCkaa3tiNBAkWc=;
 b=B5YROvcdBreEQKrn6BAkgvl1zmasmtn9ZZBtC7VPuYD/5yvL0j6QdaMciFyyaRit4JBDJzETZMV/JfmDo5Wg7isLxpPDpJlgbTTktiAPwv63J2yT0AYV7tj5yEpfHJgxkdgiyBeRZuInbCRoPhAXooGAd85tD67xCGYa3F2LfVqlnExmWvHz8gkkqIyySMYuOMy2wQOO+ssluIyxBEbgB3+XrA6KjOjbQ4ohXBDFTvGlK9JUtFy6vurIOZsjvKiqFu7vf7rfLUm+la2WAYmS7F5lsjkjxojv1niUFuEd5bj0ZSh+6nqoDxXRk+EXebA5/Jvuai0t0pdPtHWzX1GpSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZoDDW2BumwNooDFAk+QUZcVDk+2/BlCkaa3tiNBAkWc=;
 b=GkTi2weNtkr4XaLVyy4IFoBqGPwCGCs7d+gsYqfQjosnD6IiN5yXlKMTWj8r7n+NSMGwqQYUDCl7lSKgghP+ZJI/drMO25yTGXj/LT1Pcz+Irbtjk7bTyqxgb2DaS4ASiXRlULPGFcDTDH8WdGGpXgqtE5dOpLW1k8MHzzbrsRk=
Received: from CH2PR12MB4216.namprd12.prod.outlook.com (20.180.6.151) by
 CH2PR12MB4151.namprd12.prod.outlook.com (20.180.16.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Mon, 17 Feb 2020 15:55:08 +0000
Received: from CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::c8d1:bea7:c855:bcfe]) by CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::c8d1:bea7:c855:bcfe%5]) with mapi id 15.20.2729.032; Mon, 17 Feb 2020
 15:55:08 +0000
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: RE: [RFC v2 0/4] Introduce i3c device userspace interface
Thread-Topic: [RFC v2 0/4] Introduce i3c device userspace interface
Thread-Index: AQHV1p4wiafUt0giokeVAyQbyadp7qgflkqAgAAENoCAAAhGAIAAAN0w
Date:   Mon, 17 Feb 2020 15:55:08 +0000
Message-ID: <CH2PR12MB42166ED8E84503B53340F80DAE160@CH2PR12MB4216.namprd12.prod.outlook.com>
References: <cover.1580299067.git.vitor.soares@synopsys.com>
        <20200217155141.08e87b3f@collabora.com>
        <CAK8P3a0jAbevb6mjy7Q=C-TFGn7uHRvshHNEO8XrDPRvRoAiTA@mail.gmail.com>
 <20200217163622.6c78fa3f@collabora.com>
In-Reply-To: <20200217163622.6c78fa3f@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctZGMxYTkyMmYtNTE5ZC0xMWVhLTgyOGQtYjgwOGNm?=
 =?us-ascii?Q?NTlkN2ZjXGFtZS10ZXN0XGRjMWE5MjMwLTUxOWQtMTFlYS04MjhkLWI4MDhj?=
 =?us-ascii?Q?ZjU5ZDdmY2JvZHkudHh0IiBzej0iMjc3MyIgdD0iMTMyMjY0Mjg1MDU5NTYy?=
 =?us-ascii?Q?NzAzIiBoPSJuRFVvODFYOEFoeHVTUXd5S3Z3M1hMM0s3dU09IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQURQ?=
 =?us-ascii?Q?UEhLZnF1WFZBVWJDSHorQkNKYnRSc0lmUDRFSWx1ME9BQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 00e11ed4-d86e-4df0-3d00-08d7b3c1c349
x-ms-traffictypediagnostic: CH2PR12MB4151:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB415101E1A8146B84F6EE8050AE160@CH2PR12MB4151.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0316567485
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(396003)(39850400004)(376002)(366004)(346002)(189003)(199004)(7696005)(5660300002)(81156014)(54906003)(81166006)(4326008)(86362001)(8676002)(6506007)(110136005)(66476007)(53546011)(66556008)(64756008)(186003)(66446008)(76116006)(26005)(8936002)(66946007)(52536014)(55016002)(9686003)(2906002)(33656002)(71200400001)(316002)(478600001)(42413003);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR12MB4151;H:CH2PR12MB4216.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ++Z9KI+xvLVkzjgmV8kbxP9GmAV42izjDDHrAysLWTKPGueVwf5CyudS8Lo/auHV67JIvbf+v2+7ujzksY/efVyWsHRb5Ydjw3Pe5qBqaYIp1Ym16jl5Z1//UklqYX+PYIZEQ54lg89je1WLlX0OeAoQUe0JvCqdBNPLR2Jb0QfqayKPI6KoYvh6+Px/l6J535X1jrt2e/4GIEAiwKVCKmVeJ6Wk6cemW3P12IS6SmC4LbbWcWjbDZfFbh394GaKGS/6YeQRJvDIt8g6ZzLcrmUJE5566PYZtohaXqAGijMNfhSCnkf8+dxl7ylRM8R9bCaBZBpv+H4Q1Ts9S0NFQNMdzYa7bT/q5/wjZw7mBOdS3hlbxka9x04ssS3pUZXbc3mnvPnYGMGHC8xW/kMzQXku2I59GPcM25Q5zRVCOPzAjuEpJQhQ9HoTX1ZykyZJVf9I+NvsG04dgCMuLLaMyJ8I6jYS6h3Ioc15wyJa/ygEliHgcYGdHVQVLIjI22ra
x-ms-exchange-antispam-messagedata: qQCq/DA1eD/DvVZtOUYm62kNuPvFBCzZLvXLLMJIfH5w/qitQLofvrdWtIQCJSK54KG+6NV5+7Efu7bYNomgD3+vbh9QrjxYmyJIH9aZOlGcgahgQGL1nwhHlHHcrYpI3peXSD+Pot4SHAcfIk5pFg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 00e11ed4-d86e-4df0-3d00-08d7b3c1c349
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2020 15:55:08.0869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kuo4DCzvXX0tc8TFFKxcW3PXNwS3DviRwUsgZMYctUzPuTZ34Nz2UMIbvZtJERgE7bE4JnmvWhNW926y/kCEUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4151
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Mon, Feb 17, 2020 at 15:36:22

> On Mon, 17 Feb 2020 16:06:45 +0100
> Arnd Bergmann <arnd@arndb.de> wrote:
>=20
> > On Mon, Feb 17, 2020 at 3:51 PM Boris Brezillon
> > <boris.brezillon@collabora.com> wrote:
> > > Sorry for taking so long to reply, and thanks for working on that top=
ic.
> > >
> > > On Wed, 29 Jan 2020 13:17:31 +0100
> > > Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> > > =20
> > > > For today there is no way to use i3c devices from user space and
> > > > the introduction of such API will help developers during the i3c de=
vice
> > > > or i3c host controllers development.
> > > >
> > > > The i3cdev module is highly based on i2c-dev and yet I tried to add=
ress
> > > > the concerns raised in [1].
> > > >
> > > > NOTES:
> > > > - The i3cdev dynamically request an unused major number.
> > > >
> > > > - The i3c devices are dynamically exposed/removed from dev/ folder =
based
> > > >   on if they have a device driver bound to it. =20
> > >
> > > May I ask why you need to automatically bind devices to the i3cdev
> > > driver when they don't have a driver matching the device id
> > > loaded/compiled-in? If we get the i3c subsystem to generate proper
> > > uevents we should be able to load the i3cdev module and bind the devi=
ce
> > > to this driver using a udev rule. =20
> >=20
> > I think that would require manual configuration to ensure that the corr=
ect
> > set of devices get bound to either the userspace driver or an in-kernel
> > driver.
>=20
> Hm, isn't that what udev is supposed to do anyway? Remember that
> I3C devices expose a manufacturer and part-id (which are similar to the
> USB vendor and product ids), so deciding when an I3C device should be
> bound to the i3cdev driver should be fairly easy, and that's a
> per-device decision anyway.
>=20
> > The method from the current patch series is more complicated,
> > but it means that any device can be accessed by the user space driver
> > as long as it's not already owned by a kernel driver.
>=20
> Well, I'm more worried about the extra churn this auto-binding logic
> might create for the common 'on-demand driver loading' use case. At
> first, there's no driver matching a specific device, but userspace
> might load one based on the uevents it receives. With the current
> approach, that means we'd first have to unbind the device before
> loading the driver. AFAICT, no other subsystem does that.

I'm about to finish v3 (today or tomorrow) and I think I fixed all=20
concerns rise during v2. I would like you to see that version before any=20
change.

Best regards,
Vitor Soares


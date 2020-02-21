Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741D3C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31842222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Nb2XJJ4w";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="SYR2XN1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgBULru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:47:50 -0500
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:57224 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727161AbgBULrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:47:49 -0500
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4C75640570;
        Fri, 21 Feb 2020 11:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1582285668; bh=kTBu4m53hBTWo04dOOE7MJqjU1BunFq4b/VRlTwk29I=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Nb2XJJ4wCuUkLrwhjNzsJbIAeqX8u3WjYjTj2ZE39yCtFP1WHloX86f6W23eBPCUd
         ITSzpM8SXHruYZ86SOEZG2TlOJLtdKQlSz264HftHafMgPtzgAF1mhQI42r7thPNQj
         oPKINQikXtPg3LMWHUMD2ClSr5D58lpWQ1bX9XqWPT0JGjkFJpMm1D42kKpERS6ef6
         9vfWLGxvdUpPGby/2nMgEgV8yA6zG6sGtWqJWIbkHGmdq0tbJN8/+W7X4O1vTCKr7Z
         kybA4z/qR4CihALuZHugJkOo3jwE/qpWNq3jmkSWFExiqd/q9bQ6TpWPYjpC7EMvpx
         H8cq5ngqJxNiQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7547DA01C1;
        Fri, 21 Feb 2020 11:47:37 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 21 Feb 2020 03:47:26 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 21 Feb 2020 03:47:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3F32FSRlKketyrNKe6jjDYZ3Ko8BEi/oRivZfkOYpn9C/mzqfQUQPnZF+lVo0V8jqyc9c1ze30ZfBpZLqwGicBfdR8AdPGEcPkxzL3AQ7wOVjNVRaYmZhgsdDWo2/wMBy/dLl+sjaF1Of9NmAQBglaRVc9tlnotJT6Tq3mOQfCnu9uQC/SXpBegoXBlM22nAZvwYgSNj8JUGjASWT7lvpMS+jkoBs6YpJexcuZdFDw8oSHzaDCtwt9qU9vdAPLtDUnjtmxVoWI24LSlhBnWbkkbBGtt/FjQyWjr69Vv6cSRjyux2doOHoVeidtYgDU5WoKcWH2CUislFzF6mkCENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiiErng+/hl1POAZhEGAQO2KCUgDZ66QQ60XNm94RmQ=;
 b=IinTZeb689HzSzk5YWAZrb3pKg4iZTpjshmt1R9EnNiScJcg2eqOThhob0CX15YmyJrgZA9GpGez6uXhrYQQ1SXIBdqoT0eo8QGPW/ju2u9ntiWkpOu3of6AAFrdAcxbXjs+vjKd0KKlHt0pHvPontVBNPNW+citIUhNxqvGQDwaQVYeFL7E0YLy2GtIB/WndoBEE2LGBfOwnYL8TgE2mDMIe3BJBw1DydQsbXvdIY2Dy72eEn8gLqg8WWfN1Ss9cITeFcqk4kWiWsK+2VLb3s5ASbK/4enZsMw8t7haBxALbqw5QTeYWguwESWsTehEh37RL+XH9J0+W7Nbf2NEvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiiErng+/hl1POAZhEGAQO2KCUgDZ66QQ60XNm94RmQ=;
 b=SYR2XN1QRTgml9OAsiT/5p4oaFErVbv+aPuhL/W6tN9xmfTbCLra0YWvCKDKac6pb/EaJXoo29k0dwW/wBw+PoW1Zr8l5J+ITeXzK6UMjQcfc1IdPheanzqGNupSSjMj/k10pDFbbbfM6wccNnb/T1s5yiivz0ZVGa87zLivtrQ=
Received: from CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23)
 by CH2PR12MB3816.namprd12.prod.outlook.com (2603:10b6:610:2f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Fri, 21 Feb
 2020 11:47:22 +0000
Received: from CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::c8d1:bea7:c855:bcfe]) by CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::c8d1:bea7:c855:bcfe%5]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 11:47:22 +0000
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Jose Abreu <Jose.Abreu@synopsys.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "wsa@the-dreams.de" <wsa@the-dreams.de>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>
Subject: RE: [PATCH v3 3/5] i3c: master: add i3c_for_each_dev helper
Thread-Topic: [PATCH v3 3/5] i3c: master: add i3c_for_each_dev helper
Thread-Index: AQHV5rqGpGTZr3HbTkKTz+n225moYqgiIPIAgANW2RA=
Date:   Fri, 21 Feb 2020 11:47:22 +0000
Message-ID: <CH2PR12MB4216D5141E562974634430B8AE120@CH2PR12MB4216.namprd12.prod.outlook.com>
References: <cover.1582069402.git.vitor.soares@synopsys.com>
 <868e5b37fd817b65e6953ed7279f5063e5fc06c5.1582069402.git.vitor.soares@synopsys.com>
 <20200219073548.GA2728338@kroah.com>
In-Reply-To: <20200219073548.GA2728338@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctZThmZDM2MzMtNTQ5Zi0xMWVhLTgyOGUtYjgwOGNm?=
 =?us-ascii?Q?NTlkN2ZjXGFtZS10ZXN0XGU4ZmQzNjM0LTU0OWYtMTFlYS04MjhlLWI4MDhj?=
 =?us-ascii?Q?ZjU5ZDdmY2JvZHkudHh0IiBzej0iMjQ5NCIgdD0iMTMyMjY3NTkyNDAyNDUw?=
 =?us-ascii?Q?MTc1IiBoPSJZTVBLdDJqZFovcjNOOEZPbEZsdGY2YzJYa1k9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUQv?=
 =?us-ascii?Q?dG5Hc3JPalZBU0RUb1NZQUlhUjNJTk9oSmdBaHBIY09BQUFBQUFBQUFBQUFB?=
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
x-ms-office365-filtering-correlation-id: 8662d8c7-b3bb-4e9f-77c5-08d7b6c3d064
x-ms-traffictypediagnostic: CH2PR12MB3816:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB38160325A1070378082BB510AE120@CH2PR12MB3816.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:243;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(136003)(39860400002)(189003)(199004)(7696005)(64756008)(66476007)(66446008)(2906002)(66946007)(81166006)(8676002)(6916009)(478600001)(4326008)(81156014)(76116006)(86362001)(52536014)(33656002)(8936002)(966005)(66556008)(186003)(26005)(6506007)(54906003)(9686003)(55016002)(71200400001)(5660300002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR12MB3816;H:CH2PR12MB4216.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RSq8n6+FClhR6QxrueEiqbFubG6mgpXCS7RutCHH08XU1/4Fv19xVEcgzKh+tL9AH7A7x8rJDjsqhKFuy6JKkfgK/UcEnYnBHjoVDX57kt9lfLo0JSmna+5rNtVRzbAE7Bbr7AXwHP4Y8tBg/hJlDSuy4uAxddh3LlCFWc8M4ttqFt013t4RaEiAeyEvkobRv+QY00x//NJdTjdJ703IAJCwAHMvITrMb2FSxmWj+2kjVImYYrkX7c2cQ4unLMEdAAEBZWc9PZwBk9S3zc2UWxAtPkK2Ans4eBKXZJ8P1kxQgN+1sPm0BDLU5PopSt6EHqMkxdQLet21UsUDbRnkQGysLl6GaJOyou8JBgqNNwaVeenL+gLoxh9ZEilL55s/ZF85hqNSiinf1tDIg3xgfa+/lUvSNbA8gnZx82v7lFeZqzeFcfNhxnb99wn5E3T7JmMQI4ANzaDlO/Jgtg2JSu9xUSA3ASGmMDov+Q8N70pc6BtBUA/rcDBCypvCPTs74KV8vbkUi0s3qUnn12UCXg==
x-ms-exchange-antispam-messagedata: TXI3dMMW3Bfkr5+gmO62fr5sPstRTJUM3OPIlAOb1LCiHwUt++vQFDaT4vh6No9jsup414pBHKLLiP8JeC5RojdP+hdk8DNY9N4SHz739GrtsAIOZ/zeoulzId2RF6ghnWDsw6bZrlq7voAlPnYQTQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8662d8c7-b3bb-4e9f-77c5-08d7b6c3d064
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 11:47:22.5674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TXadeb2B+EThuZDYEx2qr+NgwJyJ/C0L30PptxC36sXn8VSSvUwbTlrxX1awaZKx7ul4gicLzqvkWbBTT4+4fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3816
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, Feb 19, 2020 at 07:35:48

> On Wed, Feb 19, 2020 at 01:20:41AM +0100, Vitor Soares wrote:
> > Introduce i3c_for_each_dev(), an i3c device iterator for use by i3cdev.
> >=20
> > Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> > ---
> >  drivers/i3c/internals.h |  1 +
> >  drivers/i3c/master.c    | 12 ++++++++++++
> >  2 files changed, 13 insertions(+)
> >=20
> > diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
> > index bc062e8..a6deedf 100644
> > --- a/drivers/i3c/internals.h
> > +++ b/drivers/i3c/internals.h
> > @@ -24,4 +24,5 @@ int i3c_dev_enable_ibi_locked(struct i3c_dev_desc *de=
v);
> >  int i3c_dev_request_ibi_locked(struct i3c_dev_desc *dev,
> >  			       const struct i3c_ibi_setup *req);
> >  void i3c_dev_free_ibi_locked(struct i3c_dev_desc *dev);
> > +int i3c_for_each_dev(void *data, int (*fn)(struct device *, void *));
> >  #endif /* I3C_INTERNAL_H */
> > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > index 21c4372..8e22da2 100644
> > --- a/drivers/i3c/master.c
> > +++ b/drivers/i3c/master.c
> > @@ -2640,6 +2640,18 @@ void i3c_dev_free_ibi_locked(struct i3c_dev_desc=
 *dev)
> >  	dev->ibi =3D NULL;
> >  }
> > =20
> > +int i3c_for_each_dev(void *data, int (*fn)(struct device *, void *))
> > +{
> > +	int res;
> > +
> > +	mutex_lock(&i3c_core_lock);
> > +	res =3D bus_for_each_dev(&i3c_bus_type, NULL, data, fn);
> > +	mutex_unlock(&i3c_core_lock);
>=20
> Ick, why the lock?  Are you _sure_ you need that?  The core should
> handle any list locking issues here, right?

I want to make sure that no new devices (eg: Hot-Join capable device) are=20
added during this iteration and after this call, each new device will=20
release a bus notification.

>=20
> I don't see bus-specific-locks around other subsystem functions that do
> this (like usb_for_each_dev).

I based in I2C use case.

>=20
> thanks,
>=20
> greg k-h
>=20
> _______________________________________________
> linux-i3c mailing list
> linux-i3c@lists.infradead.org
> https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.infradead.org=
_mailman_listinfo_linux-2Di3c&d=3DDwICAg&c=3DDPL6_X_6JkXFx7AXWqB0tg&r=3DqVu=
U64u9x77Y0Kd0PhDK_lpxFgg6PK9PateHwjb_DY0&m=3DtlMumonboh0P8ljWml7h8q161eLTzD=
bo5QF77YPi2t8&s=3DRYYk4dJ4Ujse2MjdOBsoEwEOkxXDStTffqzlFZhwlXQ&e=3D=20

Best regards,
Vitor Soares

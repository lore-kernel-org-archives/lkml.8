Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB3AC34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41E4C24654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 00:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="iCVA5M5C";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="ZmdqgKm/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgBSAjj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 19:39:39 -0500
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:59852 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726595AbgBSAji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 19:39:38 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 07A2140122;
        Wed, 19 Feb 2020 00:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1582072777; bh=NgOiwbT4DgxxPdn2w/EgICJ0ErxsALwSOL9VJ93EEJo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=iCVA5M5CCyMyUD7jvi8k6r1vX3kauT17lFJlGXCunRSqeRUgPa1xHq021JkrbbkkW
         Vbj9B3pZzKu1jj94qf21iQZ6Hn1PXWdd5EuoQ4uM0kvoRwaqVewcWAljOrVT9eHYjG
         8dH1PP832fbxKz7zqA/aZKDc30PLB0BzLSwWDR8AIOKa+Ih8lEjenWAfj/u+DcbmGc
         ZvYR/ikDGjS5A0u328KGyRxk9aOg5Fl2CcGMvP0767Cq7cmtgX13VKifmqZDouAryT
         r8m9A8hLwbfdVZ2Ez27vpdMSwuKCoBaqww8wGuU6uyK8mHjDKj6cR9f/cbOb/xAc+x
         Tg/8gpUZjxA4w==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 59C82A0079;
        Wed, 19 Feb 2020 00:39:33 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 18 Feb 2020 16:39:33 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Tue, 18 Feb 2020 16:39:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNXeiy+1Rscx30QCiVM+QMc84NVe+RkcrGp/lRwRDxLKx9aNv7yhF0ohl+V7EC3qovJP8oTKrFN5dEx7RjG+9uvViJf3VSVoMAhb6lWf8H7KbNSTuxDYpIX8iHtNTgt7QPnkw6InNuZIEMN1thKkkJDIGjUwswahLPXU5CC/ly4JOfHUs+eFsi8WRVrVJrRLTKZEchyBFrfjGut0JABz/n2/tmvT5MoAflxGjLJj9AE+eMU62lF0FX1SxlwRaJCJ/49m+1cP3Lkx9TjqUEGmzZKrJoDACxjDhXx7SK92aMqWJzI5B5nH9s4t8EkwmnSffQTe2JL0f/DMCS2LrqkIDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HWQJPkoxFSoKPbqmF6KdNYVIBEAlWh4GTlbUxvRcL4=;
 b=UuEY/NVrxVz7okdZzSt4lgUu2RuDvyva1dewJJXrubZ5Fru4Q/tUIlzYkP9/wc5502/UX8CftWbHSUbM0ZfSDEK/L2Wo5UyQUZcebaRRSPGudWJh7h2mvQ2tppMuHtf501mTQgPCMyOGF8NWXuwHXEy3IwCUqSKqFq2uqiTaF4JJdjyqQcq3pKj8xBPsF8cDRSQWDDwjvlv41QghtK2dEfX214dXP8EVz1SlO9MlGdwu3muJYKxAYSImlYYOJVI/ms80F7OR2VSYGdw5K6jLrdTBcDkJT0Jzp4GEIH83gk/aptkL0sTPoe4L+RB0+GcF4KI6LNrmPU2vp+0GV6VObg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HWQJPkoxFSoKPbqmF6KdNYVIBEAlWh4GTlbUxvRcL4=;
 b=ZmdqgKm/6q+hMLsuUNnydlmGDeM4nMSXpIkEIMesDBMgg7ZkQVHdrt1pa13uyXSNSuTkU0SWnrw7N7QOfxfIprlv3u/AOw8y60fILZxKqz5odWSBflcfn6Nu63Jc37WTI7ERHPzKOP18yfm8zk4AunfAQBW2Aj0K8jeY5L+QT88=
Received: from CH2PR12MB4216.namprd12.prod.outlook.com (20.180.6.151) by
 CH2PR12MB4296.namprd12.prod.outlook.com (20.180.16.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 00:39:31 +0000
Received: from CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::c8d1:bea7:c855:bcfe]) by CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::c8d1:bea7:c855:bcfe%5]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 00:39:31 +0000
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     "bbrezillon@kernel.org" <bbrezillon@kernel.org>
CC:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "wsa@the-dreams.de" <wsa@the-dreams.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>
Subject: RE: [PATCH v3 0/5] Introduce i3c device userspace interface
Thread-Topic: [PATCH v3 0/5] Introduce i3c device userspace interface
Thread-Index: AQHV5rqI90LrTPLnik2TPIdRwWN8OaghqdAQ
Date:   Wed, 19 Feb 2020 00:39:31 +0000
Message-ID: <CH2PR12MB421604E9272413A6C456AB16AE100@CH2PR12MB4216.namprd12.prod.outlook.com>
References: <cover.1582069402.git.vitor.soares@synopsys.com>
In-Reply-To: <cover.1582069402.git.vitor.soares@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctNDg1YWQzNTQtNTJiMC0xMWVhLTgyOGQtYjgwOGNm?=
 =?us-ascii?Q?NTlkN2ZjXGFtZS10ZXN0XDQ4NWFkMzU1LTUyYjAtMTFlYS04MjhkLWI4MDhj?=
 =?us-ascii?Q?ZjU5ZDdmY2JvZHkudHh0IiBzej0iMzUyOSIgdD0iMTMyMjY1NDYzNjkzMjk4?=
 =?us-ascii?Q?OTMxIiBoPSJIWGJCMm11SDEyUWROK0hpczZURnJOUjU2M3c9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFCUUpBQUR6?=
 =?us-ascii?Q?ekgwTHZlYlZBZHBwQkRxTEFhTG0ybWtFT29zQm91WU9BQUFBQUFBQUFBQUFB?=
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
x-originating-ip: [2.83.222.20]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2a20bda-90c1-4a79-f125-08d7b4d42f2a
x-ms-traffictypediagnostic: CH2PR12MB4296:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB42966F8CE0B57774FAC5DFB7AE100@CH2PR12MB4296.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(396003)(136003)(366004)(346002)(199004)(189003)(64756008)(55016002)(66446008)(66556008)(9686003)(966005)(478600001)(33656002)(71200400001)(86362001)(52536014)(66946007)(76116006)(186003)(8936002)(6916009)(81166006)(4326008)(26005)(5660300002)(54906003)(66476007)(81156014)(8676002)(7696005)(6506007)(2906002)(316002)(42413003);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR12MB4296;H:CH2PR12MB4216.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q0N9vGH5KNW0r2Y8fnfRQZiDR/i74oHSEq7TFtEfqba6NWVMvtkPPQx/CoNMSaq/dWUEGeSfRoZ2bPm6SvkHYVX/ceLdeDUZ9pDDXsdYU4NAgc996/hQZw8W1/WvfjNiGDUk8zVhkB8ysxy98SOrxOfgG4+/KidJbKWjHYBO9UcAe5XYKNgmP3BcXqZnFBBL5VI/75BwaogHVM2qWhAVuzpsqTUAxGdL/mBiEu1EA9Z8YwXyy+frSqv8CVYDYuGd3TmFeZFUq9ZRiwBonGpMyr47IXspFZj+oVWJAzH2l2wVI5cOf0NGjzgcbw3EmSawC+rn6Xt/Ljl1h68LOSquybbCna0VEdvFZGFyd0w526cFkCDyFUjPKuPhZSV0lP9RIw6vkCGwTJUCf4l8TstysEoj77nOG8NejhXTb1fvI+k5+HzVffvQLijtu9mBluOrKUu7AYMIpkoy26G8rniuLOUhh42mMnlO9eYGWxeJ9mWUQXuoCblr214fR4QScrc5IaUS5eA9XNWlo94zMaqPjZQj8Ip3Q0V+Rw2Nj3NKPLKmf4WTCLfE3nB00DRjwcwi
x-ms-exchange-antispam-messagedata: NMuRwhx4gMIdYtT3ChR1hIOVLe3P2cvMZhJ4+ciWjTPAwa7Lx8dDvlSLZYgH8uHe/6Ckwf3hyX5b7ORrQF73dAXK/1WtKRZ2O0MA1G2lDPW0YFZgvzbwuG91oaYpZmRI2baAKJ3LLSNMGwDGMEOgDQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f2a20bda-90c1-4a79-f125-08d7b4d42f2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 00:39:31.1802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gqOJ4CXUCbz1db58EVZCeoCoRNH9nS5/B6eTl3y5amaXg1OqHCOqvW1d7cX+VXwGoy+FuUKB/SbIjlZ+OB/Ygg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

From: Vitor Soares <vitor.soares@synopsys.com>
Date: Wed, Feb 19, 2020 at 00:20:38

> For today there is no way to use i3c devices from user space and
> the introduction of such API will help developers during the i3c device
> or i3c host controllers development.
>=20
> The i3cdev module is highly based on i2c-dev and yet I tried to address
> the concerns raised in [1].
>=20
> NOTES:
> - The i3cdev dynamically request an unused major number.
>=20
> - The i3c devices are dynamically exposed/removed from dev/ folder based
>   on if they have a device driver bound to it.
>=20
> - For now, the module exposes i3c devices without device driver on
>   dev/bus/i3c/<bus>-<pid>
>=20
> - As in the i2c subsystem, here it is exposed the i3c_priv_xfer to
>   userspace. I tried to use a dedicated structure as in spidev but I don'=
t
>   see any obvious advantage.
>=20
> - Since the i3c API only exposes i3c_priv_xfer to devices, for now, the
>   module just makes use of one ioctl(). This can change in the future wit=
h
>   the introduction hdr commands or by the need of exposing some CCC
>   commands to the device API (private contract between master-slave).
>   Regarding the i3c device info, some information is already available
>   through sysfs. We can add more device attributes to expose more
>   information or add a dedicated ioctl() request for that purpose or both=
.
>=20
> - Similar to i2c, I have also created a tool that you can find in [2]
>   for testing purposes. If you have some time available I would appreciat=
e
>   your feedback about it as well.
>=20
> [1] https://lkml.org/lkml/2018/11/15/853
> [2] https://github.com/vitor-soares-snps/i3c-tools.git
>=20
> Changes in v3:
>   Use the xfer_lock to prevent device detach during ioctl call
>   Expose i3cdev under /dev/bus/i3c/ folder like usb does
>   Change NOTIFY_BOUND to NOTIFY_BIND, this allows the device detach occur
>   before driver->probe call
>   Avoid use of IS_ERR_OR_NULL
>   Use u64_to_user_ptr instead of (void __user *)(uintptr_t) cast
>   Allocate k_xfer and data_ptrs at once and eliminate double allocation
>   check
>   Pass i3cdev to dev->driver_data
>   Make all minors available
>   Add API documentation
>=20
> Changes in v2:
>   Use IDR api for minor numbering
>   Modify ioctl struct
>   Fix SPDX license
>=20
> Vitor Soares (5):
>   i3c: master: export i3c_masterdev_type
>   i3c: master: export i3c_bus_type symbol
>   i3c: master: add i3c_for_each_dev helper
>   i3c: add i3cdev module to expose i3c dev in /dev
>   userspace-api: add i3cdev documentation
>=20
>  Documentation/userspace-api/i3c/i3cdev.rst | 116 ++++++++
>  drivers/i3c/Kconfig                        |  15 +
>  drivers/i3c/Makefile                       |   1 +
>  drivers/i3c/i3cdev.c                       | 429 +++++++++++++++++++++++=
++++++
>  drivers/i3c/internals.h                    |   2 +
>  drivers/i3c/master.c                       |  16 +-
>  include/uapi/linux/i3c/i3cdev.h            |  38 +++
>  7 files changed, 616 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/userspace-api/i3c/i3cdev.rst
>  create mode 100644 drivers/i3c/i3cdev.c
>  create mode 100644 include/uapi/linux/i3c/i3cdev.h
>=20
> --=20
> 2.7.4

I want to make you know that none of your previous comments was ignored=20
and  I would like to start the discussion from this point.

Best regards,
Vitor Soares

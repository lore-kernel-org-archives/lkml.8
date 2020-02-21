Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62F4C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA738222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="XxMaVqfr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="VdEp+rgx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbgBULvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:51:08 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:44710 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727315AbgBULvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:51:06 -0500
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 52AEBC0093;
        Fri, 21 Feb 2020 11:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1582285865; bh=iX0IbWkgWKSzRTe8jiP6K2Yc0udFXUFnlBuct9VDRgM=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=XxMaVqfrayf3++KXFRpUaxB2OMDBD/2pHUyKXm9EiTT88L2cbIvPpW8NNiik5+rBv
         ksNtVhisGUoigdlsk3FHX00tMSRdVw2wwrnofuFz2RuQ25VsvQeg99RG1dM6gp3290
         tcoglXjNIE1m6ZFysffWJKBULOVxjgI1+bm/3OX3RBVNHB9Uia6xDnKrNxkd5bohQF
         sGOyksfocGoL+OuKrtsprx7fX6ZXGBzydUjmFsMs2a16DtUFtNegQimdg+p++DWVZ4
         7n3ricnsDYSr4eKDur+8uksdQkMhlSCCGfwUIIHPSV6iMq3wbh9A/VfJ0SKn1caNVn
         27DtYiD0cfJcA==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id E6EE0A00AE;
        Fri, 21 Feb 2020 11:51:01 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 21 Feb 2020 03:50:45 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 21 Feb 2020 03:50:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/Acf55kQ+Uq5s1ah/A2kxwPbrqFHpyjcrGmP7IUAejW3/sycg+aYrvJF2YNCkPRaaw5hLCfiDsykBSaStD7pcWyGvz5JkfQ/JHluSO739W3LDewOklSjPXbmQtHngzBg+wEthVGELiE4PXr25V7ndVL5q7B0yb8K9rT11iJ+hnRvvxArYrQ8Cj5UAT6TfL1UEEMjIzKAdjvA9uzDJVoZAbb3lXpBuFau9r8ZtQ9WYA973p4DeUtauBgESup0r7r+1A2hLzXPYAA7eyCeKVVoJ/LdK5Nuj3EUzSzXvnWggUd6C8xFB+FTjTH8Mjoo2VVyOtB/dvSlZXX+B9/AFrBjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iX0IbWkgWKSzRTe8jiP6K2Yc0udFXUFnlBuct9VDRgM=;
 b=B8Qb1tDirc7PlHVlm6f0LoKNJrNgtZJ+I50QiZjWfg7mgflp5c8W1lDU4zW8mpPJk5K83TXS0GWd1ob+3pK0CpbG4x4pVsln/4APpWaYWnk6pYUP5PK0w3sH+nbSv0b8G3+NEvEOTcB/Eg7MqmdRk+DYGy63vK5OPvHqn1OJhKSkTdRn/wPcf7sEtq6+XhjZzudxhJUJYo+6DrWEiYVjeJ7jh66pD2+bERwVuHSlt0DTDyINR/OoAVaEfim4pD2ZI7+9AzVGMh33W8nhmFSjUkFe7pW1hlqZ3LpCO/oRo6zEf5lleGKFDidPjtPplqwnyQG8g2xKu0SRyq5FhMhUVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iX0IbWkgWKSzRTe8jiP6K2Yc0udFXUFnlBuct9VDRgM=;
 b=VdEp+rgxNMgt+mv0Y7ABtRBLC2CspbZ94mUkooJV/e3nh91SfPQ4y54ZzSyjgPOl3NkEhmylkD/zgUM/2I4PpQLAxqbHb+7vzVkF+blakITI0/NguW1HEu12/uGFtDG6CrB3vnsDfC1efTETTvCeur2EQ2qtUKvm2B5kCLjG42I=
Received: from CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23)
 by CH2PR12MB3701.namprd12.prod.outlook.com (2603:10b6:610:23::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Fri, 21 Feb
 2020 11:50:43 +0000
Received: from CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::c8d1:bea7:c855:bcfe]) by CH2PR12MB4216.namprd12.prod.outlook.com
 ([fe80::c8d1:bea7:c855:bcfe%5]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 11:50:43 +0000
From:   Vitor Soares <Vitor.Soares@synopsys.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "bbrezillon@kernel.org" <bbrezillon@kernel.org>,
        "wsa@the-dreams.de" <wsa@the-dreams.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v3 4/5] i3c: add i3cdev module to expose i3c dev in /dev
Thread-Topic: [PATCH v3 4/5] i3c: add i3cdev module to expose i3c dev in /dev
Thread-Index: AQHV5rqGCzs/XZoBrU+kjYi0pz6mk6giIdiAgANqbLA=
Date:   Fri, 21 Feb 2020 11:50:42 +0000
Message-ID: <CH2PR12MB4216BFDAAD3EC267136856D7AE120@CH2PR12MB4216.namprd12.prod.outlook.com>
References: <cover.1582069402.git.vitor.soares@synopsys.com>
 <e093ae9da81e7702c188a20d1e8b9d7f8024bfeb.1582069402.git.vitor.soares@synopsys.com>
 <20200219073901.GC2728338@kroah.com>
In-Reply-To: <20200219073901.GC2728338@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc29hcmVzXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctNjFiNDhmMDUtNTRhMC0xMWVhLTgyOGUtYjgwOGNm?=
 =?us-ascii?Q?NTlkN2ZjXGFtZS10ZXN0XDYxYjQ4ZjA3LTU0YTAtMTFlYS04MjhlLWI4MDhj?=
 =?us-ascii?Q?ZjU5ZDdmY2JvZHkudHh0IiBzej0iNDEzIiB0PSIxMzIyNjc1OTQ0MDkxMTQx?=
 =?us-ascii?Q?MzQiIGg9ImtjbXFpUm85M2l0WW55TGUrQzlJTFNuZVRKYz0iIGlkPSIiIGJs?=
 =?us-ascii?Q?PSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUJRSkFBQVcr?=
 =?us-ascii?Q?Z3drcmVqVkFYbWk1Tld1NG14RmVhTGsxYTdpYkVVT0FBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFIQUFBQUNrQ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFRQUJBQUFBc1BwUkdRQUFBQUFBQUFBQUFBQUFBSjRBQUFCbUFHa0FiZ0Jo?=
 =?us-ascii?Q?QUc0QVl3QmxBRjhBY0FCc0FHRUFiZ0J1QUdrQWJnQm5BRjhBZHdCaEFIUUFa?=
 =?us-ascii?Q?UUJ5QUcwQVlRQnlBR3NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVB?=
 =?us-ascii?Q?QUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhrQVh3QndB?=
 =?us-ascii?Q?R0VBY2dCMEFHNEFaUUJ5QUhNQVh3Qm5BR1lBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFB?=
 =?us-ascii?Q?QUNlQUFBQVpnQnZBSFVBYmdCa0FISUFlUUJmQUhBQVlRQnlBSFFBYmdCbEFI?=
 =?us-ascii?Q?SUFjd0JmQUhNQVlRQnRBSE1BZFFCdUFHY0FYd0JqQUc4QWJnQm1BQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJtQUc4QWRR?=
 =?us-ascii?Q?QnVBR1FBY2dCNUFGOEFjQUJoQUhJQWRBQnVBR1VBY2dCekFGOEFjd0JoQUcw?=
 =?us-ascii?Q?QWN3QjFBRzRBWndCZkFISUFaUUJ6QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtBWHdC?=
 =?us-ascii?Q?d0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCekFHMEFhUUJqQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFB?=
 =?us-ascii?Q?QUFBQ2VBQUFBWmdCdkFIVUFiZ0JrQUhJQWVRQmZBSEFBWVFCeUFIUUFiZ0Js?=
 =?us-ascii?Q?QUhJQWN3QmZBSE1BZEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQm1BRzhB?=
 =?us-ascii?Q?ZFFCdUFHUUFjZ0I1QUY4QWNBQmhBSElBZEFCdUFHVUFjZ0J6QUY4QWRBQnpB?=
 =?us-ascii?Q?RzBBWXdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFIa0FY?=
 =?us-ascii?Q?d0J3QUdFQWNnQjBBRzRBWlFCeUFITUFYd0IxQUcwQVl3QUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNB?=
 =?us-ascii?Q?QUFBQUFDZUFBQUFad0IwQUhNQVh3QndBSElBYndCa0FIVUFZd0IwQUY4QWRB?=
 =?us-ascii?Q?QnlBR0VBYVFCdUFHa0FiZ0JuQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFCekFH?=
 =?us-ascii?Q?RUFiQUJsQUhNQVh3QmhBR01BWXdCdkFIVUFiZ0IwQUY4QWNBQnNBR0VBYmdB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBSE1BWVFCc0FHVUFjd0JmQUhF?=
 =?us-ascii?Q?QWRRQnZBSFFBWlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFB?=
 =?us-ascii?Q?Q0FBQUFBQUNlQUFBQWN3QnVBSEFBY3dCZkFHd0FhUUJqQUdVQWJnQnpBR1VB?=
 =?us-ascii?Q?WHdCMEFHVUFjZ0J0QUY4QU1RQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJ6?=
 =?us-ascii?Q?QUc0QWNBQnpBRjhBYkFCcEFHTUFaUUJ1QUhNQVpRQmZBSFFBWlFCeUFHMEFY?=
 =?us-ascii?Q?d0J6QUhRQWRRQmtBR1VBYmdCMEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFIWUFad0JmQUdzQVpRQjVB?=
 =?us-ascii?Q?SGNBYndCeUFHUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFB?=
 =?us-ascii?Q?QUFDQUFBQUFBQT0iLz48L21ldGE+?=
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=soares@synopsys.com; 
x-originating-ip: [83.174.63.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8a4a012-61ae-4f3f-c61a-08d7b6c447d4
x-ms-traffictypediagnostic: CH2PR12MB3701:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR12MB37018E2939C9CB0463CFC018AE120@CH2PR12MB3701.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:214;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(39860400002)(346002)(376002)(366004)(199004)(189003)(71200400001)(9686003)(186003)(5660300002)(558084003)(2906002)(7696005)(4326008)(52536014)(76116006)(66946007)(6506007)(316002)(54906003)(26005)(64756008)(66446008)(81166006)(6916009)(81156014)(8676002)(86362001)(66556008)(478600001)(66476007)(8936002)(55016002)(33656002)(42413003)(32563001);DIR:OUT;SFP:1102;SCL:1;SRVR:CH2PR12MB3701;H:CH2PR12MB4216.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xga/I6zPIBv5W4sL/awKLPynS/awxCyRAcCmmrtsLJljz0v9QxfX/pVx3kfEUq4nz1wXlMf4zn+/MfGt4lzmCNbv2Pdq8+Fl3QRB4c2MxLLpvSoEDghFbYaRXYvdfWiktoknrzp4OlAUnQAsIKmnqx2pGAXM4umABSnYxIl4BtGZoyaCHlsoCKMLQum8YRLoqbDmxFbIvmnJCtqdeIaJIhUtufFYKl2IWDhHyHgI89vFVZkZlGFv1tqJZewaiKVPhPtvWJISjOrMx0SfPaMJQiXVZn7JD+chXGkblqnOXcRcsi2D59jd22QRHQxeMw21DNDO1lk5XX5GoJU4tYPYQL2DyxQlQoDbYmbRF0E18d32vFg7sVpZS/SsjNGDhd4+dz6msqzSMbGRZ+FZe1WEXiCsDurTQGSQP0KlKqCyIcKvHCtmTDVd4cn0GmuKqnpdshnW8ohiq0H8G+r1WQvPoCRpiSve9E0N60GOcAaQBwquh42hvWtPzY9LeAmJvz0LzRZi2gPPF0kcf0zQngP3Sg==
x-ms-exchange-antispam-messagedata: dWM1MZBDFKNdNwDOYdSiz+MA2OA1RZY/WGWfVXMHImyYtHJLgokYbHDhCxuafI0O1edJCsJih5p7tBKE9DG/fR+oeeH7+00PG29lbQGi29ZjgaMDLa2t0wIRb+yAiDfKUpA9hf3mMtfDhm3Gatn5ug==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a4a012-61ae-4f3f-c61a-08d7b6c447d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 11:50:42.9523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WM72mt1aTErvxfRd6AZZSK2r5dWbQJqm+YZgZ7kQQaAYTsJLTSHYSLA9cP+kNEi7/xQFfsowFCTdnOORRkGIhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3701
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, Feb 19, 2020 at 07:39:01

> On Wed, Feb 19, 2020 at 01:20:42AM +0100, Vitor Soares wrote:
> > +
> > +static DEFINE_IDA(i3cdev_ida);
>=20
> You never destroy this when the code is unloaded :(

You are right, I need to destroy it.

Thanks,
Vitor Soares

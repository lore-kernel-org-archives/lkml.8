Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292A9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 967452075B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="YUzlNgzp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="u0dTllf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgFEKsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:48:10 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:41598 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726465AbgFEKsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:48:09 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3A86F40164;
        Fri,  5 Jun 2020 10:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1591354089; bh=1yAsG7126iRDxbbSY8xmSirD7V//SSJeBp5cFGitw18=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=YUzlNgzpPpnf+FvPbYNcLZUFU7nVD+HIzmhK3jxGrfnG251t4QiOrwZuMRN5+Bnm+
         8zsHffGxnN98TE9erWoGbQNNKYKevjKtDrUnFEfMSaj0wUic0Zk40ON/eESTomcbB1
         04egHrywnAu0qK4dVn7SVtxOmPVPZuBF9UEh2Eqp/tU8Sgkya9herNTJA/zKa7GZpr
         IetO8zja+7Ris/jHJSWhjYO4meHv7Di7s6cEoembRJRTE218GrCSy+bdotOT7d6zQ9
         dNcoiW8KVOoKyYdOS7/xqZ2VdXVrnQF13uot32EWHMrmYcgnCon2w1N9jusyiHf4Pe
         dRwTxtZMr0+0g==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 39836A0067;
        Fri,  5 Jun 2020 10:48:06 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 5 Jun 2020 03:48:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Fri, 5 Jun 2020 03:48:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAsGr+LsaIaCx1Nr2TBkSCnmjwHNDiRrxa59FyYH8x3k3ABLg7sFIip1juQIO+IrRe7oiXwHtlKR9fiTbWxWAJf9C0JmmVU0P+nuBUPz7tMnzdyHgRGsKpjTCmKAWVaKTW+urmfN5Zrln/8wwBhgoeBKHCVAmg8/4bsGxq34k4zNTZ6IcGd9dzph9wIBvtNjrCVibH/x8fAkvYR44TnLsg1zBpzrXhRxOCBSG2I8a3QGexRS2hcbezVTG19txRTAL3p47NHTj/wmVc8A2RDtnKhMTHEwZc0GTpcdne7aDkJNKJuTF2AwMK75kshoeRKTxYK+GIkoslKW/PMqGLsKOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/iGk+5CzB6M4MAShsoO4Vk9aIE2wsAEr9uaDxJrq3s=;
 b=mMJp/JR3ionMLQqjRHKcGy9xzttJTurASjZyjva9WZZXkdKkRjMt3r2XRSVcOzQ7ZB2tJM8slOttkgjeL6cTcDrvx7dEyNZ89pPfGzet3mTxcMjFS28jy4N/hcpZtzAIR9BbydwTDJQm90IkwFb0T84ZW4wEVMUzmzwnBvvntkP+4MG8e/KTYwmXw8c1Px91PAcBZBzaysxn8qDkOLLssJjduwwKUQEuMvQCKhwiss6BiylpMSMOYKgrdqj3RrAZQKyfY2ePFXwBjr1Lx9oHnDTvMyxuud2n0/5X+g5cwphIeivVQWC527MmSjuhFdnz0UbB60EIC+uCkiCUdFEA6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/iGk+5CzB6M4MAShsoO4Vk9aIE2wsAEr9uaDxJrq3s=;
 b=u0dTllf9JbTs+wH/mcGS6stAaWxmLYMbXvf8NJREVwGdlKe575Aqnt1+XW+c8+Vo60eo0jtghCu2CJUn7lAYkSc1zQF7lLjCOrJOK8Cr3vLmh56pH3RoBlTSNxZTYc1JJozmSvu/TAxO7y7LOJ1dAj0klJBn6iTzSIaIbB/Tl1s=
Received: from MWHPR1201MB0046.namprd12.prod.outlook.com
 (2603:10b6:301:5b::16) by MWHPR1201MB0063.namprd12.prod.outlook.com
 (2603:10b6:301:4d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Fri, 5 Jun
 2020 10:47:58 +0000
Received: from MWHPR1201MB0046.namprd12.prod.outlook.com
 ([fe80::c529:d11c:40d9:97dd]) by MWHPR1201MB0046.namprd12.prod.outlook.com
 ([fe80::c529:d11c:40d9:97dd%5]) with mapi id 15.20.3066.022; Fri, 5 Jun 2020
 10:47:58 +0000
X-SNPS-Relay: synopsys.com
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Eugeniy Paltsev" <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: RE: [PATCH v2 1/4] ARC: allow to override default mcpu compiler flag
Thread-Topic: [PATCH v2 1/4] ARC: allow to override default mcpu compiler flag
Thread-Index: AQHWOpc3iGznfJlhwkGtLq/Y8Mt+lajJ1WOg
Date:   Fri, 5 Jun 2020 10:47:57 +0000
Message-ID: <MWHPR1201MB0046338E4B38598FFB5DBCB9A1860@MWHPR1201MB0046.namprd12.prod.outlook.com>
References: <20200604173927.23127-1-Eugeniy.Paltsev@synopsys.com>
 <20200604173927.23127-2-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20200604173927.23127-2-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYWJyb2RraW5c?=
 =?us-ascii?Q?YXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRi?=
 =?us-ascii?Q?YTI5ZTM1Ylxtc2dzXG1zZy0wMjljNDMxMi1hNzFhLTExZWEtODA0YS04OGIx?=
 =?us-ascii?Q?MTFjZGUyMTdcYW1lLXRlc3RcMDI5YzQzMTMtYTcxYS0xMWVhLTgwNGEtODhi?=
 =?us-ascii?Q?MTExY2RlMjE3Ym9keS50eHQiIHN6PSIxNjgwIiB0PSIxMzIzNTgyNzY3NTYw?=
 =?us-ascii?Q?NjMzOTMiIGg9Imd6dnM2dWRzY0M1QjRhL0ZWK3ZMQjNVSCtRQT0iIGlkPSIi?=
 =?us-ascii?Q?IGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk5DZ1VBQUJRSkFB?=
 =?us-ascii?Q?Q2h4Q0RGSmp2V0FRbG5ZMUpTbDMza0NXZGpVbEtYZmVRT0FBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFIQUFBQUNrQ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFFQUFRQUJBQUFBRGVCS0lRQUFBQUFBQUFBQUFBQUFBSjRBQUFCbUFHa0Fi?=
 =?us-ascii?Q?Z0JoQUc0QVl3QmxBRjhBY0FCc0FHRUFiZ0J1QUdrQWJnQm5BRjhBZHdCaEFI?=
 =?us-ascii?Q?UUFaUUJ5QUcwQVlRQnlBR3NBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBR1lBYndCMUFHNEFaQUJ5QUhrQVh3?=
 =?us-ascii?Q?QndBR0VBY2dCMEFHNEFaUUJ5QUhNQVh3Qm5BR1lBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FB?=
 =?us-ascii?Q?QUFBQUNlQUFBQVpnQnZBSFVBYmdCa0FISUFlUUJmQUhBQVlRQnlBSFFBYmdC?=
 =?us-ascii?Q?bEFISUFjd0JmQUhNQVlRQnRBSE1BZFFCdUFHY0FYd0JqQUc4QWJnQm1BQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFBQUJtQUc4?=
 =?us-ascii?Q?QWRRQnVBR1FBY2dCNUFGOEFjQUJoQUhJQWRBQnVBR1VBY2dCekFGOEFjd0Jo?=
 =?us-ascii?Q?QUcwQWN3QjFBRzRBWndCZkFISUFaUUJ6QUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFHWUFid0IxQUc0QVpBQnlBSGtB?=
 =?us-ascii?Q?WHdCd0FHRUFjZ0IwQUc0QVpRQnlBSE1BWHdCekFHMEFhUUJqQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFD?=
 =?us-ascii?Q?QUFBQUFBQ2VBQUFBWmdCdkFIVUFiZ0JrQUhJQWVRQmZBSEFBWVFCeUFIUUFi?=
 =?us-ascii?Q?Z0JsQUhJQWN3QmZBSE1BZEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUo0QUFBQm1B?=
 =?us-ascii?Q?RzhBZFFCdUFHUUFjZ0I1QUY4QWNBQmhBSElBZEFCdUFHVUFjZ0J6QUY4QWRB?=
 =?us-ascii?Q?QnpBRzBBWXdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdZQWJ3QjFBRzRBWkFCeUFI?=
 =?us-ascii?Q?a0FYd0J3QUdFQWNnQjBBRzRBWlFCeUFITUFYd0IxQUcwQVl3QUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFB?=
 =?us-ascii?Q?QUNBQUFBQUFDZUFBQUFad0IwQUhNQVh3QndBSElBYndCa0FIVUFZd0IwQUY4?=
 =?us-ascii?Q?QWRBQnlBR0VBYVFCdUFHa0FiZ0JuQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBSjRBQUFC?=
 =?us-ascii?Q?ekFHRUFiQUJsQUhNQVh3QmhBR01BWXdCdkFIVUFiZ0IwQUY4QWNBQnNBR0VB?=
 =?us-ascii?Q?YmdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQUFBSE1BWVFCc0FHVUFjd0Jm?=
 =?us-ascii?Q?QUhFQWRRQnZBSFFBWlFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFRQUFBQUFB?=
 =?us-ascii?Q?QUFBQ0FBQUFBQUNlQUFBQWN3QnVBSEFBY3dCZkFHd0FhUUJqQUdVQWJnQnpB?=
 =?us-ascii?Q?R1VBWHdCMEFHVUFjZ0J0QUY4QU1RQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKNEFB?=
 =?us-ascii?Q?QUJ6QUc0QWNBQnpBRjhBYkFCcEFHTUFaUUJ1QUhNQVpRQmZBSFFBWlFCeUFH?=
 =?us-ascii?Q?MEFYd0J6QUhRQWRRQmtBR1VBYmdCMEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQUFIWUFad0JmQUdzQVpR?=
 =?us-ascii?Q?QjVBSGNBYndCeUFHUUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQVFBQUFB?=
 =?us-ascii?Q?QUFBQUFDQUFBQUFBQT0iLz48L21ldGE+?=
x-dg-rorf: true
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [91.237.150.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a6f935d6-a0e0-4908-dd30-08d8093de918
x-ms-traffictypediagnostic: MWHPR1201MB0063:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1201MB00631B06628740997989D0D2A1860@MWHPR1201MB0063.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0425A67DEF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KqEVnJKOTcbLu1umrNyjKL1yKL1B+5p9FWAoaYnVMi+jxDCImbzEoClbQbKtknCQbuSYBJZR6tKikWLDw8T8ybc4ic/iqr2kHvD6ncc/OQa3GN2HwAUJ1yQdAtMGrSQZMFMsiWBqFyjT21dKEmoemeXHrqsVosRImMlzu0k6NfvJkFjCeSXAKX5zofmH1GSbd+slavYQztIwsziiJDg3zLixs8csWMKcZLq2ekigifJVsCiJxtgXzJBdEMGx+R+Iy0gxgwm0Rar63uWNBqzgXIdoUG1d7Ee9WunuutHwnaL0p/XCII65R5nbrWOjwSOsKE2U0Djv4vvCDhFftG2VXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB0046.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(376002)(366004)(39860400002)(396003)(53546011)(186003)(7696005)(83380400001)(6862004)(9686003)(478600001)(26005)(107886003)(54906003)(8936002)(66446008)(55016002)(4326008)(71200400001)(66946007)(2906002)(8676002)(316002)(6506007)(76116006)(66476007)(33656002)(86362001)(5660300002)(6636002)(64756008)(52536014)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: zlK2ae2AknQ2CXUz7V1S7Iye5mLLdXlYUYJP/Jc3o7MSJ8P+MYU6ddxM/Eb4YymvgroismWbtCO9R+0OFD9URyGSVdyg3dGbrVH3JisLCryzM8AR5dT03+e+8KEXeaUH/hkiRufLleqf6OVZCEZkGgOgomV7IvrfBeUWeDiqSw+Zjh+yZa9dVUO1amVVzwIFAjoTRvmWyrSiJrSXzqIH13L2i3GW11VjOw4s8Vkdrm/sOQTSn9vWbhGDAOgFbHEoannrGwlsf4Ur8YF4PDajvxk9yEVdST+akJhq87/d/uIp7h8hPxuWgsh8zCuUirOWwZR+anpMwKfFmqlf9aANGO/lYT4arXiYwj1+jbrzZRy3Av4FM5HpFXlgrh+h08Wpe2EJVR3oW8AjALMRHmQ5XzzBnHUgNhTsqnizklbBznX0ceRgIM2mFhPFk2o89ftjnjoaoEUewA9kTOR83lAhSnbR2wSh2vKhnKsqxiRGIklgG50Gb/i6Ud6yt0nKiS4S
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f935d6-a0e0-4908-dd30-08d8093de918
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2020 10:47:57.9901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RZLSUk8k5RgWonkFQ8PlvNo/JpHlyD4rzV2JGZ7bJDN4QyzWOuYiL6+tv5Cws+gjv1Kk40ocmPgE/Hl+ASaL3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0063
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eugeniy,

A couple of minor notes below.

> -----Original Message-----
> From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> Sent: Thursday, June 4, 2020 8:39 PM
> To: linux-snps-arc@lists.infradead.org; Vineet Gupta <vgupta@synopsys.com=
>
> Cc: linux-kernel@vger.kernel.org; Alexey Brodkin <abrodkin@synopsys.com>;=
 Eugeniy Paltsev
> <paltsev@synopsys.com>
> Subject: [PATCH v2 1/4] ARC: allow to override default mcpu compiler flag
>=20
> Kernel builds set their own default -mcpu for a given ISA build.

We used to use a default "-mcpu" per ARC ISA version (one for ARCompact
and one for ARCv2).

> But that gets in the way of "custom" -mcpu flags from propagating
> into kernel build.

But with more versions of CPUs & SoCs becoming available we want to
be able to fine-tune generated code more precise.

> This will also be used in next patches for HSDK-4xD board support which
> uses a different -mcpu to effect dual issue scheduling.

"...for utilization of the new CPU's dual-issue capabilities"?

> +++ b/arch/arc/Makefile
> @@ -10,8 +10,25 @@ CROSS_COMPILE :=3D $(call cc-cross-prefix, arc-linux- =
arceb-linux-)
>  endif
>=20
>  cflags-y	+=3D -fno-common -pipe -fno-builtin -mmedium-calls -D__linux__
> -cflags-$(CONFIG_ISA_ARCOMPACT)	+=3D -mA7
> -cflags-$(CONFIG_ISA_ARCV2)	+=3D -mcpu=3Dhs38
> +
> +tune-mcpu-def-$(CONFIG_ISA_ARCOMPACT)	:=3D -mA7

I'd suggest to either swap "-mA7" which is being obsoleted with "-mcpu=3Dar=
c700"
right here or as a separate change, otherwise we may soon get ATC700 builds
broken with newer compilers.

-Alexey

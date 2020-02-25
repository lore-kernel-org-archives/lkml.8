Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B690C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5092721744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 10:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbgBYKti convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 05:49:38 -0500
Received: from mail-oln040092254040.outbound.protection.outlook.com ([40.92.254.40]:52048
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729417AbgBYKth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 05:49:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjZj+xs74SlsrbMJH/hJCi+Y6ooI1dyDMyt8GD1pdnxMmf4VoRNTpmox1PhcoEQjUM8ZUmITuWP2tCzla3WXTwJdJZypYk+N9Ij68O3kGL+X/8BEpGpgcGbhgk0jO3lQfavRagx6oCPlXQo0ZZGRUa0RyHTEFVWJI7ytFDNxAu7tpVx+BQaV84qt3T3LmwM3TQEtJ11xQ603kYCz9eCAIx5ZmJDfj3LOBCK3//sfIprO7GJ8QcSRmHFjNNRXapOd/Lng8vmLjIE4Kq+QKAZuseop96cQKZiWA3MB9Q8P1TDQwURP/sO0Yp+hyEc3vHcTDZs3oSn+Duc88pVsVQGbbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=snypIJGQnxLZRkP3g+9XBxH9SrxW3RFtT7fTb2MHa3M=;
 b=D4B2YCIH+VZXdPGUpvA75TKxTG4Xmu4lML6aNZciVgwm7Sf8lKWbspN9m7bQMaaFCaSmFrdMDLk49zkMYzZ+4ML94y65HkSXQVnj2+SeWW+xGjHw62iTRS8rmhvV/GoPyElw2q/LTj17BW921+V4ktHTgisvSWdBJG///TuXLrEhFC8n9RjtunFDhsCDmoTQQFT/MsTMrCN+ELuKZVqtl+jaGQafb+u22GzL2uCBc8AsngAe19gv1PyY+O1XAXWkOgrFiBmuRa5fq5fglFSRJ2LsWQGmvIoMQfLzLTxWxlgW9W9f9IfeCewjV2WN9ebTWo15Iz0HVPdiTrA9+z3wlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT053.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebe::33) by
 PU1APC01HT170.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebe::241)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18; Tue, 25 Feb
 2020 10:49:34 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.51) by
 PU1APC01FT053.mail.protection.outlook.com (10.152.253.128) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 10:49:34 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 10:49:34 +0000
Received: from nicholas-dell-linux (2001:44b8:6065:1c:6059:d44:6861:fae2) by ME4P282CA0018.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:90::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 10:49:31 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v1 3/3] nvmem: Remove .read_only field from nvmem_config
Thread-Topic: [PATCH v1 3/3] nvmem: Remove .read_only field from nvmem_config
Thread-Index: AQHV6znsaiedl+y69kCc/s7T8T7K26grvAoA
Date:   Tue, 25 Feb 2020 10:49:33 +0000
Message-ID: <PSXP216MB043889D5ADEC4E9BF36CC3E080ED0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB043899D4B8F693E1E5C3ECCE80EC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <PSXP216MB043836D392E998FB3193568480EC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB043836D392E998FB3193568480EC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME4P282CA0018.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:90::28) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:FEC28137A5D7C7BA656620FBC5DCABF1EAD3DBEB59460FFD3C219746D9221086;UpperCasedChecksum:E564D484453FDC11011D4ED68D58F09C17219727C86E291691AF7F9C5ADBAC14;SizeAsReceived:7950;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [7IfO7nLqaxZImDa85kH7lfQ1tqE+KIQPMJO1benPlqaCVj//+qVHHlzC8YVYIhq4]
x-microsoft-original-message-id: <20200225104926.GA1683@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 8af5d47a-4a84-42b3-70ed-08d7b9e065c0
x-ms-traffictypediagnostic: PU1APC01HT170:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QJsvqarFIe8Tchsvj3sGfKNRR7g6+SrhE5AkxXmH53g+objHOFm56G+42zKL0pNfr3niYWV1VUzTQ+JTtg7C8qwaeSIVKxvP4SrruXxUNvUaK5tuh1hNQhyu6ndKUGm1a57GEWHQCDdiXKVlY3n+ZFLu022L1RslcSTBIwYIIh89KoUQIOeKcoECZzkL8hea9W8FDsstpFjBVNX5joIdRmV7og2kh9PiDGJSc+jANPc=
x-ms-exchange-antispam-messagedata: ZMKsoIf3l7WalJQpB/aKaPwT03TJBh+uEtlvF9vQk0IIJTOZem3GAFFgWIzqsh5IGAKpzScFCVpvlXErsM9aC6sewim37H6mU7PTZdXi2fYhk4YkhEPVRc1UyhUpZwjZWRILUyqcj5XOyuYfcxOQBtBz67/dUTfcT/Nj/oX7nGWrcmxniDQzdwWIPtkMXjjSnEY8tXrbYjF381FTjsKGpA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CF4233F167195947A027F4B824CD339F@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af5d47a-4a84-42b3-70ed-08d7b9e065c0
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 10:49:33.8373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 05:43:29PM +0000, Nicholas Johnson wrote:
> There is no .write_only field in nvmem_config, so having .read_only
> makes no sense. We can determine the attrs based on whether .reg_read
> and .reg_write are provided. Using only .reg_read and .reg_write means
> that there can no longer be contradictions (for instance, if .read_only
> is set but .reg_read is NULL).
> 
> Remove .read_only field from nvmem_config.
> 
> Remove all references to .read_only field from drivers.
> 
> Update drivers to only supply nvmem->reg_write if write attrs are
> desired.
> 
> Signed-off-by: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> ---

Sorry all, I got this build bot [0] telling me that this patch 3/3 fails 
to compile for ARM architecture. It worked for x86-64. So please ignore 
3/3 for now while I investigate. 1/3 and 2/3 are all good.

I will find a better way to ensure that I have all of the references and 
post a PATCH v2 sometime.

Kind regards,
Nicholas

[0]
https://lore.kernel.org/lkml/202002250920.gc0wDekv%25lkp@intel.com/

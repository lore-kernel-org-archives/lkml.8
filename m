Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203B7C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 10:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91F62468D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 10:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="i+wRX7k9";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="i+wRX7k9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgB0KSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 05:18:51 -0500
Received: from mail-eopbgr80087.outbound.protection.outlook.com ([40.107.8.87]:44609
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728454AbgB0KSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 05:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pwt7XfA3fTB9SOtrdHonklTf6XqXmWD1rqujmtrU/XU=;
 b=i+wRX7k9LseZNOX7BOsFVROO9KZUOgtcseKgBiUpECQMI+SG0ugZuOHcXA8EB8gbN2s7u9V3nDwP5wBgvE1exbrvC6bATATdrw6Jick3+DdUj9Q6ZvPfImq7biBX8sWPaCzYirRX2cccmgHIYn6V+Ybl/WoJx+KYyoIc8IDonLs=
Received: from VI1PR08CA0188.eurprd08.prod.outlook.com (2603:10a6:800:d2::18)
 by AM4PR0802MB2146.eurprd08.prod.outlook.com (2603:10a6:200:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Thu, 27 Feb
 2020 10:18:44 +0000
Received: from DB5EUR03FT062.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::207) by VI1PR08CA0188.outlook.office365.com
 (2603:10a6:800:d2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend
 Transport; Thu, 27 Feb 2020 10:18:44 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT062.mail.protection.outlook.com (10.152.20.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Thu, 27 Feb 2020 10:18:44 +0000
Received: ("Tessian outbound 62d9cfe08e54:v42"); Thu, 27 Feb 2020 10:18:44 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ed0de32563808baa
X-CR-MTA-TID: 64aa7808
Received: from 44a233c511cc.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 5028CC8F-0244-4BD0-8153-8BE47F0DAEB0.1;
        Thu, 27 Feb 2020 10:18:38 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 44a233c511cc.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 27 Feb 2020 10:18:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBCWTaenWy/UY+mqOa8lVMTRQHbOu0+Zl1qmEpy+peJ3MTC2BbQiGc66jqPAzK/84CRpL0HJHeHMy/IUIXvPkSbIXsA3zvBMOWwhqGDGaijKeeuu1LRcW/7c1Jy2yfs5ZDaOmx80nJgogBN5uRbqISSGIxzX92vzXp9xVdkq6gx9WDi+IJriIBzqhRxxSoERyTWm3YejHcBgolJwqOg6Db47xHKgBrMgJXSfcTqdm2NfkTrPf6ts1Ax4BoET4jwdWczIXBZNcSuQxC6bAooV668J4QJDa/cAUbXcIBoci5FZJVxHgzZXvQIIkYiT0WK47zrrwfB3WPIKIjtOhTUuwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pwt7XfA3fTB9SOtrdHonklTf6XqXmWD1rqujmtrU/XU=;
 b=BOU9tOQycDoeayhCFvu+FSA37yjGks4I9SoS2fRJyXr3knciIN+nWxNUFI/OG8SewtD8Mks32CCoDPcveVOppbfNIBxGbpQiLf8Fbrj+OSvm+nqWW62c3ZuCxu2S+7Rrq/kt/x+NdN2ovSZmQZLO5FDW6INRBqZASx6Av5bJt0niyUlXDyzoLKv/6pz/hR5tB+6mktePgUexpJ0Ve5ShkwEZkIPZHZlbUWtl7ShtK9jn3IJcJOX8JxSZUgql+egWvvVmEwqZ9s7hmGjDdSmIeoXazxNmZkeE3IdqE0H0QR4dpkVDiJ8BnWKvicUiSNym9Vpl7zTZgxkT5R7RyE5q6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pwt7XfA3fTB9SOtrdHonklTf6XqXmWD1rqujmtrU/XU=;
 b=i+wRX7k9LseZNOX7BOsFVROO9KZUOgtcseKgBiUpECQMI+SG0ugZuOHcXA8EB8gbN2s7u9V3nDwP5wBgvE1exbrvC6bATATdrw6Jick3+DdUj9Q6ZvPfImq7biBX8sWPaCzYirRX2cccmgHIYn6V+Ybl/WoJx+KYyoIc8IDonLs=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
Received: from DB7PR08MB3292.eurprd08.prod.outlook.com (52.134.111.30) by
 DB7PR08MB2987.eurprd08.prod.outlook.com (52.134.109.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Thu, 27 Feb 2020 10:18:36 +0000
Received: from DB7PR08MB3292.eurprd08.prod.outlook.com
 ([fe80::d48a:40f:822:6a0a]) by DB7PR08MB3292.eurprd08.prod.outlook.com
 ([fe80::d48a:40f:822:6a0a%7]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 10:18:36 +0000
Cc:     nd@arm.com, "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Paul Turner <pjt@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <codonell@redhat.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: Rseq registration: Google tcmalloc vs glibc
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Chris Kennelly <ckennelly@google.com>
References: <1503467992.2999.1582234410317.JavaMail.zimbra@efficios.com>
 <20200221154923.GC194360@google.com>
 <1683022606.3452.1582301632640.JavaMail.zimbra@efficios.com>
 <CAEXW_YRT7AjaJs7mPyNd=J6fhBicYwGbQMK2Senwm3cBhFvWPw@mail.gmail.com>
 <CAEE+ybmQb02u-=c1sHozkJ+RXOi2Hno6qYJ0Vx9rOpKjSQ4fPQ@mail.gmail.com>
 <1089333712.8657.1582736509318.JavaMail.zimbra@efficios.com>
 <CAEE+ybkTs4U7h-Js818k1QEqpVfHwAHSTXaEwHs3g37LwOsjLQ@mail.gmail.com>
 <982202794.8791.1582743392060.JavaMail.zimbra@efficios.com>
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=szabolcs.nagy@arm.com; keydata=
 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
Message-ID: <c79e3622-30df-001f-8f60-5a3edc10f7e5@arm.com>
Date:   Thu, 27 Feb 2020 10:18:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <982202794.8791.1582743392060.JavaMail.zimbra@efficios.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0030.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::18) To DB7PR08MB3292.eurprd08.prod.outlook.com
 (2603:10a6:5:1f::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.2.80.79] (217.140.106.55) by LO2P265CA0030.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:61::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 10:18:34 +0000
X-Originating-IP: [217.140.106.55]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3dc0cbfb-f0c2-4bbb-0445-08d7bb6e6cea
X-MS-TrafficTypeDiagnostic: DB7PR08MB2987:|AM4PR0802MB2146:
X-Microsoft-Antispam-PRVS: <AM4PR0802MB2146B6E9A66DFDF3163C7822EDEB0@AM4PR0802MB2146.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;OLM:9508;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(199004)(189003)(66946007)(16526019)(7416002)(26005)(44832011)(2906002)(81166006)(81156014)(8936002)(2616005)(956004)(31696002)(66476007)(8676002)(53546011)(6486002)(186003)(66556008)(5660300002)(316002)(4326008)(36756003)(16576012)(31686004)(478600001)(110136005)(86362001)(4744005)(52116002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR08MB2987;H:DB7PR08MB3292.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: YIUeRhcmV/VLbto9gM/Pw4ORM2ZaZW+G+fapLjXoUk3cqMkzsmzXxZaJB6tDVad5RHMJ10DyLhwwk9kBUKB7VaoulxaeslbeMu6sALedEx3BzAW6gWyDEX/Hgp/fn8XHMIJJi23fxfjxyHWR4L/qt90Nzk6jDz4FH6lCuhNF7pMeXs7+ScBudqKxnSuuY03DHKz4duO04i4LC8FNAEqNlVPfPEO1kGrKY1pXTPSE39dUdv+bZNCKLc1tSQyAqL5nWJjsRHcd2pFt0gVEHiCelDsts0AqhkD2lSOscXUDqUZnbYIGWMPZ0e9U8cQL4ZJ0EUR8JOUBknSln3Ae204kZqAcvMRgddb3Ndu6JgCckRKavBOLRUVnPRuRqXwTBsCGcxAqpmmOo4sP+z7sQ+mDJkoduoHly083J21SO0FzUxWuszCSZMak8ysIzjZ1Qrlr
X-MS-Exchange-AntiSpam-MessageData: ppaohYiJzaaucvuUFrYwzSTTO1hljitKW3LTFrS6ScjQu9G8JiRM61PwjbAXfH6qGiB+SscIerlwogH8sXZtIoh8ShvtaGuoeiyso5aidDBCyZeTxhwXZvptAiBnEi9LjM+Zwmpg4OvTmI22DsKgTw==
X-MS-Exchange-Transport-Forked: True
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB2987
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Szabolcs.Nagy@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT062.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(396003)(376002)(346002)(136003)(189003)(199004)(8676002)(356004)(26826003)(26005)(2906002)(53546011)(8936002)(110136005)(36756003)(316002)(16576012)(2616005)(956004)(4326008)(5660300002)(70586007)(44832011)(70206006)(6486002)(81156014)(81166006)(4744005)(54906003)(31696002)(86362001)(478600001)(16526019)(31686004)(107886003)(336012)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0802MB2146;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 51926393-080b-478d-cd56-08d7bb6e67c2
X-Forefront-PRVS: 03264AEA72
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dty6rLm4LuFvnqeIhGLNsLlZe+DTBe1H1jw5sNcys0IoPMpXYXvE2oz0jeunLAZkT8S46orL1igv0QR/j0u+0vPwEuG2xPfD+PueA1ic3gxT4WKIsEY9HCFBmqBzyRYfTuun4kT5qPlKEIrZe9+EkrZRhb84nBYX7CoDbmqVY3iNQbSGkv3Xgj5xENTyQTrBydH9okBPlpT5LGp2O/ORZrcVH+tC/5Cyq4t0PYjNh6j55GTJUXSdgoXNx4PZS3G2wB2eaOArWCOc0M/6ips156PCQ2j5QTQAhHdMjGFe30mn+7g8+ey8cYHhL6wYk/GpQMDAGOzdE5BkJWuZigtJmpJoZMt9sQk6/3gACqHsonyyavigPUx4fId5hDD2K0eFSfZ+hmhoWc0I8biWJ4mYNNhgeyBv8Yz9pcRJgrZCkDJ+gr/lz4yXLMDhuwBYonKj
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 10:18:44.4206
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dc0cbfb-f0c2-4bbb-0445-08d7bb6e6cea
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2146
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2020 18:56, Mathieu Desnoyers wrote:
> ----- On Feb 26, 2020, at 12:27 PM, Chris Kennelly ckennelly@google.com wrote:
>> I agree that this could potentially violate inviarants, but
>> InitFastPerCpu is not intended to be called by the application.
> 
> OK, explicitly documenting this would be a good thing. In my own projects,
> I prefix those symbols with double-underscores (__) to indicate that those
> are not meant to be called by other means than the static inlines in the API.

use a different convention for that, __ prefix is always
reserved for the implementation for arbitrary use.

ideally internals would not be exposed in the user api
and then there is no such issue.

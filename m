Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D831EC2D0F3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6DD20857
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:39:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=vmware.com header.i=@vmware.com header.b="ImB+/xKj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389132AbgDBQjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:39:22 -0400
Received: from mail-eopbgr770089.outbound.protection.outlook.com ([40.107.77.89]:24213
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388555AbgDBQjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:39:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lcDi/zrkpBD4UFidjdwVSs8o4giqMZRJTY1jaFeEtAWbL3umXHxwwmtMXxYO+GybojGlm5FAeL4Dy+Lr+CpcmA4Tm7l50+2L/xaoOmJ1xRD9AimS5WRq5kc2zGBPqSmIsu5WrQOsbJPHu9RSY2D7EJXLqnUWfxdlQStxaLKiccmGLj0z6xtSUFkcYwfrUu7nX7sOrExXf2wJFcpRa5q/F8+Q6jimOZG4nFibkuZlwGRPSBSKk5SsgjAAtDFkFsZcqhIVRext+N0KgWfGxQ2xwVvjV5SpG9b71J9Jp9ceKQpRpKQX/twuvVxxoqtE6t6vzuGOLGlyHc0o/jfaUT4fyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVSRk8upYMu7m8OeTU0MBq/QMOy+80EagZDbCxosWU8=;
 b=PcDmXfdTwLIIERzuNFGa3vTDwmZ5BGezKEoOXyZfGSpW28GlxN5wHv17AF9nILP4BOaTXBxbFG87ZK4QVksYNZjlD/r/cvVPWAvehI+pQ+ppofFZgy0fPMKHSf0QdEpprhLxwlKvFdUwtPNMLHiMhW3S/JkarafOD13V0RBSmvCOUTZpZE2oZI20yPggQgoeOMFhPbigwB6CFBDj2q8EKiLGdIlRTTap7VrKqybYxhdnPOXkE/IZOFWYhZux2e3tTt6V9pGaGn3+J4sR0SCFzDfJYSLf2smlqYkwlXk0R2iIdwb67wyrc2GefYbz7QRwTpiPAp5WKcS6z5Ru76dSUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVSRk8upYMu7m8OeTU0MBq/QMOy+80EagZDbCxosWU8=;
 b=ImB+/xKju2voLT4VtAxzAuHCmMD/xmxn4/kI9kzsNHstZaACVrU2HXtR6CDcDh1znHX9uDKx2VlSCenOWxEJgLbRmrr6+XIsqnfBwlclUCQBiM+DySOxwjdgSZ6UiWkl9F5LdtoZniFea07IWbIQINWEkxFaRHap3wriLMoZ+Fw=
Received: from BYAPR05MB4776.namprd05.prod.outlook.com (2603:10b6:a03:4a::18)
 by BYAPR05MB4181.namprd05.prod.outlook.com (2603:10b6:a02:87::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Thu, 2 Apr
 2020 16:39:12 +0000
Received: from BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::7c65:25af:faf7:5331]) by BYAPR05MB4776.namprd05.prod.outlook.com
 ([fe80::7c65:25af:faf7:5331%2]) with mapi id 15.20.2878.014; Thu, 2 Apr 2020
 16:39:11 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch v2 1/2] x86,module: Detect VMX modules and disable
 Split-Lock-Detect
Thread-Topic: [patch v2 1/2] x86,module: Detect VMX modules and disable
 Split-Lock-Detect
Thread-Index: AQHWCQK4rBR9ssiUhkC+D5sFyAvl1ahmAyEAgAABlQCAAAO9gA==
Date:   Thu, 2 Apr 2020 16:39:11 +0000
Message-ID: <A86B173C-857C-4B7B-A543-BE967F9A1868@vmware.com>
References: <20200402123258.895628824@linutronix.de>
 <20200402124205.242674296@linutronix.de>
 <20200402152340.GL20713@hirez.programming.kicks-ass.net>
 <725ca48f-8194-658e-0296-65d4368803b5@intel.com>
 <20200402162548.GH20730@hirez.programming.kicks-ass.net>
In-Reply-To: <20200402162548.GH20730@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com; 
x-originating-ip: [2601:647:4700:9b2:1153:aafd:5246:5949]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65e2cfd2-6d6d-44f6-6f73-08d7d7245fa7
x-ms-traffictypediagnostic: BYAPR05MB4181:|BYAPR05MB4181:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR05MB4181F333C8D378FB1A5DED55D0C60@BYAPR05MB4181.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4776.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(316002)(36756003)(81166006)(6916009)(54906003)(2906002)(8676002)(6486002)(81156014)(8936002)(186003)(86362001)(2616005)(4744005)(33656002)(5660300002)(6506007)(53546011)(66446008)(66556008)(71200400001)(478600001)(66476007)(76116006)(66946007)(6512007)(64756008)(4326008)(7416002);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: vmware.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jBOLEzFxKwxJnKbGJpCY52BBU0DOzuiP50go/xS1a0JOs/fGlnDtER6Qvc+rcdvSPvi/SWwSlXZqywO3swmKT3c0cHg4wqGC3evo04OKDRV0eqGBo3NENBsWBLkQ5IVttZPl/4usfv8pFdWnV8BPQrNnscsyLckUMLQxyjEITa0uOUkpCZqMQBhg/o5qnmZrnepK02bmc/wCyHTLDiw8i3amvWX6xhBp6cMym/6Bv1p+PTBWSOzDHEBoYAY5d2du4c7ar6B1rxSBUChDUH0tTusCjU2zdvr8TV9TQeXnLKUUwT7u4kqYZSBjHonVx97oJcpQwV91uOqDqwzkz9huFKAC1rdiflQor8cWmZLjZLfudpgQ2uaAjrpkCgMZkR+IYhCQvbfY7BFQaQ2MNsfIzpqcpLB3daDS9TJU8wR5BAQp1iRxV7QrmgYnG7DYFFB8
x-ms-exchange-antispam-messagedata: 6v/W1Y/JoCsx0SJRnnGXs3MnP1nFWYdC32B2jZacq2CWxtpOmb+6UmRqTtiP0iatZaZx6nu7AimspNRlMMk+XVM6+QKTEFfg0S4Fwq/H5H4I75DwEz8ja/XEuh6sC11Z6EZXD3ZmOMBxL7fO1WsXIUmrDZ7ngjc8dYb9AhsrbelpNR/TGi8YOycU/ouz0FpSS8aHFhPAPvN8PsWfXzR2KQ==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <79B9730BAD75E64E89D6907626A0E497@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e2cfd2-6d6d-44f6-6f73-08d7d7245fa7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 16:39:11.8718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NDelQuJsGLzTxzJP8no+Jk9Stww6Podm/sfzm8O9EFSNH3VcWrhzNVTnHcZ6Ni3iJw5FdRK01WOJ7L0TOpdw7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR05MB4181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Apr 2, 2020, at 9:25 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
>=20
> Learn to trim your replies already!
>=20
> On Fri, Apr 03, 2020 at 12:20:08AM +0800, Xiaoyao Li wrote:
>> On 4/2/2020 11:23 PM, Peter Zijlstra wrote:
>=20
>>> +bad_module:
>>> +	pr_warn("disabled due to VMX in module: %s\n", me->name);
>>> +	sld_state =3D sld_off;
>>=20
>> shouldn't we remove the __ro_after_init of sld_state?
>=20
> Oh, that's probably a good idea. I can't actually test this due to no
> hardware.

Just wondering, since I lack hardware as well: can the performance counter
LOCK_CYCLES.SPLIT_LOCK_UC_LOCK_DURATION be used to detect split-locks
similarly to SLD (although it would be after the split-lock event)?


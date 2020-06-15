Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E136C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49375206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=necglobal.onmicrosoft.com header.i=@necglobal.onmicrosoft.com header.b="qmikKiQg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgFOGUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:20:00 -0400
Received: from mail-eopbgr1310050.outbound.protection.outlook.com ([40.107.131.50]:22752
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728284AbgFOGT7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:19:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtTdGs0ALsQbo1uyQPWK6t1JVQI5nBjB+c8zHiN5elZxxFdig8WTH9cn0LxtDKYB439hPgHAEScT1OiAp9tX6/seqpagGM6wJKO8i78TwD5LAeKmuJeX4ekIa/cjkBduka16FS6VrexZsG04fqBVBigeP8BZFzu6gL7HFVReXyXtwU0fhG/t1t+yJ3R3sQ7Nbz2Ke5pC2taozvuShDiOr+UevCVvK450PwLkN5ZuVAnaR6rpAvDxUmCSS9Uy1k/eOU1HYwT/NwuI9xDERz/+r9M52EBv5jAPTpM0rU2uvpoaGvO8js1XIefG9jDa8oyJQ6RZ7Z86k50XDTYmlGgn+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/tUcPZLrKBPnabwteb+So0P9wDf5r7ELPiCDViEq1o=;
 b=Wty6GB0D0Rv7AsHRCxA/t2m4/eoFyVnkQtBRzegP/0a32UMcXMa90/y9XWPNQluWutjyt1QsphieV47ANxufCGNDBb6zW2ubFvyZv7TnackX871NGjtsc3irQm8mqP+QZ2DAP/MooWKforsJnjLvA/NzcQny0+uRjhWK7qKec9BHOmN+6YskcnQIkgAhxGZJcqGgRWL7SlizIPgkKAjPv01FmoQhFXIjL/suRAKntfsvUmTqsBG78de5JoVrONRAh884x4JBqlXvH0CX62I3Jxpt5FdPWUGNkGa7Vhm1WK7IOpXsRWFT5OT17k1cGvupSu7Eowa0PbT5WgtXlhhJcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/tUcPZLrKBPnabwteb+So0P9wDf5r7ELPiCDViEq1o=;
 b=qmikKiQgS0tRMl8QNZUf+X/GzmeTBcoCKNnKgcf1C+RxkMZ+aCrPGJXG9hdKsxKJbsBqAxyejT1VWTKmawvrGhkNtun/TMXk2IT44ewVP6Aw1mbMLcc6hifa0sZYIiy99G7pDd5qACwBfGxvWhpGG+RE+IBfwlcc3zjpDJeucFc=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TY2PR01MB2540.jpnprd01.prod.outlook.com (2603:1096:404:6e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.19; Mon, 15 Jun
 2020 06:19:54 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::3841:ec9f:5cdf:f58]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::3841:ec9f:5cdf:f58%5]) with mapi id 15.20.3088.028; Mon, 15 Jun 2020
 06:19:54 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Dmitry Yakunin <zeil@yandex-team.ru>
CC:     "osalvador@suse.de" <osalvador@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "n-horiguchi@ah.jp.nec.com" <n-horiguchi@ah.jp.nec.com>,
        "max7255@yandex-team.ru" <max7255@yandex-team.ru>
Subject: Re: [RFC PATCH v2 00/16] Hwpoison rework {hard,soft}-offline
Thread-Topic: [RFC PATCH v2 00/16] Hwpoison rework {hard,soft}-offline
Thread-Index: AQHWQA+H5/eI9wztJka38makXyA1EqjZOdWA
Date:   Mon, 15 Jun 2020 06:19:53 +0000
Message-ID: <20200615061951.GA26108@hori.linux.bs1.fc.nec.co.jp>
References: <20191017142123.24245-1-osalvador@suse.de>
 <20200611164319.16860-1-zeil@yandex-team.ru>
In-Reply-To: <20200611164319.16860-1-zeil@yandex-team.ru>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: yandex-team.ru; dkim=none (message not signed)
 header.d=none;yandex-team.ru; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a8f3857-0fbf-44fd-aef2-08d810f41e5d
x-ms-traffictypediagnostic: TY2PR01MB2540:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB25403ED2CAA111AE0F671CAFE79C0@TY2PR01MB2540.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HjFubihrXcgdpXkhuCJgXT2Oi4lAAi/VqfCrnFOM4+2IA/JQZ0fPMAWo9oADSoA7OJRfDtqhiP742ufgaXGREqJuPcI8DtM6A2CTvEA6OpQBO4Xge0X04A9SwoRCO1417Hkyjab5aXKVmLtyno+vkin6szFXazZQD1uV0jLCM8WB6M915UmhXmFOnRcQ835D4ZL8Ola/N+rnxSvMN02bV7eDcv1pCnnFTeGQHNx5OJKTHchy3ZXfTnXxQcc3n9Z/d49gj65BE0HanyRcSBYe9P6W4YkuNtkaMUtGFvCmBGvYQx64/lkl4grGG/ju8zKpQGsnNV1jY/Aullvax6ruHcQkrAYrl86kxCEqKCJC/+IabCgaRF8J+N9NHI29P0KQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(366004)(39860400002)(346002)(376002)(2906002)(83380400001)(6916009)(33656002)(9686003)(6512007)(4326008)(5660300002)(1076003)(55236004)(6506007)(76116006)(66446008)(64756008)(186003)(316002)(8936002)(66476007)(66946007)(71200400001)(85182001)(478600001)(6486002)(8676002)(54906003)(86362001)(26005)(66556008)(142933001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /erXWni+ELHMUPgFe0cH0JJBLk6J4K9/F4q0pfzuDg3DscbI4hbe75qz9JUFEVEnKY4pmH+i+PjFHVd3MNB5N+zaAMYKMJnxBoxygc49Kmd0WrrdLz+Xwnh13afGUkhjjkzbsa76V4+TRtAu6ndeBgR618FdtezkoUFk+tA/escjOM9pkWRRHa8uKLbU+y1EGDhajQFFErqVR09eBuvmlNX5x9NTWx1zt5H0JQCMnaFmtqIyYuFthgO7Z8a0B9hz4pE3cTlHMS+ZIM5SbfbP/hY7mFrKBVeECuC28bmK8hOnt9Vc/ObOtub/cY/XSGupKSDBAox9uKQDiDyF40qJwIUjtMOUf0rptUad74ZabBoVL3QBFttbBY0us2n4TFsL75IA8dvlhOOfxPvawRYLIvxv0+KsKfYsGrekXJXNvKpUAFTeVIAezlwWtUZtnGjduaUPPOFvbYvYA0wbFgVKnLdh1Vd7esMiqc3e9oRCiaYfh6EI0EFv3i74JgjmJVO+
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <2FE0E49E76F0E04699B62B358E37EF69@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8f3857-0fbf-44fd-aef2-08d810f41e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 06:19:53.9606
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tRpXFBhW8W7MUt6bKwVTmFy+JBP3la7Hb6I5JOXfWqgXjq+Kc3s5OzaoS0cBMuH9UW5EgJTwO4t4LO1keX+aqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2540
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Thu, Jun 11, 2020 at 07:43:19PM +0300, Dmitry Yakunin wrote:
> Hello!
>=20
> We are faced with similar problems with hwpoisoned pages
> on one of our production clusters after kernel update to stable 4.19.
> Application that does a lot of memory allocations sometimes caught SIGBUS=
 signal
> with message in dmesg about hardware memory corruption fault.
> In kernel and mce logs we saw messages about soft offlining pages with
> correctable errors. Those events always had happened before application
> was killed. This is not the behavior we expect. We want our application t=
o
> continue working on a smaller set of available pages in the system.
>=20
> This issue is difficult to reproduce, but we suppose that the reason for =
such
> behavior is that compaction does not check for page poisonness while proc=
essing
> free pages, so as a result valid userspace data gets migrated to bad page=
s.
> We wrote the simple test:
>   - soft offline first 4 pages in every 64 continuous pages in ZONE_NORMA=
L
>     through writing pfn to /sys/devices/system/memory/soft_offline_page
>   - force compaction by echo 1 >> /proc/sys/vm/compact_memory
> Without this patch series after these steps bash became unusable
> and every attempt to run any command leads to SIGBUS with message about
> hardware memory corruption fault. And after applying this series to our k=
ernel
> tree we cannot reproduce such SIGBUSes by our test. On upstream kernel 5.=
7
> this behavior is still reproducible.
>=20
> So, we want to know, why this patchset wasn't merged to the upstream?
> Is there any problems in such rework for {soft,hard}-offline handling?

No technical reason, it's just because I didn't have enough power to push
this to be merged. Really sorry about that.

> BTW, this patchset should be updated with upstream changes in mm.

I'm working this now and still need more testing to confirm, but I hope
I'll update and post this for 5.9.

Thanks,
Naoya Horiguchi=

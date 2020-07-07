Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CB1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5209E206E9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=netapp.onmicrosoft.com header.i=@netapp.onmicrosoft.com header.b="l+wyqmZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgGGG44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:56:56 -0400
Received: from mail-bn8nam12on2042.outbound.protection.outlook.com ([40.107.237.42]:6186
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726788AbgGGG44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:56:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W63jdAroosjWIXatF7k8pysKPwjZG9685KHAyj19f1+1HKgtLD9DXwIwcnZnDw3PpakpE9bwIVS2Ortkqwjn+twaOHvRRHc1DazdSqvc78TLrhWNPGT3HaOZvBbory/I9Rw2VmaUhycyLQyW9z+xnDTboWv8GkBOx+dSSfWlxd2hvQBP4wS1IVpNW5r+SEu8Fcv5wCwJAgXb/P+Ea4THYwWfQnWYz6FpN4EThLL5z7RxEFeKGADJK/lorJMhNp053Qno9vRCogDXwzbYEJOwLquzohxInFiouIlTEVuLgaZHYsT0Nv4Evyudj8g3/M8i3220NrPMIPgY0gXX6OGBhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8J4jKPfdBgumrz2lYa9vQnsFXVuXz7mgTUHieXh7VQU=;
 b=JnxwjFBVLF+uRjHK83iUWcUlxklOYxs+b/XLptbc9kXPE8Hhf05k2vDyxoa090kUfpTMMgXmm8eSPEG0uhaynidxrJDEp2/WIZd/I8ZlNi/llziDuiqjovtnxJuKHd/7twUvZs5PyB8fDB+IkUiTbQIv2sC6NmTmSVHmC0DCCGTtHZOpdPT7blqdwlJe3IeRmnRSuZgSZYvYlAc07QKazFNQ7A9hKWWgqzNfERtyJd65KaON+kFNvTb0S0mFX189kIw2Idb7Sty562tk4u/F+vA37BHTxS1TIy/AUz3Idw2rErI0RdahdxLai2ErZKqVSW5S/OqhaaWPXhtRVJ4K+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=netapp.onmicrosoft.com; s=selector1-netapp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8J4jKPfdBgumrz2lYa9vQnsFXVuXz7mgTUHieXh7VQU=;
 b=l+wyqmZ6hA9Ag0GIOdNlo0UjhI+MS/E2zzpdU/mJkkx3XOVPuJFz9opSIIoHe0Gdzj882euMa112OSKQR9DwCISEj2jCr1+oJ9PXy709BqRis6cWfkaA05VRKMBhZUi+j6wSsePeo9esqhuWlB9QSnsDGMRp0hJEpb7Fqsf/k4s=
Received: from DM6PR06MB3836.namprd06.prod.outlook.com (2603:10b6:5:85::21) by
 DM6PR06MB5740.namprd06.prod.outlook.com (2603:10b6:5:1a6::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.20; Tue, 7 Jul 2020 06:56:53 +0000
Received: from DM6PR06MB3836.namprd06.prod.outlook.com
 ([fe80::dc64:4c7:1c5b:7e90]) by DM6PR06MB3836.namprd06.prod.outlook.com
 ([fe80::dc64:4c7:1c5b:7e90%6]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 06:56:53 +0000
From:   "Harrosh, Boaz" <Boaz.Harrosh@netapp.com>
To:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>
CC:     ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        Chris Mason <clm@fb.clm>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
Thread-Topic: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
Thread-Index: AQHWUkBlJd1sexqy50W93WQXawjffKj6wNEAgADhVoCAAAxEiw==
Date:   Tue, 7 Jul 2020 06:56:53 +0000
Message-ID: <DM6PR06MB3836FBAD65096AF63ACD3DB3EE660@DM6PR06MB3836.namprd06.prod.outlook.com>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CALCETrXewAK4_fpaJNDHJVDK9mUcjghA5HwYvZFQNYVfC9M+OQ@mail.gmail.com>,<202007062234.A90F922DF@keescook>
In-Reply-To: <202007062234.A90F922DF@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=netapp.com;
x-originating-ip: [2a00:a040:196:431d:6203:64fa:e313:fb47]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e8fa0c7-358d-420a-3d0d-08d82242ee58
x-ms-traffictypediagnostic: DM6PR06MB5740:
x-microsoft-antispam-prvs: <DM6PR06MB5740DB7F62008DEF823EB5AFEE660@DM6PR06MB5740.namprd06.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nUQknO2LLvTGT5HDR2LrfVgtotazj/hL84RC4aiESnR02O6r6PRPgJYLQiPyB6cV6dC5Z4CTuxqgU+7DjBXRP49rBcq0n0du56B5l+8S7QtpfiV5dtAt5MgR87+WuJke/L4vV9318ktciU3z/svn24Q5YpJuXjcT7ka91V1I4y6pLjTb3pPudJ+vUfdO0GjcvkTcW1ZL901x5QCOUtZBGJ1V0kZMbAkyp0cnOX4mJt6ISbVbamX8GGFOHzTdOcMK9lUVpDTDCodxz4BQmdji9MwNkTSZvTsB+JdCAlZGzBjXMZqLfbpeugDCWYmc8ioUJJnuKO0UnQh/sepxRKBtEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR06MB3836.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(7696005)(4326008)(9686003)(5660300002)(478600001)(71200400001)(186003)(6506007)(55016002)(52536014)(2906002)(8936002)(8676002)(54906003)(91956017)(86362001)(110136005)(66446008)(64756008)(66476007)(76116006)(316002)(33656002)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: GereuADuZgNsVLquMuAZyUnjpI2cOBgVIpplB6hmQIga7L5P4lpoEJ1oGQ8xich+BghQ2EXxuBbdjzVLCWzul6IL5DeBkP/+tssnxikNfPmK2vAbq990UBEYy1np/UF3/xSXwl1yB9jCpdqoh8fNnK3WzyTB3Q5R83zDppb6hMurmIzyUJ8rO/QzCs8g0/WX8ab5i7N6ENM/qPL9M15oW+bHuFO/aC1wINHuSlZni7Zx0L4oazu2aMo7CSiPIUljx1tNG1Fbn4BtDnqNpdXl0eg4oFyolcBT/6mu8vK8vvmQScoxqd6HRZuPW4uQusTrT1R7dc7I2lnUAikSjRJPj4xdVw0DL7FHetIFDgtSdVJ6XfclYnZAAFl5AUh3Pmc2Z++aNjN8nOrkYlO4/LRF+CbLiQHM+T04GTTi/bH+irY+qyLfGLw5SKKkUq8YNMPyVdAOnfy/aGdO9r7/tvqPThHvBMbIRYKvHzdqd5ZIfvAOJ6hGL7cxRBc9Sn9bqB7/PhA62WW0JZOzp6b+ZN8QBm2gIVZcFfiOMmlHCu0VmJ6BXKm6EfA+af1RWtE4kMst
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR06MB3836.namprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8fa0c7-358d-420a-3d0d-08d82242ee58
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 06:56:53.3272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YDGzrmEYiarlYFpye73Y05rK3pi5kONBuYBkh2mobCqJE4Sfn7pz38MjBYFRVoSBrCalvkW4O4a2NEbcsAHPOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB5740
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook wrote:=0A=
> I have struggled with this as well. The parts of speech change, and my=0A=
> grammar senses go weird. whitelist =3D adjective noun. allow-list =3D ver=
b=0A=
> noun. verbing the adj/noun combo feels okay, but verbing a verb/noun is=
=0A=
> weird.=0A=
=0A=
> And just using "allowed" and "denied" doesn't impart whether it refers=0A=
> to a _single_ instance or a _list_ of instances.=0A=
=0A=
> But that's all fine. The change is easy to do and is more descriptive=0A=
> even if I can't find terms that don't collide with my internal grammar=0A=
> checker. ;)=0A=
=0A=
But why. In English many times a verb when it comes before the noun means a=
n adjective, or an adjective like, describing some traits of the noun.=0A=
Example: =0A=
I work - work is a verb here.=0A=
I used the work bench. - Work is saying something about the type of bench, =
an adjective. Same as you would say "I used the green bench".=0A=
=0A=
I am not an English native at all but allow-list sounds totally English to =
me. (I guess the very correct English way is "allowed-list"  where the past=
 tense may convert the verb to a noun. but allow-list sounds very good to m=
e as well. Say work-list as opposed to vacation-list do you need to say wor=
ked-list? I don't think so.)=0A=
=0A=
run mate, running mate. cutting board. these are all examples of verbs used=
 as adjectives. Are they not English? What am I missing I would like to lea=
rn?=0A=
=0A=
Thanks=0A=
Boaz=0A=

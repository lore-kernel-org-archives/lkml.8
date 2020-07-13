Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909D9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 21:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 551782072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 21:51:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="OvP01AKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgGMVvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 17:51:16 -0400
Received: from mail-dm6nam10on2061.outbound.protection.outlook.com ([40.107.93.61]:23749
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726150AbgGMVvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 17:51:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZXlA0ArCxpxawgA5oVwx74Ew51ltpWGBNV4t6WNtNHPy/RiSoSG1jZkMB8We2mpaEMWw4M9AuYg6y9EL2xw4pXvZ/vy8xOuVG7+0Mn0hzMTapOn3uDrXI0EUjQUns+xLxl5BytDQGNV6MiTaeox4AioSyAs/H8Tj4vW2yDP03GtdME6AcbERjuJRgAERGgV6YqYYUsp/JyRjFS3jibdoG20a2Q2HTr7mJ4JlndjGYXk3nJ4zZmWLA+xbvBuxZnaFTsoxQWugQhUSocvekPFP4VEVSy1HVYDljpOhvRfSnj82VMymbNHTUE3q/rBlcpdVdPf+qMVYTxbhQL6fTa7+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNjED0GPrRv1JRMoh1DcgPJtSSA/Ww+9m5qGZN2x8eQ=;
 b=eOjXCiDYr9n2OD+B9Z7DP1M6jrFNjuEHJgd4y4jgioR5j6yYlwj5GUD7C3fifHFGnyrsERc5sFm58XL7jvLIkRAYpvYfeHUBkk3yx0T1Peoh0wK82KZuQ0Hyj/TtMSjTdq8SaJ0nLvD+EAGMJQY9FDEdZGAC+w4phef0FwNi6PTFi1scr7/YYoAZLuWk+NyEC47ZNqOJFYwhMGzSYA6yNCTEvYG++rV+bc5dfuyufSLCsjhs2QftMVeGWufV3vyYGlocOJEKxrHi1UTj6EdkEZSgm0Le9Q/1NMKOtAareLK6AwUlEavaIpvlwzY34MMtTdUkAAbpvqdMFdxmJFz01g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MNjED0GPrRv1JRMoh1DcgPJtSSA/Ww+9m5qGZN2x8eQ=;
 b=OvP01AKbdr1Lo4m7x9bRz9N7QPU8avfbjyZgayjGauxWCjsL8711d2l9fgPr8NrfbbVvlFJ/oT8bmp0RC4CMpa8wkmlT57g8XQJoRJuaJOsWhVQHG4lUThAbneD+ixVsOd+cRS6oY4J8llIh1usSPiPoInG6VWuThkQCZKf1MtA=
Received: from MWHPR1001MB2190.namprd10.prod.outlook.com
 (2603:10b6:301:2e::20) by MWHPR1001MB2222.namprd10.prod.outlook.com
 (2603:10b6:301:2d::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Mon, 13 Jul
 2020 21:51:11 +0000
Received: from MWHPR1001MB2190.namprd10.prod.outlook.com
 ([fe80::b439:ba0:98d6:c2d1]) by MWHPR1001MB2190.namprd10.prod.outlook.com
 ([fe80::b439:ba0:98d6:c2d1%5]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 21:51:11 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "richard.weinberger@gmail.com" <richard.weinberger@gmail.com>
CC:     "zhongjubin@huawei.com" <zhongjubin@huawei.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "qiuxi1@huawei.com" <qiuxi1@huawei.com>,
        "richard@nod.at" <richard@nod.at>,
        "wangfangpeng1@huawei.com" <wangfangpeng1@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "chenjie6@huawei.com" <chenjie6@huawei.com>,
        "lizhe67@huawei.com" <lizhe67@huawei.com>
Subject: Re: [PATCH] jffs2: fix UAF problem
Thread-Topic: [PATCH] jffs2: fix UAF problem
Thread-Index: AQHWRhkioXhOUXpJp0C2OVljdhi7G6joJxSAgBQb7gCAACilgIAJx5WA
Date:   Mon, 13 Jul 2020 21:51:10 +0000
Message-ID: <a42981ab23f75dcf5feddf6c8b50d3b44f749899.camel@infinera.com>
References: <20200619090635.58548-1-lizhe67@huawei.com>
         <e0d04d70ce674584a71af1a5a00984dd26729891.camel@infinera.com>
         <dadc539df01b17aa5dc85e7c0f1dbc83591667cc.camel@infinera.com>
         <CAFLxGvzP3AuZBJ3RugZiRTobxv3Z-kxYKnBUi0rfshwf7GuuCA@mail.gmail.com>
In-Reply-To: <CAFLxGvzP3AuZBJ3RugZiRTobxv3Z-kxYKnBUi0rfshwf7GuuCA@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.37.3 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=infinera.com;
x-originating-ip: [62.109.37.155]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c447148-16fa-43bd-278a-08d82776db44
x-ms-traffictypediagnostic: MWHPR1001MB2222:
x-microsoft-antispam-prvs: <MWHPR1001MB2222B08D40FD9F40D043A78EF4600@MWHPR1001MB2222.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qeSV3BpQAIpD0HWtCMQ+SXvLY0qwyDl68BAyYirhAVTNVh+aGJYYBL0UcG0dp4Vf0bKa1CTY+BNjOazdZ3qByVDUmgvigDJyMBen1g/5ZLL495LKvl5BlNb9Ba2TahtE6nur5pQcEnn3f5YVQqFxBGnCH46BxFkdW1b5HIE/uueUx2t5zWCmxcmZG8JFR1A9+b579nbmGEWTYE+/c4rqiLNPiTQwUu4q+I6N0fQrA506y6MURQkzTJqfuKJhkKZapIUcBaAmBIXWCYdHYVt0CZVoFsKtwtc1gm6Qm5Z3iaRCz5A4sGmSsWghRYtrKCfPU4bG5pcZjYdtyymkeov2LQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2190.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(7416002)(5660300002)(4744005)(86362001)(36756003)(66946007)(66476007)(66556008)(66446008)(64756008)(91956017)(76116006)(186003)(26005)(6486002)(2616005)(6916009)(71200400001)(2906002)(4326008)(478600001)(8676002)(6506007)(316002)(6512007)(54906003)(8936002)(53546011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: RlH2HDBApX21JnupmNHAq2BLKr9K7o964IQHLGeTQhjk9TuwTLxRP9ePzt3n+tW50CJ1HlfR38KEkOu5j0Gw0kvua+QRugFoyWzphh6IFGGUoPyxOqUZyfMcyIssrlpGfNlT6zXT/gKwCK71piUsAOw+BPkON4MA5NQjgfsjd5X4ESCtKvYNEjLasOZaY/+8wxqHcoH2q7DoxnyAckPv/vb4D9A89E+FWlKSY/DBLTF+88QotD5dbqg8S0mMq9xz3VgKQpu90YPEWNHhjtG2vYy+CfpOyNrJ+QitDq+Aq7wYOkK8t8lxgiU7GOfIcSDH2jLUa+sR76a8AzoOc5sPbDoBDE5W1Hga3yvjB97j5kWtvte/z2Ueg2+6ekqX0+GJumZ3dwHrZoeRWRt4nGpFHLoKDYkKkP6bd2YSqoMZJ96UTICHUMglE97PegOxTjUvkMDZZf5GhxmJhU0GP3nyrRlwCsd4tA0Q2Hjsy7uqisg=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <3A648F6980A4A34796ADD831A0BC1EB0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2190.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c447148-16fa-43bd-278a-08d82776db44
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2020 21:51:10.9087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8uEetPqCZUGMPfL8Pu5O4wiZ5HABBpkwWRZjkZNy3R70ae9QocdoWLPhA5OgketrCJRtdp6kp3OF/SppmRPRYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-07 at 18:30 +0200, Richard Weinberger wrote:
> CAUTION: This email originated from outside of the organization. Do
> not click links or open attachments unless you recognize the sender
> and know the content is safe.
>=20
>=20
> On Tue, Jul 7, 2020 at 4:08 PM Joakim Tjernlund
> <Joakim.Tjernlund@infinera.com> wrote:
> >=20
> > Maintainer ping ?
>=20
> Whoops. Applied for fixes.

Did you queue for stable too?
This bug has been there since day one for jffs2

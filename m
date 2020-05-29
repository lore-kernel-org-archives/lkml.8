Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A71C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93710207D3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbgE2ESz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 00:18:55 -0400
Received: from m17747.mail.qiye.163.com ([123.58.177.47]:42949 "EHLO
        m17747.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgE2ESy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 00:18:54 -0400
X-Greylist: delayed 504 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 May 2020 00:18:54 EDT
Received: from vivo.com (sdy-hm7.qy.internal [127.0.0.1])
        by m17747.mail.qiye.163.com (Hmail) with ESMTP id 5A6687C1731;
        Fri, 29 May 2020 12:10:27 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AJIAHAA7CLDayC1bgc0c0qq9.1.1590725427357.Hmail.zhucancan@vivo.com>
To:     lgirdwood <lgirdwood@gmail.com>, broonie <broonie@kernel.org>,
        perex <perex@perex.cz>, tiwai <tiwai@suse.com>,
        alsa-devel <alsa-devel@alsa-project.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     kernel <kernel@vivo.com>,
        =?UTF-8?B?5pyx54G/54G/?= <zhucancan@vivo.com>,
        trivial <trivial@kernel.org>
Subject: =?UTF-8?B?U3ViamVjdDogW1BBVENIXSBBU29DOiBzb2MtcGNtOiBmaXggQkUgZGFpIG5vdCBod19mcmVlIGFuZCBzaHV0ZG93biBkdXJpbmcgbWl4ZXIgdXBkYXRl?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.251.74.226
MIME-Version: 1.0
Received: from zhucancan@vivo.com( [58.251.74.226) ] by ajax-webmail ( [127.0.0.1] ) ; Fri, 29 May 2020 12:10:27 +0800 (GMT+08:00)
From:   zhucancan <zhucancan@vivo.com>
Date:   Fri, 29 May 2020 12:10:26 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VNS0JLS0tJS05CQkhNTllXWShZQU
        hPN1dZLVlBSVdZDwkaFQgSH1lBWRgxKzI4HDgzMzVPARJCOR40MBAtOjpWVlVKT0IoSVlXWQkOFx
        4IWUFZNTQpNjo3JCkuNz5ZV1kWGg8SFR0UWUFZNDBZBg++
X-HM-Sender-Digest: e1kMHhlZQQ8JDh5XWRIfHhUPWUFZRzoxMjozOjpMODc*GgI4ShkcGEsY
        SwoKQlVKVUpOQktMSU5PSUxPSkxVMxYaEhdVARMOGBoVGBoVOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlJTVlXWQgBWUFITUhNNwY+
X-HM-Tid: 0a725e9fc0af64a7kurs5a6687c1731
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RkUgc3RhdGUgaXMgU05EX1NPQ19EUENNX1NUQVRFX1BSRVBBUkUgbm93LCBCRTEgaXMNCnVzZWQg
YnkgRkUuDQoNCkxhdGVyIHdoZW4gbmV3IEJFMiBpcyBhZGRlZCB0byBGRSBieSBtaXhlciB1cGRh
dGUsDQppdCB3aWxsIGNhbGwgZHBjbV9ydW5fdXBkYXRlX3N0YXJ0dXAoKSB0byB1cGRhdGUNCkJF
MidzIHN0YXRlLCBidXQgdW5mb3J0dW5hdGVseSBCRTIgLnByZXBhcmUoKSBtZWV0cw0KZXJyb3Is
IGl0IHdpbGwgZGlzY29ubmVjdCBhbGwgbm9uIHN0YXJ0ZWQgQkUuDQoNClRoaXMgbWFrZSBCRTEg
ZGFpIHNraXAgLmh3X2ZyZWUoKSBhbmQgLnNodXRkb3duKCksDQphbmQgdGhlIEJFMSB1c2VycyB3
aWxsIG5ldmVyIGRlY3JlYXNlIHRvIHplcm8uDQoNClNpZ25lZC1vZmYtYnk6IHpodWNhbmNhbiA8
emh1Y2FuY2FuQHZpdm8uY29tPg0KLS0tDQogc291bmQvc29jL3NvYy1wY20uYyB8IDYgKysrLS0t
DQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL3NvdW5kL3NvYy9zb2MtcGNtLmMgYi9zb3VuZC9zb2Mvc29jLXBjbS5jDQppbmRl
eCAxZjMwMmRlNDQwNTIuLmRmMzQ0MjJiZDBkZCAxMDA2NDQNCi0tLSBhL3NvdW5kL3NvYy9zb2Mt
cGNtLmMNCisrKyBiL3NvdW5kL3NvYy9zb2MtcGNtLmMNCkBAIC0yNzMwLDEyICsyNzMwLDEyIEBA
IHN0YXRpYyBpbnQgZHBjbV9ydW5fdXBkYXRlX3N0YXJ0dXAoc3RydWN0IHNuZF9zb2NfcGNtX3J1
bnRpbWUgKmZlLCBpbnQgc3RyZWFtKQ0KIGNsb3NlOg0KICBkcGNtX2JlX2RhaV9zaHV0ZG93bihm
ZSwgc3RyZWFtKTsNCiBkaXNjb25uZWN0Og0KLSAvKiBkaXNjb25uZWN0IGFueSBub24gc3RhcnRl
ZCBCRXMgKi8NCisgLyogZGlzY29ubmVjdCBhbnkgY2xvc2VkIEJFcyAqLw0KICBzcGluX2xvY2tf
aXJxc2F2ZSgmZmUtPmNhcmQtPmRwY21fbG9jaywgZmxhZ3MpOw0KICBmb3JfZWFjaF9kcGNtX2Jl
KGZlLCBzdHJlYW0sIGRwY20pIHsNCiAgIHN0cnVjdCBzbmRfc29jX3BjbV9ydW50aW1lICpiZSA9
IGRwY20tPmJlOw0KLSAgaWYgKGJlLT5kcGNtW3N0cmVhbV0uc3RhdGUgIT0gU05EX1NPQ19EUENN
X1NUQVRFX1NUQVJUKQ0KLSAgICBkcGNtLT5zdGF0ZSA9IFNORF9TT0NfRFBDTV9MSU5LX1NUQVRF
X0ZSRUU7DQorICBpZiAoYmUtPmRwY21bc3RyZWFtXS5zdGF0ZSA9PSBTTkRfU09DX0RQQ01fU1RB
VEVfQ0xPU0UpDQorICAgZHBjbS0+c3RhdGUgPSBTTkRfU09DX0RQQ01fTElOS19TVEFURV9GUkVF
Ow0KICB9DQogIHNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmZlLT5jYXJkLT5kcGNtX2xvY2ssIGZs
YWdzKTsNCiANCi0tIA0KMi4yMS4wDQoNCg0KDQoyMDIwLTA1LTI5DQoNCnpodWNhbmNhbiANCg0K

Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8ECC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 10:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9C55207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 10:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgE2KTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 06:19:16 -0400
Received: from mail-m127107.qiye.163.com ([115.236.127.107]:28719 "EHLO
        mail-m127107.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE2KTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 06:19:15 -0400
X-Greylist: delayed 387 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 May 2020 06:19:13 EDT
Received: from vivo.com (wm-12.qy.internal [127.0.0.1])
        by mail-m127107.qiye.163.com (Hmail) with ESMTP id 306C28109C;
        Fri, 29 May 2020 18:12:44 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ALMAWwB5CP9aAcKXCU5FzqqF.1.1590747164172.Hmail.zhucancan@vivo.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     trivial@kernel.org, kernel <kernel@vivo.com>,
        zhucancan <zhucancan@vivo.com>,
        =?UTF-8?B?546L5paH6JmO?= <wenhu.wang@vivo.com>
Subject: =?UTF-8?B?U3ViamVjdDogW1BBVENIIHYyXSBBU29DOiBzb2MtcGNtOiBmaXggQkUgZGFpIG5vdCBod19mcmVlIGFuZCBzaHV0ZG93biBkdXJpbmcgbWl4ZXIgdXBkYXRl?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.251.74.226
MIME-Version: 1.0
Received: from zhucancan@vivo.com( [58.251.74.226) ] by ajax-webmail ( [127.0.0.1] ) ; Fri, 29 May 2020 18:12:44 +0800 (GMT+08:00)
From:   =?UTF-8?B?5pyx54G/54G/?= <zhucancan@vivo.com>
Date:   Fri, 29 May 2020 18:12:44 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VLTkNLS0tLQ0xMSENLT1lXWShZQU
        hPN1dZLVlBSVdZDwkaFQgSH1lBWRJOKzI4HDkjTigQGE81OR40LTIhOjpWVlVJSkMoSVlXWQkOFx
        4IWUFZNTQpNjo3JCkuNz5ZV1kWGg8SFR0UWUFZNDBZBg++
X-HM-Sender-Digest: e1kMHhlZQQ8JDh5XWRIfHhUPWUFZRzo3NjosDDlOOCtCGjoYMCM4Lk49
        AQoKPVVKVUpOQktMT0xKTU9JTkhVMxYaEhdVARMOGBoVGBoVOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlJTVlXWQgBWUFITkhNNwY+
X-HM-Tid: 0a725feb6e2d986bkuuu306c28109c
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RkUgc3RhdGUgaXMgU05EX1NPQ19EUENNX1NUQVRFX1BSRVBBUkUgbm93LCBCRTEgaXMKdXNlZCBi
eSBGRS4KCkxhdGVyIHdoZW4gbmV3IEJFMiBpcyBhZGRlZCB0byBGRSBieSBtaXhlciB1cGRhdGUs
Cml0IHdpbGwgY2FsbCBkcGNtX3J1bl91cGRhdGVfc3RhcnR1cCgpIHRvIHVwZGF0ZQpCRTIncyBz
dGF0ZSwgYnV0IHVuZm9ydHVuYXRlbHkgQkUyIC5wcmVwYXJlKCkgbWVldHMKZXJyb3IsIGl0IHdp
bGwgZGlzY29ubmVjdCBhbGwgbm9uIHN0YXJ0ZWQgQkUuCgpUaGlzIG1ha2UgQkUxIGRhaSBza2lw
IC5od19mcmVlKCkgYW5kIC5zaHV0ZG93bigpLAphbmQgdGhlIEJFMSB1c2VycyB3aWxsIG5ldmVy
IGRlY3JlYXNlIHRvIHplcm8uCgpTaWduZWQtb2ZmLWJ5OiB6aHVjYW5jYW4gPHpodWNhbmNhbkB2
aXZvLmNvbT4KLS0tCnJlLWZvcm1hdCBwYXRjaCBjb250ZW50IHYyCi0tLQogc291bmQvc29jL3Nv
Yy1wY20uYyB8IDYgKysrLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9zb2MtcGNtLmMgYi9zb3VuZC9zb2Mv
c29jLXBjbS5jCmluZGV4IDFmMzAyZGU0NDA1Mi4uZGYzNDQyMmJkMGRkIDEwMDY0NAotLS0gYS9z
b3VuZC9zb2Mvc29jLXBjbS5jCisrKyBiL3NvdW5kL3NvYy9zb2MtcGNtLmMKQEAgLTI3MzAsMTIg
KzI3MzAsMTIgQEAgc3RhdGljIGludCBkcGNtX3J1bl91cGRhdGVfc3RhcnR1cChzdHJ1Y3Qgc25k
X3NvY19wY21fcnVudGltZSAqZmUsIGludCBzdHJlYW0pCiBjbG9zZToKIAlkcGNtX2JlX2RhaV9z
aHV0ZG93bihmZSwgc3RyZWFtKTsKIGRpc2Nvbm5lY3Q6Ci0JLyogZGlzY29ubmVjdCBhbnkgbm9u
IHN0YXJ0ZWQgQkVzICovCisJLyogZGlzY29ubmVjdCBhbnkgY2xvc2VkIEJFcyAqLwogCXNwaW5f
bG9ja19pcnFzYXZlKCZmZS0+Y2FyZC0+ZHBjbV9sb2NrLCBmbGFncyk7CiAJZm9yX2VhY2hfZHBj
bV9iZShmZSwgc3RyZWFtLCBkcGNtKSB7CiAJCXN0cnVjdCBzbmRfc29jX3BjbV9ydW50aW1lICpi
ZSA9IGRwY20tPmJlOwotCQlpZiAoYmUtPmRwY21bc3RyZWFtXS5zdGF0ZSAhPSBTTkRfU09DX0RQ
Q01fU1RBVEVfU1RBUlQpCi0JCQkJZHBjbS0+c3RhdGUgPSBTTkRfU09DX0RQQ01fTElOS19TVEFU
RV9GUkVFOworCQlpZiAoYmUtPmRwY21bc3RyZWFtXS5zdGF0ZSA9PSBTTkRfU09DX0RQQ01fU1RB
VEVfQ0xPU0UpCisJCQlkcGNtLT5zdGF0ZSA9IFNORF9TT0NfRFBDTV9MSU5LX1NUQVRFX0ZSRUU7
CiAJfQogCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmZlLT5jYXJkLT5kcGNtX2xvY2ssIGZsYWdz
KTsKIAotLSAKMi4yMS4wCgoKCg0KDQo=

Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06830C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 05:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7B19207CD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 05:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgGCFUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 01:20:06 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:32944 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725764AbgGCFUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 01:20:06 -0400
Received: from dggemi404-hub.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id CF98FFEB8ECD8C0D6333;
        Fri,  3 Jul 2020 13:20:03 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.177]) by
 dggemi404-hub.china.huawei.com ([10.3.17.142]) with mapi id 14.03.0487.000;
 Fri, 3 Jul 2020 13:19:54 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     John Garry <john.garry@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>
Subject: RE: [PATCH v3] driver core: platform: expose numa_node to users in
 sysfs
Thread-Topic: [PATCH v3] driver core: platform: expose numa_node to users in
 sysfs
Thread-Index: AQHWReYTVpuuKIUXc0+/IcmdTQnez6jj830AgACHrdCAEOJqoA==
Date:   Fri, 3 Jul 2020 05:19:54 +0000
Message-ID: <B926444035E5E2439431908E3842AFD2552B4F@DGGEMI525-MBS.china.huawei.com>
References: <20200619030045.81956-1-song.bao.hua@hisilicon.com>
 <dc66d5a7-fa26-4c56-7445-57f99d3a5018@huawei.com> 
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.157]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IA0KPiBIb3dldmVyLCBpdCBpcyBzdGlsbCBtdWNoIG1vcmUgY2xlYXIgYW5kIGNyZWRpYmxl
IHRvIHVzZXJzIGJ5IGV4cG9zaW5nIHRoZSBkYXRhDQo+IGRpcmVjdGx5IGZyb20gQUNQSSB0YWJs
ZS4NCj4gDQoNCkV4Y2VwdCBBUk02NCBpb3J0LCBudW1hX25vZGUgaXMgYWN0dWFsbHkgYWxzbyBh
cHBsaWNhYmxlIHRvIHg4NiBhbmQgb3RoZXIgYXJjaGl0ZWN0dXJlcyB0aHJvdWdoIGdlbmVyYWwN
CmFjcGlfY3JlYXRlX3BsYXRmb3JtX2RldmljZSgpIEFQSToNCg0KZHJpdmVycy9hY3BpL3NjYW4u
YzoNCnN0YXRpYyB2b2lkIGFjcGlfZGVmYXVsdF9lbnVtZXJhdGlvbihzdHJ1Y3QgYWNwaV9kZXZp
Y2UgKmRldmljZSkNCnsNCgkuLi4NCglpZiAoIWRldmljZS0+ZmxhZ3MuZW51bWVyYXRpb25fYnlf
cGFyZW50KSB7DQoJCWFjcGlfY3JlYXRlX3BsYXRmb3JtX2RldmljZShkZXZpY2UsIE5VTEwpOw0K
CQlhY3BpX2RldmljZV9zZXRfZW51bWVyYXRlZChkZXZpY2UpOw0KCX0NCn0NCg0Kc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqYWNwaV9jcmVhdGVfcGxhdGZvcm1fZGV2aWNlKHN0cnVjdCBhY3BpX2Rl
dmljZSAqYWRldiwNCgkJCQkJc3RydWN0IHByb3BlcnR5X2VudHJ5ICpwcm9wZXJ0aWVzKQ0Kew0K
CS4uLg0KDQoJcGRldiA9IHBsYXRmb3JtX2RldmljZV9yZWdpc3Rlcl9mdWxsKCZwZGV2aW5mbyk7
DQoJaWYgKElTX0VSUihwZGV2KSkNCgkJZGV2X2VycigmYWRldi0+ZGV2LCAicGxhdGZvcm0gZGV2
aWNlIGNyZWF0aW9uIGZhaWxlZDogJWxkXG4iLA0KCQkJUFRSX0VSUihwZGV2KSk7DQoJZWxzZSB7
DQoJCXNldF9kZXZfbm9kZSgmcGRldi0+ZGV2LCBhY3BpX2dldF9ub2RlKGFkZXYtPmhhbmRsZSkp
Ow0KCQlkZXZfZGJnKCZhZGV2LT5kZXYsICJjcmVhdGVkIHBsYXRmb3JtIGRldmljZSAlc1xuIiwN
CgkJCWRldl9uYW1lKCZwZGV2LT5kZXYpKTsNCgl9DQoNCgkuLi4NCg0KCXJldHVybiBwZGV2Ow0K
fQ0KDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4gSm9obg0KDQpUaGFua3MNCkJhcnJ5DQoNCg0K

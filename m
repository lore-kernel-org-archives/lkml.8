Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D984C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 05:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA0A020772
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 05:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="HZrNFt0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgGGFbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 01:31:46 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:7590 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726889AbgGGFbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 01:31:45 -0400
X-UUID: cfbde1c3c24641f794aedd704777a07c-20200707
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=QHbkWGB6AYr/otqaU50brYqQUJizQSU9qyIN4GtkzDg=;
        b=HZrNFt0QpmEcTcwk3dctytFB7Ysd1tNRcGOL5AYYCkhG8TSg+4ioB81h9L/VtfD6ebSde7vh7uN55RH6AoewtEzlFBFgyWVXIvcF6wcbjkce9sDzFpKY/f1q8FMqSvr0D29ZHSP3IKjlqT9CufY8SsyVy+pFN3NPe2nkpjevOIA=;
X-UUID: cfbde1c3c24641f794aedd704777a07c-20200707
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chinwen.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1227173683; Tue, 07 Jul 2020 13:31:42 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 7 Jul 2020 13:31:36 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 7 Jul 2020 13:31:36 +0800
Message-ID: <1594099897.30360.58.camel@mtkswgap22>
Subject: Re: [PATCH v12 00/31] Speculative page faults
From:   Chinwen Chang <chinwen.chang@mediatek.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>
CC:     Haiyan Song <haiyanx.song@intel.com>, <akpm@linux-foundation.org>,
        <mhocko@kernel.org>, <peterz@infradead.org>,
        <kirill@shutemov.name>, <ak@linux.intel.com>, <dave@stgolabs.net>,
        <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        <aneesh.kumar@linux.ibm.com>, <benh@kernel.crashing.org>,
        <mpe@ellerman.id.au>, <paulus@samba.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, <hpa@zytor.com>,
        Will Deacon <will.deacon@arm.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        <sergey.senozhatsky.work@gmail.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        <kemi.wang@intel.com>, Daniel Jordan <daniel.m.jordan@oracle.com>,
        David Rientjes <rientjes@google.com>,
        "Jerome Glisse" <jglisse@redhat.com>,
        Ganesh Mahendran <opensource.ganesh@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        "Punit Agrawal" <punitagrawal@gmail.com>,
        vinayak menon <vinayakm.list@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        zhong jiang <zhongjiang@huawei.com>,
        Balbir Singh <bsingharora@gmail.com>, <sj38.park@gmail.com>,
        "Michel Lespinasse" <walken@google.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <haren@linux.vnet.ibm.com>, <npiggin@gmail.com>,
        <paulmck@linux.vnet.ibm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        <linuxppc-dev@lists.ozlabs.org>, <x86@kernel.org>,
        <miles.chen@mediatek.com>
Date:   Tue, 7 Jul 2020 13:31:37 +0800
In-Reply-To: <490c0811-50cd-0802-2cbc-9c031ef309f6@linux.ibm.com>
References: <20190416134522.17540-1-ldufour@linux.ibm.com>
         <20190606065129.d5s3534p23twksgp@haiyan.sh.intel.com>
         <3d3cefa2-0ebb-e86d-b060-7ba67c48a59f@linux.ibm.com>
         <1c412ebe-c213-ee67-d261-c70ddcd34b79@linux.ibm.com>
         <20190620081945.hwj6ruqddefnxg6z@haiyan.sh.intel.com>
         <1594027500.30360.32.camel@mtkswgap22>
         <490c0811-50cd-0802-2cbc-9c031ef309f6@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: BD21DAF844DD646E121434B7D084E5A7BA97FF2EEB9E645A621535C561C7DB242000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA3LTA2IGF0IDE0OjI3ICswMjAwLCBMYXVyZW50IER1Zm91ciB3cm90ZToN
Cj4gTGUgMDYvMDcvMjAyMCDDoCAxMToyNSwgQ2hpbndlbiBDaGFuZyBhIMOpY3JpdCA6DQo+ID4g
T24gVGh1LCAyMDE5LTA2LTIwIGF0IDE2OjE5ICswODAwLCBIYWl5YW4gU29uZyB3cm90ZToNCj4g
Pj4gSGkgTGF1cmVudCwNCj4gPj4NCj4gPj4gSSBkb3dubG9hZGVkIHlvdXIgc2NyaXB0IGFuZCBy
dW4gaXQgb24gSW50ZWwgMnMgc2t5bGFrZSBwbGF0Zm9ybSB3aXRoIHNwZi12MTIgcGF0Y2gNCj4g
Pj4gc2VyaWFscy4NCj4gPj4NCj4gPj4gSGVyZSBhdHRhY2hlZCB0aGUgb3V0cHV0IHJlc3VsdHMg
b2YgdGhpcyBzY3JpcHQuDQo+ID4+DQo+ID4+IFRoZSBmb2xsb3dpbmcgY29tcGFyaXNvbiByZXN1
bHQgaXMgc3RhdGlzdGljcyBmcm9tIHRoZSBzY3JpcHQgb3V0cHV0cy4NCj4gPj4NCj4gPj4gYSku
IEVuYWJsZSBUSFANCj4gPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgU1BGXzAgICAgICAgICAgY2hhbmdlICAgICAgIFNQRl8xDQo+ID4+IHdpbGwtaXQtc2Nh
bGUucGFnZV9mYXVsdDIucGVyX3RocmVhZF9vcHMgICAgMjY2NDE5MC44ICAgICAgLTExLjclICAg
ICAgIDIzNTM2MzcuNg0KPiA+PiB3aWxsLWl0LXNjYWxlLnBhZ2VfZmF1bHQzLnBlcl90aHJlYWRf
b3BzICAgIDQ0ODAwMjcuMiAgICAgIC0xNC43JSAgICAgICAzODE5MzMxLjkNCj4gPj4NCj4gPj4N
Cj4gPj4gYikuIERpc2FibGUgVEhQDQo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFNQRl8wICAgICAgICAgICBjaGFuZ2UgICAgICBTUEZfMQ0KPiA+PiB3
aWxsLWl0LXNjYWxlLnBhZ2VfZmF1bHQyLnBlcl90aHJlYWRfb3BzICAgIDI2NTMyNjAuNyAgICAg
ICAtMTAlICAgICAgICAyMzg1MTY1LjgNCj4gPj4gd2lsbC1pdC1zY2FsZS5wYWdlX2ZhdWx0My5w
ZXJfdGhyZWFkX29wcyAgICA0NDM2MzMwLjEgICAgICAgLTEyLjQlICAgICAgMzg4NjczNC4yDQo+
ID4+DQo+ID4+DQo+ID4+IFRoYW5rcywNCj4gPj4gSGFpeWFuIFNvbmcNCj4gPj4NCj4gPj4NCj4g
Pj4gT24gRnJpLCBKdW4gMTQsIDIwMTkgYXQgMTA6NDQ6NDdBTSArMDIwMCwgTGF1cmVudCBEdWZv
dXIgd3JvdGU6DQo+ID4+PiBMZSAxNC8wNi8yMDE5IMOgIDEwOjM3LCBMYXVyZW50IER1Zm91ciBh
IMOpY3JpdCA6DQo+ID4+Pj4gUGxlYXNlIGZpbmQgYXR0YWNoZWQgdGhlIHNjcmlwdCBJIHJ1biB0
byBnZXQgdGhlc2UgbnVtYmVycy4NCj4gPj4+PiBUaGlzIHdvdWxkIGJlIG5pY2UgaWYgeW91IGNv
dWxkIGdpdmUgaXQgYSB0cnkgb24geW91ciB2aWN0aW0gbm9kZSBhbmQgc2hhcmUgdGhlIHJlc3Vs
dC4NCj4gPj4+DQo+ID4+PiBTb3VuZHMgdGhhdCB0aGUgSW50ZWwgbWFpbCBmaXRlcmluZyBzeXN0
ZW0gZG9lc24ndCBsaWtlIHRoZSBhdHRhY2hlZCBzaGVsbCBzY3JpcHQuDQo+ID4+PiBQbGVhc2Ug
ZmluZCBpdCB0aGVyZTogaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZ2lzdC5n
aXRodWIuY29tL2xkdTQvYTVjYzFhOTNmMjkzMTA4ZWEzODdkNDNkNWQ1ZTdmNDRfXzshIUNUUk5L
QTl3TWcwQVJidyEwbHV4MkZNQ2JJRnhGRWw4MjRDZFN1U1FxVDBJVldzdnlVcWZEVkpORVZiOWdU
V3lSbHRtN2NwUFpnNzBOX1hoWG1NWiQgDQo+ID4+Pg0KPiA+Pj4gVGhhbmtzLA0KPiA+Pj4gTGF1
cmVudC4NCj4gPj4+DQo+ID4gDQo+ID4gSGkgTGF1cmVudCwNCj4gPiANCj4gPiBXZSBtZXJnZWQg
U1BGIHYxMSBhbmQgc29tZSBwYXRjaGVzIGZyb20gdjEyIGludG8gb3VyIHBsYXRmb3Jtcy4gQWZ0
ZXINCj4gPiBzZXZlcmFsIGV4cGVyaW1lbnRzLCB3ZSBvYnNlcnZlZCBTUEYgaGFzIG9idmlvdXMg
aW1wcm92ZW1lbnRzIG9uIHRoZQ0KPiA+IGxhdW5jaCB0aW1lIG9mIGFwcGxpY2F0aW9ucywgZXNw
ZWNpYWxseSBmb3IgdGhvc2UgaGlnaC1UTFAgb25lcywNCj4gPiANCj4gPiAjIGxhdW5jaCB0aW1l
IG9mIGFwcGxpY2F0aW9ucyhzKToNCj4gPiANCj4gPiBwYWNrYWdlICAgICAgICAgICB2ZXJzaW9u
ICAgICAgdy8gU1BGICAgICAgdy9vIFNQRiAgICAgIGltcHJvdmUoJSkNCj4gPiAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
Cj4gPiBCYWlkdSBtYXBzICAgICAgICAxMC4xMy4zICAgICAgMC44ODcgICAgICAgMC45OCAgICAg
ICAgIDkuNDkNCj4gPiBUYW9iYW8gICAgICAgICAgICA4LjQuMC4zNSAgICAgMS4yMjcgICAgICAg
MS4yOTMgICAgICAgIDUuMTANCj4gPiBNZWl0dWFuICAgICAgICAgICA5LjEyLjQwMSAgICAgMS4x
MDcgICAgICAgMS41NDMgICAgICAgIDI4LjI2DQo+ID4gV2VDaGF0ICAgICAgICAgICAgNy4wLjMg
ICAgICAgIDIuMzUzICAgICAgIDIuNjggICAgICAgICAxMi4yMA0KPiA+IEhvbm9yIG9mIEtpbmdz
ICAgIDEuNDMuMS42ICAgICA2LjYzICAgICAgICA2LjcxMyAgICAgICAgMS4yNA0KPiANCj4gVGhh
dCdzIGdyZWF0IG5ld3MsIHRoYW5rcyBmb3IgcmVwb3J0aW5nIHRoaXMhDQo+IA0KPiA+IA0KPiA+
IEJ5IHRoZSB3YXksIHdlIGhhdmUgdmVyaWZpZWQgb3VyIHBsYXRmb3JtcyB3aXRoIHRob3NlIHBh
dGNoZXMgYW5kDQo+ID4gYWNoaWV2ZWQgdGhlIGdvYWwgb2YgbWFzcyBwcm9kdWN0aW9uLg0KPiAN
Cj4gQW5vdGhlciBnb29kIG5ld3MhDQo+IEZvciBteSBpbmZvcm1hdGlvbiwgd2hhdCBpcyB5b3Vy
IHRhcmdldGVkIGhhcmR3YXJlPw0KPiANCj4gQ2hlZXJzLA0KPiBMYXVyZW50Lg0KDQpIaSBMYXVy
ZW50LA0KDQpPdXIgdGFyZ2V0ZWQgaGFyZHdhcmUgYmVsb25ncyB0byBBUk02NCBtdWx0aS1jb3Jl
IHNlcmllcy4NCg0KVGhhbmtzLg0KQ2hpbndlbg0KPiANCg0K


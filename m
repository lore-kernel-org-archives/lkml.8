Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4424CC4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 07:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0181720658
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 07:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgCUHkt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 03:40:49 -0400
Received: from m213143.mail.qiye.163.com ([223.252.213.143]:55872 "EHLO
        m213143.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbgCUHkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 03:40:49 -0400
Received: from vivo.com (wm-7 [127.0.0.1])
        by m213143.mail.qiye.163.com (Hmail) with ESMTP id 332BD5814F8;
        Sat, 21 Mar 2020 15:40:15 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AAcAiQCjCGSRNYLoGw6Zkqov.3.1584776415192.Hmail.wenhu.wang@vivo.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@vivo.com
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSCB2MixSRVNFTkRdIGRvYzogemhfQ046IGZpeCBzdHlsZSBwcm9ibGVtcyBmb3IgaW9fb3JkZXJpbmcudHh0?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.251.74.227
In-Reply-To: <20200320172426.121d881d@lwn.net>
MIME-Version: 1.0
Received: from wenhu.wang@vivo.com( [58.251.74.227) ] by ajax-webmail ( [127.0.0.1] ) ; Sat, 21 Mar 2020 15:40:15 +0800 (GMT+08:00)
From:   =?UTF-8?B?546L5paH6JmO?= <wenhu.wang@vivo.com>
Date:   Sat, 21 Mar 2020 15:40:15 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVDTUtLS0tKSEhOSk9PWVdZKFlBSE
        83V1ktWUFJV1kJDhceCFlBWTU0KTY6NyQpLjc#WQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhNTEJNTEJCSUpDN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6Ohg6Eio4ETg8KCk1IjcUPAxNIRAKFA1VSFVKTkNPTExNT0pMTUpLVTMWGhIXVQweFRMOVQwa
        FRw7DRINFFUYFBZFWVdZEgtZQVlOQ1VJTkpVTE9VSUlMWVdZCAFZQU5CSkI3Bg++
X-HM-Tid: 0a70fc0907f27f7bkuuk332bd5814f8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogSm9uYXRoYW4gQ29yYmV0IDxjb3JiZXRAbHduLm5ldD4KRGF0ZTogMjAyMC0wMy0yMSAw
NzoyNDoyNgpUbzogIFdhbmcgV2VuaHUgPHdlbmh1LndhbmdAdml2by5jb20+CkNjOiAgSGFycnkg
V2VpIDxoYXJyeXhpeW91QGdtYWlsLmNvbT4sQWxleCBTaGkgPGFsZXguc2hpQGxpbnV4LmFsaWJh
YmEuY29tPixsaW51eC1kb2NAdmdlci5rZXJuZWwub3JnLGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcsa2VybmVsQHZpdm8uY29tClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjIsUkVTRU5EXSBkb2M6
IHpoX0NOOiBmaXggc3R5bGUgcHJvYmxlbXMgZm9yIGlvX29yZGVyaW5nLnR4dD5PbiBTYXQsIDE0
IE1hciAyMDIwIDIzOjA4OjU1IC0wNzAwCj5XYW5nIFdlbmh1IDx3ZW5odS53YW5nQHZpdm8uY29t
PiB3cm90ZToKPgo+PiBQcm9ibGVtcyBleGlzdCBpbiB0aGUgQ2hpbmVzZSB0cmFuc2xhdGlvbiBv
ZiBpb19vcmRlcmluZy50eHQuCj4+IFBhcnRseSBmb3IgdGhlIGRpZmZlcmVuY2UgYmV0d2VlbiBD
aGluZXNlIGFuZCBFbmdsaXNoIGNoYXJhY3Rlcgo+PiBlbmNvZGluZyBmb3JtYXQsIGFuZCB0aGUg
b3RoZXJzIGFyZSBvZiB0aGUgZmFpbHVyZSB0byBjb21wbHkKPj4gd2l0aCB0aGUgUmVTVCBtYXJr
dXBzLgo+Cj5TbyBJIGZlZWwgbGlrZSBJJ20gbWlzc2luZyBzb21ldGhpbmcgaGVyZS4uLgpTb21l
IHN0eWxlIG1vZGlmaWNhdGlvbiwgc3VjaCBhcyAiOjoiIGZpZWxkIGFkZGVkIHdpdGhpbiBhIG5l
d2xpbmUgaW5kaWNhdGluZwpzdGFydCBvZiBhIGJsb2NrLiBCZWNhdXNlIG9mIHRoZSBkaWZmZXJl
bmNlIGJldHdlZW4gZW5jb2Rpbmcgb2YgQ2hpbmVzZSBhbmQKRW5nbGlzaCwgaXQgZGlkIG5vdCB3
b3JrIHdlbGwgZm9yIENoaW5lc2UgdG8ganVzdCBwdXQgaXQgYWZ0ZXIgc29tZSBDaGluZXNlCmNo
YXJhY3RlcnMgd2l0aGluIHRoZSBzYW1lIGxpbmUuCgpUaGUgZmlsZSBpcyBjdXJyZW50bHkgYSB0
eHQgZmlsZShub25lIHJzdCksIHNvIGl0J3MgT0sganVzdCBpZ25vcmUgdGhlIG1vZGlmYWN0aW9u
cy4KPgo+PiBTaWduZWQtb2ZmLWJ5OiBXYW5nIFdlbmh1IDx3ZW5odS53YW5nQHZpdm8uY29tPgo+
PiAtLS0KPj4gdjI6IHJlc2VuZCBmb3IgdGhlIGZhaWx1cmUgb2YgZGVsaXZlcmluZy4KPj4gCj4+
ICAuLi4vdHJhbnNsYXRpb25zL3poX0NOL2lvX29yZGVyaW5nLnR4dCAgICAgICAgfCA3MiArKysr
KysrKysrKystLS0tLS0tCj4+ICAxIGZpbGUgY2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygrKSwgMjYg
ZGVsZXRpb25zKC0pCj4+IAo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlv
bnMvemhfQ04vaW9fb3JkZXJpbmcudHh0IGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhf
Q04vaW9fb3JkZXJpbmcudHh0Cj4+IGluZGV4IDFmODEyN2JkZDQxNS4uMDgwZWQyOTExZGIwIDEw
MDY0NAo+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL3RyYW5zbGF0aW9ucy96aF9DTi9pb19vcmRlcmlu
Zy50eHQKPj4gKysrIGIvRG9jdW1lbnRhdGlvbi90cmFuc2xhdGlvbnMvemhfQ04vaW9fb3JkZXJp
bmcudHh0Cj4+IEBAIC0yOSwzOSArMjksNTkgQEAgRG9jdW1lbnRhdGlvbi9pb19vcmRlcmluZy50
eHQg55qE5Lit5paH57+76K+RCj4+ICDov5nkuZ/lj6/ku6Xkv53or4HlkI7pnaLnmoTlhpnmk43k
vZzlj6rlnKjliY3pnaLnmoTlhpnmk43kvZzkuYvlkI7liLDovr7orr7lpIfvvIjov5npnZ7luLjn
sbvkvLzkuo7lhoXlrZgKPj4gIOWxj+manOaTjeS9nO+8jG1iKCnvvIzkuI3ov4fku4XpgILnlKjk
uo5JL0/vvInjgIIKPj4gIAo+PiArQSBtb3JlIGNvbmNyZXRlIGV4YW1wbGUgZnJvbSBhIGh5cG90
aGV0aWNhbCBkZXZpY2UgZHJpdmVyOjoKPj4gKwo+PiArCQkuLi4KPj4gKwlDUFUgQTogIHNwaW5f
bG9ja19pcnFzYXZlKCZkZXZfbG9jaywgZmxhZ3MpCj4+ICsJQ1BVIEE6ICB2YWwgPSByZWFkbCht
eV9zdGF0dXMpOwo+PiArCUNQVSBBOiAgLi4uCj4+ICsJQ1BVIEE6ICB3cml0ZWwobmV3dmFsLCBy
aW5nX3B0cik7Cj4+ICsJQ1BVIEE6ICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkZXZfbG9jaywg
ZmxhZ3MpCj4+ICsJCS4uLgo+PiArCUNQVSBCOiAgc3Bpbl9sb2NrX2lycXNhdmUoJmRldl9sb2Nr
LCBmbGFncykKPj4gKwlDUFUgQjogIHZhbCA9IHJlYWRsKG15X3N0YXR1cyk7Cj4+ICsJQ1BVIEI6
ICAuLi4KPj4gKwlDUFUgQjogIHdyaXRlbChuZXd2YWwyLCByaW5nX3B0cik7Cj4+ICsJQ1BVIEI6
ICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkZXZfbG9jaywgZmxhZ3MpCj4+ICsJCS4uLgo+PiAr
Cj4+ICsKPj4gIOWBh+iuvuS4gOS4quiuvuWkh+mpseWKqOeoi+eahOWFt+S9k+S+i+WtkO+8mgo+
PiArOjoKPj4gIAo+PiArCQkuLi4KPj4gKwlDUFUgQTogIHNwaW5fbG9ja19pcnFzYXZlKCZkZXZf
bG9jaywgZmxhZ3MpCj4+ICsJQ1BVIEE6ICB2YWwgPSByZWFkbChteV9zdGF0dXMpOwo+PiArCUNQ
VSBBOiAgLi4uCj4+ICsJQ1BVIEE6ICB3cml0ZWwobmV3dmFsLCByaW5nX3B0cik7Cj4+ICsJQ1BV
IEE6ICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkZXZfbG9jaywgZmxhZ3MpCj4+ICsJCS4uLgo+
PiArCUNQVSBCOiAgc3Bpbl9sb2NrX2lycXNhdmUoJmRldl9sb2NrLCBmbGFncykKPj4gKwlDUFUg
QjogIHZhbCA9IHJlYWRsKG15X3N0YXR1cyk7Cj4+ICsJQ1BVIEI6ICAuLi4KPj4gKwlDUFUgQjog
IHdyaXRlbChuZXd2YWwyLCByaW5nX3B0cik7Cj4+ICsJQ1BVIEI6ICBzcGluX3VubG9ja19pcnFy
ZXN0b3JlKCZkZXZfbG9jaywgZmxhZ3MpCj4KPkl0IHN1cmUgbG9va3MgbGlrZSB5b3UncmUgYWRk
aW5nIHRoZSBzYW1lIHRleHQgdHdpY2UgaGVyZS4uLj8KQXMgSSBtZW50aW9uZWQgYmVsb3cgdGhl
IHNpZ24tb2ZmIGFyZWEsIGRlbGl2ZXJ5IGZhaWx1cmUgaGFwcGVuZWQgc28KdGhpcyBpcyBqdXN0
IGEgcmVzZW50IHZlcnNpb24uCj4KPlRoYW5rcywKPgo+am9uCj4KDQoNCg==

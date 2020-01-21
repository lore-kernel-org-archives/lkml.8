Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1731EC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 06:46:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84D624653
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 06:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgAUGqz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 01:46:55 -0500
Received: from m176151.mail.qiye.163.com ([59.111.176.151]:48914 "EHLO
        m176151.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUGqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 01:46:55 -0500
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Jan 2020 01:46:52 EST
Received: from vivo.com (wm-11.qy.internal [127.0.0.1])
        by m176151.mail.qiye.163.com (Hmail) with ESMTP id BF62C482986;
        Tue, 21 Jan 2020 14:38:24 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AFEA1QBVCHZojVUNOs1Cfqrs.3.1579588704764.Hmail.wenhu.wang@vivo.com>
To:     Scott Wood <oss@buserror.net>
Cc:     wangwenhu <wenhu.pku@gmail.com>,
        Kumar Gala <galak@kernel.crashing.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org, Rai Harninder <harninder.rai@nxp.com>
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gcG93ZXJwYy9LY29uZmlnOiBNYWtlIEZTTF84NVhYX0NBQ0hFX1NSQU0gY29uZmlndXJhYmxl?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.251.74.226
In-Reply-To: <0948b2f469c5e9d9241477e7f0cba677bbcd1780.camel@buserror.net>
MIME-Version: 1.0
Received: from wenhu.wang@vivo.com( [58.251.74.226) ] by ajax-webmail ( [127.0.0.1] ) ; Tue, 21 Jan 2020 14:38:24 +0800 (GMT+08:00)
From:   =?UTF-8?B?546L5paH6JmO?= <wenhu.wang@vivo.com>
Date:   Tue, 21 Jan 2020 14:38:24 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VNSkxLS0tKS0lCQk1DSFlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhNSktCT01PT0tCN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6PT46Sio5LTgzIRQRLS41NAhKOB0KCQhVSFVKTkxCTkNDTEtMSktDVTMWGhIXVQweFRMOVQwa
        FRw7DRINFFUYFBZFWVdZEgtZQVlOQ1VJTkpVTE9VSUlNWVdZCAFZQU1DSEw3Bg++
X-HM-Tid: 0a6fc6d2da1693b5kuwsbf62c482986
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5Y+R5Lu25Lq677yaU2NvdHQgV29vZCA8b3NzQGJ1c2Vycm9yLm5ldD4K5Y+R6YCB5pel5pyf77ya
MjAyMC0wMS0yMSAxMzo0OTo1OQrmlLbku7bkurrvvJoi546L5paH6JmOIiA8d2VuaHUud2FuZ0B2
aXZvLmNvbT4K5oqE6YCB5Lq677yad2FuZ3dlbmh1IDx3ZW5odS5wa3VAZ21haWwuY29tPixLdW1h
ciBHYWxhIDxnYWxha0BrZXJuZWwuY3Jhc2hpbmcub3JnPixCZW5qYW1pbiBIZXJyZW5zY2htaWR0
IDxiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc+LFBhdWwgTWFja2VycmFzIDxwYXVsdXNAc2FtYmEu
b3JnPixNaWNoYWVsIEVsbGVybWFuIDxtcGVAZWxsZXJtYW4uaWQuYXU+LGxpbnV4cHBjLWRldkBs
aXN0cy5vemxhYnMub3JnLGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcsdHJpdmlhbEBrZXJu
ZWwub3JnLFJhaSBIYXJuaW5kZXIgPGhhcm5pbmRlci5yYWlAbnhwLmNvbT4K5Li76aKY77yaUmU6
IFtQQVRDSF0gcG93ZXJwYy9LY29uZmlnOiBNYWtlIEZTTF84NVhYX0NBQ0hFX1NSQU0gY29uZmln
dXJhYmxlPk9uIFR1ZSwgMjAyMC0wMS0yMSBhdCAxMzoyMCArMDgwMCwg546L5paH6JmOIHdyb3Rl
Ogo+PiBGcm9tOiBTY290dCBXb29kIDxvc3NAYnVzZXJyb3IubmV0Pgo+PiBEYXRlOiAyMDIwLTAx
LTIxIDExOjI1OjI1Cj4+IFRvOiAgd2FuZ3dlbmh1IDx3ZW5odS5wa3VAZ21haWwuY29tPixLdW1h
ciBHYWxhIDxnYWxha0BrZXJuZWwuY3Jhc2hpbmcub3JnPiwKPj4gQmVuamFtaW4gSGVycmVuc2No
bWlkdCA8YmVuaEBrZXJuZWwuY3Jhc2hpbmcub3JnPixQYXVsIE1hY2tlcnJhcyA8Cj4+IHBhdWx1
c0BzYW1iYS5vcmc+LE1pY2hhZWwgRWxsZXJtYW4gPG1wZUBlbGxlcm1hbi5pZC5hdT4sCj4+IGxp
bnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnLGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcK
Pj4gQ2M6ICB0cml2aWFsQGtlcm5lbC5vcmcsd2VuaHUud2FuZ0B2aXZvLmNvbSxSYWkgSGFybmlu
ZGVyIDwKPj4gaGFybmluZGVyLnJhaUBueHAuY29tPgo+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBw
b3dlcnBjL0tjb25maWc6IE1ha2UgRlNMXzg1WFhfQ0FDSEVfU1JBTQo+PiBjb25maWd1cmFibGU+
T24gTW9uLCAyMDIwLTAxLTIwIGF0IDA2OjQzIC0wODAwLCB3YW5nd2VuaHUgd3JvdGU6Cj4+ID4g
PiBGcm9tOiB3YW5nd2VuaHUgPHdlbmh1LndhbmdAdml2by5jb20+Cj4+ID4gPiAKPj4gPiA+IFdo
ZW4gZ2VuZXJhdGluZyAuY29uZmlnIGZpbGUgd2l0aCBtZW51Y29uZmlnIG9uIEZyZWVzY2FsZSBC
T09LRQo+PiA+ID4gU09DLCBGU0xfODVYWF9DQUNIRV9TUkFNIGlzIG5vdCBjb25maWd1cmFibGUg
Zm9yIHRoZSBsYWNrIG9mCj4+ID4gPiBkZXNjcmlwdGlvbiBpbiB0aGUgS2NvbmZpZyBmaWVsZCwg
d2hpY2ggbWFrZXMgaXQgaW1wb3NzaWJsZQo+PiA+ID4gdG8gc3VwcG9ydCBMMkNhY2hlLVNyYW0g
ZHJpdmVyLiBBZGQgYSBkZXNjcmlwdGlvbiB0byBtYWtlIGl0Cj4+ID4gPiBjb25maWd1cmFibGUu
Cj4+ID4gPiAKPj4gPiA+IFNpZ25lZC1vZmYtYnk6IHdhbmd3ZW5odSA8d2VuaHUud2FuZ0B2aXZv
LmNvbT4KPj4gPiAKPj4gPiBUaGUgaW50ZW50IHdhcyB0aGF0IGRyaXZlcnMgdXNpbmcgdGhlIFNS
QU0gQVBJIHdvdWxkIHNlbGVjdCB0aGUKPj4gPiBzeW1ib2wuICBXaGF0Cj4+ID4gaXMgdGhlIHVz
ZSBjYXNlIGZvciBzZWxlY3RpbmcgaXQgbWFudWFsbHk/Cj4+ID4gCj4+IAo+PiBXaXRoIGEgcmVw
b3NpdG9yeSBvZiBtdWx0aXBsZSBwcm9kdWN0cyhtZWFuaW5nIGRpZmZlcmVudCBkZWZjb25maWdz
KSBhbmQKPj4gbXVsdGlwbGUKPj4gZGV2ZWxvcGVycywgdGhlIEtjb25maWdzIG9mIHRoZSBLZXJu
ZWwgU291cmNlIFRyZWUgY2hhbmdlIGZyZXF1ZW50bHkuIFNvIHRoZQo+PiAibWFrZSBtZW51Y29u
ZmlnIgo+PiBwcm9jZXNzIGlzIG5lZWRlZCBmb3IgZGVmY29uZmlncycgcmUtZ2VuZXJhdGluZyBv
ciB1cGRhdGluZyBmb3IgdGhlCj4+IGNvbXBsZXhpdHkgb2YgZGVwZW5kZW5jaWVzCj4+IGJldHdl
ZW4gZGlmZmVyZW50IGZlYXR1cmVzIGRlZmluZWQgaW4gdGhlIEtjb25maWdzLgo+Cj5UaGF0IGRv
ZXNuJ3QgYW5zd2VyIG15IHF1ZXN0aW9uIG9mIGhvdyB0aGUgU1JBTSBjb2RlIHdvdWxkIGJlIHVz
ZWZ1bCBvdGhlcgo+dGhhbiB0byBzb21lIG90aGVyIGRyaXZlciB0aGF0IHVzZXMgdGhlIEFQSSAo
d2hpY2ggd291bGQgdXNlICJzZWxlY3QiKS4gIFRoZXJlCj5pcyBubyB1c2Vyc3BhY2UgQVBJLiAg
WW91IGNvdWxkIHVzZSB0aGUga2VybmVsIGNvbW1hbmQgbGluZSB0byBjb25maWd1cmUgdGhlCj5T
UkFNIGJ1dCB5b3UgbmVlZCB0byBnZXQgdGhlIGFkZHJlc3Mgb2YgaXQgZm9yIGl0IHRvIGJlIHVz
ZWZ1bC4KPgoKTGlrZSB5b3UndmUgYXNrZWQgYmVsb3csIHZpYSAvZGV2L21lbSBvciBkaXJlY3Qg
Y2FsbGluZyB3aXRoaW4gdGhlIEtlcm5lbC4KQW5kIHRoZXkgYXJlIG5vdCBzdWJtaXR0ZWQgeWVz
LCB1bmRlciBkZXZlbG9wbWVudC4KCj4+ID4gU2luY2UgdGhpcyBjb2RlIHdhcyBhZGRlZCBhbG1v
c3QgdGVuIHllYXJzIGFnbyBhbmQgdGhlcmUgYXJlIHN0aWxsIG5vIChpbi0KPj4gPiB0cmVlPykg
dXNlcnMgb2YgdGhlIEFQSSwgd2Ugc2hvdWxkIGp1c3QgcmVtb3ZlIHRoZSBzcmFtIGNvZGUgKHVu
bGVzcyB0aGlzCj4+ID4gcHJvZHMgc29tZW9uZSB0byBzdWJtaXQgc3VjaCBhIHVzZXIgdmVyeSBz
b29uKS4KPj4gPiAKPj4gCj4+IFllcywgcHJldHR5IGxvbmcgYSB0aW1lLiBCdXQgd2UgRE8gcmVh
bGx5IHVzZSB0aGUgQVBJIG5vdyBmb3IKPj4gUFBDRTUwMC9GcmVlc2NhbGUgU29DLgo+Cj5JIGRv
IG5vdCBzZWUgYW55IHVzZXJzIGluIHRoZSBrZXJuZWwgdHJlZS4gIEFyZSB5b3UgdGFsa2luZyBh
Ym91dCBvdXQtb2YtdHJlZQo+Y29kZSwgb3Igc29tZXRoaW5nIHRoYXQgeW91J3ZlIHN1Ym1pdHRl
ZCBvciB3aWxsIHN1Ym1pdCBzb29uPyAgT3IgYXJlIHlvdQo+YWNjZXNzaW5nIGl0IHZpYSAvZGV2
L21lbT8KPgoKQm90aCwgYnV0IG5vdCBzdWJtaXR0ZWQgeWV0LCBhbmQgcGFydGx5IHVuZGVyIGRl
dmVsb3BtZW50LgoKPj4gTGlrZSBzb21ldGltZXMgd2UgbmVlZCB0byByZXNldCB0aGUgd2hvbGUg
UkFNLCB0aGVuIHRoZSBMMi1DYWNoZSB3b3VsZCBiZQo+PiB1c2VkIGFzCj4+IFNSQU0gZm9yIGJh
Y2t1cCB1c2luZy4gU2luY2UgaXQgaXMgdXNlZnVsIGZvciB1cyBub3csIGEgcmUtY29uc2lkZXJh
dGlvbiBpcwo+PiByZWNvbW1hbmRlZC4KPgo+V2hlcmUgaXMgdGhlIGNvZGUgdGhhdCB3b3VsZCBk
byB0aGlzPwo+CgpDdXJyZW50bHkgdW5kZXIgZGV2ZWxvcG1lbnQsIGFuZCBub3Qgc3VibWl0dGVk
IHlldC4KCj4tU2NvdHQKPj4gCj4KCldlbmh1DQoNCg==

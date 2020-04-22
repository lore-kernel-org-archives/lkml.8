Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56EE9C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 01:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 391F82072D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 01:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgDVBMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 21:12:43 -0400
Received: from m176150.mail.qiye.163.com ([59.111.176.150]:46533 "EHLO
        m176150.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgDVBMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 21:12:43 -0400
Received: from vivo.com (wm-10.qy.internal [127.0.0.1])
        by m176150.mail.qiye.163.com (Hmail) with ESMTP id 6C6231A151B;
        Wed, 22 Apr 2020 09:12:07 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AJ6AOADeCMOyb*91QJCWH4rn.3.1587517927424.Hmail.bernard@vivo.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: =?UTF-8?B?UmU6UmU6IFJlOiBbUEFUQ0ggVjJdIGttYWxsb2NfaW5kZXggb3B0aW1pemF0aW9uKGNvZGUgc2l6ZSAmIHJ1bnRpbWUgc3RhYmxlKQ==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.122
In-Reply-To: <20200421143609.GM5820@bombadil.infradead.org>
MIME-Version: 1.0
Received: from bernard@vivo.com( [157.0.31.122) ] by ajax-webmail ( [127.0.0.1] ) ; Wed, 22 Apr 2020 09:12:07 +0800 (GMT+08:00)
From:   =?UTF-8?B?6LW15Yab5aWO?= <bernard@vivo.com>
Date:   Wed, 22 Apr 2020 09:12:07 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVDS0xLS0tKTUtJSkxJQllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhMSE9OTE9MTExCN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6MU06NDo*Hjg2NAIZUUJKKjE4LDNPCRVVSFVKTkNMTkpMQklCTklKVTMWGhIXVRkeCRUaCR87
        DRINFFUYFBZFWVdZEgtZQVlKTkxVS1VISlVKSUlZV1kIAVlBTkhPSDcG
X-HM-Tid: 0a719f71301e93b4kuws6c6231a151b
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cgrlj5Hku7bkurrvvJpNYXR0aGV3IFdpbGNveCA8d2lsbHlAaW5mcmFkZWFkLm9yZz4K5Y+R6YCB
5pel5pyf77yaMjAyMC0wNC0yMSAyMjozNjowOQrmlLbku7bkurrvvJoi6LW15Yab5aWOIiA8YmVy
bmFyZEB2aXZvLmNvbT4K5oqE6YCB5Lq677yaQ2hyaXN0b3BoIExhbWV0ZXIgPGNsQGxpbnV4LmNv
bT4sUGVra2EgRW5iZXJnIDxwZW5iZXJnQGtlcm5lbC5vcmc+LERhdmlkIFJpZW50amVzIDxyaWVu
dGplc0Bnb29nbGUuY29tPixKb29uc29vIEtpbSA8aWFtam9vbnNvby5raW1AbGdlLmNvbT4sQW5k
cmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZz4sbGludXgtbW1Aa3ZhY2sub3Jn
LGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcsb3BlbnNvdXJjZS5rZXJuZWxAdml2by5jb20K
5Li76aKY77yaUmU6IFJlOiBbUEFUQ0ggVjJdIGttYWxsb2NfaW5kZXggb3B0aW1pemF0aW9uKGNv
ZGUgc2l6ZSAmIHJ1bnRpbWUgc3RhYmxlKT5PbiBUdWUsIEFwciAyMSwgMjAyMCBhdCAwNzo1NTow
M1BNICswODAwLCDotbXlhpvlpY4gd3JvdGU6Cj4+IFN1cmUsIGkganVzdCByZWNlaXZlZCBzb21l
IGtidWlsZCBjb21waWxlciBlcnJvciBtYWlscyBhbmQgcHJvbXB0IG1lIHRvIGRvIHNvbWV0aGlu
Zz8gCj4+IEkgZG9uYHQga25vdyB3aHkgdGhpcyBoYXBwZW5lZCwgc28gaSB1cGRhdGUgdGhlIHBh
dGNoIGFnYWluLgo+Cj5Eb24ndC4gIFRoZSBwYXRjaCBoYXMgYmVlbiBOQUNLZWQsIHNvIHRoZXJl
J3Mgbm8gbmVlZCB0byBwb3N0IGEgdjIuCj4KPklmIHlvdSB3YW50IHRvIGRvIHNvbWV0aGluZyB1
c2VmdWwsIGhvdyBhYm91dCBsb29raW5nIGF0IHRoZSBlZmZlY3QKPm9mIGFkZGluZyBkaWZmZXJl
bnQgc2xhYiBzaXplcz8gIFRoZXJlJ3MgYSBmYWlybHkgY29tbW9uIHBhdHRlcm4gb2YKPmFsbG9j
YXRpbmcgdGhpbmdzIHdoaWNoIGFyZSBhIHBvd2VyIG9mIHR3byArIGEgaGVhZGVyLiAgU28gaXQg
bWF5IG1ha2UKPnNlbnNlIHRvIGhhdmUga21hbGxvYyBjYWNoZXMgb2YgMzIwICgyNTYgKyA2NCks
IDU3NiAoNTEyICsgNjQpIGFuZCAxMDg4Cj4oMTAyNCArIDY0KS4gIEkgdXNlIDY0IGhlcmUgYXMg
dGhhdCdzIHRoZSBzaXplIG9mIGEgY2FjaGVsaW5lLCBzbyB3ZQo+d29uJ3QgZ2V0IGZhbHNlIHNo
YXJpbmcgYmV0d2VlbiB1c2Vycy4KPgo+VGhpcyBjb3VsZCBzYXZlIGEgZmFpciBxdWFudGl0eSBv
ZiBtZW1vcnk7IHRvZGF5IGlmIHlvdSBhbGxvY2F0ZSA1MTIgKwo+OCBieXRlcywgaXQgd2lsbCBy
b3VuZCB1cCB0byAxMDI0LiAgU28gd2UnbGwgZ2V0IDQgYWxsb2NhdGlvbnMgcGVyIDRrQgo+cGFn
ZSwgYnV0IHdpdGggYSA1NzYtYnl0ZSBzbGFiLCB3ZSdkIGdldCA3IGFsbG9jYXRpb25zIHBlciA0
a0IgcGFnZS4KPk9mIGNvdXJzZSwgaWYgdGhlcmUgYXJlbid0IGEgbG90IG9mIHVzZXJzIHdoaWNo
IGFsbG9jYXRlIG1lbW9yeSBpbiB0aGlzCj5yYW5nZSwgdGhlbiBpdCdsbCBiZSBhIHdhc3RlIG9m
IG1lbW9yeS4gIE9uIG15IGxhcHRvcCwgaXQgc2VlbXMgbGlrZQo+dGhlcmUgbWlnaHQgYmUgYSBk
ZWNlbnQgYW1vdW50IG9mIGFsbG9jYXRpb25zIGluIHRoZSByaWdodCByYW5nZToKPgo+a21hbGxv
Yy0yayAgICAgICAgICAzODgxICAgNDM4NCAgIDIwNDggICAxNiAgICA4IDogdHVuYWJsZXMgICAg
MCAgICAwICAgIDAgOiBzbGEKPmJkYXRhICAgIDI3NCAgICAyNzQgICAgICAwCj5rbWFsbG9jLTFr
ICAgICAgICAgIDY0ODggICA3MDU2ICAgMTAyNCAgIDE2ICAgIDQgOiB0dW5hYmxlcyAgICAwICAg
IDAgICAgMCA6IHNsYWJkYXRhICAgIDQ0MSAgICA0NDEgICAgICAwCj5rbWFsbG9jLTUxMiAgICAg
ICAgIDc3MDAgICA4MjU2ICAgIDUxMiAgIDE2ICAgIDIgOiB0dW5hYmxlcyAgICAwICAgIDAgICAg
MCA6IHNsYWJkYXRhICAgIDUxNiAgICA1MTYgICAgICAwCj4KPk5vdywgbWF5YmUgNTc2IGlzbid0
IHF1aXRlIHRoZSByaWdodCBzaXplLiAgTmVlZCB0byB0cnkgaXQgb24gYSB2YXJpZXR5Cj5vZiBj
b25maWd1cmF0aW9ucyBhbmQgZmluZCBvdXQuICBXYW50IHRvIGludmVzdGlnYXRlIHRoaXM/CgpU
aGlzIGxvb2tzIGxpa2UgYSBncmVhdCBpZGVhIQpNYXliZSBJIGNhbiBkbyBzb21lIHJlc2VhcmNo
IG9uIG91ciBtb2JpbGUgcGhvbmUgcHJvZHVjdHPvvIwKYW5kIHNlZSBob3cgdGhlIG9yaWdpbmFs
IHNpemUgb2Yga21hbGxvYyBpcyBkaXN0cmlidXRlZC4KVGhpcyBtYXkgYmUgdXNlZnVsIGFzIGEg
cmVmZXJlbmNlIHRvIHByb3ZpZGUgYSBmbGV4aWJsZSBjb25maWd1cmF0aW9uIG1ldGhvZC4KVGhh
bmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBzaGFyaW5nLgoKUmVnYXJkcywKQmVybmFyZAoNCg0K

Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74088C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D2AF20644
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 12:17:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbgDQMR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 08:17:27 -0400
Received: from m177126.mail.qiye.163.com ([123.58.177.126]:41842 "EHLO
        m177126.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgDQMR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 08:17:26 -0400
Received: from vivo.com (wm-5 [127.0.0.1])
        by m177126.mail.qiye.163.com (Hmail) with ESMTP id CB34318216B;
        Fri, 17 Apr 2020 20:17:19 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AOsA0QC2CNKuIHXhFI2eG4oJ.3.1587125839812.Hmail.bernard@vivo.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@vivo.com
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0ga21hbGxvY19pbmRleCBvcHRpbWl6YXRpb24oYWRkIGttYWxsb2MgbWF4IHNpemUgY2hlY2sp?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.122
In-Reply-To: <20200417113928.GL26707@dhcp22.suse.cz>
MIME-Version: 1.0
Received: from bernard@vivo.com( [157.0.31.122) ] by ajax-webmail ( [127.0.0.1] ) ; Fri, 17 Apr 2020 20:17:19 +0800 (GMT+08:00)
From:   =?UTF-8?B?6LW15Yab5aWO?= <bernard@vivo.com>
Date:   Fri, 17 Apr 2020 20:17:19 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VLSU5LS0tLQk5ITUxPSFlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhMSUNNTk1OQkpJN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6NAg6Syo4STg1MA4yMyMTPTJJHjxPFDFVSFVKTkNMSklOQ09KQkpOVTMWGhIXVRkeCRUaCR87
        DRINFFUYFBZFWVdZEgtZQVlKTkxVS1VISlVKSUlZV1kIAVlBTk9ITDcG
X-HM-Tid: 0a71881267e46458kurscb34318216b
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpGcm9tOiBNaWNoYWwgSG9ja28gPG1ob2Nrb0BrZXJuZWwub3JnPgpEYXRlOiAyMDIwLTA0LTE3
IDE5OjM5OjI4ClRvOiAgQmVybmFyZCBaaGFvIDxiZXJuYXJkQHZpdm8uY29tPgpDYzogIENocmlz
dG9waCBMYW1ldGVyIDxjbEBsaW51eC5jb20+LFBla2thIEVuYmVyZyA8cGVuYmVyZ0BrZXJuZWwu
b3JnPixEYXZpZCBSaWVudGplcyA8cmllbnRqZXNAZ29vZ2xlLmNvbT4sSm9vbnNvbyBLaW0gPGlh
bWpvb25zb28ua2ltQGxnZS5jb20+LEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlv
bi5vcmc+LGxpbnV4LW1tQGt2YWNrLm9yZyxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLGtl
cm5lbEB2aXZvLmNvbQpTdWJqZWN0OiBSZTogW1BBVENIXSBrbWFsbG9jX2luZGV4IG9wdGltaXph
dGlvbihhZGQga21hbGxvYyBtYXggc2l6ZSBjaGVjayk+T24gRnJpIDE3LTA0LTIwIDAwOjA5OjM1
LCBCZXJuYXJkIFpoYW8gd3JvdGU6Cj4+IGttYWxsb2Mgc2l6ZSBzaG91bGQgbmV2ZXIgZXhjZWVk
IEtNQUxMT0NfTUFYX1NJWkUuCj4+IGttYWxsb2NfaW5kZXggcmVhbGlzZSBpZiBzaXplIGlzIGV4
Y2VlZCBLTUFMTE9DX01BWF9TSVpFLCBlLmcgNjRNLAo+PiBrbWFsbG9jX2luZGV4IGp1c3QgcmV0
dXJuIGluZGV4IDI2LCBidXQgbmV2ZXIgY2hlY2sgd2l0aCBPU2BzIG1heAo+PiBrbWFsbG9jIGNv
bmZpZyBLTUFMTE9DX01BWF9TSVpFLiBUaGlzIGluZGV4YHMga21hbGxvYyBjYWNoZXMgbWF5YmUK
Pj4gbm90IGNyZWF0ZSBpbiBmdW5jdGlvbiBjcmVhdGVfa21hbGxvY19jYWNoZXMuCj4+IFdlIGNh
biB0aHJvdyBhbiB3YXJuaW5naW5mbyBpbiBrbWFsbG9jIGF0IHRoZSBiZWdpbm5pbmcsIGluc3Rl
YWQgb2YKPj4gYmVpbmcgZ3VhcmFudGVlZCBieSB0aGUgYnVkZHkgYWxsb2MgYmVoaW5kLgo+Cj5J
IGFtIHNvcnJ5IGJ1dCBJIGRvIG5vdCBmb2xsb3cuIFdoYXQgZG9lcyB0aGlzIHBhdGNoIG9wdGlt
aXplcz8gQUZBSUNTLAo+aXQgYWRkcyBhIGJyYW5jaCBmb3IgZXZlcnlib2R5IGZvciBzb21ldGhp
bmcgdGhhdCBpcyBoaWdobHkgdW5saWtlbHkKPnVzYWdlLiBCdHcuIHdlIGFscmVhZHkgZG8gaGFu
ZGxlIHRob3NlIGltcG9zc2libGUgY2FzZXMuIFdlIGNvdWxkIGFyZ3VlCj50aGF0IEJVRygpIGlz
IGEgYml0IGhhcnNoIHJlYWN0aW9uIGJ1dCBhIGxhY2sgb2YgcmVwb3J0cyBzdWdnZXN0cyB0aGlz
Cj5pcyBub3QgYSByZWFsIHByb2JsZW0gaW4gZmFjdC4KPgo+U28gd2hhdCBleGFjdGx5IGRvIHlv
dSB3YW50IHRvIGFjaGlldmUgaGVyZT8KPgoKSSdtIG5vdCBzdXJlIGlmIG15IHVuZGVyc3RhbmRp
bmcgaGFzIGEgZ2FwLiBJIHRoaW5rIHRoaXMgc2hvdWxkIG5ldmVyIGhhcHBlbi4gCkFuZCBtYXli
ZSB3ZSBjb3VsZCBkbyBzb21lIGd1YXJhbnRlZXMuIFRoaXMgbWF5IGJlIHZlcnkgZWZmZWN0aXZl
IHdoZW4gZGVidWdnaW5nLgpUaGUgY3VycmVudCBjb2RlIHByb2Nlc3NpbmcgY2FuIG9ubHkgYmUg
Zm91bmQgaWYgdGhlIGJ1ZGR5IGFwcGxpY2F0aW9uIGZhaWxzIGFuZCByZXR1cm5zIAphZnRlcndh
cmRzLiAKVGhlIGZpcnN0IHZlcnNpb24gSSB1c2VkIHdoZW4gdGhpcyBoYXBwZW5lZCB3YXMgIEJV
RywgYnV0IHdoZW4gSSBzdWJtaXR0ZWQgdGhlIHBhdGNoLCAKYW4gYWxlcnQgaGFwcGVuZWQsIHBy
b21wdGluZyBtZSB0byBjaGFuZ2UgdG8gd2Fybiwgc28gSSBwb3N0ZWQgYSByZXZpc2lvbiBvZiB0
aGUgd2Fybi4KSWYgdGhpcyBoYXBwZW5kcywga2VybmVsIHdpbGwgdGhyb3cgYW4gd2FybmluZyBp
bmZvLgoKPj4gU2lnbmVkLW9mZi1ieTogQmVybmFyZCBaaGFvIDxiZXJuYXJkQHZpdm8uY29tPgo+
PiAtLS0KPj4gIGluY2x1ZGUvbGludXgvc2xhYi5oIHwgNCArKysrCj4+ICAxIGZpbGUgY2hhbmdl
ZCwgNCBpbnNlcnRpb25zKCspCj4+IAo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zbGFi
LmggYi9pbmNsdWRlL2xpbnV4L3NsYWIuaAo+PiBpbmRleCA2ZDQ1NDg4Li41OWI2MGQyIDEwMDY0
NAo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3NsYWIuaAo+PiArKysgYi9pbmNsdWRlL2xpbnV4L3Ns
YWIuaAo+PiBAQCAtMzUxLDYgKzM1MSwxMCBAQCBzdGF0aWMgX19hbHdheXNfaW5saW5lIHVuc2ln
bmVkIGludCBrbWFsbG9jX2luZGV4KHNpemVfdCBzaXplKQo+PiAgCWlmICghc2l6ZSkKPj4gIAkJ
cmV0dXJuIDA7Cj4+ICAKPj4gKwkvKiBzaXplIHNob3VsZCBuZXZlciBleGNlZWQgS01BTExPQ19N
QVhfU0laRS4gKi8KPj4gKwlpZiAoc2l6ZSA+IEtNQUxMT0NfTUFYX1NJWkUpCj4+ICsJCVdBUk4o
MSwgInNpemUgZXhjZWVkIG1heCBrbWFsbG9jIHNpemUhXG4iKTsKPj4gKwo+PiAgCWlmIChzaXpl
IDw9IEtNQUxMT0NfTUlOX1NJWkUpCj4+ICAJCXJldHVybiBLTUFMTE9DX1NISUZUX0xPVzsKPj4g
IAo+PiAtLSAKPj4gMi43LjQKPj4gCj4KPi0tIAo+TWljaGFsIEhvY2tvCj5TVVNFIExhYnMKDQoN
Cg==

Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75736C33CB6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 06:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5703624655
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 06:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgAUG7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 01:59:16 -0500
Received: from m176151.mail.qiye.163.com ([59.111.176.151]:62672 "EHLO
        m176151.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbgAUG7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 01:59:16 -0500
Received: from vivo.com (wm-11.qy.internal [127.0.0.1])
        by m176151.mail.qiye.163.com (Hmail) with ESMTP id AFC054823A1;
        Tue, 21 Jan 2020 14:59:09 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ANcAOwAACK7otVnG7VF8E4rQ.3.1579589949706.Hmail.wenhu.wang@vivo.com>
To:     Andrew Donnellan <ajd@linux.ibm.com>
Cc:     wangwenhu <wenhu.pku@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org, lonehugo@hotmail.com
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gcG93ZXJwYy9zeXNkZXY6IGZpeCBjb21waWxlIGVycm9ycw==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.251.74.226
In-Reply-To: <c5256f34-176c-2e72-b0d4-4d615b96d73a@linux.ibm.com>
MIME-Version: 1.0
Received: from wenhu.wang@vivo.com( [58.251.74.226) ] by ajax-webmail ( [127.0.0.1] ) ; Tue, 21 Jan 2020 14:59:09 +0800 (GMT+08:00)
From:   =?UTF-8?B?546L5paH6JmO?= <wenhu.wang@vivo.com>
Date:   Tue, 21 Jan 2020 14:59:09 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VIT0pCQkJOSEtMQklJT1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhNSktCQ0tDS05KN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6NRg6NAw6OjgwTBQPLRU8TC09Qz5PCSpVSFVKTkxCTkNCQk5KTEJLVTMWGhIXVQweFRMOVQwa
        FRw7DRINFFUYFBZFWVdZEgtZQVlOQ1VJTkpVTE9VSUlNWVdZCAFZQU1PSEg3Bg++
X-HM-Tid: 0a6fc6e5d91d93b5kuwsafc054823a1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5Y+R5Lu25Lq677yaQW5kcmV3IERvbm5lbGxhbiA8YWpkQGxpbnV4LmlibS5jb20+CuWPkemAgeaX
peacn++8mjIwMjAtMDEtMjEgMTQ6MTM6MDcK5pS25Lu25Lq677yad2FuZ3dlbmh1IDx3ZW5odS5w
a3VAZ21haWwuY29tPixCZW5qYW1pbiBIZXJyZW5zY2htaWR0IDxiZW5oQGtlcm5lbC5jcmFzaGlu
Zy5vcmc+LFBhdWwgTWFja2VycmFzIDxwYXVsdXNAc2FtYmEub3JnPixNaWNoYWVsIEVsbGVybWFu
IDxtcGVAZWxsZXJtYW4uaWQuYXU+LEthdGUgU3Rld2FydCA8a3N0ZXdhcnRAbGludXhmb3VuZGF0
aW9uLm9yZz4sR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4s
UmljaGFyZCBGb250YW5hIDxyZm9udGFuYUByZWRoYXQuY29tPixUaG9tYXMgR2xlaXhuZXIgPHRn
bHhAbGludXRyb25peC5kZT4sbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcsbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZwrmioTpgIHkurrvvJp0cml2aWFsQGtlcm5lbC5vcmcsbG9uZWh1
Z29AaG90bWFpbC5jb20sd2VuaHUud2FuZ0B2aXZvLmNvbQrkuLvpopjvvJpSZTogW1BBVENIXSBw
b3dlcnBjL3N5c2RldjogZml4IGNvbXBpbGUgZXJyb3JzPk9uIDIxLzEvMjAgNDozMSBwbSwgd2Fu
Z3dlbmh1IHdyb3RlOgo+PiBGcm9tOiB3YW5nd2VuaHUgPHdlbmh1LndhbmdAdml2by5jb20+Cj4+
IAo+PiBJbmNsdWRlIGFyY2gvcG93ZXJwYy9pbmNsdWRlL2FzbS9pby5oIGludG8gZnNsXzg1eHhf
Y2FjaGVfc3JhbS5jIHRvCj4+IGZpeCB0aGUgaW1wbGljaXQgZGVjbGFyYXRpb24gY29tcGlsZSBl
cnJvcnMgd2hlbiBidWlsZGluZyBDYWNoZS1TcmFtLgo+PiAKPj4gYXJjaC9wb3dlcnBjL3N5c2Rl
di9mc2xfODV4eF9jYWNoZV9zcmFtLmM6IEluIGZ1bmN0aW9uIOKAmGluc3RhbnRpYXRlX2NhY2hl
X3NyYW3igJk6Cj4+IGFyY2gvcG93ZXJwYy9zeXNkZXYvZnNsXzg1eHhfY2FjaGVfc3JhbS5jOjk3
OjI2OiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYaW9yZW1hcF9j
b2hlcmVudOKAmTsgZGlkIHlvdSBtZWFuIOKAmGJpdG1hcF9jb21wbGVtZW504oCZPyBbLVdlcnJv
cj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlvbl0KPj4gICAgY2FjaGVfc3JhbS0+YmFzZV92
aXJ0ID0gaW9yZW1hcF9jb2hlcmVudChjYWNoZV9zcmFtLT5iYXNlX3BoeXMsCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn5+fn4KPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgYml0bWFwX2NvbXBsZW1lbnQKPj4gYXJjaC9wb3dlcnBjL3N5c2Rldi9mc2xfODV4
eF9jYWNoZV9zcmFtLmM6OTc6MjQ6IGVycm9yOiBhc3NpZ25tZW50IG1ha2VzIHBvaW50ZXIgZnJv
bSBpbnRlZ2VyIHdpdGhvdXQgYSBjYXN0IFstV2Vycm9yPWludC1jb252ZXJzaW9uXQo+PiAgICBj
YWNoZV9zcmFtLT5iYXNlX3ZpcnQgPSBpb3JlbWFwX2NvaGVyZW50KGNhY2hlX3NyYW0tPmJhc2Vf
cGh5cywKPj4gICAgICAgICAgICAgICAgICAgICAgICAgIF4KPj4gYXJjaC9wb3dlcnBjL3N5c2Rl
di9mc2xfODV4eF9jYWNoZV9zcmFtLmM6MTIzOjI6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlv
biBvZiBmdW5jdGlvbiDigJhpb3VubWFw4oCZOyBkaWQgeW91IG1lYW4g4oCYcm91bmR1cOKAmT8g
Wy1XZXJyb3I9aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCj4+ICAgIGlvdW5tYXAoY2Fj
aGVfc3JhbS0+YmFzZV92aXJ0KTsKPj4gICAgXn5+fn5+fgo+PiAgICByb3VuZHVwCj4+IGNjMTog
YWxsIHdhcm5pbmdzIGJlaW5nIHRyZWF0ZWQgYXMgZXJyb3JzCj4+IAo+PiBTaWduZWQtb2ZmLWJ5
OiB3YW5nd2VuaHUgPHdlbmh1LndhbmdAdml2by5jb20+Cj4KPkhvdyBsb25nIGhhcyB0aGlzIGNv
ZGUgYmVlbiBicm9rZW4gZm9yPwoKSXQncyBiZWVuIGJyb2tlbiBhbG1vc3QgMTUgbW9udGhzIHNp
bmNlIHRoZSBjb21taXQgYmVsb3c6CiJjb21taXQgYWE5MTc5NmVjNDYzMzlmMmVkNTNkYTMxMWJk
M2VhNzdhM2U0ZGZlMQpBdXRob3I6IENocmlzdG9waGUgTGVyb3kgPGNocmlzdG9waGUubGVyb3lA
Yy1zLmZyPgpEYXRlOiAgIFR1ZSBPY3QgOSAxMzo1MTo0MSAyMDE4ICswMDAwCgogICAgcG93ZXJw
YzogZG9uJ3QgdXNlIGlvcmVtYXBfcHJvdCgpIG5vciBfX2lvcmVtYXAoKSB1bmxlc3MgcmVhbGx5
IG5lZWRlZC4iCgpBbmQgd2UgYXJlIHdvcmtpbmcgb24gaXQgbm93IGZvciBmdXJ0aGVyIGRldmVs
b3BtZW50LgoKPgo+PiAtLS0KPj4gICBhcmNoL3Bvd2VycGMvc3lzZGV2L2ZzbF84NXh4X2NhY2hl
X3NyYW0uYyB8IDEgKwo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+PiAKPj4g
ZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9zeXNkZXYvZnNsXzg1eHhfY2FjaGVfc3JhbS5jIGIv
YXJjaC9wb3dlcnBjL3N5c2Rldi9mc2xfODV4eF9jYWNoZV9zcmFtLmMKPj4gaW5kZXggZjZjNjY1
ZGFjNzI1Li4yOWI2ODY4ZWZmN2QgMTAwNjQ0Cj4+IC0tLSBhL2FyY2gvcG93ZXJwYy9zeXNkZXYv
ZnNsXzg1eHhfY2FjaGVfc3JhbS5jCj4+ICsrKyBiL2FyY2gvcG93ZXJwYy9zeXNkZXYvZnNsXzg1
eHhfY2FjaGVfc3JhbS5jCj4+IEBAIC0xNyw2ICsxNyw3IEBACj4+ICAgI2luY2x1ZGUgPGxpbnV4
L29mX3BsYXRmb3JtLmg+Cj4+ICAgI2luY2x1ZGUgPGFzbS9wZ3RhYmxlLmg+Cj4+ICAgI2luY2x1
ZGUgPGFzbS9mc2xfODV4eF9jYWNoZV9zcmFtLmg+Cj4+ICsjaW5jbHVkZSA8YXNtL2lvLmg+Cj4+
IAo+PiAgICNpbmNsdWRlICJmc2xfODV4eF9jYWNoZV9jdGxyLmgiCj4+IAo+Cj4tLSAKPkFuZHJl
dyBEb25uZWxsYW4gICAgICAgICAgICAgIE96TGFicywgQURMIENhbmJlcnJhCj5hamRAbGludXgu
aWJtLmNvbSAgICAgICAgICAgICBJQk0gQXVzdHJhbGlhIExpbWl0ZWQKPgoKV2VuaHUNCg0K

Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3012CC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 11:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FCE20719
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 11:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730852AbgCPLUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 07:20:16 -0400
Received: from m177129.mail.qiye.163.com ([123.58.177.129]:41333 "EHLO
        m177129.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730560AbgCPLUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 07:20:15 -0400
Received: from vivo.com (wm-2.qy.internal [127.0.0.1])
        by m177129.mail.qiye.163.com (Hmail) with ESMTP id A7DED5C3187;
        Mon, 16 Mar 2020 19:20:05 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AJUA5gAVCMaMlIkPsaTC0KqL.3.1584357605616.Hmail.wenhu.wang@vivo.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Allison Randal <allison@lohutok.net>,
        Richard Fontana <rfontana@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org, kernel@vivo.com,
        stable <stable@vger.kernel.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2M10gcG93ZXJwYy9mc2wtODV4eDogZml4IGNvbXBpbGUgZXJyb3I=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.251.74.226
In-Reply-To: <875zf4r613.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Received: from wenhu.wang@vivo.com( [58.251.74.226) ] by ajax-webmail ( [127.0.0.1] ) ; Mon, 16 Mar 2020 19:20:05 +0800 (GMT+08:00)
From:   =?UTF-8?B?546L5paH6JmO?= <wenhu.wang@vivo.com>
Date:   Mon, 16 Mar 2020 19:20:05 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VCQktCQkJNQkNNSENCSVlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhNTEpOQ0NKTE9NN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6MS46Thw6LTg2GjYXMhArCBovOEswCjdVSFVKTkNPSE5MTUtMQkJMVTMWGhIXVQweFRMOVQwa
        FRw7DRINFFUYFBZFWVdZEgtZQVlOQ1VJTkpVTE9VSUlNWVdZCAFZQU5IQ0o3Bg++
X-HM-Tid: 0a70e31281416447kursa7ded5c3187
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTWljaGFlbCBFbGxlcm1hbiA8bXBlQGVsbGVybWFuLmlkLmF1PgogRGF0ZTogMjAyMC0w
My0xNiAxNzo0MToxMgpUbzpXQU5HIFdlbmh1IDx3ZW5odS53YW5nQHZpdm8uY29tPixCZW5qYW1p
biBIZXJyZW5zY2htaWR0IDxiZW5oQGtlcm5lbC5jcmFzaGluZy5vcmc+LFBhdWwgTWFja2VycmFz
IDxwYXVsdXNAc2FtYmEub3JnPixXQU5HIFdlbmh1IDx3ZW5odS53YW5nQHZpdm8uY29tPixBbGxp
c29uIFJhbmRhbCA8YWxsaXNvbkBsb2h1dG9rLm5ldD4sUmljaGFyZCBGb250YW5hIDxyZm9udGFu
YUByZWRoYXQuY29tPixHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnPixUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4sbGludXhwcGMtZGV2QGxp
c3RzLm96bGFicy5vcmcsbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwogY2M6IHRyaXZpYWxA
a2VybmVsLm9yZyxrZXJuZWxAdml2by5jb20sc3RhYmxlIDxzdGFibGVAdmdlci5rZXJuZWwub3Jn
PgpTdWJqZWN0OiBSZTogW1BBVENIIHYzXSBwb3dlcnBjL2ZzbC04NXh4OiBmaXggY29tcGlsZSBl
cnJvcj5XQU5HIFdlbmh1IDx3ZW5odS53YW5nQHZpdm8uY29tPiB3cml0ZXM6Cj4+IEluY2x1ZGUg
ImxpbnV4L29mX2FkZHJlc3MuaCIgdG8gZml4IHRoZSBjb21waWxlIGVycm9yIGZvcgo+PiBtcGM4
NXh4X2wyY3Rscl9vZl9wcm9iZSgpIHdoZW4gY29tcGlsaW5nIGZzbF84NXh4X2NhY2hlX3NyYW0u
Yy4KPj4KPj4gICBDQyAgICAgIGFyY2gvcG93ZXJwYy9zeXNkZXYvZnNsXzg1eHhfbDJjdGxyLm8K
Pj4gYXJjaC9wb3dlcnBjL3N5c2Rldi9mc2xfODV4eF9sMmN0bHIuYzogSW4gZnVuY3Rpb24g4oCY
bXBjODV4eF9sMmN0bHJfb2ZfcHJvYmXigJk6Cj4+IGFyY2gvcG93ZXJwYy9zeXNkZXYvZnNsXzg1
eHhfbDJjdGxyLmM6OTA6MTE6IGVycm9yOiBpbXBsaWNpdCBkZWNsYXJhdGlvbiBvZiBmdW5jdGlv
biDigJhvZl9pb21hcOKAmTsgZGlkIHlvdSBtZWFuIOKAmHBjaV9pb21hcOKAmT8gWy1XZXJyb3I9
aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCj4+ICAgbDJjdGxyID0gb2ZfaW9tYXAoZGV2
LT5kZXYub2Zfbm9kZSwgMCk7Cj4+ICAgICAgICAgICAgXn5+fn5+fn4KPj4gICAgICAgICAgICBw
Y2lfaW9tYXAKPj4gYXJjaC9wb3dlcnBjL3N5c2Rldi9mc2xfODV4eF9sMmN0bHIuYzo5MDo5OiBl
cnJvcjogYXNzaWdubWVudCBtYWtlcyBwb2ludGVyIGZyb20gaW50ZWdlciB3aXRob3V0IGEgY2Fz
dCBbLVdlcnJvcj1pbnQtY29udmVyc2lvbl0KPj4gICBsMmN0bHIgPSBvZl9pb21hcChkZXYtPmRl
di5vZl9ub2RlLCAwKTsKPj4gICAgICAgICAgXgo+PiBjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0
cmVhdGVkIGFzIGVycm9ycwo+PiBzY3JpcHRzL01ha2VmaWxlLmJ1aWxkOjI2NzogcmVjaXBlIGZv
ciB0YXJnZXQgJ2FyY2gvcG93ZXJwYy9zeXNkZXYvZnNsXzg1eHhfbDJjdGxyLm8nIGZhaWxlZAo+
PiBtYWtlWzJdOiAqKiogW2FyY2gvcG93ZXJwYy9zeXNkZXYvZnNsXzg1eHhfbDJjdGxyLm9dIEVy
cm9yIDEKPj4KPj4gRml4ZXM6IGNvbW1pdCA2ZGI5MmNjOWQwN2QgKCJwb3dlcnBjLzg1eHg6IGFk
ZCBjYWNoZS1zcmFtIHN1cHBvcnQiKQo+Cj5UaGUgc3ludGF4IGlzOgo+Cj5GaXhlczogNmRiOTJj
YzlkMDdkICgicG93ZXJwYy84NXh4OiBhZGQgY2FjaGUtc3JhbSBzdXBwb3J0IikKPgo+PiBDYzog
c3RhYmxlIDxzdGFibGVAdmdlci5rZXJuZWwub3JnPgo+Cj5UaGUgY29tbWl0IGFib3ZlIHdlbnQg
aW50byB2Mi42LjM3Lgo+Cj5TbyBubyBvbmUgaGFzIG5vdGljZWQgdGhpcyBidWcgc2luY2UgdGhl
biwgaG93PyBPciBkaWQgc29tZXRoaW5nIGVsc2UKPmNoYW5nZSB0byBleHBvc2UgdGhlIHByb2Js
ZW0/CgpBY3R1YWxseSBhIGhhcmQgcXVlc3Rpb24gdG8gYW5zd2VyIGNhdXNlIGl0IGFsc28gbGVm
dCBtZSBzY3JhdGNoaW5nIGZvciBsb25nLgpIb3dldmVyLCBJIGNhbiBub3QgZmluZCByaWdodCBv
ciBkZWZpbml0ZSBhbnN3ZXIuCgpBIGNvbnZpbmNpbmcgZXhwbGFuYXRpb24gaXMgdGhlIGRyaXZl
ciBoYXMgbm90IGJlZW4gaW4gdXNlIHNpbmNlIHYyLjYuMzcsCmJ1dCBzb21laG93LCB3ZSBhcmUg
dG8gdXNlIGl0IHJlY2VudGx5LgpBbnl3YXksIGl0J3MgYmV0dGVyIGZvciBtZSBhcyB3ZWxsIGFz
IG5vIGhhcm0gdG8gYW55b25lIHRvIGZpeCBpdCBldmVuIHRob3VnaC4KClRoYW5rcywgV2VuaHUK
Pgo+Y2hlZXJzCg0KDQo=

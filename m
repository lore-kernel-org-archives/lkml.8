Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90AFC47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F6F82068E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 03:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgEGDKU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 23:10:20 -0400
Received: from m176150.mail.qiye.163.com ([59.111.176.150]:6431 "EHLO
        m176150.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728295AbgEGDKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 23:10:20 -0400
Received: from vivo.com (wm-10.qy.internal [127.0.0.1])
        by m176150.mail.qiye.163.com (Hmail) with ESMTP id CE1361A2E1E;
        Thu,  7 May 2020 11:09:43 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ABMAdgC5CDjCyrCBmyLV44rX.3.1588820983821.Hmail.bernard@vivo.com>
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: =?UTF-8?B?UmU6W1BBVENIXSBkcm0vZXh5bm9zOiBtYWtlIHBvaW50ZXIgdG8gY29uc3QgZGF0YSBjb25zdCB0eXBl?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.122
In-Reply-To: <20200426090142.21251-1-bernard@vivo.com>
MIME-Version: 1.0
Received: from bernard@vivo.com( [157.0.31.122) ] by ajax-webmail ( [127.0.0.1] ) ; Thu, 7 May 2020 11:09:43 +0800 (GMT+08:00)
From:   Bernard <bernard@vivo.com>
Date:   Thu, 7 May 2020 11:09:43 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VNSUNCQkJMSktLQ0hLSllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhMT09DSE9LSE1ON1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6OTY6Hxw4Tjg*ETgCCTg5FgI3LU9PCSNVSFVKTkNDQ0lLQkNOQkpMVTMWGhIXVRkeCRUaCR87
        DRINFFUYFBZFWVdZEgtZQVlKTkxVS1VISlVKSUlZV1kIAVlBTklLSDcG
X-HM-Tid: 0a71ed1c403493b4kuwsce1361a2e1e
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkZyb206IEJlcm5hcmQgWmhhbyA8YmVybmFyZEB2aXZvLmNvbT4KRGF0ZTogMjAyMC0wNC0yNiAx
NzowMTo0MgpUbzogIElua2kgRGFlIDxpbmtpLmRhZUBzYW1zdW5nLmNvbT4sSm9vbnlvdW5nIFNo
aW0gPGp5MDkyMi5zaGltQHNhbXN1bmcuY29tPixTZXVuZy1Xb28gS2ltIDxzdzAzMTIua2ltQHNh
bXN1bmcuY29tPixLeXVuZ21pbiBQYXJrIDxreXVuZ21pbi5wYXJrQHNhbXN1bmcuY29tPixEYXZp
ZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+LERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5j
aD4sS3VramluIEtpbSA8a2dlbmVAa2VybmVsLm9yZz4sS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6
a0BrZXJuZWwub3JnPixkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnLGxpbnV4LWFybS1r
ZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZyxsaW51eC1zYW1zdW5nLXNvY0B2Z2VyLmtlcm5lbC5v
cmcsbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwpDYzogIG9wZW5zb3VyY2Uua2VybmVsQHZp
dm8uY29tLEJlcm5hcmQgWmhhbyA8YmVybmFyZEB2aXZvLmNvbT4KU3ViamVjdDogW1BBVENIXSBk
cm0vZXh5bm9zOiBtYWtlIHBvaW50ZXIgdG8gY29uc3QgZGF0YSBjb25zdCB0eXBlPk1heWJlIGtl
ZXAgcG9pbnRlciB3aGljaCBwb2ludHMgdG8gZ2xvYmFsIGNvbnN0IHN0cmluZyBkYXRhCj5pbiBj
b25zdCB0eXBlIGlzIGJldHRlciwgbWFrZSBzdXJlIG5vdCBjaGFuZ2UgY29uc3QgZGF0YS4KPgo+
U2lnbmVkLW9mZi1ieTogQmVybmFyZCBaaGFvIDxiZXJuYXJkQHZpdm8uY29tPgo+LS0tCj4gZHJp
dmVycy9ncHUvZHJtL2V4eW5vcy9leHlub3NfZHJtX2RzaS5jIHwgMiArLQo+IGRyaXZlcnMvZ3B1
L2RybS9leHlub3MvZXh5bm9zX2RybV9taWMuYyB8IDIgKy0KPiAyIGZpbGVzIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1
L2RybS9leHlub3MvZXh5bm9zX2RybV9kc2kuYyBiL2RyaXZlcnMvZ3B1L2RybS9leHlub3MvZXh5
bm9zX2RybV9kc2kuYwo+aW5kZXggZTA4MGFhOTIzMzhjLi5mNjBkOTljODVhYzkgMTAwNjQ0Cj4t
LS0gYS9kcml2ZXJzL2dwdS9kcm0vZXh5bm9zL2V4eW5vc19kcm1fZHNpLmMKPisrKyBiL2RyaXZl
cnMvZ3B1L2RybS9leHlub3MvZXh5bm9zX2RybV9kc2kuYwo+QEAgLTIxMSw3ICsyMTEsNyBAQAo+
IAo+ICNkZWZpbmUgT0xEX1NDTEtfTUlQSV9DTEtfTkFNRSAicGxsX2NsayIKPiAKPi1zdGF0aWMg
Y2hhciAqY2xrX25hbWVzWzVdID0geyAiYnVzX2NsayIsICJzY2xrX21pcGkiLAo+K3N0YXRpYyBj
b25zdCBjaGFyICpjb25zdCBjbGtfbmFtZXNbNV0gPSB7ICJidXNfY2xrIiwgInNjbGtfbWlwaSIs
Cj4gCSJwaHljbGtfbWlwaWRwaHkwX2JpdGNsa2RpdjgiLCAicGh5Y2xrX21pcGlkcGh5MF9yeGNs
a2VzYzAiLAo+IAkic2Nsa19yZ2JfdmNsa190b19kc2ltMCIgfTsKPiAKPmRpZmYgLS1naXQgYS9k
cml2ZXJzL2dwdS9kcm0vZXh5bm9zL2V4eW5vc19kcm1fbWljLmMgYi9kcml2ZXJzL2dwdS9kcm0v
ZXh5bm9zL2V4eW5vc19kcm1fbWljLmMKPmluZGV4IGY0MWQ3NTkyMzU1Ny4uYTg2YWJjMTczNjA1
IDEwMDY0NAo+LS0tIGEvZHJpdmVycy9ncHUvZHJtL2V4eW5vcy9leHlub3NfZHJtX21pYy5jCj4r
KysgYi9kcml2ZXJzL2dwdS9kcm0vZXh5bm9zL2V4eW5vc19kcm1fbWljLmMKPkBAIC04OCw3ICs4
OCw3IEBACj4gCj4gI2RlZmluZSBNSUNfQlNfU0laRV8yRCh4KQkoKHgpICYgMHgzZmZmKQo+IAo+
LXN0YXRpYyBjaGFyICpjbGtfbmFtZXNbXSA9IHsgInBjbGtfbWljMCIsICJzY2xrX3JnYl92Y2xr
X3RvX21pYzAiIH07Cj4rc3RhdGljIGNvbnN0IGNoYXIgKmNvbnN0IGNsa19uYW1lc1tdID0geyAi
cGNsa19taWMwIiwgInNjbGtfcmdiX3ZjbGtfdG9fbWljMCIgfTsKPiAjZGVmaW5lIE5VTV9DTEtT
CQlBUlJBWV9TSVpFKGNsa19uYW1lcykKPiBzdGF0aWMgREVGSU5FX01VVEVYKG1pY19tdXRleCk7
Cj4gCj4tLSAKPjIuMjYuMgo+Cg0KDQo=

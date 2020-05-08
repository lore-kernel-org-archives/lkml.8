Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F5AC35280
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 01:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A84120663
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 01:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgEHBxn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 21:53:43 -0400
Received: from m176150.mail.qiye.163.com ([59.111.176.150]:16490 "EHLO
        m176150.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgEHBxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 21:53:43 -0400
Received: from vivo.com (wm-10.qy.internal [127.0.0.1])
        by m176150.mail.qiye.163.com (Hmail) with ESMTP id B95D91A2142;
        Fri,  8 May 2020 09:53:07 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AKEA*wCFCDjDmtJ1Hlm3L4pz.3.1588902787737.Hmail.bernard@vivo.com>
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Uma Shankar <uma.shankar@intel.com>,
        =?UTF-8?Q?Ville_Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
        Shashank Sharma <shashank.sharma@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
Subject: =?UTF-8?B?UmU6W1BBVENIXSBkcml2ZXJzL3ZpZGVvOiBjbGVhbnVwIGNvZGluZyBzdHlsZSBpbiB2aWRlbyBhIGJpdA==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.122
In-Reply-To: <20200427080530.3234-1-bernard@vivo.com>
MIME-Version: 1.0
Received: from bernard@vivo.com( [157.0.31.122) ] by ajax-webmail ( [127.0.0.1] ) ; Fri, 8 May 2020 09:53:07 +0800 (GMT+08:00)
From:   Bernard <bernard@vivo.com>
Date:   Fri, 8 May 2020 09:53:07 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VKTU9LS0tLSE9ISElJQ1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhMT0xJSk5OSElIN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6MD46UQw4PTg*ET8WDzFKMxcWSDdPCwFVSFVKTkNDQktJTENMQktDVTMWGhIXVRkeCRUaCR87
        DRINFFUYFBZFWVdZEgtZQVlKTkxVS1VISlVKSUlZV1kIAVlBT0xLSDcG
X-HM-Tid: 0a71f1fc7b0993b4kuwsb95d91a2142
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkZyb206IEJlcm5hcmQgWmhhbyA8YmVybmFyZEB2aXZvLmNvbT4KRGF0ZTogMjAyMC0wNC0yNyAx
NjowNToyMwpUbzogIEJhcnRsb21pZWogWm9sbmllcmtpZXdpY3ogPGIuem9sbmllcmtpZUBzYW1z
dW5nLmNvbT4sVW1hIFNoYW5rYXIgPHVtYS5zaGFua2FyQGludGVsLmNvbT4sIlZpbGxlIFN5cmrD
pGzDpCIgPHZpbGxlLnN5cmphbGFAbGludXguaW50ZWwuY29tPixTaGFzaGFuayBTaGFybWEgPHNo
YXNoYW5rLnNoYXJtYUBpbnRlbC5jb20+LExhdXJlbnQgUGluY2hhcnQgPGxhdXJlbnQucGluY2hh
cnRAaWRlYXNvbmJvYXJkLmNvbT4sRGFuaWVsIFZldHRlciA8ZGFuaWVsLnZldHRlckBmZndsbC5j
aD4sQmVybmFyZCBaaGFvIDxiZXJuYXJkQHZpdm8uY29tPixkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnLGxpbnV4LWZiZGV2QHZnZXIua2VybmVsLm9yZyxsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnCkNjOiAgb3BlbnNvdXJjZS5rZXJuZWxAdml2by5jb20KU3ViamVjdDogW1BBVENI
XSBkcml2ZXJzL3ZpZGVvOiBjbGVhbnVwIGNvZGluZyBzdHlsZSBpbiB2aWRlbyBhIGJpdD5FbGlt
aW5hdGUgdGhlIG1hZ2ljIG51bWJlcnMsIGFkZCB2ZW5kZXIgaW5mb2ZyYW1lIHNpemUgbWFjcm8K
Pmxpa2Ugb3RoZXIgaGRtaSBtb2R1bGVzLgo+Cj5TaWduZWQtb2ZmLWJ5OiBCZXJuYXJkIFpoYW8g
PGJlcm5hcmRAdml2by5jb20+Cj4tLS0KPiBkcml2ZXJzL3ZpZGVvL2hkbWkuYyB8IDIgKy0KPiBp
bmNsdWRlL2xpbnV4L2hkbWkuaCB8IDEgKwo+IDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAxIGRlbGV0aW9uKC0pCj4KPmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL2hkbWkuYyBi
L2RyaXZlcnMvdmlkZW8vaGRtaS5jCj5pbmRleCA4NTZhOGM0ZTg0YTIuLmY2OTMwNzZmMmU1ZiAx
MDA2NDQKPi0tLSBhL2RyaXZlcnMvdmlkZW8vaGRtaS5jCj4rKysgYi9kcml2ZXJzL3ZpZGVvL2hk
bWkuYwo+QEAgLTQ5NSw3ICs0OTUsNyBAQCBpbnQgaGRtaV92ZW5kb3JfaW5mb2ZyYW1lX2luaXQo
c3RydWN0IGhkbWlfdmVuZG9yX2luZm9mcmFtZSAqZnJhbWUpCj4gCSAqIHZhbHVlCj4gCSAqLwo+
IAlmcmFtZS0+czNkX3N0cnVjdCA9IEhETUlfM0RfU1RSVUNUVVJFX0lOVkFMSUQ7Cj4tCWZyYW1l
LT5sZW5ndGggPSA0Owo+KwlmcmFtZS0+bGVuZ3RoID0gSERNSV9WRU5ET1JfSU5GT0ZSQU1FX1NJ
WkU7Cj4gCj4gCXJldHVybiAwOwo+IH0KPmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2hkbWku
aCBiL2luY2x1ZGUvbGludXgvaGRtaS5oCj5pbmRleCA5NjEzZDc5NmNmYjEuLmZmMjVhZWI5NWVl
NCAxMDA2NDQKPi0tLSBhL2luY2x1ZGUvbGludXgvaGRtaS5oCj4rKysgYi9pbmNsdWRlL2xpbnV4
L2hkbWkuaAo+QEAgLTU3LDYgKzU3LDcgQEAgZW51bSBoZG1pX2luZm9mcmFtZV90eXBlIHsKPiAj
ZGVmaW5lIEhETUlfU1BEX0lORk9GUkFNRV9TSVpFICAgIDI1Cj4gI2RlZmluZSBIRE1JX0FVRElP
X0lORk9GUkFNRV9TSVpFICAxMAo+ICNkZWZpbmUgSERNSV9EUk1fSU5GT0ZSQU1FX1NJWkUgICAg
MjYKPisjZGVmaW5lIEhETUlfVkVORE9SX0lORk9GUkFNRV9TSVpFICA0Cj4gCj4gI2RlZmluZSBI
RE1JX0lORk9GUkFNRV9TSVpFKHR5cGUpCVwKPiAJKEhETUlfSU5GT0ZSQU1FX0hFQURFUl9TSVpF
ICsgSERNSV8gIyMgdHlwZSAjIyBfSU5GT0ZSQU1FX1NJWkUpCj4tLSAKPjIuMjYuMgo+Cg0KDQo=

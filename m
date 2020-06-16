Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE4BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 02:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6419C20707
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 02:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgFPCYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 22:24:36 -0400
Received: from m176149.mail.qiye.163.com ([59.111.176.149]:49243 "EHLO
        m176149.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgFPCYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 22:24:35 -0400
X-Greylist: delayed 439 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jun 2020 22:24:33 EDT
Received: from vivo.com (wm-9.qy.internal [127.0.0.1])
        by m176149.mail.qiye.163.com (Hmail) with ESMTP id 136E3281F35;
        Tue, 16 Jun 2020 10:16:40 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AGQAVQB8CJTteCgzBUXE5Kra.3.1592273800065.Hmail.bernard@vivo.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Joe Perches <joe@perches.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        opensource.kernel@vivo.com
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSF0gZHJtL21lZGlhdGVrOiByZW1vdmUgdW5uZWNlc3NhcnkgY29udmVyc2lvbiB0byBib29s?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 14.29.82.33
In-Reply-To: <CAAOTY__sSV2f4MqSLJYvSW9TGV=bCKXz+zELYREaEOFVjA6XQQ@mail.gmail.com>
MIME-Version: 1.0
Received: from bernard@vivo.com( [14.29.82.33) ] by ajax-webmail ( [127.0.0.1] ) ; Tue, 16 Jun 2020 10:16:40 +0800 (GMT+08:00)
From:   Bernard <bernard@vivo.com>
Date:   Tue, 16 Jun 2020 10:16:40 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGU4YGh8fGhgYGRpKVkpOQklJTEhDS0tKSktVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tZBg++
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhDSEhKTExPTUJLN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6PCo6LSo5QzgxLw8eOBwBOS4jPk4wCRpVSFVKTkJJSUxIQ0tLTUhCVTMWGhIXVRkeCRUaCR87
        DRINFFUYFBZFWVdZEgtZQVlKT1VJQlVDSVVISFlXWQgBWUFOSUNCNwY+
X-HM-Tid: 0a72baea0b989395kuws136e3281f35
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cgrlj5Hku7bkurrvvJpDaHVuLUt1YW5nIEh1IDxjaHVua3VhbmcuaHVAa2VybmVsLm9yZz4K5Y+R
6YCB5pel5pyf77yaMjAyMC0wNi0xNSAyMjowMDo1MgrmlLbku7bkurrvvJpKb2UgUGVyY2hlcyA8
am9lQHBlcmNoZXMuY29tPgrmioTpgIHkurrvvJpCZXJuYXJkIFpoYW8gPGJlcm5hcmRAdml2by5j
b20+LENodW4tS3VhbmcgSHUgPGNodW5rdWFuZy5odUBrZXJuZWwub3JnPixQaGlsaXBwIFphYmVs
IDxwLnphYmVsQHBlbmd1dHJvbml4LmRlPixEYXZpZCBBaXJsaWUgPGFpcmxpZWRAbGludXguaWU+
LERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4sTWF0dGhpYXMgQnJ1Z2dlciA8bWF0dGhp
YXMuYmdnQGdtYWlsLmNvbT4sRFJJIERldmVsb3BtZW50IDxkcmktZGV2ZWxAbGlzdHMuZnJlZWRl
c2t0b3Aub3JnPixMaW51eCBBUk0gPGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9y
Zz4sIm1vZGVyYXRlZCBsaXN0OkFSTS9NZWRpYXRlayBTb0Mgc3VwcG9ydCIgPGxpbnV4LW1lZGlh
dGVrQGxpc3RzLmluZnJhZGVhZC5vcmc+LGxpbnV4LWtlcm5lbCA8bGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZz4sb3BlbnNvdXJjZS5rZXJuZWxAdml2by5jb20K5Li76aKY77yaUmU6IFtQQVRD
SF0gZHJtL21lZGlhdGVrOiByZW1vdmUgdW5uZWNlc3NhcnkgY29udmVyc2lvbiB0byBib29sPkpv
ZSBQZXJjaGVzIDxqb2VAcGVyY2hlcy5jb20+IOaWvCAyMDIw5bm0NuaciDE15pelIOmAseS4gCDk
uIrljYg0OjQx5a+r6YGT77yaCj4+Cj4+IE9uIEZyaSwgMjAyMC0wNi0xMiBhdCAyMDo0MCArMDgw
MCwgQmVybmFyZCBaaGFvIHdyb3RlOgo+PiA+IEluIGZ1bmN0aW9uIG10a19kc2lfY2xrX2hzX3N0
YXRlLCByZW1vdmUgdW5uZWNlc3NhcnkgY29udmVyc2lvbgo+PiA+IHRvIGJvb2wgcmV0dXJuLCB0
aGlzIGNoYW5nZSBpcyB0byBtYWtlIHRoZSBjb2RlIGEgYml0IHJlYWRhYmxlLgo+PiBbXQo+PiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jIGIvZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYwo+PiBbXQo+PiA+IEBAIC0zMTksNyArMzE5LDcg
QEAgc3RhdGljIGJvb2wgbXRrX2RzaV9jbGtfaHNfc3RhdGUoc3RydWN0IG10a19kc2kgKmRzaSkK
Pj4gPiAgICAgICB1MzIgdG1wX3JlZzE7Cj4+ID4KPj4gPiAgICAgICB0bXBfcmVnMSA9IHJlYWRs
KGRzaS0+cmVncyArIERTSV9QSFlfTENDT04pOwo+PiA+IC0gICAgIHJldHVybiAoKHRtcF9yZWcx
ICYgTENfSFNfVFhfRU4pID09IDEpID8gdHJ1ZSA6IGZhbHNlOwo+PiA+ICsgICAgIHJldHVybiAo
KHRtcF9yZWcxICYgTENfSFNfVFhfRU4pID09IDEpOwo+Pgo+PiBHaXZlbjoKPj4KPj4gZHJpdmVy
cy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYzojZGVmaW5lIExDX0hTX1RYX0VOICAgICAgICAg
ICAgICAgICAgQklUKDApCj4+Cj4+IFRoaXMgaXMgbGlrZWx5IGNsZWFyZXIgYXMKPj4KPj4gICAg
ICAgICByZXR1cm4gdG1wX3JlZzEgJiBMQ19IU19UWF9FTjsKPj4KPj4gb3IgZXZlbgo+Pgo+PiBz
dGF0aWMgYm9vbCBtdGtfZHNpX2Nsa19oc19zdGF0ZShzdHJ1Y3QgbXRrX2RzaSAqZHNpKQo+PiB7
Cj4+ICAgICAgICAgcmV0dXJuIHJlYWRsKGRzaS0+cmVncyArIERTSV9QSFlfTENDT04pICYgTENf
SFNfVFhfRU47Cj4+IH0KPgo+SSBsaWtlIHRoZSBzZWNvbmQgb25lLgoKSGk6CgpUaGlzIG1vZGlm
aWNhdGlvbiBpcyBjbGVhciBhbmQgZWFzeSB0byB1bmRlcnN0YW5kLgpJIHdpbGwgdXBkYXRlIHRo
ZSBwYXRjaCBhbmQgcmVzdWJtaXQuClRoYW5rcyEKCkJSLy9CZXJuYXJkCgo+Pgo+Pgo+PiBfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwo+PiBkcmktZGV2ZWwg
bWFpbGluZyBsaXN0Cj4+IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gaHR0cHM6
Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwKDQoNCg==

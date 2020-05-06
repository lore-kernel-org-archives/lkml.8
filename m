Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099A6C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0EB920575
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 12:49:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgEFMtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 08:49:39 -0400
Received: from m176150.mail.qiye.163.com ([59.111.176.150]:22429 "EHLO
        m176150.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbgEFMti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 08:49:38 -0400
Received: from vivo.com (wm-10.qy.internal [127.0.0.1])
        by m176150.mail.qiye.163.com (Hmail) with ESMTP id 6E7471A31C1;
        Wed,  6 May 2020 20:49:03 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AMkACAAICCLCcgaekrYcyKoA.1.1588769343436.Hmail.bernard@vivo.com>
To:     Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: =?UTF-8?B?W1BBVENIXSBkcm0vZXh5bm9zOiByZW1vdmUgbm8gbmVlZCBkZXZtX2tmcmVlIGluIHByb2JlIFtyZS1zZW5kLCB3ZWxjb21lIGFueSBjb21tZW50c10=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.122
MIME-Version: 1.0
Received: from bernard@vivo.com( [157.0.31.122) ] by ajax-webmail ( [127.0.0.1] ) ; Wed, 6 May 2020 20:49:03 +0800 (GMT+08:00)
From:   Bernard <bernard@vivo.com>
Date:   Wed, 6 May 2020 20:49:03 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VPQ0NCQkJDT0hOQkxPSllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQQ8JDh5XWRIfHhUPWUFZRzo2EDo4OjoyODg3OBgcGh4QCSIY
        AjAUOlVKVUpOQ0NMTUJIT0hOSkpVMxYaEhdVGR4JFRoJHzsNEg0UVRgUFkVZV1kSC1lBWUpOTFVL
        VUhKVUpJSVlXWQgBWUFITUlDNwY+
X-HM-Tid: 0a71ea0847e793b4kuws6e7471a31c1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmVtb3ZlIG5vIG5lZWQgZGV2bV9rZnJlZSBpbiBwcm9iZS4KVGhlIGNoYW5nZSBpcyB0byBtYWtl
IHRoZSBjb2RlIGEgYml0IG1vcmUgcmVhZGFibGUKClNpZ25lZC1vZmYtYnk6IEJlcm5hcmQgWmhh
byA8YmVybmFyZEB2aXZvLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vZXh5bm9zL2V4eW5vc19k
cm1fZHBpLmMgfCAxMCArKystLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCA3IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9leHlub3MvZXh5
bm9zX2RybV9kcGkuYyBiL2RyaXZlcnMvZ3B1L2RybS9leHlub3MvZXh5bm9zX2RybV9kcGkuYwpp
bmRleCA0M2ZhMGYyNmMwNTIuLmUwNmY3ZDdhNjY5NSAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL2V4eW5vcy9leHlub3NfZHJtX2RwaS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9leHlub3Mv
ZXh5bm9zX2RybV9kcGkuYwpAQCAtMTgxLDEwICsxODEsOCBAQCBzdGF0aWMgaW50IGV4eW5vc19k
cGlfcGFyc2VfZHQoc3RydWN0IGV4eW5vc19kcGkgKmN0eCkKIAkJCXJldHVybiAtRU5PTUVNOwog
CiAJCXJldCA9IG9mX2dldF92aWRlb21vZGUoZG4sIHZtLCAwKTsKLQkJaWYgKHJldCA8IDApIHsK
LQkJCWRldm1fa2ZyZWUoZGV2LCB2bSk7CisJCWlmIChyZXQgPCAwKQogCQkJcmV0dXJuIHJldDsK
LQkJfQogCiAJCWN0eC0+dm0gPSB2bTsKIApAQCAtMjMzLDEwICsyMzEsOCBAQCBzdHJ1Y3QgZHJt
X2VuY29kZXIgKmV4eW5vc19kcGlfcHJvYmUoc3RydWN0IGRldmljZSAqZGV2KQogCWN0eC0+ZGV2
ID0gZGV2OwogCiAJcmV0ID0gZXh5bm9zX2RwaV9wYXJzZV9kdChjdHgpOwotCWlmIChyZXQgPCAw
KSB7Ci0JCWRldm1fa2ZyZWUoZGV2LCBjdHgpOwotCQlyZXR1cm4gTlVMTDsKLQl9CisJaWYgKHJl
dCA8IDApCisJCXJldHVybiBFUlJfUFRSKHJldCk7CiAKIAlpZiAoY3R4LT5wYW5lbF9ub2RlKSB7
CiAJCWN0eC0+cGFuZWwgPSBvZl9kcm1fZmluZF9wYW5lbChjdHgtPnBhbmVsX25vZGUpOwotLSAK
Mi4yNi4yCgoKW3JlLXNlbmQsIHdlbGNvbWUgYW55IGNvbW1lbnRzXQpSZWdhcmRzLApCZXJuYXJk
CgoKDQoNCg==

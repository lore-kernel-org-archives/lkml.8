Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B18AC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4547220639
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgIBPnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:43:02 -0400
Received: from m176150.mail.qiye.163.com ([59.111.176.150]:6807 "EHLO
        m176150.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbgIBNl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:41:28 -0400
Received: from vivo.com (wm-10.qy.internal [127.0.0.1])
        by m176150.mail.qiye.163.com (Hmail) with ESMTP id AA9431A31B7;
        Wed,  2 Sep 2020 21:17:02 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ADIABQBNDXyW8X9QUmo2xaoL.1.1599052622252.Hmail.bernard@vivo.com>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: =?UTF-8?B?W1JlLXNlbmRdW1BBVENIXSBncHUvZHJtOiByZW1vdmUgZHJtX21vZGVzZXRfbG9jayBwcm90ZWN0aW9uIGZvciBkcm1fZXJyb3I=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.124
MIME-Version: 1.0
Received: from bernard@vivo.com( [157.0.31.124) ] by ajax-webmail ( [127.0.0.1] ) ; Wed, 2 Sep 2020 21:17:02 +0800 (GMT+08:00)
From:   Bernard <bernard@vivo.com>
Date:   Wed, 2 Sep 2020 21:17:02 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZTUweSx0ZT0gZT0lLVkpOQkJLTklNSUlMT0JVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQQ8JDh5XWRIfHhUPWUFZRzo*Mjo5Kjk1PyMCLEMjQiouFhRJ
        AxoUN1VKVUpOQkJLTklNSUhKT09VMxYaEhdVGR4JFRoJHzsNEg0UVRgUFkVZV1kSC1lBWUpOTFVL
        VUhKVUpJT1lXWQgBWUFIS0xNNwY+
X-HM-Tid: 0a744ef6ab6f93b4kuwsaa9431a31b7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SW4gZnVuY3Rpb24gZHJtX2F0b21pY19oZWxwZXJfc2h1dGRvd24sIG1heWJlIHRoZXJlIGlzIG5v
IG5lZWQKdG8gcHJvdGVjdCBEUk1fRVJST1IgbG9nIGluIERSTV9NT0RFU0VUX0xPQ0tfQUxMX0JF
R0lOICYKRFJNX01PREVTRVRfTE9DS19BTExfRU5ELiBUaGlzIGNoYW5nZSBpcyB0byBtYWtlIGNv
ZGUgcnVuIGEgYml0CmZhc3QuCgpTaWduZWQtb2ZmLWJ5OiBCZXJuYXJkIFpoYW8gPGJlcm5hcmRA
dml2by5jb20+Ci0tLQogZHJpdmVycy9ncHUvZHJtL2RybV9hdG9taWNfaGVscGVyLmMgfCA0ICst
LS0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2F0b21pY19oZWxwZXIuYyBiL2RyaXZlcnMvZ3B1
L2RybS9kcm1fYXRvbWljX2hlbHBlci5jCmluZGV4IDg1ZDE2M2YxNjgwMS4uODkwMmZkNjMxNmZj
IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2F0b21pY19oZWxwZXIuYworKysgYi9k
cml2ZXJzL2dwdS9kcm0vZHJtX2F0b21pY19oZWxwZXIuYwpAQCAtMzEwMCwxMiArMzEwMCwxMCBA
QCB2b2lkIGRybV9hdG9taWNfaGVscGVyX3NodXRkb3duKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYp
CiAJaW50IHJldDsKIAogCURSTV9NT0RFU0VUX0xPQ0tfQUxMX0JFR0lOKGRldiwgY3R4LCAwLCBy
ZXQpOwotCiAJcmV0ID0gZHJtX2F0b21pY19oZWxwZXJfZGlzYWJsZV9hbGwoZGV2LCAmY3R4KTsK
KwlEUk1fTU9ERVNFVF9MT0NLX0FMTF9FTkQoY3R4LCByZXQpOwogCWlmIChyZXQpCiAJCURSTV9F
UlJPUigiRGlzYWJsaW5nIGFsbCBjcnRjJ3MgZHVyaW5nIHVubG9hZCBmYWlsZWQgd2l0aCAlaVxu
IiwgcmV0KTsKLQotCURSTV9NT0RFU0VUX0xPQ0tfQUxMX0VORChjdHgsIHJldCk7CiB9CiBFWFBP
UlRfU1lNQk9MKGRybV9hdG9taWNfaGVscGVyX3NodXRkb3duKTsKIAotLSAKMi4xNy4xCgoNCg0K

Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83913C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 671012078E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 13:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbgG0NsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 09:48:24 -0400
Received: from m177126.mail.qiye.163.com ([123.58.177.126]:27697 "EHLO
        m177126.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbgG0NsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 09:48:24 -0400
X-Greylist: delayed 508 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Jul 2020 09:48:22 EDT
Received: from vivo.com (wm-5 [127.0.0.1])
        by m177126.mail.qiye.163.com (Hmail) with ESMTP id DF77C1832B7;
        Mon, 27 Jul 2020 21:39:51 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AAcAXwBTDSpsKN-5iyIOtaqk.1.1595857191899.Hmail.wenhu.wang@vivo.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     mgorman@suse.de, bsegall@google.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        trivial <trivial@kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSBzY2hlZDogZml4IGEgdHlwbyBmb3Igc2NoZWQuaCBmb3Igc3RydWN0IHNjaGVkX2F2Zw==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.251.74.226
MIME-Version: 1.0
Received: from wenhu.wang@vivo.com( [58.251.74.226) ] by ajax-webmail ( [127.0.0.1] ) ; Mon, 27 Jul 2020 21:39:51 +0800 (GMT+08:00)
From:   =?UTF-8?B?546L5paH6JmO?= <wenhu.wang@vivo.com>
Date:   Mon, 27 Jul 2020 21:39:51 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGEJCTRhDHR0ZQx0ZVkpOQk5DTkxKQkpCSk1VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQQ8JDh5XWRIfHhUPWUFZRzo6GDojDDkvPygLCDA1Vk4SAjI0
        DxoKEFVKVUpOQk5DTkxKQklIQ09VMxYaEhdVDB4VEw5VDBoVHDsNEg0UVRgUFkVZV1kSC1lBWU5D
        VUlOSlVMT1VJSU1ZV1kIAVlBSU1DTzcG
X-HM-Tid: 0a73908043f36458kursdf77c1832b7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2hhbmdlIHRoZSBjb21tZW50IHR5cG86ICJkaXJlY2x5IiAtPiAiZGlyZWN0bHkiLgoKU2lnbmVk
LW9mZi1ieTogV2FuZyBXZW5odSA8d2VuaHUud2FuZ0B2aXZvLmNvbT4KLS0tCiBpbmNsdWRlL2xp
bnV4L3NjaGVkLmggfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVs
ZXRpb24oLSkKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NjaGVkLmggYi9pbmNsdWRlL2xp
bnV4L3NjaGVkLmgKaW5kZXggNDQxOGY1Y2I4MzI0Li5hZWM1ZDdmYjE5NTIgMTAwNjQ0Ci0tLSBh
L2luY2x1ZGUvbGludXgvc2NoZWQuaAorKysgYi9pbmNsdWRlL2xpbnV4L3NjaGVkLmgKQEAgLTM3
Nyw3ICszNzcsNyBAQCBzdHJ1Y3QgdXRpbF9lc3QgewogICogRm9yIGNmc19ycSwgdGhleSBhcmUg
dGhlIGFnZ3JlZ2F0ZWQgdmFsdWVzIG9mIGFsbCBydW5uYWJsZSBhbmQgYmxvY2tlZAogICogc2No
ZWRfZW50aXRpZXMuCiAgKgotICogVGhlIGxvYWQvcnVubmFibGUvdXRpbF9hdmcgZG9lc24ndCBk
aXJlY2x5IGZhY3RvciBmcmVxdWVuY3kgc2NhbGluZyBhbmQgQ1BVCisgKiBUaGUgbG9hZC9ydW5u
YWJsZS91dGlsX2F2ZyBkb2Vzbid0IGRpcmVjdGx5IGZhY3RvciBmcmVxdWVuY3kgc2NhbGluZyBh
bmQgQ1BVCiAgKiBjYXBhY2l0eSBzY2FsaW5nLiBUaGUgc2NhbGluZyBpcyBkb25lIHRocm91Z2gg
dGhlIHJxX2Nsb2NrX3BlbHQgdGhhdCBpcyB1c2VkCiAgKiBmb3IgY29tcHV0aW5nIHRob3NlIHNp
Z25hbHMgKHNlZSB1cGRhdGVfcnFfY2xvY2tfcGVsdCgpKQogICoKLS0gCjIuMTcuMQoKDQoNCg==

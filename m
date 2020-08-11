Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C84C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2D0E206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 08:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alibaba-inc.com header.i=@alibaba-inc.com header.b="pX/zixtY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbgHKIaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 04:30:35 -0400
Received: from out0-132.mail.aliyun.com ([140.205.0.132]:59574 "EHLO
        out0-132.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbgHKIaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 04:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alibaba-inc.com; s=default;
        t=1597134632; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
        bh=dAMi5D9nlmo0sJByAKTY3OwPY+JVzMQZnZ3pNMtqwMM=;
        b=pX/zixtYC2u5ChLQaSVhZbVaDDi/IMGmchZmweFyPa5J9DUFEqDpPQQ2FtdF6n1HfzfsXzhnaOqwsIQEeZdhOwmEqFPrkunQcESqedcmle5FKYz3IfrHFwNK6SUEnLZTw4lCrpBbioiZcRwEvKNG5ZPczBSXT5PlBo1rUCPgwZw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01l07447;MF=tianchen.dingtianc@alibaba-inc.com;NM=1;PH=DW;RN=10;SR=0;TI=W4_5948689_DEFAULT_0A932697_1597134140915_o7001c150e;
Received: from WS-web (tianchen.dingtianc@alibaba-inc.com[W4_5948689_DEFAULT_0A932697_1597134140915_o7001c150e]) by e02c03290.eu6 at Tue, 11 Aug 2020 16:30:31 +0800
Date:   Tue, 11 Aug 2020 16:30:31 +0800
From:   "=?UTF-8?B?5LiB5aSp55Cb?=" <tianchen.dingtianc@alibaba-inc.com>
To:     "Ingo Molnar" <mingo@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Juri Lelli" <juri.lelli@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Ben Segall" <bsegall@google.com>, "Mel Gorman" <mgorman@suse.de>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Cc:     "=?UTF-8?B?546L6LSH?=" <yun.wang@linux.alibaba.com>
Reply-To: "=?UTF-8?B?5LiB5aSp55Cb?=" <tianchen.dingtianc@alibaba-inc.com>
Message-ID: <44875b14-00ea-4e61-aba7-4809808c4b2a.tianchen.dingtianc@alibaba-inc.com>
Subject: =?UTF-8?B?W1JGQyBQQVRDSF0gc2NoZWQvbnVtYTogZml4IGJ1ZyBpbiB1cGRhdGVfdGFza19zY2FuX3Bl?=
  =?UTF-8?B?cmlvZA==?=
X-Mailer: [Alimail-Mailagent][W4_5948689][DEFAULT][Chrome]
MIME-Version: 1.0
x-aliyun-mail-creator: W4_5948689_DEFAULT_M2ITW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzg0LjAuNDE0Ny4xMDUgU2FmYXJpLzUzNy4zNg==3L
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2hlbiBwLT5udW1hX2ZhdWx0c19sb2NhbGl0eVsyXSA+IDAsIG51bWFfc2Nhbl9wZXJpb2QgaXMg
ZG91YmxlZCwgYnV0CnRoaXMgYXJyYXkgd2lsbCBuZXZlciBiZSBjbGVhcmVkLCB3aGljaCBjYXVz
ZXMgc2Nhbm5pbmcgcGVyaW9kIGFsd2F5cwpyZWFjaGluZyBpdHMgbWF4IHZhbHVlLiBUaGlzIHBh
dGNoIGNsZWFycyBudW1hX2ZhdWx0c19sb2NhbGl0eSBhZnRlcgpudW1hX3NjYW5fcGVyaW9kIGJl
aW5nIGRvdWJsZWQgdG8gZml4IHRoaXMgYnVnLgoKU2lnbmVkLW9mZi1ieTogVGlhbmNoZW4gRGlu
ZyA8dGlhbmNoZW4uZGluZ3RpYW5jQGFsaWJhYmEtaW5jLmNvbT4KU2lnbmVkLW9mZi1ieTogTWlj
aGFlbCBXYW5nIDx5dW4ud2FuZ0BsaW51eC5hbGliYWJhLmNvbT4KLS0tCiBrZXJuZWwvc2NoZWQv
ZmFpci5jIHwgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL2tlcm5lbC9zY2hlZC9mYWlyLmMgYi9rZXJuZWwvc2NoZWQvZmFpci5jCmluZGV4IDFhNjhh
MDUzNmFkZC4uYTYxZWU0MDgyMDJlIDEwMDY0NAotLS0gYS9rZXJuZWwvc2NoZWQvZmFpci5jCisr
KyBiL2tlcm5lbC9zY2hlZC9mYWlyLmMKQEAgLTIxODAsNiArMjE4MCw4IEBAIHN0YXRpYyB2b2lk
IHVwZGF0ZV90YXNrX3NjYW5fcGVyaW9kKHN0cnVjdCB0YXNrX3N0cnVjdCAqcCwKIAkJcC0+bW0t
Pm51bWFfbmV4dF9zY2FuID0gamlmZmllcyArCiAJCQltc2Vjc190b19qaWZmaWVzKHAtPm51bWFf
c2Nhbl9wZXJpb2QpOwogCisJCW1lbXNldChwLT5udW1hX2ZhdWx0c19sb2NhbGl0eSwgMCwKKwkJ
CXNpemVvZihwLT5udW1hX2ZhdWx0c19sb2NhbGl0eSkpOwogCQlyZXR1cm47CiAJfQogCi0tIAoy
LjI1LjE=

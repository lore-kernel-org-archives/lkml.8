Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00CDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 03:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C3AE20759
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 03:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="I58nrlo8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgG1DUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 23:20:08 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:5094 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726620AbgG1DUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 23:20:07 -0400
X-UUID: f8d60d4d80cc4b638e1ddc5c08e7b297-20200728
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=GjxkIM1k042UVhE+KHYwiPMh+DeoglMOkaNl5efUmuI=;
        b=I58nrlo8AS3MmTwFC6QbCDOnllml4oeXTJQnyTnqCIop886oT9/V6PTwkiKWAlwLYNmXu2lPE2W8il8czR6el7LcNpw2hII+sInxP2Sk0E6gwlw6t4CI+5+1vpXNAORUuWPv5KKqd3ypHzV8Nc2MSM2356jkg7a7M7X26xlF91Q=;
X-UUID: f8d60d4d80cc4b638e1ddc5c08e7b297-20200728
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <frankie.chang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1122908193; Tue, 28 Jul 2020 11:20:06 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 28 Jul 2020 11:20:03 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 28 Jul 2020 11:20:00 +0800
From:   Frankie Chang <Frankie.Chang@mediatek.com>
To:     Todd Kjos <tkjos@google.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Jian-Min Liu <Jian-Min.Liu@mediatek.com>,
        Frankie Chang <Frankie.Chang@mediatek.com>
Subject: [PATCH v6] binder: transaction latency tracking for user build
Date:   Tue, 28 Jul 2020 11:19:58 +0800
Message-ID: <1595906401-11985-1-git-send-email-Frankie.Chang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1595252430.5899.6.camel@mtkswgap22>
References: <1595252430.5899.6.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E6DE5ABF50AF220296EFE4677D610D98FF0928400BA42DD430BEBA16C5A5101E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpDaGFuZ2UgZnJvbSB2NjoNCiAgLSBjaGFuZ2UgQ09ORklHX0JJTkRFUl9UUkFOU0FDVElPTl9M
QVRFTkNZX1RSQUNLSU5HIHR5cGUgZnJvbSBib29sIHRvIHRyaXN0YXRlDQogIC0gYWRkIGNvbW1l
bnRzIHRvIEB0aW1lc3RhbXAgYW5kIEB0diB1bmRlciBzdHJ1Y3QgYmluZGVyX3RyYW5zYWN0aW9u
DQogIC0gbWFrZSBiaW5kZXJfdHhuX2xhdGVuY3kgdGhyZXNob2xkIGNvbmZpZ3VyYWJsZQ0KICAt
IGVuaGFuY2UgbG9jayBwcm90ZWN0aW9uDQoNCkNoYW5nZSBmcm9tIHY1Og0KICAtIGNoYW5nZSBj
b25maWcgbmFtZSB0byB0aGUgcHJvcGVyIG9uZSwgQ09ORklHX0JJTkRFUl9UUkFOU0FDVElPTl9M
QVRFTkNZX1RSQUNLSU5HLg0KICAtIGNoYW5nZSB0cmFjZXBvaW50IG5hbWUgdG8gbW9yZSBkZXNj
cmlwdGl2ZSBvbmUsIHRyYWNlX2JpbmRlcl90eG5fbGF0ZW5jeV8oYWxsb2N8aW5mb3xmcmVlKQ0K
ICAtIGVuaGFuY2Ugc29tZSBsb2NrIHByb3RlY3Rpb24uDQoNCkNoYW5nZSBmcm9tIHY0Og0KICAt
IHNwbGl0IHVwIGludG8gcGF0Y2ggc2VyaWVzLg0KDQpDaGFuZ2UgZnJvbSB2MzoNCiAgLSB1c2Ug
dHJhY2Vwb2ludHMgZm9yIGJpbmRlcl91cGRhdGVfaW5mbyBhbmQgcHJpbnRfYmluZGVyX3RyYW5z
YWN0aW9uX2V4dCwNCiAgICBpbnN0ZWFkIG9mIGN1c3RvbSByZWdpc3RyYXRpb24gZnVuY3Rpb25z
Lg0KDQpDaGFuZ2UgZnJvbSB2MjoNCiAgLSBjcmVhdGUgdHJhbnNhY3Rpb24gbGF0ZW5jeSBtb2R1
bGUgdG8gbW9uaXRvciBzbG93IHRyYW5zYWN0aW9uLg0KDQpDaGFuZ2UgZnJvbSB2MToNCiAgLSBm
aXJzdCBwYXRjaHNldC4NCg==


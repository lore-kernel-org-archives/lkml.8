Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86ABC38A30
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 03:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98E1320782
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 03:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgDUDFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 23:05:12 -0400
Received: from m176149.mail.qiye.163.com ([59.111.176.149]:11373 "EHLO
        m176149.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbgDUDFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 23:05:12 -0400
X-Greylist: delayed 649 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Apr 2020 23:05:12 EDT
Received: from vivo.com (wm-9.qy.internal [127.0.0.1])
        by m176149.mail.qiye.163.com (Hmail) with ESMTP id 4E6B6282035;
        Tue, 21 Apr 2020 10:53:49 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AIQAfAC4CMyxqzOp-AElwKpD.3.1587437629306.Hmail.bernard@vivo.com>
To:     Christopher Lameter <cl@linux.com>
Cc:     Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@vivo.com
Subject: =?UTF-8?B?UmU6UmU6UmU6IFtQQVRDSF0ga21hbGxvY19pbmRleCBvcHRpbWl6YXRpb24oYWRkIGttYWxsb2MgbWF4IHNpemUgY2hlY2sp?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 157.0.31.122
In-Reply-To: <alpine.DEB.2.21.2004191642290.14792@www.lameter.com>
MIME-Version: 1.0
Received: from bernard@vivo.com( [157.0.31.122) ] by ajax-webmail ( [127.0.0.1] ) ; Tue, 21 Apr 2020 10:53:49 +0800 (GMT+08:00)
From:   =?UTF-8?B?6LW15Yab5aWO?= <bernard@vivo.com>
Date:   Tue, 21 Apr 2020 10:53:49 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVIS0JCQkJCT0lMTEJOT1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhMSEtPTE5LS0lMN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6Mio6HTo4Tzg2AgMKATQLVjo#FwwwCz9VSFVKTkNMT0hMTUhKSExLVTMWGhIXVRkeCRUaCR87
        DRINFFUYFBZFWVdZEgtZQVlKTkxVS1VISlVKSUlZV1kIAVlBSE9OTjcG
X-HM-Tid: 0a719aa7ef909395kuws4e6b6282035
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CuWPkeS7tuS6uu+8mkNocmlzdG9waGVyIExhbWV0ZXIgPGNsQGxpbnV4LmNvbT4K5Y+R6YCB5pel
5pyf77yaMjAyMC0wNC0yMCAwMDo0Mjo1NQrmlLbku7bkurrvvJoi6LW15Yab5aWOIiA8YmVybmFy
ZEB2aXZvLmNvbT4K5oqE6YCB5Lq677yaUGVra2EgRW5iZXJnIDxwZW5iZXJnQGtlcm5lbC5vcmc+
LERhdmlkIFJpZW50amVzIDxyaWVudGplc0Bnb29nbGUuY29tPixKb29uc29vIEtpbSA8aWFtam9v
bnNvby5raW1AbGdlLmNvbT4sQW5kcmV3IE1vcnRvbiA8YWtwbUBsaW51eC1mb3VuZGF0aW9uLm9y
Zz4sbGludXgtbW1Aa3ZhY2sub3JnLGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcsa2VybmVs
QHZpdm8uY29tCuS4u+mimO+8mlJlOlJlOiBbUEFUQ0hdIGttYWxsb2NfaW5kZXggb3B0aW1pemF0
aW9uKGFkZCBrbWFsbG9jIG1heCBzaXplIGNoZWNrKT5PbiBTYXQsIDE4IEFwciAyMDIwLCDotbXl
hpvlpY4gd3JvdGU6Cj4KPj4gU29ycnkgZm9yIHRoZSBtaXN1bmRlcnN0YW5kaW5nLgo+Cj5XaGF0
IG1pc3VuZGVyc3RhbmRpbmc/ClRoZXJlIGlzIG5vIGdhcCBub3cuCj4KPj4gQnV0IHRoZSBjdXJy
ZW50IGNvZGUgaXMgbm90LCBrbWFsbG9jX2luZGV4IHdpbGwgb25seSBiZSBCVUcoKSB3aGVuIGl0
IGV4Y2VlZHMgNjRNLgo+Cj5ZZXMgdGhhdCBpcyB3aGF0IHlvdSBtYXkgd2FudCB0byBmaXggYXMg
SSBzYWlkLgoKPllvdSBjb3VsZCBtb2RpZnkgdGhhdCB0byBjaGVjayBmb3IgS01BTExPQ19NQVhf
U0laRSB3aXRoIHNvbWUgbW9yZQo+Y29uZGl0aW9uYWxzIGJ1dCB0aGVuIGttYWxsb2NfaW5kZXgp
IGlzIHdyaXR0ZW4gc28gdGhhdCB0aGUgY29tcGlsZXIgZ2V0cwo+Y29uc3RhbnQgZm9sZGluZyBy
aWdodC4KRm9yIHRoaXMgcG9pbnQsIEkgYW0gYWZyYWlkIGkgZGlkbmB0IGNhdGNoIHlvdXIgaWRl
YS4KSSBhbSBub3Qgc3VyZSBob3cgdG8gbW9kaWZ5IGl0Li4uLgpJcyB0aGVyZSBzb21lIHNpbWls
YXIgY29kZSBpbXBsZW1lbnRhdGlvbiBpbiB0aGUga2VybmVs77yfCgpCUi8vYmVybmFyZAoKDQoN
Cg==

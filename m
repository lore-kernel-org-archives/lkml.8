Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166EAC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 10:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE58220B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 10:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgDUKNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 06:13:07 -0400
Received: from m139-178.yeah.net ([123.58.178.139]:14813 "EHLO
        m138-179.yeah.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725920AbgDUKNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 06:13:06 -0400
X-Greylist: delayed 557 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Apr 2020 06:13:06 EDT
Received: from vivo.com (wm-12.qy.internal [127.0.0.1])
        by mail-m127107.qiye.163.com (Hmail) with ESMTP id 54E4F82460;
        Tue, 21 Apr 2020 18:03:43 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AHEAGAB5CMixysy1ydkfyaqy.3.1587463423329.Hmail.wenhu.wang@vivo.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kernel@vivo.com, robh@kernel.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Scott Wood <oss@buserror.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCB2MixSRVNFTkRdIG1pc2M6IG5ldyBkcml2ZXIgc3JhbV91YXBpIGZvciB1c2VyIGxldmVsIFNSQU0gYWNjZXNz?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.251.74.227
In-Reply-To: <20200421093427.GC725219@kroah.com>
MIME-Version: 1.0
Received: from wenhu.wang@vivo.com( [58.251.74.227) ] by ajax-webmail ( [127.0.0.1] ) ; Tue, 21 Apr 2020 18:03:43 +0800 (GMT+08:00)
From:   =?UTF-8?B?546L5paH6JmO?= <wenhu.wang@vivo.com>
Date:   Tue, 21 Apr 2020 18:03:43 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUlXWQgYFAkeWUFZTVVITkxCQkJISU9MQkNOQ1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhMSE9JSk9ISkJIN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6Mz46PDo5Tjg2EgMCCAJKAh8QHQIaCgJVSFVKTkNMT01IT0lDT0pKVTMWGhIXVQweFRMOVQwa
        FRw7DRINFFUYFBZFWVdZEgtZQVlOQ1VJTkpVTE9VSUlMWVdZCAFZQUhCTkw3Bg++
X-HM-Tid: 0a719c31857c986bkuuu54e4f82460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pk9uIFR1ZSwgQXByIDIxLCAyMDIwIGF0IDA1OjA5OjQ3UE0gKzA4MDAsIOeOi+aWh+iZjiB3cm90
ZToKPj4gSGksIEdyZWcsIEFybmQsCj4+IAo+PiBUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudHMg
Zmlyc3QsIGFuZCB0aGVuIHJlYWxseSB2ZXJ5IHZlcnkgdmVyeSBzb3JyeQo+PiBmb3IgZHJpdmlu
ZyBHcmVnIHRvIHNpZ2ggYW5kIEkgaG9wZSB0aGVyZSB3b3VsZCBiZSBjaGFuY2UgdG8gc2hhcmUg
TW91dGFpCj4+IChyYXRoZXIgdGhhbiB3aGlza3ksIHdlIGRyaW5rIGl0IG11Y2gsIGEga2luZCBv
ZiBCYWlqaXUpLCBhZnRlciB0aGUgdmlydXMuCj4+IAo+PiBCYWNrIHRvIHRoZSBjb21tZW50cywg
SSdkIGxpa2UgdG8gZG8gYSBiaXQgb2YgZG9jdW1lbnRhdGlvbiBvciBleHBsYW5hdGlvbiBmaXJz
dCwKPj4gd2hpY2ggc2hvdWxkIGhhdmUgYmVlbiBkb25lIGVhcmx5IG9yIGVsc2UgdGhlcmUgd291
bGQgbm90IGJlIHNvIG11Y2ggdG8gZXhwbGFpbjoKPj4gMS4gV2hhdCBJIGhhdmUgYmVlbiB0cnlp
bmcgdG8gZG8gaXMgdG8gYWNjZXNzIHRoZSBGcmVlc2NhbGUgQ2FjaGUtU1JBTSBkZXZpY2UgZm9y
bQo+PiB1c2VyIGxldmVsOwo+PiAyLiBJIGltcGxlbWVudGVkIGl0IHVzaW5nIFVJTywgd2hpY2gg
d2FzIHRob3VnaHQgb2Ygbm9uLXByb3BlcjsKPgo+SSBzdGlsbCB0aGluayB0aGF0IHVzaW5nIHVp
byBpcyB0aGUgYmVzdCB3YXkgdG8gZG8gdGhpcywgYW5kIG5ldmVyIHNhaWQKPml0IHdhcyAibm9u
LXByb3BlciIuICBBbGwgd2UgZ290IGJvZ2dlZCBkb3duIGluIHdhcyB0aGUgRFQKPnJlcHJlc2Vu
dGF0aW9uIG9mIHN0dWZmIGZyb20gd2hhdCBJIHJlbWVtYmVyLiAgVGhhdCBzaG91bGQgYmUgd29y
a2VkCj50aHJvdWdoLgo+Cj50aGFua3MsCj4KPmdyZWcgay1oCgpTdXJlbHksIGJ1dCBzbyBob3cg
d291bGQgdGhpbmdzIGdvPyBTY290dCBzYWlkIG5vdCBmaXQgZm9yIGhpbS4gQW5kIGhlIHdhcwpn
b25uYSB0byB3cml0ZSBhIG5ldyBwYXRjaChPaCwgIHRoYXQgaXMgd2hhdCBJIGhhdmUgYmVlbiBk
b2luZy4uLi4uLGFuZCBJIHJlYWxseQpkb25vdCB0aGluayBoZSBuZWVkIHRvIGRvIGl0KQoKVGhp
cyBpcyB0aGUgZmluYWwgdmVyc2lvbiB1c2luZyBVSU8sIGFuZCBldmVuIENocmlzdG9waGUgaGFk
IFJldmlld2VkLWJ5LApodHRwczovL2xvcmUua2VybmVsLm9yZy9wYXRjaHdvcmsvcGF0Y2gvMTIy
NjIyNS8KCklmIG5vIGVuZGluZyByZWFjaGVzLCBJIGhhdmUgdG8gbWFrZSBhIHN0ZXAgZm9yd2Fy
ZCB0byBrZWVwIHdvcmtpbmcgd2l0aAp0aGUgbWlzYyBkZXZpY2UgdmVyc2lvbi4KClRoYW5rcywg
YW5kIHJlZ2FyZHMsCldlbmh1Cg0KDQo=

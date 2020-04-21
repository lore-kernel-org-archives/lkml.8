Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEC9C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 01:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06621206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 01:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgDUBxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 21:53:37 -0400
Received: from m176150.mail.qiye.163.com ([59.111.176.150]:16803 "EHLO
        m176150.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgDUBxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 21:53:36 -0400
Received: from vivo.com (wm-10.qy.internal [127.0.0.1])
        by m176150.mail.qiye.163.com (Hmail) with ESMTP id 567F51A2E07;
        Tue, 21 Apr 2020 09:46:16 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ACIAcQDuCE8x4hTnQF3SYapx.3.1587433576293.Hmail.luochucheng@vivo.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     alex.shi@linux.alibaba.com, Harry Wei <harryxiyou@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSCB2NixSRVNFTkRdIFRyYW5zbGF0ZSBkZWJ1Z2ZzLnR4dCBpbnRvIENoaW5lc2UgYW5kIGxpbmsgaXQgdG8gdGhlIGluZGV4Lg==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.251.74.226
In-Reply-To: <20200420171042.66462fe0@lwn.net>
MIME-Version: 1.0
Received: from luochucheng@vivo.com( [58.251.74.226) ] by ajax-webmail ( [127.0.0.1] ) ; Tue, 21 Apr 2020 09:46:16 +0800 (GMT+08:00)
From:   =?UTF-8?B?572X5qWa5oiQ?= <luochucheng@vivo.com>
Date:   Tue, 21 Apr 2020 09:46:16 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VKQklCQkJDSEJMQ0lMSllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kJHlYWEh9ZQUhMSElDSkxJTU1NN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6ODI6GCo*Djg#QwNPEy8VKj1IKCIaCwNVSFVKTkNMT0hITkxNT0pCVTMWGhIXVRcOFBgTDhgT
        HhUcOw0SDRRVGBQWRVlXWRILWUFZTkNVSU5KVUxPVUlJTVlXWQgBWUFITkpONwY+
X-HM-Tid: 0a719a6a17a993b4kuws567f51a2e07
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ClN1cmUsIEkgd2lsbCBkbyB0aGF0LgoKCgoKRnJvbTogSm9uYXRoYW4gQ29yYmV0IDxjb3JiZXRA
bHduLm5ldD4KRGF0ZTogMjAyMC0wNC0yMSAwNzoxMDo0MgpUbzogIENodWNoZW5nIEx1byA8bHVv
Y2h1Y2hlbmdAdml2by5jb20+CkNjOiAgYWxleC5zaGlAbGludXguYWxpYmFiYS5jb20sSGFycnkg
V2VpIDxoYXJyeXhpeW91QGdtYWlsLmNvbT4sbGludXgtZG9jQHZnZXIua2VybmVsLm9yZyxsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLG9wZW5zb3VyY2Uua2VybmVsQHZpdm8uY29tClN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjYsUkVTRU5EXSBUcmFuc2xhdGUgZGVidWdmcy50eHQgaW50byBDaGlu
ZXNlIGFuZCBsaW5rIGl0IHRvIHRoZSBpbmRleC4+T24gV2VkLCAgOCBBcHIgMjAyMCAxMDoxNTox
OCArMDgwMAo+Q2h1Y2hlbmcgTHVvIDxsdW9jaHVjaGVuZ0B2aXZvLmNvbT4gd3JvdGU6Cj4KPj4g
VHJhbnNsYXRlIERvY3VtZW50YXRpb24vZmlsZXN5c3RlbXMvZGVidWdmcy50eHQgaW50byBDaGlu
ZXNlLgo+PiAKPj4gU2lnbmVkLW9mZi1ieTogQ2h1Y2hlbmcgTHVvIDxsdW9jaHVjaGVuZ0B2aXZv
LmNvbT4KPj4gLS0tCj4+IENoYW5nZWxvZzoKPj4gdjY6Cj4+ICAtIGtlZXAgZWFjaCBsaW5lIGxl
c3MgdGhhbiA4MCBjaGFycywgYnV0IGFsc28ga2VlcCBlYWNoIGxpbmUgZnVsbAo+PiAgLSByZW1v
dmUgcmVkdW5kYW50ICc9JyBpbiBjYXB0aW9uIGFuZCBhbGwgb3RoZXIgc3ViaGVhZGluZ3MKPj4g
IC0gc2VuZCB0aGUgcGF0Y2ggd2l0aCAnY2hhcnNldD1VVEYtOCcKPgo+SSB3ZW50IHRvIGFwcGx5
IHRoaXMganVzdCBub3csIGJ1dCBubyBzdWNoIGx1Y2s7IHRoaXMgcGF0Y2ggdHJpZXMgdG8KPmNy
ZWF0ZSBhbiBpbmRleC5yc3QgZmlsZSwgYnV0IGl0J3MgYWxyZWFkeSB0aGVyZSBkdWUgdG8gYW5v
dGhlciBwYXRjaCB0aGF0Cj53ZW50IGluIGp1c3Qgb3ZlciBhIG1vbnRoIGFnby4gIEkgcmVhbGx5
IGRvbid0IHdhbnQgdG8gdHJ5IHRvIHJlc29sdmUgYQo+bWVyZ2UgY29uZmxpY3QgaW4gYSBmaWxl
IEkgY2FuJ3QgcmVhZC4uLmNvdWxkIEkgYXNrIHlvdSwgcGxlYXNlLCB0byByZWJhc2UKPnRoaXMg
cGF0Y2ggb24gdG9wIG9mIGN1cnJlbnQgZG9jcy1uZXh0LCB0aGVuIHN1Ym1pdCBvbmUgbW9yZSB0
aW1lPwo+Cj5UaGFua3MsCj4KPmpvbgoNCg0K

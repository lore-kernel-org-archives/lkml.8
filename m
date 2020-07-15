Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A343C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77DEE206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 10:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=126.com header.i=@126.com header.b="qNZeMWYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgGOKqB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 06:46:01 -0400
Received: from m1546.mail.126.com ([220.181.15.46]:63461 "EHLO
        m1546.mail.126.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729284AbgGOKqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 06:46:00 -0400
X-Greylist: delayed 386 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jul 2020 06:45:57 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=mzvz0
        4rM4BvMtyWqIGQECIt7tv5mDfJVjcsxyqY3H0w=; b=qNZeMWYCP4rUjNwW77aMr
        qbGJyq14PmXoECL0tiUlo3dTL4htcqVYKCtMVNms2ZXxa7VBkCLt0w5qq43q3Cwi
        QiqHQKmw8dBgzQd9SCa103QnGa1RZXzpRkO6WoAmBFDmjzRJSaa1ETK9eqBzzq0B
        POGTQIQ6zajAFIqh4IX/bg=
Received: from zhixu001$126.com ( [209.8.147.252] ) by ajax-webmail-wmsvr46
 (Coremail) ; Wed, 15 Jul 2020 18:45:21 +0800 (CST)
X-Originating-IP: [209.8.147.252]
Date:   Wed, 15 Jul 2020 18:45:21 +0800 (CST)
From:   Zhao <zhixu001@126.com>
To:     "Joe Perches" <joe@perches.com>,
        "Dan Carpenter" <dan.carpenter@oracle.com>,
        "Greg KH" <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        rcy@google.com, rspringer@google.com, toddpoynor@google.com
Subject: Re:Re: [PATCH v2] staging: gasket: core: Fix a coding style issue
 in gasket_core.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10 build 20190724(ac680a23)
 Copyright (c) 2002-2020 www.mailtech.cn 126com
In-Reply-To: <128a9f7de9885257736b3bb2648ea90bcbc2c760.camel@perches.com>
References: <20200617161127.32006-1-zhixu001@126.com>
 <20200714234440.27009-1-zhixu001@126.com>
 <20200715071748.GC2305231@kroah.com>
 <23ef3ca9616418b702df891443d0f4864edd58ff.camel@perches.com>
 <20200715075755.GA2516028@kroah.com> <20200715083727.GY2549@kadam>
 <128a9f7de9885257736b3bb2648ea90bcbc2c760.camel@perches.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <7d0444ff.5c46.17352142e11.Coremail.zhixu001@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: LsqowADnPQVB3g5f9grRAA--.30433W
X-CM-SenderInfo: x2kl53qqqrqiyswou0bp/1tbiZwBifF16eYfrGQACsQ
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QXQgMjAyMC0wNy0xNSAxNzowNDowNiwgIkpvZSBQZXJjaGVzIiA8am9lQHBlcmNoZXMuY29tPiB3
cm90ZToKPk9uIFdlZCwgMjAyMC0wNy0xNSBhdCAxMTozNyArMDMwMCwgRGFuIENhcnBlbnRlciB3
cm90ZToKPj4gT24gV2VkLCBKdWwgMTUsIDIwMjAgYXQgMDk6NTc6NTVBTSArMDIwMCwgR3JlZyBL
SCB3cm90ZToKPj4gPiBPbiBXZWQsIEp1bCAxNSwgMjAyMCBhdCAxMjoyNDoyMkFNIC0wNzAwLCBK
b2UgUGVyY2hlcyB3cm90ZToKPj4gPiA+IE9uIFdlZCwgMjAyMC0wNy0xNSBhdCAwOToxNyArMDIw
MCwgR3JlZyBLSCB3cm90ZToKPj4gPiA+ID4gT24gV2VkLCBKdWwgMTUsIDIwMjAgYXQgMDc6NDQ6
NDBBTSArMDgwMCwgWmhpeHUgWmhhbyB3cm90ZToKPj4gPiA+ID4gPiBPbiBUaHUsIEp1biAxOCwg
MjAyMCBhdCAxMjoxMToyN0FNICswODAwLCBaaGl4dSBaaGFvIHdyb3RlOgo+PiA+ID4gPiA+ID4g
QSBjb2RpbmcgYWxpZ25tZW50IGlzc3VlIGlzIGZvdW5kIGJ5IGNoZWNrcGF0Y2gucGwuCj4+ID4g
PiA+ID4gPiBGaXggaXQgYnkgdXNpbmcgYSB0ZW1wb3JhcnkgZm9yIGdhc2tldF9kZXYtPmJhcl9k
YXRhW2Jhcl9udW1dLgo+PiA+ID4gPiA+ID4gCj4+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBa
aGl4dSBaaGFvIDx6aGl4dTAwMUAxMjYuY29tPgo+PiA+ID4gPiA+IAo+PiA+ID4gPiA+IEhpLCB0
aGVyZX4KPj4gPiA+ID4gPiAKPj4gPiA+ID4gPiBEb2VzIGFueWJvZHkgaGF2ZSBhbnkgZnVydGhl
ciBjb21tZW50cyBvbiB0aGlzPwo+PiA+ID4gPiA+IENhbiBpdCBiZSBtZXJnZWQ/Cj4+ID4gPiA+
IAo+PiA+ID4gPiBJIG5ldmVyIHNhdyB0aGUgZmlyc3QgdmVyc2lvbiBvZiB0aGlzLCBhcmUgeW91
IHN1cmUgaXQgZ290IHNlbnQgdG8gdGhlCj4+ID4gPiA+IG1haWxpbmcgbGlzdD8gIEl0J3Mgbm90
IGluIGFueSBhcmNoaXZlcyBhbnl3aGVyZS4KPj4gPiA+IAo+PiA+ID4gSSBzYXcgaXQuICBJdCdz
IGhlcmU6Cj4+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjAwNjE3MTYxMTI3
LjMyMDA2LTEtemhpeHUwMDFAMTI2LmNvbS8KPj4gPiAKPj4gPiBBaCwgZG9oLCBzb3JyeS4KPj4g
PiAKPj4gPiBaaGl4dSwgcGxlYXNlIGFkZHJlc3MgdGhlIGNvbW1lbnRzIGdpdmVuIHRvIHlvdSBv
biB0aGUgc2VyaWVzIGFuZCByZXNlbmQKPj4gPiBpdCBhcyBhIG5ldyB2ZXJzaW9uLgo+PiAKPj4g
SGUgcmVzcG9uZGVkIGJ1dCBub3QgYXMgYSByZXBseSB0byBteSBlbWFpbC4gIEl0IHR1cm5zIG91
dCBJIG1hZGUgYQo+PiBtaXN0YWtlLgo+PiAKPj4gQW55d2F5LCBqdXN0IHJlc2VuZCwgWmhpeHUu
Cj4KPkl0J3MgYSBwaXR5IGEgcmVzZW5kIGlzIGJlaW5nIHJlcXVlc3RlZC4KPgo+SXQnZCBiZSBh
IGJldHRlciBwcm9jZXNzIGlmIHRoZSBvcmlnaW5hbCBwYXRjaCBjb3VsZAo+YmUgYXBwbGllZCB2
aWEgdGhlIGxpbmsgYWtpbiB0byBhIGdpdCBwdWxsLgo+CgpZZXMuIEFsbCBjb21tZW50cyBoYXZl
IGJlZW4gcmVzb2x2ZWQgYnkgbm93LiBQYXRjaCB2MiBpcyBzdWZmaWNpZW50LgoKQXMgRGFuIHNh
aWQsIHRoZXJlIHdhcyBhIHRhaWxpbmcgdGhyZWFkIGJlY2F1c2UgSSBtaXMtcmVwbGllZCBoaXMg
bWFpbC4KIEkganVzdCBub3cgcmVwbGllZCB0aGF0IG1haWwgd2l0aCBhIHJlZmVyZW5jZSB0byB0
aGUgZmluYWwgcmVzb2x1dGlvbiBtYWlsLgo=

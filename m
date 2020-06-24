Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC7BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AF3E20768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389088AbgFXGW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:22:29 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:53592 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388090AbgFXGW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:22:28 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DW;RN=7;SR=0;TI=W4_5899425_DEFAULT_0AB1016B_1592979481825_o7001c244;
Received: from WS-web (baolin.wang@linux.alibaba.com[W4_5899425_DEFAULT_0AB1016B_1592979481825_o7001c244]) by e01f04396.eu6 at Wed, 24 Jun 2020 14:22:24 +0800
Date:   Wed, 24 Jun 2020 14:22:24 +0800
From:   "Baolin Wang" <baolin.wang@linux.alibaba.com>
To:     "Christoph Hellwig" <hch@lst.de>
Cc:     "kbusch" <kbusch@kernel.org>, "axboe" <axboe@fb.com>,
        "sagi" <sagi@grimberg.me>, "baolin.wang7" <baolin.wang7@gmail.com>,
        "linux-nvme" <linux-nvme@lists.infradead.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Reply-To: "Baolin Wang" <baolin.wang@linux.alibaba.com>
Message-ID: <0cc93c56-57ba-42d7-8af9-348076e9d3ea.baolin.wang@linux.alibaba.com>
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAyLzNdIG52bWUtcGNpOiBBZGQgY29udHJvbGxlciBtZW1vcnkgYnVmZmVy?=
  =?UTF-8?B?IHN1cHBvcnRlZCBtYWNybw==?=
X-Mailer: [Alimail-Mailagent][W4_5899425][DEFAULT][Chrome]
MIME-Version: 1.0
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com> <eab18c7696ea0e34a6ab0371d7d17ad45d1566ce.1592916850.git.baolin.wang@linux.alibaba.com> <20200623162751.GA4846@lst.de>,<20200624020716.GB40094@VM20190228-100.tbsite.net>
x-aliyun-mail-creator: W4_5899425_DEFAULT_LjMTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgMTAuMDsgV2luNjQ7IHg2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzgzLjAuNDEwMy45NyBTYWZhcmkvNTM3LjM2TM
In-Reply-To: <20200624020716.GB40094@VM20190228-100.tbsite.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBPbiBUdWUsIEp1biAyMywgMjAyMCBhdCAwNjoyNzo1MVBNICswMjAwLCBDaHJpc3RvcGggSGVs
bHdpZyB3cm90ZToKPiA+IE9uIFR1ZSwgSnVuIDIzLCAyMDIwIGF0IDA5OjI0OjMzUE0gKzA4MDAs
IEJhb2xpbiBXYW5nIHdyb3RlOgo+ID4gPiBJbnRyb2R1Y2UgYSBuZXcgY2FwYWJpbGl0eSBtYWNy
byB0byBpbmRpY2F0ZSBpZiB0aGUgY29udHJvbGxlcgo+ID4gPiBzdXBwb3J0cyB0aGUgbWVtb3J5
IGJ1ZmZlciBvciBub3QsIGluc3RlYWQgb2YgcmVhZGluZyB0aGUKPiA+ID4gTlZNRV9SRUdfQ01C
U1ogcmVnaXN0ZXIuCj4gPiAKPiA+IFRoaXMgaXMgYSBjb21wbGV4IGlzc3VlLiAgVGhlIENNQlMg
Yml0IHdhcyBvbmx5IGFkZGVkIGluIE5WTWUgMS40IGFzCj4gPiBhIGJhY2t3YXJkcyBpbmNvbXBh
dGlibGUgY2hhbmdlLCBhcyB0aGUgQ01CIGFkZHJlc3Npbmcgc2NoZW1lIGNhbiBsZWFkCj4gCj4g
QWgsIHJpZ2h0LCBJIHRoaW5rIEkgc2hvdWxkIGFkZCBhbm90aGVyIHZlcnNpb24gY29uZGl0aW9u
Ogo+IGlmICgoY3RybC0+dnMgPj0gTlZNRV9WUygxLCA0LCAwKSAmJiAhTlZNRV9DQVBfQ01CUyhk
ZXYtPmN0cmwuY2FwKSkgfHwKPiAgICAgZGV2LT5jbWJfc2l6ZSkKPiAgICByZXR1cm47CgpBZnRl
ciBtb3JlIHRoaW5raW5nLCBub3cgd2Ugc2hvdWxkIHJlYWQgTlZNRV9SRUdfVlMgcmVnaXN0ZXIg
dG8gZ2V0IHRoZSBjb250cm9sbGVyIHZlcnNpb24Kd2hlbiB1c2luZyB0aGUgQ01CUyBiaXQgaW4g
Q2FwYWJpbGl0aWVzIHJlZ2lzdGVyLCB0aGVyZSBpcyBubyBiZW5lZml0LCBzbyBJJ2xsIGRyb3Ag
dGhpcyBwYXRjaC4gVGhhbmtzLgoKPiA+IHRvIGRhdGEgY29ycnVwdGlvbi4gIFRoZSBDTUJTIHdh
cyBhZGRlZCBhcyBwYXJ0IG9mIHRoZSBob3JyaWJlIGhhY2sKPiA+IHRoYXQgYWxzbyBpbnZvbHZl
cyB0aGUgQ0JBIGZpZWxkLCB3aGljaCB3ZSdsbCBuZWVkIHRvIHNlZSBiZWZvcmUKPiA+IHVzaW5n
IGl0IHRvIHdvcmsgYXJvdW5kIHRoZSBhZGRyZXNzaW5nIGlzc3VlLiAgQXQgdGhlIHNhbWUgdGlt
ZSB3ZQo+ID4gc2hvdWxkIGFsc28gY29udGludWUgc3VwcG9ydGluZyB0aGUgbGVnYWN5IHByZS0x
LjQgQ01CIHdpdGggYSB3YXJuaW5nCj4gPiAoYW5kIG1heSByZWplY3QgaXQgaWYgd2Uga25vdyB3
ZSBydW4gaW4gYSBWTSku

Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A24C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7EBD2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 21:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436698AbgE1Vn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 17:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436581AbgE1VnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 17:43:24 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8118C08C5C6;
        Thu, 28 May 2020 14:43:24 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 38986129654F1;
        Thu, 28 May 2020 14:43:22 -0700 (PDT)
Date:   Thu, 28 May 2020 14:43:19 -0700 (PDT)
Message-Id: <20200528.144319.2125126279324542556.davem@davemloft.net>
To:     doshir@vmware.com
Cc:     kuba@kernel.org, netdev@vger.kernel.org, Pv-drivers@vmware.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 3/4] vmxnet3: add geneve and vxlan tunnel
 offload support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <C3E924AA-41B4-437E-BC7A-181028E5CFE9@vmware.com>
References: <20200528183615.27212-4-doshir@vmware.com>
        <20200528123505.25baf888@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
        <C3E924AA-41B4-437E-BC7A-181028E5CFE9@vmware.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 28 May 2020 14:43:22 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUm9uYWsgRG9zaGkgPGRvc2hpckB2bXdhcmUuY29tPg0KRGF0ZTogVGh1LCAyOCBNYXkg
MjAyMCAyMToxODozNCArMDAwMA0KDQo+IA0KPiDvu79PbiA1LzI4LzIwLCAxMjozNSBQTSwgIkph
a3ViIEtpY2luc2tpIiA8a3ViYUBrZXJuZWwub3JnPiB3cm90ZToNCj4+ICAgIE9uIFRodSwgMjgg
TWF5IDIwMjAgMTE6MzY6MTQgLTA3MDAgUm9uYWsgRG9zaGkgd3JvdGU6DQo+PiAgICA+IEBAIC0x
MTY4LDEzICsxMjIwLDIxIEBAIHZteG5ldDNfcnhfY3N1bShzdHJ1Y3Qgdm14bmV0M19hZGFwdGVy
ICphZGFwdGVyLA0KPj4gICAgPiAgCQkgICAgKGxlMzJfdG9fY3B1KGdkZXNjLT5kd29yZFszXSkg
Jg0KPj4gICAgPiAgCQkgICAgIFZNWE5FVDNfUkNEX0NTVU1fT0spID09IFZNWE5FVDNfUkNEX0NT
VU1fT0spIHsNCj4+ICAgID4gIAkJCXNrYi0+aXBfc3VtbWVkID0gQ0hFQ0tTVU1fVU5ORUNFU1NB
Ulk7DQo+PiAgICA+IC0JCQlCVUdfT04oIShnZGVzYy0+cmNkLnRjcCB8fCBnZGVzYy0+cmNkLnVk
cCkpOw0KPj4gICAgPiAtCQkJQlVHX09OKGdkZXNjLT5yY2QuZnJnKTsNCj4+ICAgID4gKwkJCUJV
R19PTighKGdkZXNjLT5yY2QudGNwIHx8IGdkZXNjLT5yY2QudWRwKSAmJg0KPj4gICAgPiArCQkJ
ICAgICAgICEobGUzMl90b19jcHUoZ2Rlc2MtPmR3b3JkWzBdKSAmDQo+PiAgICA+ICsJCQkJICgx
VUwgPDwgVk1YTkVUM19SQ0RfSERSX0lOTkVSX1NISUZUKSkpOw0KPj4gICAgPiArCQkJQlVHX09O
KGdkZXNjLT5yY2QuZnJnICYmDQo+PiAgICA+ICsJCQkgICAgICAgIShsZTMyX3RvX2NwdShnZGVz
Yy0+ZHdvcmRbMF0pICYNCj4+ICAgID4gKwkJCQkgKDFVTCA8PCBWTVhORVQzX1JDRF9IRFJfSU5O
RVJfU0hJRlQpKSk7DQo+PiAgICANCj4+ICAgIFNlZW1zIGZhaXJseSBleHRyZW1lIHRvIHRyaWdn
ZXIgQlVHX09OcyBpZiByeCBkZXNjcmlwdG9yIGRvZXNuJ3QNCj4+ICAgIGNvbnRhaW4gdmFsaWQg
Y2hlY2tzdW0gb2ZmbG9hZCBmbGFncyA6UyBXQVJOX09OX09OQ0UoKSBhbmQgaWdub3JlIA0KPj4g
ICAgY2hlY3N1bSBvciBkcm9wIHBhY2tldCB3b3VsZCBiZSBtb3JlIHRoYW4gc3VmZmljaWVudC4N
Cj4gICAgIA0KPiBIZWxsbyBKYWt1YiwNCj4gDQo+IEdvb2QgcG9pbnQuIEhvd2V2ZXIsIEkgZGlk
IG5vdCB3YW50IHRvIGNoYW5nZSB0aGUgYmVoYXZpb3IgaW4gdGhpcyBwYXRjaCwNCj4gc28ga2Vw
dCBpdCBhcyBpcy4gSWYgcmVxdWlyZWQsIHRoaXMgY2FuIGJlIGRvbmUgaW4gZnV0dXJlIHNlcGFy
YXRlIHBhdGNoLg0KDQpJdCdzIHJlYWxseSBhd2Z1bCB0byBraWxsIHNvIG11Y2ggb2YgdGhlIHN5
c3RlbSBiZWNhdXNlIG9mIGEgZmxpcHBlZCBiaXQNCmluIGEgZGVzY3JpcHRvci4NCg0KUGxlYXNl
IGZpeCB0aGlzIGFzIHdlbGwgYXMgYWRkcmVzcyBNaWNoYWwncyBmZWVkYmFjay4NCg0KVGhhbmtz
Lg0K

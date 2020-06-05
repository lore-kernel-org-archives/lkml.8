Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5AEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFA7220B80
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 20:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgFEUTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 16:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgFEUTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 16:19:10 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53D3C08C5C3;
        Fri,  5 Jun 2020 13:19:10 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 46247127B0DEB;
        Fri,  5 Jun 2020 13:19:10 -0700 (PDT)
Date:   Fri, 05 Jun 2020 13:19:09 -0700 (PDT)
Message-Id: <20200605.131909.2193174516678185073.davem@davemloft.net>
To:     sgarzare@redhat.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        jhansen@vmware.com, kuba@kernel.org
Subject: Re: [PATCH net] vsock/vmci: make vmci_vsock_transport_cb() static
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200605151241.468292-1-sgarzare@redhat.com>
References: <20200605151241.468292-1-sgarzare@redhat.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 05 Jun 2020 13:19:10 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPg0KRGF0ZTogRnJp
LCAgNSBKdW4gMjAyMCAxNzoxMjo0MSArMDIwMA0KDQo+IEZpeCB0aGUgZm9sbG93aW5nIGdjYy05
LjMgd2FybmluZyB3aGVuIGJ1aWxkaW5nIHdpdGggJ21ha2UgVz0xJzoNCj4gICAgIG5ldC92bXdf
dnNvY2svdm1jaV90cmFuc3BvcnQuYzoyMDU4OjY6IHdhcm5pbmc6IG5vIHByZXZpb3VzIHByb3Rv
dHlwZQ0KPiAgICAgICAgIGZvciChdm1jaV92c29ja190cmFuc3BvcnRfY2KiIFstV21pc3Npbmct
cHJvdG90eXBlc10NCj4gICAgICAyMDU4IHwgdm9pZCB2bWNpX3Zzb2NrX3RyYW5zcG9ydF9jYihi
b29sIGlzX2hvc3QpDQo+ICAgICAgICAgICB8ICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4N
Cj4gDQo+IEZpeGVzOiBiMWJiYTgwYTQzNzYgKCJ2c29jay92bWNpOiByZWdpc3RlciB2bWNpX3Ry
YW5zcG9ydCBvbmx5IHdoZW4gVk1DSSBndWVzdC9ob3N0IGFyZSBhY3RpdmUiKQ0KPiBSZXBvcnRl
ZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4NCg0KQXBwbGllZCwgdGhh
bmsgeW91Lg0K

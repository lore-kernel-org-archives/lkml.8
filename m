Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5703C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 00:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F56E21883
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 00:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbgGNADk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 20:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgGNADj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 20:03:39 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB51C061755;
        Mon, 13 Jul 2020 17:03:39 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 43BF71297FB30;
        Mon, 13 Jul 2020 17:03:39 -0700 (PDT)
Date:   Mon, 13 Jul 2020 17:03:38 -0700 (PDT)
Message-Id: <20200713.170338.67090817978996414.davem@davemloft.net>
To:     geert@linux-m68k.org
Cc:     kuba@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: hso: Fix debug compile warning on sparc32
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200713110513.10651-1-geert@linux-m68k.org>
References: <20200713110513.10651-1-geert@linux-m68k.org>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-7
Content-Transfer-Encoding: base64
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 13 Jul 2020 17:03:39 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydEBsaW51eC1tNjhrLm9yZz4NCkRhdGU6IE1v
biwgMTMgSnVsIDIwMjAgMTM6MDU6MTMgKzAyMDANCg0KPiBPbiBzcGFyYzMyLCB0Y2ZsYWdfdCBp
cyAidW5zaWduZWQgbG9uZyIsIHVubGlrZSBvbiBhbGwgb3RoZXINCj4gYXJjaGl0ZWN0dXJlcywg
d2hlcmUgaXQgaXMgInVuc2lnbmVkIGludCI6DQo+IA0KPiAgICAgZHJpdmVycy9uZXQvdXNiL2hz
by5jOiBJbiBmdW5jdGlvbiChaHNvX3NlcmlhbF9zZXRfdGVybWlvc6I6DQo+ICAgICBpbmNsdWRl
L2xpbnV4L2tlcm5fbGV2ZWxzLmg6NToxODogd2FybmluZzogZm9ybWF0IKElZKIgZXhwZWN0cyBh
cmd1bWVudCBvZiB0eXBlIKF1bnNpZ25lZCBpbnSiLCBidXQgYXJndW1lbnQgNCBoYXMgdHlwZSCh
dGNmbGFnX3Qge2FrYSBsb25nIHVuc2lnbmVkIGludH2iIFstV2Zvcm1hdD1dDQo+ICAgICBkcml2
ZXJzL25ldC91c2IvaHNvLmM6MTM5MzozOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8goWhz
b19kYmeiDQo+ICAgICAgICBoc29fZGJnKDB4MTYsICJUZXJtaW9zIGNhbGxlZCB3aXRoOiBjZmxh
Z3MgbmV3WyVkXSAtIG9sZFslZF1cbiIsDQo+ICAgICAgICBefn5+fn5+DQo+ICAgICBpbmNsdWRl
L2xpbnV4L2tlcm5fbGV2ZWxzLmg6NToxODogd2FybmluZzogZm9ybWF0IKElZKIgZXhwZWN0cyBh
cmd1bWVudCBvZiB0eXBlIKF1bnNpZ25lZCBpbnSiLCBidXQgYXJndW1lbnQgNSBoYXMgdHlwZSCh
dGNmbGFnX3Qge2FrYSBsb25nIHVuc2lnbmVkIGludH2iIFstV2Zvcm1hdD1dDQo+ICAgICBkcml2
ZXJzL25ldC91c2IvaHNvLmM6MTM5MzozOiBub3RlOiBpbiBleHBhbnNpb24gb2YgbWFjcm8goWhz
b19kYmeiDQo+ICAgICAgICBoc29fZGJnKDB4MTYsICJUZXJtaW9zIGNhbGxlZCB3aXRoOiBjZmxh
Z3MgbmV3WyVkXSAtIG9sZFslZF1cbiIsDQo+ICAgICAgICBefn5+fn5+DQo+IA0KPiBBcyAidW5z
aWduZWQgbG9uZyIgaXMgMzItYml0IG9uIHNwYXJjMzIsIGZpeCB0aGlzIGJ5IGNhc3RpbmcgYWxs
IHRjZmxhZ190DQo+IHBhcmFtZXRlcnMgdG8gInVuc2lnbmVkIGludCIuDQo+IFdoaWxlIGF0IGl0
LCB1c2UgIiV1IiB0byBmb3JtYXQgdW5zaWduZWQgbnVtYmVycy4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEdlZXJ0IFV5dHRlcmhvZXZlbiA8Z2VlcnRAbGludXgtbTY4ay5vcmc+DQoNCkFwcGxpZWQs
IHRoYW5rcy4NCg==

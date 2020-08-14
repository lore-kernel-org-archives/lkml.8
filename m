Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9350C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 02:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFD222078B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 02:27:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHNC1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 22:27:51 -0400
Received: from mail.loongson.cn ([114.242.206.163]:33410 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726546AbgHNC1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 22:27:51 -0400
Received: by ajax-webmail-mail.loongson.cn (Coremail) ; Fri, 14 Aug 2020
 10:27:41 +0800 (GMT+08:00)
X-Originating-IP: [113.200.148.30]
Date:   Fri, 14 Aug 2020 10:27:41 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "Zejiang Tang" <tangzejiang@loongson.cn>
To:     "Florian Fainelli" <f.fainelli@gmail.com>
Cc:     "Steven Rostedt" <rostedt@goodmis.org>,
        "Ingo Molnar" <mingo@redhat.com>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] MIPS: ftrace: Remove redundant #ifdef
 CONFIG_DYNAMIC_FTRAC
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.10a build 20191018(4c4f6d15)
 Copyright (c) 2002-2020 www.mailtech.cn .loongson.cn
In-Reply-To: <6db80fad-1ace-70b6-080b-c06ac9c07d22@gmail.com>
References: <1597370895-5412-1-git-send-email-tangzejiang@loongson.cn>
 <6db80fad-1ace-70b6-080b-c06ac9c07d22@gmail.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7060c488.4de0.173eacb580f.Coremail.tangzejiang@loongson.cn>
X-Coremail-Locale: en_US
X-CM-TRANSID: AQAAf9AxquSd9jVfs7YIAA--.3080W
X-CM-SenderInfo: pwdqw6phmlt03j6o00pqjv00gofq/1tbiAQAIDV3QvMMMpgAAsc
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWUCw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

b2vvvIx0aGFuayB5b3UgdmVyeSBtdWNoCgomcXVvdDtGbG9yaWFuIEZhaW5lbGxpJnF1b3Q7ICZs
dDtmLmZhaW5lbGxpQGdtYWlsLmNvbSZndDt3cm90ZToKPiANCj4gDQo+IE9uIDgvMTMvMjAyMCA3
OjA4IFBNLCBaZWppYW5nIFRhbmcgd3JvdGU6DQo+ID4gVGhlcmUgZXhpc3RzIHJlZHVuZGFudCAj
aWZkZWYgQ09ORklHX0RZTkFNSUNfRlRSQUMgaW4gZnRyYWNlLmMsIHJlbW92ZSBpdC4NCj4gDQo+
IFRoZXJlIGlzIGEgbWlzc2luZyBFIGF0IHRoZSBlbmQgb2YgQ09ORklHX0RZTkFNSUNfRlRSQUMg
aW4geW91ciBzdWJqZWN0IA0KPiBGV0lXVy4NCj4gLS0gDQo+IEZsb3JpYW4NCg==

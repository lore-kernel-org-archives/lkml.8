Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529E1C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21DC220637
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgCWPgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:36:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:35632 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbgCWPgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:36:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B9F18AE24;
        Mon, 23 Mar 2020 15:36:21 +0000 (UTC)
Message-ID: <1584977769.27949.18.camel@suse.de>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
From:   Oliver Neukum <oneukum@suse.de>
To:     Qais Yousef <qais.yousef@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 23 Mar 2020 16:36:09 +0100
In-Reply-To: <20200323143857.db5zphxhq4hz3hmd@e107158-lin.cambridge.arm.com>
References: <20200323143857.db5zphxhq4hz3hmd@e107158-lin.cambridge.arm.com>
Content-Type: multipart/mixed; boundary="=-IYg+DkhohS1dh6vva5Gj"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-IYg+DkhohS1dh6vva5Gj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Am Montag, den 23.03.2020, 14:38 +0000 schrieb Qais Yousef:
> Hi
> 
> I've hit the following lockdep warning when I trigger hibernate on arm64
> platform (Juno-r2)
> 
> 
> 	echo suspend > /sys/power/disk
> 	echo disk > /sys/power/state
> 
> I only had a usb flash drive attached to it. Let me know if you need more info.

Hi,

that is not a lockdep issue, but the hub driver is not properly killing
its URB presumably. Yet, the driver looks correct to me. Please use
the additional patch and activate dynamic debugging for usbcore.

	Regards
		Oliver

--=-IYg+DkhohS1dh6vva5Gj
Content-Disposition: attachment; filename="0001-usb-hub-additional-debugging.patch"
Content-Type: text/x-patch; name="0001-usb-hub-additional-debugging.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSA4MzU3ZDlkN2FiZTM1ZDVlMzY4NGY1MTI3ZmVhNmQyNDMwMDExNTI2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29tPgpEYXRl
OiBNb24sIDIzIE1hciAyMDIwIDE2OjM0OjM1ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gdXNiOiBo
dWIgYWRkaXRpb25hbCBkZWJ1Z2dpbmcKCi0tLQogZHJpdmVycy91c2IvY29yZS9odWIuYyB8IDEg
KwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy91
c2IvY29yZS9odWIuYyBiL2RyaXZlcnMvdXNiL2NvcmUvaHViLmMKaW5kZXggNTRjZDhlZjc5NWVj
Li4yNTUzMGNmMzAzODEgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdXNiL2NvcmUvaHViLmMKKysrIGIv
ZHJpdmVycy91c2IvY29yZS9odWIuYwpAQCAtMTYyOSw2ICsxNjI5LDcgQEAgc3RhdGljIGludCBo
dWJfY29uZmlndXJlKHN0cnVjdCB1c2JfaHViICpodWIsCiAJCXJldCA9IC1FTk9NRU07CiAJCWdv
dG8gZmFpbDsKIAl9CisJZGV2X2RiZyhodWJfZGV2LCAiJXAgVVJCIGFsbG9jYXRlZCBcbiIpOwog
CiAJdXNiX2ZpbGxfaW50X3VyYihodWItPnVyYiwgaGRldiwgcGlwZSwgKmh1Yi0+YnVmZmVyLCBt
YXhwLCBodWJfaXJxLAogCQlodWIsIGVuZHBvaW50LT5iSW50ZXJ2YWwpOwotLSAKMi4xNi40Cgo=


--=-IYg+DkhohS1dh6vva5Gj--


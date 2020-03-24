Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6983C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F66208D6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgCXNVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:21:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:44086 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728769AbgCXNVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:21:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 93DE4AC0C;
        Tue, 24 Mar 2020 13:21:00 +0000 (UTC)
Message-ID: <1585056047.7151.21.camel@suse.de>
Subject: Re: lockdep warning in urb.c:363 usb_submit_urb
From:   Oliver Neukum <oneukum@suse.de>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 24 Mar 2020 14:20:47 +0100
In-Reply-To: <20200324104610.pqdtaocg6qctlnqv@e107158-lin>
References: <20200323143857.db5zphxhq4hz3hmd@e107158-lin.cambridge.arm.com>
         <1584977769.27949.18.camel@suse.de>
         <20200323172932.5s7txy2juhut5qdv@e107158-lin.cambridge.arm.com>
         <1585040918.7151.6.camel@suse.de>
         <20200324104610.pqdtaocg6qctlnqv@e107158-lin>
Content-Type: multipart/mixed; boundary="=-U07L1RnJRmO2Nvpmq+Bb"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-U07L1RnJRmO2Nvpmq+Bb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Am Dienstag, den 24.03.2020, 10:46 +0000 schrieb Qais Yousef:
> 
> I should have stuck to what I know then. I misread the documentation. Hopefully
> the attached looks better. I don't see the new debug you added emitted.

That is odd. Please try

echo "module usbcore +mfp" > /sys/kernel/debug/dynamic_debug/control

with the attached improved patch.

	Regards
		Oliver

--=-U07L1RnJRmO2Nvpmq+Bb
Content-Disposition: attachment; filename="0001-usb-hub-additional-debugging.patch"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="0001-usb-hub-additional-debugging.patch";
	charset="UTF-8"

RnJvbSA4OWI0MjBmNGI2ZmQ0MWU4OTAxMjY3ZWU2OThhYzllNWQ0OThmOGRiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBPbGl2ZXIgTmV1a3VtIDxvbmV1a3VtQHN1c2UuY29tPgpEYXRl
OiBNb24sIDIzIE1hciAyMDIwIDE2OjM0OjM1ICswMTAwClN1YmplY3Q6IFtQQVRDSCAxLzJdIHVz
YjogaHViIGFkZGl0aW9uYWwgZGVidWdnaW5nCgotLS0KIGRyaXZlcnMvdXNiL2NvcmUvaHViLmMg
fCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2NvcmUvaHViLmMgYi9kcml2ZXJzL3VzYi9jb3JlL2h1Yi5jCmluZGV4IDU0Y2Q4ZWY3
OTVlYy4uMTJjZTJmZGM0YzJhIDEwMDY0NAotLS0gYS9kcml2ZXJzL3VzYi9jb3JlL2h1Yi5jCisr
KyBiL2RyaXZlcnMvdXNiL2NvcmUvaHViLmMKQEAgLTE2MjksNiArMTYyOSw3IEBAIHN0YXRpYyBp
bnQgaHViX2NvbmZpZ3VyZShzdHJ1Y3QgdXNiX2h1YiAqaHViLAogCQlyZXQgPSAtRU5PTUVNOwog
CQlnb3RvIGZhaWw7CiAJfQorCWRldl9kYmcoaHViX2RldiwgIiVwIFVSQiBhbGxvY2F0ZWQgXG4i
LCBodWItPnVyYik7CiAKIAl1c2JfZmlsbF9pbnRfdXJiKGh1Yi0+dXJiLCBoZGV2LCBwaXBlLCAq
aHViLT5idWZmZXIsIG1heHAsIGh1Yl9pcnEsCiAJCWh1YiwgZW5kcG9pbnQtPmJJbnRlcnZhbCk7
Ci0tIAoyLjE2LjQKCg==


--=-U07L1RnJRmO2Nvpmq+Bb--


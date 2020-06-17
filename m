Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F1AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB6802082F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 09:37:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihlL0ifJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgFQJhq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 05:37:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42094 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725964AbgFQJhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 05:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592386665;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GALKjCyCx4yfJN/JVX3IxioyMG3hz4NRjecTTDpBoNE=;
        b=ihlL0ifJRdP4jd/5CgY9zdM9onBkfQixDWvqhmeFSw87r/4g3X0ccFZT5Z8/qM946042SH
        oq+0xx76xIRJO8/t/MwKn2By0mdJs1UFQCv/PtYOSbocGAJ04SuFUKrj0Weeb6IgwMiFfW
        OKlwcCcYpjRPEW4bBTZIyJPfPRn9CRE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-k6oO2ez3NvGoZWDkW1VHGw-1; Wed, 17 Jun 2020 05:37:43 -0400
X-MC-Unique: k6oO2ez3NvGoZWDkW1VHGw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6D41876EE2;
        Wed, 17 Jun 2020 09:37:41 +0000 (UTC)
Received: from localhost (ovpn-114-151.ams2.redhat.com [10.36.114.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7731478EE1;
        Wed, 17 Jun 2020 09:37:34 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcelo Tosatti <mtosatti@redhat.com>, linux-pci@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC 1/2] genirq: honor device NUMA node when allocating descs
Date:   Wed, 17 Jun 2020 10:37:24 +0100
Message-Id: <20200617093725.1725569-2-stefanha@redhat.com>
In-Reply-To: <20200617093725.1725569-1-stefanha@redhat.com>
References: <20200617093725.1725569-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VXNlIHRoZSBkZXZpY2UncyBOVU1BIG5vZGUgaW5zdGVhZCBvZiB0aGUgZmlyc3QgbWFza2VkIENQ
VXMgbm9kZSB3aGVuCmRlc2NzIGFyZSBhbGxvY2F0ZWQuIFRoZSBtYXNrIG1heSBpbmNsdWRlIGFs
bCBDUFVzIGFuZCB0aGVyZWZvcmUgbm90CmNvcnJlc3BvbmQgdG8gdGhlIGhvbWUgTlVNQSBub2Rl
IG9mIHRoZSBkZXZpY2UuCgpTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhh
QHJlZGhhdC5jb20+Ci0tLQoga2VybmVsL2lycS9pcnFkZXNjLmMgfCAzICsrLQogMSBmaWxlIGNo
YW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2tlcm5l
bC9pcnEvaXJxZGVzYy5jIGIva2VybmVsL2lycS9pcnFkZXNjLmMKaW5kZXggMWE3NzIzNjA0Mzk5
Li5iOWM0MTYwZDcyYzQgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9pcnEvaXJxZGVzYy5jCisrKyBiL2tl
cm5lbC9pcnEvaXJxZGVzYy5jCkBAIC00ODgsNyArNDg4LDggQEAgc3RhdGljIGludCBhbGxvY19k
ZXNjcyh1bnNpZ25lZCBpbnQgc3RhcnQsIHVuc2lnbmVkIGludCBjbnQsIGludCBub2RlLAogCQkJ
CQlJUlFEX01BTkFHRURfU0hVVERPV047CiAJCQl9CiAJCQltYXNrID0gJmFmZmluaXR5LT5tYXNr
OwotCQkJbm9kZSA9IGNwdV90b19ub2RlKGNwdW1hc2tfZmlyc3QobWFzaykpOworCQkJaWYgKG5v
ZGUgPT0gTlVNQV9OT19OT0RFKQorCQkJCW5vZGUgPSBjcHVfdG9fbm9kZShjcHVtYXNrX2ZpcnN0
KG1hc2spKTsKIAkJCWFmZmluaXR5Kys7CiAJCX0KIAotLSAKMi4yNi4yCgo=


Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF76BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC97A206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VNYLbCzI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFBJRl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:17:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40461 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726580AbgFBJRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 05:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591089459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5jQIt9iE59XqDR+eye8j7C/bUOH+dlZE3dxsk1GuQcM=;
        b=VNYLbCzIn1xrHGkv9rrXL5aHyv62nNCfLk5Ka6BBhYRI5MQPmeabxdk51DYGAcmpA7R0Qd
        Q7fgS1WLypBU43IMyVasB2kQCOVdnTrjGn7u4aRmPunLscjX3nnbJRRB7WUars+dnPdaES
        +9Q2Yn2dFzRpkF4lyTQhLKkDIxkOHkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-QQpQfl53OUus0eRX1WdFUw-1; Tue, 02 Jun 2020 05:17:36 -0400
X-MC-Unique: QQpQfl53OUus0eRX1WdFUw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0A5E3100CCC1;
        Tue,  2 Jun 2020 09:17:34 +0000 (UTC)
Received: from localhost (ovpn-115-9.ams2.redhat.com [10.36.115.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD9E5579A3;
        Tue,  2 Jun 2020 09:17:30 +0000 (UTC)
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     James Morris <jmorris@namei.org>,
        linux-security-module@vger.kernel.org
Cc:     Serge Hallyn <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2] capabilities: add description for CAP_SETFCAP
Date:   Tue,  2 Jun 2020 10:17:28 +0100
Message-Id: <20200602091728.10843-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RG9jdW1lbnQgdGhlIHB1cnBvc2Ugb2YgQ0FQX1NFVEZDQVAuICBGb3Igc29tZSByZWFzb24gdGhp
cyBjYXBhYmlsaXR5CmhhZCBubyBkZXNjcmlwdGlvbiB3aGlsZSB0aGUgb3RoZXJzIGRpZC4KClNp
Z25lZC1vZmYtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0LmNvbT4KLS0tCnYy
OgogKiBSZWJhc2VkIG9udG8gZ2l0IG1hc3RlcgoKIGluY2x1ZGUvdWFwaS9saW51eC9jYXBhYmls
aXR5LmggfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvaW5jbHVkZS91YXBpL2xpbnV4L2NhcGFiaWxpdHkuaCBiL2luY2x1ZGUvdWFwaS9saW51eC9j
YXBhYmlsaXR5LmgKaW5kZXggZTU4Yzk2MzY3NDFiLi5jNDUzMmIwZmUwMGYgMTAwNjQ0Ci0tLSBh
L2luY2x1ZGUvdWFwaS9saW51eC9jYXBhYmlsaXR5LmgKKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4
L2NhcGFiaWxpdHkuaApAQCAtMzMyLDYgKzMzMiw4IEBAIHN0cnVjdCB2ZnNfbnNfY2FwX2RhdGEg
ewogCiAjZGVmaW5lIENBUF9BVURJVF9DT05UUk9MICAgIDMwCiAKKy8qIFNldCBvciByZW1vdmUg
Y2FwYWJpbGl0aWVzIG9uIGZpbGVzICovCisKICNkZWZpbmUgQ0FQX1NFVEZDQVAJICAgICAzMQog
CiAvKiBPdmVycmlkZSBNQUMgYWNjZXNzLgotLSAKMi4yNS40Cgo=


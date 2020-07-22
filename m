Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459A0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F15720717
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 13:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7gfnWSL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732446AbgGVNlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 09:41:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30974 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726425AbgGVNlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 09:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595425313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=Ui/vqY+wjCMXVC3AeuKik/PdHbSTYXnM22dr85QtBBc=;
        b=H7gfnWSLuyI5gpnVjMVbBSFJQjjyv9riFiw2JlffDcH4X54jbixZpXb77VdcUQQsZNX2Sx
        4a4dVQ3S+6xNTAQbCq4vwSyCfunKJ+UTtqSETMH0D08SzPPbPgQElSyB2LZaqLokGn5KN+
        K+pdlT1D+VGyIbS5cyGXVQcz2Y/24yU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-z3V4zKwWOluYp_goGHsLNA-1; Wed, 22 Jul 2020 09:41:52 -0400
X-MC-Unique: z3V4zKwWOluYp_goGHsLNA-1
Received: by mail-qk1-f199.google.com with SMTP id i3so1448041qkf.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 06:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ui/vqY+wjCMXVC3AeuKik/PdHbSTYXnM22dr85QtBBc=;
        b=NNV2sW4zAQT5shQwuXhzkjH8OOuEHNXKRFYn/KD7zsB8lwRNPvsJQh1TfKlo80O72a
         V/jIqZyRlwv6bRhtwXBkyMjbVOl2YfVoIBDl05Y9BSVUx4uy6ZoCEl1BiFK547Nubenr
         Z6o8NjAoso/nk1ubzc/LCFHjHlzhPUBwvRZ3qbcxTA9D3FuPSGO6cUH/XMSh9IvgfgpJ
         /J3boed8VUxAbQ3lZ1wSJWdO7Y/UhtC3SiykWH2of0vkSM0teMn/rW0Ehkhq2QTMIJRC
         XuK1puEWT0gNcfjMf7gejcS8NfBTsgGQIcfhOVmNarrFdD6Th3ZitsXXAdhKXI5fVl50
         b20g==
X-Gm-Message-State: AOAM5301rSFNve6Qf1td7n03nme0Kqnw8MkVt4BHSiTCXbZZXWc220O5
        oWt8HQN7UxEPB5apa0WEPGtrnJK4aXqojK3vdtolqL0url8MOBGJTEzIiSQCv1Snu7w4twJeJ3x
        0se4qt18XK7Dg1SeqaOEbbiC4
X-Received: by 2002:ac8:7241:: with SMTP id l1mr34190476qtp.254.1595425311635;
        Wed, 22 Jul 2020 06:41:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9SwiS7B94UsTa1T4MWZIZChKfTj3cztPK0m8KJwbQIjkVQygaJ1FIqBq5LPXmP8OjlBQaDg==
X-Received: by 2002:ac8:7241:: with SMTP id l1mr34190457qtp.254.1595425311411;
        Wed, 22 Jul 2020 06:41:51 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id f54sm27791224qte.76.2020.07.22.06.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 06:41:50 -0700 (PDT)
From:   trix@redhat.com
To:     jasmin@anw.at, mchehab@kernel.org, o.endriss@gmx.de,
        rjkm@metzlerbros.de
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] media: dvb-frontends/cxd2099: report errors
Date:   Wed, 22 Jul 2020 06:41:26 -0700
Message-Id: <20200722134126.31191-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this error

drivers/media/dvb-frontends/cxd2099.c:420:2: warning: Undefined
  or garbage value returned to caller
        return val;
        ^~~~~~~~~~

In read_cam_control, the call to read_io can fail.
When it fails val is not set.

The failure status should be returned to the caller,
not the unset val.

Similar problem with read_attribute_mem

Fixes: 0f0b270f905b ("[media] ngene: CXD2099AR Common Interface driver")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/media/dvb-frontends/cxd2099.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/media/dvb-frontends/cxd2099.c b/drivers/media/dvb-frontends/cxd2099.c
index f88b5355493e..9dfaf18fc4b4 100644
--- a/drivers/media/dvb-frontends/cxd2099.c
+++ b/drivers/media/dvb-frontends/cxd2099.c
@@ -387,12 +387,15 @@ static int read_attribute_mem(struct dvb_ca_en50221 *ca,
 {
 	struct cxd *ci = ca->data;
 	u8 val;
+	int ret;
 
 	mutex_lock(&ci->lock);
 	set_mode(ci, 1);
-	read_pccard(ci, address, &val, 1);
+	ret = read_pccard(ci, address, &val, 1);
+	if (!ret)
+		ret = val;
 	mutex_unlock(&ci->lock);
-	return val;
+	return ret;
 }
 
 static int write_attribute_mem(struct dvb_ca_en50221 *ca, int slot,
@@ -412,12 +415,15 @@ static int read_cam_control(struct dvb_ca_en50221 *ca,
 {
 	struct cxd *ci = ca->data;
 	unsigned int val;
+	int ret;
 
 	mutex_lock(&ci->lock);
 	set_mode(ci, 0);
-	read_io(ci, address, &val);
+	ret = read_io(ci, address, &val);
+	if (!ret)
+		ret = val;
 	mutex_unlock(&ci->lock);
-	return val;
+	return ret;
 }
 
 static int write_cam_control(struct dvb_ca_en50221 *ca, int slot,
-- 
2.18.1


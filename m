Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B33C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C5020776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590521636;
	bh=ICYSVU/X9xqeXGvBRFzKeQSNfyqQXJbdXb38mcw1iL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oorTrsXF95HdYpLiKVe/LeM6IPJNCNsGwtuyNVOqNjmZqV71sJjTHI3mvNkm/ZfSD
	 aTM7TWNJwdkqI6jKs/uch1OPGxSsptO9WlR0V7Ye36k3rdJSIxpbOK5RShVaiCdJel
	 nZ9zZQKopbx9bz2QubxzsZQVj6ezV5nCToQxOaS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404500AbgEZTdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:33:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:48306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389644AbgEZSzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:55:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46B7A208B3;
        Tue, 26 May 2020 18:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590519347;
        bh=ICYSVU/X9xqeXGvBRFzKeQSNfyqQXJbdXb38mcw1iL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B5HeTyAgALG5GEYjxBPkuP8g0c4WFEjjZeEz9R1GQo6AhOLXL9h7cuFrl0bMJHjdM
         SPqStbq9kXEsNBKgHrdavN67cVni1u5VBgPSpUVaa2l30sgegJ61fRShh/Y1VT/Mrv
         7eIKiCr5dmZSgt1OVprSXXAEEIp8C+b4VX0GXhVc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        "Darren Hart (VMware)" <dvhart@infradead.org>
Subject: [PATCH 4.4 32/65] platform/x86: alienware-wmi: fix kfree on potentially uninitialized pointer
Date:   Tue, 26 May 2020 20:52:51 +0200
Message-Id: <20200526183917.810880502@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183905.988782958@linuxfoundation.org>
References: <20200526183905.988782958@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

commit 98e2630284ab741804bd0713e932e725466f2f84 upstream.

Currently the kfree of output.pointer can be potentially freeing
an uninitalized pointer in the case where out_data is NULL. Fix this
by reworking the case where out_data is not-null to perform the
ACPI status check and also the kfree of outpoint.pointer in one block
and hence ensuring the pointer is only freed when it has been used.

Also replace the if (ptr != NULL) idiom with just if (ptr).

Fixes: ff0e9f26288d ("platform/x86: alienware-wmi: Correct a memory leak")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Darren Hart (VMware) <dvhart@infradead.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/alienware-wmi.c |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

--- a/drivers/platform/x86/alienware-wmi.c
+++ b/drivers/platform/x86/alienware-wmi.c
@@ -449,23 +449,22 @@ static acpi_status alienware_hdmi_comman
 
 	input.length = (acpi_size) sizeof(*in_args);
 	input.pointer = in_args;
-	if (out_data != NULL) {
+	if (out_data) {
 		output.length = ACPI_ALLOCATE_BUFFER;
 		output.pointer = NULL;
 		status = wmi_evaluate_method(WMAX_CONTROL_GUID, 1,
 					     command, &input, &output);
-	} else
+		if (ACPI_SUCCESS(status)) {
+			obj = (union acpi_object *)output.pointer;
+			if (obj && obj->type == ACPI_TYPE_INTEGER)
+				*out_data = (u32)obj->integer.value;
+		}
+		kfree(output.pointer);
+	} else {
 		status = wmi_evaluate_method(WMAX_CONTROL_GUID, 1,
 					     command, &input, NULL);
-
-	if (ACPI_SUCCESS(status) && out_data != NULL) {
-		obj = (union acpi_object *)output.pointer;
-		if (obj && obj->type == ACPI_TYPE_INTEGER)
-			*out_data = (u32) obj->integer.value;
 	}
-	kfree(output.pointer);
 	return status;
-
 }
 
 static ssize_t show_hdmi_cable(struct device *dev,



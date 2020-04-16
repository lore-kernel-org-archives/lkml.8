Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C642C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF3A421D91
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587051571;
	bh=1ClpcThwENIVjhgFj2BIfnEiPBTFpOMrznL6cQRlSt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vjjktgYCcwhD5whpSoB7QyKj337absSUlzEkBbaEJaUtX1mzIWi4P2xEymHyN6u5w
	 XY/M91pLM3zdIkVjFmLd5C4VBd9Ut8r7rJ+fY6by8r1ujy8JHsNo1hovGjbC2UGF+d
	 18D9UFBrS8PCqV/5d9coPDjOrCL6jbzpyxgqlNGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634034AbgDPPja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:39:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897687AbgDPNiV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 09:38:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E72F722201;
        Thu, 16 Apr 2020 13:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587044301;
        bh=1ClpcThwENIVjhgFj2BIfnEiPBTFpOMrznL6cQRlSt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x70BnzWdfxDeC/PAkZphkcC7bz8GQvU15yDQbICpq4yfuvbTwHbtBPsKMFlzdQldF
         B+9D7Yv6mtGWKtG7rYFsK0OzundDs+iPkpNpdpJScEdRQgZXINRdWLOurCVnS+RAM+
         OtWcXl1NkIwzKeiXT2Bkz4VDo6lYH87xWZl7Uuno=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vasily Averin <vvs@virtuozzo.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 5.5 121/257] tpm: tpm1_bios_measurements_next should increase position index
Date:   Thu, 16 Apr 2020 15:22:52 +0200
Message-Id: <20200416131341.436466713@linuxfoundation.org>
X-Mailer: git-send-email 2.26.1
In-Reply-To: <20200416131325.891903893@linuxfoundation.org>
References: <20200416131325.891903893@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

commit d7a47b96ed1102551eb7325f97937e276fb91045 upstream.

If .next function does not change position index,
following .show function will repeat output related
to current position index.

In case of /sys/kernel/security/tpm0/ascii_bios_measurements
and binary_bios_measurements:
1) read after lseek beyound end of file generates whole last line.
2) read after lseek to middle of last line generates
expected end of last line and unexpected whole last line once again.

Cc: stable@vger.kernel.org # 4.19.x
Fixes: 1f4aace60b0e ("fs/seq_file.c: simplify seq_file iteration code ...")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206283
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/eventlog/tpm1.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/char/tpm/eventlog/tpm1.c
+++ b/drivers/char/tpm/eventlog/tpm1.c
@@ -115,6 +115,7 @@ static void *tpm1_bios_measurements_next
 	u32 converted_event_size;
 	u32 converted_event_type;
 
+	(*pos)++;
 	converted_event_size = do_endian_conversion(event->event_size);
 
 	v += sizeof(struct tcpa_event) + converted_event_size;
@@ -132,7 +133,6 @@ static void *tpm1_bios_measurements_next
 	    ((v + sizeof(struct tcpa_event) + converted_event_size) > limit))
 		return NULL;
 
-	(*pos)++;
 	return v;
 }
 



Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D676DC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:47:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A026A206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579218443;
	bh=W+Gri1dui11+ZSP4nNWrDjhwU54HKegHjy00ebz6aN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iCwcONUErSMCuygJt5XgGG0v1KafvQNZQ9d9CGHwQYFcJ3BcvLYOB6wvpVfNH6POj
	 RDcPMsopvq9q73lkWySU8ebOrTR2AM09vVMYUwpHCXymebn/ula+v0YsKjMrI9wPNj
	 rMdkfLdOH32HmKGezFTmF+bI/SgrJoE1SIml1q/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392096AbgAPXrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:47:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:48002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390744AbgAPXVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:21:03 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64EC42072B;
        Thu, 16 Jan 2020 23:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579216862;
        bh=W+Gri1dui11+ZSP4nNWrDjhwU54HKegHjy00ebz6aN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rkipbhc/oXxhZWBxKM/VIQjcurFKy7I0df/biE5cVTkFA7Gu2+sASQtMq1WF5M3kb
         BxB2D8iEcDcKb0ECY9y2tswjUspCofEcx+utv1W2x1a7X9jUy+m1LVaYGmA7UY1B0J
         qXmMJMAGRYN08TAsMiXbSDbSyidN84mbnFxOpSec=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexandra Winter <wintera@linux.ibm.com>,
        Julian Wiedmann <jwi@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 034/203] s390/qeth: fix false reporting of VNIC CHAR config failure
Date:   Fri, 17 Jan 2020 00:15:51 +0100
Message-Id: <20200116231747.170050880@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231745.218684830@linuxfoundation.org>
References: <20200116231745.218684830@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandra Winter <wintera@linux.ibm.com>

commit 68c57bfd52836e31bff33e5e1fc64029749d2c35 upstream.

Symptom: Error message "Configuring the VNIC characteristics failed"
in dmesg whenever an OSA interface on z15 is set online.

The VNIC characteristics get re-programmed when setting a L2 device
online. This follows the selected 'wanted' characteristics - with the
exception that the INVISIBLE characteristic unconditionally gets
switched off.

For devices that don't support INVISIBLE (ie. OSA), the resulting
IO failure raises a noisy error message
("Configuring the VNIC characteristics failed").
For IQD, INVISIBLE is off by default anyways.

So don't unnecessarily special-case the INVISIBLE characteristic, and
thereby suppress the misleading error message on OSA devices.

Fixes: caa1f0b10d18 ("s390/qeth: add VNICC enable/disable support")
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/net/qeth_l2_main.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -2072,7 +2072,6 @@ static void qeth_l2_vnicc_init(struct qe
 	error |= qeth_l2_vnicc_recover_timeout(card, QETH_VNICC_LEARNING,
 					       timeout);
 	chars_tmp = card->options.vnicc.wanted_chars ^ QETH_VNICC_DEFAULT;
-	chars_tmp |= QETH_VNICC_BRIDGE_INVISIBLE;
 	chars_len = sizeof(card->options.vnicc.wanted_chars) * BITS_PER_BYTE;
 	for_each_set_bit(i, &chars_tmp, chars_len) {
 		vnicc = BIT(i);



Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CAB6C33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1167024672
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 10:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578996192;
	bh=GPjj1mU/KmVcZvRN8v8L1t6ubCjdjo9O40XwnKiBc4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FBW4h3v4YKlkqp7J2HaPgOXlw4EyU+6C/YA/I2HayjMl4SpBumnBWCMYYJcj4o7oq
	 AGiHBcqKtW9HApU5ipTt1Yu+CEV2KQlFmjub/OgBFhDGKfRSp++PChDEeg66nVfLsQ
	 iZLOwoiE3bFIoFypH87vQcnp5JwtSRVf9FgRMSdY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgANKDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 05:03:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:57736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726169AbgANKDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 05:03:08 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65EA624672;
        Tue, 14 Jan 2020 10:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578996188;
        bh=GPjj1mU/KmVcZvRN8v8L1t6ubCjdjo9O40XwnKiBc4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OEFKwckbiwNy25TkXlzm9ddoMr/Lwg73t00Q82X5dbrrtvIrStfbRoR96rdDZTkAY
         goQxMlvNRK5YacfC79ocdnjhubPo/K6VrICS0Sbpdpf6iEmaGWMd6+e9obz6Oa0sgL
         nNcAzrYsBWSbgJPT4eLlyQO7hq9hOtyiM4Zt7Bvw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerry Snitselaar <jsnitsel@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Xiaoping Zhou <xiaoping.zhou@intel.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Subject: [PATCH 5.4 11/78] tpm: Revert "tpm_tis_core: Turn on the TPM before probing IRQs"
Date:   Tue, 14 Jan 2020 11:00:45 +0100
Message-Id: <20200114094354.203074177@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114094352.428808181@linuxfoundation.org>
References: <20200114094352.428808181@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefan Berger <stefanb@linux.ibm.com>

commit aa4a63dd981682b1742baa01237036e48bc11923 upstream.

There has been a bunch of reports (one from kernel bugzilla linked)
reporting that when this commit is applied it causes on some machines
boot freezes.

Unfortunately hardware where this commit causes a failure is not widely
available (only one I'm aware is Lenovo T490), which means we cannot
predict yet how long it will take to properly fix tpm_tis interrupt
probing.

Thus, the least worst short term action is to revert the code to the
state before this commit. In long term we need fix the tpm_tis probing
code to work on machines that Stefan's fix was supposed to fix.

Fixes: 21df4a8b6018 ("tpm_tis: reserve chip for duration of tpm_tis_core_init")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=205935
Cc: stable@vger.kernel.org
Cc: Jerry Snitselaar <jsnitsel@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Tested-by: Dan Williams <dan.j.williams@intel.com>
Tested-by: Xiaoping Zhou <xiaoping.zhou@intel.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
Reported-by: Jerry Snitselaar <jsnitsel@redhat.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/tpm/tpm_tis_core.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -980,7 +980,6 @@ int tpm_tis_core_init(struct device *dev
 			goto out_err;
 		}
 
-		tpm_chip_start(chip);
 		if (irq) {
 			tpm_tis_probe_irq_single(chip, intmask, IRQF_SHARED,
 						 irq);
@@ -990,7 +989,6 @@ int tpm_tis_core_init(struct device *dev
 		} else {
 			tpm_tis_probe_irq(chip, intmask);
 		}
-		tpm_chip_stop(chip);
 	}
 
 	rc = tpm_chip_register(chip);



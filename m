Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8656C2BA80
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF807207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q7DevERL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403904AbgDCNnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:43:50 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35591 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403831AbgDCNnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:43:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id i19so7791316wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 06:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=siuqCyw5EFTFQ/oL4HCyMhDyVDB5gecawHr8BjOLSHY=;
        b=q7DevERL2mS+AkK1aX5LPAtKiT6JIKZUoSE5KQHvahjw+/Z+q3amhIFDNrQH4UHyDD
         uwvWA7MMGSivE3chFONIbps4AQv8v2Gzs/okob+RRPgTi9K6OYGDpa3c1zQzl9HVafhN
         VaCLxoA8Ave9cgbsnCc2k42Zu9hGkyBO7RUaJUPjbOmoEfhhrVZYcycjM0uK/O9tepxZ
         +ULkdTIr2NJyokrTU3p1mLi4rcnFw3rt0epTqzkzv6YBLHriOS+o2pfyCUycsugJtCPr
         3l3PoFcZAVCMHxUdGFyXk26ICX0IJfoHSp6Adoz/45FzphStgvqT49Ksq8vmtLPABJHr
         1UWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=siuqCyw5EFTFQ/oL4HCyMhDyVDB5gecawHr8BjOLSHY=;
        b=eVcN9d78tZdEl4EvG1/iwKS2njSE4RSLx0dhAJ2JyVAE1PZzjlxweH0YkVf0vtNmc0
         hv9bwYD5wu8aWKVXIsy9kZwQImtuAUV+QmG17lQjJdAhmLWAdca6uXtQArX8hAef1f46
         tjef1WvkJ7QsummjvI8U5pL/Jf/K0fw75f7/wVW3poFcgDXEx9a7HEun3o+2GFSq4LYy
         VY7UjfKVlF9DTklha/MNF0cFmeLp/yMDGcC9U0dXM3PyxOKI59jdFmzy8Nb4XyjvVDqX
         1IUi3Uje3+RZzfQcPs0FbtIo0Ash1APbnhWg9Pmiwr68DzpPlrSL1c9yyqEC3kgOVd/3
         /wLg==
X-Gm-Message-State: AGi0PubI/08iwGNf219vMVPWlzObMpJB5ct6iH06GBBaUbYRuLvwPtOW
        NR8d5abc3e9ZEvjsL30yJIE=
X-Google-Smtp-Source: APiQypL8AUbX4z6Wy434HUzaqxoMUdOvo5oMcS1XbXDG6PIO5eStcMGkjcM0HdR181KMWf9Y39azkw==
X-Received: by 2002:a1c:5502:: with SMTP id j2mr8952217wmb.93.1585921423550;
        Fri, 03 Apr 2020 06:43:43 -0700 (PDT)
Received: from debian.lan (host-84-13-17-86.opaltelecom.net. [84.13.17.86])
        by smtp.gmail.com with ESMTPSA id f12sm12081232wrm.94.2020.04.03.06.43.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 06:43:43 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 09/11] parport: Add comments for parport_register_dev_model()
Date:   Fri,  3 Apr 2020 14:43:23 +0100
Message-Id: <20200403134325.11523-9-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200403134325.11523-1-sudipm.mukherjee@gmail.com>
References: <20200403134325.11523-1-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove parport_register_device(), copy the comments
to parport_register_dev_model() and modify the parameters according to
what parport_register_dev_model() has.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/share.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/parport.h |  4 ++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 3169feebdc19..ee2892a935d6 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -841,6 +841,68 @@ static void free_pardevice(struct device *dev)
 	kfree(par_dev);
 }
 
+/**
+ *	parport_register_dev_model - register a device on a parallel port
+ *	@port: port to which the device is attached
+ *	@name: a name to refer to the device
+ *	@par_dev_cb: struct containing callbacks
+ *	@id: device number to be given to the device
+ *
+ *	This function, called by parallel port device drivers,
+ *	declares that a device is connected to a port, and tells the
+ *	system all it needs to know.
+ *
+ *	The struct pardev_cb contains pointer to callbacks. preemption
+ *	callback function, @preempt, is called when this device driver
+ *	has claimed access to the port but another device driver wants
+ *	to use it.  It is given, @private, as its parameter, and should
+ *	return zero if it is willing for the system to release the port
+ *	to another driver on its behalf. If it wants to keep control of
+ *	the port it should return non-zero, and no action will be taken.
+ *	It is good manners for the driver to try to release the port at
+ *	the earliest opportunity after its preemption callback rejects a
+ *	preemption attempt. Note that if a preemption callback is happy
+ *	for preemption to go ahead, there is no need to release the
+ *	port; it is done automatically. This function may not block, as
+ *	it may be called from interrupt context. If the device driver
+ *	does not support preemption, @preempt can be %NULL.
+ *
+ *	The wake-up ("kick") callback function, @wakeup, is called when
+ *	the port is available to be claimed for exclusive access; that
+ *	is, parport_claim() is guaranteed to succeed when called from
+ *	inside the wake-up callback function.  If the driver wants to
+ *	claim the port it should do so; otherwise, it need not take
+ *	any action.  This function may not block, as it may be called
+ *	from interrupt context.  If the device driver does not want to
+ *	be explicitly invited to claim the port in this way, @wakeup can
+ *	be %NULL.
+ *
+ *	The interrupt handler, @irq_func, is called when an interrupt
+ *	arrives from the parallel port.  Note that if a device driver
+ *	wants to use interrupts it should use parport_enable_irq(),
+ *	and can also check the irq member of the parport structure
+ *	representing the port.
+ *
+ *	The parallel port (lowlevel) driver is the one that has called
+ *	request_irq() and whose interrupt handler is called first.
+ *	This handler does whatever needs to be done to the hardware to
+ *	acknowledge the interrupt (for PC-style ports there is nothing
+ *	special to be done).  It then tells the IEEE 1284 code about
+ *	the interrupt, which may involve reacting to an IEEE 1284
+ *	event depending on the current IEEE 1284 phase.  After this,
+ *	it calls @irq_func.  Needless to say, @irq_func will be called
+ *	from interrupt context, and may not block.
+ *
+ *	The %PARPORT_DEV_EXCL flag is for preventing port sharing, and
+ *	so should only be used when sharing the port with other device
+ *	drivers is impossible and would lead to incorrect behaviour.
+ *	Use it sparingly!  Normally, @flags will be zero.
+ *
+ *	This function returns a pointer to a structure that represents
+ *	the device on the port, or %NULL if there is not enough memory
+ *	to allocate space for that structure.
+ **/
+
 struct pardevice *
 parport_register_dev_model(struct parport *port, const char *name,
 			   const struct pardev_cb *par_dev_cb, int id)
diff --git a/include/linux/parport.h b/include/linux/parport.h
index 13932ce8b37b..36a0f6270238 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -337,6 +337,10 @@ struct pardevice *parport_register_device(struct parport *port,
 			  void (*irq_func)(void *), 
 			  int flags, void *handle);
 
+/*
+ * parport_register_dev_model declares that a device is connected to a
+ * port, and tells the kernel all it needs to know.
+ */
 struct pardevice *
 parport_register_dev_model(struct parport *port, const char *name,
 			   const struct pardev_cb *par_dev_cb, int cnt);
-- 
2.11.0


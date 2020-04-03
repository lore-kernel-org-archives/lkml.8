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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9E4C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56212078C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 13:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WjLSf+jM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403922AbgDCNnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 09:43:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37640 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403866AbgDCNns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 09:43:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id j19so7767461wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 06:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lyOD0g2kIaK72ilE7baiLJ5fxyvMN9ni06jgBaMw15E=;
        b=WjLSf+jMUk0KcSXZ+9iq/N80hmRBrFPVU1+XG2UPyNJt8aQJ61n/co9iQuFnZRwiGe
         g/8AC4Cf9pLol2dg8TWOOgOlkDvYNYLz7JdCUnC0VIupJIROPMQOPDYsLg9JqD5Z9Sc9
         dA+47GFh70iboX+/PouyqxhwqijY+i/vlaahTXn4TevM2wltkoXZq/GQp8MyWleI02y+
         7RwjyVFDVnoJk73YVPPZ85NmKRn4cmlizBSrMXKO1l5DcOX7owKFEbyMVUCy3Jo6/yMW
         AgbzHmWKtuftvi2+SDiU/fB5j/TmMAH90O0zvkQmBQmWdt84EckvTgMavlEH3CAHiLU/
         PjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lyOD0g2kIaK72ilE7baiLJ5fxyvMN9ni06jgBaMw15E=;
        b=LsdrFguWKQ+Hb4sjVb48PhrOJ4fOHySimhK12abIQeNC3y44TGSuVdwBfTy4uLpIGT
         i46TzfIF2CIOEqZK8wZNiumlP2DZy68M8Qf2KdnHr1xEMKXL4Uw+zh2vrY8HSY2JLFmj
         mVzNhrPryhkIrZPpOGDrj+zq6ZKs9p6E47yyCJoMyEkv+/X1KRjkmEWFHqlfqHWYkJRK
         XWcT6GKhnXsdbe5h4ODSrOkHathiU8WO05017qdVfDw2aDGcfmVWmR0dhBdtJe1/idV1
         JwgaQgkLL2KvAaS6uonLhHMAKHWnJtDczDlcF4R/7JQMUewLXFSu7A3npjYsm7Z6NT+5
         0qSQ==
X-Gm-Message-State: AGi0Puart6XTILrxILUkFSby4n6Pdl2JpxgwFGX2OcnJ91UGRSf3z2Bw
        v2f8gG4//Uoa5LnThla6OZs=
X-Google-Smtp-Source: APiQypIZwJJbqN2XXw9yenAhenILr8RVMy+DdsSit44Y+eIW6g7TpYiYwlabvGjZAuiQE8Fhv5XN0A==
X-Received: by 2002:a1c:3d83:: with SMTP id k125mr9414000wma.177.1585921424641;
        Fri, 03 Apr 2020 06:43:44 -0700 (PDT)
Received: from debian.lan (host-84-13-17-86.opaltelecom.net. [84.13.17.86])
        by smtp.gmail.com with ESMTPSA id f12sm12081232wrm.94.2020.04.03.06.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2020 06:43:43 -0700 (PDT)
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 10/11] parport: remove unused parport_register_device()
Date:   Fri,  3 Apr 2020 14:43:24 +0100
Message-Id: <20200403134325.11523-10-sudipm.mukherjee@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200403134325.11523-1-sudipm.mukherjee@gmail.com>
References: <20200403134325.11523-1-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the drivers that are using parallel port has been converted to use
the new device model api, and parport_register_device() is no longer
used.

Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
---
 drivers/parport/share.c | 192 ------------------------------------------------
 include/linux/parport.h |  12 ---
 2 files changed, 204 deletions(-)

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index ee2892a935d6..661f623b3129 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -641,198 +641,6 @@ void parport_remove_port(struct parport *port)
 }
 EXPORT_SYMBOL(parport_remove_port);
 
-/**
- *	parport_register_device - register a device on a parallel port
- *	@port: port to which the device is attached
- *	@name: a name to refer to the device
- *	@pf: preemption callback
- *	@kf: kick callback (wake-up)
- *	@irq_func: interrupt handler
- *	@flags: registration flags
- *	@handle: data for callback functions
- *
- *	This function, called by parallel port device drivers,
- *	declares that a device is connected to a port, and tells the
- *	system all it needs to know.
- *
- *	The @name is allocated by the caller and must not be
- *	deallocated until the caller calls @parport_unregister_device
- *	for that device.
- *
- *	The preemption callback function, @pf, is called when this
- *	device driver has claimed access to the port but another
- *	device driver wants to use it.  It is given @handle as its
- *	parameter, and should return zero if it is willing for the
- *	system to release the port to another driver on its behalf.
- *	If it wants to keep control of the port it should return
- *	non-zero, and no action will be taken.  It is good manners for
- *	the driver to try to release the port at the earliest
- *	opportunity after its preemption callback rejects a preemption
- *	attempt.  Note that if a preemption callback is happy for
- *	preemption to go ahead, there is no need to release the port;
- *	it is done automatically.  This function may not block, as it
- *	may be called from interrupt context.  If the device driver
- *	does not support preemption, @pf can be %NULL.
- *
- *	The wake-up ("kick") callback function, @kf, is called when
- *	the port is available to be claimed for exclusive access; that
- *	is, parport_claim() is guaranteed to succeed when called from
- *	inside the wake-up callback function.  If the driver wants to
- *	claim the port it should do so; otherwise, it need not take
- *	any action.  This function may not block, as it may be called
- *	from interrupt context.  If the device driver does not want to
- *	be explicitly invited to claim the port in this way, @kf can
- *	be %NULL.
- *
- *	The interrupt handler, @irq_func, is called when an interrupt
- *	arrives from the parallel port.  Note that if a device driver
- *	wants to use interrupts it should use parport_enable_irq(),
- *	and can also check the irq member of the parport structure
- *	representing the port.
- *
- *	The parallel port (lowlevel) driver is the one that has called
- *	request_irq() and whose interrupt handler is called first.
- *	This handler does whatever needs to be done to the hardware to
- *	acknowledge the interrupt (for PC-style ports there is nothing
- *	special to be done).  It then tells the IEEE 1284 code about
- *	the interrupt, which may involve reacting to an IEEE 1284
- *	event depending on the current IEEE 1284 phase.  After this,
- *	it calls @irq_func.  Needless to say, @irq_func will be called
- *	from interrupt context, and may not block.
- *
- *	The %PARPORT_DEV_EXCL flag is for preventing port sharing, and
- *	so should only be used when sharing the port with other device
- *	drivers is impossible and would lead to incorrect behaviour.
- *	Use it sparingly!  Normally, @flags will be zero.
- *
- *	This function returns a pointer to a structure that represents
- *	the device on the port, or %NULL if there is not enough memory
- *	to allocate space for that structure.
- **/
-
-struct pardevice *
-parport_register_device(struct parport *port, const char *name,
-			int (*pf)(void *), void (*kf)(void *),
-			void (*irq_func)(void *),
-			int flags, void *handle)
-{
-	struct pardevice *tmp;
-
-	if (port->physport->flags & PARPORT_FLAG_EXCL) {
-		/* An exclusive device is registered. */
-		printk(KERN_DEBUG "%s: no more devices allowed\n", port->name);
-		return NULL;
-	}
-
-	if (flags & PARPORT_DEV_LURK) {
-		if (!pf || !kf) {
-			pr_info("%s: refused to register lurking device (%s) without callbacks\n",
-				port->name, name);
-			return NULL;
-		}
-	}
-
-	if (flags & PARPORT_DEV_EXCL) {
-		if (port->physport->devices) {
-			/*
-			 * If a device is already registered and this new
-			 * device wants exclusive access, then no need to
-			 * continue as we can not grant exclusive access to
-			 * this device.
-			 */
-			pr_err("%s: cannot grant exclusive access for device %s\n",
-			       port->name, name);
-			return NULL;
-		}
-	}
-
-	/*
-	 * We up our own module reference count, and that of the port
-	 * on which a device is to be registered, to ensure that
-	 * neither of us gets unloaded while we sleep in (e.g.)
-	 * kmalloc.
-	 */
-	if (!try_module_get(port->ops->owner))
-		return NULL;
-
-	parport_get_port(port);
-
-	tmp = kmalloc(sizeof(struct pardevice), GFP_KERNEL);
-	if (!tmp)
-		goto out;
-
-	tmp->state = kmalloc(sizeof(struct parport_state), GFP_KERNEL);
-	if (!tmp->state)
-		goto out_free_pardevice;
-
-	tmp->name = name;
-	tmp->port = port;
-	tmp->daisy = -1;
-	tmp->preempt = pf;
-	tmp->wakeup = kf;
-	tmp->private = handle;
-	tmp->flags = flags;
-	tmp->irq_func = irq_func;
-	tmp->waiting = 0;
-	tmp->timeout = 5 * HZ;
-	tmp->devmodel = false;
-
-	/* Chain this onto the list */
-	tmp->prev = NULL;
-	/*
-	 * This function must not run from an irq handler so we don' t need
-	 * to clear irq on the local CPU. -arca
-	 */
-	spin_lock(&port->physport->pardevice_lock);
-
-	if (flags & PARPORT_DEV_EXCL) {
-		if (port->physport->devices) {
-			spin_unlock(&port->physport->pardevice_lock);
-			printk(KERN_DEBUG "%s: cannot grant exclusive access for device %s\n",
-			       port->name, name);
-			goto out_free_all;
-		}
-		port->flags |= PARPORT_FLAG_EXCL;
-	}
-
-	tmp->next = port->physport->devices;
-	wmb(); /*
-		* Make sure that tmp->next is written before it's
-		* added to the list; see comments marked 'no locking
-		* required'
-		*/
-	if (port->physport->devices)
-		port->physport->devices->prev = tmp;
-	port->physport->devices = tmp;
-	spin_unlock(&port->physport->pardevice_lock);
-
-	init_waitqueue_head(&tmp->wait_q);
-	tmp->timeslice = parport_default_timeslice;
-	tmp->waitnext = tmp->waitprev = NULL;
-
-	/*
-	 * This has to be run as last thing since init_state may need other
-	 * pardevice fields. -arca
-	 */
-	port->ops->init_state(tmp, tmp->state);
-	if (!test_and_set_bit(PARPORT_DEVPROC_REGISTERED, &port->devflags)) {
-		port->proc_device = tmp;
-		parport_device_proc_register(tmp);
-	}
-	return tmp;
-
- out_free_all:
-	kfree(tmp->state);
- out_free_pardevice:
-	kfree(tmp);
- out:
-	parport_put_port(port);
-	module_put(port->ops->owner);
-
-	return NULL;
-}
-EXPORT_SYMBOL(parport_register_device);
-
 static void free_pardevice(struct device *dev)
 {
 	struct pardevice *par_dev = to_pardevice(dev);
diff --git a/include/linux/parport.h b/include/linux/parport.h
index 36a0f6270238..1fb508c19e83 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -325,18 +325,6 @@ struct pardev_cb {
 	unsigned int flags;
 };
 
-/* parport_register_device declares that a device is connected to a
-   port, and tells the kernel all it needs to know.
-   - pf is the preemption function (may be NULL for no callback)
-   - kf is the wake-up function (may be NULL for no callback)
-   - irq_func is the interrupt handler (may be NULL for no interrupts)
-   - handle is a user pointer that gets handed to callback functions.  */
-struct pardevice *parport_register_device(struct parport *port, 
-			  const char *name,
-			  int (*pf)(void *), void (*kf)(void *),
-			  void (*irq_func)(void *), 
-			  int flags, void *handle);
-
 /*
  * parport_register_dev_model declares that a device is connected to a
  * port, and tells the kernel all it needs to know.
-- 
2.11.0


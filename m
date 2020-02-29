Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25023C3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 19:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC3D424688
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 19:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgB2TfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 14:35:16 -0500
Received: from smtprelay0087.hostedemail.com ([216.40.44.87]:46586 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727169AbgB2TfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 14:35:16 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id D274418037D39;
        Sat, 29 Feb 2020 19:35:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: spot30_84e41545dce18
X-Filterd-Recvd-Size: 21547
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Sat, 29 Feb 2020 19:35:13 +0000 (UTC)
Message-ID: <3b5e2c9f59b8296af3992c5d979d4c4dae05244d.camel@perches.com>
Subject: Re: [PATCH 0/7] parport: Use generic kernel logging styles
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-parisc@vger.kernel.org
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org
Date:   Sat, 29 Feb 2020 11:33:39 -0800
In-Reply-To: <d03d6ce4-f40e-2905-1641-089a82720383@infradead.org>
References: <69fb1d36-b6cf-7c46-96d1-9403de6ab47a@infradead.org>
         <cover.1582878393.git.joe@perches.com>
         <d03d6ce4-f40e-2905-1641-089a82720383@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-02-29 at 08:40 -0800, Randy Dunlap wrote:
> On 2/28/20 12:32 AM, Joe Perches wrote:
> > Well, if the parport logging is getting some generic fixing,
> > here's some more generic logging fixing...
> > 
> > Joe Perches (7):
> >   parport: Convert printk(KERN_<LEVEL> to pr_<level>(
> >   parport: Use more comon logging styles
> >   parport: daisy: Convert DPRINTK to pr_debug
> >   parport_amiga: Convert DPRINTK to pr_debug
> >   parport_mfc3: Convert DPRINTK to pr_debug
> >   parport_pc: Convert DPRINTK to pr_debug
> >   parport: Standardize use of printmode
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

btw: Sudip

After this recent daisy change:
---------------------------------------------------------------------

commit 60f8a59ddcdc7fb7c17180ba10d9c49bc91156c7
Author: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Wed Oct 16 15:45:40 2019 +0100

    parport: daisy: use new parport device model
    
    Modify parport daisy driver to use the new parallel port device model.
    
    Last attempt was '1aec4211204d ("parport: daisy: use new parport device
    model")' which failed as daisy was also trying to load the low level
    driver and that resulted in a deadlock.

---------------------------------------------------------------------

parport_register_device is no longer in use and
parport_register_dev_model is used instead.

Documentation/driver-api/parport-lowlevel.rst
should be updated and the various comments can
be updated or deleted.

$ git grep -w parport_register_device
Documentation/driver-api/parport-lowlevel.rst:  parport_register_device
Documentation/driver-api/parport-lowlevel.rst:          dev[count++] = parport_register_device (...);
Documentation/driver-api/parport-lowlevel.rst:parport_unregister_driver, parport_register_device, parport_enumerate
Documentation/driver-api/parport-lowlevel.rst:parport_register_device - register to use a port
Documentation/driver-api/parport-lowlevel.rst:  struct pardevice *parport_register_device(struct parport *port,
Documentation/driver-api/parport-lowlevel.rst:          private->dev = parport_register_device (port, "toaster", preempt,
Documentation/driver-api/parport-lowlevel.rst:This function is the opposite of parport_register_device.  After using
Documentation/driver-api/parport-lowlevel.rst:This is like parport_register_device but takes a device number instead
Documentation/driver-api/parport-lowlevel.rst:See parport_register_device.  If no device is associated with devnum,
Documentation/driver-api/parport-lowlevel.rst:parport_register_device
drivers/parport/daisy.c: *      This function is similar to parport_register_device(), except
drivers/parport/daisy.c: *      parport_register_device().  The return value is the same as
drivers/parport/daisy.c: *      for parport_register_device().
drivers/parport/daisy.c: *      parport_register_device().
drivers/parport/share.c: *      parport_register_device() on that port will do this for you.
drivers/parport/share.c: *      parport_register_device - register a device on a parallel port
drivers/parport/share.c:parport_register_device(struct parport *port, const char *name,
drivers/parport/share.c:EXPORT_SYMBOL(parport_register_device);
drivers/parport/share.c: *      This undoes the effect of parport_register_device().
include/linux/parport.h:/* parport_register_device declares that a device is connected to a
include/linux/parport.h:struct pardevice *parport_register_device(struct parport *port, 
scripts/kernel-doc:    # - parport_register_device (function pointer parameters)

Maybe something like this is necessary:
(it will need to be edited, I just deleted the references)
---
 Documentation/driver-api/parport-lowlevel.rst |  72 ++--------
 drivers/auxdisplay/panel.c                    |   2 +-
 drivers/parport/daisy.c                       |  10 +-
 drivers/parport/share.c                       | 197 +-------------------------
 include/linux/parport.h                       |  12 --
 scripts/kernel-doc                            |   1 -
 6 files changed, 17 insertions(+), 277 deletions(-)

diff --git a/Documentation/driver-api/parport-lowlevel.rst b/Documentation/driver-api/parport-lowlevel.rst
index 0633d70..42b1c87 100644
--- a/Documentation/driver-api/parport-lowlevel.rst
+++ b/Documentation/driver-api/parport-lowlevel.rst
@@ -10,7 +10,7 @@ Global functions::
   parport_register_driver
   parport_unregister_driver
   parport_enumerate
-  parport_register_device
+  parport_register_dev_model
   parport_unregister_device
   parport_claim
   parport_claim_or_block
@@ -205,7 +205,7 @@ EXAMPLE
 	{
 		...
 		private = kmalloc (...);
-		dev[count++] = parport_register_device (...);
+		dev[count++] = parport_register_dev_model (...);
 		...
 	}
 
@@ -235,7 +235,7 @@ EXAMPLE
 SEE ALSO
 ^^^^^^^^
 
-parport_unregister_driver, parport_register_device, parport_enumerate
+parport_unregister_driver, parport_enumerate
 
 
 
@@ -354,7 +354,7 @@ parport_register_driver, parport_unregister_driver
 
 
 
-parport_register_device - register to use a port
+parport_register_dev_model - register to use a port
 ------------------------------------------------
 
 SYNOPSIS
@@ -368,60 +368,21 @@ SYNOPSIS
 	typedef void (*wakeup_func) (void *handle);
 	typedef int (*irq_func) (int irq, void *handle, struct pt_regs *);
 
-	struct pardevice *parport_register_device(struct parport *port,
-						  const char *name,
-						  preempt_func preempt,
-						  wakeup_func wakeup,
-						  irq_func irq,
-						  int flags,
-						  void *handle);
+	struct pardevice *parport_register_dev_model(struct parport *port,
+						     const char *name,
+						     const struct pardev_cb *par_dev_cb,
+						     int cnt);
 
 DESCRIPTION
 ^^^^^^^^^^^
 
 Use this function to register your device driver on a parallel port
-(``port``).  Once you have done that, you will be able to use
-parport_claim and parport_release in order to use the port.
+(``port``).
 
 The (``name``) argument is the name of the device that appears in /proc
 filesystem. The string must be valid for the whole lifetime of the
 device (until parport_unregister_device is called).
 
-This function will register three callbacks into your driver:
-``preempt``, ``wakeup`` and ``irq``.  Each of these may be NULL in order to
-indicate that you do not want a callback.
-
-When the ``preempt`` function is called, it is because another driver
-wishes to use the parallel port.  The ``preempt`` function should return
-non-zero if the parallel port cannot be released yet -- if zero is
-returned, the port is lost to another driver and the port must be
-re-claimed before use.
-
-The ``wakeup`` function is called once another driver has released the
-port and no other driver has yet claimed it.  You can claim the
-parallel port from within the ``wakeup`` function (in which case the
-claim is guaranteed to succeed), or choose not to if you don't need it
-now.
-
-If an interrupt occurs on the parallel port your driver has claimed,
-the ``irq`` function will be called. (Write something about shared
-interrupts here.)
-
-The ``handle`` is a pointer to driver-specific data, and is passed to
-the callback functions.
-
-``flags`` may be a bitwise combination of the following flags:
-
-  ===================== =================================================
-        Flag            Meaning
-  ===================== =================================================
-  PARPORT_DEV_EXCL	The device cannot share the parallel port at all.
-			Use this only when absolutely necessary.
-  ===================== =================================================
-
-The typedefs are not actually defined -- they are only shown in order
-to make the function prototype more readable.
-
 The visible parts of the returned ``struct pardevice`` are::
 
 	struct pardevice {
@@ -468,9 +429,7 @@ EXAMPLE
 
 	static int toaster_detect (struct toaster *private, struct parport *port)
 	{
-		private->dev = parport_register_device (port, "toaster", preempt,
-							wakeup, NULL, 0,
-							private);
+		private->dev = parport_register_dev_model(port, "toaster", ...);
 		if (!private->dev)
 			/* Couldn't register with parport. */
 			return -EIO;
@@ -511,7 +470,7 @@ SYNPOPSIS
 DESCRIPTION
 ^^^^^^^^^^^
 
-This function is the opposite of parport_register_device.  After using
+This function is the opposite of parport_register_dev_model.  After using
 parport_unregister_device, ``dev`` is no longer a valid device handle.
 
 You should not unregister a device that is currently claimed, although
@@ -879,20 +838,15 @@ SYNOPSIS
 DESCRIPTION
 ^^^^^^^^^^^
 
-This is like parport_register_device but takes a device number instead
+This is like parport_register_dev_model but takes a device number instead
 of a pointer to a struct parport.
 
 RETURN VALUE
 ^^^^^^^^^^^^
 
-See parport_register_device.  If no device is associated with devnum,
+See parport_register_dev_model.  If no device is associated with devnum,
 NULL is returned.
 
-SEE ALSO
-^^^^^^^^
-
-parport_register_device
-
 
 
 parport_close - unregister device for particular device number
diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 85965953..cf4b12 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -1589,7 +1589,7 @@ static void panel_attach(struct parport *port)
 
 	pprt = parport_register_dev_model(port, "panel", &panel_cb, 0);
 	if (!pprt) {
-		pr_err("%s: port->number=%d parport=%d, parport_register_device() failed\n",
+		pr_err("%s: port->number=%d parport=%d, parport_register_dev_model() failed\n",
 		       __func__, port->number, parport);
 		return;
 	}
diff --git a/drivers/parport/daisy.c b/drivers/parport/daisy.c
index 6d78ec..7dc641 100644
--- a/drivers/parport/daisy.c
+++ b/drivers/parport/daisy.c
@@ -228,14 +228,6 @@ void parport_daisy_fini(struct parport *port)
  *	parport_open - find a device by canonical device number
  *	@devnum: canonical device number
  *	@name: name to associate with the device
- *
- *	This function is similar to parport_register_device(), except
- *	that it locates a device by its number rather than by the port
- *	it is attached to.
- *
- *	All parameters except for @devnum are the same as for
- *	parport_register_device().  The return value is the same as
- *	for parport_register_device().
  **/
 
 struct pardevice *parport_open(int devnum, const char *name)
@@ -289,7 +281,7 @@ struct pardevice *parport_open(int devnum, const char *name)
  *	@dev: device to close
  *
  *	This is to parport_open() as parport_unregister_device() is to
- *	parport_register_device().
+ *	parport_register_dev_model().
  **/
 
 void parport_close(struct pardevice *dev)
diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 3169fee..484723 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -262,8 +262,7 @@ static int port_detect(struct device *dev, void *dev_drv)
  *	The driver's attach() function may block.  The port that
  *	attach() is given will be valid for the duration of the
  *	callback, but if the driver wants to take a copy of the
- *	pointer it must call parport_get_port() to do so.  Calling
- *	parport_register_device() on that port will do this for you.
+ *	pointer it must call parport_get_port() to do so.
  *
  *	The driver's detach() function may block.  The port that
  *	detach() is given will be valid for the duration of the
@@ -641,198 +640,6 @@ void parport_remove_port(struct parport *port)
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
@@ -986,7 +793,7 @@ EXPORT_SYMBOL(parport_register_dev_model);
  *	parport_unregister_device - deregister a device on a parallel port
  *	@dev: pointer to structure representing device
  *
- *	This undoes the effect of parport_register_device().
+ *	This undoes the effect of parport_register_dev_model().
  **/
 
 void parport_unregister_device(struct pardevice *dev)
diff --git a/include/linux/parport.h b/include/linux/parport.h
index 13932ce..b7a5d06 100644
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
 struct pardevice *
 parport_register_dev_model(struct parport *port, const char *name,
 			   const struct pardev_cb *par_dev_cb, int cnt);
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index f2d73f..acd0e3 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1607,7 +1607,6 @@ sub dump_function($$) {
     #
     # If you mess with these regexps, it's a good idea to check that
     # the following functions' documentation still comes out right:
-    # - parport_register_device (function pointer parameters)
     # - atomic_set (macro)
     # - pci_match_device, __copy_to_user (long return type)
 


Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A165C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B57022510
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KQHmh359";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ImtnlcJ3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgGNOLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:11:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43998 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgGNOLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:11:39 -0400
Date:   Tue, 14 Jul 2020 16:11:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594735897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JeIQ3P4wYQehcuP5rdazH48Xayk7TLAphsc9ayU/skc=;
        b=KQHmh359AhnE0Yc29/cztUPNOuA2hDJa2FTg+OIf3pnghDrYXsVLNgo7BqlEG36Q4+lBsS
        jo/ZlUU9k2R+tH1LuE1yLFespUMOCB2HbSThJc7veRoTtiW+TOXpMm6MwW7r+oaGtXlClA
        Xksm1mZX2f3uK22HyWHDaNtmvWlfNgmApxlKthab5hUFvAXGVqUsMtEpWg4GNzJ7gDR98S
        SRV/JiynF4YYrKQpfBSEV4BMfwKqGPrBSbMTZpJaq5HmP9UMXIBuxL7zlXUV0vjJS/GYAt
        dz4eD08lgF09dgZgljm4cIHkiK7ukO8dtKyPbvAaL+AksNIFoN7SOBJKUEnx1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594735897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JeIQ3P4wYQehcuP5rdazH48Xayk7TLAphsc9ayU/skc=;
        b=ImtnlcJ3L8NSKe+FtsbIjjfsAPIXFMc0olxzPEWXzgGnhnf6t9VJ+6OhLe+mWyUg4+7F7O
        pCQfexCLYQ85OyBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Stephen Berman <stephen.berman@gmx.net>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
Message-ID: <20200714141135.47adndrsdgpiqfy4@linutronix.de>
References: <20200616073827.vysntufld3ves666@linutronix.de>
 <87o8pjh1i0.fsf@gmx.net>
 <20200616155501.psduxnisltitodme@linutronix.de>
 <871rmesqkk.fsf@gmx.net>
 <20200617142734.mxwfoblufmo6li5e@linutronix.de>
 <87ftatqu07.fsf@gmx.net>
 <20200624201156.xu6hel3drnhno6c3@linutronix.de>
 <87ftak2kxr.fsf@rub.de>
 <20200714134410.3odqfvjq6rndjjf6@linutronix.de>
 <CAJZ5v0hZSUkEMCszDADGWk-v0xNEiDE45B3CHLi05BX6rPfm6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hxwaiyslsko5zit6"
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hZSUkEMCszDADGWk-v0xNEiDE45B3CHLi05BX6rPfm6g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hxwaiyslsko5zit6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 2020-07-14 15:54:57 [+0200], Rafael J. Wysocki wrote:
> On Tue, Jul 14, 2020 at 3:44 PM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:>
> > On 2020-06-24 23:49:52 [+0200], Stephen Berman wrote:
> >
> > Let me summarize the thread here:
> >
> > On Stephen's system, ACPI informs the thermal zone driver to poll the
> > temperature every second and the driver does so.
> > The driver queries the temperature by invoking acpi_evaluate_integer()
> > which invokes (at some point) acpi_ev_queue_notify_request().
> 
> Well, I don't quite see how acpi_ev_queue_notify_request() can be
> invoked from the acpi_evaluate_integer() code path.
> 
> Do you have a call trace showing that?

So the trace in 
     https://lore.kernel.org/linux-acpi/87o8pjh1i0.fsf@gmx.net/

shows the pattern and we nailed it down that it comes from
thermal_get_temp(). I assumed acpi_ex_opcode_2A_0T_0R() since the other
candidate was acpi_ev_asynch_execute_gpe_method().

Stephen, the patch attached adds a WARN_ON() statement which will
produce a stack trace (4 or so). Could please run 'dmesg' after a while
and send it back. There should be a
    "WARNING in drivers/acpi/acpica/evmisc.c" 

statement or something along the lines.

Rafael, are you also interested in an ACPI dump?

> Cheers!

Sebastian

--hxwaiyslsko5zit6
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="acpi_dbg.patch"

diff --git a/drivers/acpi/acpica/evgpe.c b/drivers/acpi/acpica/evgpe.c
index 3e39907fedd9f..816e23d103c63 100644
--- a/drivers/acpi/acpica/evgpe.c
+++ b/drivers/acpi/acpica/evgpe.c
@@ -477,6 +477,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 		 * notifies on multiple device objects.
 		 */
 		notify = gpe_event_info->dispatch.notify_list;
+		trace_printk("notify %px\n", gpe_event_info);
 		while (ACPI_SUCCESS(status) && notify) {
 			status =
 			    acpi_ev_queue_notify_request(notify->device_node,
@@ -484,6 +485,7 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 
 			notify = notify->next;
 		}
+		trace_printk("Event notify %px done %x\n", gpe_event_info, status);
 
 		break;
 
@@ -491,6 +493,9 @@ static void ACPI_SYSTEM_XFACE acpi_ev_asynch_execute_gpe_method(void *context)
 
 		/* Allocate the evaluation information block */
 
+		trace_printk("Evaluate %4.4s\n",
+			     acpi_ut_get_node_name(gpe_event_info->dispatch.method_node));
+
 		info = ACPI_ALLOCATE_ZEROED(sizeof(struct acpi_evaluate_info));
 		if (!info) {
 			status = AE_NO_MEMORY;
diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmisc.c
index ce1eda6beb845..d8e3f426729db 100644
--- a/drivers/acpi/acpica/evmisc.c
+++ b/drivers/acpi/acpica/evmisc.c
@@ -72,6 +72,7 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node *node, u32 notify_value)
 	union acpi_generic_state *info;
 	u8 handler_list_id = 0;
 	acpi_status status = AE_OK;
+	static int num_req = 0;
 
 	ACPI_FUNCTION_NAME(ev_queue_notify_request);
 
@@ -129,19 +130,20 @@ acpi_ev_queue_notify_request(struct acpi_namespace_node *node, u32 notify_value)
 	info->notify.handler_list_head = handler_list_head;
 	info->notify.global = &acpi_gbl_global_notify[handler_list_id];
 
-	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
-			  "Dispatching Notify on [%4.4s] (%s) Value 0x%2.2X (%s) Node %p\n",
+	trace_printk("Dispatching Notify on [%4.4s] (%s) Value 0x%2.2X (%s) Node %px\n",
 			  acpi_ut_get_node_name(node),
 			  acpi_ut_get_type_name(node->type), notify_value,
 			  acpi_ut_get_notify_name(notify_value, ACPI_TYPE_ANY),
-			  node));
+			  node);
+	WARN_ON(num_req > 10 && num_req < 15);
 
 	status = acpi_os_execute(OSL_NOTIFY_HANDLER,
 				 acpi_ev_notify_dispatch, info);
 	if (ACPI_FAILURE(status)) {
 		acpi_ut_delete_generic_state(info);
 	}
-
+	if (num_req++ == 300)
+		tracing_off();
 	return (status);
 }
 
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 762c5d50b8fe2..67d5ac9aa433d 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -844,6 +844,16 @@ static void acpi_os_execute_deferred(struct work_struct *work)
 	kfree(dpc);
 }
 
+static void acpi_os_execute_deferred_notify(struct work_struct *work)
+{
+	struct acpi_os_dpc *dpc = container_of(work, struct acpi_os_dpc, work);
+
+	trace_printk("Start %px %pS(%px)\n", dpc, dpc->function, dpc->context);
+	dpc->function(dpc->context);
+	trace_printk("End %px %pS(%px)\n", dpc, dpc->function, dpc->context);
+	kfree(dpc);
+}
+
 #ifdef CONFIG_ACPI_DEBUGGER
 static struct acpi_debugger acpi_debugger;
 static bool acpi_debugger_initialized;
@@ -1096,7 +1106,8 @@ acpi_status acpi_os_execute(acpi_execute_type type,
 	 */
 	if (type == OSL_NOTIFY_HANDLER) {
 		queue = kacpi_notify_wq;
-		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
+		trace_printk("Adding %pS %px <%px>\n", function, context, dpc);
+		INIT_WORK(&dpc->work, acpi_os_execute_deferred_notify);
 	} else if (type == OSL_GPE_HANDLER) {
 		queue = kacpid_wq;
 		INIT_WORK(&dpc->work, acpi_os_execute_deferred);
diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 19067a5e52934..883eb37592639 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -191,7 +191,9 @@ static int acpi_thermal_get_temperature(struct acpi_thermal *tz)
 
 	tz->last_temperature = tz->temperature;
 
+	printk("Query temp\n");
 	status = acpi_evaluate_integer(tz->device->handle, "_TMP", NULL, &tmp);
+	printk("Query temp done: %d\n", status);
 	if (ACPI_FAILURE(status))
 		return -ENODEV;
 

--hxwaiyslsko5zit6--

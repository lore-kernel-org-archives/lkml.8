Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D59C433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3394320720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tJGdUY6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730723AbgGUTgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 15:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbgGUTgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 15:36:12 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB0CC061794;
        Tue, 21 Jul 2020 12:36:12 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ed14so9900634qvb.2;
        Tue, 21 Jul 2020 12:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rIE6TxmD9oIdbMIzjWrd9kXPxFh/SkCx0zmXfX+fCbI=;
        b=tJGdUY6s7FhPbgTO8CqKNzFESpUhmdvH/LxLzmoRorl5t3YtQGsI9EV+f7tpB8fbcc
         vRZk/S4eNorEuxPYfrnczJDJzzcH3QBNpMLsxCgjNcNVQ1a4NRQjr4VZN69dELzaXh4f
         co6VHUyKgEA0MIezRHaK7OE6LDV+0+XhaH8IRli/kEewyVd4sCgi3JOb351wRplPfmsu
         opZ6fE0q0SHNIOiHvjb79bjfzxKzlyEu2KSHo5bn/+n5yGWVaRYztuncf+WXPPk7mjht
         GB29PS8aPRz1oYvIF2Gsx2ipMHFSR3KV9++7jXjaOGCc0nap8ZuT3IaDKBYLmT3R4WBa
         pp5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rIE6TxmD9oIdbMIzjWrd9kXPxFh/SkCx0zmXfX+fCbI=;
        b=FHNDUM9rcWV/oEyW2cYNujJjoAZmRduWer6n1QNkoTpVRf7xhdWb7opbhtr7cJYW5d
         9ZAQxwTG3CNm2fecolSKmPRcQZjspb5vqv9QkRpi0rQ3PRbYIMOGXr48dHmrqbH1mXV8
         Dz35YdzLmKgVumKl0MCPPAFlxdyDLQiFrtgjnuIntz/aqsZEw+WQXg1uZkDqpAiAgas3
         ds4eqG4SiEzm1dmMkVGczvZfU7ajyr32hi4zEKvJbFHVvP47wPvx2olD7A3VN2U/clvO
         6NbmxUBQsuCAt2STl7nCnzbAzwOceV66Z1+zvMjKyV0lbvZI1ts+B2t8PH6O8Lfsx1XY
         L7+w==
X-Gm-Message-State: AOAM531ss0Imp55ZVpqF8gcah+4hbwMblZiYyJ8TZxfOXknf4YJGDyte
        RrfW3bd0KMIgHRQOerRkiOc=
X-Google-Smtp-Source: ABdhPJwIEeE4bd5LJDxdVOmMLGPdhYEvQIi2S+D9OU7kzfttd0JO9osN9Wxl4Tj8BIsy21R2FYzFvQ==
X-Received: by 2002:a0c:aa9b:: with SMTP id f27mr28590776qvb.9.1595360170709;
        Tue, 21 Jul 2020 12:36:10 -0700 (PDT)
Received: from localhost.localdomain (072-189-064-225.res.spectrum.com. [72.189.64.225])
        by smtp.gmail.com with ESMTPSA id j72sm3331351qke.20.2020.07.21.12.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 12:36:09 -0700 (PDT)
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     jic23@kernel.org
Cc:     kamel.bouhara@bootlin.com, gwendal@chromium.org,
        alexandre.belloni@bootlin.com, david@lechnology.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, syednwaris@gmail.com,
        patrick.havelange@essensium.com, fabrice.gasnier@st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Subject: [PATCH v4 1/5] counter: Internalize sysfs interface code
Date:   Tue, 21 Jul 2020 15:35:47 -0400
Message-Id: <e13d43849f68af8227c6aaa0ef672b459d47e9ab.1595358237.git.vilhelm.gray@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1595358237.git.vilhelm.gray@gmail.com>
References: <cover.1595358237.git.vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a reimplementation of the Generic Counter driver interface.
There are no modifications to the Counter subsystem userspace interface,
so existing userspace applications should continue to run seamlessly.

Overview
========

The purpose of this patch is to internalize the sysfs interface code
among the various counter drivers into a shared module. Counter drivers
pass and take data natively (i.e. u8, u64, etc.) and the shared counter
module handles the translation between the sysfs interface. This
gurantees a standard userspace interface for all counter drivers, and
helps generalize the Generic Counter driver ABI in order to support the
Generic Counter chrdev interface (introduced in a subsequent patch)
without significant changes to the existing counter drivers.

A high-level view of how a count value is passed down from a counter
driver is exemplified by the following:

                 ----------------------
                / Counter device       \
                +----------------------+
                | Count register: 0x28 |
                +----------------------+
                        |
                 -----------------
                / raw count data /
                -----------------
                        |
                        V
                +----------------------------+
                | Counter device driver      |----------+
                +----------------------------+          |
                | Processes data from device |   -------------------
                |----------------------------|  / driver callbacks /
                | Type: u64                  |  -------------------
                | Value: 42                  |          |
                +----------------------------+          |
                        |                               |
                 ----------                             |
                / u64     /                             |
                ----------                              |
                        |                               |
                        |                               V
                        |               +----------------------+
                        |               | Counter core         |
                        |               +----------------------+
                        |               | Routes device driver |
                        |               | callbacks to the     |
                        |               | userspace interfaces |
                        |               +----------------------+
                        |                       |
                        |                -------------------
                        |               / driver callbacks /
                        |               -------------------
                        |                       |
                +-------+                       |
                |                               |
                |               +---------------+
                |               |
                V               |
        +--------------------+  |
        | Counter sysfs      |<-+
        +--------------------+
        | Translates to the  |
        | standard Counter   |
        | sysfs output       |
        |--------------------|
        | Type: const char * |
        | Value: "42"        |
        +--------------------+
                |
         ---------------
        / const char * /
        ---------------
                |
                V
        +--------------------------------------------------+
        | `/sys/bus/counter/devices/counterX/countY/count` |
        +--------------------------------------------------+
        \ Count: "42"                                      /
         --------------------------------------------------

There are three primary components involved:

	Counter device driver
	---------------------
	Communicates with the hardware device to read/write data; e.g.
	counter drivers for 104-quad-8, stm32-timer, etc.

	Counter core
	------------
	Registers the counter device driver to the system so that the
	respective callbacks are called during userspace interaction

	Counter sysfs
	-------------
	Translates counter data to the standard Counter sysfs interface
	format and vice versa

Driver ABI
==========

This reimplementation entails several changes to the driver ABI. In
particular, the device driver callbacks are now expected to handle
standard C datatypes rather than translating the sysfs I/O directly.

To that end, the struct counter_data structure is introduced to
establish counter extensions for Signals, Synapses, and Counts.

The "type" member specifies the type of high-level data (e.g. BOOL,
COUNT_DIRECTION, etc.) handled by this extension. The "*_read" and
"*_write" members can then be set by the counter device driver with
callbacks to handle that data using native C data types (i.e. u8, u64,
etc.).

Convenience macros such as COUNTER_DATA_COUNT_U64 are provided for use
by driver authors. In particular, driver authors are expected to use
the provided macros for standard Counter subsystem attributes in order
to maintain a consistent interface for userspace. For example, a counter
device driver may define several standard attributes like so:

struct counter_data count_ext[] = {
	COUNTER_DATA_DIRECTION(count_direction_read),
	COUNTER_DATA_ENABLE(count_enable_read, count_enable_write),
	COUNTER_DATA_CEILING(count_ceiling_read, count_ceiling_write),
};

This makes it simple to see, add, and modify the attributes that are
supported by this driver ("direction", "enable", and "ceiling") and to
maintain this code without getting lost in a web of struct braces.

Callbacks must match the function type expected for the respective
component or extension. These function types are defined in the struct
counter_data structure as the "*_read" and "*_write" union members.

The corresponding callback prototypes for the extensions above would be:

int count_direction_read(struct counter_device *counter,
			 struct counter_count *count, u8 *direction);
int count_enable_read(struct counter_device *counter,
		      struct counter_count *count, u8 *enable);
int count_enable_write(struct counter_device *counter,
		       struct counter_count *count, u8 enable);
int count_ceiling_read(struct counter_device *counter,
		       struct counter_count *count, u64 *ceiling);
int count_ceiling_write(struct counter_device *counter,
			struct counter_count *count, u64 ceiling);

In this way, driver authors no longer need to mess with sysfs strings
and are instead able to focus on what they actually care about doing --
getting data to/from the devices -- while the Generic Counter interface
handles the translation of that data for them between the various
userspace interfaces (e.g. sysfs and chardev).

Architecture
============

Counter device registration is the same as before: drivers populate a
struct counter_device with components and callbacks, then pass the
structure to the devm_counter_register function. However, what's
different now is how the Counter subsystem code handles this
registration internally.

Whereas before callbacks would interact directly with sysfs data, this
interaction is now abstracted and instead callbacks interact with native
C data types. The counter_data structure forms the basis for Counter
extentions.

The counter-sysfs.c file contains the code to parse through the
counter_device structure and register the requested components and
extensions. Attributes are created and populated based on type, with
respective translation functions to handle the mapping between sysfs and
the counter driver callbacks.

The translation performed for each attribute is straightforward: the
attribute type and data is parsed from the counter_attribute structure,
the respective counter driver read/write callback is called, and sysfs
I/O is handled before or after the driver read/write function is called.

Cc: Syed Nayyar Waris <syednwaris@gmail.com>
Cc: Patrick Havelange <patrick.havelange@essensium.com>
Cc: Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc: Fabrice Gasnier <fabrice.gasnier@st.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: David Lechner <david@lechnology.com>
Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
---
 MAINTAINERS                             |    2 +-
 drivers/counter/104-quad-8.c            |  474 +++----
 drivers/counter/Makefile                |    1 +
 drivers/counter/counter-core.c          |  157 +++
 drivers/counter/counter-sysfs.c         |  849 +++++++++++++
 drivers/counter/counter-sysfs.h         |   14 +
 drivers/counter/counter.c               | 1496 -----------------------
 drivers/counter/ftm-quaddec.c           |   59 +-
 drivers/counter/microchip-tcb-capture.c |  104 +-
 drivers/counter/stm32-lptimer-cnt.c     |  161 +--
 drivers/counter/stm32-timer-cnt.c       |  139 +--
 drivers/counter/ti-eqep.c               |  211 ++--
 include/linux/counter.h                 |  618 ++++------
 include/linux/counter_enum.h            |   45 -
 include/uapi/linux/counter.h            |   38 +
 15 files changed, 1829 insertions(+), 2539 deletions(-)
 create mode 100644 drivers/counter/counter-core.c
 create mode 100644 drivers/counter/counter-sysfs.c
 create mode 100644 drivers/counter/counter-sysfs.h
 delete mode 100644 drivers/counter/counter.c
 delete mode 100644 include/linux/counter_enum.h
 create mode 100644 include/uapi/linux/counter.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9077411c9890..a94d8b900c2f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4415,7 +4415,7 @@ F:	Documentation/ABI/testing/sysfs-bus-counter*
 F:	Documentation/driver-api/generic-counter.rst
 F:	drivers/counter/
 F:	include/linux/counter.h
-F:	include/linux/counter_enum.h
+F:	include/uapi/linux/counter.h
 
 CPMAC ETHERNET DRIVER
 M:	Florian Fainelli <f.fainelli@gmail.com>
diff --git a/drivers/counter/104-quad-8.c b/drivers/counter/104-quad-8.c
index 78766b6ec271..0f20920073d6 100644
--- a/drivers/counter/104-quad-8.c
+++ b/drivers/counter/104-quad-8.c
@@ -621,7 +621,7 @@ static const struct iio_chan_spec quad8_channels[] = {
 };
 
 static int quad8_signal_read(struct counter_device *counter,
-	struct counter_signal *signal, enum counter_signal_value *val)
+			     struct counter_signal *signal, u8 *val)
 {
 	const struct quad8_iio *const priv = counter->priv;
 	unsigned int state;
@@ -639,7 +639,7 @@ static int quad8_signal_read(struct counter_device *counter,
 }
 
 static int quad8_count_read(struct counter_device *counter,
-	struct counter_count *count, unsigned long *val)
+			    struct counter_count *count, u64 *val)
 {
 	struct quad8_iio *const priv = counter->priv;
 	const int base_offset = priv->base + 2 * count->id;
@@ -670,7 +670,7 @@ static int quad8_count_read(struct counter_device *counter,
 }
 
 static int quad8_count_write(struct counter_device *counter,
-	struct counter_count *count, unsigned long val)
+			     struct counter_count *count, u64 val)
 {
 	struct quad8_iio *const priv = counter->priv;
 	const int base_offset = priv->base + 2 * count->id;
@@ -710,22 +710,16 @@ static int quad8_count_write(struct counter_device *counter,
 	return 0;
 }
 
-enum quad8_count_function {
-	QUAD8_COUNT_FUNCTION_PULSE_DIRECTION = 0,
-	QUAD8_COUNT_FUNCTION_QUADRATURE_X1,
-	QUAD8_COUNT_FUNCTION_QUADRATURE_X2,
-	QUAD8_COUNT_FUNCTION_QUADRATURE_X4
-};
 
-static enum counter_count_function quad8_count_functions_list[] = {
-	[QUAD8_COUNT_FUNCTION_PULSE_DIRECTION] = COUNTER_COUNT_FUNCTION_PULSE_DIRECTION,
-	[QUAD8_COUNT_FUNCTION_QUADRATURE_X1] = COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A,
-	[QUAD8_COUNT_FUNCTION_QUADRATURE_X2] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
-	[QUAD8_COUNT_FUNCTION_QUADRATURE_X4] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4
+static const u8 quad8_count_functions_list[] = {
+	COUNTER_COUNT_FUNCTION_PULSE_DIRECTION,
+	COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A,
+	COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
+	COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
 };
 
-static int quad8_function_get(struct counter_device *counter,
-	struct counter_count *count, size_t *function)
+static int quad8_function_read(struct counter_device *counter,
+			       struct counter_count *count, u8 *function)
 {
 	struct quad8_iio *const priv = counter->priv;
 	const int id = count->id;
@@ -735,25 +729,25 @@ static int quad8_function_get(struct counter_device *counter,
 	if (priv->quadrature_mode[id])
 		switch (priv->quadrature_scale[id]) {
 		case 0:
-			*function = QUAD8_COUNT_FUNCTION_QUADRATURE_X1;
+			*function = COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A;
 			break;
 		case 1:
-			*function = QUAD8_COUNT_FUNCTION_QUADRATURE_X2;
+			*function = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A;
 			break;
 		case 2:
-			*function = QUAD8_COUNT_FUNCTION_QUADRATURE_X4;
+			*function = COUNTER_COUNT_FUNCTION_QUADRATURE_X4;
 			break;
 		}
 	else
-		*function = QUAD8_COUNT_FUNCTION_PULSE_DIRECTION;
+		*function = COUNTER_COUNT_FUNCTION_PULSE_DIRECTION;
 
 	mutex_unlock(&priv->lock);
 
 	return 0;
 }
 
-static int quad8_function_set(struct counter_device *counter,
-	struct counter_count *count, size_t function)
+static int quad8_function_write(struct counter_device *counter,
+				struct counter_count *count, u8 function)
 {
 	struct quad8_iio *const priv = counter->priv;
 	const int id = count->id;
@@ -769,7 +763,7 @@ static int quad8_function_set(struct counter_device *counter,
 	mode_cfg = priv->count_mode[id] << 1;
 	idr_cfg = priv->index_polarity[id] << 1;
 
-	if (function == QUAD8_COUNT_FUNCTION_PULSE_DIRECTION) {
+	if (function == COUNTER_COUNT_FUNCTION_PULSE_DIRECTION) {
 		*quadrature_mode = 0;
 
 		/* Quadrature scaling only available in quadrature mode */
@@ -785,15 +779,15 @@ static int quad8_function_set(struct counter_device *counter,
 		*quadrature_mode = 1;
 
 		switch (function) {
-		case QUAD8_COUNT_FUNCTION_QUADRATURE_X1:
+		case COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A:
 			*scale = 0;
 			mode_cfg |= QUAD8_CMR_QUADRATURE_X1;
 			break;
-		case QUAD8_COUNT_FUNCTION_QUADRATURE_X2:
+		case COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A:
 			*scale = 1;
 			mode_cfg |= QUAD8_CMR_QUADRATURE_X2;
 			break;
-		case QUAD8_COUNT_FUNCTION_QUADRATURE_X4:
+		case COUNTER_COUNT_FUNCTION_QUADRATURE_X4:
 			*scale = 2;
 			mode_cfg |= QUAD8_CMR_QUADRATURE_X4;
 			break;
@@ -808,8 +802,8 @@ static int quad8_function_set(struct counter_device *counter,
 	return 0;
 }
 
-static void quad8_direction_get(struct counter_device *counter,
-	struct counter_count *count, enum counter_count_direction *direction)
+static int quad8_direction_read(struct counter_device *counter,
+				struct counter_count *count, u8 *direction)
 {
 	const struct quad8_iio *const priv = counter->priv;
 	unsigned int ud_flag;
@@ -820,93 +814,82 @@ static void quad8_direction_get(struct counter_device *counter,
 
 	*direction = (ud_flag) ? COUNTER_COUNT_DIRECTION_FORWARD :
 		COUNTER_COUNT_DIRECTION_BACKWARD;
-}
 
-enum quad8_synapse_action {
-	QUAD8_SYNAPSE_ACTION_NONE = 0,
-	QUAD8_SYNAPSE_ACTION_RISING_EDGE,
-	QUAD8_SYNAPSE_ACTION_FALLING_EDGE,
-	QUAD8_SYNAPSE_ACTION_BOTH_EDGES
-};
+	return 0;
+}
 
-static enum counter_synapse_action quad8_index_actions_list[] = {
-	[QUAD8_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
-	[QUAD8_SYNAPSE_ACTION_RISING_EDGE] = COUNTER_SYNAPSE_ACTION_RISING_EDGE
+static const u8 quad8_index_actions_list[] = {
+	COUNTER_SYNAPSE_ACTION_NONE,
+	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
 };
 
-static enum counter_synapse_action quad8_synapse_actions_list[] = {
-	[QUAD8_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
-	[QUAD8_SYNAPSE_ACTION_RISING_EDGE] = COUNTER_SYNAPSE_ACTION_RISING_EDGE,
-	[QUAD8_SYNAPSE_ACTION_FALLING_EDGE] = COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
-	[QUAD8_SYNAPSE_ACTION_BOTH_EDGES] = COUNTER_SYNAPSE_ACTION_BOTH_EDGES
+static const u8 quad8_synapse_actions_list[] = {
+	COUNTER_SYNAPSE_ACTION_NONE,
+	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
+	COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
+	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
 };
 
-static int quad8_action_get(struct counter_device *counter,
-	struct counter_count *count, struct counter_synapse *synapse,
-	size_t *action)
+static int quad8_action_read(struct counter_device *counter,
+			     struct counter_count *count,
+			     struct counter_synapse *synapse, u8 *action)
 {
 	struct quad8_iio *const priv = counter->priv;
 	int err;
-	size_t function = 0;
+	u8 function;
 	const size_t signal_a_id = count->synapses[0].signal->id;
-	enum counter_count_direction direction;
+	u8 direction;
 
 	/* Handle Index signals */
 	if (synapse->signal->id >= 16) {
 		if (priv->preset_enable[count->id])
-			*action = QUAD8_SYNAPSE_ACTION_RISING_EDGE;
+			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
 		else
-			*action = QUAD8_SYNAPSE_ACTION_NONE;
+			*action = COUNTER_SYNAPSE_ACTION_NONE;
 
 		return 0;
 	}
 
-	err = quad8_function_get(counter, count, &function);
+	err = quad8_function_read(counter, count, &function);
 	if (err)
 		return err;
 
 	/* Default action mode */
-	*action = QUAD8_SYNAPSE_ACTION_NONE;
+	*action = COUNTER_SYNAPSE_ACTION_NONE;
 
 	/* Determine action mode based on current count function mode */
 	switch (function) {
-	case QUAD8_COUNT_FUNCTION_PULSE_DIRECTION:
+	case COUNTER_COUNT_FUNCTION_PULSE_DIRECTION:
 		if (synapse->signal->id == signal_a_id)
-			*action = QUAD8_SYNAPSE_ACTION_RISING_EDGE;
+			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
 		break;
-	case QUAD8_COUNT_FUNCTION_QUADRATURE_X1:
+	case COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A:
 		if (synapse->signal->id == signal_a_id) {
-			quad8_direction_get(counter, count, &direction);
+			err = quad8_direction_read(counter, count, &direction);
+			if (err)
+				return err;
 
 			if (direction == COUNTER_COUNT_DIRECTION_FORWARD)
-				*action = QUAD8_SYNAPSE_ACTION_RISING_EDGE;
+				*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
 			else
-				*action = QUAD8_SYNAPSE_ACTION_FALLING_EDGE;
+				*action = COUNTER_SYNAPSE_ACTION_FALLING_EDGE;
 		}
 		break;
-	case QUAD8_COUNT_FUNCTION_QUADRATURE_X2:
+	case COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A:
 		if (synapse->signal->id == signal_a_id)
-			*action = QUAD8_SYNAPSE_ACTION_BOTH_EDGES;
+			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
 		break;
-	case QUAD8_COUNT_FUNCTION_QUADRATURE_X4:
-		*action = QUAD8_SYNAPSE_ACTION_BOTH_EDGES;
+	case COUNTER_COUNT_FUNCTION_QUADRATURE_X4:
+		*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
 		break;
 	}
 
 	return 0;
 }
 
-static const struct counter_ops quad8_ops = {
-	.signal_read = quad8_signal_read,
-	.count_read = quad8_count_read,
-	.count_write = quad8_count_write,
-	.function_get = quad8_function_get,
-	.function_set = quad8_function_set,
-	.action_get = quad8_action_get
-};
-
 static int quad8_index_polarity_get(struct counter_device *counter,
-	struct counter_signal *signal, size_t *index_polarity)
+				    struct counter_signal *signal,
+				    u8 *index_polarity)
 {
 	const struct quad8_iio *const priv = counter->priv;
 	const size_t channel_id = signal->id - 16;
@@ -917,20 +900,20 @@ static int quad8_index_polarity_get(struct counter_device *counter,
 }
 
 static int quad8_index_polarity_set(struct counter_device *counter,
-	struct counter_signal *signal, size_t index_polarity)
+				    struct counter_signal *signal,
+				    u8 index_polarity)
 {
 	struct quad8_iio *const priv = counter->priv;
 	const size_t channel_id = signal->id - 16;
 	const int base_offset = priv->base + 2 * channel_id + 1;
-	unsigned int idr_cfg = index_polarity << 1;
+	unsigned int idr_cfg;
 
 	mutex_lock(&priv->lock);
 
-	idr_cfg |= priv->synchronous_mode[channel_id];
-
 	priv->index_polarity[channel_id] = index_polarity;
 
 	/* Load Index Control configuration to Index Control Register */
+	idr_cfg = priv->synchronous_mode[channel_id] | index_polarity << 1;
 	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
 
 	mutex_unlock(&priv->lock);
@@ -938,15 +921,9 @@ static int quad8_index_polarity_set(struct counter_device *counter,
 	return 0;
 }
 
-static struct counter_signal_enum_ext quad8_index_pol_enum = {
-	.items = quad8_index_polarity_modes,
-	.num_items = ARRAY_SIZE(quad8_index_polarity_modes),
-	.get = quad8_index_polarity_get,
-	.set = quad8_index_polarity_set
-};
-
 static int quad8_synchronous_mode_get(struct counter_device *counter,
-	struct counter_signal *signal, size_t *synchronous_mode)
+				      struct counter_signal *signal,
+				      u8 *synchronous_mode)
 {
 	const struct quad8_iio *const priv = counter->priv;
 	const size_t channel_id = signal->id - 16;
@@ -957,17 +934,16 @@ static int quad8_synchronous_mode_get(struct counter_device *counter,
 }
 
 static int quad8_synchronous_mode_set(struct counter_device *counter,
-	struct counter_signal *signal, size_t synchronous_mode)
+				      struct counter_signal *signal,
+				      u8 synchronous_mode)
 {
 	struct quad8_iio *const priv = counter->priv;
 	const size_t channel_id = signal->id - 16;
 	const int base_offset = priv->base + 2 * channel_id + 1;
-	unsigned int idr_cfg = synchronous_mode;
+	unsigned int idr_cfg;
 
 	mutex_lock(&priv->lock);
 
-	idr_cfg |= priv->index_polarity[channel_id] << 1;
-
 	/* Index function must be non-synchronous in non-quadrature mode */
 	if (synchronous_mode && !priv->quadrature_mode[channel_id]) {
 		mutex_unlock(&priv->lock);
@@ -977,6 +953,7 @@ static int quad8_synchronous_mode_set(struct counter_device *counter,
 	priv->synchronous_mode[channel_id] = synchronous_mode;
 
 	/* Load Index Control configuration to Index Control Register */
+	idr_cfg = synchronous_mode | priv->index_polarity[channel_id] << 1;
 	outb(QUAD8_CTR_IDR | idr_cfg, base_offset);
 
 	mutex_unlock(&priv->lock);
@@ -984,22 +961,17 @@ static int quad8_synchronous_mode_set(struct counter_device *counter,
 	return 0;
 }
 
-static struct counter_signal_enum_ext quad8_syn_mode_enum = {
-	.items = quad8_synchronous_modes,
-	.num_items = ARRAY_SIZE(quad8_synchronous_modes),
-	.get = quad8_synchronous_mode_get,
-	.set = quad8_synchronous_mode_set
-};
-
-static ssize_t quad8_count_floor_read(struct counter_device *counter,
-	struct counter_count *count, void *private, char *buf)
+static int quad8_count_floor_read(struct counter_device *counter,
+				  struct counter_count *count, u64 *floor)
 {
 	/* Only a floor of 0 is supported */
-	return sprintf(buf, "0\n");
+	*floor = 0;
+
+	return 0;
 }
 
-static int quad8_count_mode_get(struct counter_device *counter,
-	struct counter_count *count, size_t *cnt_mode)
+static int quad8_count_mode_read(struct counter_device *counter,
+				 struct counter_count *count, u8 *cnt_mode)
 {
 	const struct quad8_iio *const priv = counter->priv;
 
@@ -1022,35 +994,36 @@ static int quad8_count_mode_get(struct counter_device *counter,
 	return 0;
 }
 
-static int quad8_count_mode_set(struct counter_device *counter,
-	struct counter_count *count, size_t cnt_mode)
+static int quad8_count_mode_write(struct counter_device *counter,
+				  struct counter_count *count, u8 cnt_mode)
 {
 	struct quad8_iio *const priv = counter->priv;
+	unsigned int count_mode;
 	unsigned int mode_cfg;
 	const int base_offset = priv->base + 2 * count->id + 1;
 
 	/* Map Generic Counter count mode to 104-QUAD-8 count mode */
 	switch (cnt_mode) {
 	case COUNTER_COUNT_MODE_NORMAL:
-		cnt_mode = 0;
+		count_mode = 0;
 		break;
 	case COUNTER_COUNT_MODE_RANGE_LIMIT:
-		cnt_mode = 1;
+		count_mode = 1;
 		break;
 	case COUNTER_COUNT_MODE_NON_RECYCLE:
-		cnt_mode = 2;
+		count_mode = 2;
 		break;
 	case COUNTER_COUNT_MODE_MODULO_N:
-		cnt_mode = 3;
+		count_mode = 3;
 		break;
 	}
 
 	mutex_lock(&priv->lock);
 
-	priv->count_mode[count->id] = cnt_mode;
+	priv->count_mode[count->id] = count_mode;
 
 	/* Set count mode configuration value */
-	mode_cfg = cnt_mode << 1;
+	mode_cfg = count_mode << 1;
 
 	/* Add quadrature mode configuration */
 	if (priv->quadrature_mode[count->id])
@@ -1064,60 +1037,39 @@ static int quad8_count_mode_set(struct counter_device *counter,
 	return 0;
 }
 
-static struct counter_count_enum_ext quad8_cnt_mode_enum = {
-	.items = counter_count_mode_str,
-	.num_items = ARRAY_SIZE(counter_count_mode_str),
-	.get = quad8_count_mode_get,
-	.set = quad8_count_mode_set
-};
-
-static ssize_t quad8_count_direction_read(struct counter_device *counter,
-	struct counter_count *count, void *priv, char *buf)
-{
-	enum counter_count_direction dir;
-
-	quad8_direction_get(counter, count, &dir);
-
-	return sprintf(buf, "%s\n", counter_count_direction_str[dir]);
-}
-
-static ssize_t quad8_count_enable_read(struct counter_device *counter,
-	struct counter_count *count, void *private, char *buf)
+static int quad8_count_enable_read(struct counter_device *counter,
+				   struct counter_count *count, u8 *enable)
 {
 	const struct quad8_iio *const priv = counter->priv;
 
-	return sprintf(buf, "%u\n", priv->ab_enable[count->id]);
+	*enable = priv->ab_enable[count->id];
+
+	return 0;
 }
 
-static ssize_t quad8_count_enable_write(struct counter_device *counter,
-	struct counter_count *count, void *private, const char *buf, size_t len)
+static int quad8_count_enable_write(struct counter_device *counter,
+				    struct counter_count *count, u8 enable)
 {
 	struct quad8_iio *const priv = counter->priv;
 	const int base_offset = priv->base + 2 * count->id;
-	int err;
-	bool ab_enable;
 	unsigned int ior_cfg;
 
-	err = kstrtobool(buf, &ab_enable);
-	if (err)
-		return err;
-
 	mutex_lock(&priv->lock);
 
-	priv->ab_enable[count->id] = ab_enable;
+	priv->ab_enable[count->id] = enable;
 
-	ior_cfg = ab_enable | priv->preset_enable[count->id] << 1;
+	ior_cfg = enable | priv->preset_enable[count->id] << 1;
 
 	/* Load I/O control configuration */
 	outb(QUAD8_CTR_IOR | ior_cfg, base_offset + 1);
 
 	mutex_unlock(&priv->lock);
 
-	return len;
+	return 0;
 }
 
 static int quad8_error_noise_get(struct counter_device *counter,
-	struct counter_count *count, size_t *noise_error)
+				 struct counter_count *count, u8 *noise_error)
 {
 	const struct quad8_iio *const priv = counter->priv;
 	const int base_offset = priv->base + 2 * count->id + 1;
@@ -1127,22 +1079,18 @@ static int quad8_error_noise_get(struct counter_device *counter,
 	return 0;
 }
 
-static struct counter_count_enum_ext quad8_error_noise_enum = {
-	.items = quad8_noise_error_states,
-	.num_items = ARRAY_SIZE(quad8_noise_error_states),
-	.get = quad8_error_noise_get
-};
-
-static ssize_t quad8_count_preset_read(struct counter_device *counter,
-	struct counter_count *count, void *private, char *buf)
+static int quad8_count_preset_read(struct counter_device *counter,
+				   struct counter_count *count, u64 *preset)
 {
 	const struct quad8_iio *const priv = counter->priv;
 
-	return sprintf(buf, "%u\n", priv->preset[count->id]);
+	*preset = priv->preset[count->id];
+
+	return 0;
 }
 
-static void quad8_preset_register_set(struct quad8_iio *quad8iio, int id,
-		unsigned int preset)
+static void quad8_preset_register_set(struct quad8_iio *const quad8iio,
+				      const int id, const u64 preset)
 {
 	const unsigned int base_offset = quad8iio->base + 2 * id;
 	int i;
@@ -1157,16 +1105,10 @@ static void quad8_preset_register_set(struct quad8_iio *quad8iio, int id,
 		outb(preset >> (8 * i), base_offset);
 }
 
-static ssize_t quad8_count_preset_write(struct counter_device *counter,
-	struct counter_count *count, void *private, const char *buf, size_t len)
+static int quad8_count_preset_write(struct counter_device *counter,
+				    struct counter_count *count, u64 preset)
 {
 	struct quad8_iio *const priv = counter->priv;
-	unsigned int preset;
-	int ret;
-
-	ret = kstrtouint(buf, 0, &preset);
-	if (ret)
-		return ret;
 
 	/* Only 24-bit values are supported */
 	if (preset > 0xFFFFFF)
@@ -1178,11 +1120,11 @@ static ssize_t quad8_count_preset_write(struct counter_device *counter,
 
 	mutex_unlock(&priv->lock);
 
-	return len;
+	return 0;
 }
 
-static ssize_t quad8_count_ceiling_read(struct counter_device *counter,
-	struct counter_count *count, void *private, char *buf)
+static int quad8_count_ceiling_read(struct counter_device *counter,
+				    struct counter_count *count, u64 *ceiling)
 {
 	struct quad8_iio *const priv = counter->priv;
 
@@ -1193,25 +1135,21 @@ static ssize_t quad8_count_ceiling_read(struct counter_device *counter,
 	case 1:
 	case 3:
 		mutex_unlock(&priv->lock);
-		return sprintf(buf, "%u\n", priv->preset[count->id]);
+		return quad8_count_preset_read(counter, count, ceiling);
 	}
 
 	mutex_unlock(&priv->lock);
 
 	/* By default 0x1FFFFFF (25 bits unsigned) is maximum count */
-	return sprintf(buf, "33554431\n");
+	*ceiling = 0x1FFFFFF;
+
+	return 0;
 }
 
-static ssize_t quad8_count_ceiling_write(struct counter_device *counter,
-	struct counter_count *count, void *private, const char *buf, size_t len)
+static int quad8_count_ceiling_write(struct counter_device *counter,
+				     struct counter_count *count, u64 ceiling)
 {
 	struct quad8_iio *const priv = counter->priv;
-	unsigned int ceiling;
-	int ret;
-
-	ret = kstrtouint(buf, 0, &ceiling);
-	if (ret)
-		return ret;
 
 	/* Only 24-bit values are supported */
 	if (ceiling > 0xFFFFFF)
@@ -1223,36 +1161,33 @@ static ssize_t quad8_count_ceiling_write(struct counter_device *counter,
 	switch (priv->count_mode[count->id]) {
 	case 1:
 	case 3:
-		quad8_preset_register_set(priv, count->id, ceiling);
-		break;
+		return quad8_count_preset_write(counter, count, ceiling);
 	}
 
 	mutex_unlock(&priv->lock);
 
-	return len;
+	return -EINVAL;
 }
 
-static ssize_t quad8_count_preset_enable_read(struct counter_device *counter,
-	struct counter_count *count, void *private, char *buf)
+static int quad8_count_preset_enable_read(struct counter_device *counter,
+					  struct counter_count *count,
+					  u8 *preset_enable)
 {
 	const struct quad8_iio *const priv = counter->priv;
 
-	return sprintf(buf, "%u\n", !priv->preset_enable[count->id]);
+	*preset_enable = !priv->preset_enable[count->id];
+
+	return 0;
 }
 
-static ssize_t quad8_count_preset_enable_write(struct counter_device *counter,
-	struct counter_count *count, void *private, const char *buf, size_t len)
+static int quad8_count_preset_enable_write(struct counter_device *counter,
+					   struct counter_count *count,
+					   u8 preset_enable)
 {
 	struct quad8_iio *const priv = counter->priv;
 	const int base_offset = priv->base + 2 * count->id + 1;
-	bool preset_enable;
-	int ret;
 	unsigned int ior_cfg;
 
-	ret = kstrtobool(buf, &preset_enable);
-	if (ret)
-		return ret;
-
 	/* Preset enable is active low in Input/Output Control register */
 	preset_enable = !preset_enable;
 
@@ -1260,25 +1195,24 @@ static ssize_t quad8_count_preset_enable_write(struct counter_device *counter,
 
 	priv->preset_enable[count->id] = preset_enable;
 
-	ior_cfg = priv->ab_enable[count->id] | (unsigned int)preset_enable << 1;
+	ior_cfg = priv->ab_enable[count->id] | preset_enable << 1;
 
 	/* Load I/O control configuration to Input / Output Control Register */
 	outb(QUAD8_CTR_IOR | ior_cfg, base_offset);
 
 	mutex_unlock(&priv->lock);
 
-	return len;
+	return 0;
 }
 
-static ssize_t quad8_signal_cable_fault_read(struct counter_device *counter,
-					     struct counter_signal *signal,
-					     void *private, char *buf)
+static int quad8_signal_cable_fault_read(struct counter_device *counter,
+					 struct counter_signal *signal,
+					 u8 *cable_fault)
 {
 	struct quad8_iio *const priv = counter->priv;
 	const size_t channel_id = signal->id / 2;
 	bool disabled;
 	unsigned int status;
-	unsigned int fault;
 
 	mutex_lock(&priv->lock);
 
@@ -1295,36 +1229,31 @@ static ssize_t quad8_signal_cable_fault_read(struct counter_device *counter,
 	mutex_unlock(&priv->lock);
 
 	/* Mask respective channel and invert logic */
-	fault = !(status & BIT(channel_id));
+	*cable_fault = !(status & BIT(channel_id));
 
-	return sprintf(buf, "%u\n", fault);
+	return 0;
 }
 
-static ssize_t quad8_signal_cable_fault_enable_read(
-	struct counter_device *counter, struct counter_signal *signal,
-	void *private, char *buf)
+static int quad8_signal_cable_fault_enable_read(struct counter_device *counter,
+						struct counter_signal *signal,
+						u8 *enable)
 {
 	const struct quad8_iio *const priv = counter->priv;
 	const size_t channel_id = signal->id / 2;
-	const unsigned int enb = !!(priv->cable_fault_enable & BIT(channel_id));
 
-	return sprintf(buf, "%u\n", enb);
+	*enable = !!(priv->cable_fault_enable & BIT(channel_id));
+
+	return 0;
 }
 
-static ssize_t quad8_signal_cable_fault_enable_write(
-	struct counter_device *counter, struct counter_signal *signal,
-	void *private, const char *buf, size_t len)
+static int quad8_signal_cable_fault_enable_write(struct counter_device *counter,
+						 struct counter_signal *signal,
+						 u8 enable)
 {
 	struct quad8_iio *const priv = counter->priv;
 	const size_t channel_id = signal->id / 2;
-	bool enable;
-	int ret;
 	unsigned int cable_fault_enable;
 
-	ret = kstrtobool(buf, &enable);
-	if (ret)
-		return ret;
-
 	mutex_lock(&priv->lock);
 
 	if (enable)
@@ -1339,31 +1268,27 @@ static ssize_t quad8_signal_cable_fault_enable_write(
 
 	mutex_unlock(&priv->lock);
 
-	return len;
+	return 0;
 }
 
-static ssize_t quad8_signal_fck_prescaler_read(struct counter_device *counter,
-	struct counter_signal *signal, void *private, char *buf)
+static int quad8_signal_fck_prescaler_read(struct counter_device *counter,
+					   struct counter_signal *signal,
+					   u8 *prescaler)
 {
 	const struct quad8_iio *const priv = counter->priv;
-	const size_t channel_id = signal->id / 2;
 
-	return sprintf(buf, "%u\n", priv->fck_prescaler[channel_id]);
+	*prescaler = priv->fck_prescaler[signal->id / 2];
+
+	return 0;
 }
 
-static ssize_t quad8_signal_fck_prescaler_write(struct counter_device *counter,
-	struct counter_signal *signal, void *private, const char *buf,
-	size_t len)
+static int quad8_signal_fck_prescaler_write(struct counter_device *counter,
+					    struct counter_signal *signal,
+					    u8 prescaler)
 {
 	struct quad8_iio *const priv = counter->priv;
 	const size_t channel_id = signal->id / 2;
 	const int base_offset = priv->base + 2 * channel_id;
-	u8 prescaler;
-	int ret;
-
-	ret = kstrtou8(buf, 0, &prescaler);
-	if (ret)
-		return ret;
 
 	mutex_lock(&priv->lock);
 
@@ -1379,31 +1304,30 @@ static ssize_t quad8_signal_fck_prescaler_write(struct counter_device *counter,
 
 	mutex_unlock(&priv->lock);
 
-	return len;
+	return 0;
 }
 
-static const struct counter_signal_ext quad8_signal_ext[] = {
-	{
-		.name = "cable_fault",
-		.read = quad8_signal_cable_fault_read
-	},
-	{
-		.name = "cable_fault_enable",
-		.read = quad8_signal_cable_fault_enable_read,
-		.write = quad8_signal_cable_fault_enable_write
-	},
-	{
-		.name = "filter_clock_prescaler",
-		.read = quad8_signal_fck_prescaler_read,
-		.write = quad8_signal_fck_prescaler_write
-	}
+static struct counter_data quad8_signal_ext[] = {
+	COUNTER_DATA_SIGNAL_BOOL("cable_fault", quad8_signal_cable_fault_read,
+				 NULL),
+	COUNTER_DATA_SIGNAL_BOOL("cable_fault_enable",
+				 quad8_signal_cable_fault_enable_read,
+				 quad8_signal_cable_fault_enable_write),
+	COUNTER_DATA_SIGNAL_U8("filter_clock_prescaler",
+			       quad8_signal_fck_prescaler_read,
+			       quad8_signal_fck_prescaler_write)
 };
 
-static const struct counter_signal_ext quad8_index_ext[] = {
-	COUNTER_SIGNAL_ENUM("index_polarity", &quad8_index_pol_enum),
-	COUNTER_SIGNAL_ENUM_AVAILABLE("index_polarity",	&quad8_index_pol_enum),
-	COUNTER_SIGNAL_ENUM("synchronous_mode", &quad8_syn_mode_enum),
-	COUNTER_SIGNAL_ENUM_AVAILABLE("synchronous_mode", &quad8_syn_mode_enum)
+static DEFINE_COUNTER_ENUM(quad8_index_pol_enum, quad8_index_polarity_modes);
+static DEFINE_COUNTER_ENUM(quad8_synch_mode_enum, quad8_synchronous_modes);
+
+static struct counter_data quad8_index_ext[] = {
+	COUNTER_DATA_SIGNAL_ENUM("index_polarity", quad8_index_polarity_get,
+				 quad8_index_polarity_set,
+				 quad8_index_pol_enum),
+	COUNTER_DATA_SIGNAL_ENUM("synchronous_mode", quad8_synchronous_mode_get,
+				 quad8_synchronous_mode_set,
+				 quad8_synch_mode_enum),
 };
 
 #define QUAD8_QUAD_SIGNAL(_id, _name) {		\
@@ -1472,39 +1396,30 @@ static struct counter_synapse quad8_count_synapses[][3] = {
 	QUAD8_COUNT_SYNAPSES(6), QUAD8_COUNT_SYNAPSES(7)
 };
 
-static const struct counter_count_ext quad8_count_ext[] = {
-	{
-		.name = "ceiling",
-		.read = quad8_count_ceiling_read,
-		.write = quad8_count_ceiling_write
-	},
-	{
-		.name = "floor",
-		.read = quad8_count_floor_read
-	},
-	COUNTER_COUNT_ENUM("count_mode", &quad8_cnt_mode_enum),
-	COUNTER_COUNT_ENUM_AVAILABLE("count_mode", &quad8_cnt_mode_enum),
-	{
-		.name = "direction",
-		.read = quad8_count_direction_read
-	},
-	{
-		.name = "enable",
-		.read = quad8_count_enable_read,
-		.write = quad8_count_enable_write
-	},
-	COUNTER_COUNT_ENUM("error_noise", &quad8_error_noise_enum),
-	COUNTER_COUNT_ENUM_AVAILABLE("error_noise", &quad8_error_noise_enum),
-	{
-		.name = "preset",
-		.read = quad8_count_preset_read,
-		.write = quad8_count_preset_write
-	},
-	{
-		.name = "preset_enable",
-		.read = quad8_count_preset_enable_read,
-		.write = quad8_count_preset_enable_write
-	}
+static const u8 quad8_cnt_modes[] = {
+	COUNTER_COUNT_MODE_NORMAL,
+	COUNTER_COUNT_MODE_RANGE_LIMIT,
+	COUNTER_COUNT_MODE_NON_RECYCLE,
+	COUNTER_COUNT_MODE_MODULO_N,
+};
+
+static DEFINE_COUNTER_AVAILABLE(quad8_count_mode_available, quad8_cnt_modes);
+
+static DEFINE_COUNTER_ENUM(quad8_error_noise_enum, quad8_noise_error_states);
+
+static struct counter_data quad8_count_ext[] = {
+	COUNTER_DATA_CEILING(quad8_count_ceiling_read,
+			     quad8_count_ceiling_write),
+	COUNTER_DATA_FLOOR(quad8_count_floor_read, NULL),
+	COUNTER_DATA_COUNT_MODE(quad8_count_mode_read, quad8_count_mode_write,
+				quad8_count_mode_available),
+	COUNTER_DATA_DIRECTION(quad8_direction_read),
+	COUNTER_DATA_ENABLE(quad8_count_enable_read, quad8_count_enable_write),
+	COUNTER_DATA_COUNT_ENUM("error_noise", quad8_error_noise_get, NULL,
+				quad8_error_noise_enum),
+	COUNTER_DATA_PRESET(quad8_count_preset_read, quad8_count_preset_write),
+	COUNTER_DATA_PRESET_ENABLE(quad8_count_preset_enable_read,
+				   quad8_count_preset_enable_write),
 };
 
 #define QUAD8_COUNT(_id, _cntname) {					\
@@ -1559,7 +1474,12 @@ static int quad8_probe(struct device *dev, unsigned int id)
 	quad8iio = iio_priv(indio_dev);
 	quad8iio->counter.name = dev_name(dev);
 	quad8iio->counter.parent = dev;
-	quad8iio->counter.ops = &quad8_ops;
+	quad8iio->counter.signal_read = quad8_signal_read;
+	quad8iio->counter.count_read = quad8_count_read;
+	quad8iio->counter.count_write = quad8_count_write;
+	quad8iio->counter.function_read = quad8_function_read;
+	quad8iio->counter.function_write = quad8_function_write;
+	quad8iio->counter.action_read = quad8_action_read;
 	quad8iio->counter.counts = quad8_counts;
 	quad8iio->counter.num_counts = ARRAY_SIZE(quad8_counts);
 	quad8iio->counter.signals = quad8_signals;
diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index 0a393f71e481..cbe1d06af6a9 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_COUNTER) += counter.o
+counter-y := counter-core.o counter-sysfs.o
 
 obj-$(CONFIG_104_QUAD_8)	+= 104-quad-8.o
 obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
new file mode 100644
index 000000000000..499664809c75
--- /dev/null
+++ b/drivers/counter/counter-core.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic Counter interface
+ * Copyright (C) 2020 William Breathitt Gray
+ */
+#include <linux/counter.h>
+#include <linux/device.h>
+#include <linux/export.h>
+#include <linux/gfp.h>
+#include <linux/idr.h>
+#include <linux/init.h>
+#include <linux/module.h>
+
+#include "counter-sysfs.h"
+
+/* Provides a unique ID for each counter device */
+static DEFINE_IDA(counter_ida);
+
+static void counter_device_release(struct device *dev)
+{
+	struct counter_device *const counter = dev_get_drvdata(dev);
+
+	counter_sysfs_free(counter);
+	ida_simple_remove(&counter_ida, counter->id);
+}
+
+static struct device_type counter_device_type = {
+	.name = "counter_device",
+	.release = counter_device_release
+};
+
+static struct bus_type counter_bus_type = {
+	.name = "counter"
+};
+
+/**
+ * counter_register - register Counter to the system
+ * @counter:	pointer to Counter to register
+ *
+ * This function registers a Counter to the system. A sysfs "counter" directory
+ * will be created and populated with sysfs attributes correlating with the
+ * Counter Signals, Synapses, and Counts respectively.
+ */
+int counter_register(struct counter_device *const counter)
+{
+	struct device *const dev = &counter->dev;
+	int err;
+
+	/* Acquire unique ID */
+	counter->id = ida_simple_get(&counter_ida, 0, 0, GFP_KERNEL);
+	if (counter->id < 0)
+		return counter->id;
+
+	/* Configure device structure for Counter */
+	dev->type = &counter_device_type;
+	dev->bus = &counter_bus_type;
+	if (counter->parent) {
+		dev->parent = counter->parent;
+		dev->of_node = counter->parent->of_node;
+	}
+	dev_set_name(dev, "counter%d", counter->id);
+	device_initialize(dev);
+	dev_set_drvdata(dev, counter);
+
+	/* Add Counter sysfs attributes */
+	err = counter_sysfs_add(counter);
+	if (err)
+		goto err_free_id;
+
+	/* Add device to system */
+	err = device_add(dev);
+	if (err)
+		goto err_free_sysfs;
+
+	return 0;
+
+err_free_sysfs:
+	counter_sysfs_free(counter);
+err_free_id:
+	ida_simple_remove(&counter_ida, counter->id);
+	return err;
+}
+EXPORT_SYMBOL_GPL(counter_register);
+
+/**
+ * counter_unregister - unregister Counter from the system
+ * @counter:	pointer to Counter to unregister
+ *
+ * The Counter is unregistered from the system; all allocated memory is freed.
+ */
+void counter_unregister(struct counter_device *const counter)
+{
+	if (counter) {
+		device_del(&counter->dev);
+		counter_sysfs_free(counter);
+	}
+}
+EXPORT_SYMBOL_GPL(counter_unregister);
+
+static void devm_counter_unreg(struct device *dev, void *res)
+{
+	counter_unregister(*(struct counter_device **)res);
+}
+
+/**
+ * devm_counter_register - Resource-managed counter_register
+ * @dev:	device to allocate counter_device for
+ * @counter:	pointer to Counter to register
+ *
+ * Managed counter_register. The Counter registered with this function is
+ * automatically unregistered on driver detach. This function calls
+ * counter_register internally. Refer to that function for more information.
+ *
+ * If an Counter registered with this function needs to be unregistered
+ * separately, devm_counter_unregister must be used.
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int devm_counter_register(struct device *dev,
+			  struct counter_device *const counter)
+{
+	struct counter_device **ptr;
+	int ret;
+
+	ptr = devres_alloc(devm_counter_unreg, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+
+	ret = counter_register(counter);
+	if (!ret) {
+		*ptr = counter;
+		devres_add(dev, ptr);
+	} else {
+		devres_free(ptr);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_counter_register);
+
+static int __init counter_init(void)
+{
+	return bus_register(&counter_bus_type);
+}
+
+static void __exit counter_exit(void)
+{
+	bus_unregister(&counter_bus_type);
+}
+
+subsys_initcall(counter_init);
+module_exit(counter_exit);
+
+MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
+MODULE_DESCRIPTION("Generic Counter interface");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
new file mode 100644
index 000000000000..dd9cd9ce8dd9
--- /dev/null
+++ b/drivers/counter/counter-sysfs.c
@@ -0,0 +1,849 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Generic Counter sysfs interface
+ * Copyright (C) 2020 William Breathitt Gray
+ */
+#include <linux/counter.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gfp.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+
+#include "counter-sysfs.h"
+
+struct counter_attribute {
+	struct device_attribute dev_attr;
+	struct list_head l;
+
+	struct counter_data data;
+	__u8 type;
+	void *owner;
+};
+
+#define to_counter_attribute(_dev_attr) \
+	container_of(_dev_attr, struct counter_attribute, dev_attr)
+
+static const char *const counter_count_function_str[] = {
+	[COUNTER_COUNT_FUNCTION_INCREASE] = "increase",
+	[COUNTER_COUNT_FUNCTION_DECREASE] = "decrease",
+	[COUNTER_COUNT_FUNCTION_PULSE_DIRECTION] = "pulse-direction",
+	[COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A] = "quadrature x1 a",
+	[COUNTER_COUNT_FUNCTION_QUADRATURE_X1_B] = "quadrature x1 b",
+	[COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A] = "quadrature x2 a",
+	[COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B] = "quadrature x2 b",
+	[COUNTER_COUNT_FUNCTION_QUADRATURE_X4] = "quadrature x4"
+};
+
+static const char *const counter_signal_value_str[] = {
+	[COUNTER_SIGNAL_LOW] = "low",
+	[COUNTER_SIGNAL_HIGH] = "high"
+};
+
+static const char *const counter_synapse_action_str[] = {
+	[COUNTER_SYNAPSE_ACTION_NONE] = "none",
+	[COUNTER_SYNAPSE_ACTION_RISING_EDGE] = "rising edge",
+	[COUNTER_SYNAPSE_ACTION_FALLING_EDGE] = "falling edge",
+	[COUNTER_SYNAPSE_ACTION_BOTH_EDGES] = "both edges"
+};
+
+static const char *const counter_count_direction_str[] = {
+	[COUNTER_COUNT_DIRECTION_FORWARD] = "forward",
+	[COUNTER_COUNT_DIRECTION_BACKWARD] = "backward"
+};
+
+static const char *const counter_count_mode_str[] = {
+	[COUNTER_COUNT_MODE_NORMAL] = "normal",
+	[COUNTER_COUNT_MODE_RANGE_LIMIT] = "range limit",
+	[COUNTER_COUNT_MODE_NON_RECYCLE] = "non-recycle",
+	[COUNTER_COUNT_MODE_MODULO_N] = "modulo-n"
+};
+
+static ssize_t counter_data_u8_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	const struct counter_attribute *const a = to_counter_attribute(attr);
+	struct counter_device *const counter = dev_get_drvdata(dev);
+	const struct counter_available *const avail = a->data.priv;
+	int err;
+	u8 data;
+
+	switch (a->type) {
+	case COUNTER_OWNER_TYPE_DEVICE:
+		err = a->data.device_u8_read(counter, &data);
+		break;
+	case COUNTER_OWNER_TYPE_SIGNAL:
+		err = a->data.signal_u8_read(counter, a->owner, &data);
+		break;
+	case COUNTER_OWNER_TYPE_COUNT:
+		if (a->data.type == COUNTER_DATA_TYPE_SYNAPSE_ACTION)
+			err = a->data.action_read(counter, a->owner,
+						  a->data.priv, &data);
+		else
+			err = a->data.count_u8_read(counter, a->owner, &data);
+		break;
+	}
+	if (err)
+		return err;
+
+	switch (a->data.type) {
+	case COUNTER_DATA_TYPE_BOOL:
+		return sprintf(buf, "%u\n", (unsigned int)!!data);
+	case COUNTER_DATA_TYPE_COUNT_FUNCTION:
+		return sprintf(buf, "%s\n", counter_count_function_str[data]);
+	case COUNTER_DATA_TYPE_SIGNAL:
+		return sprintf(buf, "%s\n", counter_signal_value_str[data]);
+	case COUNTER_DATA_TYPE_SYNAPSE_ACTION:
+		return sprintf(buf, "%s\n", counter_synapse_action_str[data]);
+	case COUNTER_DATA_TYPE_ENUM:
+		return sprintf(buf, "%s\n", avail->enums[data]);
+	case COUNTER_DATA_TYPE_COUNT_DIRECTION:
+		return sprintf(buf, "%s\n", counter_count_direction_str[data]);
+	case COUNTER_DATA_TYPE_COUNT_MODE:
+		return sprintf(buf, "%s\n", counter_count_mode_str[data]);
+	default:
+		break;
+	}
+
+	return sprintf(buf, "%u\n", (unsigned int)data);
+}
+
+static int find_in_string_array(u8 *const item, const u8 *const items,
+				const size_t num_items, const char *const buf,
+				const char *const string_array[])
+{
+	size_t index;
+
+	for (index = 0; index < num_items; index++) {
+		*item = items[index];
+		if (sysfs_streq(buf, string_array[*item]))
+			return 0;
+	}
+
+	return -EINVAL;
+}
+
+static ssize_t counter_data_u8_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
+{
+	const struct counter_attribute *const a = to_counter_attribute(attr);
+	struct counter_device *const counter = dev_get_drvdata(dev);
+	struct counter_count *const count = a->owner;
+	struct counter_synapse *const synapse = a->data.priv;
+	const struct counter_available *const avail = a->data.priv;
+	int err;
+	bool bool_data;
+	u8 data;
+
+	switch (a->data.type) {
+	case COUNTER_DATA_TYPE_BOOL:
+		err = kstrtobool(buf, &bool_data);
+		data = bool_data;
+		break;
+	case COUNTER_DATA_TYPE_COUNT_FUNCTION:
+		err = find_in_string_array(&data, count->functions_list,
+					   count->num_functions, buf,
+					   counter_count_function_str);
+		break;
+	case COUNTER_DATA_TYPE_SYNAPSE_ACTION:
+		err = find_in_string_array(&data, synapse->actions_list,
+					   synapse->num_actions, buf,
+					   counter_synapse_action_str);
+		break;
+	case COUNTER_DATA_TYPE_ENUM:
+		err = __sysfs_match_string(avail->enums, avail->num_items, buf);
+		data = err;
+		break;
+	case COUNTER_DATA_TYPE_COUNT_MODE:
+		err = find_in_string_array(&data, avail->items,
+					   avail->num_items, buf,
+					   counter_count_mode_str);
+		break;
+	default:
+		err = kstrtou8(buf, 0, &data);
+		break;
+	}
+	if (err)
+		return err;
+
+	switch (a->type) {
+	case COUNTER_OWNER_TYPE_DEVICE:
+		err = a->data.device_u8_write(counter, data);
+		break;
+	case COUNTER_OWNER_TYPE_SIGNAL:
+		err = a->data.signal_u8_write(counter, a->owner, data);
+		break;
+	case COUNTER_OWNER_TYPE_COUNT:
+		if (a->data.type == COUNTER_DATA_TYPE_SYNAPSE_ACTION)
+			err = a->data.action_write(counter, count, synapse,
+						   data);
+		else
+			err = a->data.count_u8_write(counter, count, data);
+		break;
+	}
+	if (err)
+		return err;
+
+	return len;
+}
+
+static ssize_t counter_data_u64_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	const struct counter_attribute *const a = to_counter_attribute(attr);
+	struct counter_device *const counter = dev_get_drvdata(dev);
+	int err;
+	u64 data;
+
+	switch (a->type) {
+	case COUNTER_OWNER_TYPE_DEVICE:
+		err = a->data.device_u64_read(counter, &data);
+		break;
+	case COUNTER_OWNER_TYPE_SIGNAL:
+		err = a->data.signal_u64_read(counter, a->owner, &data);
+		break;
+	case COUNTER_OWNER_TYPE_COUNT:
+		err = a->data.count_u64_read(counter, a->owner, &data);
+		break;
+	}
+	if (err)
+		return err;
+
+	return sprintf(buf, "%llu\n", (unsigned long long)data);
+}
+
+static ssize_t counter_data_u64_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t len)
+{
+	const struct counter_attribute *const a = to_counter_attribute(attr);
+	struct counter_device *const counter = dev_get_drvdata(dev);
+	int err;
+	u64 data;
+
+	err = kstrtou64(buf, 0, &data);
+	if (err)
+		return err;
+
+	switch (a->type) {
+	case COUNTER_OWNER_TYPE_DEVICE:
+		err = a->data.device_u64_write(counter, data);
+		break;
+	case COUNTER_OWNER_TYPE_SIGNAL:
+		err = a->data.signal_u64_write(counter, a->owner, data);
+		break;
+	case COUNTER_OWNER_TYPE_COUNT:
+		err = a->data.count_u64_write(counter, a->owner, data);
+		break;
+	}
+	if (err)
+		return err;
+
+	return len;
+}
+
+static ssize_t items_available_show(const u8 *const items,
+				    const size_t num_items,
+				    const char *const string_array[], char *buf)
+{
+	size_t len = 0;
+	size_t index;
+
+	for (index = 0; index < num_items; index++)
+		len += sprintf(buf + len, "%s\n", string_array[items[index]]);
+
+	return len;
+}
+
+static ssize_t enums_available_show(const struct counter_available *const avail,
+				    char *buf)
+{
+	size_t len = 0;
+	size_t index;
+
+	for (index = 0; index < avail->num_items; index++)
+		len += sprintf(buf + len, "%s\n", avail->enums[index]);
+
+	return len;
+}
+
+static ssize_t counter_data_available_show(struct device *dev,
+					   struct device_attribute *attr,
+					   char *buf)
+{
+	const struct counter_attribute *const a = to_counter_attribute(attr);
+	const struct counter_count *const count = a->owner;
+	const struct counter_synapse *const synapse = a->data.priv;
+	const struct counter_available *const avail = a->data.priv;
+
+	switch (a->data.type) {
+	case COUNTER_DATA_TYPE_COUNT_FUNCTION:
+		return items_available_show(count->functions_list,
+					    count->num_functions,
+					    counter_count_function_str, buf);
+	case COUNTER_DATA_TYPE_SYNAPSE_ACTION:
+		return items_available_show(synapse->actions_list,
+					    synapse->num_actions,
+					    counter_synapse_action_str, buf);
+	case COUNTER_DATA_TYPE_ENUM:
+		return enums_available_show(avail, buf);
+	case COUNTER_DATA_TYPE_COUNT_MODE:
+		return items_available_show(avail->items, avail->num_items,
+					    counter_count_mode_str, buf);
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+struct counter_dynamic_name {
+	struct list_head l;
+	const char *name;
+};
+
+static int counter_available_attribute_create(
+	struct counter_attribute_group *const group,
+	struct list_head *const names, const struct counter_data *const data,
+	void *const owner)
+{
+	struct counter_attribute *counter_attr;
+	struct device_attribute *dev_attr;
+	struct counter_dynamic_name *dyn_name;
+
+	/* Allocate Counter attribute */
+	counter_attr = kzalloc(sizeof(*counter_attr), GFP_KERNEL);
+	if (!counter_attr)
+		return -ENOMEM;
+	list_add(&counter_attr->l, &group->attr_list);
+	group->num_attr++;
+
+	/* Configure Counter attribute */
+	counter_attr->data = *data;
+	counter_attr->owner = owner;
+
+	/* Initialize sysfs attribute */
+	dev_attr = &counter_attr->dev_attr;
+	sysfs_attr_init(&dev_attr->attr);
+
+	/* Generate dynamic name list item */
+	dyn_name = kmalloc(sizeof(*dyn_name), GFP_KERNEL);
+	if (!dyn_name)
+		return -ENOMEM;
+	list_add(&dyn_name->l, names);
+
+	/* Generate available attribute name */
+	dyn_name->name = kasprintf(GFP_KERNEL, "%s_available", data->name);
+	if (!dyn_name->name)
+		return -ENOMEM;
+
+	/* Configure device attribute */
+	dev_attr->attr.name = dyn_name->name;
+	dev_attr->attr.mode = 0444;
+	dev_attr->show = counter_data_available_show;
+
+	return 0;
+}
+
+static int counter_attribute_create(struct counter_attribute_group *const group,
+				    struct list_head *const names,
+				    const struct counter_data *const data,
+				    const __u8 type, void *const owner)
+{
+	struct counter_attribute *counter_attr;
+	struct device_attribute *dev_attr;
+
+	/* Allocate Counter attribute */
+	counter_attr = kzalloc(sizeof(*counter_attr), GFP_KERNEL);
+	if (!counter_attr)
+		return -ENOMEM;
+	list_add(&counter_attr->l, &group->attr_list);
+	group->num_attr++;
+
+	/* Configure Counter attribute */
+	counter_attr->data = *data;
+	counter_attr->type = type;
+	counter_attr->owner = owner;
+
+	/* Configure device attribute */
+	dev_attr = &counter_attr->dev_attr;
+	sysfs_attr_init(&dev_attr->attr);
+	dev_attr->attr.name = data->name;
+	switch (data->type) {
+	case COUNTER_DATA_TYPE_U8:
+	case COUNTER_DATA_TYPE_BOOL:
+	case COUNTER_DATA_TYPE_SIGNAL:
+	case COUNTER_DATA_TYPE_COUNT_FUNCTION:
+	case COUNTER_DATA_TYPE_SYNAPSE_ACTION:
+	case COUNTER_DATA_TYPE_ENUM:
+	case COUNTER_DATA_TYPE_COUNT_DIRECTION:
+	case COUNTER_DATA_TYPE_COUNT_MODE:
+		if (data->device_u8_read) {
+			dev_attr->attr.mode |= 0444;
+			dev_attr->show = counter_data_u8_show;
+		}
+		if (data->device_u8_write) {
+			dev_attr->attr.mode |= 0200;
+			dev_attr->store = counter_data_u8_store;
+		}
+		break;
+	case COUNTER_DATA_TYPE_U64:
+		if (data->device_u64_read) {
+			dev_attr->attr.mode |= 0444;
+			dev_attr->show = counter_data_u64_show;
+		}
+		if (data->device_u64_write) {
+			dev_attr->attr.mode |= 0200;
+			dev_attr->store = counter_data_u64_store;
+		}
+		break;
+	}
+
+	switch (data->type) {
+	case COUNTER_DATA_TYPE_COUNT_FUNCTION:
+	case COUNTER_DATA_TYPE_SYNAPSE_ACTION:
+	case COUNTER_DATA_TYPE_ENUM:
+	case COUNTER_DATA_TYPE_COUNT_MODE:
+		return counter_available_attribute_create(group, names, data,
+							  owner);
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static ssize_t counter_data_name_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%s\n", to_counter_attribute(attr)->data.name);
+}
+
+static int counter_name_attr_create(struct counter_attribute_group *const group,
+				    const char *const name)
+{
+	struct counter_attribute *counter_attr;
+
+	/* Allocate Counter attribute */
+	counter_attr = kzalloc(sizeof(*counter_attr), GFP_KERNEL);
+	if (!counter_attr)
+		return -ENOMEM;
+	list_add(&counter_attr->l, &group->attr_list);
+	group->num_attr++;
+
+	/* Configure Counter attribute */
+	counter_attr->data.name = name;
+
+	/* Configure device attribute */
+	sysfs_attr_init(&counter_attr->dev_attr.attr);
+	counter_attr->dev_attr.attr.name = "name";
+	counter_attr->dev_attr.attr.mode = 0444;
+	counter_attr->dev_attr.show = counter_data_name_show;
+
+	return 0;
+}
+static struct counter_data counter_signal_data = {
+	.type = COUNTER_DATA_TYPE_SIGNAL,
+	.name = "signal",
+};
+
+static int counter_signal_attributes_create(
+	struct counter_attribute_group *const group,
+	struct counter_device *const counter,
+	struct counter_signal *const signal)
+{
+	struct list_head *const names = &counter->dynamic_names_list;
+	const __u8 type = COUNTER_OWNER_TYPE_SIGNAL;
+	int err;
+	struct counter_data data;
+	size_t i;
+	const struct counter_data *ext;
+
+	/* Create main Signal attribute */
+	data = counter_signal_data;
+	data.signal_u8_read = counter->signal_read;
+	err = counter_attribute_create(group, names, &data, type, signal);
+	if (err)
+		return err;
+
+	/* Create Signal name attribute */
+	err = counter_name_attr_create(group, signal->name);
+	if (err)
+		return err;
+
+	/* Create an attribute for each extension */
+	for (i = 0; i < signal->num_ext; i++) {
+		ext = signal->ext + i;
+		err = counter_attribute_create(group, names, ext, type, signal);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int counter_signals_register(
+	struct counter_attribute_group *const groups_list,
+	struct counter_device *const counter)
+{
+	size_t i;
+	const char *name;
+	int err;
+
+	/* Register each Signal */
+	for (i = 0; i < counter->num_signals; i++) {
+		/* Generate Signal attribute directory name */
+		name = kasprintf(GFP_KERNEL, "signal%zu", i);
+		if (!name)
+			return -ENOMEM;
+		groups_list[i].attr_group.name = name;
+
+		/* Create all attributes associated with Signal */
+		err = counter_signal_attributes_create(groups_list + i, counter,
+						       counter->signals + i);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int counter_synapses_register(
+	struct counter_attribute_group *const group,
+	struct counter_device *const counter, struct counter_count *const count)
+{
+	struct list_head *const names = &counter->dynamic_names_list;
+	const __u8 type = COUNTER_OWNER_TYPE_COUNT;
+	size_t i;
+	struct counter_synapse *synapse;
+	struct counter_dynamic_name *dyn_name;
+	size_t id;
+	struct counter_data data;
+	int err;
+
+	/* Register each Synapse */
+	for (i = 0; i < count->num_synapses; i++) {
+		synapse = count->synapses + i;
+
+		/* Generate dynamic name list item */
+		dyn_name = kmalloc(sizeof(*dyn_name), GFP_KERNEL);
+		if (!dyn_name)
+			return -ENOMEM;
+		list_add(&dyn_name->l, names);
+
+		/* Generate Synapse action name */
+		id = synapse->signal - counter->signals;
+		dyn_name->name = kasprintf(GFP_KERNEL, "signal%zu_action", id);
+		if (!dyn_name->name)
+			return -ENOMEM;
+
+		/* Create action attribute */
+		data.type = COUNTER_DATA_TYPE_SYNAPSE_ACTION;
+		data.name = dyn_name->name;
+		data.action_read = counter->action_read;
+		data.action_write = counter->action_write;
+		data.priv = synapse;
+		err = counter_attribute_create(group, names, &data, type,
+					       count);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static struct counter_data counter_count_data =
+	COUNTER_DATA_COUNT_U64("count", NULL, NULL);
+
+static struct counter_data counter_count_function_data = {
+	.type = COUNTER_DATA_TYPE_COUNT_FUNCTION,
+	.name = "function",
+};
+
+static int counter_count_attributes_create(
+	struct counter_attribute_group *const group,
+	struct counter_device *const counter,
+	struct counter_count *const count)
+{
+	struct list_head *const names = &counter->dynamic_names_list;
+	const __u8 type = COUNTER_OWNER_TYPE_COUNT;
+	int err;
+	struct counter_data data;
+	size_t i;
+	const struct counter_data *ext;
+
+	/* Create main Count attribute */
+	data = counter_count_data;
+	data.count_u64_read = counter->count_read;
+	data.count_u64_write = counter->count_write;
+	err = counter_attribute_create(group, names, &data, type, count);
+	if (err)
+		return err;
+
+	/* Create Count name attribute */
+	err = counter_name_attr_create(group, count->name);
+	if (err)
+		return err;
+
+	/* Create Count function attribute */
+	data = counter_count_function_data;
+	data.count_u8_read = counter->function_read;
+	data.count_u8_write = counter->function_write;
+	err = counter_attribute_create(group, names, &data, type, count);
+	if (err)
+		return err;
+
+	/* Create an attribute for each extension */
+	for (i = 0; i < count->num_ext; i++) {
+		ext = count->ext + i;
+		err = counter_attribute_create(group, names, ext, type, count);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int counter_counts_register(
+	struct counter_attribute_group *const groups_list,
+	struct counter_device *const counter)
+{
+	size_t i;
+	struct counter_count *count;
+	const char *name;
+	int err;
+
+	/* Register each Count */
+	for (i = 0; i < counter->num_counts; i++) {
+		count = counter->counts + i;
+
+		/* Generate Count attribute directory name */
+		name = kasprintf(GFP_KERNEL, "count%zu", i);
+		if (!name)
+			return -ENOMEM;
+		groups_list[i].attr_group.name = name;
+
+		/* Register the Synapses associated with each Count */
+		err = counter_synapses_register(groups_list + i, counter,
+						count);
+		if (err)
+			return err;
+
+		/* Create all attributes associated with Count */
+		err = counter_count_attributes_create(groups_list + i, counter,
+						      count);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+static int counter_num_signals_read(struct counter_device *counter, u8 *val)
+{
+	*val = counter->num_signals;
+	return 0;
+}
+
+static int counter_num_counts_read(struct counter_device *counter, u8 *val)
+{
+	*val = counter->num_counts;
+	return 0;
+}
+
+static void counter_groups_list_free(struct counter_device *const counter)
+{
+	struct counter_attribute_group *group;
+	struct counter_attribute *p, *n;
+
+	/* Loop through all attribute groups (signals, counts, device, etc.) */
+	while (counter->num_groups--) {
+		group = counter->groups_list + counter->num_groups;
+
+		/* Free all attribute group and associated attributes memory */
+		kfree(group->attr_group.name);
+		kfree(group->attr_group.attrs);
+
+		/* Free attribute list */
+		list_for_each_entry_safe(p, n, &group->attr_list, l)
+			kfree(p);
+	}
+
+	kfree(counter->groups_list);
+}
+
+static struct counter_data counter_num_signals_data =
+	COUNTER_DATA_DEVICE_U8("num_signals", counter_num_signals_read, NULL);
+
+static struct counter_data counter_num_counts_data =
+	COUNTER_DATA_DEVICE_U8("num_counts", counter_num_counts_read, NULL);
+
+static int counter_device_register(struct counter_attribute_group *group,
+				   struct counter_device *const counter)
+{
+	struct list_head *const names = &counter->dynamic_names_list;
+	const __u8 type = COUNTER_OWNER_TYPE_DEVICE;
+	struct counter_data data;
+	int err;
+	size_t i;
+	const struct counter_data *ext;
+
+	/* Register Signals */
+	err = counter_signals_register(group, counter);
+	if (err)
+		goto err_free_groups_list;
+	group += counter->num_signals;
+
+	/* Register Counts and respective Synapses */
+	err = counter_counts_register(group, counter);
+	if (err)
+		goto err_free_groups_list;
+	group += counter->num_counts;
+
+	/* Create name attribute */
+	err = counter_name_attr_create(group, counter->name);
+	if (err)
+		goto err_free_groups_list;
+
+	/* Create num_signals attribute */
+	data = counter_num_signals_data;
+	err = counter_attribute_create(group, names, &data, type, NULL);
+	if (err)
+		goto err_free_groups_list;
+
+	/* Create num_counts attribute */
+	data = counter_num_counts_data;
+	err = counter_attribute_create(group, names, &data, type, NULL);
+	if (err)
+		goto err_free_groups_list;
+
+	/* Create an attribute for each extension */
+	for (i = 0; i < counter->num_ext; i++) {
+		ext = counter->ext + i;
+		err = counter_attribute_create(group, names, ext, type, NULL);
+		if (err)
+			goto err_free_groups_list;
+	}
+
+	return 0;
+
+err_free_groups_list:
+	counter_groups_list_free(counter);
+	return err;
+}
+
+static int counter_groups_list_prepare(struct counter_device *const counter)
+{
+	const size_t num_grps = counter->num_signals + counter->num_counts + 1;
+	struct counter_attribute_group *groups_list;
+	size_t i;
+
+	/* Allocate space for attribute groups (signals, counts, and ext) */
+	groups_list = kcalloc(num_grps, sizeof(*groups_list), GFP_KERNEL);
+	if (!groups_list)
+		return -ENOMEM;
+
+	/* Store groups_list in counter structure */
+	counter->groups_list = groups_list;
+	counter->num_groups = num_grps;
+
+	/* Initialize attribute lists */
+	for (i = 0; i < num_grps; i++)
+		INIT_LIST_HEAD(&groups_list[i].attr_list);
+
+	/* Register Counter device attributes */
+	return counter_device_register(groups_list, counter);
+}
+
+static int counter_groups_prepare(struct counter_device *const counter)
+{
+	size_t i, j;
+	struct counter_attribute_group *group;
+	struct attribute **attrs;
+	int err;
+	struct counter_attribute *p;
+
+	/* Allocate attribute groups for association with device */
+	counter->groups = kcalloc(counter->num_groups + 1,
+				  sizeof(*counter->groups), GFP_KERNEL);
+	if (!counter->groups)
+		return -ENOMEM;
+
+	/* Prepare each group of attributes for association */
+	for (i = 0; i < counter->num_groups; i++) {
+		group = counter->groups_list + i;
+
+		/* Allocate space for attribute pointers */
+		attrs = kcalloc(group->num_attr + 1, sizeof(*attrs),
+				GFP_KERNEL);
+		if (!attrs) {
+			err = -ENOMEM;
+			goto err_free_groups;
+		}
+		group->attr_group.attrs = attrs;
+
+		/* Add attribute pointers to attribute group */
+		j = 0;
+		list_for_each_entry(p, &group->attr_list, l)
+			attrs[j++] = &p->dev_attr.attr;
+
+		/* Group attributes in attribute group */
+		counter->groups[i] = &group->attr_group;
+	}
+	/* Associate attributes with device */
+	counter->dev.groups = counter->groups;
+
+	return 0;
+
+err_free_groups:
+	kfree(counter->groups);
+	return err;
+}
+
+static void counter_dynamic_names_free(struct list_head *const names)
+{
+	struct counter_dynamic_name *p, *n;
+
+	list_for_each_entry_safe(p, n, names, l) {
+		kfree(p->name);
+		kfree(p);
+	}
+}
+
+int counter_sysfs_add(struct counter_device *const counter)
+{
+	int err;
+
+	/* Initialize Synapse names list */
+	INIT_LIST_HEAD(&counter->dynamic_names_list);
+
+	/* Prepare device attributes */
+	err = counter_groups_list_prepare(counter);
+	if (err)
+		goto err_free_names;
+
+	/* Organize device attributes to groups and match to device */
+	err = counter_groups_prepare(counter);
+	if (err)
+		goto err_free_groups_list;
+
+	return 0;
+
+err_free_groups_list:
+	counter_groups_list_free(counter);
+err_free_names:
+	counter_dynamic_names_free(&counter->dynamic_names_list);
+	return err;
+}
+
+void counter_sysfs_free(struct counter_device *const counter)
+{
+	kfree(counter->groups);
+	counter_groups_list_free(counter);
+	counter_dynamic_names_free(&counter->dynamic_names_list);
+}
diff --git a/drivers/counter/counter-sysfs.h b/drivers/counter/counter-sysfs.h
new file mode 100644
index 000000000000..00e7cd6ea083
--- /dev/null
+++ b/drivers/counter/counter-sysfs.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Counter sysfs interface
+ * Copyright (C) 2020 William Breathitt Gray
+ */
+#ifndef _COUNTER_SYSFS_H_
+#define _COUNTER_SYSFS_H_
+
+#include <linux/counter.h>
+
+int counter_sysfs_add(struct counter_device *const counter);
+void counter_sysfs_free(struct counter_device *const counter);
+
+#endif /* _COUNTER_SYSFS_H_ */
diff --git a/drivers/counter/counter.c b/drivers/counter/counter.c
deleted file mode 100644
index 6a683d086008..000000000000
--- a/drivers/counter/counter.c
+++ /dev/null
@@ -1,1496 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Generic Counter interface
- * Copyright (C) 2018 William Breathitt Gray
- */
-#include <linux/counter.h>
-#include <linux/device.h>
-#include <linux/err.h>
-#include <linux/export.h>
-#include <linux/fs.h>
-#include <linux/gfp.h>
-#include <linux/idr.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/list.h>
-#include <linux/module.h>
-#include <linux/printk.h>
-#include <linux/slab.h>
-#include <linux/string.h>
-#include <linux/sysfs.h>
-#include <linux/types.h>
-
-const char *const counter_count_direction_str[2] = {
-	[COUNTER_COUNT_DIRECTION_FORWARD] = "forward",
-	[COUNTER_COUNT_DIRECTION_BACKWARD] = "backward"
-};
-EXPORT_SYMBOL_GPL(counter_count_direction_str);
-
-const char *const counter_count_mode_str[4] = {
-	[COUNTER_COUNT_MODE_NORMAL] = "normal",
-	[COUNTER_COUNT_MODE_RANGE_LIMIT] = "range limit",
-	[COUNTER_COUNT_MODE_NON_RECYCLE] = "non-recycle",
-	[COUNTER_COUNT_MODE_MODULO_N] = "modulo-n"
-};
-EXPORT_SYMBOL_GPL(counter_count_mode_str);
-
-ssize_t counter_signal_enum_read(struct counter_device *counter,
-				 struct counter_signal *signal, void *priv,
-				 char *buf)
-{
-	const struct counter_signal_enum_ext *const e = priv;
-	int err;
-	size_t index;
-
-	if (!e->get)
-		return -EINVAL;
-
-	err = e->get(counter, signal, &index);
-	if (err)
-		return err;
-
-	if (index >= e->num_items)
-		return -EINVAL;
-
-	return sprintf(buf, "%s\n", e->items[index]);
-}
-EXPORT_SYMBOL_GPL(counter_signal_enum_read);
-
-ssize_t counter_signal_enum_write(struct counter_device *counter,
-				  struct counter_signal *signal, void *priv,
-				  const char *buf, size_t len)
-{
-	const struct counter_signal_enum_ext *const e = priv;
-	ssize_t index;
-	int err;
-
-	if (!e->set)
-		return -EINVAL;
-
-	index = __sysfs_match_string(e->items, e->num_items, buf);
-	if (index < 0)
-		return index;
-
-	err = e->set(counter, signal, index);
-	if (err)
-		return err;
-
-	return len;
-}
-EXPORT_SYMBOL_GPL(counter_signal_enum_write);
-
-ssize_t counter_signal_enum_available_read(struct counter_device *counter,
-					   struct counter_signal *signal,
-					   void *priv, char *buf)
-{
-	const struct counter_signal_enum_ext *const e = priv;
-	size_t i;
-	size_t len = 0;
-
-	if (!e->num_items)
-		return 0;
-
-	for (i = 0; i < e->num_items; i++)
-		len += sprintf(buf + len, "%s\n", e->items[i]);
-
-	return len;
-}
-EXPORT_SYMBOL_GPL(counter_signal_enum_available_read);
-
-ssize_t counter_count_enum_read(struct counter_device *counter,
-				struct counter_count *count, void *priv,
-				char *buf)
-{
-	const struct counter_count_enum_ext *const e = priv;
-	int err;
-	size_t index;
-
-	if (!e->get)
-		return -EINVAL;
-
-	err = e->get(counter, count, &index);
-	if (err)
-		return err;
-
-	if (index >= e->num_items)
-		return -EINVAL;
-
-	return sprintf(buf, "%s\n", e->items[index]);
-}
-EXPORT_SYMBOL_GPL(counter_count_enum_read);
-
-ssize_t counter_count_enum_write(struct counter_device *counter,
-				 struct counter_count *count, void *priv,
-				 const char *buf, size_t len)
-{
-	const struct counter_count_enum_ext *const e = priv;
-	ssize_t index;
-	int err;
-
-	if (!e->set)
-		return -EINVAL;
-
-	index = __sysfs_match_string(e->items, e->num_items, buf);
-	if (index < 0)
-		return index;
-
-	err = e->set(counter, count, index);
-	if (err)
-		return err;
-
-	return len;
-}
-EXPORT_SYMBOL_GPL(counter_count_enum_write);
-
-ssize_t counter_count_enum_available_read(struct counter_device *counter,
-					  struct counter_count *count,
-					  void *priv, char *buf)
-{
-	const struct counter_count_enum_ext *const e = priv;
-	size_t i;
-	size_t len = 0;
-
-	if (!e->num_items)
-		return 0;
-
-	for (i = 0; i < e->num_items; i++)
-		len += sprintf(buf + len, "%s\n", e->items[i]);
-
-	return len;
-}
-EXPORT_SYMBOL_GPL(counter_count_enum_available_read);
-
-ssize_t counter_device_enum_read(struct counter_device *counter, void *priv,
-				 char *buf)
-{
-	const struct counter_device_enum_ext *const e = priv;
-	int err;
-	size_t index;
-
-	if (!e->get)
-		return -EINVAL;
-
-	err = e->get(counter, &index);
-	if (err)
-		return err;
-
-	if (index >= e->num_items)
-		return -EINVAL;
-
-	return sprintf(buf, "%s\n", e->items[index]);
-}
-EXPORT_SYMBOL_GPL(counter_device_enum_read);
-
-ssize_t counter_device_enum_write(struct counter_device *counter, void *priv,
-				  const char *buf, size_t len)
-{
-	const struct counter_device_enum_ext *const e = priv;
-	ssize_t index;
-	int err;
-
-	if (!e->set)
-		return -EINVAL;
-
-	index = __sysfs_match_string(e->items, e->num_items, buf);
-	if (index < 0)
-		return index;
-
-	err = e->set(counter, index);
-	if (err)
-		return err;
-
-	return len;
-}
-EXPORT_SYMBOL_GPL(counter_device_enum_write);
-
-ssize_t counter_device_enum_available_read(struct counter_device *counter,
-					   void *priv, char *buf)
-{
-	const struct counter_device_enum_ext *const e = priv;
-	size_t i;
-	size_t len = 0;
-
-	if (!e->num_items)
-		return 0;
-
-	for (i = 0; i < e->num_items; i++)
-		len += sprintf(buf + len, "%s\n", e->items[i]);
-
-	return len;
-}
-EXPORT_SYMBOL_GPL(counter_device_enum_available_read);
-
-struct counter_attr_parm {
-	struct counter_device_attr_group *group;
-	const char *prefix;
-	const char *name;
-	ssize_t (*show)(struct device *dev, struct device_attribute *attr,
-			char *buf);
-	ssize_t (*store)(struct device *dev, struct device_attribute *attr,
-			 const char *buf, size_t len);
-	void *component;
-};
-
-struct counter_device_attr {
-	struct device_attribute dev_attr;
-	struct list_head l;
-	void *component;
-};
-
-static int counter_attribute_create(const struct counter_attr_parm *const parm)
-{
-	struct counter_device_attr *counter_attr;
-	struct device_attribute *dev_attr;
-	int err;
-	struct list_head *const attr_list = &parm->group->attr_list;
-
-	/* Allocate a Counter device attribute */
-	counter_attr = kzalloc(sizeof(*counter_attr), GFP_KERNEL);
-	if (!counter_attr)
-		return -ENOMEM;
-	dev_attr = &counter_attr->dev_attr;
-
-	sysfs_attr_init(&dev_attr->attr);
-
-	/* Configure device attribute */
-	dev_attr->attr.name = kasprintf(GFP_KERNEL, "%s%s", parm->prefix,
-					parm->name);
-	if (!dev_attr->attr.name) {
-		err = -ENOMEM;
-		goto err_free_counter_attr;
-	}
-	if (parm->show) {
-		dev_attr->attr.mode |= 0444;
-		dev_attr->show = parm->show;
-	}
-	if (parm->store) {
-		dev_attr->attr.mode |= 0200;
-		dev_attr->store = parm->store;
-	}
-
-	/* Store associated Counter component with attribute */
-	counter_attr->component = parm->component;
-
-	/* Keep track of the attribute for later cleanup */
-	list_add(&counter_attr->l, attr_list);
-	parm->group->num_attr++;
-
-	return 0;
-
-err_free_counter_attr:
-	kfree(counter_attr);
-	return err;
-}
-
-#define to_counter_attr(_dev_attr) \
-	container_of(_dev_attr, struct counter_device_attr, dev_attr)
-
-struct counter_signal_unit {
-	struct counter_signal *signal;
-};
-
-static const char *const counter_signal_value_str[] = {
-	[COUNTER_SIGNAL_LOW] = "low",
-	[COUNTER_SIGNAL_HIGH] = "high"
-};
-
-static ssize_t counter_signal_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	struct counter_device *const counter = dev_get_drvdata(dev);
-	const struct counter_device_attr *const devattr = to_counter_attr(attr);
-	const struct counter_signal_unit *const component = devattr->component;
-	struct counter_signal *const signal = component->signal;
-	int err;
-	enum counter_signal_value val;
-
-	err = counter->ops->signal_read(counter, signal, &val);
-	if (err)
-		return err;
-
-	return sprintf(buf, "%s\n", counter_signal_value_str[val]);
-}
-
-struct counter_name_unit {
-	const char *name;
-};
-
-static ssize_t counter_device_attr_name_show(struct device *dev,
-					     struct device_attribute *attr,
-					     char *buf)
-{
-	const struct counter_name_unit *const comp = to_counter_attr(attr)->component;
-
-	return sprintf(buf, "%s\n", comp->name);
-}
-
-static int counter_name_attribute_create(
-	struct counter_device_attr_group *const group,
-	const char *const name)
-{
-	struct counter_name_unit *name_comp;
-	struct counter_attr_parm parm;
-	int err;
-
-	/* Skip if no name */
-	if (!name)
-		return 0;
-
-	/* Allocate name attribute component */
-	name_comp = kmalloc(sizeof(*name_comp), GFP_KERNEL);
-	if (!name_comp)
-		return -ENOMEM;
-	name_comp->name = name;
-
-	/* Allocate Signal name attribute */
-	parm.group = group;
-	parm.prefix = "";
-	parm.name = "name";
-	parm.show = counter_device_attr_name_show;
-	parm.store = NULL;
-	parm.component = name_comp;
-	err = counter_attribute_create(&parm);
-	if (err)
-		goto err_free_name_comp;
-
-	return 0;
-
-err_free_name_comp:
-	kfree(name_comp);
-	return err;
-}
-
-struct counter_signal_ext_unit {
-	struct counter_signal *signal;
-	const struct counter_signal_ext *ext;
-};
-
-static ssize_t counter_signal_ext_show(struct device *dev,
-				       struct device_attribute *attr, char *buf)
-{
-	const struct counter_device_attr *const devattr = to_counter_attr(attr);
-	const struct counter_signal_ext_unit *const comp = devattr->component;
-	const struct counter_signal_ext *const ext = comp->ext;
-
-	return ext->read(dev_get_drvdata(dev), comp->signal, ext->priv, buf);
-}
-
-static ssize_t counter_signal_ext_store(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf, size_t len)
-{
-	const struct counter_device_attr *const devattr = to_counter_attr(attr);
-	const struct counter_signal_ext_unit *const comp = devattr->component;
-	const struct counter_signal_ext *const ext = comp->ext;
-
-	return ext->write(dev_get_drvdata(dev), comp->signal, ext->priv, buf,
-		len);
-}
-
-static void counter_device_attr_list_free(struct list_head *attr_list)
-{
-	struct counter_device_attr *p, *n;
-
-	list_for_each_entry_safe(p, n, attr_list, l) {
-		/* free attribute name and associated component memory */
-		kfree(p->dev_attr.attr.name);
-		kfree(p->component);
-		list_del(&p->l);
-		kfree(p);
-	}
-}
-
-static int counter_signal_ext_register(
-	struct counter_device_attr_group *const group,
-	struct counter_signal *const signal)
-{
-	const size_t num_ext = signal->num_ext;
-	size_t i;
-	const struct counter_signal_ext *ext;
-	struct counter_signal_ext_unit *signal_ext_comp;
-	struct counter_attr_parm parm;
-	int err;
-
-	/* Create an attribute for each extension */
-	for (i = 0 ; i < num_ext; i++) {
-		ext = signal->ext + i;
-
-		/* Allocate signal_ext attribute component */
-		signal_ext_comp = kmalloc(sizeof(*signal_ext_comp), GFP_KERNEL);
-		if (!signal_ext_comp) {
-			err = -ENOMEM;
-			goto err_free_attr_list;
-		}
-		signal_ext_comp->signal = signal;
-		signal_ext_comp->ext = ext;
-
-		/* Allocate a Counter device attribute */
-		parm.group = group;
-		parm.prefix = "";
-		parm.name = ext->name;
-		parm.show = (ext->read) ? counter_signal_ext_show : NULL;
-		parm.store = (ext->write) ? counter_signal_ext_store : NULL;
-		parm.component = signal_ext_comp;
-		err = counter_attribute_create(&parm);
-		if (err) {
-			kfree(signal_ext_comp);
-			goto err_free_attr_list;
-		}
-	}
-
-	return 0;
-
-err_free_attr_list:
-	counter_device_attr_list_free(&group->attr_list);
-	return err;
-}
-
-static int counter_signal_attributes_create(
-	struct counter_device_attr_group *const group,
-	const struct counter_device *const counter,
-	struct counter_signal *const signal)
-{
-	struct counter_signal_unit *signal_comp;
-	struct counter_attr_parm parm;
-	int err;
-
-	/* Allocate Signal attribute component */
-	signal_comp = kmalloc(sizeof(*signal_comp), GFP_KERNEL);
-	if (!signal_comp)
-		return -ENOMEM;
-	signal_comp->signal = signal;
-
-	/* Create main Signal attribute */
-	parm.group = group;
-	parm.prefix = "";
-	parm.name = "signal";
-	parm.show = (counter->ops->signal_read) ? counter_signal_show : NULL;
-	parm.store = NULL;
-	parm.component = signal_comp;
-	err = counter_attribute_create(&parm);
-	if (err) {
-		kfree(signal_comp);
-		return err;
-	}
-
-	/* Create Signal name attribute */
-	err = counter_name_attribute_create(group, signal->name);
-	if (err)
-		goto err_free_attr_list;
-
-	/* Register Signal extension attributes */
-	err = counter_signal_ext_register(group, signal);
-	if (err)
-		goto err_free_attr_list;
-
-	return 0;
-
-err_free_attr_list:
-	counter_device_attr_list_free(&group->attr_list);
-	return err;
-}
-
-static int counter_signals_register(
-	struct counter_device_attr_group *const groups_list,
-	const struct counter_device *const counter)
-{
-	const size_t num_signals = counter->num_signals;
-	size_t i;
-	struct counter_signal *signal;
-	const char *name;
-	int err;
-
-	/* Register each Signal */
-	for (i = 0; i < num_signals; i++) {
-		signal = counter->signals + i;
-
-		/* Generate Signal attribute directory name */
-		name = kasprintf(GFP_KERNEL, "signal%d", signal->id);
-		if (!name) {
-			err = -ENOMEM;
-			goto err_free_attr_groups;
-		}
-		groups_list[i].attr_group.name = name;
-
-		/* Create all attributes associated with Signal */
-		err = counter_signal_attributes_create(groups_list + i, counter,
-						       signal);
-		if (err)
-			goto err_free_attr_groups;
-	}
-
-	return 0;
-
-err_free_attr_groups:
-	do {
-		kfree(groups_list[i].attr_group.name);
-		counter_device_attr_list_free(&groups_list[i].attr_list);
-	} while (i--);
-	return err;
-}
-
-static const char *const counter_synapse_action_str[] = {
-	[COUNTER_SYNAPSE_ACTION_NONE] = "none",
-	[COUNTER_SYNAPSE_ACTION_RISING_EDGE] = "rising edge",
-	[COUNTER_SYNAPSE_ACTION_FALLING_EDGE] = "falling edge",
-	[COUNTER_SYNAPSE_ACTION_BOTH_EDGES] = "both edges"
-};
-
-struct counter_action_unit {
-	struct counter_synapse *synapse;
-	struct counter_count *count;
-};
-
-static ssize_t counter_action_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	const struct counter_device_attr *const devattr = to_counter_attr(attr);
-	int err;
-	struct counter_device *const counter = dev_get_drvdata(dev);
-	const struct counter_action_unit *const component = devattr->component;
-	struct counter_count *const count = component->count;
-	struct counter_synapse *const synapse = component->synapse;
-	size_t action_index;
-	enum counter_synapse_action action;
-
-	err = counter->ops->action_get(counter, count, synapse, &action_index);
-	if (err)
-		return err;
-
-	synapse->action = action_index;
-
-	action = synapse->actions_list[action_index];
-	return sprintf(buf, "%s\n", counter_synapse_action_str[action]);
-}
-
-static ssize_t counter_action_store(struct device *dev,
-				    struct device_attribute *attr,
-				    const char *buf, size_t len)
-{
-	const struct counter_device_attr *const devattr = to_counter_attr(attr);
-	const struct counter_action_unit *const component = devattr->component;
-	struct counter_synapse *const synapse = component->synapse;
-	size_t action_index;
-	const size_t num_actions = synapse->num_actions;
-	enum counter_synapse_action action;
-	int err;
-	struct counter_device *const counter = dev_get_drvdata(dev);
-	struct counter_count *const count = component->count;
-
-	/* Find requested action mode */
-	for (action_index = 0; action_index < num_actions; action_index++) {
-		action = synapse->actions_list[action_index];
-		if (sysfs_streq(buf, counter_synapse_action_str[action]))
-			break;
-	}
-	/* If requested action mode not found */
-	if (action_index >= num_actions)
-		return -EINVAL;
-
-	err = counter->ops->action_set(counter, count, synapse, action_index);
-	if (err)
-		return err;
-
-	synapse->action = action_index;
-
-	return len;
-}
-
-struct counter_action_avail_unit {
-	const enum counter_synapse_action *actions_list;
-	size_t num_actions;
-};
-
-static ssize_t counter_synapse_action_available_show(struct device *dev,
-	struct device_attribute *attr, char *buf)
-{
-	const struct counter_device_attr *const devattr = to_counter_attr(attr);
-	const struct counter_action_avail_unit *const component = devattr->component;
-	size_t i;
-	enum counter_synapse_action action;
-	ssize_t len = 0;
-
-	for (i = 0; i < component->num_actions; i++) {
-		action = component->actions_list[i];
-		len += sprintf(buf + len, "%s\n",
-			       counter_synapse_action_str[action]);
-	}
-
-	return len;
-}
-
-static int counter_synapses_register(
-	struct counter_device_attr_group *const group,
-	const struct counter_device *const counter,
-	struct counter_count *const count, const char *const count_attr_name)
-{
-	size_t i;
-	struct counter_synapse *synapse;
-	const char *prefix;
-	struct counter_action_unit *action_comp;
-	struct counter_attr_parm parm;
-	int err;
-	struct counter_action_avail_unit *avail_comp;
-
-	/* Register each Synapse */
-	for (i = 0; i < count->num_synapses; i++) {
-		synapse = count->synapses + i;
-
-		/* Generate attribute prefix */
-		prefix = kasprintf(GFP_KERNEL, "signal%d_",
-				   synapse->signal->id);
-		if (!prefix) {
-			err = -ENOMEM;
-			goto err_free_attr_list;
-		}
-
-		/* Allocate action attribute component */
-		action_comp = kmalloc(sizeof(*action_comp), GFP_KERNEL);
-		if (!action_comp) {
-			err = -ENOMEM;
-			goto err_free_prefix;
-		}
-		action_comp->synapse = synapse;
-		action_comp->count = count;
-
-		/* Create action attribute */
-		parm.group = group;
-		parm.prefix = prefix;
-		parm.name = "action";
-		parm.show = (counter->ops->action_get) ? counter_action_show : NULL;
-		parm.store = (counter->ops->action_set) ? counter_action_store : NULL;
-		parm.component = action_comp;
-		err = counter_attribute_create(&parm);
-		if (err) {
-			kfree(action_comp);
-			goto err_free_prefix;
-		}
-
-		/* Allocate action available attribute component */
-		avail_comp = kmalloc(sizeof(*avail_comp), GFP_KERNEL);
-		if (!avail_comp) {
-			err = -ENOMEM;
-			goto err_free_prefix;
-		}
-		avail_comp->actions_list = synapse->actions_list;
-		avail_comp->num_actions = synapse->num_actions;
-
-		/* Create action_available attribute */
-		parm.group = group;
-		parm.prefix = prefix;
-		parm.name = "action_available";
-		parm.show = counter_synapse_action_available_show;
-		parm.store = NULL;
-		parm.component = avail_comp;
-		err = counter_attribute_create(&parm);
-		if (err) {
-			kfree(avail_comp);
-			goto err_free_prefix;
-		}
-
-		kfree(prefix);
-	}
-
-	return 0;
-
-err_free_prefix:
-	kfree(prefix);
-err_free_attr_list:
-	counter_device_attr_list_free(&group->attr_list);
-	return err;
-}
-
-struct counter_count_unit {
-	struct counter_count *count;
-};
-
-static ssize_t counter_count_show(struct device *dev,
-				  struct device_attribute *attr,
-				  char *buf)
-{
-	struct counter_device *const counter = dev_get_drvdata(dev);
-	const struct counter_device_attr *const devattr = to_counter_attr(attr);
-	const struct counter_count_unit *const component = devattr->component;
-	struct counter_count *const count = component->count;
-	int err;
-	unsigned long val;
-
-	err = counter->ops->count_read(counter, count, &val);
-	if (err)
-		return err;
-
-	return sprintf(buf, "%lu\n", val);
-}
-
-static ssize_t counter_count_store(struct device *dev,
-				   struct device_attribute *attr,
-				   const char *buf, size_t len)
-{
-	struct counter_device *const counter = dev_get_drvdata(dev);
-	const struct counter_device_attr *const devattr = to_counter_attr(attr);
-	const struct counter_count_unit *const component = devattr->component;
-	struct counter_count *const count = component->count;
-	int err;
-	unsigned long val;
-
-	err = kstrtoul(buf, 0, &val);
-	if (err)
-		return err;
-
-	err = counter->ops->count_write(counter, count, val);
-	if (err)
-		return err;
-
-	return len;
-}
-
-static const char *const counter_count_function_str[] = {
-	[COUNTER_COUNT_FUNCTION_INCREASE] = "increase",
-	[COUNTER_COUNT_FUNCTION_DECREASE] = "decrease",
-	[COUNTER_COUNT_FUNCTION_PULSE_DIRECTION] = "pulse-direction",
-	[COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A] = "quadrature x1 a",
-	[COUNTER_COUNT_FUNCTION_QUADRATURE_X1_B] = "quadrature x1 b",
-	[COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A] = "quadrature x2 a",
-	[COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B] = "quadrature x2 b",
-	[COUNTER_COUNT_FUNCTION_QUADRATURE_X4] = "quadrature x4"
-};
-
-static ssize_t counter_function_show(struct device *dev,
-				     struct device_attribute *attr, char *buf)
-{
-	int err;
-	struct counter_device *const counter = dev_get_drvdata(dev);
-	const struct counter_device_attr *const devattr = to_counter_attr(attr);
-	const struct counter_count_unit *const component = devattr->component;
-	struct counter_count *const count = component->count;
-	size_t func_index;
-	enum counter_count_function function;
-
-	err = counter->ops->function_get(counter, count, &func_index);
-	if (err)
-		return err;
-
-	count->function = func_index;
-
-	function = count->functions_list[func_index];
-	return sprintf(buf, "%s\n", counter_count_function_str[function]);
-}
-
-static ssize_t counter_function_store(struct device *dev,
-				      struct device_attribute *attr,
-				      const char *buf, size_t len)
-{
-	const struct counter_device_attr *const devattr = to_counter_attr(attr);
-	const struct counter_count_unit *const component = devattr->component;
-	struct counter_count *const count = component->count;
-	const size_t num_functions = count->num_functions;
-	size_t func_index;
-	enum counter_count_function function;
-	int err;
-	struct counter_device *const counter = dev_get_drvdata(dev);
-
-	/* Find requested Count function mode */
-	for (func_index = 0; func_index < num_functions; func_index++) {
-		function = count->functions_list[func_index];
-		if (sysfs_streq(buf, counter_count_function_str[function]))
-			break;
-	}
-	/* Return error if requested Count function mode not found */
-	if (func_index >= num_functions)
-		return -EINVAL;
-
-	err = counter->ops->function_set(counter, count, func_index);
-	if (err)
-		return err;
-
-	count->function = func_index;
-
-	return len;
-}
-
-struct counter_count_ext_unit {
-	struct counter_count *count;
-	const struct counter_count_ext *ext;
-};
-
-static ssize_t counter_count_ext_show(struct device *dev,
-				      struct device_attribute *attr, char *buf)
-{
-	const struct counter_device_attr *const devattr = to_counter_attr(attr);
-	const struct counter_count_ext_unit *const comp = devattr->component;
-	const struct counter_count_ext *const ext = comp->ext;
-
-	return ext->read(dev_get_drvdata(dev), comp->count, ext->priv, buf);
-}
-
-static ssize_t counter_count_ext_store(struct device *dev,
-				       struct device_attribute *attr,
-				       const char *buf, size_t len)
-{
-	const struct counter_device_attr *const devattr = to_counter_attr(attr);
-	const struct counter_count_ext_unit *const comp = devattr->component;
-	const struct counter_count_ext *const ext = comp->ext;
-
-	return ext->write(dev_get_drvdata(dev), comp->count, ext->priv, buf,
-		len);
-}
-
-static int counter_count_ext_register(
-	struct counter_device_attr_group *const group,
-	struct counter_count *const count)
-{
-	size_t i;
-	const struct counter_count_ext *ext;
-	struct counter_count_ext_unit *count_ext_comp;
-	struct counter_attr_parm parm;
-	int err;
-
-	/* Create an attribute for each extension */
-	for (i = 0 ; i < count->num_ext; i++) {
-		ext = count->ext + i;
-
-		/* Allocate count_ext attribute component */
-		count_ext_comp = kmalloc(sizeof(*count_ext_comp), GFP_KERNEL);
-		if (!count_ext_comp) {
-			err = -ENOMEM;
-			goto err_free_attr_list;
-		}
-		count_ext_comp->count = count;
-		count_ext_comp->ext = ext;
-
-		/* Allocate count_ext attribute */
-		parm.group = group;
-		parm.prefix = "";
-		parm.name = ext->name;
-		parm.show = (ext->read) ? counter_count_ext_show : NULL;
-		parm.store = (ext->write) ? counter_count_ext_store : NULL;
-		parm.component = count_ext_comp;
-		err = counter_attribute_create(&parm);
-		if (err) {
-			kfree(count_ext_comp);
-			goto err_free_attr_list;
-		}
-	}
-
-	return 0;
-
-err_free_attr_list:
-	counter_device_attr_list_free(&group->attr_list);
-	return err;
-}
-
-struct counter_func_avail_unit {
-	const enum counter_count_function *functions_list;
-	size_t num_functions;
-};
-
-static ssize_t counter_count_function_available_show(struct device *dev,
-	struct device_attribute *attr, char *buf)
-{
-	const struct counter_device_attr *const devattr = to_counter_attr(attr);
-	const struct counter_func_avail_unit *const component = devattr->component;
-	const enum counter_count_function *const func_list = component->functions_list;
-	const size_t num_functions = component->num_functions;
-	size_t i;
-	enum counter_count_function function;
-	ssize_t len = 0;
-
-	for (i = 0; i < num_functions; i++) {
-		function = func_list[i];
-		len += sprintf(buf + len, "%s\n",
-			       counter_count_function_str[function]);
-	}
-
-	return len;
-}
-
-static int counter_count_attributes_create(
-	struct counter_device_attr_group *const group,
-	const struct counter_device *const counter,
-	struct counter_count *const count)
-{
-	struct counter_count_unit *count_comp;
-	struct counter_attr_parm parm;
-	int err;
-	struct counter_count_unit *func_comp;
-	struct counter_func_avail_unit *avail_comp;
-
-	/* Allocate count attribute component */
-	count_comp = kmalloc(sizeof(*count_comp), GFP_KERNEL);
-	if (!count_comp)
-		return -ENOMEM;
-	count_comp->count = count;
-
-	/* Create main Count attribute */
-	parm.group = group;
-	parm.prefix = "";
-	parm.name = "count";
-	parm.show = (counter->ops->count_read) ? counter_count_show : NULL;
-	parm.store = (counter->ops->count_write) ? counter_count_store : NULL;
-	parm.component = count_comp;
-	err = counter_attribute_create(&parm);
-	if (err) {
-		kfree(count_comp);
-		return err;
-	}
-
-	/* Allocate function attribute component */
-	func_comp = kmalloc(sizeof(*func_comp), GFP_KERNEL);
-	if (!func_comp) {
-		err = -ENOMEM;
-		goto err_free_attr_list;
-	}
-	func_comp->count = count;
-
-	/* Create Count function attribute */
-	parm.group = group;
-	parm.prefix = "";
-	parm.name = "function";
-	parm.show = (counter->ops->function_get) ? counter_function_show : NULL;
-	parm.store = (counter->ops->function_set) ? counter_function_store : NULL;
-	parm.component = func_comp;
-	err = counter_attribute_create(&parm);
-	if (err) {
-		kfree(func_comp);
-		goto err_free_attr_list;
-	}
-
-	/* Allocate function available attribute component */
-	avail_comp = kmalloc(sizeof(*avail_comp), GFP_KERNEL);
-	if (!avail_comp) {
-		err = -ENOMEM;
-		goto err_free_attr_list;
-	}
-	avail_comp->functions_list = count->functions_list;
-	avail_comp->num_functions = count->num_functions;
-
-	/* Create Count function_available attribute */
-	parm.group = group;
-	parm.prefix = "";
-	parm.name = "function_available";
-	parm.show = counter_count_function_available_show;
-	parm.store = NULL;
-	parm.component = avail_comp;
-	err = counter_attribute_create(&parm);
-	if (err) {
-		kfree(avail_comp);
-		goto err_free_attr_list;
-	}
-
-	/* Create Count name attribute */
-	err = counter_name_attribute_create(group, count->name);
-	if (err)
-		goto err_free_attr_list;
-
-	/* Register Count extension attributes */
-	err = counter_count_ext_register(group, count);
-	if (err)
-		goto err_free_attr_list;
-
-	return 0;
-
-err_free_attr_list:
-	counter_device_attr_list_free(&group->attr_list);
-	return err;
-}
-
-static int counter_counts_register(
-	struct counter_device_attr_group *const groups_list,
-	const struct counter_device *const counter)
-{
-	size_t i;
-	struct counter_count *count;
-	const char *name;
-	int err;
-
-	/* Register each Count */
-	for (i = 0; i < counter->num_counts; i++) {
-		count = counter->counts + i;
-
-		/* Generate Count attribute directory name */
-		name = kasprintf(GFP_KERNEL, "count%d", count->id);
-		if (!name) {
-			err = -ENOMEM;
-			goto err_free_attr_groups;
-		}
-		groups_list[i].attr_group.name = name;
-
-		/* Register the Synapses associated with each Count */
-		err = counter_synapses_register(groups_list + i, counter, count,
-						name);
-		if (err)
-			goto err_free_attr_groups;
-
-		/* Create all attributes associated with Count */
-		err = counter_count_attributes_create(groups_list + i, counter,
-						      count);
-		if (err)
-			goto err_free_attr_groups;
-	}
-
-	return 0;
-
-err_free_attr_groups:
-	do {
-		kfree(groups_list[i].attr_group.name);
-		counter_device_attr_list_free(&groups_list[i].attr_list);
-	} while (i--);
-	return err;
-}
-
-struct counter_size_unit {
-	size_t size;
-};
-
-static ssize_t counter_device_attr_size_show(struct device *dev,
-					     struct device_attribute *attr,
-					     char *buf)
-{
-	const struct counter_size_unit *const comp = to_counter_attr(attr)->component;
-
-	return sprintf(buf, "%zu\n", comp->size);
-}
-
-static int counter_size_attribute_create(
-	struct counter_device_attr_group *const group,
-	const size_t size, const char *const name)
-{
-	struct counter_size_unit *size_comp;
-	struct counter_attr_parm parm;
-	int err;
-
-	/* Allocate size attribute component */
-	size_comp = kmalloc(sizeof(*size_comp), GFP_KERNEL);
-	if (!size_comp)
-		return -ENOMEM;
-	size_comp->size = size;
-
-	parm.group = group;
-	parm.prefix = "";
-	parm.name = name;
-	parm.show = counter_device_attr_size_show;
-	parm.store = NULL;
-	parm.component = size_comp;
-	err = counter_attribute_create(&parm);
-	if (err)
-		goto err_free_size_comp;
-
-	return 0;
-
-err_free_size_comp:
-	kfree(size_comp);
-	return err;
-}
-
-struct counter_ext_unit {
-	const struct counter_device_ext *ext;
-};
-
-static ssize_t counter_device_ext_show(struct device *dev,
-				       struct device_attribute *attr, char *buf)
-{
-	const struct counter_device_attr *const devattr = to_counter_attr(attr);
-	const struct counter_ext_unit *const component = devattr->component;
-	const struct counter_device_ext *const ext = component->ext;
-
-	return ext->read(dev_get_drvdata(dev), ext->priv, buf);
-}
-
-static ssize_t counter_device_ext_store(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf, size_t len)
-{
-	const struct counter_device_attr *const devattr = to_counter_attr(attr);
-	const struct counter_ext_unit *const component = devattr->component;
-	const struct counter_device_ext *const ext = component->ext;
-
-	return ext->write(dev_get_drvdata(dev), ext->priv, buf, len);
-}
-
-static int counter_device_ext_register(
-	struct counter_device_attr_group *const group,
-	struct counter_device *const counter)
-{
-	size_t i;
-	struct counter_ext_unit *ext_comp;
-	struct counter_attr_parm parm;
-	int err;
-
-	/* Create an attribute for each extension */
-	for (i = 0 ; i < counter->num_ext; i++) {
-		/* Allocate extension attribute component */
-		ext_comp = kmalloc(sizeof(*ext_comp), GFP_KERNEL);
-		if (!ext_comp) {
-			err = -ENOMEM;
-			goto err_free_attr_list;
-		}
-
-		ext_comp->ext = counter->ext + i;
-
-		/* Allocate extension attribute */
-		parm.group = group;
-		parm.prefix = "";
-		parm.name = counter->ext[i].name;
-		parm.show = (counter->ext[i].read) ? counter_device_ext_show : NULL;
-		parm.store = (counter->ext[i].write) ? counter_device_ext_store : NULL;
-		parm.component = ext_comp;
-		err = counter_attribute_create(&parm);
-		if (err) {
-			kfree(ext_comp);
-			goto err_free_attr_list;
-		}
-	}
-
-	return 0;
-
-err_free_attr_list:
-	counter_device_attr_list_free(&group->attr_list);
-	return err;
-}
-
-static int counter_global_attr_register(
-	struct counter_device_attr_group *const group,
-	struct counter_device *const counter)
-{
-	int err;
-
-	/* Create name attribute */
-	err = counter_name_attribute_create(group, counter->name);
-	if (err)
-		return err;
-
-	/* Create num_counts attribute */
-	err = counter_size_attribute_create(group, counter->num_counts,
-					    "num_counts");
-	if (err)
-		goto err_free_attr_list;
-
-	/* Create num_signals attribute */
-	err = counter_size_attribute_create(group, counter->num_signals,
-					    "num_signals");
-	if (err)
-		goto err_free_attr_list;
-
-	/* Register Counter device extension attributes */
-	err = counter_device_ext_register(group, counter);
-	if (err)
-		goto err_free_attr_list;
-
-	return 0;
-
-err_free_attr_list:
-	counter_device_attr_list_free(&group->attr_list);
-	return err;
-}
-
-static void counter_device_groups_list_free(
-	struct counter_device_attr_group *const groups_list,
-	const size_t num_groups)
-{
-	struct counter_device_attr_group *group;
-	size_t i;
-
-	/* loop through all attribute groups (signals, counts, global, etc.) */
-	for (i = 0; i < num_groups; i++) {
-		group = groups_list + i;
-
-		/* free all attribute group and associated attributes memory */
-		kfree(group->attr_group.name);
-		kfree(group->attr_group.attrs);
-		counter_device_attr_list_free(&group->attr_list);
-	}
-
-	kfree(groups_list);
-}
-
-static int counter_device_groups_list_prepare(
-	struct counter_device *const counter)
-{
-	const size_t total_num_groups =
-		counter->num_signals + counter->num_counts + 1;
-	struct counter_device_attr_group *groups_list;
-	size_t i;
-	int err;
-	size_t num_groups = 0;
-
-	/* Allocate space for attribute groups (signals, counts, and ext) */
-	groups_list = kcalloc(total_num_groups, sizeof(*groups_list),
-			      GFP_KERNEL);
-	if (!groups_list)
-		return -ENOMEM;
-
-	/* Initialize attribute lists */
-	for (i = 0; i < total_num_groups; i++)
-		INIT_LIST_HEAD(&groups_list[i].attr_list);
-
-	/* Register Signals */
-	err = counter_signals_register(groups_list, counter);
-	if (err)
-		goto err_free_groups_list;
-	num_groups += counter->num_signals;
-
-	/* Register Counts and respective Synapses */
-	err = counter_counts_register(groups_list + num_groups, counter);
-	if (err)
-		goto err_free_groups_list;
-	num_groups += counter->num_counts;
-
-	/* Register Counter global attributes */
-	err = counter_global_attr_register(groups_list + num_groups, counter);
-	if (err)
-		goto err_free_groups_list;
-	num_groups++;
-
-	/* Store groups_list in device_state */
-	counter->device_state->groups_list = groups_list;
-	counter->device_state->num_groups = num_groups;
-
-	return 0;
-
-err_free_groups_list:
-	counter_device_groups_list_free(groups_list, num_groups);
-	return err;
-}
-
-static int counter_device_groups_prepare(
-	struct counter_device_state *const device_state)
-{
-	size_t i, j;
-	struct counter_device_attr_group *group;
-	int err;
-	struct counter_device_attr *p;
-
-	/* Allocate attribute groups for association with device */
-	device_state->groups = kcalloc(device_state->num_groups + 1,
-				       sizeof(*device_state->groups),
-				       GFP_KERNEL);
-	if (!device_state->groups)
-		return -ENOMEM;
-
-	/* Prepare each group of attributes for association */
-	for (i = 0; i < device_state->num_groups; i++) {
-		group = device_state->groups_list + i;
-
-		/* Allocate space for attribute pointers in attribute group */
-		group->attr_group.attrs = kcalloc(group->num_attr + 1,
-			sizeof(*group->attr_group.attrs), GFP_KERNEL);
-		if (!group->attr_group.attrs) {
-			err = -ENOMEM;
-			goto err_free_groups;
-		}
-
-		/* Add attribute pointers to attribute group */
-		j = 0;
-		list_for_each_entry(p, &group->attr_list, l)
-			group->attr_group.attrs[j++] = &p->dev_attr.attr;
-
-		/* Group attributes in attribute group */
-		device_state->groups[i] = &group->attr_group;
-	}
-	/* Associate attributes with device */
-	device_state->dev.groups = device_state->groups;
-
-	return 0;
-
-err_free_groups:
-	do {
-		group = device_state->groups_list + i;
-		kfree(group->attr_group.attrs);
-		group->attr_group.attrs = NULL;
-	} while (i--);
-	kfree(device_state->groups);
-	return err;
-}
-
-/* Provides a unique ID for each counter device */
-static DEFINE_IDA(counter_ida);
-
-static void counter_device_release(struct device *dev)
-{
-	struct counter_device *const counter = dev_get_drvdata(dev);
-	struct counter_device_state *const device_state = counter->device_state;
-
-	kfree(device_state->groups);
-	counter_device_groups_list_free(device_state->groups_list,
-					device_state->num_groups);
-	ida_simple_remove(&counter_ida, device_state->id);
-	kfree(device_state);
-}
-
-static struct device_type counter_device_type = {
-	.name = "counter_device",
-	.release = counter_device_release
-};
-
-static struct bus_type counter_bus_type = {
-	.name = "counter"
-};
-
-/**
- * counter_register - register Counter to the system
- * @counter:	pointer to Counter to register
- *
- * This function registers a Counter to the system. A sysfs "counter" directory
- * will be created and populated with sysfs attributes correlating with the
- * Counter Signals, Synapses, and Counts respectively.
- */
-int counter_register(struct counter_device *const counter)
-{
-	struct counter_device_state *device_state;
-	int err;
-
-	/* Allocate internal state container for Counter device */
-	device_state = kzalloc(sizeof(*device_state), GFP_KERNEL);
-	if (!device_state)
-		return -ENOMEM;
-	counter->device_state = device_state;
-
-	/* Acquire unique ID */
-	device_state->id = ida_simple_get(&counter_ida, 0, 0, GFP_KERNEL);
-	if (device_state->id < 0) {
-		err = device_state->id;
-		goto err_free_device_state;
-	}
-
-	/* Configure device structure for Counter */
-	device_state->dev.type = &counter_device_type;
-	device_state->dev.bus = &counter_bus_type;
-	if (counter->parent) {
-		device_state->dev.parent = counter->parent;
-		device_state->dev.of_node = counter->parent->of_node;
-	}
-	dev_set_name(&device_state->dev, "counter%d", device_state->id);
-	device_initialize(&device_state->dev);
-	dev_set_drvdata(&device_state->dev, counter);
-
-	/* Prepare device attributes */
-	err = counter_device_groups_list_prepare(counter);
-	if (err)
-		goto err_free_id;
-
-	/* Organize device attributes to groups and match to device */
-	err = counter_device_groups_prepare(device_state);
-	if (err)
-		goto err_free_groups_list;
-
-	/* Add device to system */
-	err = device_add(&device_state->dev);
-	if (err)
-		goto err_free_groups;
-
-	return 0;
-
-err_free_groups:
-	kfree(device_state->groups);
-err_free_groups_list:
-	counter_device_groups_list_free(device_state->groups_list,
-					device_state->num_groups);
-err_free_id:
-	ida_simple_remove(&counter_ida, device_state->id);
-err_free_device_state:
-	kfree(device_state);
-	return err;
-}
-EXPORT_SYMBOL_GPL(counter_register);
-
-/**
- * counter_unregister - unregister Counter from the system
- * @counter:	pointer to Counter to unregister
- *
- * The Counter is unregistered from the system; all allocated memory is freed.
- */
-void counter_unregister(struct counter_device *const counter)
-{
-	if (counter)
-		device_del(&counter->device_state->dev);
-}
-EXPORT_SYMBOL_GPL(counter_unregister);
-
-static void devm_counter_unreg(struct device *dev, void *res)
-{
-	counter_unregister(*(struct counter_device **)res);
-}
-
-/**
- * devm_counter_register - Resource-managed counter_register
- * @dev:	device to allocate counter_device for
- * @counter:	pointer to Counter to register
- *
- * Managed counter_register. The Counter registered with this function is
- * automatically unregistered on driver detach. This function calls
- * counter_register internally. Refer to that function for more information.
- *
- * If an Counter registered with this function needs to be unregistered
- * separately, devm_counter_unregister must be used.
- *
- * RETURNS:
- * 0 on success, negative error number on failure.
- */
-int devm_counter_register(struct device *dev,
-			  struct counter_device *const counter)
-{
-	struct counter_device **ptr;
-	int ret;
-
-	ptr = devres_alloc(devm_counter_unreg, sizeof(*ptr), GFP_KERNEL);
-	if (!ptr)
-		return -ENOMEM;
-
-	ret = counter_register(counter);
-	if (!ret) {
-		*ptr = counter;
-		devres_add(dev, ptr);
-	} else {
-		devres_free(ptr);
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(devm_counter_register);
-
-static int devm_counter_match(struct device *dev, void *res, void *data)
-{
-	struct counter_device **r = res;
-
-	if (!r || !*r) {
-		WARN_ON(!r || !*r);
-		return 0;
-	}
-
-	return *r == data;
-}
-
-/**
- * devm_counter_unregister - Resource-managed counter_unregister
- * @dev:	device this counter_device belongs to
- * @counter:	pointer to Counter associated with the device
- *
- * Unregister Counter registered with devm_counter_register.
- */
-void devm_counter_unregister(struct device *dev,
-			     struct counter_device *const counter)
-{
-	int rc;
-
-	rc = devres_release(dev, devm_counter_unreg, devm_counter_match,
-			    counter);
-	WARN_ON(rc);
-}
-EXPORT_SYMBOL_GPL(devm_counter_unregister);
-
-static int __init counter_init(void)
-{
-	return bus_register(&counter_bus_type);
-}
-
-static void __exit counter_exit(void)
-{
-	bus_unregister(&counter_bus_type);
-}
-
-subsys_initcall(counter_init);
-module_exit(counter_exit);
-
-MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
-MODULE_DESCRIPTION("Generic Counter interface");
-MODULE_LICENSE("GPL v2");
diff --git a/drivers/counter/ftm-quaddec.c b/drivers/counter/ftm-quaddec.c
index c2b3fdfd8b77..71a0f7131237 100644
--- a/drivers/counter/ftm-quaddec.c
+++ b/drivers/counter/ftm-quaddec.c
@@ -14,6 +14,7 @@
 #include <linux/mutex.h>
 #include <linux/counter.h>
 #include <linux/bitfield.h>
+#include <linux/types.h>
 
 #define FTM_FIELD_UPDATE(ftm, offset, mask, val)			\
 	({								\
@@ -115,8 +116,7 @@ static void ftm_quaddec_disable(void *ftm)
 }
 
 static int ftm_quaddec_get_prescaler(struct counter_device *counter,
-				     struct counter_count *count,
-				     size_t *cnt_mode)
+				     struct counter_count *count, u8 *cnt_mode)
 {
 	struct ftm_quaddec *ftm = counter->priv;
 	uint32_t scflags;
@@ -129,8 +129,7 @@ static int ftm_quaddec_get_prescaler(struct counter_device *counter,
 }
 
 static int ftm_quaddec_set_prescaler(struct counter_device *counter,
-				     struct counter_count *count,
-				     size_t cnt_mode)
+				     struct counter_count *count, u8 cnt_mode)
 {
 	struct ftm_quaddec *ftm = counter->priv;
 
@@ -151,34 +150,21 @@ static const char * const ftm_quaddec_prescaler[] = {
 	"1", "2", "4", "8", "16", "32", "64", "128"
 };
 
-static struct counter_count_enum_ext ftm_quaddec_prescaler_enum = {
-	.items = ftm_quaddec_prescaler,
-	.num_items = ARRAY_SIZE(ftm_quaddec_prescaler),
-	.get = ftm_quaddec_get_prescaler,
-	.set = ftm_quaddec_set_prescaler
-};
-
-enum ftm_quaddec_synapse_action {
-	FTM_QUADDEC_SYNAPSE_ACTION_BOTH_EDGES,
-};
-
-static enum counter_synapse_action ftm_quaddec_synapse_actions[] = {
-	[FTM_QUADDEC_SYNAPSE_ACTION_BOTH_EDGES] =
+static const u8 ftm_quaddec_synapse_actions[] = {
 	COUNTER_SYNAPSE_ACTION_BOTH_EDGES
 };
 
 enum ftm_quaddec_count_function {
-	FTM_QUADDEC_COUNT_ENCODER_MODE_1,
+	FTM_QUADDEC_COUNT_ENCODER_MODE_1 = COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
 };
 
-static const enum counter_count_function ftm_quaddec_count_functions[] = {
-	[FTM_QUADDEC_COUNT_ENCODER_MODE_1] =
-	COUNTER_COUNT_FUNCTION_QUADRATURE_X4
+static const u8 ftm_quaddec_count_functions[] = {
+	FTM_QUADDEC_COUNT_ENCODER_MODE_1
 };
 
 static int ftm_quaddec_count_read(struct counter_device *counter,
 				  struct counter_count *count,
-				  unsigned long *val)
+				  u64 *val)
 {
 	struct ftm_quaddec *const ftm = counter->priv;
 	uint32_t cntval;
@@ -192,7 +178,7 @@ static int ftm_quaddec_count_read(struct counter_device *counter,
 
 static int ftm_quaddec_count_write(struct counter_device *counter,
 				   struct counter_count *count,
-				   const unsigned long val)
+				   const u64 val)
 {
 	struct ftm_quaddec *const ftm = counter->priv;
 
@@ -208,7 +194,7 @@ static int ftm_quaddec_count_write(struct counter_device *counter,
 
 static int ftm_quaddec_count_function_get(struct counter_device *counter,
 					  struct counter_count *count,
-					  size_t *function)
+					  u8 *function)
 {
 	*function = FTM_QUADDEC_COUNT_ENCODER_MODE_1;
 
@@ -218,20 +204,13 @@ static int ftm_quaddec_count_function_get(struct counter_device *counter,
 static int ftm_quaddec_action_get(struct counter_device *counter,
 				  struct counter_count *count,
 				  struct counter_synapse *synapse,
-				  size_t *action)
+				  u8 *action)
 {
-	*action = FTM_QUADDEC_SYNAPSE_ACTION_BOTH_EDGES;
+	*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
 
 	return 0;
 }
 
-static const struct counter_ops ftm_quaddec_cnt_ops = {
-	.count_read = ftm_quaddec_count_read,
-	.count_write = ftm_quaddec_count_write,
-	.function_get = ftm_quaddec_count_function_get,
-	.action_get = ftm_quaddec_action_get,
-};
-
 static struct counter_signal ftm_quaddec_signals[] = {
 	{
 		.id = 0,
@@ -256,9 +235,12 @@ static struct counter_synapse ftm_quaddec_count_synapses[] = {
 	}
 };
 
-static const struct counter_count_ext ftm_quaddec_count_ext[] = {
-	COUNTER_COUNT_ENUM("prescaler", &ftm_quaddec_prescaler_enum),
-	COUNTER_COUNT_ENUM_AVAILABLE("prescaler", &ftm_quaddec_prescaler_enum),
+static DEFINE_COUNTER_ENUM(ftm_quaddec_prescaler_enum, ftm_quaddec_prescaler);
+
+static struct counter_data ftm_quaddec_count_ext[] = {
+	COUNTER_DATA_COUNT_ENUM("prescaler", ftm_quaddec_get_prescaler,
+				ftm_quaddec_set_prescaler,
+				ftm_quaddec_prescaler_enum),
 };
 
 static struct counter_count ftm_quaddec_counts = {
@@ -302,7 +284,10 @@ static int ftm_quaddec_probe(struct platform_device *pdev)
 	}
 	ftm->counter.name = dev_name(&pdev->dev);
 	ftm->counter.parent = &pdev->dev;
-	ftm->counter.ops = &ftm_quaddec_cnt_ops;
+	ftm->counter.count_read = ftm_quaddec_count_read;
+	ftm->counter.count_write = ftm_quaddec_count_write;
+	ftm->counter.function_read = ftm_quaddec_count_function_get;
+	ftm->counter.action_read = ftm_quaddec_action_get;
 	ftm->counter.counts = &ftm_quaddec_counts;
 	ftm->counter.num_counts = 1;
 	ftm->counter.signals = ftm_quaddec_signals;
diff --git a/drivers/counter/microchip-tcb-capture.c b/drivers/counter/microchip-tcb-capture.c
index f7b7743ddb94..27c449bbadd7 100644
--- a/drivers/counter/microchip-tcb-capture.c
+++ b/drivers/counter/microchip-tcb-capture.c
@@ -32,28 +32,16 @@ struct mchp_tc_data {
 	bool trig_inverted;
 };
 
-enum mchp_tc_count_function {
-	MCHP_TC_FUNCTION_INCREASE,
-	MCHP_TC_FUNCTION_QUADRATURE,
+static const u8 mchp_tc_count_functions[] = {
+	COUNTER_COUNT_FUNCTION_INCREASE,
+	COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
 };
 
-static enum counter_count_function mchp_tc_count_functions[] = {
-	[MCHP_TC_FUNCTION_INCREASE] = COUNTER_COUNT_FUNCTION_INCREASE,
-	[MCHP_TC_FUNCTION_QUADRATURE] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
-};
-
-enum mchp_tc_synapse_action {
-	MCHP_TC_SYNAPSE_ACTION_NONE = 0,
-	MCHP_TC_SYNAPSE_ACTION_RISING_EDGE,
-	MCHP_TC_SYNAPSE_ACTION_FALLING_EDGE,
-	MCHP_TC_SYNAPSE_ACTION_BOTH_EDGE
-};
-
-static enum counter_synapse_action mchp_tc_synapse_actions[] = {
-	[MCHP_TC_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
-	[MCHP_TC_SYNAPSE_ACTION_RISING_EDGE] = COUNTER_SYNAPSE_ACTION_RISING_EDGE,
-	[MCHP_TC_SYNAPSE_ACTION_FALLING_EDGE] = COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
-	[MCHP_TC_SYNAPSE_ACTION_BOTH_EDGE] = COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
+static const u8 mchp_tc_synapse_actions[] = {
+	COUNTER_SYNAPSE_ACTION_NONE,
+	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
+	COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
+	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
 };
 
 static struct counter_signal mchp_tc_count_signals[] = {
@@ -80,23 +68,23 @@ static struct counter_synapse mchp_tc_count_synapses[] = {
 	}
 };
 
-static int mchp_tc_count_function_get(struct counter_device *counter,
-				      struct counter_count *count,
-				      size_t *function)
+static int mchp_tc_count_function_read(struct counter_device *counter,
+				       struct counter_count *count,
+				       u8 *function)
 {
 	struct mchp_tc_data *const priv = counter->priv;
 
 	if (priv->qdec_mode)
-		*function = MCHP_TC_FUNCTION_QUADRATURE;
+		*function = COUNTER_COUNT_FUNCTION_QUADRATURE_X4;
 	else
-		*function = MCHP_TC_FUNCTION_INCREASE;
+		*function = COUNTER_COUNT_FUNCTION_INCREASE;
 
 	return 0;
 }
 
-static int mchp_tc_count_function_set(struct counter_device *counter,
-				      struct counter_count *count,
-				      size_t function)
+static int mchp_tc_count_function_write(struct counter_device *counter,
+					struct counter_count *count,
+					u8 function)
 {
 	struct mchp_tc_data *const priv = counter->priv;
 	u32 bmr, cmr;
@@ -108,7 +96,7 @@ static int mchp_tc_count_function_set(struct counter_device *counter,
 	cmr &= ~ATMEL_TC_WAVE;
 
 	switch (function) {
-	case MCHP_TC_FUNCTION_INCREASE:
+	case COUNTER_COUNT_FUNCTION_INCREASE:
 		priv->qdec_mode = 0;
 		/* Set highest rate based on whether soc has gclk or not */
 		bmr &= ~(ATMEL_TC_QDEN | ATMEL_TC_POSEN);
@@ -120,7 +108,7 @@ static int mchp_tc_count_function_set(struct counter_device *counter,
 		cmr |=  ATMEL_TC_CMR_MASK;
 		cmr &= ~(ATMEL_TC_ABETRG | ATMEL_TC_XC0);
 		break;
-	case MCHP_TC_FUNCTION_QUADRATURE:
+	case COUNTER_COUNT_FUNCTION_QUADRATURE_X4:
 		if (!priv->tc_cfg->has_qdec)
 			return -EINVAL;
 		/* In QDEC mode settings both channels 0 and 1 are required */
@@ -154,8 +142,7 @@ static int mchp_tc_count_function_set(struct counter_device *counter,
 }
 
 static int mchp_tc_count_signal_read(struct counter_device *counter,
-				     struct counter_signal *signal,
-				     enum counter_signal_value *val)
+				     struct counter_signal *signal, u8 *val)
 {
 	struct mchp_tc_data *const priv = counter->priv;
 	bool sigstatus;
@@ -173,34 +160,34 @@ static int mchp_tc_count_signal_read(struct counter_device *counter,
 	return 0;
 }
 
-static int mchp_tc_count_action_get(struct counter_device *counter,
-				    struct counter_count *count,
-				    struct counter_synapse *synapse,
-				    size_t *action)
+static int mchp_tc_count_action_read(struct counter_device *counter,
+				     struct counter_count *count,
+				     struct counter_synapse *synapse,
+				     u8 *action)
 {
 	struct mchp_tc_data *const priv = counter->priv;
 	u32 cmr;
 
 	regmap_read(priv->regmap, ATMEL_TC_REG(priv->channel[0], CMR), &cmr);
 
-	*action = MCHP_TC_SYNAPSE_ACTION_NONE;
+	*action = COUNTER_SYNAPSE_ACTION_NONE;
 
 	if (cmr & ATMEL_TC_ETRGEDG_NONE)
-		*action = MCHP_TC_SYNAPSE_ACTION_NONE;
+		*action = COUNTER_SYNAPSE_ACTION_NONE;
 	else if (cmr & ATMEL_TC_ETRGEDG_RISING)
-		*action = MCHP_TC_SYNAPSE_ACTION_RISING_EDGE;
+		*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
 	else if (cmr & ATMEL_TC_ETRGEDG_FALLING)
-		*action = MCHP_TC_SYNAPSE_ACTION_FALLING_EDGE;
+		*action = COUNTER_SYNAPSE_ACTION_FALLING_EDGE;
 	else if (cmr & ATMEL_TC_ETRGEDG_BOTH)
-		*action = MCHP_TC_SYNAPSE_ACTION_BOTH_EDGE;
+		*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
 
 	return 0;
 }
 
-static int mchp_tc_count_action_set(struct counter_device *counter,
-				    struct counter_count *count,
-				    struct counter_synapse *synapse,
-				    size_t action)
+static int mchp_tc_count_action_write(struct counter_device *counter,
+				      struct counter_count *count,
+				      struct counter_synapse *synapse,
+				      u8 action)
 {
 	struct mchp_tc_data *const priv = counter->priv;
 	u32 edge = ATMEL_TC_ETRGEDG_NONE;
@@ -210,16 +197,16 @@ static int mchp_tc_count_action_set(struct counter_device *counter,
 		return -EINVAL;
 
 	switch (action) {
-	case MCHP_TC_SYNAPSE_ACTION_NONE:
+	case COUNTER_SYNAPSE_ACTION_NONE:
 		edge = ATMEL_TC_ETRGEDG_NONE;
 		break;
-	case MCHP_TC_SYNAPSE_ACTION_RISING_EDGE:
+	case COUNTER_SYNAPSE_ACTION_RISING_EDGE:
 		edge = ATMEL_TC_ETRGEDG_RISING;
 		break;
-	case MCHP_TC_SYNAPSE_ACTION_FALLING_EDGE:
+	case COUNTER_SYNAPSE_ACTION_FALLING_EDGE:
 		edge = ATMEL_TC_ETRGEDG_FALLING;
 		break;
-	case MCHP_TC_SYNAPSE_ACTION_BOTH_EDGE:
+	case COUNTER_SYNAPSE_ACTION_BOTH_EDGES:
 		edge = ATMEL_TC_ETRGEDG_BOTH;
 		break;
 	}
@@ -230,8 +217,7 @@ static int mchp_tc_count_action_set(struct counter_device *counter,
 }
 
 static int mchp_tc_count_read(struct counter_device *counter,
-			      struct counter_count *count,
-			      unsigned long *val)
+			      struct counter_count *count, u64 *val)
 {
 	struct mchp_tc_data *const priv = counter->priv;
 	u32 cnt;
@@ -253,15 +239,6 @@ static struct counter_count mchp_tc_counts[] = {
 	},
 };
 
-static struct counter_ops mchp_tc_ops = {
-	.signal_read  = mchp_tc_count_signal_read,
-	.count_read   = mchp_tc_count_read,
-	.function_get = mchp_tc_count_function_get,
-	.function_set = mchp_tc_count_function_set,
-	.action_get   = mchp_tc_count_action_get,
-	.action_set   = mchp_tc_count_action_set
-};
-
 static const struct atmel_tcb_config tcb_rm9200_config = {
 		.counter_width = 16,
 };
@@ -367,7 +344,12 @@ static int mchp_tc_probe(struct platform_device *pdev)
 	priv->regmap = regmap;
 	priv->counter.name = dev_name(&pdev->dev);
 	priv->counter.parent = &pdev->dev;
-	priv->counter.ops = &mchp_tc_ops;
+	priv->counter.signal_read  = mchp_tc_count_signal_read,
+	priv->counter.count_read   = mchp_tc_count_read,
+	priv->counter.function_read = mchp_tc_count_function_read,
+	priv->counter.function_write = mchp_tc_count_function_write,
+	priv->counter.action_read   = mchp_tc_count_action_read,
+	priv->counter.action_write   = mchp_tc_count_action_write
 	priv->counter.num_counts = ARRAY_SIZE(mchp_tc_counts);
 	priv->counter.counts = mchp_tc_counts;
 	priv->counter.num_signals = ARRAY_SIZE(mchp_tc_count_signals);
diff --git a/drivers/counter/stm32-lptimer-cnt.c b/drivers/counter/stm32-lptimer-cnt.c
index fd6828e2d34f..a37c2456d33a 100644
--- a/drivers/counter/stm32-lptimer-cnt.c
+++ b/drivers/counter/stm32-lptimer-cnt.c
@@ -17,6 +17,7 @@
 #include <linux/module.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/types.h>
 
 struct stm32_lptim_cnt {
 	struct counter_device counter;
@@ -352,32 +353,46 @@ static const struct iio_chan_spec stm32_lptim_cnt_channels = {
  * @STM32_LPTIM_ENCODER_BOTH_EDGE: count on both edges (IN1 & IN2 quadrature)
  */
 enum stm32_lptim_cnt_function {
-	STM32_LPTIM_COUNTER_INCREASE,
-	STM32_LPTIM_ENCODER_BOTH_EDGE,
+	STM32_LPTIM_COUNTER_INCREASE = COUNTER_COUNT_FUNCTION_INCREASE,
+	STM32_LPTIM_ENCODER_BOTH_EDGE = COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
 };
 
-static enum counter_count_function stm32_lptim_cnt_functions[] = {
-	[STM32_LPTIM_COUNTER_INCREASE] = COUNTER_COUNT_FUNCTION_INCREASE,
-	[STM32_LPTIM_ENCODER_BOTH_EDGE] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
+static u8 stm32_lptim_cnt_functions[] = {
+	STM32_LPTIM_COUNTER_INCREASE,
+	STM32_LPTIM_ENCODER_BOTH_EDGE,
 };
 
 enum stm32_lptim_synapse_action {
+	/* Index must match with stm32_lptim_cnt_polarity[] (priv->polarity) */
 	STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE,
 	STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE,
 	STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES,
 	STM32_LPTIM_SYNAPSE_ACTION_NONE,
 };
 
-static enum counter_synapse_action stm32_lptim_cnt_synapse_actions[] = {
-	/* Index must match with stm32_lptim_cnt_polarity[] (priv->polarity) */
+static const enum stm32_lptim_synapse_action stm32_lptim_c2l_actions_map[] = {
+	[COUNTER_SYNAPSE_ACTION_RISING_EDGE] = STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE,
+	[COUNTER_SYNAPSE_ACTION_FALLING_EDGE] = STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE,
+	[COUNTER_SYNAPSE_ACTION_BOTH_EDGES] = STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES,
+	[COUNTER_SYNAPSE_ACTION_NONE] = STM32_LPTIM_SYNAPSE_ACTION_NONE,
+};
+
+static const u8 stm32_lptim_l2c_actions_map[] = {
 	[STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE] = COUNTER_SYNAPSE_ACTION_RISING_EDGE,
 	[STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE] = COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
 	[STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES] = COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
 	[STM32_LPTIM_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
 };
 
+static const u8 stm32_lptim_cnt_synapse_actions[] = {
+	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
+	COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
+	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
+	COUNTER_SYNAPSE_ACTION_NONE,
+};
+
 static int stm32_lptim_cnt_read(struct counter_device *counter,
-				struct counter_count *count, unsigned long *val)
+				struct counter_count *count, u64 *val)
 {
 	struct stm32_lptim_cnt *const priv = counter->priv;
 	u32 cnt;
@@ -394,7 +409,7 @@ static int stm32_lptim_cnt_read(struct counter_device *counter,
 
 static int stm32_lptim_cnt_function_get(struct counter_device *counter,
 					struct counter_count *count,
-					size_t *function)
+					u8 *function)
 {
 	struct stm32_lptim_cnt *const priv = counter->priv;
 
@@ -413,7 +428,7 @@ static int stm32_lptim_cnt_function_get(struct counter_device *counter,
 
 static int stm32_lptim_cnt_function_set(struct counter_device *counter,
 					struct counter_count *count,
-					size_t function)
+					u8 function)
 {
 	struct stm32_lptim_cnt *const priv = counter->priv;
 
@@ -423,19 +438,20 @@ static int stm32_lptim_cnt_function_set(struct counter_device *counter,
 	switch (function) {
 	case STM32_LPTIM_COUNTER_INCREASE:
 		priv->quadrature_mode = 0;
-		return 0;
+		break;
 	case STM32_LPTIM_ENCODER_BOTH_EDGE:
 		priv->quadrature_mode = 1;
 		priv->polarity = STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES;
-		return 0;
+		break;
+	default: return -EINVAL;
 	}
 
-	return -EINVAL;
+	return 0;
 }
 
-static ssize_t stm32_lptim_cnt_enable_read(struct counter_device *counter,
-					   struct counter_count *count,
-					   void *private, char *buf)
+static int stm32_lptim_cnt_enable_read(struct counter_device *counter,
+				       struct counter_count *count,
+				       u8 *enable)
 {
 	struct stm32_lptim_cnt *const priv = counter->priv;
 	int ret;
@@ -444,22 +460,18 @@ static ssize_t stm32_lptim_cnt_enable_read(struct counter_device *counter,
 	if (ret < 0)
 		return ret;
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", ret);
+	*enable = ret;
+
+	return 0;
 }
 
-static ssize_t stm32_lptim_cnt_enable_write(struct counter_device *counter,
-					    struct counter_count *count,
-					    void *private,
-					    const char *buf, size_t len)
+static int stm32_lptim_cnt_enable_write(struct counter_device *counter,
+					struct counter_count *count,
+					u8 enable)
 {
 	struct stm32_lptim_cnt *const priv = counter->priv;
-	bool enable;
 	int ret;
 
-	ret = kstrtobool(buf, &enable);
-	if (ret)
-		return ret;
-
 	/* Check nobody uses the timer, or already disabled/enabled */
 	ret = stm32_lptim_is_enabled(priv);
 	if ((ret < 0) || (!ret && !enable))
@@ -475,48 +487,51 @@ static ssize_t stm32_lptim_cnt_enable_write(struct counter_device *counter,
 	if (ret)
 		return ret;
 
-	return len;
+	return 0;
 }
 
-static ssize_t stm32_lptim_cnt_ceiling_read(struct counter_device *counter,
-					    struct counter_count *count,
-					    void *private, char *buf)
+static int stm32_lptim_cnt_ceiling_read(struct counter_device *counter,
+					struct counter_count *count,
+					u64 *ceiling)
 {
 	struct stm32_lptim_cnt *const priv = counter->priv;
 
-	return stm32_lptim_cnt_get_ceiling(priv, buf);
+	*ceiling = priv->ceiling;
+
+	return 0;
 }
 
-static ssize_t stm32_lptim_cnt_ceiling_write(struct counter_device *counter,
-					     struct counter_count *count,
-					     void *private,
-					     const char *buf, size_t len)
+static int stm32_lptim_cnt_ceiling_write(struct counter_device *counter,
+					 struct counter_count *count,
+					 u64 ceiling)
 {
 	struct stm32_lptim_cnt *const priv = counter->priv;
 
-	return stm32_lptim_cnt_set_ceiling(priv, buf, len);
+	if (ceiling > STM32_LPTIM_MAX_ARR)
+		return -EINVAL;
+
+	if (stm32_lptim_is_enabled(priv))
+		return -EBUSY;
+
+	priv->ceiling = ceiling;
+
+	return 0;
 }
 
-static const struct counter_count_ext stm32_lptim_cnt_ext[] = {
-	{
-		.name = "enable",
-		.read = stm32_lptim_cnt_enable_read,
-		.write = stm32_lptim_cnt_enable_write
-	},
-	{
-		.name = "ceiling",
-		.read = stm32_lptim_cnt_ceiling_read,
-		.write = stm32_lptim_cnt_ceiling_write
-	},
+static struct counter_data stm32_lptim_cnt_ext[] = {
+	COUNTER_DATA_ENABLE(stm32_lptim_cnt_enable_read,
+			    stm32_lptim_cnt_enable_write),
+	COUNTER_DATA_CEILING(stm32_lptim_cnt_ceiling_read,
+			     stm32_lptim_cnt_ceiling_write),
 };
 
 static int stm32_lptim_cnt_action_get(struct counter_device *counter,
 				      struct counter_count *count,
 				      struct counter_synapse *synapse,
-				      size_t *action)
+				      u8 *action)
 {
 	struct stm32_lptim_cnt *const priv = counter->priv;
-	size_t function;
+	u8 function;
 	int err;
 
 	err = stm32_lptim_cnt_function_get(counter, count, &function);
@@ -527,25 +542,25 @@ static int stm32_lptim_cnt_action_get(struct counter_device *counter,
 	case STM32_LPTIM_COUNTER_INCREASE:
 		/* LP Timer acts as up-counter on input 1 */
 		if (synapse->signal->id == count->synapses[0].signal->id)
-			*action = priv->polarity;
+			*action = stm32_lptim_l2c_actions_map[priv->polarity];
 		else
-			*action = STM32_LPTIM_SYNAPSE_ACTION_NONE;
-		return 0;
+			*action = COUNTER_SYNAPSE_ACTION_NONE;
+		break;
 	case STM32_LPTIM_ENCODER_BOTH_EDGE:
-		*action = priv->polarity;
-		return 0;
+		*action = stm32_lptim_l2c_actions_map[priv->polarity];
+		break;
 	}
 
-	return -EINVAL;
+	return 0;
 }
 
 static int stm32_lptim_cnt_action_set(struct counter_device *counter,
 				      struct counter_count *count,
 				      struct counter_synapse *synapse,
-				      size_t action)
+				      u8 action)
 {
 	struct stm32_lptim_cnt *const priv = counter->priv;
-	size_t function;
+	u8 function;
 	int err;
 
 	if (stm32_lptim_is_enabled(priv))
@@ -556,27 +571,15 @@ static int stm32_lptim_cnt_action_set(struct counter_device *counter,
 		return err;
 
 	/* only set polarity when in counter mode (on input 1) */
-	if (function == STM32_LPTIM_COUNTER_INCREASE
-	    && synapse->signal->id == count->synapses[0].signal->id) {
-		switch (action) {
-		case STM32_LPTIM_SYNAPSE_ACTION_RISING_EDGE:
-		case STM32_LPTIM_SYNAPSE_ACTION_FALLING_EDGE:
-		case STM32_LPTIM_SYNAPSE_ACTION_BOTH_EDGES:
-			priv->polarity = action;
-			return 0;
-		}
-	}
+	if (function != STM32_LPTIM_COUNTER_INCREASE
+	    || synapse->signal->id != count->synapses[0].signal->id
+	    || action == COUNTER_SYNAPSE_ACTION_NONE)
+		return -EINVAL;
 
-	return -EINVAL;
-}
+	priv->polarity = stm32_lptim_c2l_actions_map[action];
 
-static const struct counter_ops stm32_lptim_cnt_ops = {
-	.count_read = stm32_lptim_cnt_read,
-	.function_get = stm32_lptim_cnt_function_get,
-	.function_set = stm32_lptim_cnt_function_set,
-	.action_get = stm32_lptim_cnt_action_get,
-	.action_set = stm32_lptim_cnt_action_set,
-};
+	return 0;
+}
 
 static struct counter_signal stm32_lptim_cnt_signals[] = {
 	{
@@ -659,7 +662,11 @@ static int stm32_lptim_cnt_probe(struct platform_device *pdev)
 	/* Initialize Counter device */
 	priv->counter.name = dev_name(&pdev->dev);
 	priv->counter.parent = &pdev->dev;
-	priv->counter.ops = &stm32_lptim_cnt_ops;
+	priv->counter.count_read = stm32_lptim_cnt_read;
+	priv->counter.function_read = stm32_lptim_cnt_function_get;
+	priv->counter.function_write = stm32_lptim_cnt_function_set;
+	priv->counter.action_read = stm32_lptim_cnt_action_get;
+	priv->counter.action_write = stm32_lptim_cnt_action_set;
 	if (ddata->has_encoder) {
 		priv->counter.counts = &stm32_lptim_enc_counts;
 		priv->counter.num_signals = ARRAY_SIZE(stm32_lptim_cnt_signals);
diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-timer-cnt.c
index ef2a974a2f10..502e525836a9 100644
--- a/drivers/counter/stm32-timer-cnt.c
+++ b/drivers/counter/stm32-timer-cnt.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
+#include <linux/types.h>
 
 #define TIM_CCMR_CCXS	(BIT(8) | BIT(0))
 #define TIM_CCMR_MASK	(TIM_CCMR_CC1S | TIM_CCMR_CC2S | \
@@ -45,19 +46,19 @@ struct stm32_timer_cnt {
  */
 enum stm32_count_function {
 	STM32_COUNT_SLAVE_MODE_DISABLED = -1,
+	STM32_COUNT_ENCODER_MODE_1 = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
+	STM32_COUNT_ENCODER_MODE_2 = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B,
+	STM32_COUNT_ENCODER_MODE_3 = COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
+};
+
+static const u8 stm32_count_functions[] = {
 	STM32_COUNT_ENCODER_MODE_1,
 	STM32_COUNT_ENCODER_MODE_2,
 	STM32_COUNT_ENCODER_MODE_3,
 };
 
-static enum counter_count_function stm32_count_functions[] = {
-	[STM32_COUNT_ENCODER_MODE_1] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
-	[STM32_COUNT_ENCODER_MODE_2] = COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B,
-	[STM32_COUNT_ENCODER_MODE_3] = COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
-};
-
 static int stm32_count_read(struct counter_device *counter,
-			    struct counter_count *count, unsigned long *val)
+			    struct counter_count *count, u64 *val)
 {
 	struct stm32_timer_cnt *const priv = counter->priv;
 	u32 cnt;
@@ -69,8 +70,7 @@ static int stm32_count_read(struct counter_device *counter,
 }
 
 static int stm32_count_write(struct counter_device *counter,
-			     struct counter_count *count,
-			     const unsigned long val)
+			     struct counter_count *count, const u64 val)
 {
 	struct stm32_timer_cnt *const priv = counter->priv;
 
@@ -81,8 +81,7 @@ static int stm32_count_write(struct counter_device *counter,
 }
 
 static int stm32_count_function_get(struct counter_device *counter,
-				    struct counter_count *count,
-				    size_t *function)
+				    struct counter_count *count, u8 *function)
 {
 	struct stm32_timer_cnt *const priv = counter->priv;
 	u32 smcr;
@@ -105,8 +104,7 @@ static int stm32_count_function_get(struct counter_device *counter,
 }
 
 static int stm32_count_function_set(struct counter_device *counter,
-				    struct counter_count *count,
-				    size_t function)
+				    struct counter_count *count, u8 function)
 {
 	struct stm32_timer_cnt *const priv = counter->priv;
 	u32 cr1, sms;
@@ -146,78 +144,67 @@ static int stm32_count_function_set(struct counter_device *counter,
 	return 0;
 }
 
-static ssize_t stm32_count_direction_read(struct counter_device *counter,
+static int stm32_count_direction_read(struct counter_device *counter,
 				      struct counter_count *count,
-				      void *private, char *buf)
+				      u8 *direction)
 {
 	struct stm32_timer_cnt *const priv = counter->priv;
-	const char *direction;
 	u32 cr1;
 
 	regmap_read(priv->regmap, TIM_CR1, &cr1);
-	direction = (cr1 & TIM_CR1_DIR) ? "backward" : "forward";
+	*direction = (cr1 & TIM_CR1_DIR) ? COUNTER_COUNT_DIRECTION_BACKWARD :
+		COUNTER_COUNT_DIRECTION_FORWARD;
 
-	return scnprintf(buf, PAGE_SIZE, "%s\n", direction);
+	return 0;
 }
 
-static ssize_t stm32_count_ceiling_read(struct counter_device *counter,
-					struct counter_count *count,
-					void *private, char *buf)
+static int stm32_count_ceiling_read(struct counter_device *counter,
+				    struct counter_count *count, u64 *ceiling)
 {
 	struct stm32_timer_cnt *const priv = counter->priv;
 	u32 arr;
 
 	regmap_read(priv->regmap, TIM_ARR, &arr);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", arr);
+	*ceiling = arr;
+
+	return 0;
 }
 
-static ssize_t stm32_count_ceiling_write(struct counter_device *counter,
-					 struct counter_count *count,
-					 void *private,
-					 const char *buf, size_t len)
+static int stm32_count_ceiling_write(struct counter_device *counter,
+				     struct counter_count *count, u64 ceiling)
 {
 	struct stm32_timer_cnt *const priv = counter->priv;
-	unsigned int ceiling;
-	int ret;
 
-	ret = kstrtouint(buf, 0, &ceiling);
-	if (ret)
-		return ret;
+	if (ceiling != (u32)ceiling)
+		return -ERANGE;
 
 	/* TIMx_ARR register shouldn't be buffered (ARPE=0) */
 	regmap_update_bits(priv->regmap, TIM_CR1, TIM_CR1_ARPE, 0);
 	regmap_write(priv->regmap, TIM_ARR, ceiling);
 
 	priv->ceiling = ceiling;
-	return len;
+	return 0;
 }
 
-static ssize_t stm32_count_enable_read(struct counter_device *counter,
-				       struct counter_count *count,
-				       void *private, char *buf)
+static int stm32_count_enable_read(struct counter_device *counter,
+				   struct counter_count *count, u8 *enable)
 {
 	struct stm32_timer_cnt *const priv = counter->priv;
 	u32 cr1;
 
 	regmap_read(priv->regmap, TIM_CR1, &cr1);
 
-	return scnprintf(buf, PAGE_SIZE, "%d\n", (bool)(cr1 & TIM_CR1_CEN));
+	*enable = cr1 & TIM_CR1_CEN;
+
+	return 0;
 }
 
-static ssize_t stm32_count_enable_write(struct counter_device *counter,
-					struct counter_count *count,
-					void *private,
-					const char *buf, size_t len)
+static int stm32_count_enable_write(struct counter_device *counter,
+				    struct counter_count *count, u8 enable)
 {
 	struct stm32_timer_cnt *const priv = counter->priv;
-	int err;
 	u32 cr1;
-	bool enable;
-
-	err = kstrtobool(buf, &enable);
-	if (err)
-		return err;
 
 	if (enable) {
 		regmap_read(priv->regmap, TIM_CR1, &cr1);
@@ -236,46 +223,30 @@ static ssize_t stm32_count_enable_write(struct counter_device *counter,
 	/* Keep enabled state to properly handle low power states */
 	priv->enabled = enable;
 
-	return len;
+	return 0;
 }
 
-static const struct counter_count_ext stm32_count_ext[] = {
-	{
-		.name = "direction",
-		.read = stm32_count_direction_read,
-	},
-	{
-		.name = "enable",
-		.read = stm32_count_enable_read,
-		.write = stm32_count_enable_write
-	},
-	{
-		.name = "ceiling",
-		.read = stm32_count_ceiling_read,
-		.write = stm32_count_ceiling_write
-	},
-};
-
-enum stm32_synapse_action {
-	STM32_SYNAPSE_ACTION_NONE,
-	STM32_SYNAPSE_ACTION_BOTH_EDGES
+static struct counter_data stm32_count_ext[] = {
+	COUNTER_DATA_DIRECTION(stm32_count_direction_read),
+	COUNTER_DATA_ENABLE(stm32_count_enable_read, stm32_count_enable_write),
+	COUNTER_DATA_CEILING(stm32_count_ceiling_read,
+			     stm32_count_ceiling_write),
 };
 
-static enum counter_synapse_action stm32_synapse_actions[] = {
-	[STM32_SYNAPSE_ACTION_NONE] = COUNTER_SYNAPSE_ACTION_NONE,
-	[STM32_SYNAPSE_ACTION_BOTH_EDGES] = COUNTER_SYNAPSE_ACTION_BOTH_EDGES
+static const u8 stm32_synapse_actions[] = {
+	COUNTER_SYNAPSE_ACTION_NONE,
+	COUNTER_SYNAPSE_ACTION_BOTH_EDGES
 };
 
 static int stm32_action_get(struct counter_device *counter,
 			    struct counter_count *count,
-			    struct counter_synapse *synapse,
-			    size_t *action)
+			    struct counter_synapse *synapse, u8 *action)
 {
-	size_t function;
+	u8 function;
 	int err;
 
 	/* Default action mode (e.g. STM32_COUNT_SLAVE_MODE_DISABLED) */
-	*action = STM32_SYNAPSE_ACTION_NONE;
+	*action = COUNTER_SYNAPSE_ACTION_NONE;
 
 	err = stm32_count_function_get(counter, count, &function);
 	if (err)
@@ -285,30 +256,22 @@ static int stm32_action_get(struct counter_device *counter,
 	case STM32_COUNT_ENCODER_MODE_1:
 		/* counts up/down on TI1FP1 edge depending on TI2FP2 level */
 		if (synapse->signal->id == count->synapses[0].signal->id)
-			*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
+			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
 		break;
 	case STM32_COUNT_ENCODER_MODE_2:
 		/* counts up/down on TI2FP2 edge depending on TI1FP1 level */
 		if (synapse->signal->id == count->synapses[1].signal->id)
-			*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
+			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
 		break;
 	case STM32_COUNT_ENCODER_MODE_3:
 		/* counts up/down on both TI1FP1 and TI2FP2 edges */
-		*action = STM32_SYNAPSE_ACTION_BOTH_EDGES;
+		*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
 		break;
 	}
 
 	return 0;
 }
 
-static const struct counter_ops stm32_timer_cnt_ops = {
-	.count_read = stm32_count_read,
-	.count_write = stm32_count_write,
-	.function_get = stm32_count_function_get,
-	.function_set = stm32_count_function_set,
-	.action_get = stm32_action_get,
-};
-
 static struct counter_signal stm32_signals[] = {
 	{
 		.id = 0,
@@ -363,7 +326,11 @@ static int stm32_timer_cnt_probe(struct platform_device *pdev)
 
 	priv->counter.name = dev_name(dev);
 	priv->counter.parent = dev;
-	priv->counter.ops = &stm32_timer_cnt_ops;
+	priv->counter.count_read = stm32_count_read;
+	priv->counter.count_write = stm32_count_write;
+	priv->counter.function_read = stm32_count_function_get;
+	priv->counter.function_write = stm32_count_function_set;
+	priv->counter.action_read = stm32_action_get;
 	priv->counter.counts = &stm32_counts;
 	priv->counter.num_counts = 1;
 	priv->counter.signals = stm32_signals;
diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 1ff07faef27f..7152f0b3c2de 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
+#include <linux/types.h>
 
 /* 32-bit registers */
 #define QPOSCNT		0x0
@@ -80,12 +81,6 @@ enum {
 	TI_EQEP_COUNT_FUNC_DOWN_COUNT,
 };
 
-enum {
-	TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES,
-	TI_EQEP_SYNAPSE_ACTION_RISING_EDGE,
-	TI_EQEP_SYNAPSE_ACTION_NONE,
-};
-
 struct ti_eqep_cnt {
 	struct counter_device counter;
 	struct regmap *regmap32;
@@ -93,7 +88,7 @@ struct ti_eqep_cnt {
 };
 
 static int ti_eqep_count_read(struct counter_device *counter,
-			      struct counter_count *count, unsigned long *val)
+			      struct counter_count *count, u64 *val)
 {
 	struct ti_eqep_cnt *priv = counter->priv;
 	u32 cnt;
@@ -105,7 +100,7 @@ static int ti_eqep_count_read(struct counter_device *counter,
 }
 
 static int ti_eqep_count_write(struct counter_device *counter,
-			       struct counter_count *count, unsigned long val)
+			       struct counter_count *count, u64 val)
 {
 	struct ti_eqep_cnt *priv = counter->priv;
 	u32 max;
@@ -117,33 +112,66 @@ static int ti_eqep_count_write(struct counter_device *counter,
 	return regmap_write(priv->regmap32, QPOSCNT, val);
 }
 
+static const u8 ti_qep_t2c_functions_map[] = {
+};
+
 static int ti_eqep_function_get(struct counter_device *counter,
-				struct counter_count *count, size_t *function)
+				struct counter_count *count, u8 *function)
 {
 	struct ti_eqep_cnt *priv = counter->priv;
 	u32 qdecctl;
 
 	regmap_read(priv->regmap16, QDECCTL, &qdecctl);
-	*function = (qdecctl & QDECCTL_QSRC) >> QDECCTL_QSRC_SHIFT;
+
+	switch ((qdecctl & QDECCTL_QSRC) >> QDECCTL_QSRC_SHIFT) {
+	case TI_EQEP_COUNT_FUNC_QUAD_COUNT:
+		*function = COUNTER_COUNT_FUNCTION_QUADRATURE_X4;
+		break;
+	case TI_EQEP_COUNT_FUNC_DIR_COUNT:
+		*function = COUNTER_COUNT_FUNCTION_PULSE_DIRECTION;
+		break;
+	case TI_EQEP_COUNT_FUNC_UP_COUNT:
+		*function = COUNTER_COUNT_FUNCTION_INCREASE;
+		break;
+	case TI_EQEP_COUNT_FUNC_DOWN_COUNT:
+		*function = COUNTER_COUNT_FUNCTION_DECREASE;
+		break;
+	}
 
 	return 0;
 }
 
 static int ti_eqep_function_set(struct counter_device *counter,
-				struct counter_count *count, size_t function)
+				struct counter_count *count, u8 function)
 {
 	struct ti_eqep_cnt *priv = counter->priv;
+	unsigned long qsrc;
+
+	switch (function) {
+	case COUNTER_COUNT_FUNCTION_QUADRATURE_X4:
+		qsrc = TI_EQEP_COUNT_FUNC_QUAD_COUNT;
+		break;
+	case COUNTER_COUNT_FUNCTION_PULSE_DIRECTION:
+		qsrc = TI_EQEP_COUNT_FUNC_DIR_COUNT;
+		break;
+	case COUNTER_COUNT_FUNCTION_INCREASE:
+		qsrc = TI_EQEP_COUNT_FUNC_UP_COUNT;
+		break;
+	case COUNTER_COUNT_FUNCTION_DECREASE:
+		qsrc = TI_EQEP_COUNT_FUNC_DOWN_COUNT;
+		break;
+	}
 
 	return regmap_write_bits(priv->regmap16, QDECCTL, QDECCTL_QSRC,
-				 function << QDECCTL_QSRC_SHIFT);
+				 qsrc << QDECCTL_QSRC_SHIFT);
 }
 
 static int ti_eqep_action_get(struct counter_device *counter,
 			      struct counter_count *count,
-			      struct counter_synapse *synapse, size_t *action)
+			      struct counter_synapse *synapse, u8 *action)
 {
 	struct ti_eqep_cnt *priv = counter->priv;
-	size_t function;
+	u8 function;
 	u32 qdecctl;
 	int err;
 
@@ -152,27 +180,27 @@ static int ti_eqep_action_get(struct counter_device *counter,
 		return err;
 
 	switch (function) {
-	case TI_EQEP_COUNT_FUNC_QUAD_COUNT:
+	case COUNTER_COUNT_FUNCTION_QUADRATURE_X4:
 		/* In quadrature mode, the rising and falling edge of both
 		 * QEPA and QEPB trigger QCLK.
 		 */
-		*action = TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES;
+		*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
 		break;
-	case TI_EQEP_COUNT_FUNC_DIR_COUNT:
+	case COUNTER_COUNT_FUNCTION_PULSE_DIRECTION:
 		/* In direction-count mode only rising edge of QEPA is counted
 		 * and QEPB gives direction.
 		 */
 		switch (synapse->signal->id) {
 		case TI_EQEP_SIGNAL_QEPA:
-			*action = TI_EQEP_SYNAPSE_ACTION_RISING_EDGE;
+			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
 			break;
 		default:
-			*action = TI_EQEP_SYNAPSE_ACTION_NONE;
+			*action = COUNTER_SYNAPSE_ACTION_NONE;
 			break;
 		}
 		break;
-	case TI_EQEP_COUNT_FUNC_UP_COUNT:
-	case TI_EQEP_COUNT_FUNC_DOWN_COUNT:
+	case COUNTER_COUNT_FUNCTION_INCREASE:
+	case COUNTER_COUNT_FUNCTION_DECREASE:
 		/* In up/down-count modes only QEPA is counted and QEPB is not
 		 * used.
 		 */
@@ -183,134 +211,105 @@ static int ti_eqep_action_get(struct counter_device *counter,
 				return err;
 
 			if (qdecctl & QDECCTL_XCR)
-				*action = TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES;
+				*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
 			else
-				*action = TI_EQEP_SYNAPSE_ACTION_RISING_EDGE;
+				*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
 			break;
 		default:
-			*action = TI_EQEP_SYNAPSE_ACTION_NONE;
+			*action = COUNTER_SYNAPSE_ACTION_NONE;
 			break;
 		}
 		break;
+	default: return -EINVAL;
 	}
 
 	return 0;
 }
 
-static const struct counter_ops ti_eqep_counter_ops = {
-	.count_read	= ti_eqep_count_read,
-	.count_write	= ti_eqep_count_write,
-	.function_get	= ti_eqep_function_get,
-	.function_set	= ti_eqep_function_set,
-	.action_get	= ti_eqep_action_get,
-};
-
-static ssize_t ti_eqep_position_ceiling_read(struct counter_device *counter,
-					     struct counter_count *count,
-					     void *ext_priv, char *buf)
+static int ti_eqep_position_ceiling_read(struct counter_device *counter,
+					 struct counter_count *count,
+					 u64 *ceiling)
 {
 	struct ti_eqep_cnt *priv = counter->priv;
 	u32 qposmax;
 
 	regmap_read(priv->regmap32, QPOSMAX, &qposmax);
 
-	return sprintf(buf, "%u\n", qposmax);
+	*ceiling = qposmax;
+
+	return 0;
 }
 
-static ssize_t ti_eqep_position_ceiling_write(struct counter_device *counter,
-					      struct counter_count *count,
-					      void *ext_priv, const char *buf,
-					      size_t len)
+static int ti_eqep_position_ceiling_write(struct counter_device *counter,
+					  struct counter_count *count,
+					  u64 ceiling)
 {
 	struct ti_eqep_cnt *priv = counter->priv;
-	int err;
-	u32 res;
 
-	err = kstrtouint(buf, 0, &res);
-	if (err < 0)
-		return err;
+	if (ceiling != (u32)ceiling)
+		return -ERANGE;
 
-	regmap_write(priv->regmap32, QPOSMAX, res);
+	regmap_write(priv->regmap32, QPOSMAX, ceiling);
 
-	return len;
+	return 0;
 }
 
-static ssize_t ti_eqep_position_floor_read(struct counter_device *counter,
-					   struct counter_count *count,
-					   void *ext_priv, char *buf)
+static int ti_eqep_position_floor_read(struct counter_device *counter,
+				       struct counter_count *count, u64 *floor)
 {
 	struct ti_eqep_cnt *priv = counter->priv;
 	u32 qposinit;
 
 	regmap_read(priv->regmap32, QPOSINIT, &qposinit);
 
-	return sprintf(buf, "%u\n", qposinit);
+	*floor = qposinit;
+
+	return 0;
 }
 
-static ssize_t ti_eqep_position_floor_write(struct counter_device *counter,
-					    struct counter_count *count,
-					    void *ext_priv, const char *buf,
-					    size_t len)
+static int ti_eqep_position_floor_write(struct counter_device *counter,
+					struct counter_count *count, u64 floor)
 {
 	struct ti_eqep_cnt *priv = counter->priv;
-	int err;
-	u32 res;
 
-	err = kstrtouint(buf, 0, &res);
-	if (err < 0)
-		return err;
+	if (floor != (u32)floor)
+		return -ERANGE;
 
-	regmap_write(priv->regmap32, QPOSINIT, res);
+	regmap_write(priv->regmap32, QPOSINIT, floor);
 
-	return len;
+	return 0;
 }
 
-static ssize_t ti_eqep_position_enable_read(struct counter_device *counter,
-					    struct counter_count *count,
-					    void *ext_priv, char *buf)
+static int ti_eqep_position_enable_read(struct counter_device *counter,
+					struct counter_count *count, u8 *enable)
 {
 	struct ti_eqep_cnt *priv = counter->priv;
 	u32 qepctl;
 
 	regmap_read(priv->regmap16, QEPCTL, &qepctl);
 
-	return sprintf(buf, "%u\n", !!(qepctl & QEPCTL_PHEN));
+	*enable = !!(qepctl & QEPCTL_PHEN);
+
+	return 0;
 }
 
-static ssize_t ti_eqep_position_enable_write(struct counter_device *counter,
-					     struct counter_count *count,
-					     void *ext_priv, const char *buf,
-					     size_t len)
+static int ti_eqep_position_enable_write(struct counter_device *counter,
+					 struct counter_count *count, u8 enable)
 {
 	struct ti_eqep_cnt *priv = counter->priv;
-	int err;
-	bool res;
 
-	err = kstrtobool(buf, &res);
-	if (err < 0)
-		return err;
-
-	regmap_write_bits(priv->regmap16, QEPCTL, QEPCTL_PHEN, res ? -1 : 0);
+	regmap_write_bits(priv->regmap16, QEPCTL, QEPCTL_PHEN, enable ? -1 : 0);
 
-	return len;
+	return 0;
 }
 
-static struct counter_count_ext ti_eqep_position_ext[] = {
-	{
-		.name	= "ceiling",
-		.read	= ti_eqep_position_ceiling_read,
-		.write	= ti_eqep_position_ceiling_write,
-	},
-	{
-		.name	= "floor",
-		.read	= ti_eqep_position_floor_read,
-		.write	= ti_eqep_position_floor_write,
-	},
-	{
-		.name	= "enable",
-		.read	= ti_eqep_position_enable_read,
-		.write	= ti_eqep_position_enable_write,
-	},
+static struct counter_data ti_eqep_position_ext[] = {
+	COUNTER_DATA_CEILING(ti_eqep_position_ceiling_read,
+			     ti_eqep_position_ceiling_write),
+	COUNTER_DATA_FLOOR(ti_eqep_position_floor_read,
+			   ti_eqep_position_floor_write),
+	COUNTER_DATA_ENABLE(ti_eqep_position_enable_read,
+			    ti_eqep_position_enable_write),
 };
 
 static struct counter_signal ti_eqep_signals[] = {
@@ -324,17 +323,17 @@ static struct counter_signal ti_eqep_signals[] = {
 	},
 };
 
-static const enum counter_count_function ti_eqep_position_functions[] = {
-	[TI_EQEP_COUNT_FUNC_QUAD_COUNT]	= COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
-	[TI_EQEP_COUNT_FUNC_DIR_COUNT]	= COUNTER_COUNT_FUNCTION_PULSE_DIRECTION,
-	[TI_EQEP_COUNT_FUNC_UP_COUNT]	= COUNTER_COUNT_FUNCTION_INCREASE,
-	[TI_EQEP_COUNT_FUNC_DOWN_COUNT]	= COUNTER_COUNT_FUNCTION_DECREASE,
+static const u8 ti_eqep_position_functions[] = {
+	COUNTER_COUNT_FUNCTION_QUADRATURE_X4,
+	COUNTER_COUNT_FUNCTION_PULSE_DIRECTION,
+	COUNTER_COUNT_FUNCTION_INCREASE,
+	COUNTER_COUNT_FUNCTION_DECREASE,
 };
 
-static const enum counter_synapse_action ti_eqep_position_synapse_actions[] = {
-	[TI_EQEP_SYNAPSE_ACTION_BOTH_EDGES]	= COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
-	[TI_EQEP_SYNAPSE_ACTION_RISING_EDGE]	= COUNTER_SYNAPSE_ACTION_RISING_EDGE,
-	[TI_EQEP_SYNAPSE_ACTION_NONE]		= COUNTER_SYNAPSE_ACTION_NONE,
+static const u8 ti_eqep_position_synapse_actions[] = {
+	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
+	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
+	COUNTER_SYNAPSE_ACTION_NONE,
 };
 
 static struct counter_synapse ti_eqep_position_synapses[] = {
@@ -406,7 +405,11 @@ static int ti_eqep_probe(struct platform_device *pdev)
 
 	priv->counter.name = dev_name(dev);
 	priv->counter.parent = dev;
-	priv->counter.ops = &ti_eqep_counter_ops;
+	priv->counter.count_read = ti_eqep_count_read;
+	priv->counter.count_write = ti_eqep_count_write;
+	priv->counter.function_read = ti_eqep_function_get;
+	priv->counter.function_write = ti_eqep_function_set;
+	priv->counter.action_read = ti_eqep_action_get;
 	priv->counter.counts = ti_eqep_counts;
 	priv->counter.num_counts = ARRAY_SIZE(ti_eqep_counts);
 	priv->counter.signals = ti_eqep_signals;
diff --git a/include/linux/counter.h b/include/linux/counter.h
index 9dbd5df4cd34..76657d203a26 100644
--- a/include/linux/counter.h
+++ b/include/linux/counter.h
@@ -6,418 +6,157 @@
 #ifndef _COUNTER_H_
 #define _COUNTER_H_
 
-#include <linux/counter_enum.h>
 #include <linux/device.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
 #include <linux/types.h>
-
-enum counter_count_direction {
-	COUNTER_COUNT_DIRECTION_FORWARD = 0,
-	COUNTER_COUNT_DIRECTION_BACKWARD
-};
-extern const char *const counter_count_direction_str[2];
-
-enum counter_count_mode {
-	COUNTER_COUNT_MODE_NORMAL = 0,
-	COUNTER_COUNT_MODE_RANGE_LIMIT,
-	COUNTER_COUNT_MODE_NON_RECYCLE,
-	COUNTER_COUNT_MODE_MODULO_N
-};
-extern const char *const counter_count_mode_str[4];
+#include <uapi/linux/counter.h>
 
 struct counter_device;
+struct counter_count;
+struct counter_synapse;
 struct counter_signal;
 
-/**
- * struct counter_signal_ext - Counter Signal extensions
- * @name:	attribute name
- * @read:	read callback for this attribute; may be NULL
- * @write:	write callback for this attribute; may be NULL
- * @priv:	data private to the driver
- */
-struct counter_signal_ext {
+enum counter_data_type {
+	COUNTER_DATA_TYPE_U8,
+	COUNTER_DATA_TYPE_U64,
+	COUNTER_DATA_TYPE_BOOL,
+	COUNTER_DATA_TYPE_SIGNAL,
+	COUNTER_DATA_TYPE_COUNT_FUNCTION,
+	COUNTER_DATA_TYPE_SYNAPSE_ACTION,
+	COUNTER_DATA_TYPE_ENUM,
+	COUNTER_DATA_TYPE_COUNT_DIRECTION,
+	COUNTER_DATA_TYPE_COUNT_MODE,
+};
+
+struct counter_data {
+	enum counter_data_type type;
 	const char *name;
-	ssize_t (*read)(struct counter_device *counter,
-			struct counter_signal *signal, void *priv, char *buf);
-	ssize_t (*write)(struct counter_device *counter,
-			 struct counter_signal *signal, void *priv,
-			 const char *buf, size_t len);
 	void *priv;
+	union {
+		int (*action_read)(struct counter_device *counter,
+				   struct counter_count *count,
+				   struct counter_synapse *synapse, u8 *action);
+		int (*device_u8_read)(struct counter_device *counter, u8 *val);
+		int (*count_u8_read)(struct counter_device *counter,
+				     struct counter_count *count, u8 *val);
+		int (*signal_u8_read)(struct counter_device *counter,
+				      struct counter_signal *signal, u8 *val);
+		int (*device_u64_read)(struct counter_device *counter,
+				       u64 *val);
+		int (*count_u64_read)(struct counter_device *counter,
+				      struct counter_count *count, u64 *val);
+		int (*signal_u64_read)(struct counter_device *counter,
+				       struct counter_signal *signal, u64 *val);
+	};
+	union {
+		int (*action_write)(struct counter_device *counter,
+				    struct counter_count *count,
+				    struct counter_synapse *synapse, u8 action);
+		int (*device_u8_write)(struct counter_device *counter, u8 val);
+		int (*count_u8_write)(struct counter_device *counter,
+				      struct counter_count *count, u8 val);
+		int (*signal_u8_write)(struct counter_device *counter,
+				       struct counter_signal *signal, u8 val);
+		int (*device_u64_write)(struct counter_device *counter,
+					u64 val);
+		int (*count_u64_write)(struct counter_device *counter,
+				       struct counter_count *count, u64 val);
+		int (*signal_u64_write)(struct counter_device *counter,
+					struct counter_signal *signal, u64 val);
+	};
 };
 
 /**
  * struct counter_signal - Counter Signal node
- * @id:		unique ID used to identify signal
- * @name:	device-specific Signal name; ideally, this should match the name
- *		as it appears in the datasheet documentation
- * @ext:	optional array of Counter Signal extensions
- * @num_ext:	number of Counter Signal extensions specified in @ext
- * @priv:	optional private data supplied by driver
+ * @id:		unique ID used to identify the Signal
+ * @name:	device-specific Signal name
+ * @ext:	optional array of Signal extensions
+ * @num_ext:	number of Signal extensions specified in @ext
  */
 struct counter_signal {
 	int id;
 	const char *name;
 
-	const struct counter_signal_ext *ext;
+	struct counter_data *ext;
 	size_t num_ext;
-
-	void *priv;
-};
-
-/**
- * struct counter_signal_enum_ext - Signal enum extension attribute
- * @items:	Array of strings
- * @num_items:	Number of items specified in @items
- * @set:	Set callback function; may be NULL
- * @get:	Get callback function; may be NULL
- *
- * The counter_signal_enum_ext structure can be used to implement enum style
- * Signal extension attributes. Enum style attributes are those which have a set
- * of strings that map to unsigned integer values. The Generic Counter Signal
- * enum extension helper code takes care of mapping between value and string, as
- * well as generating a "_available" file which contains a list of all available
- * items. The get callback is used to query the currently active item; the index
- * of the item within the respective items array is returned via the 'item'
- * parameter. The set callback is called when the attribute is updated; the
- * 'item' parameter contains the index of the newly activated item within the
- * respective items array.
- */
-struct counter_signal_enum_ext {
-	const char * const *items;
-	size_t num_items;
-	int (*get)(struct counter_device *counter,
-		   struct counter_signal *signal, size_t *item);
-	int (*set)(struct counter_device *counter,
-		   struct counter_signal *signal, size_t item);
-};
-
-/**
- * COUNTER_SIGNAL_ENUM() - Initialize Signal enum extension
- * @_name:	Attribute name
- * @_e:		Pointer to a counter_signal_enum_ext structure
- *
- * This should usually be used together with COUNTER_SIGNAL_ENUM_AVAILABLE()
- */
-#define COUNTER_SIGNAL_ENUM(_name, _e) \
-{ \
-	.name = (_name), \
-	.read = counter_signal_enum_read, \
-	.write = counter_signal_enum_write, \
-	.priv = (_e) \
-}
-
-/**
- * COUNTER_SIGNAL_ENUM_AVAILABLE() - Initialize Signal enum available extension
- * @_name:	Attribute name ("_available" will be appended to the name)
- * @_e:		Pointer to a counter_signal_enum_ext structure
- *
- * Creates a read only attribute that lists all the available enum items in a
- * newline separated list. This should usually be used together with
- * COUNTER_SIGNAL_ENUM()
- */
-#define COUNTER_SIGNAL_ENUM_AVAILABLE(_name, _e) \
-{ \
-	.name = (_name "_available"), \
-	.read = counter_signal_enum_available_read, \
-	.priv = (_e) \
-}
-
-enum counter_synapse_action {
-	COUNTER_SYNAPSE_ACTION_NONE = 0,
-	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
-	COUNTER_SYNAPSE_ACTION_FALLING_EDGE,
-	COUNTER_SYNAPSE_ACTION_BOTH_EDGES
 };
 
 /**
  * struct counter_synapse - Counter Synapse node
- * @action:		index of current action mode
  * @actions_list:	array of available action modes
  * @num_actions:	number of action modes specified in @actions_list
- * @signal:		pointer to associated signal
+ * @signal:		pointer to the associated Signal
  */
 struct counter_synapse {
-	size_t action;
-	const enum counter_synapse_action *actions_list;
+	const u8 *actions_list;
 	size_t num_actions;
 
 	struct counter_signal *signal;
 };
 
-struct counter_count;
-
-/**
- * struct counter_count_ext - Counter Count extension
- * @name:	attribute name
- * @read:	read callback for this attribute; may be NULL
- * @write:	write callback for this attribute; may be NULL
- * @priv:	data private to the driver
- */
-struct counter_count_ext {
-	const char *name;
-	ssize_t (*read)(struct counter_device *counter,
-			struct counter_count *count, void *priv, char *buf);
-	ssize_t (*write)(struct counter_device *counter,
-			 struct counter_count *count, void *priv,
-			 const char *buf, size_t len);
-	void *priv;
-};
-
-enum counter_count_function {
-	COUNTER_COUNT_FUNCTION_INCREASE = 0,
-	COUNTER_COUNT_FUNCTION_DECREASE,
-	COUNTER_COUNT_FUNCTION_PULSE_DIRECTION,
-	COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A,
-	COUNTER_COUNT_FUNCTION_QUADRATURE_X1_B,
-	COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A,
-	COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B,
-	COUNTER_COUNT_FUNCTION_QUADRATURE_X4
-};
-
 /**
  * struct counter_count - Counter Count node
- * @id:			unique ID used to identify Count
- * @name:		device-specific Count name; ideally, this should match
- *			the name as it appears in the datasheet documentation
- * @function:		index of current function mode
- * @functions_list:	array available function modes
+ * @id:			unique ID used to identify the Count
+ * @name:		device-specific Count name
+ * @functions_list:	array of available function modes
  * @num_functions:	number of function modes specified in @functions_list
- * @synapses:		array of synapses for initialization
- * @num_synapses:	number of synapses specified in @synapses
- * @ext:		optional array of Counter Count extensions
- * @num_ext:		number of Counter Count extensions specified in @ext
- * @priv:		optional private data supplied by driver
+ * @synapses:		array of Synapses for initialization
+ * @num_synapses:	number of Synapses specified in @synapses
+ * @ext:		optional array of Count extensions
+ * @num_ext:		number of Count extensions specified in @ext
  */
 struct counter_count {
 	int id;
 	const char *name;
 
-	size_t function;
-	const enum counter_count_function *functions_list;
+	const u8 *functions_list;
 	size_t num_functions;
 
 	struct counter_synapse *synapses;
 	size_t num_synapses;
 
-	const struct counter_count_ext *ext;
+	struct counter_data *ext;
 	size_t num_ext;
-
-	void *priv;
-};
-
-/**
- * struct counter_count_enum_ext - Count enum extension attribute
- * @items:	Array of strings
- * @num_items:	Number of items specified in @items
- * @set:	Set callback function; may be NULL
- * @get:	Get callback function; may be NULL
- *
- * The counter_count_enum_ext structure can be used to implement enum style
- * Count extension attributes. Enum style attributes are those which have a set
- * of strings that map to unsigned integer values. The Generic Counter Count
- * enum extension helper code takes care of mapping between value and string, as
- * well as generating a "_available" file which contains a list of all available
- * items. The get callback is used to query the currently active item; the index
- * of the item within the respective items array is returned via the 'item'
- * parameter. The set callback is called when the attribute is updated; the
- * 'item' parameter contains the index of the newly activated item within the
- * respective items array.
- */
-struct counter_count_enum_ext {
-	const char * const *items;
-	size_t num_items;
-	int (*get)(struct counter_device *counter, struct counter_count *count,
-		   size_t *item);
-	int (*set)(struct counter_device *counter, struct counter_count *count,
-		   size_t item);
 };
 
 /**
- * COUNTER_COUNT_ENUM() - Initialize Count enum extension
- * @_name:	Attribute name
- * @_e:		Pointer to a counter_count_enum_ext structure
- *
- * This should usually be used together with COUNTER_COUNT_ENUM_AVAILABLE()
- */
-#define COUNTER_COUNT_ENUM(_name, _e) \
-{ \
-	.name = (_name), \
-	.read = counter_count_enum_read, \
-	.write = counter_count_enum_write, \
-	.priv = (_e) \
-}
-
-/**
- * COUNTER_COUNT_ENUM_AVAILABLE() - Initialize Count enum available extension
- * @_name:	Attribute name ("_available" will be appended to the name)
- * @_e:		Pointer to a counter_count_enum_ext structure
- *
- * Creates a read only attribute that lists all the available enum items in a
- * newline separated list. This should usually be used together with
- * COUNTER_COUNT_ENUM()
- */
-#define COUNTER_COUNT_ENUM_AVAILABLE(_name, _e) \
-{ \
-	.name = (_name "_available"), \
-	.read = counter_count_enum_available_read, \
-	.priv = (_e) \
-}
-
-/**
- * struct counter_device_attr_group - internal container for attribute group
+ * struct counter_attribute_group - internal container for attribute group
  * @attr_group:	Counter sysfs attributes group
  * @attr_list:	list to keep track of created Counter sysfs attributes
  * @num_attr:	number of Counter sysfs attributes
  */
-struct counter_device_attr_group {
+struct counter_attribute_group {
 	struct attribute_group attr_group;
 	struct list_head attr_list;
 	size_t num_attr;
 };
 
-/**
- * struct counter_device_state - internal state container for a Counter device
- * @id:			unique ID used to identify the Counter
- * @dev:		internal device structure
- * @groups_list:	attribute groups list (for Signals, Counts, and ext)
- * @num_groups:		number of attribute groups containers
- * @groups:		Counter sysfs attribute groups (to populate @dev.groups)
- */
-struct counter_device_state {
-	int id;
-	struct device dev;
-	struct counter_device_attr_group *groups_list;
-	size_t num_groups;
-	const struct attribute_group **groups;
-};
-
-enum counter_signal_value {
-	COUNTER_SIGNAL_LOW = 0,
-	COUNTER_SIGNAL_HIGH
-};
-
-/**
- * struct counter_ops - Callbacks from driver
- * @signal_read:	optional read callback for Signal attribute. The read
- *			value of the respective Signal should be passed back via
- *			the val parameter.
- * @count_read:		optional read callback for Count attribute. The read
- *			value of the respective Count should be passed back via
- *			the val parameter.
- * @count_write:	optional write callback for Count attribute. The write
- *			value for the respective Count is passed in via the val
- *			parameter.
- * @function_get:	function to get the current count function mode. Returns
- *			0 on success and negative error code on error. The index
- *			of the respective Count's returned function mode should
- *			be passed back via the function parameter.
- * @function_set:	function to set the count function mode. function is the
- *			index of the requested function mode from the respective
- *			Count's functions_list array.
- * @action_get:		function to get the current action mode. Returns 0 on
- *			success and negative error code on error. The index of
- *			the respective Synapse's returned action mode should be
- *			passed back via the action parameter.
- * @action_set:		function to set the action mode. action is the index of
- *			the requested action mode from the respective Synapse's
- *			actions_list array.
- */
-struct counter_ops {
-	int (*signal_read)(struct counter_device *counter,
-			   struct counter_signal *signal,
-			   enum counter_signal_value *val);
-	int (*count_read)(struct counter_device *counter,
-			  struct counter_count *count, unsigned long *val);
-	int (*count_write)(struct counter_device *counter,
-			   struct counter_count *count, unsigned long val);
-	int (*function_get)(struct counter_device *counter,
-			    struct counter_count *count, size_t *function);
-	int (*function_set)(struct counter_device *counter,
-			    struct counter_count *count, size_t function);
-	int (*action_get)(struct counter_device *counter,
-			  struct counter_count *count,
-			  struct counter_synapse *synapse, size_t *action);
-	int (*action_set)(struct counter_device *counter,
-			  struct counter_count *count,
-			  struct counter_synapse *synapse, size_t action);
-};
-
-/**
- * struct counter_device_ext - Counter device extension
- * @name:	attribute name
- * @read:	read callback for this attribute; may be NULL
- * @write:	write callback for this attribute; may be NULL
- * @priv:	data private to the driver
- */
-struct counter_device_ext {
-	const char *name;
-	ssize_t (*read)(struct counter_device *counter, void *priv, char *buf);
-	ssize_t (*write)(struct counter_device *counter, void *priv,
-			 const char *buf, size_t len);
-	void *priv;
-};
-
-/**
- * struct counter_device_enum_ext - Counter enum extension attribute
- * @items:	Array of strings
- * @num_items:	Number of items specified in @items
- * @set:	Set callback function; may be NULL
- * @get:	Get callback function; may be NULL
- *
- * The counter_device_enum_ext structure can be used to implement enum style
- * Counter extension attributes. Enum style attributes are those which have a
- * set of strings that map to unsigned integer values. The Generic Counter enum
- * extension helper code takes care of mapping between value and string, as well
- * as generating a "_available" file which contains a list of all available
- * items. The get callback is used to query the currently active item; the index
- * of the item within the respective items array is returned via the 'item'
- * parameter. The set callback is called when the attribute is updated; the
- * 'item' parameter contains the index of the newly activated item within the
- * respective items array.
- */
-struct counter_device_enum_ext {
-	const char * const *items;
-	size_t num_items;
-	int (*get)(struct counter_device *counter, size_t *item);
-	int (*set)(struct counter_device *counter, size_t item);
-};
-
-/**
- * COUNTER_DEVICE_ENUM() - Initialize Counter enum extension
- * @_name:	Attribute name
- * @_e:		Pointer to a counter_device_enum_ext structure
- *
- * This should usually be used together with COUNTER_DEVICE_ENUM_AVAILABLE()
- */
-#define COUNTER_DEVICE_ENUM(_name, _e) \
-{ \
-	.name = (_name), \
-	.read = counter_device_enum_read, \
-	.write = counter_device_enum_write, \
-	.priv = (_e) \
-}
-
-/**
- * COUNTER_DEVICE_ENUM_AVAILABLE() - Initialize Counter enum available extension
- * @_name:	Attribute name ("_available" will be appended to the name)
- * @_e:		Pointer to a counter_device_enum_ext structure
- *
- * Creates a read only attribute that lists all the available enum items in a
- * newline separated list. This should usually be used together with
- * COUNTER_DEVICE_ENUM()
- */
-#define COUNTER_DEVICE_ENUM_AVAILABLE(_name, _e) \
-{ \
-	.name = (_name "_available"), \
-	.read = counter_device_enum_available_read, \
-	.priv = (_e) \
-}
-
 /**
  * struct counter_device - Counter data structure
- * @name:		name of the device as it appears in the datasheet
+ * @name:		name of the device
  * @parent:		optional parent device providing the counters
- * @device_state:	internal device state container
- * @ops:		callbacks from driver
+ * @signal_read:	optional read callback for Signals. The read value of
+ *			the respective Signal should be passed back via the
+ *			value parameter.
+ * @count_read:		optional read callback for Counts. The read value of the
+ *			respective Count should be passed back via the value
+ *			parameter.
+ * @count_write:	optional write callback for Counts. The write value for
+ *			the respective Count is passed in via the value
+ *			parameter.
+ * @function_read:	optional read callback the Count function modes. The
+ *			read function mode of the respective Count should be
+ *			passed back via the function parameter.
+ * @function_write:	option write callback for Count function modes. The
+ *			function mode to write for the respective Count is
+ *			passed in via the function parameter.
+ * @action_read:	optional read callback the Synapse action modes. The
+ *			read action mode of the respective Synapse should be
+ *			passed back via the action parameter.
+ * @action_write:	option write callback for Synapse action modes. The
+ *			action mode to write for the respective Synapse is
+ *			passed in via the action parameter.
  * @signals:		array of Signals
  * @num_signals:	number of Signals specified in @signals
  * @counts:		array of Counts
@@ -425,23 +164,50 @@ struct counter_device_enum_ext {
  * @ext:		optional array of Counter device extensions
  * @num_ext:		number of Counter device extensions specified in @ext
  * @priv:		optional private data supplied by driver
+ * @id:			unique ID used to identify the Counter
+ * @dev:		internal device structure
+ * @dynamic_names_list:	list for dynamically allocated names
+ * @groups_list:	attribute groups list (for Signals, Counts, and ext)
+ * @num_groups:		number of attribute groups containers
+ * @groups:		Counter sysfs attribute groups (to populate @dev.groups)
  */
 struct counter_device {
 	const char *name;
 	struct device *parent;
-	struct counter_device_state *device_state;
 
-	const struct counter_ops *ops;
+	int (*signal_read)(struct counter_device *counter,
+			   struct counter_signal *signal, u8 *value);
+	int (*count_read)(struct counter_device *counter,
+			  struct counter_count *count, u64 *value);
+	int (*count_write)(struct counter_device *counter,
+			   struct counter_count *count, u64 value);
+	int (*function_read)(struct counter_device *counter,
+			     struct counter_count *count, u8 *function);
+	int (*function_write)(struct counter_device *counter,
+			      struct counter_count *count, u8 function);
+	int (*action_read)(struct counter_device *counter,
+			   struct counter_count *count,
+			   struct counter_synapse *synapse, u8 *action);
+	int (*action_write)(struct counter_device *counter,
+			    struct counter_count *count,
+			    struct counter_synapse *synapse, u8 action);
 
 	struct counter_signal *signals;
 	size_t num_signals;
 	struct counter_count *counts;
 	size_t num_counts;
 
-	const struct counter_device_ext *ext;
+	struct counter_data *ext;
 	size_t num_ext;
 
 	void *priv;
+
+	int id;
+	struct device dev;
+	struct list_head dynamic_names_list;
+	struct counter_attribute_group *groups_list;
+	size_t num_groups;
+	const struct attribute_group **groups;
 };
 
 int counter_register(struct counter_device *const counter);
@@ -451,4 +217,146 @@ int devm_counter_register(struct device *dev,
 void devm_counter_unregister(struct device *dev,
 			     struct counter_device *const counter);
 
+#define COUNTER_DATA_DEVICE_U8(_name, _read, _write) \
+{ \
+	.type = COUNTER_DATA_TYPE_U8, \
+	.name = (_name), \
+	.device_u8_read = (_read), \
+	.device_u8_write = (_write), \
+}
+#define COUNTER_DATA_COUNT_U8(_name, _read, _write) \
+{ \
+	.type = COUNTER_DATA_TYPE_U8, \
+	.name = (_name), \
+	.count_u8_read = (_read), \
+	.count_u8_write = (_write), \
+}
+#define COUNTER_DATA_SIGNAL_U8(_name, _read, _write) \
+{ \
+	.type = COUNTER_DATA_TYPE_U8, \
+	.name = (_name), \
+	.signal_u8_read = (_read), \
+	.signal_u8_write = (_write), \
+}
+
+#define COUNTER_DATA_DEVICE_U64(_name, _read, _write) \
+{ \
+	.type = COUNTER_DATA_TYPE_U64, \
+	.name = (_name), \
+	.device_u64_read = (_read), \
+	.device_u64_write = (_write), \
+}
+#define COUNTER_DATA_COUNT_U64(_name, _read, _write) \
+{ \
+	.type = COUNTER_DATA_TYPE_U64, \
+	.name = (_name), \
+	.count_u64_read = (_read), \
+	.count_u64_write = (_write), \
+}
+#define COUNTER_DATA_SIGNAL_U64(_name, _read, _write) \
+{ \
+	.type = COUNTER_DATA_TYPE_U64, \
+	.name = (_name), \
+	.signal_u64_read = (_read), \
+	.signal_u64_write = (_write), \
+}
+
+#define COUNTER_DATA_DEVICE_BOOL(_name, _read, _write) \
+{ \
+	.type = COUNTER_DATA_TYPE_BOOL, \
+	.name = (_name), \
+	.device_u8_read = (_read), \
+	.device_u8_write = (_write), \
+}
+#define COUNTER_DATA_COUNT_BOOL(_name, _read, _write) \
+{ \
+	.type = COUNTER_DATA_TYPE_BOOL, \
+	.name = (_name), \
+	.count_u8_read = (_read), \
+	.count_u8_write = (_write), \
+}
+#define COUNTER_DATA_SIGNAL_BOOL(_name, _read, _write) \
+{ \
+	.type = COUNTER_DATA_TYPE_BOOL, \
+	.name = (_name), \
+	.signal_u8_read = (_read), \
+	.signal_u8_write = (_write), \
+}
+
+struct counter_available {
+	union {
+		const u8 *items;
+		const char *const *enums;
+	};
+	size_t num_items;
+};
+
+#define DEFINE_COUNTER_AVAILABLE(_name, _items) \
+	struct counter_available _name = { \
+		.items = (_items), \
+		.num_items = ARRAY_SIZE(_items), \
+	}
+
+#define DEFINE_COUNTER_ENUM(_name, _enums) \
+	struct counter_available _name = { \
+		.enums = (_enums), \
+		.num_items = ARRAY_SIZE(_enums), \
+	}
+
+#define COUNTER_DATA_DEVICE_ENUM(_name, _get, _set, _available) \
+{ \
+	.type = COUNTER_DATA_TYPE_ENUM, \
+	.name = (_name), \
+	.device_u8_read = (_get), \
+	.device_u8_write = (_set), \
+	.priv = &(_available), \
+}
+#define COUNTER_DATA_COUNT_ENUM(_name, _get, _set, _available) \
+{ \
+	.type = COUNTER_DATA_TYPE_ENUM, \
+	.name = (_name), \
+	.count_u8_read = (_get), \
+	.count_u8_write = (_set), \
+	.priv = &(_available), \
+}
+#define COUNTER_DATA_SIGNAL_ENUM(_name, _get, _set, _available) \
+{ \
+	.type = COUNTER_DATA_TYPE_ENUM, \
+	.name = (_name), \
+	.signal_u8_read = (_get), \
+	.signal_u8_write = (_set), \
+	.priv = &(_available), \
+}
+
+#define COUNTER_DATA_CEILING(_read, _write) \
+	COUNTER_DATA_COUNT_U64("ceiling", _read, _write)
+
+#define COUNTER_DATA_COUNT_MODE(_read, _write, _available) \
+{ \
+	.type = COUNTER_DATA_TYPE_COUNT_MODE, \
+	.name = "count_mode", \
+	.count_u8_read = (_read), \
+	.count_u8_write = (_write), \
+	.priv = &(_available), \
+}
+
+#define COUNTER_DATA_DIRECTION(_read) \
+{ \
+	.type = COUNTER_DATA_TYPE_COUNT_DIRECTION, \
+	.name = "direction", \
+	.count_u8_read = (_read), \
+}
+
+#define COUNTER_DATA_ENABLE(_read, _write) \
+	COUNTER_DATA_COUNT_BOOL("enable", _read, _write)
+
+#define COUNTER_DATA_FLOOR(_read, _write) \
+	COUNTER_DATA_COUNT_U64("floor", _read, _write)
+
+#define COUNTER_DATA_PRESET(_read, _write) \
+	COUNTER_DATA_COUNT_U64("preset", _read, _write)
+
+#define COUNTER_DATA_PRESET_ENABLE(_read, _write) \
+	COUNTER_DATA_COUNT_BOOL("preset_enable", _read, _write)
+
 #endif /* _COUNTER_H_ */
diff --git a/include/linux/counter_enum.h b/include/linux/counter_enum.h
deleted file mode 100644
index 9f917298a88f..000000000000
--- a/include/linux/counter_enum.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Counter interface enum functions
- * Copyright (C) 2018 William Breathitt Gray
- */
-#ifndef _COUNTER_ENUM_H_
-#define _COUNTER_ENUM_H_
-
-#include <linux/types.h>
-
-struct counter_device;
-struct counter_signal;
-struct counter_count;
-
-ssize_t counter_signal_enum_read(struct counter_device *counter,
-				 struct counter_signal *signal, void *priv,
-				 char *buf);
-ssize_t counter_signal_enum_write(struct counter_device *counter,
-				  struct counter_signal *signal, void *priv,
-				  const char *buf, size_t len);
-
-ssize_t counter_signal_enum_available_read(struct counter_device *counter,
-					   struct counter_signal *signal,
-					   void *priv, char *buf);
-
-ssize_t counter_count_enum_read(struct counter_device *counter,
-				struct counter_count *count, void *priv,
-				char *buf);
-ssize_t counter_count_enum_write(struct counter_device *counter,
-				 struct counter_count *count, void *priv,
-				 const char *buf, size_t len);
-
-ssize_t counter_count_enum_available_read(struct counter_device *counter,
-					  struct counter_count *count,
-					  void *priv, char *buf);
-
-ssize_t counter_device_enum_read(struct counter_device *counter, void *priv,
-				 char *buf);
-ssize_t counter_device_enum_write(struct counter_device *counter, void *priv,
-				  const char *buf, size_t len);
-
-ssize_t counter_device_enum_available_read(struct counter_device *counter,
-					   void *priv, char *buf);
-
-#endif /* _COUNTER_ENUM_H_ */
diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
new file mode 100644
index 000000000000..2ddee9fc93e0
--- /dev/null
+++ b/include/uapi/linux/counter.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Userspace ABI for Counter character devices
+ * Copyright (C) 2020 William Breathitt Gray
+ */
+#ifndef _UAPI_COUNTER_H_
+#define _UAPI_COUNTER_H_
+
+#define COUNTER_OWNER_TYPE_DEVICE 0
+#define COUNTER_OWNER_TYPE_SIGNAL 1
+#define COUNTER_OWNER_TYPE_COUNT 2
+
+#define COUNTER_COUNT_DIRECTION_FORWARD 0
+#define COUNTER_COUNT_DIRECTION_BACKWARD 1
+
+#define COUNTER_COUNT_MODE_NORMAL 0
+#define COUNTER_COUNT_MODE_RANGE_LIMIT 1
+#define COUNTER_COUNT_MODE_NON_RECYCLE 2
+#define COUNTER_COUNT_MODE_MODULO_N 3
+
+#define COUNTER_COUNT_FUNCTION_INCREASE 0
+#define COUNTER_COUNT_FUNCTION_DECREASE 1
+#define COUNTER_COUNT_FUNCTION_PULSE_DIRECTION 2
+#define COUNTER_COUNT_FUNCTION_QUADRATURE_X1_A 3
+#define COUNTER_COUNT_FUNCTION_QUADRATURE_X1_B 4
+#define COUNTER_COUNT_FUNCTION_QUADRATURE_X2_A 5
+#define COUNTER_COUNT_FUNCTION_QUADRATURE_X2_B 6
+#define COUNTER_COUNT_FUNCTION_QUADRATURE_X4 7
+
+#define COUNTER_SIGNAL_LOW 0
+#define COUNTER_SIGNAL_HIGH 1
+
+#define COUNTER_SYNAPSE_ACTION_NONE 0
+#define COUNTER_SYNAPSE_ACTION_RISING_EDGE 1
+#define COUNTER_SYNAPSE_ACTION_FALLING_EDGE 2
+#define COUNTER_SYNAPSE_ACTION_BOTH_EDGES 3
+
+#endif /* _UAPI_COUNTER_H_ */
-- 
2.27.0


Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2378C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78FE3206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="uwNDgzDw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgIAWst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgIAWsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:48:47 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9ACC061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 15:48:46 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id x21so828780pjp.6
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 15:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=3NSYXqfrpK8IBk0LQZPf7moUDfuG0boatgKdQT/tGQM=;
        b=uwNDgzDwEP7cEMbXzpfi3f9+Cx4tAdgfGtXHt0UvIE25ZgCGXGshFzS8nTajRHc0z3
         P5T8qYzJXCHieIdGqVmeqUp8Q53CMkoO/ruNlLy0vsyAXQ6PqPldCySsrOoy2YtPvSbV
         dAFqas6GnzGqfh9vrt587KvL4r5Am20qfKctnw5b4/pzEJosIb4OB06Xw7602eDz0yjQ
         OIIVysuHKd9Kuv2S3ymYHoKbEMdN7SGiS1ud5Fw6Y11Pb0X1OpuTdz+tCzu1ex9a3PDF
         UrJF+l89lOK9ZMPaB3gkcpyrBafqVZ8vclHlMXOEf5uY110cYmUWVBfFaaSqFZcmw/W1
         50vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=3NSYXqfrpK8IBk0LQZPf7moUDfuG0boatgKdQT/tGQM=;
        b=QhutX7ZYEmHIGELIdeoFQsfHdHcUTVMj83Ajsj2uOT3RK0ALH730Z8Ih9wu7XQEubV
         /vziSXbqlFK/cXrW/W/fXLRmrcMJ1B6EQoSF/TCWulOciT6xsK9zsj9oXA7hNhMsKa5G
         ig/NCDyITAA4DSHmwVw3rQ4JsMfS9CGS1uFaTh8qE/1o3cUBLox5GL+OnuFJ9CM+3w5/
         YuaGuNw3BY1Y0yMr+0siw94FOQQkl39e9LduWqeAdkvl2Z/QR22j9otnJLazCIrGSi5/
         bw5KGeptQitBxH6OpMb1H/eKzkxV2K3q888Zw1gSIesOcaoPgozrRCA9IZkYccnnXCCm
         3s4A==
X-Gm-Message-State: AOAM532yBrrVS/q8p4zSPOETwYDca5f5OziPCyi21BdStA+BpMu2OYy6
        irBDpP+xyRqwJz8QQz9k/65oGc56EC79ats=
X-Google-Smtp-Source: ABdhPJzzeadNjoNNpYLyyC+vCI6oPKDvMmW9pwcSUcgBJZhFlFw/vUmnhcJP/qnELMA+4m62+43TnDhkmJ03Hwo=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:11:7220:84ff:fe09:fedc])
 (user=saravanak job=sendgmr) by 2002:aa7:8edc:0:b029:138:695c:a024 with SMTP
 id b28-20020aa78edc0000b0290138695ca024mr4156482pfr.2.1599000526055; Tue, 01
 Sep 2020 15:48:46 -0700 (PDT)
Date:   Tue,  1 Sep 2020 15:48:42 -0700
Message-Id: <20200901224842.1787825-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.402.g5ffc5be6b7-goog
Subject: [PATCH v1] scripts/dev-needs: Add script to list device dependencies
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This script can be useful for:
- Figuring out the list of modules you need to pack in initrd
- Figuring out the list of drivers you need to modularize for a device
  to be fully functional without building in any dependencies.
- Figuring out which drivers to enable first, when porting drivers
  between kernels (say, to upstream).
- Plotting graphs of system dependencies, etc.

Usage: dev-needs.sh [-c|-d|-m|-f] [filter options] <list of devices>

This script needs to be run on the target device once it has booted to a
shell.

The script takes as input a list of one or more device directories under
/sys/devices and then lists the probe dependency chain (suppliers and
parents) of these devices. It does a breadth first search of the dependency
chain, so the last entry in the output is close to the root of the
dependency chain.

By default it lists the full path to the devices under /sys/devices.

It also takes an optional modifier flag as the first parameter to change
what information is listed in the output. If the requested information is
not available, the device name is printed.

  -c	lists the compatible string of the dependencies
  -d	lists the driver name of the dependencies that have probed
  -m	lists the module name of the dependencies that have a module
  -f	list the firmware node path of the dependencies
  -g	list the dependencies as edges and nodes for graphviz
  -t	list the dependencies as edges for tsort

The filter options provide a way to filter out some dependencies:
  --allow-no-driver	By default dependencies that don't have a driver
			attached are ignored. This is to avoid following
			device links to "class" devices that are created
			when the consumer probes (as in, not a probe
			dependency). If you want to follow these links
			anyway, use this flag.

  --exclude-devlinks	Don't follow device links when tracking probe
			dependencies.

  --exclude-parents	Don't follow parent devices when tracking probe
			dependencies.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 MAINTAINERS          |   6 +
 scripts/dev-needs.sh | 315 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 321 insertions(+)
 create mode 100755 scripts/dev-needs.sh

diff --git a/MAINTAINERS b/MAINTAINERS
index 7119165796c7..0edde5b4b032 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4995,6 +4995,12 @@ S:	Maintained
 F:	drivers/base/devcoredump.c
 F:	include/linux/devcoredump.h
 
+DEVICE DEPENDENCY HELPER SCRIPT
+M:	Saravana Kannan <saravanak@google.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	scripts/dev-needs.sh
+
 DEVICE DIRECT ACCESS (DAX)
 M:	Dan Williams <dan.j.williams@intel.com>
 M:	Vishal Verma <vishal.l.verma@intel.com>
diff --git a/scripts/dev-needs.sh b/scripts/dev-needs.sh
new file mode 100755
index 000000000000..454cc304fb44
--- /dev/null
+++ b/scripts/dev-needs.sh
@@ -0,0 +1,315 @@
+#! /bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020, Google LLC. All rights reserved.
+# Author: Saravana Kannan <saravanak@google.com>
+
+function help() {
+	cat << EOF
+Usage: $(basename $0) [-c|-d|-m|-f] [filter options] <list of devices>
+
+This script needs to be run on the target device once it has booted to a
+shell.
+
+The script takes as input a list of one or more device directories under
+/sys/devices and then lists the probe dependency chain (suppliers and
+parents) of these devices. It does a breadth first search of the dependency
+chain, so the last entry in the output is close to the root of the
+dependency chain.
+
+By default it lists the full path to the devices under /sys/devices.
+
+It also takes an optional modifier flag as the first parameter to change
+what information is listed in the output. If the requested information is
+not available, the device name is printed.
+
+  -c	lists the compatible string of the dependencies
+  -d	lists the driver name of the dependencies that have probed
+  -m	lists the module name of the dependencies that have a module
+  -f	list the firmware node path of the dependencies
+  -g	list the dependencies as edges and nodes for graphviz
+  -t	list the dependencies as edges for tsort
+
+The filter options provide a way to filter out some dependencies:
+  --allow-no-driver	By default dependencies that don't have a driver
+			attached are ignored. This is to avoid following
+			device links to "class" devices that are created
+			when the consumer probes (as in, not a probe
+			dependency). If you want to follow these links
+			anyway, use this flag.
+
+  --exclude-devlinks	Don't follow device links when tracking probe
+			dependencies.
+
+  --exclude-parents	Don't follow parent devices when tracking probe
+			dependencies.
+
+EOF
+}
+
+function dev_to_detail() {
+	local i=0
+	while [ $i -lt ${#OUT_LIST[@]} ]
+	do
+		local C=${OUT_LIST[i]}
+		local S=${OUT_LIST[i+1]}
+		local D="'$(detail_chosen $C $S)'"
+		if [ ! -z "$D" ]
+		then
+			# This weirdness is needed to work with toybox when
+			# using the -t option.
+			printf '%05u\t%s\n' ${i} "$D" | tr -d \'
+		fi
+		i=$((i+2))
+	done
+}
+
+function already_seen() {
+	local i=0
+	while [ $i -lt ${#OUT_LIST[@]} ]
+	do
+		if [ "$1" = "${OUT_LIST[$i]}" ]
+		then
+			# if-statement treats 0 (no-error) as true
+			return 0
+		fi
+		i=$(($i+2))
+	done
+
+	# if-statement treats 1 (error) as false
+	return 1
+}
+
+# Return 0 (no-error/true) if parent was added
+function add_parent() {
+
+	if [ ${ALLOW_PARENTS} -eq 0 ]
+	then
+		return 1
+	fi
+
+	local CON=$1
+	# $CON could be a symlink path. So, we need to find the real path and
+	# then go up one level to find the real parent.
+	local PARENT=$(realpath $CON/..)
+
+	while [ ! -e ${PARENT}/driver ]
+	do
+		if [ "$PARENT" = "/sys/devices" ]
+		then
+			return 1
+		fi
+		PARENT=$(realpath $PARENT/..)
+	done
+
+	CONSUMERS+=($PARENT)
+	OUT_LIST+=(${CON} ${PARENT})
+	return 0
+}
+
+# Return 0 (no-error/true) if one or more suppliers were added
+function add_suppliers() {
+	local CON=$1
+	local RET=1
+
+	if [ ${ALLOW_DEVLINKS} -eq 0 ]
+	then
+		return 1
+	fi
+
+	SUPPLIER_LINKS=$(ls -1d $CON/supplier:* 2>/dev/null)
+	for SL in $SUPPLIER_LINKS;
+	do
+		SYNC_STATE=$(cat $SL/sync_state_only)
+
+		# sync_state_only links are proxy dependencies.
+		# They can also have cycles. So, don't follow them.
+		if [ "$SYNC_STATE" != '0' ]
+		then
+			continue
+		fi
+
+		SUPPLIER=$(realpath $SL/supplier)
+
+		if [ ! -e $SUPPLIER/driver -a ${ALLOW_NO_DRIVER} -eq 0 ]
+		then
+			continue
+		fi
+
+		CONSUMERS+=($SUPPLIER)
+		OUT_LIST+=(${CON} ${SUPPLIER})
+		RET=0
+	done
+
+	return $RET
+}
+
+function detail_compat() {
+	f=$1/of_node/compatible
+	if [ -e $f ]
+	then
+		echo -n $(cat $f)
+	else
+		echo -n $1
+	fi
+}
+
+function detail_module() {
+	f=$1/driver/module
+	if [ -e $f ]
+	then
+		echo -n $(basename $(realpath $f))
+	else
+		echo -n $1
+	fi
+}
+
+function detail_driver() {
+	f=$1/driver
+	if [ -e $f ]
+	then
+		echo -n $(basename $(realpath $f))
+	else
+		echo -n $1
+	fi
+}
+
+function detail_fwnode() {
+	f=$1/firmware_node
+	if [ ! -e $f ]
+	then
+		f=$1/of_node
+	fi
+
+	if [ -e $f ]
+	then
+		echo -n $(realpath $f)
+	else
+		echo -n $1
+	fi
+}
+
+function detail_graphviz() {
+	if [ "$2" != "ROOT" ]
+	then
+		echo -n "\"$(basename $2)\"->\"$(basename $1)\""
+	else
+		echo -n "\"$(basename $1)\""
+	fi
+}
+
+function detail_tsort() {
+	echo -n "\"$2\" \"$1\""
+}
+
+function detail_device() { echo -n $1; }
+
+alias detail=detail_device
+ALLOW_NO_DRIVER=0
+ALLOW_DEVLINKS=1
+ALLOW_PARENTS=1
+
+while [ $# -gt 0 ]
+do
+	ARG=$1
+	case $ARG in
+		--help)
+			help
+			exit 0
+			;;
+		-c)
+			alias detail=detail_compat
+			;;
+		-m)
+			alias detail=detail_module
+			;;
+		-d)
+			alias detail=detail_driver
+			;;
+		-f)
+			alias detail=detail_fwnode
+			;;
+		-g)
+			alias detail=detail_graphviz
+			;;
+		-t)
+			alias detail=detail_tsort
+			;;
+		--allow-no-driver)
+			ALLOW_NO_DRIVER=1
+			;;
+		--exclude-devlinks)
+			ALLOW_DEVLINKS=0
+			;;
+		--exclude-parents)
+			ALLOW_PARENTS=0
+			;;
+		*)
+			# Stop at the first argument that's not an option.
+			break
+			;;
+	esac
+	shift
+done
+
+function detail_chosen() {
+	detail $1 $2
+}
+
+if [ $# -eq 0 ]
+then
+	help
+	exit 1
+fi
+
+CONSUMERS=($@)
+OUT_LIST=()
+
+# Do a breadth first, non-recursive tracking of suppliers. The parent is also
+# considered a "supplier" as a device can't probe without its parent.
+i=0
+while [ $i -lt ${#CONSUMERS[@]} ]
+do
+	CONSUMER=$(realpath ${CONSUMERS[$i]})
+	i=$(($i+1))
+
+	if already_seen ${CONSUMER}
+	then
+		continue
+	fi
+
+	# If this is not a device with a driver, we don't care about its
+	# suppliers.
+	if [ ! -e ${CONSUMER}/driver -a ${ALLOW_NO_DRIVER} -eq 0 ]
+	then
+		continue
+	fi
+
+	ROOT=1
+
+	# Add suppliers to CONSUMERS list and output the consumer details.
+	#
+	# We don't need to worry about a cycle in the dependency chain causing
+	# infinite loops. That's because the kernel doesn't allow cycles in
+	# device links unless it's a sync_state_only device link. And we ignore
+	# sync_state_only device links inside add_suppliers.
+	if add_suppliers ${CONSUMER}
+	then
+		ROOT=0
+	fi
+
+	if add_parent ${CONSUMER}
+	then
+		ROOT=0
+	fi
+
+	if [ $ROOT -eq 1 ]
+	then
+		OUT_LIST+=(${CONSUMER} "ROOT")
+	fi
+done
+
+# Can NOT combine sort and uniq using sort -suk2 because stable sort in toybox
+# isn't really stable.
+dev_to_detail | sort -k2 -k1 | uniq -f 1 | sort | cut -f2-
+
+exit 0
-- 
2.28.0.402.g5ffc5be6b7-goog


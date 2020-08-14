Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93783C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 01:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D4F620855
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 01:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHNBBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 21:01:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:55582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbgHNBBC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 21:01:02 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 141912078D;
        Fri, 14 Aug 2020 01:01:01 +0000 (UTC)
Date:   Thu, 13 Aug 2020 21:01:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 4/6] tools/bootconfig: Add a script to generate ftrace
 shell-command from bootconfig
Message-ID: <20200813210100.23a706ab@oasis.local.home>
In-Reply-To: <159704851101.175360.15119132351139842345.stgit@devnote2>
References: <159704847064.175360.3292152056631660862.stgit@devnote2>
        <159704851101.175360.15119132351139842345.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Aug 2020 17:35:11 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:


> --- /dev/null
> +++ b/tools/bootconfig/scripts/xbc.sh
> @@ -0,0 +1,56 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-only
> +
> +# bootconfig utility functions
> +
> +XBC_TMPFILE=
> +XBC_BASEDIR=`dirname $0`
> +BOOTCONFIG=${BOOTCONFIG:=$XBC_BASEDIR/../bootconfig}
> +if [ ! -x "$BOOTCONFIG" ]; then
> +	BOOTCONFIG=`which bootconfig`
> +	if [ -z "$BOOTCONFIG" ]; then
> +		echo "Erorr: bootconfig command is not found" 1>&2
> +		exit 1
> +	fi
> +fi
> +
> +xbc_cleanup() {
> +	if [ "$XBC_TMPFILE" ]; then

Should the above be:

	if [ -f "$XBC_TMPFILE" ]; then
?


-- Steve

> +		rm -f "$XBC_TMPFILE"
> +	fi
> +}
> +
> +xbc_init() { # bootconfig-file
> +	xbc_cleanup
> +	XBC_TMPFILE=`mktemp bconf-XXXX`
> +	trap xbc_cleanup EXIT TERM
> +
> +	$BOOTCONFIG -l $1 > $XBC_TMPFILE || exit 1
> +}
> +
> +nr_args() { # args
> +	echo $#
> +}
> +
> +xbc_get_val() { # key [maxnum]
> +	if [ "$2" ]; then
> +		MAXOPT="-L $2"
> +	fi
> +	grep "^$1 =" $XBC_TMPFILE | cut -d= -f2- | \
> +		sed -e 's/", /" /g' -e "s/',/' /g" | \
> +		xargs $MAXOPT -n 1 echo
> +}
> +
> +xbc_has_key() { # key
> +	grep -q "^$1 =" $XBC_TMPFILE
> +}
> +
> +xbc_has_branch() { # prefix-key
> +	grep -q "^$1" $XBC_TMPFILE
> +}
> +
> +xbc_subkeys() { # prefix-key depth
> +	__keys=`echo $1 | sed "s/\./ /g"`
> +	__s=`nr_args $__keys`
> +	grep "^$1" $XBC_TMPFILE | cut -d= -f1| cut -d. -f$((__s + 1))-$((__s + $2)) | uniq
> +}


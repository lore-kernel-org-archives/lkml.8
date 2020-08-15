Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6319C433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC0D920657
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597529543;
	bh=M/nxbLlP+D61zLzHCfsidzMMTdPbHEbfvM8bO2P5ksc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tr7yNIIB6UcxnkAA+6kwSHqkuP4YwhkM4osQf2CBDx1rNrqxwrECZqvAuhNpKGcnZ
	 /TwesVMEf/uBzmdBDL95Q8wIJnRpxb6RyPmfSk0QEU74GiDZ52TbM4srOzF8W3Fg39
	 pHEKe9LFEJkKHaPgYbyQk7b25yeV8xrWdp83TvCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbgHOWMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:12:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729131AbgHOWK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 18:10:28 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B22123105;
        Sat, 15 Aug 2020 10:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597489074;
        bh=M/nxbLlP+D61zLzHCfsidzMMTdPbHEbfvM8bO2P5ksc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wjh/i9+MH/e9RbB9m+iuxE60TALKoWIyziVZqHh41a3WS1A6vIvxq70hWFqW77Cx3
         kChAUAZfsj0fucSroOF/3U4WufQvjbcyLPuYCsa7yd35in7n8BFKJ8dIYyFnzGc31Z
         QmnCAntecFcEzvPqTM1UDloVXkohVBpA3obqIWj0=
Date:   Sat, 15 Aug 2020 19:57:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 4/6] tools/bootconfig: Add a script to generate ftrace
 shell-command from bootconfig
Message-Id: <20200815195749.9d25395fd2f9fbcda6efc423@kernel.org>
In-Reply-To: <20200813210100.23a706ab@oasis.local.home>
References: <159704847064.175360.3292152056631660862.stgit@devnote2>
        <159704851101.175360.15119132351139842345.stgit@devnote2>
        <20200813210100.23a706ab@oasis.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Aug 2020 21:01:00 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 10 Aug 2020 17:35:11 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> 
> > --- /dev/null
> > +++ b/tools/bootconfig/scripts/xbc.sh
> > @@ -0,0 +1,56 @@
> > +#!/bin/sh
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +
> > +# bootconfig utility functions
> > +
> > +XBC_TMPFILE=
> > +XBC_BASEDIR=`dirname $0`
> > +BOOTCONFIG=${BOOTCONFIG:=$XBC_BASEDIR/../bootconfig}
> > +if [ ! -x "$BOOTCONFIG" ]; then
> > +	BOOTCONFIG=`which bootconfig`
> > +	if [ -z "$BOOTCONFIG" ]; then
> > +		echo "Erorr: bootconfig command is not found" 1>&2
> > +		exit 1
> > +	fi
> > +fi
> > +
> > +xbc_cleanup() {
> > +	if [ "$XBC_TMPFILE" ]; then
> 
> Should the above be:
> 
> 	if [ -f "$XBC_TMPFILE" ]; then
> ?

Ah, good catch!
I didn't call xbc_cleanup except for the trap in bconf2ftrace,
but for user who call xbc_cleanup explicitly, we need -f.

Thank you!

> 
> 
> -- Steve
> 
> > +		rm -f "$XBC_TMPFILE"
> > +	fi
> > +}
> > +
> > +xbc_init() { # bootconfig-file
> > +	xbc_cleanup
> > +	XBC_TMPFILE=`mktemp bconf-XXXX`
> > +	trap xbc_cleanup EXIT TERM
> > +
> > +	$BOOTCONFIG -l $1 > $XBC_TMPFILE || exit 1
> > +}
> > +
> > +nr_args() { # args
> > +	echo $#
> > +}
> > +
> > +xbc_get_val() { # key [maxnum]
> > +	if [ "$2" ]; then
> > +		MAXOPT="-L $2"
> > +	fi
> > +	grep "^$1 =" $XBC_TMPFILE | cut -d= -f2- | \
> > +		sed -e 's/", /" /g' -e "s/',/' /g" | \
> > +		xargs $MAXOPT -n 1 echo
> > +}
> > +
> > +xbc_has_key() { # key
> > +	grep -q "^$1 =" $XBC_TMPFILE
> > +}
> > +
> > +xbc_has_branch() { # prefix-key
> > +	grep -q "^$1" $XBC_TMPFILE
> > +}
> > +
> > +xbc_subkeys() { # prefix-key depth
> > +	__keys=`echo $1 | sed "s/\./ /g"`
> > +	__s=`nr_args $__keys`
> > +	grep "^$1" $XBC_TMPFILE | cut -d= -f1| cut -d. -f$((__s + 1))-$((__s + $2)) | uniq
> > +}
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

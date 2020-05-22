Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FABFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:51:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A2C420727
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbgEVQvY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 12:51:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:51736 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730487AbgEVQvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:51:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9E6B6ABE3;
        Fri, 22 May 2020 16:51:24 +0000 (UTC)
Date:   Fri, 22 May 2020 18:51:20 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Benson Leung <bleung@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 2/6] printk: honor the max_reason field in kmsg_dumper
Message-ID: <20200522165120.GL3464@linux-b0ei>
References: <20200515184434.8470-1-keescook@chromium.org>
 <20200515184434.8470-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515184434.8470-3-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-05-15 11:44:30, Kees Cook wrote:
> From: Pavel Tatashin <pasha.tatashin@soleen.com>
> 
> kmsg_dump() allows to dump kmesg buffer for various system events: oops,
> panic, reboot, etc. It provides an interface to register a callback call
> for clients, and in that callback interface there is a field "max_reason"
> which gets ignored unless always_kmsg_dump is passed as kernel parameter.

Strictly speaking, this is not fully true. "max_reason" field is not
ignored when set to KMSG_DUMP_PANIC even when always_kmsg_dump was not set.

It should be something like:

"which gets ignored for reason higher than KMSG_DUMP_OOPS unless
always_kmsg_dump is passed as kernel parameter".

Heh, I wonder if anyone will be able to parse this ;-)


Otherwise, it looks good to me. With the updated commit message:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

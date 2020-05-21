Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED2FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58D4020823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgEUUGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:06:15 -0400
Received: from smtprelay0152.hostedemail.com ([216.40.44.152]:59316 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728368AbgEUUGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:06:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 08A8E837F24C;
        Thu, 21 May 2020 20:06:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: steel94_4f05fa326d21
X-Filterd-Recvd-Size: 2688
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Thu, 21 May 2020 20:06:11 +0000 (UTC)
Message-ID: <5bb4b918aec3c77038122588ee642ae4aa2a09b0.camel@perches.com>
Subject: [RFC] Make dynamic debug infrastructure more flexible
From:   Joe Perches <joe@perches.com>
To:     Jason Baron <jbaron@akamai.com>
Cc:     Vikash Garodia <vgarodia@codeaurora.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 21 May 2020 13:06:10 -0700
In-Reply-To: <c4cad4f243988d214208a4903aa311a64f9b4531.camel@perches.com>
References: <20200521132816.31111-1-stanimir.varbanov@linaro.org>
         <20200521132816.31111-3-stanimir.varbanov@linaro.org>
         <c4cad4f243988d214208a4903aa311a64f9b4531.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-21 at 09:08 -0700, Joe Perches wrote:
> On Thu, 2020-05-21 at 16:28 +0300, Stanimir Varbanov wrote:
> > Here we introduce few debug macros with levels (low, medium and
> > high) and debug macro for firmware. Enabling the particular level
> > will be done by dynamic debug.
> 
> I'd rather make the logging level facility generic in
> dynamic debug than prefix all formats with what could
> be non-specific content.
> 
> From a long time ago:
> 
> https://groups.google.com/forum/#!msg/linux.kernel/VlWbno-ZAFw/k_fFadhNHXcJ

Hey Jason.

I believe there are 6 bits left in the unsigned int
use for the line number and flags in struct _ddebug

Assuming the use of a mechanism like

	pr_debug_level(level, fmt, ...)

would you be OK with something like this to enable a
level or bitmask test of dynamic debug logging output?

where the output is controlled by something like

echo 'file <filename> level <n> +p' > <debugfs>/dynamic_debug/control

to enable dynamic debug output only at level <n> or higher
or maybe match a bitmap of <n>

(modulo all the rest of the code necessary to use it?)
---
 include/linux/dynamic_debug.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index abcd5fde30eb..616dbb2b5921 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -38,6 +38,8 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
 	unsigned int flags:8;
+	unsigned int level:5;
+	unsigned int level_is_bitmask:1;
 #ifdef CONFIG_JUMP_LABEL
 	union {
 		struct static_key_true dd_key_true;



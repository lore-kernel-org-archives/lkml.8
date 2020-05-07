Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B39C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A91E21BE5
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 19:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588879275;
	bh=Fqz2PjC/jFV89A9kXw++EXBwCRqH25aWHuTpik2W34I=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=kKF9UdMQSkiru0SZJZN15kVTOFRUI2xRgv4pOmIAMZguJWoAcEou0QmjfL4vS5Dvo
	 WHbPBQYUuPmcCZo7k0G0i3OTHyinaZmBncKZjPya3SDBaDSnpfKgtVTQvIW2JLJZcL
	 Bn8NNp4/Wy63IZa8dT/XAl/eKGGpbMXGxJckqI3I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgEGTVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 15:21:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728309AbgEGTVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 15:21:13 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2662221F7;
        Thu,  7 May 2020 19:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588879273;
        bh=Fqz2PjC/jFV89A9kXw++EXBwCRqH25aWHuTpik2W34I=;
        h=Date:From:To:Cc:Subject:From;
        b=sIlWVVg+1ES+Eb2qBbHDRCjQ+Br9Roy/dbGcWJFqTZ/hZ3Ia2eHs7Pah817dUkshs
         E8aX9VcPCHsTf7p/wpO/gZat2vnUAOz8oSMY02e6LDI6NKrTvgxrwqYsZbVoMY9d7x
         yhr9+B+GOcWSofspsfYfjVDvKlhknDKYLGsrEUcg=
Date:   Thu, 7 May 2020 14:25:39 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tracing/probe: Replace zero-length array with flexible-array
Message-ID: <20200507192539.GA16642@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

sizeof(flexible-array-member) triggers a warning because flexible array
members have incomplete type[1]. There are some instances of code in
which the sizeof operator is being incorrectly/erroneously applied to
zero-length arrays and the result is zero. Such instances may be hiding
some bugs. So, this work (flexible-array member conversions) will also
help to get completely rid of those sorts of issues.

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 kernel/trace/trace_probe.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index a0ff9e200ef6..a22b62813f8c 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -236,7 +236,7 @@ struct trace_probe_event {
 	struct trace_event_call		call;
 	struct list_head 		files;
 	struct list_head		probes;
-	struct trace_uprobe_filter	filter[0];
+	struct trace_uprobe_filter	filter[];
 };
 
 struct trace_probe {


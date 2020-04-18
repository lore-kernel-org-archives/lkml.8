Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AB9C3A5A0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD56E21D6C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 20:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgDRUnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 16:43:06 -0400
Received: from smtprelay0199.hostedemail.com ([216.40.44.199]:41158 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726014AbgDRUnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 16:43:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id C8D98100E7B43;
        Sat, 18 Apr 2020 20:43:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bikes51_54543769da122
X-Filterd-Recvd-Size: 3474
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sat, 18 Apr 2020 20:42:59 +0000 (UTC)
Message-ID: <24a1f021e52ccabfd53baa22b93947ef10e6bf3b.camel@perches.com>
Subject: Re: [PATCHv3 01/50] kallsyms/printk: Add loglvl to print_ip_sym()
From:   Joe Perches <joe@perches.com>
To:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jslaby@suse.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greentime Hu <green.hu@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Michal Simek <monstr@monstr.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Burton <paulburton@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Chen <deanbo422@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Will Deacon <will@kernel.org>, linux-mips@vger.kernel.org,
        linux-riscv@lists.infradead.org
Date:   Sat, 18 Apr 2020 13:40:45 -0700
In-Reply-To: <20200418201944.482088-2-dima@arista.com>
References: <20200418201944.482088-1-dima@arista.com>
         <20200418201944.482088-2-dima@arista.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-04-18 at 21:18 +0100, Dmitry Safonov wrote:
> print_ip_sym() needs to have a log level parameter to comply with other
> parts being printed. Otherwise, half of the expected backtrace would be
> printed and other may be missing with some logging level.

I'd rather create another extension to %ps that also emits
the [<address>] along with the symbol lookup and retire
print_ip_sym altogether.

Something like:
---
 lib/vsprintf.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 7c488a..8fce8f 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2072,6 +2072,8 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
  * - 'S' For symbolic direct pointers (or function descriptors) with offset
  * - 's' For symbolic direct pointers (or function descriptors) without offset
  * - '[Ss]R' as above with __builtin_extract_return_addr() translation
+ * - '[Ss]B' [<address>] and symbolic direct pointers as above
+ *	     (was used previously used as print_ip_sym)
  * - '[Ff]' %pf and %pF were obsoleted and later removed in favor of
  *	    %ps and %pS. Be careful when re-using these specifiers.
  * - 'B' For backtraced symbolic direct pointers with offset
@@ -2183,6 +2185,8 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	case 'S':
 	case 's':
 		ptr = dereference_symbol_descriptor(ptr);
+		if (fmt[1] == 'B')
+			buf += vsprintf(buf, end, "[<%px>] ", ptr);
 		/* Fallthrough */
 	case 'B':
 		return symbol_string(buf, end, ptr, spec, fmt);



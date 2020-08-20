Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3BBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2218320885
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgHTRss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:48:48 -0400
Received: from smtprelay0106.hostedemail.com ([216.40.44.106]:45654 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726723AbgHTRsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:48:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id DBFAA1800B86B;
        Thu, 20 Aug 2020 17:48:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: name45_221863b27032
X-Filterd-Recvd-Size: 2754
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Thu, 20 Aug 2020 17:48:41 +0000 (UTC)
Message-ID: <472f2e553805b52d9834d64e4056db965edee329.camel@perches.com>
Subject: Re: [RFC PATCH 2/5] sysrq: use pr_cont_t for cont messages
From:   Joe Perches <joe@perches.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 20 Aug 2020 10:48:40 -0700
In-Reply-To: <CAHk-=wj_b6Bh=d-Wwh0xYqoQBhHkYeExhszkpxdRA6GjTvkRiQ@mail.gmail.com>
References: <20200819232632.13418-1-john.ogness@linutronix.de>
         <20200819232632.13418-3-john.ogness@linutronix.de>
         <CAHk-=wj_b6Bh=d-Wwh0xYqoQBhHkYeExhszkpxdRA6GjTvkRiQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-19 at 18:03 -0700, Linus Torvalds wrote:
> On Wed, Aug 19, 2020 at 4:26 PM John Ogness <john.ogness@linutronix.de> wrote:
> > Use the new pr_cont_t mechanism.
> 
> This looks actively much worse than the old code.

Isn't this just a generic mechanism to simplify
the accumulation of
logging message chunks?

It does seem straightforward enough to me.

And here it seems like the 'for (j =...)' loop is superfluous.

Maybe something like this would be reasonable:
---
 drivers/tty/sysrq.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
index a8e39b2cdd55..a145e4fc1a2a 100644
--- a/drivers/tty/sysrq.c
+++ b/drivers/tty/sysrq.c
@@ -572,21 +572,14 @@ void __handle_sysrq(int key, bool check_mask)
 			console_loglevel = orig_log_level;
 		}
 	} else {
-		pr_info("HELP : ");
-		/* Only print the help msg once per handler */
+		pr_context c;
+		pr_info_start(&c, "HELP :");
 		for (i = 0; i < ARRAY_SIZE(sysrq_key_table); i++) {
-			if (sysrq_key_table[i]) {
-				int j;
-
-				for (j = 0; sysrq_key_table[i] !=
-						sysrq_key_table[j]; j++)
-					;
-				if (j != i)
-					continue;
-				pr_cont("%s ", sysrq_key_table[i]->help_msg);
-			}
+			if (!sysrq_key_table[i])
+				continue;
+			pr_next(&c, " %s", sysrq_key_table[i]->help_msg);
 		}
-		pr_cont("\n");
+		pr_end(&c, "\n");
 		console_loglevel = orig_log_level;
 	}
 	rcu_read_unlock();



Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F52C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ABD6207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbgHJQpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:45:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:34470 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727121AbgHJQpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 12:45:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9E53EAC61;
        Mon, 10 Aug 2020 16:46:13 +0000 (UTC)
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org
From:   Claudio Fontana <cfontana@suse.de>
Subject: in_commit_log: is the wrong token being matched for the MAINTAINERS
 need updating message?
Message-ID: <540c6741-3f22-ec85-0a14-3165115430df@suse.de>
Date:   Mon, 10 Aug 2020 18:45:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while working on a downstream version of the checkpatch.pl script used for qemu,

I experienced a "bug" that I traced back to the kernel upstream version of checkpatch.pl, and hence the question:

what is the exact meaning of the variable in_commit_log, is it supposed to be including the git diff stats or not?

For example, lets take this sample useless patch as input:

-------- cut --------
From 1873ba53039d8824e37452dc39af79b4b0327085 Mon Sep 17 00:00:00 2001
From: Claudio Fontana <cfontana@suse.de>
Date: Mon, 10 Aug 2020 15:36:47 +0200
Subject: [PATCH] XXX test patch moving file

Signed-off-by: Claudio Fontana <cfontana@suse.de>
---
 sound/Makefile              | 2 +-
 sound/{ => ac97}/ac97_bus.c | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename sound/{ => ac97}/ac97_bus.c (100%)

diff --git a/sound/Makefile b/sound/Makefile
index 797ecdcd35e2..d7a08163ea1a 100644
--- a/sound/Makefile
+++ b/sound/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_SND) += core/ i2c/ drivers/ isa/ pci/ ppc/ arm/ sh/ synth/ usb/ \
 obj-$(CONFIG_SND_AOA) += aoa/
 
 # This one must be compilable even if sound is configured out
-obj-$(CONFIG_AC97_BUS) += ac97_bus.o
+obj-$(CONFIG_AC97_BUS) += ac97/ac97_bus.o
 obj-$(CONFIG_AC97_BUS_NEW) += ac97/
 
 ifeq ($(CONFIG_SND),y)
diff --git a/sound/ac97_bus.c b/sound/ac97/ac97_bus.c
similarity index 100%
rename from sound/ac97_bus.c
rename to sound/ac97/ac97_bus.c
-- 
2.16.4

-------- cut --------

and using this simple patch to highlight the issue:

-------- cut --------
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 599b8c4933a7..e87d5d00a9cd 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2876,16 +2876,17 @@ sub process {
                        }
                }
 
+               print $line . "\n";
 # Check for added, moved or deleted files
                if (!$reported_maintainer_file && !$in_commit_log &&
                    ($line =~ /^(?:new|deleted) file mode\s*\d+\s*$/ ||
                     $line =~ /^rename (?:from|to) [\w\/\.\-]+\s*$/ ||
                     ($line =~ /\{\s*([\w\/\.\-]*)\s*\=\>\s*([\w\/\.\-]*)\s*\}/ &&
                      (defined($1) || defined($2))))) {
+                       print("1: $1 2: $2\n");
                        $is_patch = 1;
                        $reported_maintainer_file = 1;
-                       WARN("FILE_PATH_CHANGES",
-                            "added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
+                       print("added, moved or deleted file(s), does MAINTAINERS need updating?\n" . $herecurr);
                }
 
 # Check for adding new DT bindings not in schema format
-------- cut --------

We can see that in the sample patch input we are matching the line

 sound/{ => ac97}/ac97_bus.c | 0

with the regex ($line =~ /\{\s*([\w\/\.\-]*)\s*\=\>\s*([\w\/\.\-]*)\s*\}/

Is this actually wanted?

I would expect that in this case we want instead to match the lines:

rename from sound/ac97_bus.c
rename to sound/ac97/ac97_bus.c

It does not hurt in the kernel, but it does hurt in my downstream patch, where I try to make use of $realfile ,
which is not set if I match too early in the patch. 

Would it make sense to move this chunk earlier:


# Check if it's the start of a commit log                                                                                                   
# (not a header line and we haven't seen the patch filename)                                                                                
                if ($in_header_lines && $realfile =~ /^$/ &&
                    !($rawline =~ /^\s+(?:\S|$)/ ||
                      $rawline =~ /^(?:commit\b|from\b|[\w-]+:)/i)) {
                        $in_header_lines = 0;
                        $in_commit_log = 1;
                        $has_commit_log = 1;
                }

so that the check: 

if (!$reported_maintainer_file && !$in_commit_log

fails for the testcase shown (in_commit_log ends up as true), and the match will happen later, where realfile is set and available for use?

Thanks!

Claudio


-- 
Claudio Fontana
Engineering Manager Virtualization, SUSE Labs Core

SUSE Software Solutions Italy Srl

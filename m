Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F59C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D967E2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Mej8KfJX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729242AbgF2SsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbgF2Srp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:47:45 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749F8C031C4D;
        Mon, 29 Jun 2020 10:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=u+6HLVb+cgRR0Hb2dw/N6EBtkK2k556CYS23hEx+WSk=; b=Mej8KfJXpy+djVbbFX8sK8jJ6Z
        qmYOpW/auxeHHvN0nGfRYth5IAcRg876lllOpE4VARJ29D0oKyOsoi0bKyfm+X43d6SaX/dORAK+H
        IBXmmidDvtg5ivgR5ptvj/VCPhfVklyCzO9Qw8WSmwhoabgiSwNzykNdVUFKKKnmBg+mOQv/VZ2dM
        HxW7msrnxH7A3q34gSpsL9dwmABDG1mHHUIBkIuBQnWt4fLn+rHc4gXYmKpMiavbhq3m3SRl0+Gwt
        V7bLLpjDT7AEryBVpNv/1pkYh7G8F3Gjt94tciTA0TIbAtXeiLPgRJ657daY0n5X0EhUJjSM7CxHI
        g77vcozQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jpxcj-0003Vz-12; Mon, 29 Jun 2020 17:31:18 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Julia Lawall <julia.lawall@lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>, cocci@systeme.lip6.fr,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: Coccinelle: fix typos and command example
Message-ID: <725b57dd-cfde-a63f-0475-954452761508@infradead.org>
Date:   Mon, 29 Jun 2020 10:31:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix various typos etc. in dev-tools/coccinelle.rst:

- punctuation, grammar, wording
- add "path/to/file.c" when using Coccinelle to check a single file

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Gilles Muller <Gilles.Muller@lip6.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: cocci@systeme.lip6.fr
---
 Documentation/dev-tools/coccinelle.rst |   44 +++++++++++------------
 1 file changed, 22 insertions(+), 22 deletions(-)

--- linux-next-20200629.orig/Documentation/dev-tools/coccinelle.rst
+++ linux-next-20200629/Documentation/dev-tools/coccinelle.rst
@@ -85,7 +85,7 @@ Four basic modes are defined: ``patch``,
   file:line:column-column: message
 
 - ``context`` highlights lines of interest and their context in a
-  diff-like style.Lines of interest are indicated with ``-``.
+  diff-like style. Lines of interest are indicated with ``-``.
 
 - ``org`` generates a report in the Org mode format of Emacs.
 
@@ -119,7 +119,7 @@ For each semantic patch, a commit messag
 description of the problem being checked by the semantic patch, and
 includes a reference to Coccinelle.
 
-As any static code analyzer, Coccinelle produces false
+As with any static code analyzer, Coccinelle produces false
 positives. Thus, reports must be carefully checked, and patches
 reviewed.
 
@@ -135,18 +135,18 @@ the parallelism, set the J= variable. Fo
 
    make coccicheck MODE=report J=4
 
-As of Coccinelle 1.0.2 Coccinelle uses Ocaml parmap for parallelization,
+As of Coccinelle 1.0.2 Coccinelle uses Ocaml parmap for parallelization;
 if support for this is detected you will benefit from parmap parallelization.
 
 When parmap is enabled coccicheck will enable dynamic load balancing by using
-``--chunksize 1`` argument, this ensures we keep feeding threads with work
+``--chunksize 1`` argument. This ensures we keep feeding threads with work
 one by one, so that we avoid the situation where most work gets done by only
 a few threads. With dynamic load balancing, if a thread finishes early we keep
 feeding it more work.
 
 When parmap is enabled, if an error occurs in Coccinelle, this error
-value is propagated back, the return value of the ``make coccicheck``
-captures this return value.
+value is propagated back, and the return value of the ``make coccicheck``
+command captures this return value.
 
 Using Coccinelle with a single semantic patch
 ---------------------------------------------
@@ -177,13 +177,13 @@ For example, to check drivers/net/wirele
 To apply Coccinelle on a file basis, instead of a directory basis, the
 following command may be used::
 
-    make C=1 CHECK="scripts/coccicheck"
+    make C=1 CHECK="scripts/coccicheck" path/to/file.c
 
 To check only newly edited code, use the value 2 for the C flag, i.e.::
 
-    make C=2 CHECK="scripts/coccicheck"
+    make C=2 CHECK="scripts/coccicheck" path/to/file.c
 
-In these modes, which works on a file basis, there is no information
+In these modes, which work on a file basis, there is no information
 about semantic patches displayed, and no commit message proposed.
 
 This runs every semantic patch in scripts/coccinelle by default. The
@@ -198,12 +198,12 @@ Debugging Coccinelle SmPL patches
 
 Using coccicheck is best as it provides in the spatch command line
 include options matching the options used when we compile the kernel.
-You can learn what these options are by using V=1, you could then
+You can learn what these options are by using V=1; you could then
 manually run Coccinelle with debug options added.
 
 Alternatively you can debug running Coccinelle against SmPL patches
-by asking for stderr to be redirected to stderr, by default stderr
-is redirected to /dev/null, if you'd like to capture stderr you
+by asking for stderr to be redirected to stderr. By default stderr
+is redirected to /dev/null; if you'd like to capture stderr you
 can specify the ``DEBUG_FILE="file.txt"`` option to coccicheck. For
 instance::
 
@@ -211,8 +211,8 @@ instance::
     make coccicheck COCCI=scripts/coccinelle/free/kfree.cocci MODE=report DEBUG_FILE=cocci.err
     cat cocci.err
 
-You can use SPFLAGS to add debugging flags, for instance you may want to
-add both --profile --show-trying to SPFLAGS when debugging. For instance
+You can use SPFLAGS to add debugging flags; for instance you may want to
+add both --profile --show-trying to SPFLAGS when debugging. For example
 you may want to use::
 
     rm -f err.log
@@ -229,7 +229,7 @@ DEBUG_FILE support is only supported whe
 --------------------
 
 Coccinelle supports reading .cocciconfig for default Coccinelle options that
-should be used every time spatch is spawned, the order of precedence for
+should be used every time spatch is spawned. The order of precedence for
 variables for .cocciconfig is as follows:
 
 - Your current user's home directory is processed first
@@ -237,7 +237,7 @@ variables for .cocciconfig is as follows
 - The directory provided with the --dir option is processed last, if used
 
 Since coccicheck runs through make, it naturally runs from the kernel
-proper dir, as such the second rule above would be implied for picking up a
+proper dir; as such the second rule above would be implied for picking up a
 .cocciconfig when using ``make coccicheck``.
 
 ``make coccicheck`` also supports using M= targets. If you do not supply
@@ -260,13 +260,13 @@ If not using the kernel's coccicheck tar
 order logic of .cocciconfig reading. If using the kernel's coccicheck target,
 override any of the kernel's .coccicheck's settings using SPFLAGS.
 
-We help Coccinelle when used against Linux with a set of sensible defaults
+We help Coccinelle when used against Linux with a set of sensible default
 options for Linux with our own Linux .cocciconfig. This hints to coccinelle
-git can be used for ``git grep`` queries over coccigrep. A timeout of 200
+that git can be used for ``git grep`` queries over coccigrep. A timeout of 200
 seconds should suffice for now.
 
 The options picked up by coccinelle when reading a .cocciconfig do not appear
-as arguments to spatch processes running on your system, to confirm what
+as arguments to spatch processes running on your system. To confirm what
 options will be used by Coccinelle run::
 
       spatch --print-options-only
@@ -290,7 +290,7 @@ given to it when options are in conflict
 
 Coccinelle supports idutils as well but requires coccinelle >= 1.0.6.
 When no ID file is specified coccinelle assumes your ID database file
-is in the file .id-utils.index on the top level of the kernel, coccinelle
+is in the file .id-utils.index on the top level of the kernel. Coccinelle
 carries a script scripts/idutils_index.sh which creates the database with::
 
     mkid -i C --output .id-utils.index
@@ -317,7 +317,7 @@ SmPL patch specific options
 ---------------------------
 
 SmPL patches can have their own requirements for options passed
-to Coccinelle. SmPL patch specific options can be provided by
+to Coccinelle. SmPL patch-specific options can be provided by
 providing them at the top of the SmPL patch, for instance::
 
 	// Options: --no-includes --include-headers
@@ -327,7 +327,7 @@ SmPL patch Coccinelle requirements
 
 As Coccinelle features get added some more advanced SmPL patches
 may require newer versions of Coccinelle. If an SmPL patch requires
-at least a version of Coccinelle, this can be specified as follows,
+at minimum version of Coccinelle, this can be specified as follows,
 as an example if requiring at least Coccinelle >= 1.0.5::
 
 	// Requires: 1.0.5


Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39354C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EC9A206C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 08:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgHLIbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 04:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgHLIbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 04:31:46 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Aug 2020 01:31:45 PDT
Received: from smtp2-3.goneo.de (smtp2.goneo.de [IPv6:2001:1640:5::8:33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED778C06174A;
        Wed, 12 Aug 2020 01:31:45 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id D369523F726;
        Wed, 12 Aug 2020 10:21:42 +0200 (CEST)
X-Virus-Scanned: by goneo
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 47WxqdcBU-ye; Wed, 12 Aug 2020 10:21:41 +0200 (CEST)
Received: from [192.168.1.127] (dyndsl-085-016-039-248.ewe-ip-backbone.de [85.16.39.248])
        by smtp2.goneo.de (Postfix) with ESMTPSA id 4611D23F737;
        Wed, 12 Aug 2020 10:21:41 +0200 (CEST)
Subject: Re: Documentation: build failure with sphinx >= 3.0.0: exception:
 cannot import name 'c_funcptr_sig_re' from 'sphinx.domains.c'
To:     Salvatore Bonaccorso <carnil@debian.org>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>,
        jforbes@fedoraproject.org
References: <20200408113705.GB1924@ArchLinux>
 <20200408132505.52e595bc@lwn.net> <20200408233450.GA14923@debian>
 <20200809132327.GA145573@eldamar.local>
 <20200812073059.GA509953@eldamar.local>
From:   Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <579fbb36-515d-5af4-f7dc-c092d29fddd8@darmarit.de>
Date:   Wed, 12 Aug 2020 10:21:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812073059.GA509953@eldamar.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 12.08.20 um 09:30 schrieb Salvatore Bonaccorso:
[..]
>> The problem is actually related to changes happening in Sphinx 3.0.0.
>> There is the followign issue filled upstream:
>>
>> https://github.com/sphinx-doc/sphinx/issues/7421
>>
>> 'c_funcptr_sig_re' was removed upstream in sphinx v3.0.0b1 and so the
>> kernel documentation build fails. This is reproducible with a recent
>> sphinx version (in attached case it is 3.2.0):
>>
>> $ make PYTHON=python3 xmldocs
>>    SPHINX  xmldocs --> file:///home/build/linux/Documentation/output/xml
>> make[2]: Nothing to be done for 'xml'.
>> Running Sphinx v3.2.0
>>
>> Extension error:
>> Could not import extension cdomain (exception: cannot import name 'c_funcptr_sig_re' from 'sphinx.domains.c' (/usr/lib/python3/dist-packages/sphinx/domains/c.py))
>> make[1]: *** [Documentation/Makefile:115: xmldocs] Error 2
>> make: *** [Makefile:1655: xmldocs] Error 2
>>
>> Distribution reports related to this issue:
>> https://bugs.debian.org/963636
>> https://bugs.archlinux.org/task/66178
>> https://bugs.archlinux.org/task/66156
> 
> As a workaround to make the documentation build again (but known that
> parts of the documentation will be broken), we could drop the cdomain
> extension.
> 
> Regards,
> Salvatore

@jon, do you have time to implement a patch?
.. sorry, I'am in a hurry :o

In the linked github issue you find also a patch that fixes a
cdomain.py.  I tested the patch (shee below) in the linux kernel.

   For me it works.

BTW: The patch of Documentation/sphinx/requirements.txt
was only nedded for a test.

   -- Markus --


---


diff --git a/Documentation/sphinx/cdomain.py b/Documentation/sphinx/cdomain.py
index cbac8e608dc4..65e15d48891e 100644
--- a/Documentation/sphinx/cdomain.py
+++ b/Documentation/sphinx/cdomain.py
@@ -31,16 +31,35 @@ u"""
         arguments types of function-like macros.

  """
+import re

  from docutils import nodes
  from docutils.parsers.rst import directives

  import sphinx
  from sphinx import addnodes
-from sphinx.domains.c import c_funcptr_sig_re, c_sig_re
  from sphinx.domains.c import CObject as Base_CObject
  from sphinx.domains.c import CDomain as Base_CDomain

+# C&P from commit https://github.com/return42/linuxdoc/commit/48f09de2
+# fixes 
https://github.com/sphinx-doc/sphinx/commit/0f49e30c51b5cc5055cda5b4b294c2dd9d1df573#r38750737
+
+# pylint: disable=invalid-name
+c_sig_re = re.compile(
+    r'''^([^(]*?)          # return type
+        ([\w:.]+)  \s*     # thing name (colon allowed for C++)
+        (?: \((.*)\) )?    # optionally arguments
+        (\s+const)? $      # const specifier
+    ''', re.VERBOSE)
+
+c_funcptr_sig_re = re.compile(
+    r'''^([^(]+?)          # return type
+        (\( [^()]+ \)) \s* # name in parentheses
+        \( (.*) \)         # arguments
+        (\s+const)? $      # const specifier
+    ''', re.VERBOSE)
+# pylint: enable=invalid-name
+
  __version__  = '1.0'

  # Get Sphinx version
diff --git a/Documentation/sphinx/requirements.txt 
b/Documentation/sphinx/requirements.txt
index 489f6626de67..f7486fd7ec85 100644
--- a/Documentation/sphinx/requirements.txt
+++ b/Documentation/sphinx/requirements.txt
@@ -1,3 +1,3 @@
  docutils
-Sphinx==2.4.4
+Sphinx==3.2.0
  sphinx_rtd_theme

Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13118C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0DCF206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="GjRAepnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgGHRar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:30:47 -0400
Received: from mout.web.de ([212.227.15.3]:33387 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgGHRaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1594229439;
        bh=Qm9nUxjTH7/LcRHGft+5nUsVdNRNQah5N8iu4Ri0VuI=;
        h=X-UI-Sender-Class:Subject:From:To:References:Cc:Date:In-Reply-To;
        b=GjRAepnkshiTsQ9em3HBm2Td8UMWi8j7SFzcoyjMaW2DHit5PTMr3JSCfbZHlD6Kn
         7DZYy/FaYLEBlK9pCXd9fYmlYuVJNItu50AgnKizpQHuj68ocosyM4/55gegOTREwB
         GbGPMPFqb6rTpmFL5mw6l5hYUCqAtlUe/UeFmsT4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.36.188]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MSaea-1kId4N01MC-00RXza; Wed, 08
 Jul 2020 19:30:39 +0200
Subject: [PATCH] Coccinelle: Add a SmPL script for the reconsideration of
 function calls before return statements
From:   Markus Elfring <Markus.Elfring@web.de>
To:     Coccinelle <cocci@systeme.lip6.fr>,
        kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <4b3bb651-5db0-021c-cbea-347eda0e95e0@web.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <de887f9e-8db2-7839-5665-8d38e75aaddc@web.de>
Date:   Wed, 8 Jul 2020 19:30:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <4b3bb651-5db0-021c-cbea-347eda0e95e0@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Dwkuhtk1JpJTmBTR83yd39SchmPuHBc/GUwr09P493uXplIJSKM
 kIKThL9eJHYRwFRA+zR9D2GAOIuPFMAMD3x/p1ac/rHyGQAV8dE2ztS5ouCDfYw+ldLm7vp
 3IjGIxMI8K+92gzJl44knUOW+ibPU7KGvOJ8eYaUomAgzxwpEab970z0RHZYV+7ptf7ZZHO
 0Qr+sIXxHLcb6R4LMy4WA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lIZw8oThuUM=:FqpzNhvLwBUY5FYI4izHi8
 zNL50nYZcVKRYzSHs6sQzj/9dmJxlLYz+uJfR3PtWVuY38ciObft5wf+rOKc3BLEDyD1L2hYg
 wP/a1F+Ew/CNx/+i5CvcbL6WEUuNhyHEXvr08FP9uHN5m8JX0HuwKna5Q/rgAfhT/uCOdm8oX
 6/g9sFiP+KHM2+gss6C4vaujuc250QPeFdHf8as4K8WveY0DkB/oZXxCbYir882aNIjO8jsiF
 WE1PvhMrnqprDKP1dArK/JP50katclSSp+nx1WGWPi45Dd7m9zyHix+M5M3PIkZ0zPXFNwUEn
 xnSTVLRBKD5hs0KC5XBnTJ/rt/9tBVHjOMiZBnbpQu9hqXml9ZE82y8WQihOHVP7nTPhsZhiN
 szgfScQT3u1oipBX03gm2mkBEiIbxgH3/N9/CeXVCPCAQh6GO/QhGn8RahiQdDPbajwNtabQB
 SDuOgbvIR/yT3enh0GtcYUqodmIaAVJI7lJ1LK8CGyLBt1Gmf58f65WBwMIHODQool7W1k3/t
 8DPyS5sqxNctvKRrAXP0wAPS0MTjLv0CoTa8QaHHJXarWxThwbyLISUxgctBqzOCaUoepjGLK
 /P4qJa9UbYE+Q7DvfyHWIgeXyOzy5Dw2ihgD7p9ANW/knwc3LVGO/kVBBNWzXZBPsDiyyUxE0
 2rLglPvtsvv8MW1AcNglbnEg6nDY22Aedai6udfGh9QyuYqv+P7WeJHTMw7kHtUnNPkmqM8Hy
 +mjVheH2rX3lQjr94cgpwk1S8mdQ/Jtr48vXrWCuUVltC1aeMliggPsCJ54jjLmH1C/ZaCF1J
 Om5fS0OboaXuQSIKxv7m//afRKlF/6ef+mx/0VVYsouKXF3sPrcbzR9c2Uz0lzg1VWK4/dOS/
 QLe0x0jh6wd5WQ1WYON0zDQVO1PVk8llu2/+ooKWAvuimbAsSnYYrYI07mt396JX688fx/JGh
 YbtpWGu2QVSX4Jz0FHJpKlOe4bNv/gbxSw+hztGCRvRKnO8ipAFcsHgzOMkNsmn/ydKp4idKu
 7gvirIyxkXjwFAPGuPsBpLDheJSzqChqFfpyJLaCnCx/X13tr4dTeQA1d5QOKz0Hx/xIR11y1
 i7YBjLbgMYsPfyw4BCUH70nzZogzTtsr5vDRJEOqgp8DfXHsBa6VLGss+pKYI77+7LGg/EJa+
 eGGtnAhE58NmP9iWMnXjr26IziZeaDn9RWVR7E0iSJp/l/ZkU7hgrU2sOaaV/CYZBxORxR56p
 7qLzb9D4o5MLix70573U+2z2jFP6FoiITfWBq2Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 8 Jul 2020 19:09:59 +0200

It can happen that function implementations with the return type =E2=80=9C=
void=E2=80=9D
call a special function at the end of if branches.
Such calls are occasionally followed by an immediate return.
The same function can be called at the end of the function implementation.
Thus it can be helpful to replace previous function calls
by goto statements.

Provide design options for the adjustment of affected source code
by the means of the semantic patch language (Coccinelle software).

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 .../misc/goto_last_function_call.cocci        | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 scripts/coccinelle/misc/goto_last_function_call.cocci

diff --git a/scripts/coccinelle/misc/goto_last_function_call.cocci b/scrip=
ts/coccinelle/misc/goto_last_function_call.cocci
new file mode 100644
index 000000000000..92dcf3626c48
=2D-- /dev/null
+++ b/scripts/coccinelle/misc/goto_last_function_call.cocci
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0
+/// Reconsider function calls before a return statement in if branches.
+//
+// Keywords: duplicate function calls common exception handling
+// Confidence: Low
+// See also:
+// Clarification request =E2=80=9CAdding labels without indentation befor=
e specific statements?=E2=80=9D
+// https://lore.kernel.org/cocci/4b3bb651-5db0-021c-cbea-347eda0e95e0@web=
.de/
+
+virtual context, patch, report, org
+
+@display depends on context@
+expression action;
+expression list el;
+identifier work;
+@@
+ void work(...)
+ {
+ <+...
+ if (...)
+ {
+    ...
+*   action(el);
+*   return;
+ }
+ ...+>
+*action(el);
+ }
+
+@replacement depends on patch@
+expression action, condition;
+expression list el;
+identifier work;
+@@
+ void work(...)
+ {
+ <+...
+(
+-if (condition)
+-{
+-   action(el);
+-   return;
+-}
++if (condition)
++   goto last_action;
+|
+ if (...)
+ {
+    ...
+-   action(el);
+-   return;
++   goto last_action;
+ }
+)
+ ...+>
++last_action:
+ action(el);
+ }
+
+@or depends on org || report@
+expression action;
+expression list el;
+identifier work;
+position p;
+@@
+ void work(...)
+ {
+ <+...
+ if (...)
+ {
+    ...
+    action(el);
+    return;
+ }
+ ...+>
+ action@p(el);
+ }
+
+@script:python to_do depends on org@
+p << or.p;
+@@
+coccilib.org.print_todo(p[0],
+                        "WARNING: The same function was called at the end=
 of an if branch before. Would you like to avoid duplicate function calls?=
")
+
+@script:python reporting depends on report@
+p << or.p;
+@@
+coccilib.report.print_report(p[0],
+                             "WARNING: The same function was called at th=
e end of an if branch before. Would you like to avoid duplicate function c=
alls?")
=2D-
2.27.0


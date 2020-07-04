Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F29BC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 15:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E160120826
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 15:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="KaPTBn58"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgGDPwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 11:52:22 -0400
Received: from mout.gmx.net ([212.227.15.18]:49151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgGDPwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 11:52:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1593877892;
        bh=tAtI5rS5UHUyRq0DpLyYLjxEsQq2XtSEjG4HHyuWRE8=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=KaPTBn58KwDtI+RAJoTdSRRO2RqVshAASEmbHz4ul5cZgdMYJZ0JDRLyoVX/Ja2bo
         VCaTmIlxuauNdxkSO/IEOoSQ42qs+MeojULRY7HcHwO+CQGmlVC3IaXew3P7b4EFqT
         J3H16MesehMKeQ5y3ih+CxOFGprxuQSpCbJcxvc0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.73.70]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MzhnH-1knAOb2GEz-00vhSn; Sat, 04 Jul 2020 17:51:32 +0200
From:   Oscar Carter <oscar.carter@gmx.com>
To:     Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Cc:     kernel-hardening@lists.openwall.com, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oscar Carter <oscar.carter@gmx.com>
Subject: [PATCH v2] parisc/kernel/ftrace: Remove function callback casts
Date:   Sat,  4 Jul 2020 17:50:57 +0200
Message-Id: <20200704155057.3959-1-oscar.carter@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:R5hfiGVWqGDQ+lgUWVBXTSSU4VXpztSPSCW5LLJmeHirtrL6qjS
 h/OkEOlAmkQWjNgwbAmZBSa18vPP+iqfKLX1U55rOelFaBbimJgHUQ++ryBIxErjaluqiMt
 RIzTxmbduIX0Te4N5eAl07WmZfV7y8e3KkR/b3vie7Da24pcW5tpc54brxK6iJQd4j0bTmC
 oYpkkQ5YWFw1jesnCFPEw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KPr6d6wU2Tk=:/XQpyyxWJW59BDAc3HhAH3
 IXHbCmVEp97xXSOOgw3mmkjjdvuOjilAakJ42ogmcW37xhPjuG+LBkIujb/40lbDwhI2sKR3o
 nw2ExcoF2Gfyu1RBajF8GQ9IYcl9gGYABYcHhsjwnYmijWCqvnXsikMaQ1VKSoLZoNx/bu+0F
 2CfJLJuMYfg1RisPaW4sJev9yiH0lPeRenDfWG6FC0nIUm2YVMuQd9gJkv3v1Q8L6jeQ2XFzc
 i5ecrrKCczi+Eekugon/tn200O31pD5v05hvJHXCqNch5DskoOlFNMXA1gtLfoL4oNkCBk84P
 95XHMl7bQuoFOLPDFzyPKWlvjRNhcRYAA4aNJx/UnRWPxms5sWppXqL2x+XrXZjnqDpv6Qb0m
 Hxah4Nysds2rJy04IjB3qQxXBTYMZ0vQuXsjH1DtB64/ANF9Fmhc5ZBp3iGVdL5Ce5taP+0z1
 68wHrNOfK9htjl+G4ZFl2fY0qh0PhCBOI1f/sk61sEJsp0rTPTzD1q3CzvymtjwFYorT9ubgk
 8iJAe6uOWEIAv1zg2/aorozWcGRGyGpgrZWpubv6OAOay9FZo/HkrwjQ7V0u4R9iRh0fmzWKG
 BeFKtNXjXeXXgaBXlrrysojX8CfzL8ZKxtUVyhdsZGhwV3qOiKaJ37Wb/YOX5t67DPsJrFC/o
 EXUA8fhlkNR4GpcgOhmgRS0dJTV7CyvOyrCFSYJgKxPOiRP5fcxq1+j2S6mlLTqiQap5ekY6e
 0uZs1XR3k4eMrLdxcTX6kcW22uj00lmKibRTiUIFp60Z1C5ppaM905kN7nRHUR93MYcmLik6a
 oHubOPv7Fslx49tL+K0EzCuoWpfxSCu2go5L4ZujE9WgmmcSW0n6t1iq/eJlfdlROcVZ5S3Ok
 wnQVb8V0cyFpjcQOFUgLLChyowo7x3lTATF5jtMIYYtDKliZMh2n2LFVXpLoB8LxL7MwPJRg1
 +j1HEHL43UUeox/AocpLz29sVHEfLZc9/8dRDDrCK598eDdcaJBxi0b1QaeN3A+fhTBgQB04B
 XTOK3vljJGNbTxfl9KkqXfecWjdJI8UHy1dRiYRppNb9lLAl5ogm1xZzroDF7A2MyG40WFtGK
 VYmOFabofs9uEkQZZF8A0A7mmVbYyDRlCZ+wWbEEZeOrmC2Ikt22MYMhE9PaIFca/CbQqaD4s
 KprKJSzGlLU8Bt+fqqZwUpqd5pgYHicIJiLEDIfoNKojbL53ODavYRlZ5SZg55XXdaTlBLkXw
 bsFBe4bDUCsu/sDF+zwCgueVfXEs9SF69YsjqCw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In an effort to enable -Wcast-function-type in the top-level Makefile to
support Control Flow Integrity builds, remove all the function callback
casts.

To do this add an inline function helper to get the address of a
function. This helper uses the "dereference_function_descriptor" as the
parisc64 architecture uses function descriptors instead of direct
addresses for functions.

Then, remove the cast to a function pointer type in the comparison
statement and use the function helper to get the address of every
function in the right and left operand. This can be done since the
comparison is against function address (these operands are not function
calls).

Co-developed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Oscar Carter <oscar.carter@gmx.com>
=2D--
Hi,

I have added the Co-develop-by tag and Signed-off-by tag to give credit to
Helge Deller if there are no objections.

Thanks.

Changelog v1->v2
- Use the function "dereference_function_descriptor" to get the function
  address instead of a direct cast to unsigned long type.
- Modify the commit changelog accordingly.
- Add the Co-developed-by tag and Signed-off-by tag to give credit to Helg=
e
  Deller.

 arch/parisc/kernel/ftrace.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/ftrace.c b/arch/parisc/kernel/ftrace.c
index 1df0f67ed667..c53576890881 100644
=2D-- a/arch/parisc/kernel/ftrace.c
+++ b/arch/parisc/kernel/ftrace.c
@@ -24,6 +24,11 @@
 #define __hot __attribute__ ((__section__ (".text.hot")))

 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
+static inline unsigned long ftrace_get_function_address(void *function)
+{
+	return (unsigned long)dereference_function_descriptor(function);
+}
+
 /*
  * Hook the return address and push it in the stack of return addrs
  * in current thread info.
@@ -64,7 +69,8 @@ void notrace __hot ftrace_function_trampoline(unsigned l=
ong parent,
 				function_trace_op, regs);

 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
-	if (ftrace_graph_return !=3D (trace_func_graph_ret_t) ftrace_stub ||
+	if (ftrace_get_function_address(ftrace_graph_return) !=3D
+	    ftrace_get_function_address(ftrace_stub) ||
 	    ftrace_graph_entry !=3D ftrace_graph_entry_stub) {
 		unsigned long *parent_rp;

=2D-
2.20.1


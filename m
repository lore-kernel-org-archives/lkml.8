Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7E5C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 17:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D0E32521A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 17:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730538AbgFURmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 13:42:44 -0400
Received: from smtprelay0122.hostedemail.com ([216.40.44.122]:39284 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730524AbgFURmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 13:42:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 9471A18224D6E;
        Sun, 21 Jun 2020 17:42:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: top74_3b0614726e2c
X-Filterd-Recvd-Size: 2913
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sun, 21 Jun 2020 17:42:39 +0000 (UTC)
Message-ID: <2c60a30eb1fd3616fccd496e76d3d1cc54afc732.camel@perches.com>
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones:
 Documentation/process
From:   Joe Perches <joe@perches.com>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tony Fischetti <tony.fischetti@gmail.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>, Will Deacon <will@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacob Huisman <jacobhuisman@kernelthusiast.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Date:   Sun, 21 Jun 2020 10:42:38 -0700
In-Reply-To: <b7ba0047-8993-d3bf-327c-1fb70bc0282c@al2klimov.de>
References: <20200621133630.46435-1-grandmaster@al2klimov.de>
         <CANiq72kA==S-G481VHx2qrKkJmaVK7ZOuYmin4xVr3XKB8x8ug@mail.gmail.com>
         <b7ba0047-8993-d3bf-327c-1fb70bc0282c@al2klimov.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-06-21 at 16:30 +0200, Alexander A. Klimov wrote:
> Am 21.06.20 um 15:46 schrieb Miguel Ojeda:
> > On Sun, Jun 21, 2020 at 3:37 PM Alexander A. Klimov
> > <grandmaster@al2klimov.de> wrote:
[]
> > >              Replace HTTP with HTTPS.
[]
> W/o a 
> such central "rule on how to HTTPSify links"

Maybe:
---
 scripts/checkpatch.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 524df88f9364..4e49187a6137 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3115,6 +3115,12 @@ sub process {
 			}
 		}
 
+# check for URLs using old http:// links, suggest https:
+		if ($rawline =~ m{^\+.*\bhttp://}) {
+			WARN("HTTP_URL",
+			     "Prefer URLs using https: over http:\n" . $herecurr);
+		}
+
 # discourage the use of boolean for type definition attributes of Kconfig options
 		if ($realfile =~ /Kconfig/ &&
 		    $line =~ /^\+\s*\bboolean\b/) {



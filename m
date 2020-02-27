Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7173DC4BA06
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 07:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A4824687
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 07:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582788370;
	bh=HLZWdqbAPMZ47PNc0H2ux9LQJw1VSgzcwfP53Z+s45c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ylvi4i3Lpgko2A9GzINpcqOwhgzr9KQWfdeg4zLy+YsHGsWCp7Gys7HDFl9k5stNy
	 Npix5HLhZIIDNIMvXYYBMP7wKVR9Mi2fGv3TefV+VGjRfMfZ+2SIsGtAHOy3r6cbx0
	 aIy0XbnXMHCptWo6rtzhmJuSxMVEjx7zx7y6Zp7Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgB0H0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 02:26:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:37494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbgB0H0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 02:26:07 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7381324683;
        Thu, 27 Feb 2020 07:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582788366;
        bh=HLZWdqbAPMZ47PNc0H2ux9LQJw1VSgzcwfP53Z+s45c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z58VXo/dwtzPLO0ts9ifQzzjRWlYu+i4Y7wSftEKUVDovfk0EpQwf+s93o+8z3xgU
         4YNCOzBm/ol5W/aFCM9Jf98ZtMWh0hKc5eFn0pmZr2rp1tdEPCbMX347vPEFUNNIOF
         7eDXTOoUsjJy9eCqebmuHU9XTNUWHuduH6ItyPaU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH 2/2] Documentation: bootconfig: Add EBNF syntax file
Date:   Thu, 27 Feb 2020 16:26:02 +0900
Message-Id: <158278836196.14966.3881489301852781521.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <158278834245.14966.6179457011671073018.stgit@devnote2>
References: <158278834245.14966.6179457011671073018.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an extended Backus–Naur form (EBNF) syntax file for
bootconfig so that user can logically understand how they
can write correct boot configuration file.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 Documentation/admin-guide/bootconfig.ebnf |   41 +++++++++++++++++++++++++++++
 Documentation/admin-guide/bootconfig.rst  |    8 ++++++
 MAINTAINERS                               |    1 +
 3 files changed, 50 insertions(+)
 create mode 100644 Documentation/admin-guide/bootconfig.ebnf

diff --git a/Documentation/admin-guide/bootconfig.ebnf b/Documentation/admin-guide/bootconfig.ebnf
new file mode 100644
index 000000000000..fe27007dc23f
--- /dev/null
+++ b/Documentation/admin-guide/bootconfig.ebnf
@@ -0,0 +1,41 @@
+# Boot Configuration Syntax in EBNF
+
+# Characters
+digit = "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" ;
+alphabet = "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" | "i" | "j" | "k"
+	| "l" | "m" | "n" | "o" | "p" | "q" | "r" | "s" | "t" | "u" | "v"
+	| "w" | "x" | "y" | "z" | "A" | "B" | "C" | "D" | "E" | "F" | "G"
+	| "H" | "I" | "J" | "K" | "L" | "M" | "N" | "O" | "P" | "Q" | "R"
+	| "S" | "T" | "U" | "V" | "W" | "X" | "Y" | "Z" ;
+white space = ? white space characters (isspace() compatible ) ? ;
+all characters = ? all visible characters (isprint() compatible ) ? ;
+
+# Value definition
+value delimiter = "," | ";" | "\n" | "}" | "#" ;
+value string = { all characters - value delimiter } ;
+single quoted string = "'" , { all characters - "'" } , "'" ;
+double quoted string = '"' , { all characters - '"' } , '"' ;
+quoted string = double quoted string | single quoted string ;
+value = { white space }, quoted string | value string , { white space } ;
+
+# Non array value is equal to one-element array
+comment = "#" , { all characters - "\n" } , "\n" ;
+array delimiter = "," , { { white space }, ( comment | "\n" ) } ;
+array = { value , array delimiter } , value ;
+
+# Key definition
+key word character = alphabet | digit | "-" | "_" ;
+key word = { key word character } , key word character ;
+key = { white space } , { key word , "." } , key word , { white space } ;
+
+# Assignment definitions
+delimiter = { white space } , ( comment | ";" | "\n" ) ;
+assign operator = [ "+" ] , "=" ;
+assignment = key , [ assign operator , array ] ;
+assignment tree = key , "{" , { assignment sequence } , [ assignment ] , "}" ;
+assignment sequence = ( assignment , delimiter ) | assignment tree
+	| delimiter | white space ;
+
+# Boot configuration definition
+configuration = { assignment sequence } , (assignment | assignment tree)
+	, { delimiter | white space } ;
diff --git a/Documentation/admin-guide/bootconfig.rst b/Documentation/admin-guide/bootconfig.rst
index 4bac98250bc0..8d336af948a8 100644
--- a/Documentation/admin-guide/bootconfig.rst
+++ b/Documentation/admin-guide/bootconfig.rst
@@ -188,6 +188,14 @@ Note that you can not put a comment between value and delimiter(``,`` or
  key = 1 # !ERROR! comment is not allowed before delimiter
        ,2
 
+Syntax in EBNF
+--------------
+
+Here is the boot configuration file syntax written in EBNF.
+
+.. include:: bootconfig.ebnf
+   :literal:
+
 
 /proc/bootconfig
 ================
diff --git a/MAINTAINERS b/MAINTAINERS
index 47873f2e6696..3e792f0a2237 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15778,6 +15778,7 @@ F:	fs/proc/bootconfig.c
 F:	include/linux/bootconfig.h
 F:	tools/bootconfig/*
 F:	Documentation/admin-guide/bootconfig.rst
+F:	Documentation/admin-guide/bootconfig.ebnf
 
 SUN3/3X
 M:	Sam Creasey <sammy@sammy.net>


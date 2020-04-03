Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E77C2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3E8206F6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="DjhDXCzb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xLEZttoh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403870AbgDCRHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:07:25 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:34715 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728069AbgDCRHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:07:25 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 3AD535C0348;
        Fri,  3 Apr 2020 13:07:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 03 Apr 2020 13:07:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=BuSbOOS98bnGguD48Whxfaqib+
        qZKhz5N9W1r3wN3ek=; b=DjhDXCzb10cj8sS7/Wv/JKmySCvnMfA4RgKJ08i5IR
        qwcswnqet44YWw53IrsYTizO6tXvwG55aw+YVPEwjw4SwO4N7qeM3G5Rx7WkhYLj
        deA5fbb/RrKhxkvDoJ7Y8gVzciYQziyNa3JVbqWsDM7OSgS9RJvUtJ+2Zo+bjlA8
        RhRy3/CLj4VQ8bB71oPl3PDbBl5Lp4j+qorslROT63zbMxxnZaMfzFsmT16nQ+6f
        grLs8EO0YigV7bcexERmBMtX3IJOg/oh2V78mpokMOwMP3ZuMOtHC/YIPa5Jx27r
        hIeWFkz14+1h5+zPXg0G/QWPXNqVvrKj8eqbkTYWuPGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=BuSbOOS98bnGguD48
        Whxfaqib+qZKhz5N9W1r3wN3ek=; b=xLEZttohdp0dOostB8EKiInhZIz+pV5kF
        G1n5GEVnPfFpxWp9TzrUrwD/qxe0DoMjsrpkXvxH1Sflcf32TZ4ExCkLLKERe4rk
        RgTwws/dKxcm3Kk8VE0Lb4+vAp+RDG2LqceFz/8/VYBI4ipJO+ya2jkJM+lJxsie
        gua086nrmW0Dt7I006NTNu+ErZGxLZF80aBUFzghOr4fh4beJ3IFEUhLQ1f9REGH
        TwMDn23Z+VN1LDiFtPy+ugFqsYGuL/8v94j9R+9nXBcvRZTDBcAEZgJYWhPZI0xU
        z45WpP5YXFV2HlDf+dlClZ6ATz5EOZ1kWpZXgjblzGHuvEW36D93g==
X-ME-Sender: <xms:S22HXm1dWnp15H82qHHtoTvZtFcLX9ak3I5voJI3aZa_JcARWMUCiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrtdeigddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeetlhihshhsrgcu
    tfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucfkphepkeegrddukeegrddvfeegrd
    dukedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhep
    qhihlhhishhsseigvddvtddrqhihlhhishhsrdhnvght
X-ME-Proxy: <xmx:S22HXmmY02gzhTOdsowfKaVdNLOrJrRWnFLFPiYVsKm0kXsnhziBjw>
    <xmx:S22HXhgumOmRIeGKL0xC5h7FQ2lSkBswa7zqMCyW2-iveTTtaoF6Qg>
    <xmx:S22HXtR9zEQivseN4eIVBpY8980ZdjbPlAs5QXTuj34nrsSxU-JzYw>
    <xmx:TG2HXsGXDrbQJPSrRUd8Nnm9e8d0isPKC1dIfQugp7PmW983Yh6UFA>
Received: from x220.qyliss.net (p54b8eab6.dip0.t-ipconnect.de [84.184.234.182])
        by mail.messagingengine.com (Postfix) with ESMTPA id 73FBB306CF5E;
        Fri,  3 Apr 2020 13:07:23 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
        id 8D3D04D4; Fri,  3 Apr 2020 17:07:21 +0000 (UTC)
From:   Alyssa Ross <hi@alyssa.is>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Alyssa Ross <hi@alyssa.is>
Subject: [PATCH] Documentation: sysrq: fix RST formatting
Date:   Fri,  3 Apr 2020 17:07:01 +0000
Message-Id: <20200403170701.10852-1-hi@alyssa.is>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"On x86" and "On SPARC" are now definition list terms, like
"On PowerPC", "On other", and "On all".

The Credits list is now a bulleted list, like lots of Credits lists in
other files.  This prevents the list from becoming a single long,
unpunctuated sentence in the generated documentation.

I also did a couple of other tiny readability improvements to the
"How do I use the magic SysRq key?" section while I was there.

Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
 Documentation/admin-guide/sysrq.rst | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
index 72b2cfb066f4..a46209f4636c 100644
--- a/Documentation/admin-guide/sysrq.rst
+++ b/Documentation/admin-guide/sysrq.rst
@@ -48,9 +48,10 @@ always allowed (by a user with admin privileges).
 How do I use the magic SysRq key?
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-On x86   - You press the key combo :kbd:`ALT-SysRq-<command key>`.
+On x86
+	You press the key combo :kbd:`ALT-SysRq-<command key>`.
 
-.. note::
+	.. note::
 	   Some
            keyboards may not have a key labeled 'SysRq'. The 'SysRq' key is
            also known as the 'Print Screen' key. Also some keyboards cannot
@@ -58,14 +59,15 @@ On x86   - You press the key combo :kbd:`ALT-SysRq-<command key>`.
 	   have better luck with press :kbd:`Alt`, press :kbd:`SysRq`,
 	   release :kbd:`SysRq`, press :kbd:`<command key>`, release everything.
 
-On SPARC - You press :kbd:`ALT-STOP-<command key>`, I believe.
+On SPARC
+	You press :kbd:`ALT-STOP-<command key>`, I believe.
 
 On the serial console (PC style standard serial ports only)
         You send a ``BREAK``, then within 5 seconds a command key. Sending
         ``BREAK`` twice is interpreted as a normal BREAK.
 
 On PowerPC
-	Press :kbd:`ALT - Print Screen` (or :kbd:`F13`) - :kbd:`<command key>`,
+	Press :kbd:`ALT - Print Screen` (or :kbd:`F13`) - :kbd:`<command key>`.
         :kbd:`Print Screen` (or :kbd:`F13`) - :kbd:`<command key>` may suffice.
 
 On other
@@ -73,7 +75,7 @@ On other
         let me know so I can add them to this section.
 
 On all
-	write a character to /proc/sysrq-trigger.  e.g.::
+	Write a character to /proc/sysrq-trigger.  e.g.::
 
 		echo t > /proc/sysrq-trigger
 
@@ -282,7 +284,7 @@ Just ask them on the linux-kernel mailing list:
 Credits
 ~~~~~~~
 
-Written by Mydraal <vulpyne@vulpyne.net>
-Updated by Adam Sulmicki <adam@cfar.umd.edu>
-Updated by Jeremy M. Dolan <jmd@turbogeek.org> 2001/01/28 10:15:59
-Added to by Crutcher Dunnavant <crutcher+kernel@datastacks.com>
+- Written by Mydraal <vulpyne@vulpyne.net>
+- Updated by Adam Sulmicki <adam@cfar.umd.edu>
+- Updated by Jeremy M. Dolan <jmd@turbogeek.org> 2001/01/28 10:15:59
+- Added to by Crutcher Dunnavant <crutcher+kernel@datastacks.com>
-- 
2.24.1


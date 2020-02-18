Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE70CC3404C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8AFC2465A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582055972;
	bh=AQXNCwSq4Z50V5yHlLV51EKDB3lSCNe9jOBAJff5fh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SOfPVhX1B/HJV9XzK0J1mgMfYsU0VMSn2fZNFK48gA2WUlvRk1G8uDf6mnJa6Xota
	 zWqR98+JjrIXVV+fyd8JJxgwWBQ3RjfeFXc128vyMwzXHRYIdWARBqZg/wAiUxAdCO
	 lvPHNA9gYCLSIaWnf5o2x7LFvitUG6IBPOuRVv4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgBRT7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:59:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728426AbgBRT73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:59:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41F542465A;
        Tue, 18 Feb 2020 19:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582055968;
        bh=AQXNCwSq4Z50V5yHlLV51EKDB3lSCNe9jOBAJff5fh4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ajPgpnQt/Gmkd5PUiUhHexmQc5m12GuBH4UwRhurzlSF6TupROZba/H7WeWuVsMyM
         Ro+r3aho14tAMjgWZrzsssfij0OeVatJNQBTuAKzSAJENu+3ZbUIiNsPoyqxgATRXa
         wWzvYrWoLB/CO7sD+yNbe6CGwdBH5trjpNms0QMY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 5.4 49/66] s390/time: Fix clk type in get_tod_clock
Date:   Tue, 18 Feb 2020 20:55:16 +0100
Message-Id: <20200218190432.572394728@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200218190428.035153861@linuxfoundation.org>
References: <20200218190428.035153861@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

commit 0f8a206df7c920150d2aa45574fba0ab7ff6be4f upstream.

Clang warns:

In file included from ../arch/s390/boot/startup.c:3:
In file included from ../include/linux/elf.h:5:
In file included from ../arch/s390/include/asm/elf.h:132:
In file included from ../include/linux/compat.h:10:
In file included from ../include/linux/time.h:74:
In file included from ../include/linux/time32.h:13:
In file included from ../include/linux/timex.h:65:
../arch/s390/include/asm/timex.h:160:20: warning: passing 'unsigned char
[16]' to parameter of type 'char *' converts between pointers to integer
types with different sign [-Wpointer-sign]
        get_tod_clock_ext(clk);
                          ^~~
../arch/s390/include/asm/timex.h:149:44: note: passing argument to
parameter 'clk' here
static inline void get_tod_clock_ext(char *clk)
                                           ^

Change clk's type to just be char so that it matches what happens in
get_tod_clock_ext.

Fixes: 57b28f66316d ("[S390] s390_hypfs: Add new attributes")
Link: https://github.com/ClangBuiltLinux/linux/issues/861
Link: http://lkml.kernel.org/r/20200208140858.47970-1-natechancellor@gmail.com
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/include/asm/timex.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -155,7 +155,7 @@ static inline void get_tod_clock_ext(cha
 
 static inline unsigned long long get_tod_clock(void)
 {
-	unsigned char clk[STORE_CLOCK_EXT_SIZE];
+	char clk[STORE_CLOCK_EXT_SIZE];
 
 	get_tod_clock_ext(clk);
 	return *((unsigned long long *)&clk[1]);



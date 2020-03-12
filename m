Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB58C0044D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618CC2074D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UleuOCyz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbgCLAKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 20:10:12 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42985 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731418AbgCLAKL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 20:10:11 -0400
Received: by mail-qt1-f194.google.com with SMTP id g16so3019239qtp.9
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 17:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Qc/yKi3r5phF37+WiquQaUgtp6vC7iVWg5HXpKVNHvY=;
        b=UleuOCyzScWPzaYnbq5Vl4d9u/jYen5HaFT4NjASEaVmKSLebHkxpuzDgqGWwJEPU+
         RcBSWcy7xhAmGMJBjx485y/rbmdoBOgZiBDljVp074P/by3anY3lGdAUXV12OPEKofSP
         ZK49zx85MNrptMRKu4UI3e+q7O+VVLG2Qz+587tu9kKpZRUbGvu/TVoSi+mRX0Aty8Yc
         U4xu3UvMxHqHpHgDQs90A+2cFmwYM3alc6hccB75Fddps+HgN6Kj1OHO90xl4nX1jDaP
         RcLk/N5RXF0hEp2nzrSrpMQKj0vXsVfKjWx+4nbv9R7Ts5YpkNEAGDqamLGcFvb0bZTG
         vNaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qc/yKi3r5phF37+WiquQaUgtp6vC7iVWg5HXpKVNHvY=;
        b=V7y2cqiQmPl16w41oGXMhQ4TTAnhoY9pTFN4F7YDhuaATyI/bI/uNCw7xLS7XDxrNm
         orJ3A1jPbv2T3o8oZ8CFsEUtpJ3DOXivYi6uKYKaoeVgmkLXz5XeggXrgXvvJcZwqqIn
         2r3me/DQ8SjeB2/N+lJtn+uzveQBSvdk0lWHrdl1wSzMrfUNb2wvFs+VrOqA4R73wiO9
         sRVJDRuWvN8BHAdWeDp4yoj6CoTA+w+Mddfija9kTXF3A6p5WKcu8TAH2tyxdD5zAkrb
         wWPVFJghkYOhSJn2+wFSonmWJDae8ieqI2yCOB5Ot9GypU4Lchus17oaWGlQEYmXOeCa
         JViw==
X-Gm-Message-State: ANhLgQ0MZqGhqYfa2pPjYCk3epWg/OAcdxcA0rBve5/dYFYBuniIDE9g
        UdmJswAKj0DLV8YU2duzgqw=
X-Google-Smtp-Source: ADFU+vsqUIyMwwS7FG7fCqKbhNQ/W74LVZ8XcWboYSPZmIH9X0r1+tC+dgyj501iQfZ6mDw9855fcg==
X-Received: by 2002:ac8:4659:: with SMTP id f25mr5002889qto.273.1583971810279;
        Wed, 11 Mar 2020 17:10:10 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id m1sm4683932qtm.22.2020.03.11.17.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 17:10:10 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 11 Mar 2020 20:10:08 -0400
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] x86/purgatory: Make sure we fail the build if
 purgatory.ro has missing symbols
Message-ID: <20200312001006.GA170175@rani.riverdale.lan>
References: <20200311214601.18141-1-hdegoede@redhat.com>
 <20200311214601.18141-3-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200311214601.18141-3-hdegoede@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 10:46:01PM +0100, Hans de Goede wrote:
> Since we link purgatory.ro with -r aka we enable "incremental linking"
> no checks for unresolved symbols is done while linking purgatory.ro.
> 

Do we actually need to link purgatory with -r? We could use
--emit-relocs to get the relocation sections generated the way the main
x86 kernel does, no?

Eg like the below? This would avoid the double-link creating
purgatory.chk.

diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
index fb4ee5444379..5332f95ca1d3 100644
--- a/arch/x86/purgatory/Makefile
+++ b/arch/x86/purgatory/Makefile
@@ -14,8 +14,8 @@ $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
 
 CFLAGS_sha256.o := -D__DISABLE_EXPORTS
 
-LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined -nostdlib -z nodefaultlib
-targets += purgatory.ro
+LDFLAGS_purgatory := -e purgatory_start --emit-relocs -nostdlib -z nodefaultlib
+targets += purgatory
 
 KASAN_SANITIZE	:= n
 KCOV_INSTRUMENT := n
@@ -55,7 +55,7 @@ CFLAGS_sha256.o			+= $(PURGATORY_CFLAGS)
 CFLAGS_REMOVE_string.o		+= $(PURGATORY_CFLAGS_REMOVE)
 CFLAGS_string.o			+= $(PURGATORY_CFLAGS)
 
-$(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
+$(obj)/purgatory: $(PURGATORY_OBJS) FORCE
 		$(call if_changed,ld)
 
 targets += kexec-purgatory.c
@@ -63,7 +63,7 @@ targets += kexec-purgatory.c
 quiet_cmd_bin2c = BIN2C   $@
       cmd_bin2c = $(objtree)/scripts/bin2c kexec_purgatory < $< > $@
 
-$(obj)/kexec-purgatory.c: $(obj)/purgatory.ro FORCE
+$(obj)/kexec-purgatory.c: $(obj)/purgatory FORCE
 	$(call if_changed,bin2c)
 
 obj-$(CONFIG_KEXEC_FILE)	+= kexec-purgatory.o

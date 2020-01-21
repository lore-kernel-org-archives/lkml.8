Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 251D1C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 20:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E29FA24125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 20:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="qpV6PRjk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgAUUVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 15:21:38 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45789 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbgAUUVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 15:21:37 -0500
Received: by mail-qt1-f196.google.com with SMTP id w30so3741776qtd.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 12:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=c/3ImOVwIp32mGHoKfubejJz3W+3PLWFevS4CW0Ta1U=;
        b=qpV6PRjk2iTeaxz0NCEYt6HBBeFcUz94ShMyioSHhDAUM2DpgrKsfGd+8+NXogSHbT
         Th3lJsLYlmR/Waz8Chjmnsp9JW63OwCVODW3fb1nYdvszZuf+WlBLLUzfy+YzMuPnIpz
         yz/P/Ky76hzEOGUubLuSTwrzNc+9YkwOqDfzvGjO+DFpcDGHQH96jBwAopvSD5bPXboa
         SKO6kUnNK6MYdWbwwdwqf2J/mueaKNFNq5/X00aD2lGqyeGE43tzCg4d6L2RPUNzlgri
         uv5PZQQYWIjfYlMCGE5+F60sX8OS/1J02L8Qk3r7vCFy7b0PdhcoHMPUEjZXE775LOGo
         j3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=c/3ImOVwIp32mGHoKfubejJz3W+3PLWFevS4CW0Ta1U=;
        b=Wx7nIYyAfhg2VpSQ+mk0LUP8hVnly+8HDIdnEvLxnygqOpkywvOnxMQMSPINnNO1oj
         WOsFUmrwzdalxyHGFEgXhdTqJcjHoxbE26o8tXonS4hHBeP+4TJUPde7T8DK/A3AoePi
         6VsbNgkh9tfxrpUtTSWXUMXbCb/wwobo9jmotflQky3e45g88x4xAUqBEl8qysamW+PC
         hhR9g6XhuVmJNGcYTtGeJPjF0x9MepAd3Jf9ns4d5PtXbWWD8fCzX5iqRtua73GOhYlR
         KHNWWqnUjtTona2IIWYsn2LhtqV988M7Gvo2skhfNeDXaDWm78mEFlMJ6tqpnY6egJFa
         jRtw==
X-Gm-Message-State: APjAAAVpP23ORNGhGV7E2QkWw0j6FOL6bHdOwD/ULEeYf/F+HKaItCWx
        6PF9lGqOLM5mYvEhMcPEfuPiFw==
X-Google-Smtp-Source: APXvYqw5dIknH1Wsq5sEFP5EywZ2rt0xaJA+uoiOgNW6L+rkqDVZXuk6AfzfZ2cm2h0W4kevMQVJ6Q==
X-Received: by 2002:ac8:1415:: with SMTP id k21mr6586641qtj.300.1579638096684;
        Tue, 21 Jan 2020 12:21:36 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x8sm17745331qki.60.2020.01.21.12.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jan 2020 12:21:36 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH -next] x86/mm/pat: silence a data race in cpa_4k_install
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200121154528.GK7808@zn.tnic>
Date:   Tue, 21 Jan 2020 15:21:35 -0500
Cc:     Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <E9162CDC-BBC5-4D69-87FB-C93AB8B3D581@lca.pw>
References: <20200121151503.2934-1-cai@lca.pw>
 <CANpmjNPR+mbadR0DDKGUhTkaXJi=vsHmhvq3+Rz0Hrx=E9V_Qg@mail.gmail.com>
 <20200121152853.GI7808@zn.tnic> <44A4276D-5530-4DAA-8FC7-753D03ADD2F3@lca.pw>
 <CANpmjNO7mTEMc6pvpVVXdu2r6cMg_N8QkRffEHHG-WNFXE4CjA@mail.gmail.com>
 <20200121154528.GK7808@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 21, 2020, at 10:45 AM, Borislav Petkov <bp@alien8.de> wrote:
> 
> On Tue, Jan 21, 2020 at 04:36:49PM +0100, Marco Elver wrote:
>> Isn't the intent "x86/mm/pat: Mark intentional data race" ?  The fact
>> that KCSAN no longer shows the warning is a side-effect.  At least
>> that's how I see it.
> 
> Perhaps because you've been dealing with KCSAN for so long. :-)
> 
> The main angle here, IMO, is that this "fix" is being done solely for
> KCSAN. Or is there another reason to "fix" intentional data races? At
> least I don't see one. And the text says
> 
> "This will generate a lot of noise on a debug kernel with
> debug_pagealloc with KCSAN enabled which could render the system
> unusable."
> 
> So yes, I think it should say something about making KCSAN happy.
> 
> Oh, and while at it I'd prefer it if it did the __no_kcsan function
> annotation instead of the data_race() thing.

Actually "__no_kcsan" does not work because I have
CONFIG_OPTIMIZE_INLINING=y (GCC 8.3.1) here, so it has to be,

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 20823392f4f2..fabbf8a33b7f 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -126,7 +126,7 @@ static inline void cpa_inc_2m_checked(void)
        cpa_2m_checked++;
 }
 
-static inline void cpa_inc_4k_install(void)
+static inline void __no_kcsan_or_inline cpa_inc_4k_install(void)
 {
        cpa_4k_install++;
 }

Are you fine with it or data_race() looks better? 

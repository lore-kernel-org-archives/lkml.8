Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85CB9C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C6E9217F4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 22:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="lMB9oxYb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgBNWzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 17:55:39 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38878 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbgBNWzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 17:55:39 -0500
Received: by mail-pg1-f193.google.com with SMTP id d6so5654913pgn.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 14:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=9BMR/1ljfo4sHSBuMNZ+z5Tv5CN3Fmzs3LXwrUy/C1M=;
        b=lMB9oxYbtxwZWaVxgPBrpGz3OfFoEKkkUMWGNVnlsm3iFyaCa0cjEmOXHQj2nzc+VT
         B7brjzcauvcMJokIGxHtpFuUTSCq4aWZpiHSjdUJRfFz5JX2uXlkKoOxVAUcrCDi4Sh7
         bvqG5k2c05sfl0lm44DR7VYwR06+QYS2c3cj12dJiB0nWGMXoYv7Aj0/TIt5f3ES2y8V
         L47gSEWe9Fi7+BUM9fVN8PhJdR1nZjkoZWXKPIOk5WIMaYlXuik+qdZAipxZ9Q0x60ey
         8sk6Wrh7HRmJIoLDhnMYHANbIGBRBpqEdRXpA5FYeTibUOszk1YyV58RCZkD1Fuon4ua
         3L+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=9BMR/1ljfo4sHSBuMNZ+z5Tv5CN3Fmzs3LXwrUy/C1M=;
        b=bysJR5iZWuTWaXxLNifgJEzH8Ei2RoQZCSRFtNZa6YwZ+gMzANAJmYkcLt6k+RkdoH
         Kfa7aAnHH3ExqDAAXDBULbn4MZPD4vsozLh594KXfy5+lo/ANKsIZ5HJYyMwO3AfcrxH
         bvx92i/dBe/alZAqvhyBeJaGlxIwBAKATC4kgq2Q7bQgXMrAcwPRmTQy7ukdX7gZ7avx
         0/CCLqqK7/lWbxvq1TCbxx1A9Xx0Yt5VxKDILwxGRSCsrnOYAokT0FFx7C6pzy9HR7eB
         T/Itf6++bK+rhyDGyMHBTgRQzcbbtA0tjVz/ubVoH9xmKwMmtdwru5wSgOgGt/1Mcfxg
         350w==
X-Gm-Message-State: APjAAAU8TmduT201zXnUInGirMIpBk5h1Rj9DYKDJYPFA+DvciWvJQMh
        YNuFyzCreDHuw3YbKd8QWZxAow==
X-Google-Smtp-Source: APXvYqy9aqh2YWKxZGcjHmox0Uy657jDNwnRb5bPLy/I7HQrDO1i0qmtW04hETu/klN6F2ngy7B/Hg==
X-Received: by 2002:a63:4804:: with SMTP id v4mr5710281pga.373.1581720938430;
        Fri, 14 Feb 2020 14:55:38 -0800 (PST)
Received: from nebulus.mtv.corp.google.com ([2620:15c:211:200:5404:91ba:59dc:9400])
        by smtp.googlemail.com with ESMTPSA id r9sm8314708pfl.136.2020.02.14.14.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 14:55:37 -0800 (PST)
Subject: Re: [PATCH 2/3] random: rng-seed source is utf-8
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Rob Herring <robh@kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
References: <158166060044.9887.549561499483343724.stgit@devnote2>
 <158166062748.9887.15284887096084339722.stgit@devnote2>
 <CAL_Jsq+BDfWgGTVtppD-JEFHZRqpc00WaV2N7c6qsPBSaxOEPw@mail.gmail.com>
 <20200214224744.GC439135@mit.edu>
From:   Mark Salyzyn <salyzyn@android.com>
Message-ID: <f15511bf-b840-0633-3354-506b7b0607fe@android.com>
Date:   Fri, 14 Feb 2020 14:55:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200214224744.GC439135@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/14/20 2:47 PM, Theodore Y. Ts'o wrote:
> On Fri, Feb 14, 2020 at 01:58:35PM -0600, Rob Herring wrote:
>> On Fri, Feb 14, 2020 at 12:10 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>>> From: Mark Salyzyn <salyzyn@android.com>
>>>
>>> commit 428826f5358c922dc378830a1717b682c0823160
>>> ("fdt: add support for rng-seed") makes the assumption that the data
>>> in rng-seed is binary, when it is typically constructed of utf-8
>> Typically? Why is that?
>>
>>> characters which has a bitness of roughly 6 to give appropriate
>>> credit due for the entropy.
> This is why I really think what gets specified via the boot command
> line, or bootconfig, should specify the bits of entropy and the
> entropy seed *separately*, so it can be specified explicitly, instead
> of assuming that *everyone knows* that rng-seed is either (a) a binary
> string, or (b) utf-8, or (c) a hex string.  The fact is, everyone does
> *not* know, or everyone will have a different implementation, which
> everyone will say is *obviously* the only way to go....
>
> 	      	     		     	  - Ted

Given that the valid option are between 4 (hex), 6 (utf-8) or 8 
(binary), we can either split the difference and accept 6; or take a 
pass at the values and determine which of the set they belong to 
[0-9a-fA-F], [!-~] or [\000-\377]  nor need to separately specify.

-- Mark


Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E62C3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 19:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 559D42072A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 19:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNK85IGD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgCETC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 14:02:59 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55911 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgCETC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 14:02:59 -0500
Received: by mail-wm1-f68.google.com with SMTP id 6so7607766wmi.5;
        Thu, 05 Mar 2020 11:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=GdTI1fZ3Q2aYd8I6QuzV0KCmBCojLWf+sv0lmHpJ8qo=;
        b=gNK85IGDFeRlgI7q8lz7TbTTtOfh0XNd8GQORC+V9NIJDK0pU4LSMGNlnGToBV9Tzz
         cMfjsGSpUwFarRVqI75GkeJ0DHJqUU8YmlAWDoyi47lPtABJjpZbCVOYe/EbVVlS9CxE
         Oy2vJl2e4ndKhSvEmwpvKwzxwMhq42T8rRIISoW3MbQigu8ovC0LM6fb1LFrspNtXBYW
         4mU6q8Tu2Ky32YvOcCUVlBxNNqbhElzj+bM4j5Yb6FvfPqqUgtl3RbCkXtmIIfa/7C2b
         ppOyO4H1yhdV67ofA5P3/D0THzQRQc++hvlwMEXxPZRVr5a1U5NzIVkrk/I7FW+YbJeA
         6PQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GdTI1fZ3Q2aYd8I6QuzV0KCmBCojLWf+sv0lmHpJ8qo=;
        b=gHDq0w/HZ6m+krMtEBgfmYSsU803AvWDY0jfdD9OUQlQ4We6bwy3k1keZA5v0LsniX
         iSCBYDunBE7X4bus1Tbjvsq4E6Kmqyo4vGmCTOUZTdu6oV0kNcfQJBLlGvoVi5BuUzpu
         fjQqOxZlotfi+DWPxzHoE5cNjQlEO6fLyHvG646V0jrXJKsyTJ8qWn4gAbENm3NWGcE+
         C/3OOz2TdnJkERyEJEwl0IQvwIoMnOkEyz39sDIM2doklUq17EOYluaXUohuhCggNXBd
         N4r7L252GlbaxvF8A5y0KqAKWUWXhaG/1txCApcBGY85djkNeDKfH+Eh/uQfYJHz6A/4
         bl7Q==
X-Gm-Message-State: ANhLgQ3TsTZ3GiAPhMaPGyS0ShLVMQbRR7YYwicIWzf3uBnJKvaXrtd6
        2Ad/sBzMcrKqPZeeOWi/bIHt/V0=
X-Google-Smtp-Source: ADFU+vsuq/vD8sVRob8SYGQe75Mb90tzMK0Rk6CMpjGFcJVDYK0Fzt60aYnlXdzWz0JtntkFCJNk7Q==
X-Received: by 2002:a05:600c:247:: with SMTP id 7mr183875wmj.181.1583434976131;
        Thu, 05 Mar 2020 11:02:56 -0800 (PST)
Received: from avx2 ([46.53.249.49])
        by smtp.gmail.com with ESMTPSA id z135sm10394199wmc.20.2020.03.05.11.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 11:02:55 -0800 (PST)
Date:   Thu, 5 Mar 2020 22:02:53 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     torvalds@linux-foundation.org, corbet@lwn.net
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel,
        linux-doc@vger.kernel.org, x86@kernel.org
Subject: [PATCH] doc: code generation style
Message-ID: <20200305190253.GA28787@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if it would be useful to have something like this in tree.

It states trivial things for anyone who looked at disassembly few times
but still...

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 Documentation/process/code-generation.rst |  196 ++++++++++++++++++++++++++++++
 1 file changed, 196 insertions(+)

new file mode 100644
--- /dev/null
+++ b/Documentation/process/code-generation.rst
@@ -0,0 +1,196 @@
+Code generation
+===============
+
+1) Generic techniques
+---------------------
+
+### a) Inlining/uninlining function calls ###
+
+External function call is serious business from code generation point of view.
+ABIs require that specific arguments are placed into specific registers before
+doing the call forcing spilling and register shuffling to accomodate ABI rules.
+Clobbered registers which aren't used by a function are wasted. Declaring
+function as ``static inline`` in a header gives compiler more information
+to work with.
+
+However, excessing inlining often leads to code bloat for no measurable
+performance gains. In such case it is probably better to save on generated code
+for icache, disk I/O and network bandwidth costs.
+
+Use ``noinline`` attribute to prevent inlining inside translation unit and
+see what happens:
+
+.. code-block:: c
+
+        noinline
+        int f()
+        {
+                ...
+        }
+
+It is hard to advice any more than that as modern compilers generate code in
+mysterious ways.
+
+
+### b) Appending arguments ###
+
+Some functions are thin wrappers appending an argument or two to another
+function which actually does the job:
+
+.. code-block:: c
+
+        int g(int, int, flag_t);
+        int f(int a, int b)
+        {
+                return g(a, b, FLAG_C);
+        }
+
+Appending an argument at the end adds minimum amount of code:
+
+.. code-block:: none
+
+        f:
+                mov     edx, FLAG_C
+                jmp     g
+
+Appending an argument in the middle or in the beginning will generate
+reshuffle sequence:
+
+.. code-block:: none
+
+        f:
+                mov     edx, esi
+                mov     esi, edi
+                mov     edi, FLAG_C
+                jmp     g
+
+Do not enforce this rule religiously as there may be other reasons for
+specific argument order most notably keeping related arguments together
+at source level.
+
+
+2) Architecture specific issues (i386/x86_64)
+---------------------------------------------
+
+### a) Member placement ###
+
+First member of any structure is very special on i386/x86_64: compiler will
+use ``[r32]`` or ``[r64]`` addressing mode which has the shortest encoding.
+After laying out members of a structure into cachelines for performance,
+move most often used member of the first cacheline to the very beginning.
+
+Done that, pay attention to bytes 1--127. Members placed there will be encoded
+with ``[r64+disp8]`` encoding (or ``[r32+disp8]`` on i386). This is only 1 byte
+longer than encoding used for the first member but 3 bytes _shorter_ than
+``[r64+disp32]`` used for all other members. Try to shift more often used
+members into first 2 cachelines.
+
+"Refugee" members living in byte 128 and beyond can be placed in any order.
+
+
+### b) Implicit 32/64-bit casts
+
+Avoid casts which change signedness and/or bitness of a value.
+
+If some piece of data appears in the code it generally should be kept in its
+original type unless there are specific reasons to do otherwise (packing, etc).
+With C's seemingly arcane implicit and explicit casting rules this is good advice
+from programming language point of view as well.
+
+Given the code:
+
+.. code-block:: c
+
+        void f(size_t);
+
+        int len = strlen(s);
+        f(len);
+
+if compiler doesn't or can't maintain value ranges through casts it will have
+no choice but to assume that all "size_t" values are possible and emit MOVSX
+instruction:
+
+.. code-block:: none
+
+        mov     rdi, ...
+        call    strlen
+        movsx   rdi, eax
+        call    f
+
+MOVSX by itself it not a problem but it a) may be 1 byte longer than MOV
+instruction with same arguments and b) it won't be handled by register renaming,
+increasing dependency chains by 1 instruction.
+
+
+### c) 64-bitness ###
+
+64-bit instruction are 1-byte longer than corresponding 32-bit equivalents
+on x86_64.
+
+There is one big 64-bit enabler which is dynamic memory allocation: all
+kmalloc variant accept ``size_t`` and ``sizeof`` operator returns ``size_t``.
+
+Do not use 64-bit/``size_t`` unless strictly necessary (pointer-to-integer
+conversion, syscall ABI interfaces, integers which can be genuinely big on
+big machines, statistics).
+
+Use 32-bit ``unsigned int``. Kernel simply doesn't to individual 4+ GB
+allocations and if it does it probably goes via page allocator. Such huge
+amounts of memory simply aren't needed: network doesn't do gigabyte packets,
+VFS caps IO at 2 GB minus a little and interating with userspace via
+``copy_from_user``/``copy_to_user`` is capped at ``INT_MAX`` as well.
+
+.. code-block:: c
+
+        #define MAX_RW_COUNT (INT_MAX & PAGE_MASK)
+
+The only exceptional case is ``size_t`` value being passed directly into
+a standard function accepting ``size_t`` (``memset``, ``memcpy``, ...).
+Truncating value to 32-bit won't do anything useful in this case.
+
+
+### d) 16-bitness ###
+
+16-bit instructions will generate 1-byte operand size override prefix (66)
+which again bloats an instruction by 1 byte. Unlike REX prefixes, this is
+unavoidable.
+
+It is better to use 16-bit types at ABI/protocol/memory level, convert
+to plain ``int``/``unsigned int`` as soon as possible and work with that.
+
+Preferred order of bitness on x86_64 is:
+
+        32/8-bit > 64-bit > 16-bit.
+
+3) Architecture specific issues (arm/arm64)
+-------------------------------------------
+
+### Constant flags value selection ###
+
+"Tight" constants can be loaded into a register in 1 instruction on arm and
+other RISC architectures:
+
+.. code-block:: c
+
+        int f()
+        {
+                return 1;
+        }
+
+.. code-block:: none
+
+        00000000 <f>:
+           0:   e3a00001        mov     r0, #1
+           4:   e12fff1e        bx      lr
+
+Constants which don't fit into 12-bit window on arm will be loaded from memory
+or constructed with 2 loads:
+
+.. code-block:: none
+
+        00000000 <f>:
+           0:   e59f0000        ldr     r0, [pc]        ; 8 <f+0x8>
+           4:   e12fff1e        bx      lr
+           8:   00000801        .word   0x00000801      ; <=== 2049
+
+After settling on flags/constants push often used values together bitwise.

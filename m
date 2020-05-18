Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F963C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5177C20758
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgERT6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 15:58:11 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:59865 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbgERT6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 15:58:11 -0400
Received: from mail-qt1-f181.google.com ([209.85.160.181]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mi27T-1j682b1BQX-00e3gP for <linux-kernel@vger.kernel.org>; Mon, 18 May
 2020 21:58:08 +0200
Received: by mail-qt1-f181.google.com with SMTP id z18so9229952qto.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 12:58:08 -0700 (PDT)
X-Gm-Message-State: AOAM533egJnlRsUTgFrqYKuq1uDWB8+6Xhn35+uC0XPjIkYe08Y7hbX+
        6gydE+7O0pne3/bxzKsxdezyqqiQsr5hPl4/u50=
X-Google-Smtp-Source: ABdhPJyET2V+EnyL+uVionmACLzPAshzKIY/gAOVUdclORPQ+2iKe4XXf7jU97YzJietOrdUS32srVPAAUSj32ylqhM=
X-Received: by 2002:ac8:2bce:: with SMTP id n14mr17792483qtn.18.1589831887122;
 Mon, 18 May 2020 12:58:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0QkqyA2wq_EbA+oWrLGgVdQwpBvb+G0aKyz60BOLs6fg@mail.gmail.com>
 <20200507232941.jccuywl56bppxfyp@treble>
In-Reply-To: <20200507232941.jccuywl56bppxfyp@treble>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 May 2020 21:57:50 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0G9uOatw93R90nP3tURgx=WW7yDB7qDtC8cwx0DHZqCw@mail.gmail.com>
Message-ID: <CAK8P3a0G9uOatw93R90nP3tURgx=WW7yDB7qDtC8cwx0DHZqCw@mail.gmail.com>
Subject: Re: objtool warning breaks build for fs/dlm/lock.o
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: multipart/mixed; boundary="000000000000e2bad405a5f1942f"
X-Provags-ID: V03:K1:F9AK6AtGvYwH5xn6manqUTG0H0XH3NxV+lQ1d1EX6M0UMcBX8Df
 eZwJhQ4av1348TLM8TDuhd+PI/ERaD6ID+Y2EooZijAY2xbswiFZosge6UuzKBDCs2m/fTH
 tB6yeZuwNGAPrE1oeYQZX/3MwWCQoRg8YkjQ/jc95YOd/TZ1d/14e7cd+nipPO2Rs2ms+5F
 mQsttXl049e1PrVUFovRQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:sXSSaTIjk/E=:V6vw54av3wqFQqlJ5z4jqc
 L1L0m9/w1JQ9x94dzVPGZ821pC4VrRAnh5qs7+dGWuxXuHHnipsgX5cxN7fwAX+m6CEMpwH4O
 hNjQy7oXk5hhoG4Kq0hvD3rPlDWT/24d1kptCdkaMGuGl0jtUPTCde6siFhI2NPstjohG8vlH
 DXBtFINkdfAVJB/tfTubbJDHDg1FDzcpZrhMmVps1vajTip+9vp/qiVdVNo+lc2V9uvlsFhga
 90DZX+qkQTfhKEHHNDjSVO7dwvo3x8OFhkdx5eiJuyaq3ZQLCu26yKuJxUkXxgl6BjHf6KUAk
 X5h7lr8wxYn2Ch1I3+ESlmpLppRUgiArNvwu44UX9aOSIuHt8DSFFSQ0I62EtI6NF47NDUsI9
 lWGs86rNK5rsHWhH5WEiiPiypy3ouzDPUzNN90OuqUuc33H84bscSROMXwgRPDk5ZhVIMw53r
 9y0b2yOLmyDLque26v+oLUMSFCh/SO73pp79yfqIZ1UKxA16dAcDGI79PFuYjWdwFtZ81AW1f
 yzuG1qJQACmb+GMnRaDR2hpRyURu7cCEPfP1DIdrJ2YXthcXmkP1dzFzG3caG2NPUGG78tkaA
 T/f3D+NN+MBVOpIFCNn88UB1Cqfapx4n10G492ND7oTD62USYafkhtBwqN8QZkj3shxpH33N9
 D29BHmoTaZaTqMF27865HvEDpK0nJdkb4Aqkh5rsn4hGdoAKUglPdzmZwzq2J4WgFKIyPloyM
 xWOVvV7ggxhbvxZlGDY3ImhCM8XyDoBlpG+aUREevC06DVIHqH9enTkLi2SO000a1xqbiMvDm
 /AtSIz5Njk94to7W7qXDCu8n6fM4gtn70jusdmZM1IfJWZzkII=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000e2bad405a5f1942f
Content-Type: text/plain; charset="UTF-8"

On Fri, May 8, 2020 at 1:29 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Wed, May 06, 2020 at 04:07:25PM +0200, Arnd Bergmann wrote:
> > Hi,
> >
> > During randconfig testing with clang-10 I came across a number
> > of additional objtool warnings, I'll send another mail about those
> > when I have collected more information and some object files.
> >
> > This one sticks out however, as objtool returns an error code that
> > stops the build:
>
> > fs/dlm/lock.o: warning: objtool: __receive_convert_reply()+0x1e5: can't find jump dest instruction at .text+0xcaa7
>
> Thanks for sending the patch for this one.  Objtool always gets confused
> by new compiler versions, I really think we need to revert
>
>   644592d32837 ("objtool: Fail the kernel build on fatal errors")
>
> because objtool is never going to be reliable enough such that we can be
> confident that failing the build is the right thing to do.

I'm now struggling with a clang -fintegrated-as related failure:

arch/x86/kernel/ftrace_64.o: warning: objtool: missing symbol for insn
at offset 0x16
make[4]: *** [/git/arm-soc/scripts/Makefile.build:355:
arch/x86/kernel/ftrace_64.o] Error 255

Using this as a local workaround, but I'd like to find out if this is a bug
in clang or in objtool:

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index e77261db2391..b4a0f3dd321d 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -38,6 +38,9 @@ OBJECT_FILES_NON_STANDARD_paravirt_patch.o            := y
 ifdef CONFIG_FRAME_POINTER
 OBJECT_FILES_NON_STANDARD_ftrace_$(BITS).o             := y
 endif
+ifdef CONFIG_CC_IS_CLANG
+AFLAGS_ftrace_64.o                                     += -fno-integrated-as
+endif

 # If instrumentation of this dir is enabled, boot hangs during first second.
 # Probably could be more selective here, but note that files related to irqs,

Attaching the broken object file fore reference.

     Arnd

--000000000000e2bad405a5f1942f
Content-Type: application/x-object; name="ftrace_64.o"
Content-Disposition: attachment; filename="ftrace_64.o"
Content-Transfer-Encoding: base64
Content-ID: <f_kacwu4620>
X-Attachment-Id: f_kacwu4620

f0VMRgIBAQAAAAAAAAAAAAEAPgABAAAAAAAAAAAAAAAAAAAAAAAAAFACAAAAAAAAAAAAAEAAAAAA
AEAABwABAEiBPCUAAAAAAAAAAHUBw0iB7KgAAABIiUQkUEiJTCRYSIlUJGBIiXQkaEiJfCRwTIlE
JEhMiUwkQEjHRCR4AAAAAEiJ6kiJVCQgSIu0JLAAAABIi7wkqAAAAEiJvCSAAAAASIPvBUyLBCUA
AAAAQf/QSItsJCBMi0wkQEyLRCRISIt8JHBIi3QkaEiLVCRgSItMJFhIi0QkUEiBxKgAAADpaf//
/wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAF8AAAAAAAUAAAAAAAAAAAAAAAAAAAAAADYAAAAA
AAMADgAAAAAAAAAAAAAAAAAAAD0AAAAAAAMADwAAAAAAAAAAAAAAAAAAAG0AAAASAAMAAAAAAAAA
AAClAAAAAAAAAEMAAAAQAAMADgAAAAAAAAAAAAAAAAAAABIAAAAQAAAAAAAAAAAAAAAAAAAAAAAA
AAQAAAAAAAAACwAAAAYAAAAAAAAAAAAAAAgAAAAAAAAACwAAAAUAAAAAAAAAAAAAAGoAAAAAAAAA
CwAAAAYAAAAAAAAAAAAAAAAucmVsYS5lbnRyeS50ZXh0AGZ0cmFjZV90cmFjZV9mdW5jdGlvbgAu
ZGlzY2FyZC5rc3ltAGZncmFwaF90cmFjZQBmdHJhY2Vfc3R1YgAuc3RydGFiAC5zeW10YWIAX19r
c3ltX21hcmtlcl9fX2ZlbnRyeV9fAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABPAAAAAwAAAAAAAAAAAAAAAAAAAAAAAADYAQAA
AAAAAHgAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAADAAAAAEAAAAGAAAAAAAAAAAAAAAA
AAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAYAAAABAAAABgAAAAAA
AAAAAAAAAAAAAEAAAAAAAAAApQAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAABAAAABAAA
AAAAAAAAAAAAAAAAAAAAAACQAQAAAAAAAEgAAAAAAAAABgAAAAMAAAAIAAAAAAAAABgAAAAAAAAA
KAAAAAEAAAACAAAAAAAAAAAAAAAAAAAA5QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAA
AAAAAAAAAFcAAAACAAAAAAAAAAAAAAAAAAAAAAAAAOgAAAAAAAAAqAAAAAAAAAABAAAABAAAAAgA
AAAAAAAAGAAAAAAAAAA=
--000000000000e2bad405a5f1942f--

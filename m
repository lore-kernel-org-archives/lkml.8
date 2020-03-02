Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAD8C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0219E2166E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="PPIU/iwx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgCBK4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:56:09 -0500
Received: from mail-lj1-f182.google.com ([209.85.208.182]:38948 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbgCBK4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:56:09 -0500
Received: by mail-lj1-f182.google.com with SMTP id o15so11198760ljg.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 02:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=nqMVuyS4CFOxlIAUHG8LbizmYBcid9hPW+nTGezNsFY=;
        b=PPIU/iwx8iRLuwOH+7C44gxAISsC3e13p6cXyZ4WlrwcTcSTY83YNmjvhQ+005D7LK
         MBW8hWONjaCZqMq3ippgKLQDW/eR3CWtL3H1azXkh8T0cIJOxnyrwhWvy9VKLu5PbE2L
         0pVWiQjom66WsaHJs6EBoaj5Y2TRT7GiJATUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=nqMVuyS4CFOxlIAUHG8LbizmYBcid9hPW+nTGezNsFY=;
        b=D1N+YMRI6AOTXxZ505T+M+ZcmohcABvFBl5HEEFqWsl0wqq3Z2610E8n/vYyM7DaKS
         cPRc3lef77fQMl4+kc2IjY2NQ2Oj0INx+RG82+BuEgPARVosG7AvChlhAFx/3EAgdO8u
         pCkIgHSWWXHV2GuFAEWcbxSaP+UMEaNS/S0NZdBYvZnDxVcCMIKHvxd8vgPJIEu1p+ER
         0FS9sxBn7tcPP9MLPM1XgAkozQI1Rw3UfFC639JlzY0JfhC+6XqBx2XtfaSvr9UWjquu
         bKigG8IPG3spIbc1QV1qofDtRp7X/s0bJ0bdnhLyVYIQchzbYWzMmp1Dt58EQP7gGncA
         v+pw==
X-Gm-Message-State: ANhLgQ1BrN+sSF5vFAR1OVxrQGGhLnRgZ44R3/cZY59PD3g+2+VaaD4K
        UYpPmowgtjDQLh7SueUR69XZL16wKwzNR1sV
X-Google-Smtp-Source: ADFU+vvItV4F44Kw96WD2QVFnEnYHkQqMrFYjSTlprO9G/f4U91MWBiMRQudjTiTkIKk+2eijAutgg==
X-Received: by 2002:a2e:a58c:: with SMTP id m12mr10192159ljp.141.1583146566633;
        Mon, 02 Mar 2020 02:56:06 -0800 (PST)
Received: from [172.16.11.50] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 67sm7213458ljj.31.2020.03.02.02.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 02:56:06 -0800 (PST)
To:     LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: eh_frame confusion
Message-ID: <3b00b45f-74b5-13e3-9a98-c3d6b3bb7286@rasmusvillemoes.dk>
Date:   Mon, 2 Mar 2020 11:56:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm building a ppc32 kernel, and noticed that after upgrading from gcc-7
to gcc-8 all object files now end up having .eh_frame section. For
vmlinux, that's not a problem, because they all get discarded in
arch/powerpc/kernel/vmlinux.lds.S . However, they stick around in
modules, which doesn't seem to be useful - given that everything worked
just fine with gcc-7, and I don't see anything in the module loader that
handles .eh_frame.

The reason I care is that my target has a rather tight rootfs budget,
and the .eh_frame section seem to occupy 10-30% of the file size
(obviously very depending on the particular module).

Comparing the .foo.o.cmd files, I don't see change in options that might
explain this (there's a bunch of new -Wno-*, and the -mspe=no spelling
is apparently no longer supported in gcc-8). Both before and after, there's

-fno-dwarf2-cfi-asm

about which gcc's documentation says

'-fno-dwarf2-cfi-asm'
     Emit DWARF unwind info as compiler generated '.eh_frame' section
     instead of using GAS '.cfi_*' directives.

Looking into where that comes from got me even more confused, because
both arm and unicore32 say

# Never generate .eh_frame
KBUILD_CFLAGS           += $(call cc-option,-fno-dwarf2-cfi-asm)

while the ppc32 case at hand says

# FIXME: the module load should be taught about the additional relocs
# generated by this.
# revert to pre-gcc-4.4 behaviour of .eh_frame

but prior to gcc-8, .eh_frame didn't seem to get generated anyway.

Can .eh_frame sections be discarded for modules (on ppc32 at least), or
is there some magic that makes them necessary when building with gcc-8?

Rasmus

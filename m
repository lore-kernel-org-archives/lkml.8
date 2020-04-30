Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C2FC28CBC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CC09206D9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:05:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgD3OFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:05:33 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:46833 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729109AbgD3OF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:05:28 -0400
Received: from mail-qk1-f174.google.com ([209.85.222.174]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MvsN5-1jDBA202Rr-00suuU for <linux-kernel@vger.kernel.org>; Thu, 30 Apr
 2020 16:05:25 +0200
Received: by mail-qk1-f174.google.com with SMTP id t3so5786419qkg.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 07:05:24 -0700 (PDT)
X-Gm-Message-State: AGi0PuandLSXWv9b+G4/hyCTHc3yVwXn1I1KIycMzt0hkm/02jmmZPpw
        rhuT5yUFx9ZW2l8+RgK78/qrBVUcOaNh3G1Wo+c=
X-Google-Smtp-Source: APiQypKfiuTQyZkimGUZuhVN/2iNyzi11875kCfR0We9GVut/dOFNKlobiXEVN3wKCduUp9kiEhAMWifibP/eeqhm+U=
X-Received: by 2002:ae9:f712:: with SMTP id s18mr3753225qkg.394.1588255523610;
 Thu, 30 Apr 2020 07:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
In-Reply-To: <CAK8P3a2qLJkokMGt48JRky=WUeAbJRuNmoD1oqfWdrGSC6y1LA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 30 Apr 2020 16:05:07 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Gzj9SVZSGo+PxWR0cMJb1sFwv+ii9J6jEGE-Z41Fr+A@mail.gmail.com>
Message-ID: <CAK8P3a2Gzj9SVZSGo+PxWR0cMJb1sFwv+ii9J6jEGE-Z41Fr+A@mail.gmail.com>
Subject: Re: Remaining randconfig objtool warnings, linux-next-20200428
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:cEKfAJqGGwRbsuWNFp4ylaRDRdTLvS34qZ28WQ+Mnmy4XjDGHI/
 2d2MFMx2qQnvRAMkDTc63efM+SAo4AqGXxk5MK4ty7bQ7ErRa6LKMYlYGgW3MpZwDrbKi8O
 clnZWSl7BwbzNIpr9R3wjV161YpbepvK/HI1xz+Gs0kN9m1LWaGEeotIxVI2n0oyYUHw9NB
 35MGhge8G4CvBV/vL7z4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DVEXobJtqlY=:PD1V5Jmy0vIiBrLAScz97K
 IWx+Z5pXyVuHnM68XlXKjawkWQz8NMEnqX0NWrkAGf8hYJ0TYvHK9+oR+muar/Y0TKk80ex9/
 zHJ8NmyHSHFM3WLup8l7sFmXQyfJjlvanyPuPrKWTVooO+dlYFy8z4Ht0tqbAmC/PG4Uu3e6S
 rUOXznfmAOtHMezP69+yWzl+IYOrNjErO/GfNW/AA2AG8TVVMVu4jr6W0mOFAbOy0WBSg1b5g
 c0YSoCZ0++u9Y1bUmL3oDFH54aBP7UaS94o/MoZEmwO9H36o9PDvCu90gnOomvHi2VfzVpRjS
 ZdLD3gBYT//xGGQWUKMHUTYM3nlHsctXNgkU3GXl3v976mbQZnPvI5HgCgubFgIYSVG/xc/xD
 x7LcIjPBszj58avhVDL4EC4Hjmhv4xPbIYUfRFlTTnxepEGAxOTJ9Wov60JmFhPdyBuGYXS9N
 HwAiJ6zg/FS1sI/kQYZu6olRqbPnzUZY2eVH8MYvMDgZhfopcpPQulTW/k1RTwmhDLmayM7zo
 olSNTzq2vtUMxhOI8cu379T0uVgzvEOunDJwIgbAqL3T4BOIaO0FjEDSX/FO7xtM9QxD4QCGQ
 KxIydu3K8JzH0XWcD8CU3j1kmb5Mhevzp4bQ1IAKrz+7AUItomMKWvRGh5EMzwcIuGT3FPGPF
 cWiICRrOPK3oSXecOOY2TTiEwTMw5mQpXNbaJQPuVVSrsBrw3bVd8wd/rly2WgoxUbL5tVD3S
 VG9LKgB5bi1DaOwfHnO5kx3pIDzXPNyMhD4hUQio/D8wZgUyS/YHEI13K4Y/LyomWBvTY2f3D
 W2Mn86JQqNMoD6joo7k9+snj/2pFtL52g5Tc32c/lcXMIEa9t4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 4:49 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> I noticed the number of objtool warnings in randconfig kernels have gone down
>  recently, maybe it's possible to eliminate the remaining ones?
>
> Here are the ones I ran into recently, using gcc-9.3:

I now cross-checked with gcc-10.0, which leads to a few additional warnings
for randconfig builds:

drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: warning: objtool:
vmw_port_hb_in()+0x12f: stack state mismatch: cfa1=6+16 cfa2=7+8
drivers/gpu/drm/vmwgfx/vmwgfx_msg.o: warning: objtool:
vmw_port_hb_in()+0xca: return with modified stack frame
drivers/media/dvb-frontends/rtl2832_sdr.o: warning: objtool:
.text.unlikely: unexpected end of section
drivers/media/dvb-frontends/rtl2832_sdr.o: warning: objtool:
rtl2832_sdr_try_fmt_sdr_cap() falls through to next function
rtl2832_sdr_s_fmt_sdr_cap.cold()
kernel/kexec_core.o: warning: objtool: crash_kexec()+0x2b: unreachable
instruction
lib/locking-selftest.o: warning: objtool: locking_selftest()+0x117f:
PUSHF stack exhausted
lib/locking-selftest.o: warning: objtool: ww_tests()+0x1083: PUSHF
stack exhausted
lib/strncpy_from_user.o: warning: objtool: strncpy_from_user()+0x133:
call to do_strncpy_from_user() with UACCESS enabled
lib/strnlen_user.o: warning: objtool: strnlen_user()+0x122: call to
do_strnlen_user() with UACCESS enabled

I uploaded these as well now, see
https://drive.google.com/open?id=1k10cO9OkFKaMVnK7uX-prplY-13CAvW1

       Arnd

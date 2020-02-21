Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B32C35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D839D24672
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qNCVJD4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgBUL4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:56:48 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:48222 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgBUL4q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:56:46 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200221115644euoutp02fb5d7ba9ce1549a224b35217d35c651b~1aOtZsx-b0701707017euoutp02j
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 11:56:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200221115644euoutp02fb5d7ba9ce1549a224b35217d35c651b~1aOtZsx-b0701707017euoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582286204;
        bh=ttOHqZyVhN2Ha6AWi1sTsR5rhszW5WEHAUFOhdn9x+Q=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=qNCVJD4+/KbTgr88jeFxvt6oQ2Lk/db2jITJZP1m9WxB3K2nQS9AZP/pzf/aqkCgd
         spwqCLpFvEOSJDSEKDvI7lDcKqJCu9qq0wKpLzUcnTEeNk8lwMxHWF2lvioUyZYBad
         662EGDvAtXn9zIfAikisl1Xsura+iONXhpm32JiI=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200221115643eucas1p12981681eb2cda488400f2e4bb58f629b~1aOsz36tK1507415074eucas1p1b;
        Fri, 21 Feb 2020 11:56:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 2A.A5.60698.B75CF4E5; Fri, 21
        Feb 2020 11:56:43 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200221115643eucas1p12ecb95c6161853a0e7dfe9207db079be~1aOsfjy121401914019eucas1p1x;
        Fri, 21 Feb 2020 11:56:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200221115643eusmtrp28eb23b4d75089b6224cabe59b5709188~1aOsermH62880428804eusmtrp2S;
        Fri, 21 Feb 2020 11:56:43 +0000 (GMT)
X-AuditID: cbfec7f5-a29ff7000001ed1a-28-5e4fc57b7f8d
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CA.AA.07950.B75CF4E5; Fri, 21
        Feb 2020 11:56:43 +0000 (GMT)
Received: from [106.120.51.15] (unknown [106.120.51.15]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200221115642eusmtip2cfdd6a1fd4e334856d6328370dcdefb9~1aOrrQXfl2493724937eusmtip2D;
        Fri, 21 Feb 2020 11:56:42 +0000 (GMT)
Subject: Re: [patch V2 11/17] ARM/arm64: vdso: Use common vdso clock mode
 storage
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, John Stultz <john.stultz@linaro.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Andrei Vagin <avagin@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <c86bbd4e-5992-c1c9-ed31-9ea04d392588@samsung.com>
Date:   Fri, 21 Feb 2020 12:56:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200207124403.363235229@linutronix.de>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTYRTHffZe9jqcPK2Wp4yKYUEXM83qwSQKJN9PFRaE3Ve+mKQzNi0t
        quW6LJFMS7N5KbKLlmZMGypTa2XTtFlas8Q+hNKN1MhLdlFze7P89jvP//zP/xx4OEpxgZ3J
        xWgSBK1GHatiZbTlyQ+H/5H6DTuX5jp9SfPYZ4r03UxDxGiQkLw3QSSj4RtNmn/5E3OXkyFt
        1XkssWXVINJSXcqQG+0vJKQqr5EhN984aGIcyqdJnWWUIa1WP2IucbKk3JxFkZrRHzQ52bmc
        DN/rYtYo+ZKCEsS3OV9Q/Kn0YZavMr2V8ubbZ1m+02ll+V6HQ8rXF5dK+PLrx/lTlSNSvq/2
        FcuXVbyi+X7z7I3yrbLQKCE25qCgDVi9W7av1XiVPmDwSsrsMEv1KFeWijw5wMFQ8XKATkUy
        ToGLEOR/GWLFYgBB1yPrX6Ufwbfuc9SE5cxwoVQUbiGwnctnXYIC9yAoP+Fumoo3gf2ik3Hx
        NLwB3hvS3ZMo/JEB84nv7iYWB0JqT6rbLMer4XxKn8TFNJ4HTZXZ7h4l3gG5xY9osWcKNF7u
        drMnXg4tKR/cXgrPAcP9XEpkH+joviJxhQFu4ODh6Gkkrh0GOZYrjMhT4bO9QiryLBirmjAY
        ELxzlErFIg1BW0rOX/cq6HT8HI/jxiMWQFl1gAsBr4U7hVhEb3jdM0XcwRsyLZco8VkOxtMK
        ccZ8MNnv/kt9+LyVOo9UpkmXmSZdY5p0jel/7FVE30Y+QqIuLlrQLdMIh5bo1HG6RE30kr3x
        cWY0/lWbRu2Dlaj29x4bwhxSecmT9Ot3Khj1QV1ynA0BR6mmyed7jT/Jo9TJhwVt/C5tYqyg
        syFfjlb5yJdd+7RDgaPVCcJ+QTggaCdUCec5U4+UEUO7sh4sCjiabG83Jh3P917HpgUHHdNE
        Ej8l8bKGNOeMwP7Mx08f6AsCZdaE5g5NWINHcWf/oCdRzkhZOUZ9eO8XsWWxJuJr751GhY9l
        cACrjoZnzA2vY4qmP0Whz7aH8NkehZv7qugVR/RoZF1DUcfmMkWbrzayLjRkm1ZF6/apAxdS
        Wp36D6Lx7lemAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0iTURjHOXsvm+LqdWqerDTWDQqnm06PYiJE9EJpgfql8jL0RSXnZO8U
        NSJxmmt00VDBeUnwAppSzbt5a+C9NBVnmpmiYGhqFyktszZX4Lff+Z//74EHHh4mqCCceHEJ
        KkaZIIsXktb40E7frOvNnsvh7nP9OHr1ZxlD61X3ANKoOah4SoJy+7+a4l+uSL9gJNB4WzGJ
        DPkdAI201RGocnKUg1qLBwhUNTWMI833Ehx1Ne0QaKz9ONLXGklUr8/HUMfOFo4yZ6Ro89kC
        EeBA15bWAnrcOIrRWQ83SbpV955L62vukvSMsZ2k14aHuXRPdR2Hrq+4TWe1/ObS650TJP20
        YQKnv+mdr/CvivyUiiQVczRWwarOCq+JkUQk9kEiiaePSOzhHeYrkQrd/P2imfi4ZEbp5h8p
        ih3TlOGJapuUR9N6bjoostYCKx6kPGH2ZjlXC6x5AqoSwN7VbNLycRgOFKQTFraD20btbi6g
        VgB8/iXQzHZUMOzLM+527KlAmHG/jDAPwqhlAn6uqzA9eCYhAub32Jo7JCWG2lXLHD7lD3My
        1jlmxqkTcKilADOzAxUG3xZqOJaOLRwoXMTNbEVJ4UjG0q6LUV6wtH4es7ALVDcW/WNHOL34
        mJMDBLo9um6Potuj6PYoZQCvAfZMEiuPkbMSESuTs0kJMaIohVwPTBfS1LvV0AK0a8EGQPGA
        0Iafkh4ULiBkyWyq3AAgDxPa80/amCJ+tCw1jVEqIpRJ8QxrAFLTcrmYk0OUwnRvCaoIsVTs
        jXzE3h7eHl5I6MjXUC+vC6gYmYq5wTCJjPK/x+FZOaWDVOX5zRfc7gusZq6z+UN3ZEXoQZfB
        n55dUfUXY8cKCsuIgFvyQ7MD2LuGkZUHmfuOhEr9G/frnam0M5OXfEOmsja289TDn8bPHUsx
        qDJdPEK6kg8sFZ9qpktGg18HSlXhHzumPK0L1e5bP2rL31SHDergfGNlXFDviO7J9B0UtSHE
        2ViZ+DSmZGV/ASza5qQ3AwAA
X-CMS-MailID: 20200221115643eucas1p12ecb95c6161853a0e7dfe9207db079be
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200221115643eucas1p12ecb95c6161853a0e7dfe9207db079be
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200221115643eucas1p12ecb95c6161853a0e7dfe9207db079be
References: <20200207123847.339896630@linutronix.de>
        <20200207124403.363235229@linutronix.de>
        <CGME20200221115643eucas1p12ecb95c6161853a0e7dfe9207db079be@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 07.02.2020 13:38, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Convert ARM/ARM64 to the generic VDSO clock mode storage. This needs to
> happen in one go as they share the clocksource driver.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Tested-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

This patch landed in today's linux-next (next-20200221) as commit 
5e3c6a312a09. It breaks ARM 32bit build without VDSO enabled in .config:

$ make ARCH=arm multi_v7_defconfig

$ ./scripts/config -e ARM_LPAE -e VIRTUALIZATION -e KVM -d VDSO

$ make ARCH=arm olddefconfig

$ make

...

drivers/clocksource/arm_arch_timer.c:73:44: error: 
‘VDSO_CLOCKMODE_ARCHTIMER’ undeclared here (not in a function)
  static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCHTIMER;
                                             ^
scripts/Makefile.build:267: recipe for target 
'drivers/clocksource/arm_arch_timer.o' failed
make[2]: *** [drivers/clocksource/arm_arch_timer.o] Error 1
make[2]: *** Waiting for unfinished jobs....
scripts/Makefile.build:505: recipe for target 'drivers/clocksource' failed
make[1]: *** [drivers/clocksource] Error 2
make[1]: *** Waiting for unfinished jobs....
Makefile:1683: recipe for target 'drivers' failed
make: *** [drivers] Error 2

> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


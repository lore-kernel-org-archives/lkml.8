Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D800CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B249C20724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 11:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OYr9flTk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbgFWLY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 07:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732189AbgFWLY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 07:24:57 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3C4C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 04:24:56 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l10so20124957wrr.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 04:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LISOo0uegZi3am5M7TOWf7OzM2rHxLFNz15tOWhpgHY=;
        b=OYr9flTkc67fJMXrndR42JOdtI/v8Gh6pi/3xD5WK4OjwlkH2dyWXZKS2UHVvxdPDg
         JotNaQttXi2ukOKmAWJlT8e4pRgnQhbjJvJmklJTAQuhS5QuT9f8pUug3+WKjXges8Ab
         gHQQQOMJxaFVRFQ3bs8NUd+gl4TxHdglSpzvmKs6BoPaOKAi+9AlmnQCx3P9f2qEA+g6
         VardcbztghtjzkqwQjJZ71VOGA+aIkfvPWnCyiey7hPNBW6sc/qyWTDL7o4/XMLO6tHI
         WrGJ78xYaksF2YPzb/IHalGIOKQG/vN0Z82hf9wmv3XvLJNetKqSAvYI2Z7GA/9ehSUf
         Va6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LISOo0uegZi3am5M7TOWf7OzM2rHxLFNz15tOWhpgHY=;
        b=tb8aL1I4eW6KSPwPQ3e/Vvrb4QBxFW+1Jw8QrbWHho7R2SRYYsxBDcc0E1dGbDxj7b
         2molbVCaFohbHwGoZEHQxRgCfCbI6yqBXEJPbPZhVw+0tK++zRmOKh6Jw6boXXN1j5T2
         rgG0gNWNRFEdCipoUfbh24s+M5VqdTjEv3Rpg9ZOEz1kgoaNT24siP7zC7B+KSbuhdFy
         0cSHAnjSjLX4uqLy5RRUY462N98fhuIMkLpvfgXelFCBrIRnB0OXYmN7Gb6rMAHN/Oxr
         2GMDi7ndu7ZP79D5FjUr18LxuZOnxhUVz+F4/GRiCzk1BAeJ+7YVsv0u98BwkW1pmp3t
         5S6g==
X-Gm-Message-State: AOAM5319u6fSfVVFD0furK4k76DKg74oAlvQIY/wCYNXyvbKWOgL79e3
        gbP8EIf1ZscepWrkfdaB9C7+eA==
X-Google-Smtp-Source: ABdhPJytDIeaxmPu6ekWJ4tCMSlDCsjdYYX0RSg8oGW12mCaAKj/1NHCrq4BCADMHZL/uI1G/DCbDw==
X-Received: by 2002:a5d:40cb:: with SMTP id b11mr12984601wrq.263.1592911495061;
        Tue, 23 Jun 2020 04:24:55 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id v20sm22540379wrb.51.2020.06.23.04.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 04:24:54 -0700 (PDT)
Date:   Tue, 23 Jun 2020 13:24:48 +0200
From:   Marco Elver <elver@google.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     syzbot <syzbot+dbf8cf3717c8ef4a90a0@syzkaller.appspotmail.com>,
        bp@alien8.de, hpa@zytor.com, jmattson@google.com, joro@8bytes.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, mingo@redhat.com, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org
Subject: Re: linux-next build error (9)
Message-ID: <20200623112448.GA208112@elver.google.com>
References: <000000000000c25ce105a8a8fcd9@google.com>
 <20200622094923.GP576888@hirez.programming.kicks-ass.net>
 <20200623124413.08b2bd65@canb.auug.org.au>
 <20200623093230.GD4781@hirez.programming.kicks-ass.net>
 <20200623201730.6c085687@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200623201730.6c085687@canb.auug.org.au>
User-Agent: Mutt/1.13.2 (2019-12-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 08:17PM +1000, Stephen Rothwell wrote:
> Hi Peter,
>=20
> On Tue, 23 Jun 2020 11:32:30 +0200 Peter Zijlstra <peterz@infradead.org> =
wrote:
> >
> > I suppose the next quest is finding a s390 compiler version that works
> > and then bumping the version test in the aforementioned commit.
>=20
> Not a lot of help, but my Debian cross compiler seems to work:
>=20
> $ s390x-linux-gnu-gcc --version
> s390x-linux-gnu-gcc (Debian 9.3.0-13) 9.3.0

Rummaging through changelogs led me to 8.3.0 as the first good GCC. Also
confirmed by building that version and compiling a file that breaks with
older versions. It seems the first major version to fix it was 9, but
backported to 8.3. This is for all architectures.

Suggested patch below.

Thanks,
-- Marco

------ >8 ------

=46rom: Marco Elver <elver@google.com>
Date: Tue, 23 Jun 2020 12:57:42 +0200
Subject: [PATCH] kasan: Fix required compiler version

The first working GCC version to satisfy
CC_HAS_WORKING_NOSANITIZE_ADDRESS is GCC 8.3.0.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D89124
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Marco Elver <elver@google.com>
---
 lib/Kconfig.kasan | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.kasan b/lib/Kconfig.kasan
index 7a496b885f46..19fba15e99c6 100644
--- a/lib/Kconfig.kasan
+++ b/lib/Kconfig.kasan
@@ -16,7 +16,7 @@ config CC_HAS_KASAN_SW_TAGS
 	def_bool $(cc-option, -fsanitize=3Dkernel-hwaddress)
=20
 config CC_HAS_WORKING_NOSANITIZE_ADDRESS
-	def_bool !CC_IS_GCC || GCC_VERSION >=3D 80000
+	def_bool !CC_IS_GCC || GCC_VERSION >=3D 80300
=20
 config KASAN
 	bool "KASAN: runtime memory debugger"
--=20
2.27.0.111.gc72c7da667-goog


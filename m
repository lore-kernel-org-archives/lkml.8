Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39765C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C75B24653
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fh+L/HgW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgAUPhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:37:02 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:43259 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgAUPhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:37:01 -0500
Received: by mail-oi1-f178.google.com with SMTP id p125so2901527oif.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 07:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RmViYAa1rRPt72/wIccYehar/+HNwKCjcTf+igUl6VA=;
        b=fh+L/HgWv3D9ttnggU6JGqSQStDK5h3ktOJkYmdzLKBOJ9Iqsa+rnenXs+L7x9noRb
         yMJZgzsETDV0BK+WrUpmkr8t8pLkm/0XpC4tPvC88sMPcN30eVKswEi9iIY8M1OOedSx
         r6Ux/4FHN44flxoqAmMDp+172AbujOl8cYd9hXmQDpvmNOaAG/HZVSAyAd+QWunblMIE
         dCyDRMzerFinT5IJe3xbo/pr58qOHuZ9TTe8P6Vkm2Asvz/aqqFLTZ+3x1L8hvwq0LDJ
         AYndPKkW/Y/T9tjiN2/8CTbyHu/VMWEGbj70+my8Y//1mLgdiH+BNz6c631UisVP+T1A
         gaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RmViYAa1rRPt72/wIccYehar/+HNwKCjcTf+igUl6VA=;
        b=lk5apzTLjPXG5zbg7wKdUrTmV2gph/Wvq1RTL+ci6HrPVMRh75csfFAAUpzxPyBmD+
         mZpJqnXNbrcal1SS/t82jiBgaMhqyPQQsP99yQHa4rQr94V+oc8RTl9NF8UqYaj4L4Jy
         DzONMlPa6Esg6wz1HvnOMWyN/XZCA3QiOmoQqA11QuzGy2khjV3p3RZFdrRbDispeSLU
         p6fCmHuuK055cM1lGn5nMP289flTgAtyx/fdN9z2MQAdgZ5HHTj6ZpsFX0mhyATlBXas
         uUV2HT5XC6+hxvCyBatdV+izJPiawuRLp3LPr8vU5XwWa78Hc5HI20uC8/j/5Svtmt5A
         PpdA==
X-Gm-Message-State: APjAAAVnzvcHBo1rirjdEIq/oY8b73YDbviEQaBRRNXJO6PJV41Zz/XY
        Vi2WSefHTjDYv4YJWQJDKUZ1B0tHdlAhSD4TPg5YXQ==
X-Google-Smtp-Source: APXvYqxDYp2UrR+9SpJuK4r2uuLGqMJPe2AdBEeH8RoVdrYxxO67IpVFxAeZLnpSAHJhlfxNbzI2+d8IgMfl6/Rwz1Q=
X-Received: by 2002:a05:6808:8d5:: with SMTP id k21mr3542611oij.121.1579621020494;
 Tue, 21 Jan 2020 07:37:00 -0800 (PST)
MIME-Version: 1.0
References: <20200121151503.2934-1-cai@lca.pw> <CANpmjNPR+mbadR0DDKGUhTkaXJi=vsHmhvq3+Rz0Hrx=E9V_Qg@mail.gmail.com>
 <20200121152853.GI7808@zn.tnic> <44A4276D-5530-4DAA-8FC7-753D03ADD2F3@lca.pw>
In-Reply-To: <44A4276D-5530-4DAA-8FC7-753D03ADD2F3@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Tue, 21 Jan 2020 16:36:49 +0100
Message-ID: <CANpmjNO7mTEMc6pvpVVXdu2r6cMg_N8QkRffEHHG-WNFXE4CjA@mail.gmail.com>
Subject: Re: [PATCH -next] x86/mm/pat: silence a data race in cpa_4k_install
To:     Qian Cai <cai@lca.pw>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2020 at 16:33, Qian Cai <cai@lca.pw> wrote:
>
>
>
> > On Jan 21, 2020, at 10:28 AM, Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Tue, Jan 21, 2020 at 04:19:22PM +0100, Marco Elver wrote:
> >> Could you remove the verbatim copy of my email? Maybe something like:
> >>
> >> "Increments to cpa_4k_install may happen concurrently, as detected by KCSAN:
> >>
> >> <....... the stack traces ......>
> >
> > ... and drop the stack traces and fix your subject to say what you're
> > actually "fixing".
>
> Does this title work for you?
>
> x86/mm/pat: silence an data race for KCSAN

Isn't the intent "x86/mm/pat: Mark intentional data race" ?  The fact
that KCSAN no longer shows the warning is a side-effect.  At least
that's how I see it.

Thanks,
-- Marco

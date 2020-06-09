Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE04C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C667C2078C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rstobshj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729800AbgFINpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 09:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgFINpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 09:45:54 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA48C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 06:45:54 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id c194so18769181oig.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 06:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KEU/lBQXx7Y+HNqUAFaiNZ4WAPmvykZU+zkAfhPdu7U=;
        b=RstobshjFqPQXoG7aJDr0mkuw/r7kmyuVTZRc2jc67iRHYWSTfVW+067l8A7njlWUh
         1AoZ6XfD+bMV7uoJUqS6Qtd4k0sACUvB73vqSbPFt5a4fSt4axJ79DxXkZLwp+phAwuR
         B6I9TZVboxX0pO+7P0Mx56xgDv8fJ1TvetW+LeHofSOABD4zrA+wvwj6lReiVkO0KjQW
         K/T8FKsHcJqH+dQJxK2occbtn1rnp5iwqWSUjsdd43ZnyRy+aCOn7u8CpNeHZpzMyReJ
         Tjo50cj7JPy486cQXNtMBk4clel8/AH7KEkpQ97+SLwsHASMG8vuINdGIOYh+/9JsBMj
         j+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KEU/lBQXx7Y+HNqUAFaiNZ4WAPmvykZU+zkAfhPdu7U=;
        b=p4qSlPo9SmbfRCsovq2V1gRRJwoKHxSfALtvvFHrAbUYwvkpyfyWmu8ouDDiP/5Hs2
         2z2htwRTzClEpzCLgiAIUU2ra0v0ZmMdBMh5lqVkeENY7DRIc2cIorryZXNT+gQIR0Hv
         aKhhRQmc4Uy7E0S055RutQO6YS6VGOOW1ZSXC5mJill9NhlMyS/514ELZEu8/qbwGJvo
         0+g2RQhBf9E4mZ3ZDkggymyEdcY5q9+u0A2sB4Mo4ftpeLIreta3WPQZ1dfZf2nDJ249
         s54kYZqVypzJwo9XB9HoJpv8MNKX+t/eCm5/gFEhity5BmZyAAhEHIsDh/2Ttbkv7KP9
         yeLQ==
X-Gm-Message-State: AOAM532MA1FPs3AXrk5xBTg3yJCy/jY4LGhmNcDqjIraxxQ9M45SduLp
        nQQMbkaXdTAKmD7mV4AYHzeGTx2HH192+KM/cvbn4Ybg
X-Google-Smtp-Source: ABdhPJwfw3Nh9kzyjHe6SMHjhOhOSlXDUoJN1LDhyMVk1y/wk8kecZ7j1fQqp/dXg2xEnH/o3AvQtfGx0a/v2nE7hok=
X-Received: by 2002:a05:6808:34f:: with SMTP id j15mr3515515oie.121.1591710353326;
 Tue, 09 Jun 2020 06:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200513124021.GB20278@willie-the-truck> <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
 <20200513165008.GA24836@willie-the-truck> <CANpmjNN=n59ue06s0MfmRFvKX=WB2NgLgbP6kG_MYCGy2R6PHg@mail.gmail.com>
 <20200513174747.GB24836@willie-the-truck> <CANpmjNNOpJk0tprXKB_deiNAv_UmmORf1-2uajLhnLWQQ1hvoA@mail.gmail.com>
 <20200513212520.GC28594@willie-the-truck> <CANpmjNOAi2K6knC9OFUGjpMo-rvtLDzKMb==J=vTRkmaWctFaQ@mail.gmail.com>
 <20200514110537.GC4280@willie-the-truck> <20200603185220.GA20613@zn.tnic>
 <20200603192353.GA180529@google.com> <87213fd1-950d-c2d5-4aa0-2f53ea3b505c@suse.cz>
 <CANpmjNNRz5OVKb6PE7K6GjfoGbht_ZhyPkNG9aD+KjNDzK7hGg@mail.gmail.com>
 <cf282ae4-892a-a341-07ce-8ea5db6463b7@suse.cz> <3df9cc45-97e6-b468-7d61-8b7aa3a6bd01@suse.cz>
In-Reply-To: <3df9cc45-97e6-b468-7d61-8b7aa3a6bd01@suse.cz>
From:   Marco Elver <elver@google.com>
Date:   Tue, 9 Jun 2020 15:45:39 +0200
Message-ID: <CANpmjNPde-1E_RbFnBykpPMC6HJ9hV_9JCKXK1tYkLu+HTT5Hg@mail.gmail.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
To:     =?UTF-8?Q?Martin_Li=C5=A1ka?= <mliska@suse.cz>
Cc:     Borislav Petkov <bp@alien8.de>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jun 2020 at 14:36, Martin Li=C5=A1ka <mliska@suse.cz> wrote:
>
> On 6/9/20 1:55 PM, Martin Li=C5=A1ka wrote:
> > Works for me and I've just sent patch for that:
> > https://gcc.gnu.org/pipermail/gcc-patches/2020-June/547618.html
>
> The patch has landed into master.

Great, thank you for turning this around so quickly!

I've just sent v3 of the tsan-distinguish-volatile patch:
https://gcc.gnu.org/pipermail/gcc-patches/2020-June/547633.html -- I
think there is only the func-entry-exit param left.

Thanks,
-- Marco


-- Marco

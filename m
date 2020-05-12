Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E80C54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6476206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f6Nrlgw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730153AbgELN6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 09:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730145AbgELN6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:58:19 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEAAC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 06:58:19 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z72so13821698wmc.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 06:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6We9F0Gl5i6dFB55TqViIVwO6PgjLYpYEaNQovKdPNk=;
        b=f6Nrlgw8UCeFoD5o8cR+YQiCKCYmqZIj47J/ddXCRLiBT2dJ14ERtJogi5vv4YRaVP
         DdOdfSdEPRWfH3VZDTL6qtcEuOpAl6zcS2aHXoLeO9T9OxdreTUPFeoXk95PQzM59cjT
         oiIsAr2xUt21mubwr8eYWwQlTKjYamkIbd4z0Qod13dJalTL9DFmYH5A3VoF2Zfj03Tp
         URKm8lP2zvsnOTcQWSAHzOf97wLEQV8JglXIfA3rqgtRJHp+/W4YYkadapu+NpANBdcO
         KT1UygHLxz9bFaAiq5sTd7qNhwWv+IY5MWT3WpCaex/qYlCHndsfgw81dFpxaVbSuqvc
         Gmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6We9F0Gl5i6dFB55TqViIVwO6PgjLYpYEaNQovKdPNk=;
        b=ZbohZMXfHHBSpp6JETrb4O1/3Z99+3VNIsFQLwcaeEtADUVxcNnXAyM860imt3CCAw
         iDnPsoV8pHft6IunNoSONjarLP3obWOvZ0yAukkzY/6uQ5wK2k7fjSCvKgPWp5g8xvdY
         KeeST0G1MSOa0744RJRrUnpdhjykUqKG+ZYBqiHlaP+XlWAA6JLC1ROhinNfsomBFBMV
         QmAUgd3DdpJ8DceTqZiUNH3D0TK4hggQb+eATPcI7Z2ZiZ3x8Zu6NYFtlrpnteBr+XLk
         0qx1KsVitrEBiLbF98PZ5M8yxjAJXRW0oyXgJ5cwd68i+mFBn7kTR9B/B2r0B6dWSnRI
         jfLg==
X-Gm-Message-State: AGi0PuYWUeQhdj1NL+/whkuvFmcUFAFPNJOC1AGnJvOfcv6O7UDz0Dm/
        os4yX79H4omQpry29B/iX+DzEqVj007GWg==
X-Google-Smtp-Source: APiQypJjRlOI0WgMaW9PI/tz98LbvmgkkDNcbr+q8RKiGAeM85CNu41OObsMGh78C+ggI9aYP6unNA==
X-Received: by 2002:a1c:e302:: with SMTP id a2mr36318773wmh.96.1589291897718;
        Tue, 12 May 2020 06:58:17 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id s2sm351084wme.33.2020.05.12.06.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 06:58:16 -0700 (PDT)
Date:   Tue, 12 May 2020 14:58:13 +0100
From:   Quentin Perret <qperret@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Todd Kjos <tkjos@google.com>,
        "Cc: Android Kernel" <kernel-team@android.com>
Subject: Re: [PATCH 00/14] Modularize schedutil
Message-ID: <20200512135813.GA101124@google.com>
References: <20200508081128.GM5298@hirez.programming.kicks-ass.net>
 <20200508103721.GA3860390@kroah.com>
 <20200508111612.GA252673@google.com>
 <20200508113141.GB5298@hirez.programming.kicks-ass.net>
 <20200508130507.GA10541@google.com>
 <CAJZ5v0iaa_VCtN608QKTYZ-A6QG_7bwxihxSgoEGv1LcSK-ksA@mail.gmail.com>
 <20200511090049.GA229633@google.com>
 <CAJZ5v0jKMgFsR0dXDt4si5hT9QF2evaoMS-13y-Qde8UpcaARg@mail.gmail.com>
 <20200512092102.GA16151@google.com>
 <CAJZ5v0hm3Tv2yZKLzM9a+kJuB1V5_eFOEKT-uM318dzeKV3_Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hm3Tv2yZKLzM9a+kJuB1V5_eFOEKT-uM318dzeKV3_Qw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 May 2020 at 12:25:17 (+0200), Rafael J. Wysocki wrote:
> Still, IMO it would be fair to say that if uclamps are used, schedutil
> is very likely to be preferred.
> 
> Kconfig can be made select schedutil when enabling uclamps or similar
> to express that preference.

Right, fair enough. Making schedutil default to y when uclamp is
compiled in should do the trick (and avoid using 'select'). Would that
work for you?

> What you are proposing is basically to add complexity and the reason
> for doing that seems to be convenience (and that's not the users'
> convenience for that matter) which is not really super-convincing.

Forcing our users to build in their products something they don't want
to use tends to be a very real problem for what we're trying to achieve,
so it's certainly not just convenience from our perspective. I can
understand that yours might be different, though.

Thanks,
Quentin

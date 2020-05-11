Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C0AC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4266220643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 15:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgEKP2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 11:28:55 -0400
Received: from foss.arm.com ([217.140.110.172]:34722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgEKP2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 11:28:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CEDA130E;
        Mon, 11 May 2020 08:28:54 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6904D3F68F;
        Mon, 11 May 2020 08:28:52 -0700 (PDT)
Date:   Mon, 11 May 2020 16:28:50 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] Documentation/sysctl: Document uclamp sysctl knobs
Message-ID: <20200511152849.cg5a56ojhey55btr@e107158-lin.cambridge.arm.com>
References: <20200501114927.15248-1-qais.yousef@arm.com>
 <20200501114927.15248-2-qais.yousef@arm.com>
 <87d07krjyk.derkling@matbug.com>
 <20200505145637.5daqhatsm5bjsok7@e107158-lin.cambridge.arm.com>
 <877dxik4ob.derkling@matbug.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877dxik4ob.derkling@matbug.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick

On 05/11/20 15:00, Patrick Bellasi wrote:

[...]

> > I have this now
> >
> > """
> >  984 This knob will not escape the range constraint imposed by sched_util_clamp_min
> >  985 defined above.
> >  986
> >  987 For example if
> >  988
> >  989         sched_util_clamp_min_rt_default = 800
> >  990         sched_util_clamp_min = 600
> >  991
> >  992 Then the boost will be clamped to 600 because 800 is outside of the permissible
> >  993 range of [0:600]. This could happen for instance if a powersave mode will
> >  994 restrict all boosts temporarily by modifying sched_util_clamp_min. As soon as
> >  995 this restriction is lifted, the requested sched_util_clamp_min_rt_default
> >  996 will take effect.
> >  997
> >  998 Any modification is applied lazily to currently running tasks and should be
> >  999 visible by the next wakeup.
> > """
> 
> That's better IMHO, would just slightly change the last sentence to:
> 
>        Any modification is applied lazily to tasks and is effective
>        starting from their next wakeup.

+1, will post v5 later today.

Thanks

--
Qais Yousef

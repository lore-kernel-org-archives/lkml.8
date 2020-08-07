Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D30CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 15:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16C8F20866
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 15:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="fnVygkK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgHGPhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 11:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726061AbgHGPhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 11:37:35 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DE5C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 08:37:34 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id p4so2109582qkf.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 08:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eLwi9oVvNS2LpmnHVpeAiCa4eD/S6H9JAq2fjvFA1xU=;
        b=fnVygkK2zJ1EV5RXMiYReFaLv63tH+QLUWn0SQ+rrEUEe8AMGkZeFGVzS7y8A/Vrvx
         V/nDGc/jSKVHLRTdFIWawRhjfSCcBTdIwQJAJk9CUUyJ3yi0keYeZhnh6EmMbrjTtqcd
         8fEWD2Xryc/nDKOFA4AxWW6OYfVqVia6ym+Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eLwi9oVvNS2LpmnHVpeAiCa4eD/S6H9JAq2fjvFA1xU=;
        b=mdTQxyoyld9mU+cPZL6XkI0/BsVYWNEd8NwJp1TVlLUXJ1Nql1DE2DNNci9HNqkL0U
         1t79oJ2xZJknsmuaCiAqEIirP7mYoVDEp5+SMJ1YTU7yxTKYJMKOOdrD3oeCveglSJHM
         mJLY85RIz0Zgo2YMCV4H1cXn/KBLi+hVcZdMpYlTTMhroJpD3Kkj8ddbr5LOQVpoDmpg
         kpUcnZIPuC8BHCXzOrYXLKWI3LfMd5Vpfo6I7eP1/ddpMACtR/QTyA7Y6qp9pOYDvXpI
         RMmq+QhxURPKyp1XBJK4LMDVk537wH8/WUp3xdqqrNZnyZ69Vyfo2RKnwsmfG7FVdOua
         BmfA==
X-Gm-Message-State: AOAM532wbV/jAa62CJUvCBmQbF9muu300fC+KF7TzHsJ8z6BVS1sagNX
        ciJr+uesXEQ70DGRIQHEUcYu0Q==
X-Google-Smtp-Source: ABdhPJxoa5G4OLetc65+xiFpl7TElfCRJSoj+NnB2mbtwFg1wgoPiF63XLC9Ov1yQG+ajwcdrF64Jg==
X-Received: by 2002:a37:8107:: with SMTP id c7mr14316099qkd.22.1596814654004;
        Fri, 07 Aug 2020 08:37:34 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id q34sm8125956qtk.32.2020.08.07.08.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 08:37:33 -0700 (PDT)
Date:   Fri, 7 Aug 2020 11:37:32 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/2] rcu/tree: Add a warning if CPU being onlined did not
 report QS already
Message-ID: <20200807153732.GA2865655@google.com>
References: <20200730030221.705255-1-joel@joelfernandes.org>
 <20200730162159.GZ9247@paulmck-ThinkPad-P72>
 <20200731014222.GA2349603@google.com>
 <20200731034825.GI9247@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731034825.GI9247@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On Thu, Jul 30, 2020 at 08:48:25PM -0700, Paul E. McKenney wrote:
[...]
> > And I could make the comment here as:
> > 	/*
> > 	 * Delete QS reporting from here, by June 2021, if the warning does not
> >  	 * fire. Leave the warning indefinitely. Check RCU design requirements
> > 	 * in Documentation/RCU/ about CPU hotplug requirements.
> > 	 */
> 
> Rather than decide for our future selves, could we please just suggest
> reviewing this on June 2021?  Or, given enterprise distro schedules,
> 2024.  :-/

I am replacing it with the following, let me know if any objections, thanks:

+        * XXX: The following rcu_report_qs_rnp() is redundant. If the below
+        * warning does not fire, consider replacing it with the "else" block,
+        * by June 2021 or so. The rationale for this is as follows: The CPU
+        * onlining path does not need to report QS for an offline CPU. Either
+        * the QS should have reported during CPU offlining, or during
+        * rcu_gp_init() if it detected a race with either CPU offlining or
+        * task unblocking on previously offlined CPUs. To avoid deadlocks
+        * related to waiting on timers or cpu hotplug locks, only those paths
+        * do the QS reporting for offline CPUs.

thanks,

 - Joel

> 
> 							Thanx, Paul
> 
> > I will post my v3 with changes to the requirements document.
> > 
> > Let me know any other comments, thanks,
> > 
> >  - Joel
> > 

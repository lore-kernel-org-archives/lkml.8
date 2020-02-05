Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E9AC352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D233D2072B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QaYncY22"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgBEWeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:34:18 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:45049 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgBEWeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:34:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id g3so1648424pgs.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 14:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BJAZ+tjDZGEWKOLhDN5AGrWH1BdqO7gaMNKY2ZpYEZE=;
        b=QaYncY22KA1veHmJfyF9ObQNUPiSi3a+CYQ/HWRhROmmrwOgTOH5jglHbNzKa3crqZ
         0yWquqQt2uqdYLCLXrJPtB1A+OFdkF7HpKyn/NN7xtUqFHK7ipFabry5qlMjt0gX01gE
         iB3UJDUvBVIWfSXh0lUgCf+hLlzcJkZDwHd/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BJAZ+tjDZGEWKOLhDN5AGrWH1BdqO7gaMNKY2ZpYEZE=;
        b=P97TlfEr+H/MBdx/rzAOYR6Tb4vwgMRUwdHM/dNq70m7y3vgfRgj/bIL/jN1HNa9xk
         o21SRNNHC3wQ1SkKcehQd1QkCa/A52i7ek+4lW5pMQu2bwfNRtwm5JMZOZVWKXoSEB8G
         me48lLAY17NYp5s8l9VKB/gAKQQ7gYsflpt60edAs3Em3deJ5HZoGGvtpdBlAx13CSaG
         d+j90Lb/leWAxtVRh3Z9dlX+sNXyhP+L7UHVuDahnlPHmYe3TQdIyBVpcwOcXNDt1BwB
         XBbaYOtVUPEkanMQGmHX3rsH0dTp3iL62ey0FUzkRqMqFAk5gE0Ax3mAt8iuMmlwdpNT
         HCVQ==
X-Gm-Message-State: APjAAAUDV0545VWntXhDnSWntVcPnxEv2Ht2AK4SpIhJVHD/SKNH0mFw
        GNYFzkbpJB/BR2TvJeWIX2bwwg==
X-Google-Smtp-Source: APXvYqwH/JozABknbiZDhGi/qjztmZyyCX4nXbvdvUmqzc6dhXb1KJ7OGhn2QUC6bDzXn1X7tfRLFg==
X-Received: by 2002:a63:d0c:: with SMTP id c12mr130039pgl.173.1580942057139;
        Wed, 05 Feb 2020 14:34:17 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t19sm784459pgg.23.2020.02.05.14.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 14:34:16 -0800 (PST)
Date:   Wed, 5 Feb 2020 17:34:15 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        paulmck@kernel.org, frextrite@gmail.com, rcu@vger.kernel.org,
        madhuparnabhowmik04@gmail.com
Subject: Re: [PATCH] kernel/trace: Use rcu_assign_pointer() for setting
 fgraph hash pointers
Message-ID: <20200205223415.GA55522@google.com>
References: <20200205221808.54576-1-joel@joelfernandes.org>
 <20200205172529.4282a0d1@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205172529.4282a0d1@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 05:25:29PM -0500, Steven Rostedt wrote:
> On Wed,  5 Feb 2020 17:18:08 -0500
> "Joel Fernandes (Google)" <joel@joelfernandes.org> wrote:
> 
> > set_ftrace_early_graph() sets pointers without any explicit
> > release-barriers. Let us use rcu_assign_pointer() to ensure the same.
> > 
> > Note that ftrace_early_graph() calls ftrace_graph_set_hash() which does
> > do mutex_unlock(&ftrace_lock); which should imply a release barrier.
> > However it is better to not depend on it and just use
> > rcu_assign_pointer() which should also avoid sparse errors in the
> > future.
> 
> This is going to have to wait for the next merge window, as I'm already
> *very* late, and I've pushed the limit to what I will add at this time
> frame.

I understand, no problem. I will resend it next merge window.

thanks,

 - Joel

> 
> -- Steve
> 

Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D3EC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0626E20838
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 22:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="axUzghXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgH1WX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 18:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgH1WX5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 18:23:57 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554FAC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 15:23:57 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id p2so1071514qkj.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 15:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IAjW6p98DNeSLIu10vGW7p3vepoeZgY1KmTJgTOG/bU=;
        b=axUzghXFm+xtirUUyDR9WlbhXuIYKprTJMsQLoQqRSEkh0siU5+oWwq0MIPK4O+MlR
         QmTR4lZTgT7XhT7AdBtLHHuGySxCS29ydpriP6XIgGknrjZUOfhSn6PHhfm3XcUoXEvM
         q82gT+ukYcR1iFJ2kFcdZROMRfxv92uEaApdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IAjW6p98DNeSLIu10vGW7p3vepoeZgY1KmTJgTOG/bU=;
        b=OMNorYejZ0B3eI85XS6Y08DTUCh1zfHqFizCbQUnDqhmRC/Ojbx7gnLJor5Fe1D5NI
         v7kuy3mLpePZxhgRvZSOfT4BcSps1FC/4UQfvodmowrLPY5lsgLrT+GZIdFjYC27Qoar
         8VpzvOj0YnbAiXuHwawAOPnlqpG6Qop+z92568GKcUFhNih7IWgQkTu4fI7PHYm422LC
         jhIcID3kAIvn1pxGJ/rWOlCUgHLo2SW0zdtI5R+1xVCjdG9SPyI2OGDyHSXgTynDp9Ja
         i14mhdKqM8o/qUvhjdBx2iYLIgE7+G5NUqcc5JQdx1WsZ/YkvRJELv/X8JL11qUPi2O1
         +S5A==
X-Gm-Message-State: AOAM533GRM2AfyfBQRB9YG3qQE64cMf43GvfuFawtR8vZgS/rhtaCEt4
        zdNaGMrvfkDg0tx5J508+4djwA==
X-Google-Smtp-Source: ABdhPJxiWF+lxDu6RZ7StydqoCsefevRLn+NO0dALc8ZYTREodTF0cq/w2SJ9XH3GL7l6OXyYVbYmA==
X-Received: by 2002:a05:620a:15e7:: with SMTP id p7mr1252025qkm.56.1598653436492;
        Fri, 28 Aug 2020 15:23:56 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id n85sm435095qkn.80.2020.08.28.15.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 15:23:56 -0700 (PDT)
Date:   Fri, 28 Aug 2020 18:23:55 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Vineeth Pillai <viremana@linux.microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
Subject: Re: [RFC PATCH v7 08/23] sched: Add core wide task selection and
 scheduling.
Message-ID: <20200828222355.GA1874461@google.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <df3af13cc820a3c2397b85cb7de08cb6a0780e1d.1598643276.git.jdesfossez@digitalocean.com>
 <20200828205154.GB29142@worktop.programming.kicks-ass.net>
 <381e6ea5-a48c-9882-4c0d-49cfa92d21cc@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <381e6ea5-a48c-9882-4c0d-49cfa92d21cc@linux.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 06:02:25PM -0400, Vineeth Pillai wrote:
[...] 
> > Can we please split out this hotplug 'fix' into a separate patch with a
> > coherent changelog.
> Sorry about this. I had posted this as separate patches in v6 list,
> but merged it for v7. Will split it and have details about the fix in
> next iteration.

Thanks Vineeth. Peter, also the "v6+" series (which were some addons on v6)
detail the individual hotplug changes squashed into this patch:
https://lore.kernel.org/lkml/20200815031908.1015049-9-joel@joelfernandes.org/
https://lore.kernel.org/lkml/20200815031908.1015049-11-joel@joelfernandes.org/
https://lore.kernel.org/lkml/20200815031908.1015049-12-joel@joelfernandes.org/
https://lore.kernel.org/lkml/20200815031908.1015049-13-joel@joelfernandes.org/

Agreed we can split the patches for the next series, however for final
upstream merge, I suggest we fix hotplug issues in this patch itself so that
we don't break bisectability.

thanks,

 - Joel


Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB900C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C60A320771
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 01:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="fcIyB9vp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729853AbgFSBBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 21:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729302AbgFSBBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 21:01:46 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39CEC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 18:01:46 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id ec10so3721277qvb.5
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 18:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MJ6veFyzxDt135BoIfRzKOs9xaQDu2Yqf6GKe1z5Eo0=;
        b=fcIyB9vpbknZC/CmQAv0sRfKuQtGTX2dBJV+aATVZfItZbLJPnfF6DDJg7psKdn1mO
         g2Qf5hC7mdTHAMNeTwKiLiEI/gK80VSljz33bbvO8dcxcoZ+lRb9BXYoadKBIh6TKveV
         hTv/Za8X7gzAd8G5Tlo9cz2HTWg8KDU9nqWlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MJ6veFyzxDt135BoIfRzKOs9xaQDu2Yqf6GKe1z5Eo0=;
        b=NEF5cdrrxLP7HuZVJTLRuL2nDEH2nnXnH6r2b1fk4kPqNdB8H5CbqTNuwLiVm+s3Mj
         mSBqomXGFBrQanQjuv68fP/JBL+QD4oUVi7/ESvsidhhruCygX2BO/RgQnzW1A8VnG3O
         igyIWPnNu7qfi+GgGN1wOzgLXqeHyK3bzgXjuAFwsUDC61QPcqzEmVXn4un9dTJPQSwI
         MJ91I/qDLdbj3TZw8UC4pon2BxIPKJ94Be+WeRT0+q6xxUzouFuJDMDI/qlZDCOKd9RS
         dteBEWZ8L8p8vb2lhduXaleHWqKUQvuHzvusMnsalYJ48Bi1tLnCOlNNiChucM7EwDI7
         eFrQ==
X-Gm-Message-State: AOAM531Hyq4dkbosIAdquvLNI41Ri5pt4KEsifE9Yr0g4o7lBaVbXJcN
        Sj8YQLjnQnMnedG/1zThQM7lNA==
X-Google-Smtp-Source: ABdhPJyPbwMv7xmOR0zrhGfawXpUfQc9CBRHap72QZBY41qY/2j9nrXNnzCAiZX4nU/81eVpTlvC6A==
X-Received: by 2002:ad4:56e3:: with SMTP id cr3mr6499327qvb.175.1592528505164;
        Thu, 18 Jun 2020 18:01:45 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id o62sm4601391qkd.53.2020.06.18.18.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 18:01:44 -0700 (PDT)
Date:   Thu, 18 Jun 2020 21:01:44 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        rcu@vger.kernel.org, "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH 3/7] rcu/trace: Add name of the source for gp_seq
Message-ID: <20200619010144.GH40119@google.com>
References: <20200618202955.4024-1-joel@joelfernandes.org>
 <20200618202955.4024-3-joel@joelfernandes.org>
 <20200618221901.GZ2723@paulmck-ThinkPad-P72>
 <20200618200138.500b20cb@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618200138.500b20cb@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 08:01:38PM -0400, Steven Rostedt wrote:
> On Thu, 18 Jun 2020 15:19:01 -0700
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > For future reference, the TPS() around strings is not optional.  Without
> > it, trace messages from crash dumps are garbled, if I remember correctly.
> 
> When you pass in a string like this, only the pointer to the string is
> saved in the ring buffer. User space tools have no idea what those
> pointers are. The TPS() around strings maps those pointers to the
> string and shows them in the /sys/kernel/tracing/printk_formats file,
> such that perf and trace-cmd know how to make sense of those strings.

Makes sense. Quite a valuable feature!

thanks,

 - Joel


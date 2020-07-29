Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D690BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE9E82074B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+/zYiBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgG2Xct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgG2Xct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 19:32:49 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22573C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 16:32:49 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 74so5693140pfx.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 16:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=2e8RCHR7zK7mYDiJHIGb9P5RdtY7eXETdj3bdIaDpFg=;
        b=Y+/zYiBG7yMH/+zZtdcZc8UNqZQCaiJqXOM/7Ca/i9kg7Hrs3+s40fsGgMEBvIMQrf
         GaS7whhngR/dRIRLunl1B1JB1KAjc+sL7s2Frxx47H6ps6B2dnp9uTHXnWWBtVYT+IPL
         VcRu4VxfagbTG7nKFBB4+Rdt82IcUrF5IUINpoaJqvQW7RW1/OAlEM87X8Chc0+eQpv9
         X/IxFSihmb0tyufAMxSxpLycnqASvWxM9MvYefrOVlrVqAoD4NMw8S+OetrDTQJiRigB
         6eViD66WmlPn4L3pCIhYL59sgMfsTIO8j2I79666hKZPMbmfkn5ZHveqvPCiFS8dzfqS
         D4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=2e8RCHR7zK7mYDiJHIGb9P5RdtY7eXETdj3bdIaDpFg=;
        b=A2TQMtTaG4kM96KAOh0KWQb78HNC5SgHyxuMyYRsI5Osopt2pgaIRsHn0mScnuVyyt
         55vyZ0lJ7iQJwqIIKChZqDURYkk27ab4nLpwE4TcTRCAnXhw8aFZUUoZzsGYKuAKna0C
         hIfqe7jaD1gkXFO8z/xXpHKRuqxFv6/VKplb+x+f3J/t5O1L39b3NWhCLx2JfdwTNMZl
         nGDjJdL1N3GZH9VPpWzWGPqnsnY5WPkhmnKxvtitMneyzuTeT55uUOyxTXEW4lWAXL+w
         aHkkMb/dO6NiCpMINQmwiq/qFt3FMiLXHNYkFIR/c5rQ21HjQHh07I390XYkulbK37nE
         6k+g==
X-Gm-Message-State: AOAM531m/1pyJ56VeLFqM6TWztETjzBpBYb4sVoOvRSFQ2CommbykfXv
        SQwpWVGOER14qOj9ZUWUKfExlQ==
X-Google-Smtp-Source: ABdhPJy/+vWWiGWHOB9uKSOFg6qQ7W03EDCKFGbHDvKIeGqlzNlldtrXmcI7KwfCyD0c9QWtxZuvRw==
X-Received: by 2002:a63:e50a:: with SMTP id r10mr30978179pgh.285.1596065568352;
        Wed, 29 Jul 2020 16:32:48 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id l62sm3386842pjb.7.2020.07.29.16.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 16:32:47 -0700 (PDT)
Date:   Wed, 29 Jul 2020 16:32:46 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     "Zhang, Qiang" <Qiang.Zhang@windriver.com>
cc:     "cl@linux.com" <cl@linux.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?Q?Re=3A_=E5=9B=9E=E5=A4=8D=3A_=5BPATCH=5D_mm=2Fslab=2Ec=3A?=
 =?UTF-8?Q?_add_node_spinlock_protect_in_=5F=5Fcache=5Ffree=5F?=
 =?UTF-8?Q?alien?=
In-Reply-To: <BYAPR11MB2632BEC45DC867E80F841B82FF700@BYAPR11MB2632.namprd11.prod.outlook.com>
Message-ID: <alpine.DEB.2.23.453.2007291631040.3120473@chino.kir.corp.google.com>
References: <20200728095551.30634-1-qiang.zhang@windriver.com>,<alpine.DEB.2.23.453.2007281238580.2664959@chino.kir.corp.google.com> <BYAPR11MB2632BEC45DC867E80F841B82FF700@BYAPR11MB2632.namprd11.prod.outlook.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jul 2020, Zhang, Qiang wrote:

> > From: Zhang Qiang <qiang.zhang@windriver.com>
> >
> > We should add node spinlock protect "n->alien" which may be
> > assigned to NULL in cpuup_canceled func. cause address access
> > exception.
> >
> 
> >Hi, do you have an example NULL pointer dereference where you have hit
> >this?
> 

If you have a NULL pointer dereference or a GPF that occurred because of 
this, it would be helpful to provide as rationale.

> >This rather looks like something to fix up in cpuup_canceled() since it's
> >currently manipulating the alien cache for the canceled cpu's node.
> 
> yes , it is fix up in cpuup_canceled  it's
> currently manipulating the alien cache for the canceled cpu's node which  may be the same as the node being operated on in the __cache_free_alien func.
> 
> void cpuup_canceled
> {
>         n = get_node(cachep, node);
>         spin_lock_irq(&n->list_lock);
>         ...
>         n->alien = NULL;
>         spin_unlock_irq(&n->list_lock);
>          ....
> }
> 

Right, so the idea is that this should be fixed in cpuup_canceled() 
instead -- why would we invaliate the entire node's alien cache because a 
single cpu failed to come online?

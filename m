Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EA7C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF7DF2080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D24klSlQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbgBJIH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 03:07:26 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27661 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725468AbgBJIHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 03:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581322044;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R/vrAcei338JXmIq8PEiyq5Efj26tu4WshIpJ4aAFt0=;
        b=D24klSlQUYC3vrFZZw3b2Zi1BFVF0wymub+2wj4EW4h+tnCwfMi8/3YNxda9VK0DtPVhzF
        jeC87db8fjDR+AX/yFswBjJpBhfCTSB/JOo4teUvikyKnjRLVX2gJogxJ0qM0/bU6h6EfJ
        wJ+yaTsfHM5faqISVUXo9PQDPydFlEI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-DKlFqS7YNci9yCybhuLeQA-1; Mon, 10 Feb 2020 03:07:22 -0500
X-MC-Unique: DKlFqS7YNci9yCybhuLeQA-1
Received: by mail-wm1-f72.google.com with SMTP id n17so2872617wmk.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 00:07:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R/vrAcei338JXmIq8PEiyq5Efj26tu4WshIpJ4aAFt0=;
        b=WWLm5rm8pALg08bSEZ2rfIl44v05qQ8a0QcI7gYbttCAG7ezKUS8PXEC+XTQtapPFO
         GAip3E9SV6HTvs+0w0ENmfh4EcX984aeME43iMzSNO5blRFNKYXEriVgAvzPXaeKLsY8
         AXDsOWOxt8InphrvaqmtKR6q3zAtSipWVS60s7TGYQ74sMS6GZHdmWD4xea5OaVWP0aA
         wQpVaXxc9xPbfaXZpmwyRJXYnlan7tdOMlygf71RAiVBIeBJ0FR59FwwpaS96cAAE863
         BT4jpDvGlAB09QU//v82BAk36K8MrwEynGxKRMbjjS+BzqifLMcz+IMcxPHnEmTjqiPN
         kMaQ==
X-Gm-Message-State: APjAAAUjpPkbdmUQcwXuW4pjXU6xPQ9sralaY/89DpL8o1hqZZoEXmoN
        Kn3J0pvw4RwksLIibTWI1m/RzvuXdNfmlGihlTkJLcDHYF7D6nKKuxw534ynpSobi24iGRBg5+0
        53JXH7ao/RcwGIZu0sQMkU4SH
X-Received: by 2002:a1c:7406:: with SMTP id p6mr14647152wmc.82.1581322041636;
        Mon, 10 Feb 2020 00:07:21 -0800 (PST)
X-Google-Smtp-Source: APXvYqzyutQzrqNLBSHCcjxPc2EBxYV84bPCyNl9toOZe4wlgGLy5GGwUc79SQYvtPkEpAQyR519RQ==
X-Received: by 2002:a1c:7406:: with SMTP id p6mr14647117wmc.82.1581322041343;
        Mon, 10 Feb 2020 00:07:21 -0800 (PST)
Received: from localhost.localdomain ([151.29.2.83])
        by smtp.gmail.com with ESMTPSA id k10sm15250485wrd.68.2020.02.10.00.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 00:07:20 -0800 (PST)
Date:   Mon, 10 Feb 2020 09:07:18 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     boqun.feng@gmail.com, peterz@infradead.org, mingo@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] sched/deadline: Add missing annotation for
 dl_task_offline_migration()
Message-ID: <20200210080718.GG7650@localhost.localdomain>
References: <0/11>
 <cover.1581282103.git.jbi.octave@gmail.com>
 <4cebf47c30ce24ee1972f4b6330376d8f32802b9.1581282103.git.jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cebf47c30ce24ee1972f4b6330376d8f32802b9.1581282103.git.jbi.octave@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 09/02/20 22:39, Jules Irenge wrote:
> Sparse reports warning at dl_task_offline_migration()
> 
> warning: context imbalance in dl_task_offline_migration()
> 	 - unexpected unlock
> 
> The root cause is the missing annotation for dl_task_offline_migration()
> 
> Add the missing __releases(rq->lock) annotation.
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Best,

Juri


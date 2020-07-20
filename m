Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F8E8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E29920729
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kdy0A+XP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgGTWGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 18:06:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24845 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgGTWGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 18:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595282763;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ui4TgDlV8SNq6AEy7rMKlPf4tS22AT8vC1X2BWWDx3M=;
        b=Kdy0A+XPVkITxNJa63G6ruR2pGHfTbpFW06mn/saYxqUvx0jd7sT9pnwquPq1gYygP8mus
        HiLM73BgnIv5LDOe69Uq+EGfqYIdj4bqPYw33TF7/+UTWrc6vuC0N2tN8QolJVrX67yUgS
        sktPR2hqMzXznf8xc/s9jX3htNkGOBI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-16-o0DmeRstNG-tb8L153dEWA-1; Mon, 20 Jul 2020 18:06:01 -0400
X-MC-Unique: o0DmeRstNG-tb8L153dEWA-1
Received: by mail-qt1-f200.google.com with SMTP id t36so12904291qtc.16
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 15:06:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ui4TgDlV8SNq6AEy7rMKlPf4tS22AT8vC1X2BWWDx3M=;
        b=BRF5epEwbohfmMNp8Z8IsZlDMWCSFJa0fCU/sYh84KKGxgKTDq27ztXH2EV5paTrJe
         LIKIlbu6iB/nZ8bYz8MKNgqNmQpLXR6PKUVRyPq0xdv1mxe+I75ph7cU3L87TR4VBTuH
         g6yXVAHB5I6Vqb93MsiwJYcQbL9eN+VySZRHYLdm0mfbKej2lUd1og3/0gpAAFbTWPel
         TgjpYNB45RGzdVG2m+/NG/svMFLIdsvL4fqjo/Q0Sp1JHQBwsONIsDWkMB3EcEsPxSuw
         4dcSz7g1TvkCx+a4yWrVNaFac50kN6ZOsK5uu01zNSBF/ccgttUZZ+7TTNKvsSHQ+5WO
         nHbQ==
X-Gm-Message-State: AOAM533Jnyp8aZ4xVJy4I+bTHxwLGXlibPFYysBfGyI6zBd6h2Vl6RDR
        DjzHXqmdLNFY8Kzan9f+ZF35neD2zUhsZhDwu3IIs0dy0n+uWLowW67Z9jr+G9MDJjbmCnJseKW
        qMdvJ0ssiFYhurQxYa/yID63J
X-Received: by 2002:ac8:5691:: with SMTP id h17mr27088654qta.35.1595282760686;
        Mon, 20 Jul 2020 15:06:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxktMziFRW26sqcuKCe1BiUW9KgrudLEhWcfpNy5hfiS8Zzypyg7oYWH9pVueXeHLJsRJoD/g==
X-Received: by 2002:ac8:5691:: with SMTP id h17mr27088613qta.35.1595282760176;
        Mon, 20 Jul 2020 15:06:00 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c8:6f::1f4f])
        by smtp.gmail.com with ESMTPSA id y12sm18742348qto.87.2020.07.20.15.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 15:05:59 -0700 (PDT)
Date:   Mon, 20 Jul 2020 18:05:57 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Rich Felker <dalias@libc.org>
Cc:     linux-kernel@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org
Subject: Re: [PATCH 20/25] mm/sh: Use mm_fault_accounting()
Message-ID: <20200720220557.GP535743@xz-x1>
References: <20200615221607.7764-1-peterx@redhat.com>
 <20200615222306.8502-1-peterx@redhat.com>
 <20200720212524.GL14669@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200720212524.GL14669@brightrain.aerifal.cx>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rich,

On Mon, Jul 20, 2020 at 05:25:24PM -0400, Rich Felker wrote:
> What's the status on the rest of this series? Do you need any action
> from my side (arch/sh) at this time?

This series should have been queued by Andrew in -next.  So iiuc no further
action is needed.

Thanks for asking,

-- 
Peter Xu


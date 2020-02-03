Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF41C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 12:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B0A2192A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 12:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIEQPIAm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgBCMZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 07:25:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51875 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727339AbgBCMZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 07:25:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580732720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rnhSOZrfyRptYaXvcR6IW21U5l/A6AEDfxI9feZjAvY=;
        b=TIEQPIAmVdzZr0tT1lydQNdr7B2//2TcnqVUzs+WxOo8KxNX0qoDUf6BH5lozIjX1xNsk7
        VfjG37/cbB0hX27Bsx8oj7kz1cqZEpSPItJu2GPHp5tdelGGwOXgk1m7mrMBdfWdTc0rzJ
        UFK1vvK+w52hD5EpMYUDfyE0y07b/+U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-WtNfqeaONfWCNl_avbI_Rw-1; Mon, 03 Feb 2020 07:25:19 -0500
X-MC-Unique: WtNfqeaONfWCNl_avbI_Rw-1
Received: by mail-wr1-f72.google.com with SMTP id x15so8124348wrl.15
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 04:25:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rnhSOZrfyRptYaXvcR6IW21U5l/A6AEDfxI9feZjAvY=;
        b=pYmCAzUj+EPdvvLjQbcqqM0gJEATL6wutjXJyZUU727JmoNLfFSgG+bn174eRNqudN
         IfO8HnGcWt4Uzpvg209G88jQbXwGeZtSUdB7Yo4xl6bmduwTQSjjcVY7pE3PVGa4pt6i
         9m1WNQ9eNXF6zmEQsr4LCxMbAtAe7uQ21t+TBEzi3HadkKX59jB0HKPqg4ebZtb8Ya6q
         ABrEBomnhxiI4S6BY3nxFai1vfwJXOXCdleCDXlJRGxrJxBs9Y991RQvSceHnNJiEtgT
         ukTa0NdvWNDpqyAdLCU3Y8ePgdta8LnWR3yubrwHRd78kdD2Pz44HFiKji3UpF1h9uGA
         213g==
X-Gm-Message-State: APjAAAVuQ6vcKZF7+GMGQjhUxYSnk/k0IuJSBpBUAs5vRY7Upxk7fo+M
        zdQcyci8gaktzcSg5vyU1sBxCsoViWHMDi8vyszGj8OIiCbuIElQ6fEP0QTIpIieimvegIEhUWr
        M/qCQYEcBIBVXELkQnIO5IV2G
X-Received: by 2002:a5d:4d04:: with SMTP id z4mr9862978wrt.157.1580732717982;
        Mon, 03 Feb 2020 04:25:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqy5ghHPlkc6xYznMwtJxDFgEjOmagx2Zb7+ckF0+ETu5uHQ0dVmPuQCkSW/CyhcLslYmPrC6w==
X-Received: by 2002:a5d:4d04:: with SMTP id z4mr9862941wrt.157.1580732717777;
        Mon, 03 Feb 2020 04:25:17 -0800 (PST)
Received: from localhost.localdomain ([151.29.2.83])
        by smtp.gmail.com with ESMTPSA id e22sm18968813wme.45.2020.02.03.04.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 04:25:17 -0800 (PST)
Date:   Mon, 3 Feb 2020 13:25:14 +0100
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, will@kernel.org, oleg@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, williams@redhat.com, bristot@redhat.com,
        longman@redhat.com, dave@stgolabs.net, jack@suse.com
Subject: Re: [PATCH -v2 0/7] locking: Percpu-rwsem rewrite
Message-ID: <20200203122514.GK8582@localhost.localdomain>
References: <20200131150703.194229898@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200131150703.194229898@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31/01/20 16:07, Peter Zijlstra wrote:
> Hi all,
> 
> This is the long awaited report of the percpu-rwsem rework (sorry Juri).
> 
> IIRC (I really have trouble keeping up momentum on this series) I've addressed
> all previous comments by Oleg and Davidlohr and Waiman and hope we can stick
> this in tip/locking/core for inclusion in the next merge.
> 
> It has been cooked (thoroughly) in PREEMPT_RT, and not found wanting.
> 
> Any objections to me stuffing it in so we can all forget about it properly?

FWIW, backported and tested again on downstream PREEMPT_RT kernel.
locktorture didn't find any problem and latencies look good.

Tested-by: Juri Lelli <juri.lelli@redhat.com>

Thanks!

Juri


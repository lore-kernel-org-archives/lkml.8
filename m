Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374AAC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0388524125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579596237;
	bh=SOtOdKhDkbjdhdwtVbPIIzp2AuPc/9Dy7C9qYoRm3Tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yREqHTR39aFCvs6OhLGnKHmCAWE2wmiZLGqvBKg3r0YP45vLmKWUGgNYqJNVWehXd
	 /7UcG1HEQpMtnogOp5eYU2EQ0VVDOAjtz7hPw9SqIzLRh6Y6Tajx9XdL+G9sEzMvXZ
	 /J3AayCAhk0X4ayvbEGmBHbx9dxYTWEFgtUgQbe8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728912AbgAUIn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:43:56 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55924 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgAUInz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:43:55 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so1980690wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 00:43:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p1miCEumvBZXojM3ziPoJ3SDCJDQgzFEnuJYN1G9228=;
        b=fF7Gyv8/ViMVTShqo9qPVGGQhybEemCNixYzXfmh85JISJULNs9YvXJ0PPXdfhHqpZ
         u3aUusff376J0BXfClQymutpd6SKPNLmkAAXqSUSnUPw6tQrK6KLDO2K6tLNivmp3dhv
         n7co4iT27o6KsrcFFogPULQafdGwSYGfSMdPxZVC+g1etlG+MW3qemUS1tz1zkWerscY
         c9W8cOcvZwsW5Eb2Os0+vCGsI3ZXYmaOe2M3b+RWf0H40JKJ8vU5VyjWZ34XIDtvDvcg
         sGmyWMT5OiF/0WYo5wHXg32uJf/8E+RqI3YdCObPhpg9YzNkzJQRUU6t5HQ4XapmYWNE
         3h3g==
X-Gm-Message-State: APjAAAW/PMmuXehjGSwXAMFZLIiU90sYr+uBCpMQHD9GoZOdlHiM4JwD
        cDLDqP50eovFKozAl/bx66Q=
X-Google-Smtp-Source: APXvYqwYudapVU8PoPSwbA44q1zIHoW7i923mC1fEQEvAPemabET9G4XEzRgom6tH9Wi1RBaQ+1ACg==
X-Received: by 2002:a1c:a50e:: with SMTP id o14mr3086072wme.2.1579596234154;
        Tue, 21 Jan 2020 00:43:54 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id f12sm3048208wmf.28.2020.01.21.00.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 00:43:53 -0800 (PST)
Date:   Tue, 21 Jan 2020 09:43:52 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.shi@linux.alibaba.com
Subject: Re: [PATCH 7/8] mm/migrate.c: move page on next iteration
Message-ID: <20200121084352.GE29276@dhcp22.suse.cz>
References: <20200119030636.11899-1-richardw.yang@linux.intel.com>
 <20200119030636.11899-8-richardw.yang@linux.intel.com>
 <20200120100203.GR18451@dhcp22.suse.cz>
 <20200121012200.GA1567@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121012200.GA1567@richard>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21-01-20 09:22:00, Wei Yang wrote:
> On Mon, Jan 20, 2020 at 11:02:03AM +0100, Michal Hocko wrote:
> >On Sun 19-01-20 11:06:35, Wei Yang wrote:
> >> When page is not successfully queued for migration, we would move pages
> >> on pagelist immediately. Actually, this could be done in the next
> >> iteration by telling it we need some help.
> >> 
> >> This patch adds a new variable need_move to be an indication. After
> >> this, we only need to call move_pages_and_store_status() twice.
> >
> >No! Not another iterator. There are two and this makes the function
> >quite hard to follow already. We do not want to add a third one.
> >
> 
> Two iterators here are? I don't get your point.

i is the main iterator to process the whole imput. start is another one
to control the batch to migrate. We do not need/want more. More clear?
-- 
Michal Hocko
SUSE Labs

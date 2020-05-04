Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99B8C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2CF22073B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:01:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="byoBOldM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgEDUB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 16:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728045AbgEDUB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 16:01:26 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3F6C061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 13:01:26 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id s30so86531qth.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 13:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WgubC2Z2oGM4A5Njnye3JH+tCzZ03fvavr65xjrogvc=;
        b=byoBOldMgeHecwxlmLT6bSoBGMqq5XVrcCE/QIXTwZ5Z1zmAMjCQD3wL11UJwDU2lw
         3qhTF9LVQf9dkkUIV71g+SWr/RfuCb3/XGvc1R2LfzdjtH8rYgfM96Bl6RBDPaHp990D
         asZVW5bGvKDz/BlUViwpGaZFOPO5opbcH/VTC+kmtaZ4brqdecmRCKURV3ah0oCE1dAN
         fjyfOVIkh+8VXtfajjydyGp1VIFazLovVGOyOoZjQQvq2kONRooMHTka6BjNApa+t5ok
         VrlY/HpHtrmnLajDts1PqoCvS2x0PvnP3mSjm4poXsTfXJOYDAkwEwO8amq/GCGdJehP
         go1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WgubC2Z2oGM4A5Njnye3JH+tCzZ03fvavr65xjrogvc=;
        b=XyGPO2uWTcz6kqi57prPvTkisYf8K58P4cI0/4pPYdvZDEdq82VyqEFzYJKBSqq+t1
         JusnaHCHFEQ55XJQqHi0z+/XBRHWPlKQqgJTwJCW8Q2bOWJaQY+RynErVu3Ny/SnN3Zw
         1QQwPBkjpwExKHFouOSQAtKb67eXDHSK+4QsZbBl+s2TMxu2wmu2POVSm/7mNLuvF9sm
         tBmHhQ7KpBuqTZJMjbgV0zT99YiKk/ExVWedUaQIkNxQBqKqKzv79YuUnZkwBqIh5nIQ
         OXgoIGmMz0kGIuKrVNDDXqczoklZ1n98ogzeXPwlPbVDpTvM7Bu3unclIrTA4l0OLKzM
         qPaA==
X-Gm-Message-State: AGi0PuZJ2A0suUH/5crO2tsq6rMHY7F+cpsm0PNsJrTOxWYlWV/VEvQi
        4O+LEBUJxy/Pru1Q91wy9TgRSw==
X-Google-Smtp-Source: APiQypIe6YV0BMjlELv09gZGrZM8PJzohFM36QsELGEVtRnQfj46T79bUlNCRqUae9T4ajx7WUuKQw==
X-Received: by 2002:ac8:24b7:: with SMTP id s52mr827620qts.316.1588622485189;
        Mon, 04 May 2020 13:01:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d4sm11335892qtw.25.2020.05.04.13.01.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 May 2020 13:01:24 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jVhHH-0003EA-Q2; Mon, 04 May 2020 17:01:23 -0300
Date:   Mon, 4 May 2020 17:01:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        cohuck@redhat.com, peterx@redhat.com
Subject: Re: [PATCH 3/3] vfio-pci: Invalidate mmaps and block MMIO access on
 disabled memory
Message-ID: <20200504200123.GA26002@ziepe.ca>
References: <158836742096.8433.685478071796941103.stgit@gimli.home>
 <158836917028.8433.13715345616117345453.stgit@gimli.home>
 <20200501234849.GQ26002@ziepe.ca>
 <20200504122643.52267e44@x1.home>
 <20200504184436.GZ26002@ziepe.ca>
 <20200504133552.3d00c77d@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504133552.3d00c77d@x1.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 01:35:52PM -0600, Alex Williamson wrote:

> Ok, this all makes a lot more sense with memory_lock still in the
> picture.  And it looks like you're not insisting on the wait_event, we
> can block on memory_lock so long as we don't have an ordering issue.
> I'll see what I can do.  Thanks,

Right, you can block on the rwsem if it is ordered properly vs
mmap_sem.

Jason

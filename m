Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A3EC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA1E2468D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583839038;
	bh=waUGGe6GI90YqE8xsOdU3983381gCj01LyoQhH7l21k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FLEp3ZDGvClsleuqli5F2S1AOSuO63DyaeDOgsiLa9UtvW51cTqQaGSG2juTKzCPq
	 OcwHacbICHmivscnG3Ab7nYPwRBPW2ObW4ERUmkmLUvOucA7Ke6N6a1Ips6NOKmJV2
	 veSbevXv4dGGU9tfc7OJyzjSGToNMQ7JRshZQXGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgCJLRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:17:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37841 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgCJLRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:17:14 -0400
Received: by mail-wr1-f66.google.com with SMTP id 6so15332298wre.4;
        Tue, 10 Mar 2020 04:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hMeYQLjzGBbtQiC8mAcdXgfjl4PT8fCW6CmTjHRY5u4=;
        b=ST3E6xJFYBuU0kajH+iJyGJhMRZzyEx1lCvyrh+CpSinJ7Opb6PVGmYNqLgoD5yFDd
         c89Uo/JG/+h9PDC6R+oYzIfGatcu9GQnPM0fAjWwCMqzOSFqdjwfH7PQLc1pu4UFrYQa
         x4AUfe9hCOWZiFyIr4WW/gcRKzrhzg0P4Mlg6QmkJDD0UJYGNzeFS5x0PUD+hiiw0WWW
         YDCpL+lwwYI426xGKBntuMJ15RCTMpN/eBojWZ4v/XZDP72aZgj1/hTzXwEnLtTNtb8O
         10KCAmCzkRepVgWJNDrAGYPu7AD2YV5gvE4OVJcmM0yNS8wOEcJtGxjebJodpIHhB/iY
         2A0A==
X-Gm-Message-State: ANhLgQ0yhfUeJ3ERRAniBHi4AJaoHgasmgKdn2IUffeT/i34W8CcT7+E
        lUMjGXjeo8wfYAUE8oguiiLUOYUj
X-Google-Smtp-Source: ADFU+vvwMGbod/4+O259JslpdYAISzZQ2Ja6Zj9n5SvnGOf2IeBIQt9CdyH0FQcsl015TRgEW+7DEw==
X-Received: by 2002:a5d:4685:: with SMTP id u5mr25849575wrq.69.1583839032708;
        Tue, 10 Mar 2020 04:17:12 -0700 (PDT)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id 5sm11485857wrh.10.2020.03.10.04.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 04:17:11 -0700 (PDT)
Date:   Tue, 10 Mar 2020 12:17:10 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     brookxu <brookxu.cn@gmail.com>, hannes@cmpxchg.org,
        vdavydov.dev@gmail.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] memcg: fix NULL pointer dereference in
 __mem_cgroup_usage_unregister_event
Message-ID: <20200310111710.GF8447@dhcp22.suse.cz>
References: <077a6f67-aefa-4591-efec-f2f3af2b0b02@gmail.com>
 <20200310094836.GD8447@dhcp22.suse.cz>
 <20200310104149.5c3pc75y6ny5hixb@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310104149.5c3pc75y6ny5hixb@box>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-03-20 13:41:49, Kirill A. Shutemov wrote:
> On Tue, Mar 10, 2020 at 10:48:36AM +0100, Michal Hocko wrote:
> > [Cc Kirill, I didn't realize he has implemented this code]
> 
> My first non-trivial mm contribution :P

Everybody has to pay for sins of youth :p

[...]

> > It seems that the code has been broken since 2c488db27b61 ("memcg: clean
> > up memory thresholds"). We've had 371528caec55 ("mm: memcg: Correct
> > unregistring of events attached to the same eventfd") but it didn't
> > catch this case for some reason. Unless I am missing something the code
> > was broken back then already. Kirill please double check after me.
> 
> I think the issue exitsted before 2c488db27b61. The fields had different
> names back then.
> 
> The logic to make unregister never-fail is added in 907860ed381a
> ("cgroups: make cftype.unregister_event() void-returning"). I believe the
> Fixes should point there.

Yes, you seem to be right. It doesn't make a difference much as both
went in to the same kernel but a proper Fixes tag is really valuable.

Thanks for looking into that.

-- 
Michal Hocko
SUSE Labs

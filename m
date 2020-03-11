Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6403C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37F920637
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583916318;
	bh=SbGcW+jFnB/P1s2CI1dYCsxl0keXRyzMWuMWKfiomyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vzLgiEs8/f6H31Gi+lLQj6BfAM74+KwfqbZkyir7weM3WcuwQTQm2WpOi0i9ItSZI
	 P25RIilzKvJnR9n6v/gPXoJmojUsptd84+V5ecpvDSlsq1j6cCmhaoQmUEJal0T4IM
	 gM3uaTZI+s6KOE0/a68SVa1CKvJC1auL+Jj260mU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgCKIpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:45:17 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:53765 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbgCKIpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:45:17 -0400
Received: by mail-wm1-f41.google.com with SMTP id 25so1093742wmk.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 01:45:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pRBMlMBO4NTBoT2wAbroYDijV50kCEx9++6sottZmCc=;
        b=LP9oSiYaVmWOjJaulSTb/S4YhuZ9DEMP2X5f6WT14FgPVvsRPgFK89PIcrurHAW7Jb
         ZJj956ETwzNyiRIjOG5WmPlqeoiMSS6OHNe2URHegvgyYfAIheo992pD0bX+C0XnHKUP
         LK+xhh+0dl9Z1Xb+uvUVZNfE28/RDuCo9K+VGrpolWMXUgKy49i6N6T6JKaV/dKSKyrx
         ACtVSsvJcKPPa3fV+BFK+WOoXEcw3AuZQ6siM0kldxOPMb52AcXW5oBDMzIzrLwL8PRY
         cZr+AMtUM2YMLGFxsZ4g6n4a1edL/nOGEGRw8UBnspZA6MTXCERPdMHxm2BSBzQeoRWh
         KNdQ==
X-Gm-Message-State: ANhLgQ2BWuV4yqDiYDvjXTw82C1MrkU5MFJ2KyMselwyAH1BQNVZFqQk
        BzId3DsnHObn8cCxNPBWXj4=
X-Google-Smtp-Source: ADFU+vvWcCh1ENBrqTJkvzRy7OXTXHVBKkeQjnbgzUzLh601tXQ/IzCJON+i3FCQ5QVs/GRZD2pe0g==
X-Received: by 2002:a1c:6108:: with SMTP id v8mr2523779wmb.58.1583916315039;
        Wed, 11 Mar 2020 01:45:15 -0700 (PDT)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id c85sm7752772wmd.48.2020.03.11.01.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 01:45:13 -0700 (PDT)
Date:   Wed, 11 Mar 2020 09:45:13 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>,
        Minchan Kim <minchan@kernel.org>
Cc:     Jann Horn <jannh@google.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
Message-ID: <20200311084513.GD23944@dhcp22.suse.cz>
References: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
 <20200310184814.GA8447@dhcp22.suse.cz>
 <CAG48ez2pNSKL9ZTH-PQ93+Kc6ObH6Pa1vVg3OS85WT0TB8m3=A@mail.gmail.com>
 <20200310210906.GD8447@dhcp22.suse.cz>
 <cf95db88-968d-fee5-1c15-10d024c09d8a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf95db88-968d-fee5-1c15-10d024c09d8a@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-03-20 15:48:31, Dave Hansen wrote:
> Maybe instead of just punting on MADV_PAGEOUT for map_count>1 we should
> only let it affect the *local* process.  We could still put the page in
> the swap cache, we just wouldn't go do the rmap walk.

Is it really worth medling with the reclaim code and special case
MADV_PAGEOUT there? I mean it is quite reasonable to have an initial
implementation that doesn't really touch shared pages because that can
lead to all sorts of hard to debug and unexpected problems. So I would
much rather go with a simple patch to check map count first and see
whether somebody actually cares about those shared pages and go from
there.

Minchan, do you want to take my diff and turn it into the proper patch
or should I do it.

-- 
Michal Hocko
SUSE Labs

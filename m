Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2941CC54E4A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1EB821655
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="ql9fwMag"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgEGUdv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 16:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726367AbgEGUdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:33:50 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74723C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 13:33:51 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id k81so7630401qke.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 13:33:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=baTteJqyH6isN/89zdtKchdhH2DBXV9A3IqICZz/QOE=;
        b=ql9fwMagiN0bQ+ctBRPwFkrgKyHeVXx8Q80yLGh4UpVEp26yaQwCdGZ4qSDYv9RYRF
         kO01i1USbkS3uBGPMelctZrrOhx3sQb9AEJtWDGkzVCZk4jcDJNco2YCusnjNLDTjfE2
         aKQCh+/AmnCztjhFrv5RSn0VZG8l9092XS88Z5bBA+I8HnB/wKRqzg0bKZ/yyBuZEl1l
         73ohXJZ4eIMeDQ5gx4lV4qfBWWOaaqrvOc/l1qGXpol6sWFi9FQS9kBgsNwLbfXDpWix
         bcr/2KfsbPnwCRiI5qEbSa+EsuqImEZ3hMc2aHCmwj2Q0c3kuIxBUphC7AbLnITF0Xsw
         kJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=baTteJqyH6isN/89zdtKchdhH2DBXV9A3IqICZz/QOE=;
        b=MHbGOScKwRFr1K6DEIbnydBMQQ1fEoV3PeDaTes4Y63icltMuZk6B4htbO0H6jVBQ2
         uVdn4xosfPm7cFyNar71Ce7vlVVyfob14LPy55dymKrOkFIOiKCyhnuPx7HCUwJWiF+R
         +w08x/zr65RxPVelEYLJIgFJ1fQXQVphL8KUu8hp7v7lROPF2y0yqgFKs9JRk1r/MNNo
         x/cJVDl3HUzPlmEO0tPwfVBfAP2EIpGII8EA5dvqe02VE64JZ92rDz6gewrbUb3EMpUZ
         7EfDW7h9Pm4J8h31551Eha8dzBu+HAwAsqlolYGZg5fjeE+ka55kEZ7EGzIxLPtB4sPM
         OcgA==
X-Gm-Message-State: AGi0PuZFMQCNJozhbiwf1N2qvW7MI5dCPmtPmuSb9GS8athwBO85Ovkr
        69NbSgabj+3w8EaQl/pxdlM3eg==
X-Google-Smtp-Source: APiQypJN7/JRV7OJ8s/kqjkaowwIPEF6+tYYtQrtoPjYW1yZ84PCDiVZqt0gcfZGOSXWQap6ET6GdQ==
X-Received: by 2002:a37:bd47:: with SMTP id n68mr16454193qkf.379.1588883630463;
        Thu, 07 May 2020 13:33:50 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id a139sm5156158qkg.107.2020.05.07.13.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 13:33:49 -0700 (PDT)
Date:   Thu, 7 May 2020 16:33:34 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/19] mm: memcg: factor out memcg- and lruvec-level
 changes out of __mod_lruvec_state()
Message-ID: <20200507203334.GA161043@cmpxchg.org>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-2-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422204708.2176080-2-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 01:46:50PM -0700, Roman Gushchin wrote:
> To convert memcg and lruvec slab counters to bytes there must be
> a way to change these counters without touching node counters.
> Factor out __mod_memcg_lruvec_state() out of __mod_lruvec_state().
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Roman and I have talked a bunch about the function names here. They're
not optimal, with mod_lruvec_state() doing the entire intersection -
node, memcg, lruvec - and mod_memcg_lruvec_state() being a specific
version that does not update the node.

However, the usecases for mod_memcg_lruvec_state() are highly
specific, so the function won't be widely used. As such, it received
the longer name, and we get to keep the shorter mod_lruvec_state() for
the much more widely used function.

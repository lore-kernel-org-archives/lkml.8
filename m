Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7615C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5B4E206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 14:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594047590;
	bh=nUsKdrmERbBlUVv4xgPhOyFXG8kv6pOoEGbOeKVaov0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gzJaDtMKU/thEI/6nrudoiL/7bfXkfLj6vdd+FV7QipvltZ31e14GOYcY0soo2DlB
	 tsCpDevVrtrSUzLNuut/jYu5CGHBTTJUznBKxEBgZ03GNB5oDjpcS3xzjf8pwWBXWR
	 d98cLJpt+nT5hkWh4KgKVHricznz+Zo7sGKg0WSs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgGFO7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729222AbgGFO7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 10:59:48 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F8EC061755;
        Mon,  6 Jul 2020 07:59:47 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id w34so9099850qte.1;
        Mon, 06 Jul 2020 07:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nK1wmMEIPZO1f2TPN5DzGYQpTDL9yeZCQKQ73N2IcQk=;
        b=u6e2nawyU/HYu64cNJFTex/NLHWzPhdlvrLzQpljeBXC+aiOjgqgJjyHkd1t+4ZMg4
         DKElyyBqrjinAOR5Q0iJFR83H+Y+ZA7Mpz9oFKKHylZUsT5o36LTvLz97lBwGaKGoSC5
         ovBh8/Cr1M5iwC/uDMYcekxzb55yj1byOTDMv5s9ilToDvc+r0W/DbHdyJ72grClDl6y
         PDlyekop1twuwW0/YMiCb4zH3eW0G+WZg6XHvnJcdO2c7C9HMATe4SycCMnb6g/f6plV
         TI+WvxwwUZF0U1i66TWWjHLvyd7yKdV0p27A4FW68EfJkR0EtiN/2sozQjAU1bA0GcCt
         FFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=nK1wmMEIPZO1f2TPN5DzGYQpTDL9yeZCQKQ73N2IcQk=;
        b=FLA+X9tNHHXDIB/UT3Z3626SB4a0wxGS8PteYeeoGIyW4cL6H7nG7lqMZiayzfuzHY
         x1F6szdwgNOmnuZbMmd15U2VYKpe4tuBdSQZ84FwhfqcqhDvZFTM5ABjD/jREdLAS8wo
         ZoAwzKH42DU5VtdyE7mWYZS78ru2N4LS1HZSwXECsx7l5YNDjfm8NidNZXVdcWPGAQSl
         CcvB7l5fZK+al3QY28uSbXOCaZptcjY6auL3xhTPh1yKckZXc7gCK8YLl5c1xgLVO7m/
         AqVEORiUUmDFcXGDHobydaZfPB6BD5+acSB2MAF5yYzAT7P3vPOtbmzSXt7bbJUK0Ymz
         J5qg==
X-Gm-Message-State: AOAM530XzsbT/F0Je3gAMkzd2tCbuzBtZFY5aUSxuIXtUw6eDoIH2qb8
        M0qXowjKmrFk9qhQrLXOjU4=
X-Google-Smtp-Source: ABdhPJxYXE3K0zFNzCUuCQSxb3MU8xhWTweG4OyXmB8WDNRVJYAQgNhl5MQby3r3UHIbTNSfN5unEA==
X-Received: by 2002:aed:3621:: with SMTP id e30mr50240383qtb.190.1594047586955;
        Mon, 06 Jul 2020 07:59:46 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:74c4])
        by smtp.gmail.com with ESMTPSA id p7sm19566165qki.61.2020.07.06.07.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 07:59:46 -0700 (PDT)
Date:   Mon, 6 Jul 2020 10:59:45 -0400
From:   Tejun Heo <tj@kernel.org>
To:     qiang.zhang@windriver.com
Cc:     ben.dooks@codethink.co.uk, bfields@redhat.com, cl@rock-chips.com,
        peterz@infradead.org, pmladek@suse.com, akpm@linux-foundation.org,
        mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kthread: Work could not be queued when worker being
 destroyed
Message-ID: <20200706145945.GB5603@mtj.thefacebook.com>
References: <20200705013018.7375-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200705013018.7375-1-qiang.zhang@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 05, 2020 at 09:30:18AM +0800, qiang.zhang@windriver.com wrote:
> From: Zhang Qiang <qiang.zhang@windriver.com>
> 
> Before the work is put into the queue of the worker thread,
> the state of the worker thread needs to be detected,because
> the worker thread may be in the destruction state at this time.
> 
> Signed-off-by: Zhang Qiang <qiang.zhang@windriver.com>
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>

Andrew already brought this up but can you please provide some context on
why you're making this change?

Thanks.

-- 
tejun

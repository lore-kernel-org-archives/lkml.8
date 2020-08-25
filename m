Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D84C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91FD12072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 04:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SqHJZ4q6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgHYEZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 00:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgHYEZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:25:20 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7BAC061755
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 21:25:20 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d188so6318104pfd.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 21:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+YsbixkNJbHl3U/j4h1R2QFBhRmHgyNCld/y8hVT0zM=;
        b=SqHJZ4q68uvHJEj1tqtBAPUefNUjIw5M1sYWPucazBAvrgMHSzQCgFi2hVNEBLGF1B
         rhntEosFuLtf8eCkSZzKxzNVAsgpAMkwL1JUJJhUdpGufg1LkkcjjWeGyhS+3DJSsn7/
         vWmfC093A/lLXKu1pDHpU9Ez4WXoU3YoHk8RFEilg48Ed3AyiTNtbbjYYaEg25OrUaPB
         eoSqKC61b1e3jx4rY23vbx91PYuEyuIl7Yfm5wZ85X42KVXxCppeDg4VFToGnTMWD7Of
         rTCPLanfINM95d5c1kbLayG0NFf3Pt7u9YEzItir7CC3miWHu2tB/8wWdrrt34zbjn2p
         XyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+YsbixkNJbHl3U/j4h1R2QFBhRmHgyNCld/y8hVT0zM=;
        b=TzBxe50htscIryE3JLx+L7r6aF2X1Vkui8c1F0udjJEW6wNu0YPa9iz0Tsj+djlYgH
         ESki1MtR8hRpYPxtkj+g8OYb+4L4QHyUPhWDIDF/p+++15qBE0fbv3WHbA8uICEBslEL
         2gjZVu74ltZGYQwin5P3wUuoQ27pq1p+KfcjritQy0TsdxT/jGgRaSqpXzJg0WFeh0UN
         ZThWSvHJfczVX/4R3s/jzDEy3WsyQPf403PT6h2kBsiSkrB5tumWsMzBIvl9Ph1b0ata
         2gA5IfaUF+ZHdNQ6/zN+2LLxA9cHMsFBe5HZ9AdujTu8g/TYoPzIMPMFylgOS0A/ly6e
         mgxA==
X-Gm-Message-State: AOAM533sKFrf60jO113KqeoSIWbhoRbUbJNbZEbT0iEggiqnXIFz0onX
        JnpdCsrI+kMMSiR7IJ2V4F/xDg==
X-Google-Smtp-Source: ABdhPJxUihmxgAUmEVRqbbCBcdXaWxS2Z8oQCFSsEy4g0DkFtCAJSO6hXu7wEkWdKXJS3+vV31qosQ==
X-Received: by 2002:a63:413:: with SMTP id 19mr5627102pge.310.1598329519767;
        Mon, 24 Aug 2020 21:25:19 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id r14sm5581804pgn.83.2020.08.24.21.25.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 21:25:19 -0700 (PDT)
Date:   Tue, 25 Aug 2020 09:55:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg KH <greg@kroah.com>
Cc:     stable@vger.kernel.org, Viresh Kumar <vireshk@kernel.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sajida Bhanu <sbhanu@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH - stable v5.4 and v5.7] opp: Enable resources again if
 they were disabled earlier
Message-ID: <20200825042517.gui4kovio4xcu2w5@vireshk-i7>
References: <31f315cf2b0c4afd60b07b7121058dcaa6e4afa1.1598260882.git.viresh.kumar@linaro.org>
 <20200824161049.GE435319@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824161049.GE435319@kroah.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-08-20, 18:10, Greg KH wrote:
> On Mon, Aug 24, 2020 at 02:52:23PM +0530, Viresh Kumar wrote:
> > From: Rajendra Nayak <rnayak@codeaurora.org>
> > 
> > commit a4501bac0e553bed117b7e1b166d49731caf7260 upstream.
> > 
> > dev_pm_opp_set_rate() can now be called with freq = 0 in order
> > to either drop performance or bandwidth votes or to disable
> > regulators on platforms which support them.
> > 
> > In such cases, a subsequent call to dev_pm_opp_set_rate() with
> > the same frequency ends up returning early because 'old_freq == freq'
> > 
> > Instead make it fall through and put back the dropped performance
> > and bandwidth votes and/or enable back the regulators.
> > 
> > Cc: v5.3+ <stable@vger.kernel.org> # v5.3+
> > Fixes: cd7ea582866f ("opp: Make dev_pm_opp_set_rate() handle freq = 0 to drop performance votes")
> > Reported-by: Sajida Bhanu <sbhanu@codeaurora.org>
> > Reviewed-by: Sibi Sankar <sibis@codeaurora.org>
> > Reported-by: Matthias Kaehlcke <mka@chromium.org>
> > Tested-by: Matthias Kaehlcke <mka@chromium.org>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> > Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> > [ Viresh: Don't skip clk_set_rate() and massaged changelog ]
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > [ Viresh: Updated the patch to apply to v5.4 ]
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >  drivers/opp/core.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> This too is already in the 5.7 and 5.4 queues, why add it again?

Same here, your bot reported that patch failed to apply for 5.4 and 5.7, again
rightly so as I was required to modify the patch a little bit and so I have
added another signed-off and details.

-- 
viresh

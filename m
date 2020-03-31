Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E38C2D0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2D7208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="MX3Slhqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbgCaPZh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:25:37 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40196 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730528AbgCaPZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:25:37 -0400
Received: by mail-wr1-f66.google.com with SMTP id u10so26501751wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 08:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YTzVrLlnv/U861L9j2OH30y80LBa/uThEvzXvP/gh2c=;
        b=MX3SlhqtOgu7+xXPL0VtCywalercn8WvcRrstjEE7UrqsuB7MOfCn54non2gPg5X59
         uLet+fnVhtkcLmoWl91/g5RA8oxVdZsQT8JOjXegkF08l25QW2YHmBU2fGuolcm2oQCG
         THSGdBz4PAgk6GtfOmO2lXmtTDQFqofruA8cA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YTzVrLlnv/U861L9j2OH30y80LBa/uThEvzXvP/gh2c=;
        b=FVTuVoADoUrU90f60gQa7Rpi7dVkg8tckkirAomhTQadSa/ow7JeBlATrfvBNXkURk
         B6kFAhXuvNB0Wia7sFX90V7zkrU5lq2FSCGvXFA+i7gA8fCGJrktr/4djS5MlXQGHPDP
         MpqMTE5HjqOMu89Q1bs3lBPx3XWVvHnX6xWqOwS6L+64TfXqUcMezLaxNh1yNmj30B2c
         ZQ16gIHkfIZ2izQPxFqROu9o+bXGr6qRJH+YVCKfTgj/YmiPPLo3nmsUgG0Y+hz5vP15
         1KtDGWQLTQPz2oA67GP/1pR4RYzkN8CUxj74ogulaaRsyck/3bgK0bzy5pAHg1gfaqkN
         pnZw==
X-Gm-Message-State: ANhLgQ0zh2xM9rBRdqeHPveeMxVMCF88+7sI+sripUqayAQvM3UzpOZx
        kLIJ0GXiedv077QJtq7M6cdI3A==
X-Google-Smtp-Source: ADFU+vtwJF1/nQQsqo4I3dRj5KZv3ZcoTKSDqx3vwC8HQz+R1N9Nja42TBa60n4K9gVoKNdsr+oLCw==
X-Received: by 2002:adf:f68b:: with SMTP id v11mr20090187wrp.270.1585668335013;
        Tue, 31 Mar 2020 08:25:35 -0700 (PDT)
Received: from localhost ([2620:10d:c092:180::1:27bd])
        by smtp.gmail.com with ESMTPSA id u22sm4278976wmu.43.2020.03.31.08.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 08:25:34 -0700 (PDT)
Date:   Tue, 31 Mar 2020 16:25:34 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: Do not high throttle allocators based on
 wraparound
Message-ID: <20200331152534.GA972283@chrisdown.name>
References: <20200331152424.GA1019937@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200331152424.GA1019937@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, this is a pretty bad one that could definitely affect memory.high 
users. We should probably expedite it going in.

Sorry for the trouble, especially on a -stable patch...

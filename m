Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64115C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A7C620738
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591024085;
	bh=Al2iXHXAldMvsrt0nDkQonMhuDQkU7A0IZsGF0azAnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Q7z5zK1cqk+lJZLw3pFjs/7adDE9HmVwodAv0LvVAHwKTnS/U4ZnMDWvK+E9rNDiA
	 LIrP7Y77j65+dIEkW+18jFHqE3TSiRsb3S9sYI9RHbTQwMUWClzQGl2vxjvbTivpav
	 3yFGwDain9ZXxq0TnEs0iDv40qHwB88F7si2VDHo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbgFAPIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgFAPID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:08:03 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CECC05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 08:08:03 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id k22so7903917qtm.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 08:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xp/+EIHR4gv7K6J/jkyBD7gKeAeJLQfPdoh0qV8lWlA=;
        b=hofpJK6q2tBSOfFjgk5k4keab2U1QcvaIKPp8xL+A57n+FP/lP3gJHZzB4tP7ScdCf
         rzlXxjOab6ZS1e8sTVqtwDScShV/vCAW2RHlEURbVQItgkN0FCegVQsdUB6I07d0U8g8
         XNLkx6bB0rpBhKiIuw5LCAc0+AbT46SGyYd2N+RHlNKq/IRj7mfcVqWg3bdHEjteq/vU
         1qgv3NYmjrmnMJmHf/aiS6KHLQv+0Kftk395w+yokm/PUad+6Fgjz9dTCpwrfn04sOFi
         BwjP81AXGovY0zIKTT+HiCEY79QFFqAs/2haG1JPAZAMFKwuz/COC5d1XBJeJKX1Fam7
         te3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xp/+EIHR4gv7K6J/jkyBD7gKeAeJLQfPdoh0qV8lWlA=;
        b=uQMSTXEu45q7Un4VPZk+bVG126VswsBsqrWkoMpmPz4PQO7uaE6s9pk8VnJr+u8o80
         WT0Jek8hW0jfFtzaekvVvqojgUMG0KqR4V6kEVO7DBQZHG2M+yoWEepa5BLZbxCYHL+7
         fWqpb4rpdQn9nw12hnI5eOFsBBVDS78dBwHryG9oTZ8FzsDazhXo5129jduNRqoHIsXs
         7tOoneTomhPPhhT3rDrrLcA/UVUPg0I/hpsPoBg5DUPGT0OCaaXw7qNP8ho66yta/5H6
         LP0D5SJmB5y/ceenLbBN+EyIdFceztCxTtr66i6LoxRl1imuwjjTBCu3lNjI48FPEyLj
         u1iA==
X-Gm-Message-State: AOAM532MC+ESlsb0RGcjXGbz0Hz28aJujLIEvT451k35tviIN0CYtD9o
        cLt6AeyR9gvDBvjwCAkUcrzO1ttO
X-Google-Smtp-Source: ABdhPJx3t9LxXGs7r3qohISC+6j/O3CvqIlnFm6vWpNtF7wC9MTTr6mo1DmOCUKl1/rbE8w3Gfqrhg==
X-Received: by 2002:aed:24db:: with SMTP id u27mr21924736qtc.256.1591024082817;
        Mon, 01 Jun 2020 08:08:02 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:eb8b])
        by smtp.gmail.com with ESMTPSA id x205sm15482821qka.12.2020.06.01.08.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 08:08:02 -0700 (PDT)
Date:   Mon, 1 Jun 2020 11:08:00 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <laijs@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH 2/4] workqueue: use BUILD_BUG_ON() for compile time test
 instead of WARN_ON()
Message-ID: <20200601150800.GB31548@mtj.thefacebook.com>
References: <20200601084442.8284-1-laijs@linux.alibaba.com>
 <20200601084442.8284-3-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601084442.8284-3-laijs@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 08:44:40AM +0000, Lai Jiangshan wrote:
> Any runtime WARN_ON() has to be fixed, and BUILD_BUG_ON() can
> help you nitice it earlier.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>

Applied 1-2 to wq/for-5.8.

Thanks.

-- 
tejun

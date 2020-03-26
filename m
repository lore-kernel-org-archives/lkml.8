Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E20DC2D0E7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFBE620719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:13:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kTsk5R+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCZHNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:13:43 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:39340 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgCZHNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 03:13:43 -0400
Received: by mail-yb1-f194.google.com with SMTP id h205so2675041ybg.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 00:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/EfpWk2gjYks28Q9lQqlYhUWnyVRPjiMZTzILRdTCmI=;
        b=kTsk5R+3s2jjT/cNpqLndfsa53KK2VPznNXf4BUCijYKTZ+n6Bk71eU6wBM9AqNk+A
         p2Q2Y1zGG7DJvC+04ZpkmKgA4IykLIGtP+F/1CDyK18mZDwuGFoXwhdO5w0yhjNAQzFg
         IhNHRjQh4QSA4UezVik4l5zh2cObIapq16mftQiDUVlq7BFQh93OoW6I2wjJzDRTAo9s
         zjSWjFACYYlZKQ1u9P4qEJr5sUZ3WcHLnvSfIi2gRA/ieyURxE+7fZZKHbS0Y9u+eX96
         uD9aivwNqgfnQWerQjV+4J+LVh47jDdbuvHXhHQRaEO+UMkAiei4wKGY+nS4/TAikPxs
         kS+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/EfpWk2gjYks28Q9lQqlYhUWnyVRPjiMZTzILRdTCmI=;
        b=SYYkkhpXcn7LqI3zEwgWYG1abSI7TXBcyGxoBizHCeQG7qhWsmaypYiIQ7Ma72pK/U
         ekx2/NPkcnb7qzZIqzvuRFV84rGg+5BNF3uHNwpFPot6wMjnOecCakTj65iepKuf5O87
         EQTmF5RiJNhb4+i+4921JRymvQ1N/Bi9UoGyx4+7qXnMsLgr1NpD775ci3ucNo4EGDJR
         X8tFRalvSAcBV3iZMFa8YoDuLHxuv0LxL1wMOO6EmJAncOS2+lM2dtmD5q8cwqsNbZ2/
         t5UmYY3ZZZa7edlLb4Mi47sTkv8RYRG74ykeWxKPTKQF6CiysDkyG31xWZvah6UdiToc
         l5EQ==
X-Gm-Message-State: ANhLgQ1Ct9FMfhtN1NLr9u3MbiX75dW9Wb84FsMiwmPBBq2eWuTg85U8
        ZzjiWufvrR26N7ZYjlDlvb0W2jYGAIoKsa49K0XVdw==
X-Google-Smtp-Source: ADFU+vs4DO6gF5y/6tIg6PHfoLUqho+VIZuvoBei7dkaRV4YZD9MLunpKhDyaNzHOTOuX8kFDRVl4OWktr5fM9w78SI=
X-Received: by 2002:a25:4e02:: with SMTP id c2mr11654345ybb.504.1585206821977;
 Thu, 26 Mar 2020 00:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200326070236.235835-1-walken@google.com>
In-Reply-To: <20200326070236.235835-1-walken@google.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Thu, 26 Mar 2020 00:13:29 -0700
Message-ID: <CANN689HCH9xE3GfQ4qxVrFckJAoXPTwjWDHNanwrT3UR3Yi0Bw@mail.gmail.com>
Subject: Re: [PATCH 0/8] Add a new mmap locking API wrapping mmap_sem calls
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 12:02 AM Michel Lespinasse <walken@google.com> wrote:
> I think it would be feasible to apply them in the next merge cycle if
> given sufficient approval.

Reading this part back, maybe it sounds more pushy than I intended.
What I meant is that I think the code is ready to be submitted through
the normal channels, whatever release that lands it into.

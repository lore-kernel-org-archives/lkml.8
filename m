Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49A4C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973982076F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585068060;
	bh=J+sBi6OHsndQd9FEdmPuvq1csEI2nMeek82p0CfttsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vbsq9BoNjfiZthy9srPZdsZE8p1E3bQl507uaX9CASa4vINPT8g64SrOK6ecpeDPb
	 wx+kxlQw7jCSxuALIRZHl3UafTYLQV/s7aCZZAJVEIQmOoURSzDH748WHxeB3lT7sI
	 lAqIYfcO7MGRZ7TYxdEG5ZSSVq7jIsnNhLsmmYKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgCXQk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:40:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:34580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727161AbgCXQk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:40:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42A022076E;
        Tue, 24 Mar 2020 16:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585068058;
        bh=J+sBi6OHsndQd9FEdmPuvq1csEI2nMeek82p0CfttsE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JQVuRiwPCKjU04UpPRdYIydTIWN34Ckes2kwAEmqluB0EKanARLo3M1eOhvELfmKr
         GFiHWNcdlqcOPIN9axBc1chyGXlS1EC5VEpRpQHzGoKlR7l5Qyeme+J5qumqThb7UW
         eOdgdNj3L3ayY3B9dqHS4JxVHtn/rlcVfLxEum4w=
Date:   Tue, 24 Mar 2020 17:40:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Maddie Stone <maddiestone@google.com>,
        Marco Elver <elver@google.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, kernel-team@android.com,
        kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 20/21] list: Format CHECK_DATA_CORRUPTION error
 messages consistently
Message-ID: <20200324164056.GB2518746@kroah.com>
References: <20200324153643.15527-1-will@kernel.org>
 <20200324153643.15527-21-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324153643.15527-21-will@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 03:36:42PM +0000, Will Deacon wrote:
> The error strings printed when list data corruption is detected are
> formatted inconsistently.
> 
> Satisfy my inner-pedant by consistently using ':' to limit the message
> from its prefix and drop the terminating full stops where they exist.
> 
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

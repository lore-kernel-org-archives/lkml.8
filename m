Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91463C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E31B20936
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 16:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598632612;
	bh=S3K11L2Ws9RoFoiHF2dBKgkGk5nN5svUjIexK0Dyb/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yRX00BQeMtjH0kuwF4YnNmzfy+WrulKU5TtXHZ+KNluz2VVrpqMH1gMKsVjbU23W0
	 gaOLAFfd+WSqe2S1g//UL51E60NVxrnNiitgDveoLUjgcwtY6631EXpEWMSs74XGI2
	 7GdbCAcA3Uga9bUQic8lrl2dpzP1iC4LEn1Y+dpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgH1Qgv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 12:36:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:40298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726524AbgH1Qgv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:36:51 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7039320872;
        Fri, 28 Aug 2020 16:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598632610;
        bh=S3K11L2Ws9RoFoiHF2dBKgkGk5nN5svUjIexK0Dyb/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NfnNo6sj6MMVNZRgJ/BiW190PvetzDwBcw+02YugifzNxy+vfuSxKxHih7iPtvNBM
         B18v+mmC0zTzlM46vXttCFXexfGOB2KY2GPxlHNj/lvwBgddFcO3XzplJXiSgeL13B
         VSAcpfRA84OYwmbLZPAo1+fZiH5PM+I5itV11nYc=
Date:   Fri, 28 Aug 2020 12:36:49 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH 0/2] Backport uclamp static key to 5.4.y stable
Message-ID: <20200828163649.GT8670@sasha-vm>
References: <20200828125610.30943-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200828125610.30943-1-qais.yousef@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 01:56:08PM +0100, Qais Yousef wrote:
>Hi Greg/Sasha
>
>The following 2 patches are backports of
>
>	46609ce22703: ("sched/uclamp: Protect uclamp fast path code with static key")
>	e65855a52b47: ("sched/uclamp: Fix a deadlock when enabling uclamp static key")
>
>into 5.4.y stable tree. The conflict was trivial and due to:
>
>	1. uclamp_rq_util_with() was renamed from util_util_with()
>	2. 2 local variables were converted to unsigned long from unsigned int.
>
>I did do compile test on aarch64 and x86_64 and both looked fine. Beside I ran
>a quick and short mmtest to verify the functionality and got the following
>results which is inline with what's expected.

I've queued it up, thanks!

-- 
Thanks,
Sasha

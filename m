Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B24BC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 01:59:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0357F206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 01:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="VGtjo6KJ";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="HMxIXv5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbgIJB7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 21:59:01 -0400
Received: from a27-188.smtp-out.us-west-2.amazonses.com ([54.240.27.188]:57668
        "EHLO a27-188.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728363AbgIJBhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 21:37:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599695807;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To;
        bh=l4FYBGdELu+UT/43hvHKaWHmD+LJV7nzWAyhKyqC2ag=;
        b=VGtjo6KJhXt1Bh4flUMrEAQ5D0jIgKxycT/rcbbYDdW2tXxHZLXllrhSXvJTvwH0
        X/4ILow0foPIh/aBMoeZ+/5a+eyaMFhy0CBvZF/J3dETlVK8yBw+fdA1K9Rv5QarPNc
        dWAMQnNSHtQ2MDx4hnqDBLJ3qBwFZ3Vv0LCA/qRQ=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599695807;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Feedback-ID;
        bh=l4FYBGdELu+UT/43hvHKaWHmD+LJV7nzWAyhKyqC2ag=;
        b=HMxIXv5U/9CdNvVZL4oxoVcnniDEVlAJKAxIE5aTpViEu/29aJs5VWjwEGjW0Yvj
        TyiDtAg1Pn0+q2CBNKR9uz5kP6fr224OyvFvpQ2MPUzxBBTOC07hNWQJM6qVwrJY+j8
        6anfkaBd4Oxeuvq47JfoEPe5Wprp2IH8Tlnc1KrI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3D976C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tingweiz@codeaurora.org
Date:   Wed, 9 Sep 2020 23:56:47 +0000
From:   Tingwei Zhang <tingweiz@codeaurora.org>
To:     tsoni@codeaurora.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mian Yousaf Kaukab <ykaukab@suse.de>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v9 00/24] coresight: allow to build coresight as modules
Message-ID: <01010174754ce1c8-c53380ae-5d29-492f-a6c9-64bd0e16197d-000000@us-west-2.amazonses.com>
References: <20200820054718.20115-1-tingwei@codeaurora.org>
 <CANLsYkwhypfEkmhg=wK+_F6TxxGiuoSqpgGR0REqsOqC-X-3mg@mail.gmail.com>
 <0101017470c9475d-00e296fc-1173-4afa-95cb-22ac70d85d5b-000000@us-west-2.amazonses.com>
 <20200909161523.GA553266@xps15>
 <c8737d9935a1b7a7372c41492939648d@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8737d9935a1b7a7372c41492939648d@codeaurora.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SES-Outgoing: 2020.09.10-54.240.27.188
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 04:45:52AM +0800, tsoni@codeaurora.org wrote:
> On 2020-09-09 09:15, Mathieu Poirier wrote:
> >On Wed, Sep 09, 2020 at 02:54:33AM +0000, Tingwei Zhang wrote:
> >>On Wed, Sep 09, 2020 at 01:53:51AM +0800, Mathieu Poirier wrote:
> >>> Hi Tingwei,
> >>>
> >>> Apologies for the untimely response to this set, I am hoping to get
> to
> >>> it in the next two weeks.
> >>>
> >>
> >>It's fine, Mathieu. Please let me know your comments once you have time.
> >>I'm targeting to get these set merged in 5.10 Kernel.
> >
> >From the above it is not clear if you want this set to be _in_ the 5.10
> >cycle
> >or added to my list _during_ the 5.10 cycle, which would make it part of
> >the
> >5.11 cycle.  In any case the latter seems more realistic.
> 
> Tingwei can correct me here, but we prefer to have patches to be part of the
> 5.10 release. It means they should get merged in Linus's tree in the next
> merge window.

Yes.  The target is to merge this series into Linus's tree in 5.10 Kernel.

Thanks,
Tingwei

> 
> ---Trilok Soni

Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF9FC2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 11:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EEE420772
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 11:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="N/GLW1oF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730483AbgCaLZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 07:25:56 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41427 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730180AbgCaLZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 07:25:56 -0400
Received: by mail-lj1-f193.google.com with SMTP id n17so21578214lji.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 04:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jgIzEqM2LnXzzHvamHw2Hc0doSxZZqIged014OPYZ0c=;
        b=N/GLW1oFEDCQ7URS2WLGzLmJwWLDAHhMdnP/DjtzUiv/pmSayZhM604q+eXRSuKSox
         fVIur3LF2iFCCwdN9TPJmP2ZJBMiRnUUon4gjk8p4INkbpG3/wbZ4d8HaR8WjOgaR0XP
         VX7ae0ZYBui7NTCWEUNvg9Cm4feg1FDJi+4pmphpaOBMZlVjACtYYkAdS5kPPiWJU9sa
         vTFCuVaPHaKBshlk3/mEPamPWmBOjLqK2DzRJyP33+cHCTCBjwayCZu7YvmGkKGyVI3C
         cdNLr7VZu3I3e1CkVMYuWphdHkkNUsRc4GvY07AMDIjH7fmxKEAQX59A7pEMYxl6Osit
         Jkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jgIzEqM2LnXzzHvamHw2Hc0doSxZZqIged014OPYZ0c=;
        b=GEZkStC+oYPH6rok30+n+62S3j27bSkc19uv77SDmZbpGX+NCIeFQez78klSybyZu3
         5wGzM7nVRY3AYkuZ9pUPncPkiVMolGNUM/hdGYHWc5AVo9xygGY7q9sZNZdDQxpxPQLc
         eK4QoFcEgyqv0MmlfvmJYXCmvZZJXTFYlFXJrV7ZzoZVhj7F/EZ0plgCE7LN99ABgjpW
         D+mE9PthjmtSSMFilO6UdqJoALtQ3wraWSh19mT9tHxSfaTKasQHnExtB+T6GWzOdHMQ
         lcdo8ZfyFLXLabzHoOCZRw59qTEmnQwJD1uXDt45qEjcwJTSbRIAf9jGaz63HfG576tP
         WS7g==
X-Gm-Message-State: AGi0PuYExaYyByqT4sOsqsT/xdJmaXUGdK0VaDchR923U6xFdWkxJo7C
        JVPFv6Y/7GKu7J9aSR9Tee3MQ/9bhMrKUTKScnWY2g==
X-Google-Smtp-Source: APiQypJTsUNMZl+N2BPqArgyZP2C2flmTEyblIXo71oiZxzoozA+8v6tymPhb52VSmB4cJtT70qkRRWfTUvd6eB5w4U=
X-Received: by 2002:a2e:9681:: with SMTP id q1mr10418971lji.179.1585653953043;
 Tue, 31 Mar 2020 04:25:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200329140459.18155-1-maco@android.com> <20200330010024.GA23640@ming.t460p>
 <CAB0TPYG4N-2Gg95VwQuQBQ8rvjC=4NQJP4syJWS3Q6CO28HzTQ@mail.gmail.com> <20200331074828.GA24372@lst.de>
In-Reply-To: <20200331074828.GA24372@lst.de>
From:   Martijn Coenen <maco@android.com>
Date:   Tue, 31 Mar 2020 13:25:41 +0200
Message-ID: <CAB0TPYEwOd-jYJTkq1DYp=c7uXMKvpSpgpcpZGMwW2QsYkOtSw@mail.gmail.com>
Subject: Re: [PATCH] loop: Add LOOP_SET_FD_WITH_OFFSET ioctl.
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 9:48 AM Christoph Hellwig <hch@lst.de> wrote:
> I think the full blown set fd an status would seem a lot more useful,
> or even better a LOOP_CTL_ADD variant that sets up everything important
> on the character device so that we avoid the half set up block devices
> entirely.

Thanks for the feedback, I will work on that then. I think I could do
both - LOOP_SET_FD_AND_STATUS and a new variant of LOOP_CTL_ADD that
calls it - the former could still be useful if the kernel pre-created
a large amount of loop devices.

Martijn

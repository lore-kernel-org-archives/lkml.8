Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BEAC0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A4D920637
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:41:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="E/h3JWyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgCOBlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:41:22 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35551 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgCOBlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:41:21 -0400
Received: by mail-io1-f65.google.com with SMTP id h8so13635511iob.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 18:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=+/247cTfFPmb6HzvLpP0YBhAOHansbCR7qRIbohrXkI=;
        b=E/h3JWySV60dxpGI2gxROTmY2mZeLVVOoioeXtEAq5DSRgyFBnAaTzBmVeIOUJNDYl
         pUNhavjej7XYrSfD7CWWOuCQN17b3T9dPhuBnfOH76BnRFd+wRSYWOVsmliAt0etk6gg
         DYJ9Nv8nF8GNuZpxgUZhrLeusJaLQzZk3lUmayLRYGH1E/E/grkRjfJTS3je8tzmbuNT
         Ys2H/0GpAbMCnru4/QcjKJ9ceya9viY3VelMvPMhmkU80VYVbvQPyyt1+sCejng8cLnA
         uCL0+aT+3hLuQZPQ2jhC27DjOTakBFMCjqAPDGe7DidgAz3Dl9rvTVjknDflOsLeEvbr
         IbhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+/247cTfFPmb6HzvLpP0YBhAOHansbCR7qRIbohrXkI=;
        b=dPJO5Hq3FLcKnaVVluSZYcJh2jDlnFNPDNQeLxrLY6OHHYgov5r8iKNlQ2AueMvEpp
         w7U144MaxYdcmT1Cc1qkBgRpcqAnyG9rQATcIK8PEw5it4MJzVbemJhi4rj91CBUlduv
         Gr6y8eL6GKq211ShAR/UVmjro2CivfPQe9Y+eWVEE68e2TNcMqSVfeba3i68QQLGoWpk
         QSL3BLGebjF7BPua3Ny8MX/ZsonXtKJF/l5p1UIDICycaJS4degXicbOsTAsZ7sjxcMy
         hJWSlu5QK8gfyRn9te/z6pG1EFb/7D7OfY5CAuLAMnj6fvOcHZWhPLCpGF6j2oiuZpIa
         H71w==
X-Gm-Message-State: ANhLgQ0F5MHmrMu2W2KAwFfps01xJuCyQrvW8H9dFZWah6jTV8Ry82fL
        EtC5o9j0QVzH/xkZfIyNMZ+a9RHoNnr9uA==
X-Google-Smtp-Source: ADFU+vs4bDd5BE7tlACCr4VBGaQq1i1YtcLAWyKDg8BNV4CX7P6+yrkgL79vVx2ZqcEl5BQ5gzfj3w==
X-Received: by 2002:a63:8b42:: with SMTP id j63mr19006128pge.27.1584226866175;
        Sat, 14 Mar 2020 16:01:06 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id g6sm12179905pjv.13.2020.03.14.16.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Mar 2020 16:01:05 -0700 (PDT)
Subject: Re: [PATCH 5.6] io_uring: NULL-deref for IOSQE_{ASYNC,DRAIN}
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <3fff749b19ae1c3c2d59e88462a8a5bfc9e6689f.1584127615.git.asml.silence@gmail.com>
 <bc3baf1c-0629-3989-c7c1-bc7c84ac8ae5@gmail.com>
 <6ebc5e8a-7a6c-2537-9050-fe4e5c4f014d@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ade19964-58fa-93fd-312f-cd12b69e3a8b@kernel.dk>
Date:   Sat, 14 Mar 2020 17:01:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6ebc5e8a-7a6c-2537-9050-fe4e5c4f014d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/20 3:29 PM, Pavel Begunkov wrote:
> On 13/03/2020 23:28, Pavel Begunkov wrote:
>> Hmm, found unreliably failing the across-fork test. I don't know whether it's
>> this patch specific, but need to take a look there first.
> 
> It's good to go, just used outdated tests.
> The reproducer is attached.

I integrated this into the existing read-write in liburing, thanks.

-- 
Jens Axboe


Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C2FDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 19:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7F82207ED
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 19:52:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Z/TKEiLx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgFDTwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 15:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbgFDTwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 15:52:13 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BD98C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 12:52:13 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id d66so3756576pfd.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 12:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=cD/9UyjX+yvIa+os6YZ+RyY2wWeU9kD6nVvkY0IT+ho=;
        b=Z/TKEiLxb0rZSqERy/jtpvWjeGMuJZGyVf0p71w/9BX8G71tGSkgs/ppD44UJGiL1o
         47KgB9juZjQT4ocJyt6BuoRkHdsk3tByWCBNQhV5+Ka2TLMGlljxVrhrzVYFHnEM0sZz
         Hu5lHMYi4yVDdxcvFusivhsBaPNxILGYm0u9+br4nagi49CfRQea9D/Nvo4jP1CgLm7X
         5X6PWRzH6rekKc//7uXv7xoS7zEft5/SUl7YiduHuavU4l3LWmHwHgBgh6rOw9fKGXYn
         TcfBV61UTUkmRPg2ct1F9bbgWUpsjvAbH1IDyF2M3T7TrxaGNd47BnD388aIIpnhVzJG
         +9Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cD/9UyjX+yvIa+os6YZ+RyY2wWeU9kD6nVvkY0IT+ho=;
        b=f5kqTDvmuEDDFj1/UdkN3NoGEqNmyqjxYyC329G5AqKm+1ALrPaHME46pFtiX62N8Y
         1Aq6fjXt6soh+5QMjchf8hBOSVwl3jbFjhubEjRDwhWd+WUchOL37jkr0Lu3PXJclEvX
         P/ZJi92NaBlgYY5Hpuk/dFVyJEZhZ/RX7PlNRmdWt2wHv+x78Kbi1GoH4mE+4MJoPOKW
         B/RhX5QAR8sjy1Lk3uSYBX9tD+5BaZqMpoevPVXKeXo6FXAb3YzqJuIbBvbJiVgCXK6+
         KDOQf6hVZlKwQZMqyviCIWoUdoALFls8KBa2JqxqNdJRwF2SK6q+EVPZkw08P+RvpC3G
         Blnw==
X-Gm-Message-State: AOAM530zJ6iRm4YH2X00zTis3ceMCLflP6kpy1IahuK/1mpdZBBemzcE
        kP0ei8f/0YhA5aVoQOX5IhsmrDI39N3ipQ==
X-Google-Smtp-Source: ABdhPJwt4mb+Mqsjl089Zu3RO3ZQ3BtMjv/cnBMi6+AzhxmOwZT4urNEfERWgVO44nZz1CvK/wx4vw==
X-Received: by 2002:a63:6c8:: with SMTP id 191mr5865638pgg.22.1591300332353;
        Thu, 04 Jun 2020 12:52:12 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id nl8sm7267577pjb.13.2020.06.04.12.52.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 12:52:11 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] forbid fix {SQ,IO}POLL
To:     Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1591196426.git.asml.silence@gmail.com>
 <414b9a24-2e70-3637-0b98-10adf3636c37@kernel.dk>
 <f5370eb3-af80-5481-3589-675befa41009@kernel.dk>
 <d1d92d99-c6b1-fc6e-ea1d-6c2e5097d83f@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cc3197f9-e8b1-ac13-c121-291bb32646e3@kernel.dk>
Date:   Thu, 4 Jun 2020 13:52:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <d1d92d99-c6b1-fc6e-ea1d-6c2e5097d83f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/20 1:22 PM, Pavel Begunkov wrote:
> On 04/06/2020 20:06, Jens Axboe wrote:
>> On 6/3/20 12:51 PM, Jens Axboe wrote:
>>> On 6/3/20 9:03 AM, Pavel Begunkov wrote:
>>>> The first one adds checks {SQPOLL,IOPOLL}. IOPOLL check can be
>>>> moved in the common path later, or rethinked entirely, e.g.
>>>> not io_iopoll_req_issued()'ed for unsupported opcodes.
>>>>
>>>> 3 others are just cleanups on top.
>>>>
>>>>
>>>> v2: add IOPOLL to the whole bunch of opcodes in [1/4].
>>>>     dirty and effective.
>>>> v3: sent wrong set in v2, re-sending right one 
>>>>
>>>> Pavel Begunkov (4):
>>>>   io_uring: fix {SQ,IO}POLL with unsupported opcodes
>>>>   io_uring: do build_open_how() only once
>>>>   io_uring: deduplicate io_openat{,2}_prep()
>>>>   io_uring: move send/recv IOPOLL check into prep
>>>>
>>>>  fs/io_uring.c | 94 ++++++++++++++++++++++++++-------------------------
>>>>  1 file changed, 48 insertions(+), 46 deletions(-)
>>>
>>> Thanks, applied.
>>
>> #1 goes too far, provide/remove buffers is fine with iopoll. I'll
>> going to edit the patch.
> 
> Conceptually it should work, but from a quick look:
> 
> - io_provide_buffers() drops a ref from req->refs, which should've
> been used by iopoll*. E.g. io_complete_rw_iopoll() doesn't do that.
> 
> - it doesn't set REQ_F_IOPOLL_COMPLETED, thus iopoll* side will
> call req->file->iopoll().

We don't poll for provide/remove buffers, or file update. The
completion is done inline. The REQ_F_IOPOLL_COMPLETED and friends
is only applicable on read/writes.

-- 
Jens Axboe

